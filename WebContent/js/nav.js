const navSlide = () => {
    const menu = document.querySelector('.menu');
    const nav = document.querySelector('.nav-links');
    const navLinks = document.querySelectorAll('.nav-links li');

    menu.addEventListener('click', ()=> {
        nav.classList.toggle('nav-active');

        


        menu.classList.toggle('toggle');
    });

}

navSlide();