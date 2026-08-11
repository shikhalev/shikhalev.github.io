
require 'time'
require 'date'

class Jekyll::LastModifiedCats < Jekyll::Generator

  safe false
  priority :high

  def generate site
    @cats = {}
    site.posts.docs.each do |doc|
      date = doc.data['last_modified_at'] || doc.date
      case date
      when nil
        # do nothing
      when String
        apply_date doc, Time::parse(date)
      else
        apply_date doc, date.to_time
      end
    end
    @cats.each do |cat, date|
      stream = site.collections['streams'].docs.select { it.data['category_id'] == cat }.first
      stream.data['last_modified_at'] = date.xmlschema if stream
      stream.data['date'] = date.xmlschema if stream
      calendar = site.collections['calendars'].docs.select { it.data['category_id'] == cat }.first
      calendar.data['last_modified_at'] = date.xmlschema if calendar
      calendar.data['date'] = date.xmlschema if calendar
    end
  end

  private

  def apply_date doc, date
    doc.data['categories'].each do |cat|
      apply_cat_date cat, date
    end
  end

  def apply_cat_date cat, date
    if @cats.has_key?(cat)
      @cats[cat] = [ @cats[cat], date ].max
    else
      @cats[cat] = date
    end
  end

end
