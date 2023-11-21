Return-Path: <cgroups+bounces-500-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB4E7F2763
	for <lists+cgroups@lfdr.de>; Tue, 21 Nov 2023 09:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E6E28288C
	for <lists+cgroups@lfdr.de>; Tue, 21 Nov 2023 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FDE3AC16;
	Tue, 21 Nov 2023 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/g5h1CB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6B6CB;
	Tue, 21 Nov 2023 00:23:29 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-45d9689b65dso1817043137.0;
        Tue, 21 Nov 2023 00:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700555008; x=1701159808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTTlQmptyhl28YwEosbclj7OWg+yV7E5QNOLel4gX6s=;
        b=G/g5h1CBMMbuDOL2blUuQrW38gjO9h01pWI7iXmf+9iKbRbvJGq9DkWXhZibq6OHUm
         PrbU4coZha45G+MOXJoplvgJaFGIQeszf+Df5tGxXMywGyQbdkYW8h5fpwxAp7Mn7sZb
         EgKRsDUO7GqzY53FhluHZqHlBRyjQcMoxuYLbs82jEE9Oh13rng7ATN2XvL5tugnWeNR
         dyKd/1mLMK2+cX57ckQ2/PZlp0UKmfARa7pFaEKFDBEry0AzYS2C3wws3Kr9cZ7THGsX
         cqwMEG9J/z6G9zx2SXkkW4HCHm6H83B5thcbU4/SWzKZwsbfdkY8fT69B6VHtMbZVgz4
         kyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700555008; x=1701159808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTTlQmptyhl28YwEosbclj7OWg+yV7E5QNOLel4gX6s=;
        b=PZA2gd+Zgmd5aOyKELJtF3PaX0ZrxzqykMsYK5e6wiYc2yOxijL7So7oAO+GHkwnTd
         HWgLVKun5yYj3YYHgk8wBuAk5wNQNHNgeLhArl8znjEQoFbxuIlknkU5qvJZmYzjeVpE
         tKazgSlohY6psJmjZtad0SHWnDUEKkYRsDCskb1PLAwNexA491G1PidiguYFVDdcLlby
         XNYaryAYMfyTeIDkSB+Atp0/DXyOTq2h/bZCh75GneOANHvlYCIA+BeXjDvfB6jPmlvl
         gdg1hEfxWuIXlI0Oy5sieR6Wndc6jHnlCWVr0NpfA20kclKsxbUFR6OlrU1IQFIaXGKD
         KgCQ==
X-Gm-Message-State: AOJu0YzO+tHtZrcl45vWaWo7nJyZwMG+ZqjU7Ymrkix+I/M5/pwTDlvp
	yyT5Cj2cC/idm8DaBLjcJGeUNbVQ3KsK3frqBa0=
X-Google-Smtp-Source: AGHT+IGwoESgCljT9hI9a75uzFfG37Ho+LK4Kg8xt7bZRLz8mCB39XUmvj78Wr1gcUkuJvu0WD01EZ6+itnbfBvZNTg=
X-Received: by 2002:a67:fbcc:0:b0:45d:a89f:e1f4 with SMTP id
 o12-20020a67fbcc000000b0045da89fe1f4mr4547806vsr.9.1700555008189; Tue, 21 Nov
 2023 00:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz> <20231120-slab-remove-slab-v2-3-9c9c70177183@suse.cz>
In-Reply-To: <20231120-slab-remove-slab-v2-3-9c9c70177183@suse.cz>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Tue, 21 Nov 2023 17:23:17 +0900
Message-ID: <CAB=+i9R+307rFa8d6evMFMZwPrrCXmafGrZavMhupBYph6tSAg@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] KASAN: remove code paths guarded by CONFIG_SLAB
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Marco Elver <elver@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Kees Cook <keescook@chromium.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 3:34=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> With SLAB removed and SLUB the only remaining allocator, we can clean up
> some code that was depending on the choice.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

[...]

> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index ca4529156735..138c57b836f2 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -144,10 +144,6 @@ static void qlink_free(struct qlist_node *qlink, str=
uct kmem_cache *cache)
>  {
>         void *object =3D qlink_to_object(qlink, cache);
>         struct kasan_free_meta *meta =3D kasan_get_free_meta(cache, objec=
t);
> -       unsigned long flags;
> -
> -       if (IS_ENABLED(CONFIG_SLAB))
> -               local_irq_save(flags);
>
>         /*
>          * If init_on_free is enabled and KASAN's free metadata is stored=
 in
> @@ -166,9 +162,6 @@ static void qlink_free(struct qlist_node *qlink, stru=
ct kmem_cache *cache)
>         *(u8 *)kasan_mem_to_shadow(object) =3D KASAN_SLAB_FREE;
>
>         ___cache_free(cache, object, _THIS_IP_);
> -
> -       if (IS_ENABLED(CONFIG_SLAB))
> -               local_irq_restore(flags);
>  }

FYI there's a slight conflict (easy to resolve, though) when I tried
to merge this on top of linux-next,
due to a recent change in KASAN:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D0e8b630f3053f0ff84b7c3ab8ff98a7393863824

Thanks,
Hyeonggon

