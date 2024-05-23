Return-Path: <cgroups+bounces-2988-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83D8CD879
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 18:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185B8282468
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3781802E;
	Thu, 23 May 2024 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kD6t6TuK"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964BAD31
	for <cgroups@vger.kernel.org>; Thu, 23 May 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482080; cv=none; b=TE+kbGT3vjVUswAZOMifGLgSZdjPx7nMd5TM/L8pbo6l734WThjonXd2aWt5oydvQN3GzMyAb2yKi8LWsAPF6JEXQR9pGnc26LVHdx5D/cbnE1/q6XvgEzDSnhQzCgSGS1tDObeyBIt1jQzYtzfdwjkXZEIUnseZMYWBkjKkK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482080; c=relaxed/simple;
	bh=aK5+SGyKYywmUzzkW1pRwhegoUpcH+oUqnmZwfneXhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcVFx9KG3UUwEte9fUC0FwKjn0badTwY4QgJIDBexsAhdiwD7NvdHqFFFW6lvfw/3QYvc9JAB+3eaOHDlzKBExYtzoBkI4rxOlDnj10kVFKMLPL0hJNj5eUB4TUhwwh+nedyqSJJPVQDtZKNbQV+H0iyfx6N+SdH77D9sPpnQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kD6t6TuK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pvVUhdkQBWgNG2dQUY6+6EVmXCuxM2RW1Kdkxzfr6rU=; b=kD6t6TuK9Y75pFvCdBUFlcUBUw
	gUWIBDwCCjdYrQtBskgXS9vKNShsG4zloi8MIXkmzwcDRmbh5a8fvtja3aG8Ymw+JYTjQ+QKFx1HP
	ej4YPNNzLKgJufJKUxIULd1I/QkRjTb6E6UDHkIxpHPAU2Le7c8qLBOrdjFPyCyRwo3A8JWpTr5wE
	DCgJ9i+Gev9ZVdk0TkH8192imUGdMH/MNDNtnrVkvIE0K3h6LmzFe7bYnqVEQvajNL0ufCpS9SJO9
	e/Qsl8AiOuESKFrRYtn7Cte860f7hLfeGvUeCN1XVPwbJdiUh6eCMrBITdapaixSTm2lrNEJKzJXH
	ihNPmiWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sABOd-00000001tV2-1DPa;
	Thu, 23 May 2024 16:34:27 +0000
Date: Thu, 23 May 2024 17:34:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH] mm: memcontrol: remove page_memcg()
Message-ID: <Zk9wEybsnyo9dvYu@casper.infradead.org>
References: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
 <ZkyzRVe31WLaepSt@casper.infradead.org>
 <tcdr5cm3djarfeiwar6q7qvxjdgkb7r5pcb7j6pzqejnbslsgz@2pnnlbwmfzdu>
 <Zk9FGQUdcs8tqCbi@casper.infradead.org>
 <z6t4afo4h2oybrgtpeghohxamnaapcjhi54dexvzyflv4mpk56@xjkjq4jodtve>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z6t4afo4h2oybrgtpeghohxamnaapcjhi54dexvzyflv4mpk56@xjkjq4jodtve>

On Thu, May 23, 2024 at 08:41:25AM -0700, Shakeel Butt wrote:
> On Thu, May 23, 2024 at 02:31:05PM +0100, Matthew Wilcox wrote:
> > On Tue, May 21, 2024 at 12:29:39PM -0700, Shakeel Butt wrote:
> > > On Tue, May 21, 2024 at 03:44:21PM +0100, Matthew Wilcox wrote:
> > > > The memcg should not be attached to the individual pages that make up a
> > > > vmalloc allocation.  Rather, it should be managed by the vmalloc
> > > > allocation itself.  I don't have the knowledge to poke around inside
> > > > vmalloc right now, but maybe somebody else could take that on.
> > > 
> > > Are you concerned about accessing just memcg or any field of the
> > > sub-page? There are drivers accessing fields of pages allocated through
> > > vmalloc. Some details at 3b8000ae185c ("mm/vmalloc: huge vmalloc backing
> > > pages should be split rather than compound").
> > 
> > Thanks for the pointer, and fb_deferred_io_fault() is already on my
> > hitlist for abusing struct page.
> > 
> > My primary concern is that we should track the entire allocation as a
> > single object rather than tracking each page individually.  That means
> > assigning the vmalloc allocation to a memcg rather than assigning each
> > page to a memcg.  It's a lot less overhead to increment the counter once
> > per allocation rather than once per page in the allocation!
> > 
> > But secondarily, yes, pages allocated by vmalloc probably don't need
> > any per-page state, other than tracking the vmalloc allocation they're
> > assigned to.  We'll see how that theory turns out.
> 
> I think the tricky part would be vmalloc having pages spanning multiple
> nodes which is not an issue for MEMCG_VMALLOC stat but the vmap based
> kernel stack (CONFIG_VMAP_STACK) metric NR_KERNEL_STACK_KB cares about
> that information.

Yes, we'll have to handle mod_lruvec_page_state() differently since that
stat is tracked per node.  Or we could stop tracking that stat per node.
Is it useful to track it per node?  Why is it useful to track kernel
stacks per node, but not track vmalloc allocations per node?

