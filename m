Return-Path: <cgroups+bounces-378-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8557EA95D
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F18F6B20A23
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AADA8F76;
	Tue, 14 Nov 2023 04:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k7ax4ATw"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D99474
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:11:46 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8D8D56
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:11:44 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1efad296d42so3133668fac.2
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699935103; x=1700539903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+4yq4rGlFBGUUVelo6loa8LJ3whEhAhDSYlb9+Og4U=;
        b=k7ax4ATw7ENKQBKTpFzkjNtDZUnumXdMkial8xKCs96XtVKludT0CtZYqUdBtBNMfL
         YomvUhi3dRzEHyhlXoDdtwOaqMvL8rqJDCRVaqwhqKFO6WKSMOS5j89kqW1ut2UvvzL1
         B1F++JKGqsaTwrerq5gIgSCG2k+syxVp8AeEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699935103; x=1700539903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+4yq4rGlFBGUUVelo6loa8LJ3whEhAhDSYlb9+Og4U=;
        b=ZcQY4Oby9anmgnGgArS7gzerlFS7BztXd4/DzMwb5DeamAr4hUbCWuf3OTYbSig1m0
         i08ynP9S513ZNJMV6R+wRJJ1lthUmBEhHyVYp4U0Tn4UYE/RKeILqsgLnTpLXo0t5EmD
         xy/EOMYs1GrE+Vy2Ds4XA9qXH5MzjtCeQnrbCxhfQX1vb3bEBBW0VucMKp/M0lUtnIKT
         ng+AM/iXSOqkGXd3cdtfeZBKyOlp42kZVluzbiZHIu6WKBTV13MD4EHPKXmTAVIPoXMP
         sT7aYehAh1ZF5JYen6rQUt9KqJlnYAKYicROeAVFIdwXWvS+rjGfpWI0uh7O6s58gYSE
         HTqA==
X-Gm-Message-State: AOJu0Yzujesy7S69ywhGho2MKNUvxclrzdOKv/74/z9o7AyIDgc/vP9B
	GSwpVZy6QCUx2+YVwa+32BTWdA==
X-Google-Smtp-Source: AGHT+IEfNarlWdnfTnb+4lj9a61ndeE58KtCzt4cIWOf0C0hGaQoDCR9asaBxInqDvXXBZ8V8HT8ig==
X-Received: by 2002:a05:6870:b155:b0:1ef:62fc:d51c with SMTP id a21-20020a056870b15500b001ef62fcd51cmr10394447oal.51.1699935102819;
        Mon, 13 Nov 2023 20:11:42 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fz10-20020a17090b024a00b00268b439a0cbsm4292411pjb.23.2023.11.13.20.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:11:42 -0800 (PST)
Date: Mon, 13 Nov 2023 20:11:41 -0800
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
Subject: Re: [PATCH 01/20] mm/slab: remove CONFIG_SLAB from all Kconfig and
 Makefile
Message-ID: <202311132009.8329C2F5D@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-23-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-23-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:42PM +0100, Vlastimil Babka wrote:
> Remove CONFIG_SLAB, CONFIG_DEBUG_SLAB, CONFIG_SLAB_DEPRECATED and
> everything in Kconfig files and mm/Makefile that depends on those. Since
> SLUB is the only remaining allocator, remove the allocator choice, make
> CONFIG_SLUB a "def_bool y" for now and remove all explicit dependencies
> on SLUB as it's now always enabled.
> 
> Everything under #ifdef CONFIG_SLAB, and mm/slab.c is now dead code, all
> code under #ifdef CONFIG_SLUB is now always compiled.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> [...]
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 89971a894b60..766aa8f8e553 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -228,47 +228,12 @@ config ZSMALLOC_CHAIN_SIZE
>  
>  menu "SLAB allocator options"

Should this be "Slab allocator options" ? (I've always understood
"slab" to mean the general idea, and "SLAB" to mean the particular
implementation.

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

