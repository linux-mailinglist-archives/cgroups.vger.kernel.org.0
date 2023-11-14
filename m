Return-Path: <cgroups+bounces-384-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E65C7EA988
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD22810E3
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE7CB660;
	Tue, 14 Nov 2023 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ElzCFSbH"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD46168C8
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:31:53 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BE21A7
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:31:52 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc329ce84cso47085495ad.2
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936312; x=1700541112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRGeaFnyf6oFg3w2q7Y0wKf4gObnq/HsTjuQwLGdqK8=;
        b=ElzCFSbHfe/bgGucSXBeZpMSCtMu2fXvdAFVvljnXf7iNnJnoNNXsub8LAybfdvscb
         OMSNmWetZ7B9blXxPFLn/RcwQ5H/ZhhOmQ/0JnGT3wWbsaPQG+FAxOCb3DjXJ5IZmBal
         hyzFQd65nLN0hf0M5ECPKRMV62mK5eD1rtXxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936312; x=1700541112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRGeaFnyf6oFg3w2q7Y0wKf4gObnq/HsTjuQwLGdqK8=;
        b=mFIEowO0/IAKZrChF+hYmSxWSEAn+U3+C2PhIJQUzzqeS2ajah/G1muC+bsI2A9RoK
         R8ZWFO2kooEvAglvCoZsaKTINm7ZKBBYne70NGTE8qF2vBfvpiz50iciUqWvQdBJjdX4
         YE1XMtHhHYG7guNHv/7rC62z2ZryZIa/3VwciPQGuVa4hRSPoutUcySzcXuWRxJ6Y0EV
         GdxLvtFBclPdfS1hg20Q3LB8GMorJahEVQ/yUVSJ5mXQotsZb3ublPLAro15qOvrbvtu
         FGk4ELw82jpuN03pByf4YO0XpRhEhp/jh07FCYseKlZo7wZPfALO9hwRT5Oc64FSQKf/
         xvKA==
X-Gm-Message-State: AOJu0Ywt9P2uso0VYyD+WwoYo7ZX9/AFUgLcoXvA+96mKKGEjCG+xTbO
	tZZphV8LzgvCkqbeqCoVl4YT1g==
X-Google-Smtp-Source: AGHT+IFvceFQuU8pAlXLSAPEOVKfVP9ovqBBvtCeG6ahmhd48S+R6ZSbVzn8nuN1wKsAP5TgAinsRQ==
X-Received: by 2002:a17:903:2a8c:b0:1ce:8e4:111 with SMTP id lv12-20020a1709032a8c00b001ce08e40111mr1701477plb.27.1699936312112;
        Mon, 13 Nov 2023 20:31:52 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902bf4100b001bb9d6b1baasm4768235pls.198.2023.11.13.20.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:31:51 -0800 (PST)
Date: Mon, 13 Nov 2023 20:31:51 -0800
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH 07/20] mm/mempool/dmapool: remove CONFIG_DEBUG_SLAB ifdefs
Message-ID: <202311132030.1B2302BA4@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-29-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-29-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:48PM +0100, Vlastimil Babka wrote:
> CONFIG_DEBUG_SLAB is going away with CONFIG_SLAB, so remove dead ifdefs
> in mempool and dmapool code.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/dmapool.c | 2 +-
>  mm/mempool.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index a151a21e571b..f0bfc6c490f4 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -36,7 +36,7 @@
>  #include <linux/types.h>
>  #include <linux/wait.h>
>  
> -#if defined(CONFIG_DEBUG_SLAB) || defined(CONFIG_SLUB_DEBUG_ON)
> +#ifdef CONFIG_SLUB_DEBUG_ON
>  #define DMAPOOL_DEBUG 1
>  #endif
>  
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 734bcf5afbb7..62dcbeb4c2a9 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -20,7 +20,7 @@
>  #include <linux/writeback.h>
>  #include "slab.h"
>  
> -#if defined(CONFIG_DEBUG_SLAB) || defined(CONFIG_SLUB_DEBUG_ON)
> +#ifdef CONFIG_SLUB_DEBUG_ON
>  static void poison_error(mempool_t *pool, void *element, size_t size,
>  			 size_t byte)
>  {
> @@ -95,14 +95,14 @@ static void poison_element(mempool_t *pool, void *element)
>  		kunmap_atomic(addr);
>  	}
>  }
> -#else /* CONFIG_DEBUG_SLAB || CONFIG_SLUB_DEBUG_ON */
> +#else /* CONFIG_SLUB_DEBUG_ON */
>  static inline void check_element(mempool_t *pool, void *element)
>  {
>  }
>  static inline void poison_element(mempool_t *pool, void *element)
>  {
>  }
> -#endif /* CONFIG_DEBUG_SLAB || CONFIG_SLUB_DEBUG_ON */
> +#endif /*CONFIG_SLUB_DEBUG_ON */

nit: space after "*"

With that fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

