const decreaseButton = document.getElementById('decrease');
const increaseButton = document.getElementById('increase');
const input = document.querySelector('.stepper-input');

let currentValue = parseInt(input.value);

decreaseButton.addEventListener('click', () => {
    if (currentValue > 1) {
        currentValue--;
        input.value = currentValue;
        increaseButton.disabled = false;
    }
    if (currentValue === 1) {
        decreaseButton.disabled = true;
    }
});

increaseButton.addEventListener('click', () => {
    currentValue++;
    input.value = currentValue;
    decreaseButton.disabled = false;
});