Return-Path: <cgroups+bounces-939-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39A58117B0
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 16:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD4A1C20D21
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0479439FD7;
	Wed, 13 Dec 2023 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KiWNyqVB"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC357B2
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 07:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=QobYSO51P2Wrjk2wRDM8RxMWvXuI42DNWf4jasUKNQE=; b=KiWNyqVBWLQgHMpuacLavf22oW
	avBVky0N34TI9Es116vv8YjmoICxPpZW4+bufDyBA67TCcZj9TSvwwxwXygB+fNSA+HnhhJO7piEF
	Bykkn5qiQ79/SvllVE6zbTCVCVc8p1B0lkJuM2rbMbthqqBglps3DLSUTZJb3ZWCFm84+9UUnxZ9j
	h3CmKD5g+k/EYuyredXCRszBDk5JFRQCiSxmf1GFpo+3EHUqN7wN72P9jvWtM539mDHiVXqTXiech
	TLU7XaoiiQwNkplnJVUPK87hvg/OQVRiKIraV1BzFbEaCJiInX4ke8hh7daE4o22d5Uiv0KIxo9KA
	BccMb0PA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rDRJx-0025qn-IB; Wed, 13 Dec 2023 15:38:49 +0000
Date: Wed, 13 Dec 2023 15:38:49 +0000
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
Message-ID: <ZXnQCaficsZC2bN4@casper.infradead.org>
References: <20231213130414.353244-1-yosryahmed@google.com>
 <ZXnHSPuaVW913iVZ@casper.infradead.org>
 <CAJD7tkbuyyGNjhLcZfzBYBX+BSUCvBbMpUPyzgHcRPTM4jL9Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbuyyGNjhLcZfzBYBX+BSUCvBbMpUPyzgHcRPTM4jL9Gg@mail.gmail.com>

On Wed, Dec 13, 2023 at 07:08:52AM -0800, Yosry Ahmed wrote:
> On Wed, Dec 13, 2023 at 7:01 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Dec 13, 2023 at 01:04:14PM +0000, Yosry Ahmed wrote:
> > > memcg_kmem_uncharge_page() is an inline wrapper around
> > > __memcg_kmem_uncharge_page() that checks memcg_kmem_online() before
> > > making the function call. Internally, __memcg_kmem_uncharge_page() has a
> > > folio_memcg_kmem() check.
> > >
> > > The only direct user of __memcg_kmem_uncharge_page(),
> > > free_pages_prepare(), checks PageMemcgKmem() before calling it to avoid
> > > the function call if possible. Move the folio_memcg_kmem() check from
> > > __memcg_kmem_uncharge_page() to memcg_kmem_uncharge_page() as
> > > PageMemcgKmem() -- which does the same thing under the hood. Now
> > > free_pages_prepare() can also use memcg_kmem_uncharge_page().
> >
> > I think you've just pessimised all the other places which call
> > memcg_kmem_uncharge_page().  It's a matter of probabilities.  In
> > free_pages_prepare(), most of the pages being freed are not accounted
> > to memcg.  Whereas in fork() we are absolutely certain that the pages
> > were accounted because we accounted them.
> 
> The check was already there for other callers, but it was inside
> __memcg_kmem_uncharge_page(). IIUC, the only change for other callers
> is an extra call to compound_head(), and they are not hot paths AFAICT
> so it shouldn't be noticeable.

How can you seriously claim that fork() is not a hot path?

> Am I missing something? Perhaps your point is about how branch
> prediction works across function call boundaries? or is this not about
> performance at all?
> 
> >
> > I think this is a bad change.

