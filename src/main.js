import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import jQueryPlugin from "./assets/js/jquery-plugin";

import "./assets/js/main";
import "./assets/js/slick.min";

const app = createApp(App);

app.use(router);
app.use(jQueryPlugin);

app.mount("#app");

// // Hot Module Replacement (HMR) - Ensure scripts are re-initialized
// if (module.hot) {
//   module.hot.accept(['./App.vue', './assets/js/jquery-plugin'], () => {
//     const newApp = require('./App.vue').default;
//     app.unmount();
//     app.mount(newApp);
//   });
// }