//
// CSU33014 Summer 2020 Additional Assignment
// Part B of a two-part assignment
//
// Please write your solution in this file

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include "omp.h"
#include "csu33014-annual-partB-person.h"

// Time complexity: O(n)
void find_reachable_recursive(struct person *current, int steps_remaining,
                              bool *reachable)
{
  // mark current root person as reachable
  reachable[person_get_index(current)] = true;
  // now deal with this person's acquaintances
  if (steps_remaining > 0)
  {
    int num_known = person_get_num_known(current);
    for (int i = 0; i < num_known; i++)
    {
      struct person *acquaintance = person_get_acquaintance(current, i);
      find_reachable_recursive(acquaintance, steps_remaining - 1, reachable);
    }
  }
}

// Time complexity: O(2n)
// computes the number of people within k degrees of the start person
int number_within_k_degrees(struct person *start, int total_people, int k)
{
  bool *reachable;
  int count;

  // maintain a boolean flag for each person indicating if they are visited
  reachable = malloc(sizeof(bool) * total_people);
  for (int i = 0; i < total_people; i++)
  {
    reachable[i] = false;
  }

  // now search for all people who are reachable with k steps
  find_reachable_recursive(start, k, reachable);

  // all visited people are marked reachable, so count them
  count = 0;
  for (int i = 0; i < total_people; i++)
  {
    if (reachable[i] == true)
    {
      count++;
    }
  }
  printf("\n count=%d", count);
  return count;
}

// Time complexity: O(n)
void less_redundant_find_reachable_recursive(struct person *current, int steps_remaining,
                                             int *steps_away, int steps)
{
  steps_away[person_get_index(current)] = steps - steps_remaining;
  if (steps_remaining > 0)
  {
    int num_known = person_get_num_known(current);
    for (int i = 0; i < num_known; i++)
    {
      struct person *temp = person_get_acquaintance(current, i);
      int steps_away_temp = steps_away[person_get_index(temp)];
      if (steps_away_temp == 0 || steps_away_temp > steps - steps_remaining)
      {
        less_redundant_find_reachable_recursive(temp, steps_remaining - 1, steps_away, steps);
      }
    }
  }
}

// Time complexity: O(2n)
// computes the number of people within k degrees of the start person;
// less repeated computation than the simple original version
int less_redundant_number_within_k_degrees(struct person *start,
                                           int total_people, int k)
{
  int *steps_away;

  // maintain a int for each person indicating how many steps away from the start person they are
  steps_away = malloc(sizeof(int) * total_people);
  for (int i = 0; i < total_people; i++)
  {
    steps_away[i] = 0;
  }

  // now search for all people who are reachable with k steps
  less_redundant_find_reachable_recursive(start, k, steps_away, k);
  // all visited people are marked reachable, so count them
  int count = 0;
  for (int i = 0; i < total_people; i++)
  {
    if (steps_away[i] != 0)
    {
      count++;
    }
  }
  return count;
}

//Time complexity: O(n)
void parallel_find_reachable_recursive(struct person *current, int steps_remaining,
                                       int *steps_away, int steps)
{
  steps_away[person_get_index(current)] = steps - steps_remaining;

  if (steps_remaining > 0)
  {
    int num_known = person_get_num_known(current);
    omp_set_num_threads(num_known);
#pragma omp parallel for
    for (int i = 0; i < num_known; i++)
    {

      struct person *temp = person_get_acquaintance(current, i);
      int steps_away_temp = steps_away[person_get_index(temp)];
      if (steps_away_temp == 0 || steps_away_temp > steps - steps_remaining)
      {
        
        parallel_find_reachable_recursive(temp, steps_remaining - 1, steps_away, steps);
      }
    }
  }
}

//Time complexity: O(2n)
// computes the number of people within k degrees of the start person;
// parallel version of the code
int parallel_number_within_k_degrees(struct person *start,
                                     int total_people, int k)
{
  int *steps_away;

  // maintain a int for each person indicating how many steps away from the start person they are
  steps_away = malloc(sizeof(int) * total_people);
  for (int i = 0; i < total_people; i++)
  {
    steps_away[i] = 0;
  }

// now search for all people who are reachable with k steps
  parallel_find_reachable_recursive(start, k, steps_away, k);
  // all visited people are marked reachable, so count them
  int count = 0;
  for (int i = 0; i < total_people; i++)
  {
    if (steps_away[i] != 0)
    {
      count++;
    }
  }
  return count;
}
