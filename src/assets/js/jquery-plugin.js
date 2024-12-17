// src/assets/js/jquery-plugin.js
import jQuery from "jquery";

export default {
  install: (app) => {
    // Ensure jQuery is available globally
    window.$ = window.jQuery = jQuery;

    // Dynamically load other scripts after jQuery is available
    require("./slick.min.js");
    require("./jquery.min.js");
    require("./bootstrap.min.js");
    require("./nouislider.min.js");
    require("./jquery.zoom.min.js");
    require("./main.js");

    // Add jQuery to the global properties of the Vue app
    app.config.globalProperties.$jQuery = jQuery;
  },
};