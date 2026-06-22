require "test_helper"

class UploadFlowTest < ActionDispatch::IntegrationTest
  test "galeria carrega" do
    get root_path
    assert_response :success
  end

  test "faz upload de uma foto" do
    file = Rack::Test::UploadedFile.new(
      StringIO.new("\x89PNG\r\n\x1a\n"), "image/png", original_filename: "foto.png"
    )
    assert_difference("Photo.count", 1) do
      post photos_path, params: { photo: { title: "Minha foto", image: file } }
    end
    assert_redirected_to root_path
    assert Photo.last.image.attached?
  end

  test "upload sem imagem é rejeitado" do
    assert_no_difference("Photo.count") do
      post photos_path, params: { photo: { title: "Sem imagem" } }
    end
    assert_response :unprocessable_content
  end
end
