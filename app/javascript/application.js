// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
import "controllers"

Turbo.session.drive = false

import jquery from "jquery";
window.jQuery = jquery;
window.$ = jquery;
import Rails from "@rails/ujs"
Rails.start();


// Gallery Carousel
document.addEventListener('turbo:load', () => {
  const modal = document.getElementById('galleryModal');
  const carouselEl = document.getElementById('carouselHikingGallery');

  if (!modal || !carouselEl) return;

  modal.addEventListener('show.bs.modal', (event) => {
    const trigger = event.relatedTarget;
    if (!trigger) return;

    const targetIndex = parseInt(trigger.getAttribute('data-bs-slide-to'), 10);
    
    if (isNaN(targetIndex)) return;

    // Get or create carousel instance
    let carousel = bootstrap.Carousel.getInstance(carouselEl);
    if (!carousel) {
      carousel = new bootstrap.Carousel(carouselEl, {
        interval: false,
        ride: false
      });
    }
    
    // Jump to the target slide
    carousel.to(targetIndex);
  });
});
