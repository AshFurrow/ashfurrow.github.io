require "lib/custom_helpers"
require "lib/add_links_to_navigation.rb"

helpers CustomHelpers

activate :add_links_to_navigation

###
# Blog settings
###

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true, :with_toc_data => true

activate :syntax

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "blog"
  blog.permalink = "{title}.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page/{num}"
  blog.summary_separator = "<!-- more -->"
  blog.new_article_template = "new_article.html.markdown.erb"
  blog.layout = "blog_post"
end

activate :directory_indexes

page "/feed.xml", layout: false
page "/feed.rss.xml", layout: false

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'css'

set :js_dir, 'javascripts'

set :images_dir, 'img'

set :partials_dir, 'layouts'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
  
  activate :minify_css
  activate :minify_javascript
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'staging.ashfurrow.com'
  s3_sync.aws_access_key_id          = ENV['SITE_AWS_KEY']
  s3_sync.aws_secret_access_key      = ENV['SITE_AWS_SECRET']
end
