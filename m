Return-Path: <cgroups+bounces-382-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A237EA974
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9839928104B
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D3AB651;
	Tue, 14 Nov 2023 04:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mDgENNKp"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE65B64F
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:20:38 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A28189
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:20:34 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc3bc5df96so37717985ad.2
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699935634; x=1700540434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ew+aEAUFKMT5ddXwYjWs+9wP5nLqtY4565XxaEvPnVw=;
        b=mDgENNKpQ7f7itdsUKVxSRLmWJBwXd2jnJ9NvU5b0EgLDRRAttfuc6PFgL37+NahdD
         WDdx6LfHb+NXTVORqfr5cwMS5Y2qfavJ/2R+GLEl9y9UKJMPf0vlj8Z6suSD3Xj5tYc/
         Z//5/K/+IDprPOnDWhEubFniQI62cBa8oFAjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699935634; x=1700540434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew+aEAUFKMT5ddXwYjWs+9wP5nLqtY4565XxaEvPnVw=;
        b=LO0zVT51mBgy7kwpLCWbuvRgtTMduQCiglrdEaNyjK5DZ9CYud0ROj/lQSeNK4gKoh
         Vki3g1Kn79lxB7iNIV/YTPpIyXd2KAL2gvoZ3Sbeg/GgufdbG4Vnjp9c38TfRqVxFzWR
         88I+qmobHHwW12MTEq2FrrwCpTxAfkELqwHRK2qIr6wcoxCBe6WWKB/RRMN9c6eKH1jJ
         zJNWjIn/bZsD08EQvwsy5UhESxky3ENsS5esiX+v+3WnOou5nfBboBEWZvMf7OjHzSrA
         BqVdqm5odNPtqF0TEjAxTkTfmoaOKl5BXWq78XJX3fZARnUht0xJS0i1lXa3JlEG6ykr
         OiCg==
X-Gm-Message-State: AOJu0YzxtBHDhr5NFcaUOGkWpfWvX3WietiKSBbtZjXUJnKgje6d76AG
	MjqqdDVe8+/xE0lc/6It5OjT5w==
X-Google-Smtp-Source: AGHT+IEEuR9OHz0h/+qyQyKe+kSZOUz74iG8+oSzIWHLFYokTNJRmRlv4PFje7Gdb+90MtEYK337Ug==
X-Received: by 2002:a17:903:260b:b0:1ce:171d:2795 with SMTP id jd11-20020a170903260b00b001ce171d2795mr1129493plb.65.1699935633849;
        Mon, 13 Nov 2023 20:20:33 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001cc3875e658sm4792216plz.303.2023.11.13.20.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:20:33 -0800 (PST)
Date: Mon, 13 Nov 2023 20:20:32 -0800
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
Subject: Re: [PATCH 05/20] cpu/hotplug: remove CPUHP_SLAB_PREPARE hooks
Message-ID: <202311132020.5A4B63D@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-27-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-27-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:46PM +0100, Vlastimil Babka wrote:
> The CPUHP_SLAB_PREPARE hooks are only used by SLAB which is removed.
> SLUB defines them as NULL, so we can remove those altogether.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h | 8 --------
>  kernel/cpu.c         | 5 -----
>  2 files changed, 13 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index d6d6ffeeb9a2..34e43cddc520 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -788,12 +788,4 @@ size_t kmalloc_size_roundup(size_t size);
>  
>  void __init kmem_cache_init_late(void);
>  
> -#if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
> -int slab_prepare_cpu(unsigned int cpu);
> -int slab_dead_cpu(unsigned int cpu);
> -#else
> -#define slab_prepare_cpu	NULL
> -#define slab_dead_cpu		NULL
> -#endif
> -
>  #endif	/* _LINUX_SLAB_H */
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9e4c6780adde..530b026d95a1 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2125,11 +2125,6 @@ static struct cpuhp_step cpuhp_hp_states[] = {
>  		.startup.single		= relay_prepare_cpu,
>  		.teardown.single	= NULL,
>  	},
> -	[CPUHP_SLAB_PREPARE] = {
> -		.name			= "slab:prepare",
> -		.startup.single		= slab_prepare_cpu,
> -		.teardown.single	= slab_dead_cpu,
> -	},
>  	[CPUHP_RCUTREE_PREP] = {
>  		.name			= "RCU/tree:prepare",
>  		.startup.single		= rcutree_prepare_cpu,

Should CPUHP_SLAB_PREPARE be removed from the enum too?

-- 
Kees Cook

