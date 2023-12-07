Return-Path: <cgroups+bounces-879-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D28ED807DE7
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 02:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D881F21A25
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 01:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48947111B;
	Thu,  7 Dec 2023 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYi281FA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89812D4B;
	Wed,  6 Dec 2023 17:28:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d06d4d685aso2851625ad.3;
        Wed, 06 Dec 2023 17:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701912519; x=1702517319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3u1soC42kxxszJtJ9Fi1B4cg1LFazMYjfirO31EmOoI=;
        b=GYi281FAObYriOfmCwajya0urcLabMiSyKKz9b6RKZc2M7IA3cnm/nLBmV+m1ohjBX
         u9u2+TRmBD4syFFUwH3ST41Ar9JsZ0BqGoKOVnb0+JFoiV+gDYwOSoA+wgp/kZmz0Emy
         D1Cb5eEnkymqa9CTGy+YdY4tCSfuaqOfhQwDyDcK9FmbV8CEpTQtPOyU11pEPjRlhSV+
         lEZyXcrFdF4P9nCEirJwUTxajAoHIg8iGrSxSkFz+iYIB5pheTzECUHEmEKaa+j3k+pI
         wW8ZOcrtLF0d6ZYZR60HLD4uFZjqMBrcKx985c8oHsQX99b/O5D7yBsL8pm7i/K3cl2H
         YA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701912519; x=1702517319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u1soC42kxxszJtJ9Fi1B4cg1LFazMYjfirO31EmOoI=;
        b=ApmQjNUojHklXV7toQzjLiRvKcnZUFcasm0AjKX8L/OFfxC7YU1c8/YCr32vicFppO
         eqni1Vs0OeSPH2q8I9hQ24H2UOZyIB63jMrysfsXohdrF2Xun1drPiOSJqBXTEf5BMo5
         cguWPqccbUi9g8eoHV9ceTDslhafrEori0I1xnNutEIL8s5REEn3YfA0SYHtgAhDTDzQ
         TItJRRpuLjyr8wk7n2mfw3Fkr/qlhMiacsSWfF3hHAm3QiVFdB9tWo7CbnTO2FIAFcp3
         O2FZBK2HSUM6U9Qi0YsH4/bLUBPqTOaq6xq5Vn87NgBx50nKT01wHu5ORmWhIF/k6u1J
         gwvg==
X-Gm-Message-State: AOJu0YxvtDhd3z7lp5weOfYmRojwunLBU3b0CwBpE32rncl6PZi815yP
	mgQBhPk/TUS4YM2y8Wo1n9Y=
X-Google-Smtp-Source: AGHT+IGx09sA3QjHCBqfxN8uUNcuGoNURkGUfVZC/vkcb6H8V+KrZS46H5LXsWB+131aJ1639Rkiog==
X-Received: by 2002:a17:902:6bc5:b0:1d0:bfb7:6709 with SMTP id m5-20020a1709026bc500b001d0bfb76709mr1280230plt.24.1701912518601;
        Wed, 06 Dec 2023 17:28:38 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902780e00b001bf8779e051sm89840pll.289.2023.12.06.17.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:28:37 -0800 (PST)
Date: Thu, 7 Dec 2023 10:28:24 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 17/21] mm/slab: move kmalloc_slab() to mm/slab.h
Message-ID: <ZXEfuHomAtFw3pKI@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-17-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-17-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:28PM +0100, Vlastimil Babka wrote:
> In preparation for the next patch, move the kmalloc_slab() function to
> the header, as it will have callers from two files, and make it inline.
> To avoid unnecessary bloat, remove all size checks/warnings from
> kmalloc_slab() as they just duplicate those in callers, especially after
> recent changes to kmalloc_size_roundup(). We just need to adjust handling
> of zero size in __do_kmalloc_node(). Also we can stop handling NULL
> result from kmalloc_slab() there as that now cannot happen (unless
> called too early during boot).
> 
> The size_index array becomes visible so rename it to a more specific
> kmalloc_size_index.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h        | 28 ++++++++++++++++++++++++++--
>  mm/slab_common.c | 43 ++++++++-----------------------------------
>  2 files changed, 34 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 35a55c4a407d..7d7cc7af614e 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -389,8 +389,32 @@ extern const struct kmalloc_info_struct {
>  void setup_kmalloc_cache_index_table(void);
>  void create_kmalloc_caches(slab_flags_t);
>  
> -/* Find the kmalloc slab corresponding for a certain size */
> -struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags, unsigned long caller);
> +extern u8 kmalloc_size_index[24];
> +
> +static inline unsigned int size_index_elem(unsigned int bytes)
> +{
> +	return (bytes - 1) / 8;
> +}
> +
> +/*
> + * Find the kmem_cache structure that serves a given size of
> + * allocation
> + *
> + * This assumes size is larger than zero and not larger than
> + * KMALLOC_MAX_CACHE_SIZE and the caller must check that.
> + */
> +static inline struct kmem_cache *
> +kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
> +{
> +	unsigned int index;
> +
> +	if (size <= 192)
> +		index = kmalloc_size_index[size_index_elem(size)];
> +	else
> +		index = fls(size - 1);
> +
> +	return kmalloc_caches[kmalloc_type(flags, caller)][index];
> +}
>  
>  void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
>  			      int node, size_t orig_size,
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f4f275613d2a..31ade17a7ad9 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -665,7 +665,7 @@ EXPORT_SYMBOL(random_kmalloc_seed);
>   * of two cache sizes there. The size of larger slabs can be determined using
>   * fls.
>   */
> -static u8 size_index[24] __ro_after_init = {
> +u8 kmalloc_size_index[24] __ro_after_init = {
>  	3,	/* 8 */
>  	4,	/* 16 */
>  	5,	/* 24 */
> @@ -692,33 +692,6 @@ static u8 size_index[24] __ro_after_init = {
>  	2	/* 192 */
>  };
>  
> -static inline unsigned int size_index_elem(unsigned int bytes)
> -{
> -	return (bytes - 1) / 8;
> -}
> -
> -/*
> - * Find the kmem_cache structure that serves a given size of
> - * allocation
> - */
> -struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
> -{
> -	unsigned int index;
> -
> -	if (size <= 192) {
> -		if (!size)
> -			return ZERO_SIZE_PTR;
> -
> -		index = size_index[size_index_elem(size)];
> -	} else {
> -		if (WARN_ON_ONCE(size > KMALLOC_MAX_CACHE_SIZE))
> -			return NULL;
> -		index = fls(size - 1);
> -	}
> -
> -	return kmalloc_caches[kmalloc_type(flags, caller)][index];
> -}
> -
>  size_t kmalloc_size_roundup(size_t size)
>  {
>  	if (size && size <= KMALLOC_MAX_CACHE_SIZE) {
> @@ -843,9 +816,9 @@ void __init setup_kmalloc_cache_index_table(void)
>  	for (i = 8; i < KMALLOC_MIN_SIZE; i += 8) {
>  		unsigned int elem = size_index_elem(i);
>  
> -		if (elem >= ARRAY_SIZE(size_index))
> +		if (elem >= ARRAY_SIZE(kmalloc_size_index))
>  			break;
> -		size_index[elem] = KMALLOC_SHIFT_LOW;
> +		kmalloc_size_index[elem] = KMALLOC_SHIFT_LOW;
>  	}
>  
>  	if (KMALLOC_MIN_SIZE >= 64) {
> @@ -854,7 +827,7 @@ void __init setup_kmalloc_cache_index_table(void)
>  		 * is 64 byte.
>  		 */
>  		for (i = 64 + 8; i <= 96; i += 8)
> -			size_index[size_index_elem(i)] = 7;
> +			kmalloc_size_index[size_index_elem(i)] = 7;
>  
>  	}
>  
> @@ -865,7 +838,7 @@ void __init setup_kmalloc_cache_index_table(void)
>  		 * instead.
>  		 */
>  		for (i = 128 + 8; i <= 192; i += 8)
> -			size_index[size_index_elem(i)] = 8;
> +			kmalloc_size_index[size_index_elem(i)] = 8;
>  	}
>  }
>  
> @@ -977,10 +950,10 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
>  		return ret;
>  	}
>  
> -	s = kmalloc_slab(size, flags, caller);
> +	if (unlikely(!size))
> +		return ZERO_SIZE_PTR;
>  
> -	if (unlikely(ZERO_OR_NULL_PTR(s)))
> -		return s;
> +	s = kmalloc_slab(size, flags, caller);
>  
>  	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
>  	ret = kasan_kmalloc(s, ret, size, flags);
> 
> -- 

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 2.42.1
> 
> 

