// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');
// require.context('../../assets/images', true);
// require("jquery");

// require vendor file

// require("packs/vendor/jquery/jquery.min");
// require("packs/vendor/bootstrap/js/bootstrap.bundle.min");
// require("packs/vendor/jquery.easing/jquery.easing.min");
// require("packs/vendor/php-email-form/validate");
// require("packs/vendor/aos/aos");
// require("packs/vendor/isotope-layout/isotope.pkgd.min");
// require("packs/vendor/owl.carousel/owl.carousel.min");
// require("packs/custom");
// require("packs/main");

// require("jquery")
// import "bootstrap";

// import $ from "jquery";
import 'bootstrap';
import '@fortawesome/fontawesome-free/js/all';
import '../stylesheets/application';
import './custom';

// Contact form JavaScript
import './js/jqBootstrapValidation.js';
import './js/contact_me.js';

// Custom scripts for this template
// import "./js/agency.min.js";
import './js/agency.js';

// window.jQuery = $;
// window.$ = $;

// import "./vendor/jquery/jquery.min";
// import "./vendor/bootstrap/js/bootstrap.bundle.min";
// import "./vendor/jquery.easing/jquery.easing.min";
// import "./vendor/php-email-form/validate";
// import "./vendor/aos/aos";
// import "./vendor/isotope-layout/isotope.pkgd.min";
// import "./vendor/owl.carousel/owl.carousel.min";

// import "./main";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require('trix');
require('@rails/actiontext');
