Return-Path: <cgroups+bounces-393-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320BB7EA9CA
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBAB1C20A03
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7DEB660;
	Tue, 14 Nov 2023 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cel19IJ6"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A769453
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:46:38 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CA11BE
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:46:37 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso4033609b3a.1
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699937196; x=1700541996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0a8u4z+DUq7pMxicKnRyBLDUEkYlUYGe8Ef1Qv3STI=;
        b=cel19IJ6thEKGn5xpXKFx0GFgYtOeYvhUw0MGwECop0oYc7BchqusuSFZTcMdqb55q
         SST55fvZdi02plEDuyK1DPl84RpjLx/cjq1RvM+OpVnkMPDwHilgYcQYtP+6wyfkq06p
         YeuFnQPSpWGXbHo4j4XL8CnB1jvPEw3erEwgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937196; x=1700541996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0a8u4z+DUq7pMxicKnRyBLDUEkYlUYGe8Ef1Qv3STI=;
        b=w7Lg2GgwnXCm2vwtxGUYp4slPvKSiYGWnYEU92JkOtoSlsueL99TuZKYK/0Ficf0tz
         idwdNxo5WDL8OaoXmiYiCThFrXTje+6+TafY/JGaIxdGgBVndpeGaVdwpReQgwZjsGvM
         PPaVipMUA28ngur0MCxIgUdnvZ3NV6Rwq50rzvJpEKEwwZJSdiP+xn3T5DfnYN512+uQ
         REoC8HpZvBLcRajxJaF03IlDjics2/E+7HDbVxAu2R5qP1v5kPz4U9N2lceA/3qsxNk5
         gMxAsMBXUIGTGMsh0J+IyIoh+vqeQvWpPEeDpW47CIBQXGmbJ1nJdXx7Rssw/F6wq0zu
         zOdQ==
X-Gm-Message-State: AOJu0YybIh9P2jsFy5VbAGOOma4i2QY8/x/E12dy5Op+0qcnpQJMimXP
	AKinXau72ZWiiJs8dUsCvVMpTA==
X-Google-Smtp-Source: AGHT+IGNQdjS2HSond40o2DEZuHcrsmwjNSXJJ6Otl8qWeHwrNfDjHKKQYMlq6qPVUmTUbyDR3kjJg==
X-Received: by 2002:a05:6a20:6a1c:b0:181:7d6d:c10b with SMTP id p28-20020a056a206a1c00b001817d6dc10bmr2434042pzk.7.1699937196532;
        Mon, 13 Nov 2023 20:46:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id hy13-20020a056a006a0d00b006c7ca969858sm398052pfb.82.2023.11.13.20.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:46:36 -0800 (PST)
Date: Mon, 13 Nov 2023 20:46:35 -0800
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
Subject: Re: [PATCH 17/20] mm/slab: move kmalloc() functions from
 slab_common.c to slub.c
Message-ID: <202311132046.04096EE39B@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-39-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-39-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:58PM +0100, Vlastimil Babka wrote:
> This will eliminate a call between compilation units through
> __kmem_cache_alloc_node() and allow better inlining of the allocation
> fast path.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

