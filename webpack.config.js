const ExtractTextPlugin = require('extract-text-webpack-plugin');
const webpack = require('webpack');

const cssLoader = {
	loader: 'css-loader',
	options: {
		minimize: true
	}
};

module.exports = {
	entry: './index.ts',
	output: {
		filename: 'tmp/index.js'
	},
	resolve: {
		extensions: ['.ts', '.js']
	},
	module: {
		rules: [{
				test: /\.ts$/,
				loader: 'ts-loader'
			},
			{
				test: /\.css$/,
				use: ExtractTextPlugin.extract({
					fallback: 'style-loader',
					use: cssLoader
				})
			},
			{
				test: /\.scss$/,
				use: ExtractTextPlugin.extract({
					fallback: 'style-loader',
					use: [cssLoader, {
						loader: 'sass-loader'
					}]
				})
			}
		]
	},
	plugins: [
		new webpack.optimize.UglifyJsPlugin(),
		new ExtractTextPlugin('_includes/index.css')
	]
};
