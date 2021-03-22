const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
	purge    : [
		'./app/**/*.html.erb',
		'./app/helpers/**/*.rb',
		'./app/javascript/**/*.js',
		'./app/javascript/**/*.vue'
	],
	darkMode : false, // or 'media' or 'class'
	theme    : {
		extend : {
			fontFamily      : {
				sans : [ 'Inter var', ...defaultTheme.fontFamily.sans ]
			},
			colors          : {
				pale_yellow : '#FBE8A6',
				orange      : '#F27D42',
				navy        : '#182a44',
				light_navy  : '#f0f7ff',
				turqoise    : '#55BDCA',
				light_blue  : '#96FFFF',
				powder_blue : '#C8EFF9',
				white       : '#ffffff'
			},
			backgroundImage : (theme) => ({
				'cloud-gen' : "url('./../../assets/images/cloud-background.jpg')",
				waves     : "url('./../../assets/images/waves.jpg')"
			})
		}
	},
	variants : {
		extend : {
			backgroundColor : [ 'odd', 'even', 'first' ],
			textColor       : [ 'odd', 'even' ]
		}
	},
	plugins  : [ require('@tailwindcss/forms'), require('@tailwindcss/typography'), require('@tailwindcss/aspect-ratio') ]
};
