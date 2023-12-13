Return-Path: <cgroups+bounces-936-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7698114C0
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 15:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C081C21019
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCE62E857;
	Wed, 13 Dec 2023 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O4FVnkeJ"
X-Original-To: cgroups@vger.kernel.org
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 06:35:31 PST
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF1E3
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 06:35:31 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702477644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogqfjk94QmYjvUNgg1o+03IMu+upFqXEAelcw2m6BF0=;
	b=O4FVnkeJB8t1p7jQ/Sc19JPsioqfW2DVSaqvl+qsINAE708pWhnuzM9Z8qzAEZ+jRqLahz
	pl+Cu1s+PDdQv6AE3rF/9bNICB1kW2n30DcpR3L6KPJqEnxT2F3ocpVKG3VqHOhcwjjfg3
	AVAVilbG1Qp0jhhPXhkIxYY1clzxNuk=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] mm: memcg: remove direct use of
 __memcg_kmem_uncharge_page
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231213130414.353244-1-yosryahmed@google.com>
Date: Wed, 13 Dec 2023 22:26:50 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: 7bit
Message-Id: <6F87D2CF-42AB-4225-BCF0-3F25F38A643A@linux.dev>
References: <20231213130414.353244-1-yosryahmed@google.com>
To: Yosry Ahmed <yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT



> On Dec 13, 2023, at 21:04, Yosry Ahmed <yosryahmed@google.com> wrote:
> 
> memcg_kmem_uncharge_page() is an inline wrapper around
> __memcg_kmem_uncharge_page() that checks memcg_kmem_online() before
> making the function call. Internally, __memcg_kmem_uncharge_page() has a
> folio_memcg_kmem() check.
> 
> The only direct user of __memcg_kmem_uncharge_page(),
> free_pages_prepare(), checks PageMemcgKmem() before calling it to avoid
> the function call if possible. Move the folio_memcg_kmem() check from
> __memcg_kmem_uncharge_page() to memcg_kmem_uncharge_page() as
> PageMemcgKmem() -- which does the same thing under the hood. Now
> free_pages_prepare() can also use memcg_kmem_uncharge_page().
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks


