const startingMinutes = 0.5;
let time = 0;
const countdownElement = document.getElementById('countdown');
startClock(); 

function startClock(){
    time = startingMinutes * 60;

    //updateCountdown();
    setInterval(updateCountdown, 5000); //calls function every second
}
function updateCountdown() {
    const minutes = Math.floor(time / 60);
    let seconds = time % 60;

    seconds = seconds < 10 ? '0' +  seconds : seconds;

    //console.log(minutes + ":" + seconds);
    countdownElement.innerHTML = `${minutes}:${seconds}`
    
    if(time == 0){
        
        if(confirm("Do you want to go again?"))
            startClock();
        else
            console.log("Clock finished.")

    }
    time = time - 5;
    time = time < 0 ? 0 : time;
}