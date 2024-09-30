document.addEventListener('DOMContentLoaded', function() {
    let currentIndex = 0;
    const slides = document.querySelector('.slides');
    const slideElements = document.querySelectorAll('.slide');
    const totalSlides = slideElements.length;

    // Log total number of slides
    console.log(`Total Slides: `+ totalSlides); // 총 슬라이드 수
	console.log(`Current Index: ` + currentIndex); // 현재 슬라이드 인덱스

    function showSlide(index) {
        currentIndex = index;
        if (currentIndex >= totalSlides) {
            currentIndex = 0;
        } else if (currentIndex < 0) {
            currentIndex = totalSlides - 1;
        }

        // Log current index
        console.log(`Current Index: ` + currentIndex);

        // 슬라이드를 이동시킴
        slides.style.transform = "translateX(" + (-currentIndex * 933) + "px)";
        updateDots();
    }

    window.moveSlide = function(step) {
        showSlide(currentIndex + step);
    };

    window.currentSlide = function(n) {
        showSlide(n - 1); // n은 1부터 시작하므로 1을 빼줍니다.
    };

    function updateDots() {
        const dots = document.querySelectorAll('.dot');
        dots.forEach((dot, index) => {
            dot.classList.remove('active');
            if (index === currentIndex) {
                dot.classList.add('active');
            }
        });
    }

    let autoSlide = setInterval(() => {
        moveSlide(1);
    }, 3000);

    const sliderContainer = document.querySelector('.slider-container');
    sliderContainer.addEventListener('mouseenter', () => {
        clearInterval(autoSlide);
    });

    sliderContainer.addEventListener('mouseleave', () => {
        autoSlide = setInterval(() => {
            moveSlide(1);
        }, 3000);
    });

    showSlide(currentIndex);
});