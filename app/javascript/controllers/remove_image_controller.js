import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  remove(event) {
    event.preventDefault();
    const imageContainer = event.target.closest('.group');
    if (imageContainer) {
      imageContainer.remove();
    }
  }
}