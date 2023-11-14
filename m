Return-Path: <cgroups+bounces-388-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332597EA9AF
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51AB2810B7
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EACB8487;
	Tue, 14 Nov 2023 04:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CsRdvzi4"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB9BA2D
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:41:36 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF4511A
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:41:34 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so5213318b3a.3
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936894; x=1700541694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eA82Hdspg/bY+CR7CFpsTdFZp4h7gtZ2SoVDA2UEAEM=;
        b=CsRdvzi44SUYrtU26qMcQxQza+GO2SigK5NTrdX+MXbGGaf92j7BCd+TLVoREYes9M
         IwRVZ2NL/IFeINp6O3MVx42WCFssAqOAQdBjwwl1e6BFu9IuD5MoW8Fw13GwEWNjftxc
         c+YX7/q7OG7ktXDxby7Wor0y7BAsKafQAGrLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936894; x=1700541694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eA82Hdspg/bY+CR7CFpsTdFZp4h7gtZ2SoVDA2UEAEM=;
        b=Ly/t9HqlFmEvCF3MiugfbwuoyexyQ+k6n6m3lgBaxE1aPZDk30HTA05KE0sZ4Z4fPp
         iuWuk81LHZMI24ZfWrQioT3ns9Pi/dfP9XNsCNQ/jBFAfbdW4rhBjJb/Lj3PVqtKSO68
         +gI9B+w8i2iFoKeFpfNtkZBH8jzcPdpdpPcN122dThg6KrQUV+85KkBcZYmbvJFwQF2q
         qN/Hs1I8OwaCdStN0c1EWchEgwLsRkvPvo8DMzQOmN6LzwEMuAGgWB7T1wELRdZ0QN8a
         yrZlZ6QSAo21TuHRQ8K8XI/A1MY9Yz3gfKVO7QiluC3w1Al1jFB9bMa4N0/+K3ov7PAd
         YKpg==
X-Gm-Message-State: AOJu0YytnlArtKz073gyGBQT0jlmqqaGlXLjXcSE1NOXqhLc5VtGeqL/
	vLSdwQ+w3xFaTdKvlWaAiHFf1w==
X-Google-Smtp-Source: AGHT+IFUbqnfiVhlSCwWCV5DGdqS5OAFW8uF1N6KtxMGpaKCHywxvsAYJi+LSQYhPHziOoJn8xTdZQ==
X-Received: by 2002:a05:6a00:10c8:b0:6b8:a6d6:f51a with SMTP id d8-20020a056a0010c800b006b8a6d6f51amr9811289pfu.31.1699936893812;
        Mon, 13 Nov 2023 20:41:33 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b13-20020a056a00114d00b006baa1cf561dsm395221pfm.0.2023.11.13.20.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:41:33 -0800 (PST)
Date: Mon, 13 Nov 2023 20:41:32 -0800
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
Subject: Re: [PATCH 11/20] mm/slab: consolidate includes in the internal
 mm/slab.h
Message-ID: <202311132039.7CC758A@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-33-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-33-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:52PM +0100, Vlastimil Babka wrote:
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
> index 6e76216ac74e..c278f8b15251 100644
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

I've seen kernel code style in other places ask that includes be
organized alphabetically. Is the order here in this order for some
particular reason?

-- 
Kees Cook

