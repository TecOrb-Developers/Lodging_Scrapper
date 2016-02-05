# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160205115109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "amenities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "amenities_event_rooms", id: false, force: :cascade do |t|
    t.integer "amenity_id"
    t.integer "event_room_id"
  end

  create_table "amenities_lodgings", id: false, force: :cascade do |t|
    t.integer "amenity_id"
    t.integer "lodging_id"
  end

  create_table "arrangement_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "arrangements", force: :cascade do |t|
    t.integer  "catering_id"
    t.integer  "arrangement_type_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "description"
    t.integer  "quantity"
  end

  add_index "arrangements", ["arrangement_type_id"], name: "index_arrangements_on_arrangement_type_id", using: :btree
  add_index "arrangements", ["catering_id"], name: "index_arrangements_on_catering_id", using: :btree

  create_table "audio_equipement_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audio_equipements", force: :cascade do |t|
    t.string   "how_many"
    t.integer  "audio_equipement_type_id"
    t.integer  "av_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "audio_equipements", ["audio_equipement_type_id"], name: "index_audio_equipements_on_audio_equipement_type_id", using: :btree
  add_index "audio_equipements", ["av_id"], name: "index_audio_equipements_on_av_id", using: :btree

  create_table "av_rooms", force: :cascade do |t|
    t.string   "capacity"
    t.string   "style"
    t.integer  "av_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "from"
    t.string   "to"
  end

  add_index "av_rooms", ["av_id"], name: "index_av_rooms_on_av_id", using: :btree

  create_table "avs", force: :cascade do |t|
    t.integer  "event_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "event_service_id"
  end

  add_index "avs", ["event_id"], name: "index_avs_on_event_id", using: :btree
  add_index "avs", ["event_service_id"], name: "index_avs_on_event_service_id", using: :btree

  create_table "braintree_details", force: :cascade do |t|
    t.text     "braintree_id"
    t.text     "nonce"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "braintree_details", ["user_id"], name: "index_braintree_details_on_user_id", using: :btree

  create_table "breakout_rooms", force: :cascade do |t|
    t.string   "capacity"
    t.string   "time_in"
    t.string   "time_out"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "breakout_rooms", ["event_id"], name: "index_breakout_rooms_on_event_id", using: :btree

  create_table "catered_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catereds", force: :cascade do |t|
    t.string   "served_as"
    t.string   "where"
    t.string   "time"
    t.string   "quantity"
    t.integer  "catering_id"
    t.integer  "catered_type_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "catereds", ["catered_type_id"], name: "index_catereds_on_catered_type_id", using: :btree
  add_index "catereds", ["catering_id"], name: "index_catereds_on_catering_id", using: :btree

  create_table "caterings", force: :cascade do |t|
    t.string   "guest_quantity"
    t.string   "min_budget"
    t.string   "max_budget"
    t.string   "gsa_rate"
    t.integer  "event_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "event_service_id"
  end

  add_index "caterings", ["event_id"], name: "index_caterings_on_event_id", using: :btree
  add_index "caterings", ["event_service_id"], name: "index_caterings_on_event_service_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "document"
  end

  add_index "comments", ["ticket_id"], name: "index_comments_on_ticket_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "cuisine_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cuisines", force: :cascade do |t|
    t.integer  "catering_id"
    t.integer  "cuisine_type_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "description"
    t.integer  "quantity"
  end

  add_index "cuisines", ["catering_id"], name: "index_cuisines_on_catering_id", using: :btree
  add_index "cuisines", ["cuisine_type_id"], name: "index_cuisines_on_cuisine_type_id", using: :btree

  create_table "deals", force: :cascade do |t|
    t.string   "deal_price"
    t.integer  "price_id"
    t.integer  "vendor_id"
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "quantity"
    t.integer  "deal_on"
    t.string   "serviciable_type"
    t.integer  "serviciable_id"
    t.boolean  "status"
    t.string   "deal_on_name"
  end

  add_index "deals", ["event_id"], name: "index_deals_on_event_id", using: :btree
  add_index "deals", ["price_id"], name: "index_deals_on_price_id", using: :btree
  add_index "deals", ["user_id"], name: "index_deals_on_user_id", using: :btree

  create_table "event_rooms", force: :cascade do |t|
    t.string   "room_type"
    t.float    "height"
    t.string   "size"
    t.string   "capacity"
    t.string   "best_for"
    t.integer  "lodging_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "avaibility"
  end

  add_index "event_rooms", ["lodging_id"], name: "index_event_rooms_on_lodging_id", using: :btree

  create_table "event_services", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "event_services", ["event_id"], name: "index_event_services_on_event_id", using: :btree
  add_index "event_services", ["service_id"], name: "index_event_services_on_service_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "title"
    t.date     "from"
    t.date     "to"
    t.string   "street_add"
    t.string   "no"
    t.string   "state"
    t.string   "city"
    t.string   "zip"
    t.text     "description"
    t.boolean  "need_planner"
    t.text     "planner_description"
    t.string   "terms_accept"
    t.string   "logistics",           default: [],              array: true
    t.string   "guests"
    t.string   "required_rooms"
    t.integer  "user_id"
    t.string   "search_location"
    t.string   "time"
    t.string   "time_from"
    t.string   "time_to"
    t.boolean  "need_venue"
    t.string   "event_type"
    t.string   "venue_category"
    t.string   "venue_location"
    t.string   "venue_address"
    t.string   "venue_city"
    t.string   "venue_pin"
    t.string   "seating_style"
    t.boolean  "need_breakout_rooms"
    t.integer  "property_type_id"
    t.boolean  "need_lodging"
    t.string   "price_range"
    t.boolean  "status"
    t.string   "near_by"
    t.string   "category"
    t.string   "mile_radius"
    t.date     "checkin_date"
    t.date     "checkout_date"
  end

  add_index "events", ["property_type_id"], name: "index_events_on_property_type_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "events_users", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
  end

  create_table "feature_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", force: :cascade do |t|
    t.integer  "feature_type_id"
    t.integer  "transportation_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "description"
  end

  add_index "features", ["feature_type_id"], name: "index_features_on_feature_type_id", using: :btree
  add_index "features", ["transportation_id"], name: "index_features_on_transportation_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "admin"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  create_table "idea_statuses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "idea_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "idea_statuses", ["idea_id"], name: "index_idea_statuses_on_idea_id", using: :btree
  add_index "idea_statuses", ["user_id"], name: "index_idea_statuses_on_user_id", using: :btree

  create_table "ideas", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "remark"
  end

  add_index "ideas", ["event_id"], name: "index_ideas_on_event_id", using: :btree
  add_index "ideas", ["user_id"], name: "index_ideas_on_user_id", using: :btree

  create_table "invalid_urls", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.string   "grand_total"
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "deal_id"
    t.boolean  "paid"
    t.string   "invoice_no"
  end

  add_index "invoices", ["deal_id"], name: "index_invoices_on_deal_id", using: :btree
  add_index "invoices", ["event_id"], name: "index_invoices_on_event_id", using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "labor_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "labors", force: :cascade do |t|
    t.integer  "catering_id"
    t.integer  "labor_type_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "description"
    t.integer  "quantity"
  end

  add_index "labors", ["catering_id"], name: "index_labors_on_catering_id", using: :btree
  add_index "labors", ["labor_type_id"], name: "index_labors_on_labor_type_id", using: :btree

  create_table "laundaries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "laundary_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "laundary_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "laundary_categories", ["laundary_id"], name: "index_laundary_categories_on_laundary_id", using: :btree

  create_table "laundary_details", force: :cascade do |t|
    t.date     "pickup_date"
    t.string   "pickup_time"
    t.string   "destination"
    t.string   "quantity"
    t.string   "unit"
    t.string   "description"
    t.integer  "laundary_id"
    t.integer  "laundary_category_id"
    t.integer  "event_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "event_service_id"
  end

  add_index "laundary_details", ["event_id"], name: "index_laundary_details_on_event_id", using: :btree
  add_index "laundary_details", ["event_service_id"], name: "index_laundary_details_on_event_service_id", using: :btree
  add_index "laundary_details", ["laundary_category_id"], name: "index_laundary_details_on_laundary_category_id", using: :btree
  add_index "laundary_details", ["laundary_id"], name: "index_laundary_details_on_laundary_id", using: :btree

  create_table "light_equipement_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "light_equipements", force: :cascade do |t|
    t.string   "how_many"
    t.integer  "light_equipement_type_id"
    t.integer  "av_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "light_equipements", ["av_id"], name: "index_light_equipements_on_av_id", using: :btree
  add_index "light_equipements", ["light_equipement_type_id"], name: "index_light_equipements_on_light_equipement_type_id", using: :btree

  create_table "location_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "location_type_id"
    t.integer  "transportation_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "description"
  end

  add_index "locations", ["location_type_id"], name: "index_locations_on_location_type_id", using: :btree
  add_index "locations", ["transportation_id"], name: "index_locations_on_transportation_id", using: :btree

  create_table "lodging_images", force: :cascade do |t|
    t.string   "image"
    t.integer  "lodging_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lodging_images", ["lodging_id"], name: "index_lodging_images_on_lodging_id", using: :btree

  create_table "lodging_users", force: :cascade do |t|
    t.integer  "lodging_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lodging_users", ["lodging_id"], name: "index_lodging_users_on_lodging_id", using: :btree
  add_index "lodging_users", ["user_id"], name: "index_lodging_users_on_user_id", using: :btree

  create_table "lodgings", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "lodging_type"
    t.string   "star_class"
    t.string   "class_by"
    t.string   "image"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "pin"
    t.string   "country"
    t.string   "fax"
    t.string   "avaibilaty",          default: [],              array: true
    t.string   "min_price_per_night"
    t.string   "min_price_per_week"
    t.string   "check_in"
    t.string   "check_out"
    t.string   "web"
    t.string   "contact1"
    t.string   "contact2"
    t.integer  "rooms"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "status"
    t.integer  "user_id"
    t.string   "email"
    t.string   "link"
    t.integer  "near_by_id"
    t.integer  "property_type_id"
  end

  add_index "lodgings", ["near_by_id"], name: "index_lodgings_on_near_by_id", using: :btree
  add_index "lodgings", ["property_type_id"], name: "index_lodgings_on_property_type_id", using: :btree
  add_index "lodgings", ["user_id"], name: "index_lodgings_on_user_id", using: :btree

  create_table "lodgistic_details", force: :cascade do |t|
    t.string   "plcs"
    t.string   "sulte"
    t.string   "check_in"
    t.string   "check_out"
    t.string   "days"
    t.string   "rate"
    t.string   "total_amount"
    t.integer  "lodgistic_id"
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "fname"
    t.string   "lname"
  end

  add_index "lodgistic_details", ["event_id"], name: "index_lodgistic_details_on_event_id", using: :btree
  add_index "lodgistic_details", ["lodgistic_id"], name: "index_lodgistic_details_on_lodgistic_id", using: :btree
  add_index "lodgistic_details", ["user_id"], name: "index_lodgistic_details_on_user_id", using: :btree

  create_table "lodgistics", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "lodging_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lodgistics", ["event_id"], name: "index_lodgistics_on_event_id", using: :btree
  add_index "lodgistics", ["lodging_id"], name: "index_lodgistics_on_lodging_id", using: :btree

  create_table "manpower_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manpowers", force: :cascade do |t|
    t.string   "quantity"
    t.string   "from"
    t.string   "to"
    t.integer  "manpower_type_id"
    t.integer  "event_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "manpowers", ["event_id"], name: "index_manpowers_on_event_id", using: :btree
  add_index "manpowers", ["manpower_type_id"], name: "index_manpowers_on_manpower_type_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.string   "job_title"
    t.string   "email"
    t.string   "contact"
    t.string   "address"
    t.string   "fax"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "gender"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
  end

  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "message_statuses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "message_statuses", ["message_id"], name: "index_message_statuses_on_message_id", using: :btree
  add_index "message_statuses", ["user_id"], name: "index_message_statuses_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "sender"
    t.string   "content"
    t.integer  "messageable_id"
    t.string   "messageable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "messages", ["messageable_type", "messageable_id"], name: "index_messages_on_messageable_type_and_messageable_id", using: :btree

  create_table "near_bies", force: :cascade do |t|
    t.string   "place"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "noti_type"
    t.integer  "from"
    t.integer  "to"
    t.boolean  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "content"
  end

  create_table "payments", force: :cascade do |t|
    t.string   "payment_for"
    t.string   "payment_option"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "zip"
    t.string   "country"
    t.string   "division"
    t.string   "officer_fname"
    t.string   "officer_lname"
    t.string   "officer_email"
    t.string   "officer_title"
    t.string   "officer_phone"
    t.string   "officer_fax"
    t.string   "individual"
    t.string   "attachment"
    t.integer  "event_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.string   "exemption_code"
  end

  add_index "payments", ["event_id"], name: "index_payments_on_event_id", using: :btree
  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "prices", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "priciable_id"
    t.string   "priciable_type"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "description"
    t.integer  "service_detail_id"
  end

  add_index "prices", ["priciable_type", "priciable_id"], name: "index_prices_on_priciable_type_and_priciable_id", using: :btree
  add_index "prices", ["service_detail_id"], name: "index_prices_on_service_detail_id", using: :btree
  add_index "prices", ["user_id"], name: "index_prices_on_user_id", using: :btree

  create_table "property_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "default"
  end

  add_index "roles", ["user_id"], name: "index_roles_on_user_id", using: :btree

  create_table "scrapes", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.string   "rating"
    t.string   "s_address"
    t.string   "e_address"
    t.string   "city"
    t.string   "state"
    t.string   "pin"
    t.string   "star"
    t.string   "price"
    t.string   "total_reviews"
    t.string   "traveller_rating"
    t.text     "description"
    t.text     "amenities"
    t.text     "photos"
    t.text     "reviews"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "service_details", force: :cascade do |t|
    t.string   "description"
    t.string   "price"
    t.string   "unit"
    t.string   "location"
    t.boolean  "in_house"
    t.string   "email"
    t.string   "phone"
    t.string   "contact"
    t.string   "fax"
    t.string   "web"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.integer  "service_type"
  end

  add_index "service_details", ["user_id"], name: "index_service_details_on_user_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplies", force: :cascade do |t|
    t.string   "quantity"
    t.string   "description"
    t.string   "from"
    t.string   "to"
    t.integer  "supply_type_id"
    t.integer  "event_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "supplies", ["event_id"], name: "index_supplies_on_event_id", using: :btree
  add_index "supplies", ["supply_type_id"], name: "index_supplies_on_supply_type_id", using: :btree

  create_table "supply_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tech_support_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tech_supports", force: :cascade do |t|
    t.integer  "tech_support_type_id"
    t.integer  "av_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "quantity"
  end

  add_index "tech_supports", ["av_id"], name: "index_tech_supports_on_av_id", using: :btree
  add_index "tech_supports", ["tech_support_type_id"], name: "index_tech_supports_on_tech_support_type_id", using: :btree

  create_table "tests", force: :cascade do |t|
    t.string   "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.text     "subject"
    t.text     "content"
    t.string   "document"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "status"
  end

  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id", using: :btree

  create_table "transportations", force: :cascade do |t|
    t.date     "t_date"
    t.string   "t_time"
    t.string   "passengers"
    t.integer  "event_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "event_service_id"
  end

  add_index "transportations", ["event_id"], name: "index_transportations_on_event_id", using: :btree
  add_index "transportations", ["event_service_id"], name: "index_transportations_on_event_service_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email",                  default: "", null: false
    t.string   "password_digest"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token"
    t.string   "address"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.string   "country"
    t.string   "gender"
    t.string   "image"
    t.string   "contact"
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string   "how_many"
    t.string   "hours"
    t.integer  "vehicle_type_id"
    t.integer  "transportation_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "vehicles", ["transportation_id"], name: "index_vehicles_on_transportation_id", using: :btree
  add_index "vehicles", ["vehicle_type_id"], name: "index_vehicles_on_vehicle_type_id", using: :btree

  create_table "video_equipement_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "video_equipements", force: :cascade do |t|
    t.string   "describe"
    t.string   "how_many"
    t.integer  "video_equipement_type_id"
    t.integer  "av_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "from"
    t.string   "to"
  end

  add_index "video_equipements", ["av_id"], name: "index_video_equipements_on_av_id", using: :btree
  add_index "video_equipements", ["video_equipement_type_id"], name: "index_video_equipements_on_video_equipement_type_id", using: :btree

  add_foreign_key "arrangements", "arrangement_types"
  add_foreign_key "arrangements", "caterings"
  add_foreign_key "audio_equipements", "audio_equipement_types"
  add_foreign_key "audio_equipements", "avs"
  add_foreign_key "av_rooms", "avs"
  add_foreign_key "avs", "event_services"
  add_foreign_key "avs", "events"
  add_foreign_key "braintree_details", "users"
  add_foreign_key "breakout_rooms", "events"
  add_foreign_key "catereds", "catered_types"
  add_foreign_key "catereds", "caterings"
  add_foreign_key "caterings", "event_services"
  add_foreign_key "caterings", "events"
  add_foreign_key "comments", "tickets"
  add_foreign_key "comments", "users"
  add_foreign_key "cuisines", "caterings"
  add_foreign_key "cuisines", "cuisine_types"
  add_foreign_key "deals", "events"
  add_foreign_key "deals", "prices"
  add_foreign_key "deals", "users"
  add_foreign_key "event_rooms", "lodgings"
  add_foreign_key "event_services", "events"
  add_foreign_key "event_services", "services"
  add_foreign_key "events", "property_types"
  add_foreign_key "events", "users"
  add_foreign_key "features", "feature_types"
  add_foreign_key "features", "transportations"
  add_foreign_key "idea_statuses", "ideas"
  add_foreign_key "idea_statuses", "users"
  add_foreign_key "ideas", "events"
  add_foreign_key "ideas", "users"
  add_foreign_key "invoices", "deals"
  add_foreign_key "invoices", "events"
  add_foreign_key "invoices", "users"
  add_foreign_key "labors", "caterings"
  add_foreign_key "labors", "labor_types"
  add_foreign_key "laundary_categories", "laundaries"
  add_foreign_key "laundary_details", "event_services"
  add_foreign_key "laundary_details", "events"
  add_foreign_key "laundary_details", "laundaries"
  add_foreign_key "laundary_details", "laundary_categories"
  add_foreign_key "light_equipements", "avs"
  add_foreign_key "light_equipements", "light_equipement_types"
  add_foreign_key "locations", "location_types"
  add_foreign_key "locations", "transportations"
  add_foreign_key "lodging_images", "lodgings"
  add_foreign_key "lodging_users", "lodgings"
  add_foreign_key "lodging_users", "users"
  add_foreign_key "lodgings", "near_bies"
  add_foreign_key "lodgings", "property_types"
  add_foreign_key "lodgings", "users"
  add_foreign_key "lodgistic_details", "events"
  add_foreign_key "lodgistic_details", "lodgistics"
  add_foreign_key "lodgistic_details", "users"
  add_foreign_key "lodgistics", "events"
  add_foreign_key "lodgistics", "lodgings"
  add_foreign_key "manpowers", "events"
  add_foreign_key "manpowers", "manpower_types"
  add_foreign_key "members", "users"
  add_foreign_key "message_statuses", "messages"
  add_foreign_key "message_statuses", "users"
  add_foreign_key "payments", "events"
  add_foreign_key "payments", "users"
  add_foreign_key "prices", "service_details"
  add_foreign_key "prices", "users"
  add_foreign_key "roles", "users"
  add_foreign_key "service_details", "users"
  add_foreign_key "supplies", "events"
  add_foreign_key "supplies", "supply_types"
  add_foreign_key "tech_supports", "avs"
  add_foreign_key "tech_supports", "tech_support_types"
  add_foreign_key "tickets", "users"
  add_foreign_key "transportations", "event_services"
  add_foreign_key "transportations", "events"
  add_foreign_key "vehicles", "transportations"
  add_foreign_key "vehicles", "vehicle_types"
  add_foreign_key "video_equipements", "avs"
  add_foreign_key "video_equipements", "video_equipement_types"
end
