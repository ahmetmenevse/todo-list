import { Application } from "@hotwired/stimulus"
import  tooltip  from "./tooltip_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

Stimulus.register("tooltip", tooltip)
export { application }
