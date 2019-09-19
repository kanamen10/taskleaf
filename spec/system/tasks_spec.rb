require 'rails_helper'

describe 'タスク管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'userA', email: 'a@test.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'userB', email: 'b@test.com') }
  let!(:task_a) { FactoryBot.create(:task, name: 'taskA', user: user_a) }

  before do
    # 作成者がユーザAであるタスクを作成しておく
    visit login_path
    fill_in 'email', with: login_user.email
    fill_in 'password', with: login_user.password
    click_button 'LOGIN'
  end
  
  shared_examples_for 'ユーザAが作成したタスクが表示される' do
    it { expect(page).to have_content 'taskA' }
  end
  
  describe '一覧表示機能' do
    context 'ユーザAがログインユーザであるとき' do
      let(:login_user) { user_a }
      it_behaves_like 'ユーザAが作成したタスクが表示される'
    end
    
    context 'ユーザBがログインユーザであるとき' do
      let(:login_user) { user_b }
      it 'ユーザAが作成したタスクが表示されない' do
        expect(page).to have_no_content 'taskA'
      end
    end
  end
  
  describe 'タスク詳細表示機能' do
    context 'ユーザAがログインユーザであるとき' do
      let(:login_user) { user_a }
      
      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザAが作成したタスクが表示される'
    end
  end
  
  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in 'name', with: task_name
      # fill_in 'name', with: 'kanamen'
      # fill_in 'description', with: 'kanamen10'
      click_button 'SUBMIT!'
    end

    context '新規作成画面で名称を入力したとき' do
      let(:task_name) { '新規作成のテストを書く' }
      
      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end
    
    context '新規作成画面で名称を入力しなかったとき' do
      let(:task_name) { '' }
      
      it '登録されずエラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content 'Nameを入力してください'
        end
      end
    end
  end
end
