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

// Photo Gallery - Load More functionality
document.addEventListener('turbo:load', () => {
  const photoGrid = document.querySelector('.photo-grid');
  if (!photoGrid) return;
  
  const photoCards = photoGrid.querySelectorAll('.photo-card');
  const loadMoreBtn = photoGrid.parentElement.querySelector('.load-more-btn');
  
  if (!photoCards.length || !loadMoreBtn) return;
  
  const itemsPerLoad = 8;
  let currentlyShown = 0;
  
  function showMorePhotos() {
    const toShow = currentlyShown + itemsPerLoad;
    
    for (let i = currentlyShown; i < toShow && i < photoCards.length; i++) {
      photoCards[i].classList.add('visible');
    }
    
    currentlyShown = toShow;
    
    // Hide button if all photos are shown
    if (currentlyShown >= photoCards.length) {
      loadMoreBtn.classList.remove('show');
    }
  }
  
  // Initial load
  showMorePhotos();
  
  // Show button if there are more photos to load
  if (currentlyShown < photoCards.length) {
    loadMoreBtn.classList.add('show');
  }
  
  // Load more on button click
  loadMoreBtn.addEventListener('click', showMorePhotos);
});
