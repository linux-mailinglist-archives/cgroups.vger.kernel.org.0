Return-Path: <cgroups+bounces-286-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8F67E7067
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 18:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58BA281070
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA171225D6;
	Thu,  9 Nov 2023 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PaadGnZh"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F422335
	for <cgroups@vger.kernel.org>; Thu,  9 Nov 2023 17:36:34 +0000 (UTC)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [IPv6:2001:41d0:203:375::b6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07E7D58
	for <cgroups@vger.kernel.org>; Thu,  9 Nov 2023 09:36:33 -0800 (PST)
Date: Thu, 9 Nov 2023 09:36:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699551391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6q76AbBJRV3A5UzRYYTovtVdqujVhe1G1oS+g4WJ7E=;
	b=PaadGnZhpplFNAjZ8I71usdqW3bhffkUTjLi4m2Dhu4VpWyz7Ja+0vG9RB6AC182J+3qOu
	Qj5hCIjP3rZ5PswxcgVWC1sjFLk4cbpnTHboFcU6Y74f7wiXEgmLxK9TrnVUDiIMdnEZtX
	HsHSOaOZdGtp4ZKaOJPfjCbXuR1ktwU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeelb@google.com>
Cc: Michal Hocko <mhocko@suse.com>, Christoph Lameter <cl@linux.com>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: cgroups: warning for metadata allocation with GFP_NOFAIL (was
 Re: folio_alloc_buffers() doing allocations > order 1 with GFP_NOFAIL)
Message-ID: <ZU0YmuhMkqvGnPYl@P9FQF9L96D.corp.robot.car>
References: <6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org>
 <ZUIHk+PzpOLIKJZN@casper.infradead.org>
 <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>
 <ZUp8ZFGxwmCx4ZFr@P9FQF9L96D.corp.robot.car>
 <t4vlvq3f5owdqr76ut3f5yk35jwyy76pvq4ji7zze5aimgh3uu@c2b5mmr4eytv>
 <CALvZod4yTfqk9u6AmTyk9HZyGQOh0GTLLN6f0gHWy3WNKCm-vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod4yTfqk9u6AmTyk9HZyGQOh0GTLLN6f0gHWy3WNKCm-vw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 08, 2023 at 10:37:00PM -0800, Shakeel Butt wrote:
> On Wed, Nov 8, 2023 at 2:33 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 07-11-23 10:05:24, Roman Gushchin wrote:
> > > On Mon, Nov 06, 2023 at 06:57:05PM -0800, Christoph Lameter wrote:
> > > > Right.. Well lets add the cgoup folks to this.
> > >
> > > Hello!
> > >
> > > I think it's the best thing we can do now. Thoughts?
> > >
> > > >From 5ed3e88f4f052b6ce8dbec0545dfc80eb7534a1a Mon Sep 17 00:00:00 2001
> > > From: Roman Gushchin <roman.gushchin@linux.dev>
> > > Date: Tue, 7 Nov 2023 09:18:02 -0800
> > > Subject: [PATCH] mm: kmem: drop __GFP_NOFAIL when allocating objcg vectors
> > >
> > > Objcg vectors attached to slab pages to store slab object ownership
> > > information are allocated using gfp flags for the original slab
> > > allocation. Depending on slab page order and the size of slab objects,
> > > objcg vector can take several pages.
> > >
> > > If the original allocation was done with the __GFP_NOFAIL flag, it
> > > triggered a warning in the page allocation code. Indeed, order > 1
> > > pages should not been allocated with the __GFP_NOFAIL flag.
> > >
> > > Fix this by simple dropping the __GFP_NOFAIL flag when allocating
> > > the objcg vector. It effectively allows to skip the accounting of a
> > > single slab object under a heavy memory pressure.
> >
> > It would be really good to describe what happens if the memcg metadata
> > allocation fails. AFAICS both callers of memcg_alloc_slab_cgroups -
> > memcg_slab_post_alloc_hook and account_slab will simply skip the
> > accounting which is rather curious but probably tolerable (does this
> > allow to runaway from memcg limits). If that is intended then it should
> > be documented so that new users do not get it wrong. We do not want to
> > error ever propagate down to the allocator caller which doesn't expect
> > it.
> 
> The memcg metadata allocation failure is a situation kind of similar
> to how we used to have per-memcg kmem caches for accounting slab
> memory. The first allocation from a memcg triggers kmem cache creation
> and lets the allocation pass through.
> 
> >
> > Btw. if the large allocation is really necessary, which hasn't been
> > explained so far AFAIK, would vmalloc fallback be an option?
> >
> 
> For this specific scenario, large allocation is kind of unexpected,
> like a large (multi-order) slab having tiny objects. Roman, do you
> know the slab settings where this failure occurs?

No, I hope Christoph will shed some light here.

> Anyways, I think kvmalloc is a better option. Most of the time we
> should have order 0 allocation here and for weird settings we fallback
> to vmalloc.

I'm not sure about kvmalloc, because it's not fast.
I think the better option would be to force the slab allocator to fall back
to order-0 pages. Theoretically, we don't even need to free and re-allocate
slab objects, but break the slab folio into pages and release all but first
page.

But I'd like to learn more about the use case before committing any time
into this effort.

Thanks!

