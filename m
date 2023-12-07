Return-Path: <cgroups+bounces-875-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D623A807D41
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 01:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7531F215E3
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 00:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5963DDCC;
	Thu,  7 Dec 2023 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVkDLPJY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329091736;
	Wed,  6 Dec 2023 16:30:31 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so78150b3a.1;
        Wed, 06 Dec 2023 16:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701909030; x=1702513830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUILdXO0fAmIum4i0LjaIhGHTq4M4euUAAZGlBJTfMI=;
        b=UVkDLPJYiku3Z/fo/QgPMrxc6kDRoov/cHWzBBepkOK/TFxjbFqDA+3SlZC8Lga89h
         kp/9lKXuMzTjHUDJmYT3I7KvO9+/D/cdqGBcO1mD1zFg67X3BslaEdgZNbZS9bqmjQMZ
         oWZEG/AgshzfdwLVGk2tB4cSqrLg/mvays2NhZ3KMXJy3S5Dd8XIC8WoXhcEydYpBlb2
         b2NzUC6n2sYnAv5SGyciV2GAQxQU3qDueyRzj2uBK/x/l8s+QA4xkm5KEh/mMXNTwEfu
         +pH/oEuGsWzWm5EsVxt8wxgCbI2f8YV2YrLhQjWp4rAIVOnP9Y6ceApY6KPOaCCgv2Bs
         B5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701909030; x=1702513830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUILdXO0fAmIum4i0LjaIhGHTq4M4euUAAZGlBJTfMI=;
        b=E7Qabj6S23/cy9FIOC9DvMjGtGU12+FhIIymtrlV3RKb9v4tMY9e75zgUFj9pXgu6/
         +fWAS7thFtNxX1rx3LPncxJcygrv6oI/h7RvyGmMDRZeLKOsB5qOPtGmc11YWYhTC2xm
         UIGL/DegYmA3nVVB3yBtSKAj/0SU3dwOMWZDTFmTSw3QCEOKbI70hpYWcim4GCJ1czFm
         ugZueyBRWqHDIYle51TyYSa+Vg8chpvV4osupfdBdrzFIuhiwkAft07jO2SKF0SPh7On
         2oRJ3vKqSxRNygZ0njPcCJPReQQTQtBMiTR1FyBTwSEkfuW+BW6Z71ova6ANoVTQVKmc
         veXg==
X-Gm-Message-State: AOJu0Yzsu8kD9E1L4tQ43UfPp67Z71TxDWiv38zIkEDlO9IrRZiE/3ji
	LRMDc+Z3+aQRqdbESWRjcTU=
X-Google-Smtp-Source: AGHT+IGNdRr4yYn8X8E8TUhLrtQlJNH4KI21LBAMZQqyY0t/4ywu4K0f2WjEAimk9RqDqbbbR0tJkQ==
X-Received: by 2002:a05:6a00:3a1a:b0:68f:a92a:8509 with SMTP id fj26-20020a056a003a1a00b0068fa92a8509mr4897945pfb.7.1701909030344;
        Wed, 06 Dec 2023 16:30:30 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id n19-20020aa78a53000000b006ce7d0d2590sm120723pfa.0.2023.12.06.16.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:30:29 -0800 (PST)
Date: Thu, 7 Dec 2023 09:30:15 +0900
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
Subject: Re: [PATCH v2 12/21] mm/slab: consolidate includes in the internal
 mm/slab.h
Message-ID: <ZXESF2kgL93SjEgl@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-12-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-12-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:23PM +0100, Vlastimil Babka wrote:
> The #include's are scattered at several places of the file, but it does
> not seem this is needed to prevent any include loops (anymore?) so
> consolidate them at the top. Also move the misplaced kmem_cache_init()
> declaration away from the top.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 3a8d13c099fa..1ac3a2f8d4c0 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -1,10 +1,22 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef MM_SLAB_H
>  #define MM_SLAB_H
> +
> +#include <linux/reciprocal_div.h>
> +#include <linux/list_lru.h>
> +#include <linux/local_lock.h>
> +#include <linux/random.h>
> +#include <linux/kobject.h>
> +#include <linux/sched/mm.h>
> +#include <linux/memcontrol.h>
> +#include <linux/fault-inject.h>
> +#include <linux/kmemleak.h>
> +#include <linux/kfence.h>
> +#include <linux/kasan.h>
> +
>  /*
>   * Internal slab definitions
>   */
> -void __init kmem_cache_init(void);
>  
>  #ifdef CONFIG_64BIT
>  # ifdef system_has_cmpxchg128
> @@ -209,11 +221,6 @@ static inline size_t slab_size(const struct slab *slab)
>  	return PAGE_SIZE << slab_order(slab);
>  }
>  
> -#include <linux/kfence.h>
> -#include <linux/kobject.h>
> -#include <linux/reciprocal_div.h>
> -#include <linux/local_lock.h>
> -
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  #define slub_percpu_partial(c)			((c)->partial)
>  
> @@ -347,14 +354,6 @@ static inline int objs_per_slab(const struct kmem_cache *cache,
>  	return slab->objects;
>  }
>  
> -#include <linux/memcontrol.h>
> -#include <linux/fault-inject.h>
> -#include <linux/kasan.h>
> -#include <linux/kmemleak.h>
> -#include <linux/random.h>
> -#include <linux/sched/mm.h>
> -#include <linux/list_lru.h>
> -
>  /*
>   * State of the slab allocator.
>   *
> @@ -405,6 +404,7 @@ gfp_t kmalloc_fix_flags(gfp_t flags);
>  /* Functions provided by the slab allocators */
>  int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
>  
> +void __init kmem_cache_init(void);
>  void __init new_kmalloc_cache(int idx, enum kmalloc_cache_type type,
>  			      slab_flags_t flags);
>  extern void create_boot_cache(struct kmem_cache *, const char *name,

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 
> -- 
> 2.42.1
> 
> 

