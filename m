Return-Path: <cgroups+bounces-11939-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9324C59FAF
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 21:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 133AF355A22
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 20:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F0313296;
	Thu, 13 Nov 2025 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cmim2kzQ"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C472F99A5
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066042; cv=none; b=oiZvHTwIXAYrc0V7eDZTO7XiCU9T6nH66OSGogqXX9H/lbw893ypTJpV+1y7fM/zogzIrydZwcdxhYEbJLiH7oT+90Vilq6H51FZKQJZ5isoqm+hmVcwNyD6YkYYYTSIGlw59yQWtgSuoCjtJZ0OMi2EwMiGmMQnfRvL90r8wlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066042; c=relaxed/simple;
	bh=q2EDMffkAFz5lv7El2cy5oFEZpr4qPO/NDk+VQ0iBvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWOoY/wfHm0O1j8ZLhd2dVyLcevRiIFNujuGf9I5mFL4sFgefY+Tb7eAnUQgxVo0j1Pvx9ApQsD7FbDi96vojWwpoFKPhylcuhf+mXR/N1N7Bsw8c9hg6Oc7QlnQI0eFFF/VOmEgqTZGsxX0uCuqbQZpfy5H5SJ1I7dqgXerDNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cmim2kzQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F8BIpsc6+IG97yFUh0oeZRhXpi55aHBEN/P7F13sLV4=; b=Cmim2kzQ/sW4COWLNLD/lKBLQv
	2MktANiZv8HebBFP0xpU2qKed8TiPtexeMWOZ2MU/K/eJZrML5yDAn2gWrpTaVRK3KQ2caJFgtPB2
	Ezeu3WF06JgYLUNQzucFZluyRU4eXRCwWKB4/rhlUBljeM15gfjkR6tHm3eES6UMShexgB6hSLDta
	/UPKXtKmgTqB+vRjnhrxsgqUaWd5qmUIx01RbfDijpRQoYH7mTf5VFE6PGqvZ1r9qtp3inSXM3tSU
	KwLHCFGzL0jFUYwRTUTf8HPsrTJYq8+GIYNJI0uG/AaPm/OiZ4Bqh5tijH0wMZHkLBsMq7llZAub7
	+JfxJtvg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJe0s-000000086x7-3brw;
	Thu, 13 Nov 2025 20:33:50 +0000
Date: Thu, 13 Nov 2025 20:33:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 14/16] memcg: Convert mem_cgroup_from_obj_folio() to
 mem_cgroup_from_obj_slab()
Message-ID: <aRZArvnUeXZulhuX@casper.infradead.org>
References: <20251113000932.1589073-1-willy@infradead.org>
 <20251113000932.1589073-15-willy@infradead.org>
 <20251113161424.GB3465062@cmpxchg.org>
 <45ea66a3-bf8b-4c12-89cd-d15ba26763fa@suse.cz>
 <offnmou66hzgrlbb7owyya6n4onn2g5iuv7matbqfvsigg6wv3@3hlu55yai42z>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <offnmou66hzgrlbb7owyya6n4onn2g5iuv7matbqfvsigg6wv3@3hlu55yai42z>

On Thu, Nov 13, 2025 at 11:42:01AM -0800, Shakeel Butt wrote:
> On Thu, Nov 13, 2025 at 05:28:59PM +0100, Vlastimil Babka wrote:
> > > E.g. !vmap kernel stack pages -> mod_lruvec_kmem_state -> mem_cgroup_from_obj_slab
> > > 
> > > How about:
> > > 
> > > 	if ((slab = virt_to_slap(p)))
> > > 		return mem_cgroup_from_obj_slab(slab, p);
> > > 	return folio_memcg_check(virt_to_folio(p), p);
> > 
> > page_memcg_check() maybe instead? we shouldn't get a tail page here, no?
> 
> Do you mean page_memcg_check(virt_to_page(p), p)? But virt_to_page(p)
> can return tail page, right?

Only if it's legitimate to call mod_lruvec_kmem_state() with "a pointer
to somewhere inside the object" rather than "a pointer to the object".

For example, it's legitimate to call copy_to_user() with a pointer
somewhere inside the object, so the usercopy code has to handle that
case.  But it's only legitimate to call kfree() with a pointer that's
at the start of an object, so kfree() can cheerfully BUG_ON()
PageTail(virt_to_page(p)).

