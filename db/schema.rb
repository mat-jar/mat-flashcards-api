# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_22_142115) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answer_times", force: :cascade do |t|
    t.bigint "learning_session_id", null: false
    t.bigint "flashcard_id", null: false
    t.integer "round"
    t.integer "time_millisecond"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flashcard_id", "round", "learning_session_id"], name: "answer_times_unique_index", unique: true
    t.index ["flashcard_id"], name: "index_answer_times_on_flashcard_id"
    t.index ["learning_session_id"], name: "index_answer_times_on_learning_session_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read"
  end

  create_table "english_sentences", force: :cascade do |t|
    t.string "sentence"
    t.string "key_word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flashcard_set_settings_panels", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "flashcard_set_id", null: false
    t.bigint "resume_flashcard_id"
    t.boolean "front_first"
    t.boolean "audio"
    t.boolean "answer_ignore_case"
    t.boolean "answer_ignore_punctuation"
    t.boolean "answer_ignore_spaces"
    t.boolean "answer_ignore_parentheses"
    t.integer "order"
    t.integer "mode"
    t.integer "answer_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flashcard_set_id"], name: "index_flashcard_set_settings_panels_on_flashcard_set_id"
    t.index ["resume_flashcard_id"], name: "index_flashcard_set_settings_panels_on_resume_flashcard_id"
    t.index ["user_id"], name: "index_flashcard_set_settings_panels_on_user_id"
  end

  create_table "flashcard_sets", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "category"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "access", default: 1
    t.index ["user_id"], name: "index_flashcard_sets_on_user_id"
  end

  create_table "flashcards", force: :cascade do |t|
    t.text "front_text"
    t.text "back_text"
    t.string "front_photo"
    t.string "back_photo"
    t.string "front_audio"
    t.string "back_audio"
    t.text "hint"
    t.bigint "flashcard_set_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flashcard_set_id"], name: "index_flashcards_on_flashcard_set_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "learning_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "learnable_type"
    t.bigint "learnable_id"
    t.index ["learnable_type", "learnable_id"], name: "index_learning_sessions_on_learnable"
    t.index ["user_id"], name: "index_learning_sessions_on_user_id"
  end

  create_table "stats_panels", force: :cascade do |t|
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacher_tokens", force: :cascade do |t|
    t.string "token"
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_teacher_tokens_on_teacher_id"
    t.index ["token"], name: "index_teacher_tokens_on_token", unique: true
  end

  create_table "user_sentence_sets", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "category"
    t.integer "access", default: 1
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_sentence_sets_on_user_id"
  end

  create_table "user_sentences", force: :cascade do |t|
    t.string "sentence"
    t.string "key_word"
    t.string "hint"
    t.string "comment"
    t.bigint "user_sentence_set_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_sentence_set_id"], name: "index_user_sentences_on_user_sentence_set_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 1
    t.string "name"
    t.bigint "teacher_id"
    t.datetime "last_request_at"
    t.boolean "logged_in", default: false
    t.integer "last_login_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["teacher_id"], name: "index_users_on_teacher_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answer_times", "flashcards"
  add_foreign_key "answer_times", "learning_sessions"
  add_foreign_key "flashcard_set_settings_panels", "flashcard_sets"
  add_foreign_key "flashcard_set_settings_panels", "flashcards", column: "resume_flashcard_id"
  add_foreign_key "flashcard_set_settings_panels", "users"
  add_foreign_key "flashcard_sets", "users"
  add_foreign_key "flashcards", "flashcard_sets"
  add_foreign_key "learning_sessions", "users"
  add_foreign_key "teacher_tokens", "users", column: "teacher_id"
  add_foreign_key "user_sentence_sets", "users"
  add_foreign_key "user_sentences", "user_sentence_sets"
  add_foreign_key "users", "users", column: "teacher_id"
end
