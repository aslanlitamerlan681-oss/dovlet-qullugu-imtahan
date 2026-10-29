# Dövlət Qulluğu — Netlify + Supabase

Bu paket **yalnız ZIP yükləməklə tam işləmir**. Real admin girişi, imtahan linki və nəticələr üçün Supabase layihəsi və Netlify environment variables tələb olunur.

## 1. Supabase qurulması
1. https://supabase.com saytında layihə yaradın.
2. SQL Editor bölməsində `schema.sql` faylını icra edin.
3. Authentication → Users bölməsində müəllim üçün e-poçt/şifrə hesabı yaradın.
4. Project Settings → API bölməsindən Project URL, `anon`/publishable key və **service_role**/secret key götürün. `service_role` heç vaxt frontend HTML-ə yazılmamalıdır.

## 2. Netlify
1. Bu qovluğu GitHub reposuna yükləyib Netlify-a bağlayın (Netlify Functions deploy olunsun). `netlify.toml` artıq var.
2. Netlify → Site configuration → Environment variables bölməsində aşağıdakıları əlavə edin:
   - `SUPABASE_URL` = https://PROJECT.supabase.co
   - `SUPABASE_ANON_KEY` = Supabase anon key
   - `SUPABASE_SERVICE_ROLE_KEY` = Supabase service_role key (yalnız server üçün)
   - `ADMIN_EMAILS` = müəllim hesabının e-poçtu (bir neçə olarsa vergüllə)
3. Saytı yenidən deploy edin.

## 3. İstifadə
- Müəllim paneli: `https://SAYT.netlify.app/?admin=1`
- Müəllim login olub 15 hazır sualı yükləyir, tarixləri yoxlayır və **İmtahanı saxla / yayımla** seçir.
- Tələbə linki: `https://SAYT.netlify.app/?exam=bb-05-iyul`
- Tarix: 30 oktyabr 2026, 19:00 (Bakı)
- Son giriş: 19:15 (Bakı)
- Ümumi bitmə: 20:30 (Bakı)
- Müddət: 90 dəqiqə; gec başlayanların imtahanı da 20:30-dan gec bitmir.
- Müəllim nəticələri paneldə görür.

## Təhlükəsizlik və məhdudiyyətlər
- Admin hesabı Supabase Auth vasitəsilə yoxlanılır; e-poçt allowlist ilə təsdiqlənir.
- Supabase cədvəlləri RLS ilə qorunur; yalnız Netlify server funksiyaları DB-yə müraciət edir.
- Tələbə yalnız ad-soyadla daxil olduğundan kimliyi təsdiqlənmir; eyni adla bir neçə dəfə daxil olmaq mümkündür. Bu, nəzarətli imtahan üçün əlavə identifikasiya tələb edir.
- Server saatı giriş və nəticə göndərilməsində yoxlanır.
- Word/PDF importu mətnə əsaslanır; şəkillər və qalın şriftlə göstərilən düzgün cavablar avtomatik etibarlı ötürülmür. Yoxlayın.
- Admin mövcud imtahanı iştirakçı daxil olduqdan sonra redaktə edə bilməz; yeni link kodu yaradın.
- Qələm qaralaması yalnız cari cihazda qalır; serverə göndərilmir.
- Bu sistem rəsmi DİM platforması deyil.
- Daha yüksək yüklənmə üçün rate limiting, CAPTCHA və audit logging əlavə edilməlidir.
