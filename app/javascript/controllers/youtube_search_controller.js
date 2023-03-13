
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "query", "results" ];
  static values = { trail: Number}

  connect() {
    if (!this.element.classList.contains("my-search-form")) {
      console.error("Incorrect element for search controller");
      return;
    }


  }

  search(event) {
    event.preventDefault();

    if (this.hasQueryTarget && this.hasResultsTarget) {
      const query = this.queryTarget.value;
      fetch("/search", {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({query: query})
      })
      .then(response => response.json())
      .then(data => {
        console.log(data)
        if (data && data.items && data.items.length > 0) {
          const videos = data.items;
          let html = "";
          videos.forEach(video => {
            html += `
              <div class="video" data-controller="video-content"
              data-video-content-trail-value="${this.trailValue}"
             data-video-content-title-value="${video.snippet.title}"
             data-video-content-description-value="${video.snippet.description}"
             data-video-content-thumbnail-value="${video.snippet.thumbnails.medium.url}"
              data-video-content-id-value="${video.id.videoId}">
                <div class="thumbnail">
                  <img src="${video.snippet.thumbnails.medium.url}">
                </div>
                <div class="info">
                  <h2>${video.snippet.title}</h2>
                  <p>${video.snippet.description}</p>
                </div>
                <button class="btn btn-sm btn-secondary" data-action="click->video-content#create">Add video</button>
              </div>
            `;
          });


          if (this.hasResultsTarget) {
            this.resultsTarget.insertAdjacentHTML('beforeend', html);
          }
          else {
            console.error("No results target found");
          }
        }
        else {
          console.error("No videos found");
        }
      })
      .catch(error => {
        console.error("fetch error:", error);

        if (this.hasResultsTarget) {
          this.resultsTarget.innerHTML = '<p class="error">Oops, something went wrong. Please try again later.</p>';
        }
        else {
          console.error("No results target found");
        }
      });
    }
    else {
      console.error("Missing query or results target");
    }
  }
}
