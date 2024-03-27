// Entry point for the build script in your package.json
import 'bulma/css/bulma.css';
import { createApp } from "vue";
import index from "./pages/index.vue";
console.log("mount index");
createApp(index).mount("#app");
