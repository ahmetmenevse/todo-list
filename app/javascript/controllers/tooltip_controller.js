import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tooltip"
export default class extends Controller {
  static targets = ["source"]

  mouseover() {
    this.sourceTarget.setAttribute("title", "Due date has passed")
  }

  mouseout() {
    this.sourceTarget.removeAttribute("title")
  }
}
