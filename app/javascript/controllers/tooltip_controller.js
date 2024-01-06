import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tooltip"
export default class extends Controller {
  connect() {
    console.log("connected tooltip controller");
  }

  static targets = ["source"]

  mouseover() {
    this.sourceTarget.setAttribute("title", "Due date has passed")
  }

  mouseout() {
    this.sourceTarget.removeAttribute("title")
  }
}
