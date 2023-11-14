Return-Path: <cgroups+bounces-377-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B87EA957
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF7C1F23D7A
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF52947E;
	Tue, 14 Nov 2023 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OfNKxU32"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4338F76
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:07:31 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908F9D0
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:07:30 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso4049718b3a.0
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699934850; x=1700539650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGZDmoEeCuoU4ORpnmk9KfAQBb9nHs+S5VafgrXpLog=;
        b=OfNKxU322KZVjePI1loy34wSlGlIKMBmDmy99ZOFtq4ztAVQq4NX54XXXzwcAsbI9G
         FbNPsBy+4IXbY9XPuyIc/HyafVB5Il5Xh94msMqXDmOuca4YNNJjP03kUCSWksg5GaV6
         P7vIjnV0EiZE9e0iruk+nA7B2LHuo1R10Uhmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699934850; x=1700539650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGZDmoEeCuoU4ORpnmk9KfAQBb9nHs+S5VafgrXpLog=;
        b=g6f8n5UUQV14EA7m1EIXQQnEd7pKFod04P0FX3rClyDkN102FlvbTwTpck6Y3LVaXh
         pqtcgced57vE0Ktl2NNST90zv2nJtEyttQcH1tqygUnvEerOKqHCdwM8Nsx4zJzeavXG
         VfQEHWeX+6S7LgqpOYRt4ieVYkogTLcQoML2dzc5IaaVglRTkh8X7vow6sgudNKiLlxP
         +PSK/ciCnbis47funU7W0QPs1tku0+MhWppPGdUXWjGKBO8YVQgaIeuRPFN4kiwPnZGX
         W4DuqILmDBDMj/PrDQRoMv/2x+BBeKiJpzOQPqMZfGPgFz53EA+nMOcWuNPC8Ne/1eoo
         SqIQ==
X-Gm-Message-State: AOJu0YxaA2XzkqAmrbcx+m97sAhrmYKgsK0pCp2Km5WvT+JsGn9ByLnu
	EUmzr5E3E7FKy6F0xZ6uRD01ZA==
X-Google-Smtp-Source: AGHT+IFyU2MADg9EleoYCMTUi5z42Da4Qrzy3K4tyZn3glXnx25v+sXlqweMXpTqFAPp362Amxy4Qg==
X-Received: by 2002:a05:6a20:6a04:b0:186:7988:c747 with SMTP id p4-20020a056a206a0400b001867988c747mr4329657pzk.19.1699934850013;
        Mon, 13 Nov 2023 20:07:30 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903024f00b001c62b9a51a4sm4782100plh.239.2023.11.13.20.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:07:29 -0800 (PST)
Date: Mon, 13 Nov 2023 20:07:28 -0800
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
Subject: Re: [PATCH 16/20] mm/slab: move kmalloc_slab() to mm/slab.h
Message-ID: <202311132006.51222C473@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-38-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-38-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:57PM +0100, Vlastimil Babka wrote:
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
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Yeah, removing the redundant size checks does make this nicer to look at. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

