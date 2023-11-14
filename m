Return-Path: <cgroups+bounces-395-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88FC7EAB0B
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 08:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BEA1F21E33
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 07:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBCD11CAD;
	Tue, 14 Nov 2023 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="saCOkZvi"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08E6FA9
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 07:46:44 +0000 (UTC)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94771AC
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 23:46:41 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-4ac89e8e964so2278763e0c.3
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 23:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699948001; x=1700552801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sX2ZDi+R3Ev6T5LlvMfvdN7qFs7PkFHPelflvttGDD4=;
        b=saCOkZviF7qV44inxihxL/LyQ8WpG4Ax9CQwREQIlchvqKCKVg+I7eBXPkjJ7mlme6
         rGzC0LJ7yFQ+anMCwRbaQhmlYRb0xilb6AsiD7qE3MDwna6aDhYJQ7icc/BDeOqMgtzH
         0FL8uhOBtorhv6g6aSlzGNI3/JPPVTc1AnYNpNLuhJSiqKszlRF3JwBqLbA1lI5w7MG7
         XnErTCY8jdWXxQenTzD6/npOyRzn6SzIksztlFiAxyrCoX7JAPJ9NnRelami6DBgLwiP
         yMjsWczq9yz2TSlwejV8CJ4qlRiFHT6RfL2F+zvGykBrrVMQehI5eoV1WHT7Fu6JeVJO
         +JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699948001; x=1700552801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sX2ZDi+R3Ev6T5LlvMfvdN7qFs7PkFHPelflvttGDD4=;
        b=ogsqqBniTVVAN9OIgfk6724J3ilTNthLjm5tCoemyKav3/SUgQnKxjYg2DPvpfOSRb
         0JbojbaU9kCREuo1T/NtkALyBWjqVJEuuF7bMNUWdoKmGVGxejVQogQFcivFGVam89I5
         wVHHw2VhAxlNpOZsFJRKDbadGZQXj87zzH1yZSyOm62pKHp/vcw0xA6ViEB0UvYHHOsd
         8OV9bA5QawgU0p5zYwRlBwLa0mWrbCjWjeFtuN4UNUBaZXlpVa5070peuD6I8DMzBcQb
         jR+HtdNw1ckU6DcNTJ3+W+7OaRrqV3y6SseSEvjH4mMnjU3gkFJbdbhdc0bIsHgUFmO8
         +hUg==
X-Gm-Message-State: AOJu0YyhaAGN3pJ/NODQ9O5ynXh1ZbRVwR4efR9gntDnjo7VUsMpR8dE
	9a8CgnAFgD1mQjQQQmXpQYRyt7rS/iMkEeTIrYxc5g==
X-Google-Smtp-Source: AGHT+IEkx9qpi9PxginlouXMsLXjDm4AhflR5GKJMwuObn7dBWpabAiTtV5tdjgAPRBqG6d0RnyHF3wv2N9uz3bxx2o=
X-Received: by 2002:a05:6102:2908:b0:460:621c:d14b with SMTP id
 cz8-20020a056102290800b00460621cd14bmr9815342vsb.20.1699948000802; Mon, 13
 Nov 2023 23:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113191340.17482-22-vbabka@suse.cz> <20231113191340.17482-25-vbabka@suse.cz>
In-Reply-To: <20231113191340.17482-25-vbabka@suse.cz>
From: Marco Elver <elver@google.com>
Date: Tue, 14 Nov 2023 08:46:04 +0100
Message-ID: <CANpmjNOrA_nfMsu1eaTqauVfc53p5xHxO7TZAueVXyi5Qf9wAg@mail.gmail.com>
Subject: Re: [PATCH 03/20] KFENCE: cleanup kfence_guarded_alloc() after
 CONFIG_SLAB removal
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Kees Cook <keescook@chromium.org>, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Nov 2023 at 20:14, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Some struct slab fields are initialized differently for SLAB and SLUB so
> we can simplify with SLUB being the only remaining allocator.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kfence/core.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 3872528d0963..8350f5c06f2e 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -463,11 +463,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>         /* Set required slab fields. */
>         slab = virt_to_slab((void *)meta->addr);
>         slab->slab_cache = cache;
> -#if defined(CONFIG_SLUB)
>         slab->objects = 1;
> -#elif defined(CONFIG_SLAB)
> -       slab->s_mem = addr;
> -#endif
>
>         /* Memory initialization. */
>         set_canary(meta);
> --
> 2.42.1
>

