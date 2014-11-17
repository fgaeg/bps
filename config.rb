require "builder"

###
# Time zone for blog posts
###

Time.zone = 'Jakarta'

###
# Site Settings
###

set :site_title, 'Model Social Network'
set :site_author, 'humans.txt'
set :site_language, 'en-us'
set :site_url, 'http://domain.com'
set :site_description, 'Discover your interesting gals'
set :site_keywords, 'Discovery, Models'


###
# Blog settings
###

# Time.zone = "UTC"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "blog"

  # Matcher for blog source files
  blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.permalink = "{title}.html"
  blog.taglink = "tags/{tag}.html"
  blog.layout = "blog"

  # Matcher for blog links
  blog.year_link = "{year}.html"
  blog.month_link = "{year}/{month}.html"
  blog.day_link = "{year}/{month}/{day}.html"

  # Matcher for blog template
  blog.tag_template = "blog/tag.html"
  blog.calendar_template = "blog/calendar.html"

  # Matcher summary for blog posts
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250

  # Matcher extension used for blog posts
  blog.default_extension = ".markdown"

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end


# Enable pretty URLs
activate :directory_indexes

# You can set it manually from link helper
set :relative_links, true

# Set index to "index.html"
set :index_file, 'index.html'

# Generate feeds and sitemap for search engine
page "/feed.xml", :layout => false
page "/sitemap.xml", :layout => false

###
# Haml
###

set :haml, {
  :ugly => true,
  :attr_wrapper => "\"",
  :format => :html5
}

###
# Use RedCarpet as markdown engine
###

# Our version of Markdown resembles GitHub's
set :markdown_engine, :redcarpet
set :markdown, {
  :tables => true,
  :autolink => true,
  :gh_blockcode => true,
  :fenced_code_blocks => true,
  :smartypants => true
}


###
# Compass
###

# Change Compass configuration
compass_config do |config|
  config.output_style     = :expanded
  config.line_comments    = true
  config.relative_assets  = true
end

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

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
proxy "/blog.html", "/blog/index.html", locals: {
 which_fake_page: "Rendering a fake page with a local variable"
}

# Enable blog layout for all blog pages
with_layout :blog do # refer to blog.layout above
  page "/blog.html"
  page "/blog/*"
end


###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload, :host => '127.0.0.1'

# Methods defined in the helpers block are available in templates
helpers do
  # sample helper
  # def some_helper
  #   "Helping"
  # end


  # Helpers for easily add widgets partial into template
  def get_partial(name)
    partial "layouts/partials/#{name}"
  end

  # Simulating flickholdr image
  def flickholdr(size, options={})
    options[:domain] = "http://flickholdr.com"
    size = "#{size}/#{rand(1..10)}"
    lorem.image(size, options)
  end
end

# # define custom page class for body document
# def page_classes
#   path = request.path_info.dup
#   path << settings.index_file if path.match(%r{/$})
#   path = path.gsub(%r{^/}, '')

#   classes = []
#   parts = path.split('.')[0].split('/')
#   parts.each_with_index { |path, i| classes << parts.first(i+1).join('-') }

#   classes.join(' ')
# end


set :css_dir, 'css' # Location of stylesheet
set :js_dir, 'js' # Location of javascripts asset
set :images_dir, 'images' # Location of images asset
set :partials_dir, 'layouts/partials' # Location of partials to render
set :fonts_dir, 'fonts' # Location of fonts within source

# Build-specific configuration
configure :build do
  puts "Building website"

  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Enable gzip compression
  # activate :gzip

  # Compress PNGs after build
  # First: gem install middleman-smusher
  require "middleman-smusher"
  activate :smusher

  # Use relative URLs
  activate :relative_assets

  # Haml Config
  set :haml, {
    :ugly => true,
    :attr_wrapper => "\""
  }

  #Compass config
  compass_config do |config|
    config.line_comments    = false
    config.sass_options     = {:debug_info => false}
  end

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end