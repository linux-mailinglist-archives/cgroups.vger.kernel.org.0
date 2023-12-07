Return-Path: <cgroups+bounces-881-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A921A807DF9
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 02:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FCD1F21A11
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 01:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B10136B;
	Thu,  7 Dec 2023 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2nemQi4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FDED65;
	Wed,  6 Dec 2023 17:35:51 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58df5988172so104015eaf.0;
        Wed, 06 Dec 2023 17:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701912950; x=1702517750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4xrwcnzIgg/3xKCyJBP6G5sTr9I0S6hKhfLAnFc++o=;
        b=P2nemQi4FvJkCh+XdvdWviHfR1K9O/ZmIbjgs8YAw2cP7rke8oN6HTdQ5CzlzY9qpY
         bZ8Df4gBvbuv7rmo5EPVPkuFvIBFwPg8mHfW0KewLLXZvbIcsVrxv1mgBcJRQkq3heGP
         wLbp+D8dUZCS2Rz8ZseSUYje1lff4GJDt/uP+lgu5gYhGgkdiYt8dWpq2eXcOFfYbfhF
         iJK93D3MprPqb9YK+16bZQ3uXg2/rVw1WIiugRS3sAZO+WY2oPOv2OH4G1HJ97y9pFqY
         V31lGvH3yxCO8zVNcrSoKcXaZDoygEd+UV1wgA9yGkszIAbqT3uDc7VWgCq1sTyKKOoN
         6/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701912950; x=1702517750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4xrwcnzIgg/3xKCyJBP6G5sTr9I0S6hKhfLAnFc++o=;
        b=uHJ9mqYPXK54SusYUF8dFdCrjhr9eC22rX8vv4GMBxcJ2fTaWzMMScPKi3fFacO0Vp
         zir8dJRV0vNXJZv/ST00K88NosSNMF+jfdPOxoAc1vXzuVvRh/GgOwfO0LW7hdrCwAX+
         3/FqF33BZrbNqQhNbRQRzIvEGPmXqfv0iAf5ToG4RxkbA8WumNlJXSFUTFzjBYzaCUrQ
         rFwZ1DequJ+ws89A7zTypoH7kXckHTUjJ8lW02MlkdmlMOWl8vagJZOmO0EVh0whChOr
         28geoq8QEenLqyRbMA9bubySSMIxLisS20GPjG5wfE1aBT1+kuD8StR+O0uZj7FX5G7j
         8y/Q==
X-Gm-Message-State: AOJu0YwDkttJnC556yDqHZC0cq9aXgCWCDlsutP7be9jCb2TWMiYJGnK
	2nLthp+rqWUFoi1rEww+byxp3cTr1i7TlA==
X-Google-Smtp-Source: AGHT+IGcqLPfXRlpGNUCb8LOOq3jN1nQ6GAu9BviQ+ei2oeEpmxl3kVJY3jAC786rB+FiaHsdAc3dA==
X-Received: by 2002:a05:6359:2d96:b0:170:17eb:203c with SMTP id rn22-20020a0563592d9600b0017017eb203cmr1939426rwb.37.1701912950403;
        Wed, 06 Dec 2023 17:35:50 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id g3-20020a056a0023c300b006c0685422e0sm149828pfc.214.2023.12.06.17.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:35:49 -0800 (PST)
Date: Thu, 7 Dec 2023 10:35:41 +0900
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
Subject: Re: [PATCH v2 19/21] mm/slub: remove slab_alloc() and
 __kmem_cache_alloc_lru() wrappers
Message-ID: <ZXEhbUL371iZztHQ@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-19-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-19-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:30PM +0100, Vlastimil Babka wrote:
> slab_alloc() is a thin wrapper around slab_alloc_node() with only one
> caller.  Replace with direct call of slab_alloc_node().
> __kmem_cache_alloc_lru() itself is a thin wrapper with two callers,
> so replace it with direct calls of slab_alloc_node() and
> trace_kmem_cache_alloc().
> 
> This also makes sure _RET_IP_ has always the expected value and not
> depending on inlining decisions.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index d6bc15929d22..5683f1d02e4f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3821,33 +3821,26 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
>  	return object;
>  }
>  
> -static __fastpath_inline void *slab_alloc(struct kmem_cache *s, struct list_lru *lru,
> -		gfp_t gfpflags, unsigned long addr, size_t orig_size)
> -{
> -	return slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, addr, orig_size);
> -}
> -
> -static __fastpath_inline
> -void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> -			     gfp_t gfpflags)
> +void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
>  {
> -	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
> +	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE, _RET_IP_,
> +				    s->object_size);
>  
>  	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
>  
>  	return ret;
>  }
> -
> -void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
> -{
> -	return __kmem_cache_alloc_lru(s, NULL, gfpflags);
> -}
>  EXPORT_SYMBOL(kmem_cache_alloc);
>  
>  void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  			   gfp_t gfpflags)
>  {
> -	return __kmem_cache_alloc_lru(s, lru, gfpflags);
> +	void *ret = slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, _RET_IP_,
> +				    s->object_size);
> +
> +	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_lru);

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

>  
> 
> -- 
> 2.42.1
> 
> 

