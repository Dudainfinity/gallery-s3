require "test_helper"

class PhotoTest < ActiveSupport::TestCase
  def attach_image(photo, content_type: "image/png")
    photo.image.attach(
      io: StringIO.new("fake-bytes"),
      filename: "x.png",
      content_type: content_type
    )
  end

  test "válida com título e imagem" do
    photo = Photo.new(title: "Foto")
    attach_image(photo)
    assert photo.valid?
  end

  test "inválida sem título" do
    photo = Photo.new(title: "")
    attach_image(photo)
    assert_not photo.valid?
  end

  test "inválida sem imagem" do
    photo = Photo.new(title: "Foto")
    assert_not photo.valid?
    assert_includes photo.errors[:image], "é obrigatória"
  end

  test "rejeita tipo de arquivo que não é imagem" do
    photo = Photo.new(title: "Doc")
    attach_image(photo, content_type: "application/pdf")
    assert_not photo.valid?
  end
end
