Return-Path: <cgroups+bounces-937-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCAD81157D
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 16:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5571C21052
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF982F849;
	Wed, 13 Dec 2023 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wTeEIfYu"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912FCA0
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 07:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uSpzskSxj2X/kHA/iIDZHiWRnQDxjXrWl7oGiwPBvpo=; b=wTeEIfYuCmWSRM58ytXknZCac7
	/MGb969f+q7LJh6ZcPqRwZZOIYFto0hWOqKnB2rJYFj1yGNnCdvvWMeGLND8qgvYdEAGDsKcViEpG
	AQ6tcMPE1LDGSrAnvozhFrcUvh0YmSBgZuHp/car7Y+9hAxledyT/WQl4Vk26HGwZMJa7DUi1R81m
	dHNFGVgwXlgN194GCnkTlS8MhrS1zLDT8acLWLs5K5E0Os5CfbhsC6J21EwQu4P3dKiOfvsnIQWfz
	o+5/iTitK/62zkO2ABoTEHXQMw1UDuE0VWoy4sigUgXjYfpkij4MPuEXvKfMde3wKBGDFjpqGBmE1
	pouWFVEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rDQjo-0020VS-Mp; Wed, 13 Dec 2023 15:01:28 +0000
Date: Wed, 13 Dec 2023 15:01:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: remove direct use of
 __memcg_kmem_uncharge_page
Message-ID: <ZXnHSPuaVW913iVZ@casper.infradead.org>
References: <20231213130414.353244-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213130414.353244-1-yosryahmed@google.com>

On Wed, Dec 13, 2023 at 01:04:14PM +0000, Yosry Ahmed wrote:
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

I think you've just pessimised all the other places which call
memcg_kmem_uncharge_page().  It's a matter of probabilities.  In
free_pages_prepare(), most of the pages being freed are not accounted
to memcg.  Whereas in fork() we are absolutely certain that the pages
were accounted because we accounted them.

I think this is a bad change.

