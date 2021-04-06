
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
				'body' : [ '"Open Sans Light"', ...defaultTheme.fontFamily.sans ]
			},
			colors          : {
				pale_yellow : '#FFC544',
				orange      : '#F27D42',
				navy        : '#182a44',
				light_navy  : '#f0f7ff',
				turqoise    : '#0094FE',
				light_blue  : '#96FFFF',
				powder_blue : '#C8EFF9',
				white       : '#FFFFFF'
			},
			// backgroundImage : (theme) => ({
			// 	'cloud-gen' : "url('./../../assets/images/cloud-background.jpg')"
			// })
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
