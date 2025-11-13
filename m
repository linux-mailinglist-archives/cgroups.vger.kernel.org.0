Return-Path: <cgroups+bounces-11940-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A915C5A3F5
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 22:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E37C83549DB
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E3322C63;
	Thu, 13 Nov 2025 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D6KMKAFn"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02B311C30
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070862; cv=none; b=EPxQSYGZjpAwyxPU7ieegahgUP+N2bPUnRoee4+ayIns6L8XOLdqsVNAIrkzTvaGRDKc/Jw+hKqvfjX3oUOmBIDJ7MAwmSLMs4j43EiyFsgu0vJ/6h90jyyfzw+CEtqMF6VAa6ZA+0YCwedInLf+vItbZshasSMfG67kWSZDRz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070862; c=relaxed/simple;
	bh=lbOwiPeCKj4KfU+hhjzJMG15OnbkfXob1K4vXj1P6LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZAqjNXHrCtAl1YUs5GocBYw0xPF/0QwjrUwgUQiRt9uV7RSRK4GI1ds54QmawE2W4Ll5jeskWF3TVIVcjviWhDGeT7CeOw1MHH9xBa6uhIDZDTGTn6CuZ4GTC5GBDT0bZkLrzuBVVUv0MguZ9dY5U90yR2jfB+J5UyA5vgykj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D6KMKAFn; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Nov 2025 13:54:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763070855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kiz+P4KoRR6ufskB37zeO1ETp3EAe+922ChTRKXxN74=;
	b=D6KMKAFnhdOuctgrlWsqFPmC1nHzSBU4Y8FjytaHX982niEl14tOHlsQUznR6dXGgTmyBE
	uEG4lUy5HO4Jd5CfGiNaIqaOurNRgsR6yKp65jpIkFWE9jl8qB6AhgDor2G6Wa46lxkaXr
	XfcagihPx5of3JnZnSRh4zsrzdrkDOs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 14/16] memcg: Convert mem_cgroup_from_obj_folio() to
 mem_cgroup_from_obj_slab()
Message-ID: <72bs7m3juclmj6beuakzkoka2n5vej22qnrxnzsumqfkyfkk2r@gfoxlh4innwk>
References: <20251113000932.1589073-1-willy@infradead.org>
 <20251113000932.1589073-15-willy@infradead.org>
 <20251113161424.GB3465062@cmpxchg.org>
 <45ea66a3-bf8b-4c12-89cd-d15ba26763fa@suse.cz>
 <offnmou66hzgrlbb7owyya6n4onn2g5iuv7matbqfvsigg6wv3@3hlu55yai42z>
 <aRZArvnUeXZulhuX@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRZArvnUeXZulhuX@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 13, 2025 at 08:33:50PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 13, 2025 at 11:42:01AM -0800, Shakeel Butt wrote:
> > On Thu, Nov 13, 2025 at 05:28:59PM +0100, Vlastimil Babka wrote:
> > > > E.g. !vmap kernel stack pages -> mod_lruvec_kmem_state -> mem_cgroup_from_obj_slab
> > > > 
> > > > How about:
> > > > 
> > > > 	if ((slab = virt_to_slap(p)))
> > > > 		return mem_cgroup_from_obj_slab(slab, p);
> > > > 	return folio_memcg_check(virt_to_folio(p), p);
> > > 
> > > page_memcg_check() maybe instead? we shouldn't get a tail page here, no?
> > 
> > Do you mean page_memcg_check(virt_to_page(p), p)? But virt_to_page(p)
> > can return tail page, right?
> 
> Only if it's legitimate to call mod_lruvec_kmem_state() with "a pointer
> to somewhere inside the object" rather than "a pointer to the object".
> 
> For example, it's legitimate to call copy_to_user() with a pointer
> somewhere inside the object, so the usercopy code has to handle that
> case.  But it's only legitimate to call kfree() with a pointer that's
> at the start of an object, so kfree() can cheerfully BUG_ON()
> PageTail(virt_to_page(p)).

Yes it makes sense. Though for slab objects we are allowing to pass any
address within the object (address of list_head for list_lru) to
mem_cgroup_from_slab_obj() (and thus mod_lruvec_kmem_state()) but for
normal kernel memory, if we use virt_to_page() then we will restrict to
the starting address. Anyways just noticed this pecularity, not
suggesting to do anything differently.

