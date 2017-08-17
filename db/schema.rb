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

ActiveRecord::Schema.define(version: 20170811181225) do

  create_table "answers", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "question_id"
    t.string   "give"
    t.boolean  "correct_answer", default: false
    t.integer  "score",          default: 0
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "correct_answers", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "give"
    t.integer  "question_id"
    t.index ["question_id"], name: "index_correct_answers_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "ask"
    t.boolean  "multiple_answers", default: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "user_answers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "give"
  end

  create_table "user_question_useranswers", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "user_answer_id"
    t.string   "answer_user"
    t.index ["question_id"], name: "index_user_question_useranswers_on_question_id"
    t.index ["user_answer_id"], name: "index_user_question_useranswers_on_user_answer_id"
    t.index ["user_id"], name: "index_user_question_useranswers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "examinee_answer"
    t.integer  "examinee_score"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "welcomes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
