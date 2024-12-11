Return-Path: <cgroups+bounces-5835-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2CD9ED81E
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 22:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3077F18843BD
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68671DDC28;
	Wed, 11 Dec 2024 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i/aHBbt/"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160286DCE1;
	Wed, 11 Dec 2024 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951320; cv=none; b=pQoPwyxl0+qvlyKtolD2iY87Irt4Li9wnfCD+Uwf0hRiAiq50khhf41X1V+8vBDDWTyYubToqL3ym/aCD4zGkW4sxUyrfq94KMlERRmkzQt32ndxtB21M+K9FbXqNNktA7yZXBd50t5uHVynpdFi6tJ+SkMxuOAnrU645oQnMaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951320; c=relaxed/simple;
	bh=UO3YXZW47gWv3SCpmfMBDpDp2RV79jQ3vkDyXRysnF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbEU96OGxX8UNosQ8FG7up+oISfF6halSxrG3+nnJKSiCvXgti1kN8ST9uLqyDMSkfOmvQmWN+PBzkZxd+HfMlLLUu5qlK7j17INF36ozdNYE2kZeQqJlAWRYHnNrrVehNBCXt655tw78bvfYiaiqvDSPIeTA4U3DVBHzDeo0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i/aHBbt/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T8mUFcmECrP/TteQEvTLst+33uFFcr5m63mDPK2C7ag=; b=i/aHBbt/A3ipc3S0CUjrXE02Ek
	NM/36ZwFnHhMum1HqAUvD7xs807eOMn8yDHD1fh18M0pFyfa8NhadZE74kGtjp56SssmS1rtri4aJ
	Ft0Kfp+SV7O8iEYAOBMf4uc0E9PLIj5kZlg13twWxFBBP521xpz2I6VUY5nkQyq3qG9TMngq0HZ25
	WlzHwno1loUFkGG2SUE6TdJa0emkxw5CGfsXpxzT4hyPQjtVfuPT9jLsJVzYPDKKKGRmtjfMrgPh7
	dWKwK3aJIr4JtTZ2TkOXLc/rOLayW/C3qYxg44s3fbQrkkupxUxsa3attNbnGxlKDVhsa6JWENx9z
	XTCoAcDg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLTwf-00000000v5U-3ApR;
	Wed, 11 Dec 2024 21:08:33 +0000
Date: Wed, 11 Dec 2024 21:08:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vmalloc: Account memcg per vmalloc
Message-ID: <Z1n_UXwvj27-AUHS@casper.infradead.org>
References: <20241211043252.3295947-1-willy@infradead.org>
 <20241211043252.3295947-2-willy@infradead.org>
 <20241211160956.GB3136251@cmpxchg.org>
 <Z1nC3138biX0J1DJ@casper.infradead.org>
 <keho5no2wg666yjtkb5lflxwezgbzavue5ytydqm7pm7w62ctt@q6zg7t56gf4b>
 <Z1n0FFZ_oMYKcUiP@casper.infradead.org>
 <3bgedgrbu73dovgcy2keqjud6jafqxenceihtyre2hkego7oyb@opc5u53jef5a>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bgedgrbu73dovgcy2keqjud6jafqxenceihtyre2hkego7oyb@opc5u53jef5a>

On Wed, Dec 11, 2024 at 12:58:36PM -0800, Shakeel Butt wrote:
> On Wed, Dec 11, 2024 at 08:20:36PM +0000, Matthew Wilcox wrote:
> > Umm, I don't think you know which vmalloc allocation a page came from
> > today?  I've sent patches to add that information before, but they were
> > rejected. 
> 
> Do you have a link handy for that discussion?

It's not really relevant any more ...

https://lore.kernel.org/linux-mm/20180518194519.3820-18-willy@infradead.org/

and subsequent discussion:

https://lore.kernel.org/linux-mm/20180611121129.GB12912@bombadil.infradead.org/

It all predates memdesc.

> Yes you are correct. At the moment it is a guesswork and exhaustive
> search into multiple sources.

At least I should be able to narrow it down somewhat if we have a
PGTY_vmalloc.

> > I actually want to improve this, without adding additional overhead.
> > What I'm working on right now (before I got waylaid by this bug) is:
> > 
> > +struct choir {
> > +       struct kref refcount;
> > +       unsigned int nr;
> > +       struct page *pages[] __counted_by(nr);
> > +};
> > 
> > and rewriting vmalloc to be based on choirs instead of its own pages.
> > One thing I've come to realise today is that the obj_cgroup pointer
> > needs to be in the choir and not in the vm_struct so that we uncharge the
> > allocation when the choir refcount drops to 0, not when the allocation
> > is unmapped.
> 
> What/who else can take a reference on a choir?

The first user is remap_vmalloc_range() which today takes a
mapcount+refcount on the page underlying the vmalloc inside
vm_insert_page().

But I see choirs being useful more widely; for example in the XFS buffer
cache (which wouldn't be mappable to userspace).  They might even be
the right approach for zswap, replacing zpdesc.  Haven't looked into
that in enough detail yet.


