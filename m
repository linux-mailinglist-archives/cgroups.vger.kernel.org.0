Return-Path: <cgroups+bounces-948-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CF1811FEE
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 21:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB9D28268E
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 20:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47D17E56E;
	Wed, 13 Dec 2023 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D8qVKtWz"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F58E8
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 12:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=EzlB/43el/VrIkuquoM6aTBQ8QwT/OicCQ4lPZjUMvw=; b=D8qVKtWz3cgbsiAIjWU6UIIOyh
	dJE/yQCyEZIimgSiurlrZZG6Kby+3V/PUSlf/uMyryJg9VAOsZqUW25QzF+HO5ETI+NVsR9P/YFDz
	mR46KCwmMcD/dJRRCvQMPFiG79+na3PLCjY6kgGGz1ApFhDzoZeP7Z3OhYaZig+eMFLGBWYaXHO2j
	NT7i3O9ctYvO+7GoHA4qlcP/eOn5tpVA9sAcDm6h64SQSGUaZh0pjpCR8ws+usMWxlZ6Mu9fUSujY
	vC2U7tWQu4wqyG8Nrptos/lnylAawlJLzJgk6jW0cRzvP/c2+M1nZN50yWAdElhogNew6OMyvNHiX
	t7/Dl6yA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rDVox-002eoA-LS; Wed, 13 Dec 2023 20:27:07 +0000
Date: Wed, 13 Dec 2023 20:27:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: remove direct use of
 __memcg_kmem_uncharge_page
Message-ID: <ZXoTmwIiBoeLItlg@casper.infradead.org>
References: <20231213130414.353244-1-yosryahmed@google.com>
 <ZXnHSPuaVW913iVZ@casper.infradead.org>
 <CAJD7tkbuyyGNjhLcZfzBYBX+BSUCvBbMpUPyzgHcRPTM4jL9Gg@mail.gmail.com>
 <ZXnQCaficsZC2bN4@casper.infradead.org>
 <CAJD7tkY8xxfYFuP=4vFm7A+p7LqUEzdcFdPjhogccGPTjqsSKg@mail.gmail.com>
 <ZXnabMOjwASD+RO9@casper.infradead.org>
 <CAJD7tkaUGw9mo88xSiTNhVC6EKkzvaJOh=nOwY6WYcG+skQynQ@mail.gmail.com>
 <ZXnbZlrOmrapIpb4@casper.infradead.org>
 <CAJD7tkbjNZ=16vj4uR3BVeTzaJUR2_PCMs+zF_uT+z+DYpaDZw@mail.gmail.com>
 <20231213202325.2cq3hwpycsvxcote@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213202325.2cq3hwpycsvxcote@google.com>

On Wed, Dec 13, 2023 at 08:23:25PM +0000, Shakeel Butt wrote:
> On Wed, Dec 13, 2023 at 08:31:00AM -0800, Yosry Ahmed wrote:
> > On Wed, Dec 13, 2023 at 8:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 08:24:04AM -0800, Yosry Ahmed wrote:
> > > > I doubt an extra compound_head() will matter in that path, but if you
> > > > feel strongly about it that's okay. It's a nice cleanup that's all.
> > >
> > > i don't even understand why you think it's a nice cleanup.
> > 
> > free_pages_prepare() is directly calling __memcg_kmem_uncharge_page()
> > instead of memcg_kmem_uncharge_page(), and open-coding checks that
> > already exist in both of them to avoid the unnecessary function call
> > if possible. I think this should be the job of
> > memcg_kmem_uncharge_page(), but it's currently missing the
> > PageMemcgKmem() check (which is in __memcg_kmem_uncharge_page()).
> > 
> > So I think moving that check to the wrapper allows
> > free_pages_prepare() to call memcg_kmem_uncharge_page() and without
> > worrying about those memcg-specific checks.
> 
> There is a (performance) reason these open coded check are present in
> page_alloc.c and that is very clear for __memcg_kmem_charge_page() but
> not so much for __memcg_kmem_uncharge_page(). So, for uncharge path,
> this seems ok. Now to resolve Willy's concern for the fork() path, I
> think we can open code the checks there.
> 
> Willy, any concern with that approach?

The justification for this change is insufficient.  Or really any change
in this area.  It's fine the way it is.  "The check is done twice" is
really weak, when the check is so cheap (much cheaper than calling
compound_head!)

