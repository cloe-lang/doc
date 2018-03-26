const glob = require('glob');
const path = require('path');

const indexFile = 'index.html';

module.exports = {
	templatedUrls: Object.assign(...glob.sync('_site/**/*.html').map((filename) => {
		const dirname = path.dirname(filename).slice(6);
		const basename = path.basename(filename);

		if (basename === indexFile && dirname !== '') {
			return {
				[dirname]: filename
			};
		} else if (path.extname(filename) === '.html' && basename !== indexFile) {
			return {
				[filename.slice(6, -5)]: filename
			};
		}

		return {};
	})),
	globDirectory: '_site',
	globPatterns: [
		'**/*'
	],
	globIgnores: [
		'register-service-worker.js',
		'*.map'
	],
	swDest: '_site/service-worker.js'
};
