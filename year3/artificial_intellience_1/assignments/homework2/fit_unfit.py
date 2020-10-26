ProbRewardMatrices = {
	'exercise': {
		'fit': {
			'fit': [0.9*0.99, 8],
			'unfit': [0.9*0.01, 8],
			'dead': [0.1, 0]
		},
		'unfit': {
			'fit': [0.9*0.2, 0],
			'unfit': [0.9*0.8, 0],
			'dead': [0.1, 0]
		},
		'dead': {
			'fit': [0, 0],
			'unfit': [0, 0],
			'dead': [1, 0]
		}
	},
	'relax': {
		'fit': {
			'fit': [0.99*0.7, 10],
			'unfit': [0.99*0.3, 10],
			'dead': [0.01, 0],
		},
		'unfit': {
			'fit': [0.99*0, 5],
			'unfit': [0.99*1, 5],
			'dead': [0.01, 0]
		},
		'dead': {
			'fit': [0, 0],
			'unfit': [0, 0],
			'dead': [1, 0]
		}
	}
}

n =  5		#This must be a positive integer
if not(isinstance(n,int)) or n < 0:
	print("n must be a positive integer!")
	exit(3)

G = 0.5		#This is the lambda setting where	0 <= G <= 1
if G > 1 or G < 0:
	print("G must be between 0 and 1!")
	exit(3)


S = ['fit', 'unfit', 'dead']	# states
s = 'fit'	#This is the state and must be either 'fit', 'unfit' or 'dead'
if s not in S:
	print("s must be either fit, unfit, or dead!")
	exit(3)

print("")
print("n = ", n)
print("G = ", G)
print("s = ", s)

def p(s, a, sprime):
	return ProbRewardMatrices[a][s][sprime][0]

def r(s, a, sprime):
	return ProbRewardMatrices[a][s][sprime][1]

def V(n, s):
	return max(q(n, s, 'exercise'), q(n, s, 'relax'))

def q(n, s, a):
	if n == 0:
		return (
			p(s, a, 'fit')*r(s, a, 'fit') +
			p(s, a, 'unfit')*r(s, a, 'unfit') +
			p(s, a, 'dead')*r(s, a, 'dead')
		)

	return (
		q(0, s, a) +
		(G*(p(s, a, 'fit')*V(n-1, 'fit') +
		p(s, a, 'unfit')*V(n-1, 'unfit') +
		p(s, a, 'dead')*V(n-1, 'dead')))
	)

print("")
print("qn(s, exercise):", q(n, s, 'exercise'))
print("qn(s, relax):", q(n, s, 'relax'))
exit(0)