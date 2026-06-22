# Galeria de demonstração. As imagens ficam em db/seed_images e são anexadas
# via Active Storage (disco em dev). Idempotente.
IMAGES = {
  "Pôr do sol"  => "por-do-sol.png",
  "Oceano"      => "oceano.png",
  "Floresta"    => "floresta.png",
  "Montanha"    => "montanha.png",
  "Aurora"      => "aurora.png",
  "Deserto"     => "deserto.png"
}
CAPTIONS = {
  "Pôr do sol" => "Tons quentes no fim da tarde",
  "Oceano"     => "Azul profundo do mar",
  "Floresta"   => "Verde da mata fechada",
  "Aurora"     => "Luzes do céu noturno"
}

IMAGES.each do |title, file|
  next if Photo.exists?(title: title)
  photo = Photo.new(title: title, caption: CAPTIONS[title])
  path = Rails.root.join("db", "seed_images", file)
  photo.image.attach(io: File.open(path), filename: file, content_type: "image/png")
  photo.save!
end

puts "Fotos: #{Photo.count}"
