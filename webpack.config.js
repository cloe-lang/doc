const ExtractTextPlugin = require('extract-text-webpack-plugin');
const path = require('path');
const webpack = require('webpack');

const cssLoader = {
	loader: 'css-loader',
	options: {
		minimize: true
	}
};

module.exports = {
	mode: 'production',
	entry: './index.ts',
	output: {
		filename: 'index.js',
		path: path.resolve(__dirname, 'tmp')
	},
	resolve: {
		extensions: ['.ts', '.js']
	},
	module: {
		rules: [{
				test: /\.ts$/,
				loader: 'ts-loader',
				options: {
					configFile: require.resolve('./tsconfig.webpack.json')
				}
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
	optimization: {
		minimize: true
	},
	plugins: [
		new ExtractTextPlugin('index.css')
	]
};
