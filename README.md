Ro Theme

Ro, KDE Plasma tabanlı işletim sistemimiz için geliştirilen minimal ve modüler tema projesidir.
Bu repository tek bir ana repo altında 4 ayrı modülden oluşur.

Repository Yapısı
g1-berat     → Desktop layout & panel sistemi
g2-mehmet    → KWin effects & window davranışları
g3-servet    → Visual theme (Plasma theme, colors, icons)
g4-tugba     → Login & boot (SDDM, Plymouth)

Her geliştirici sadece kendi klasöründe çalışır.

Geliştirme Modeli

Main branch = Stabil sürüm
Her geliştirici kendi branch’inde çalışır
Değişiklikler Pull Request ile main’e alınır
ISO sistemi sadece main branch’i baz alır

Dağıtım
Proje RPM olarak paketlenir ve DNF repository üzerinden dağıtılır.
Akış: Branch → PR → Merge → RPM Build → DNF Repo → ISO

Amaç
Minimal
Modüler
Profesyonel KDE tema mimarisi
ISO entegrasyonuna uygun yapı
