Return-Path: <cgroups+bounces-394-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9C37EA9D4
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B77B20A9B
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC12CBA31;
	Tue, 14 Nov 2023 04:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WTsTTJRW"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0DFBA40
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:50:49 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F22011C
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:50:48 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5bdc185c449so3629593a12.0
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699937447; x=1700542247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSHaE/1GVg9mC1SVDtWharYt7nYPJBYXesltql5ggN0=;
        b=WTsTTJRWM6qWKzHmZhVNQCZsB9NUac7sFHmcctyh1H9ElRJmr42LNA+aPK9gxcPe7N
         PGG5PFJ0ZVR2N3ZcVKg/bgjlNCOqZeWjeooLq7kzVQxb+xQmEge5ank4tqAGl8Y7dt98
         0LFdwOA3GV/EcQ2s7Tg+bEe9jMGWJq3aYEUCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937447; x=1700542247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSHaE/1GVg9mC1SVDtWharYt7nYPJBYXesltql5ggN0=;
        b=ZnT7+96qz5I2OGPl1C7SHbf0zpxTOt9uEIt1tQ3N5l+j5+acLL1DapKfXeNzwEP850
         gNWwoBLKHjnTihfceZ/+pLiNe0MnLdaZSPEQ0LsK/zWeZUDetahvYa/Br834HqkzqoPZ
         PRwe3Se1c2v+WgE4jaTM92iqTk4T1ItgI06oQnl9kwXURhCOxBjjGj2Tpix3ZQvwRGgh
         qechYIvWThM7ZNCx/sqqDDzx5Osrnmtql8xaPuIAbcEbv7XzuETkpMgLMvtVH49d2KpV
         FsfZPpsFp/CIhyRRMTSfnpnMiUUaJ6fpNydIVz5fN18LlPQcP+wezEUT69QYdoAZ78Qc
         Sw2Q==
X-Gm-Message-State: AOJu0YxXpMwcBMiMhFq3udFDOKu8wRCnx4a9LIaZCOHcKhh6kb8VS2LX
	ydyOSlfHX8viC+hA0LEdEeoRJw==
X-Google-Smtp-Source: AGHT+IF7Byd1ljDiTcsJ0NghEeEEgnKHX0+3r+3s8w6VMPI04pb7VCutEUrPIzMWjcVxqsPNaM8wIg==
X-Received: by 2002:a17:902:8b85:b0:1cc:474d:bdf9 with SMTP id ay5-20020a1709028b8500b001cc474dbdf9mr1243778plb.36.1699937447538;
        Mon, 13 Nov 2023 20:50:47 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001c9db5e2929sm4875757pls.93.2023.11.13.20.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:50:47 -0800 (PST)
Date: Mon, 13 Nov 2023 20:50:46 -0800
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
Subject: Re: [PATCH 18/20] mm/slub: remove slab_alloc() and
 __kmem_cache_alloc_lru() wrappers
Message-ID: <202311132048.B3AADC400@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-40-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-40-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:59PM +0100, Vlastimil Babka wrote:
> slab_alloc() is a thin wrapper around slab_alloc_node() with only one
> caller.  Replace with direct call of slab_alloc_node().
> __kmem_cache_alloc_lru() itself is a thin wrapper with two callers,
> so replace it with direct calls of slab_alloc_node() and
> trace_kmem_cache_alloc().

I'd have a sense that with 2 callers a wrapper is still useful?

> 
> This also makes sure _RET_IP_ has always the expected value and not
> depending on inlining decisions.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> [...]
>  void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
>  {
> -	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
> +	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_,
> +				    s->object_size);
>  

Whitespace change here isn't mentioned in the commit log.

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

