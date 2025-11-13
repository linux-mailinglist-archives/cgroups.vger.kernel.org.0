Return-Path: <cgroups+bounces-11934-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD87C59034
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379294A1866
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBD9363C47;
	Thu, 13 Nov 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FDOUAK+Z"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE463624DF
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051996; cv=none; b=Kp9XceIjcq5qN6hdlyc1VfutgxVoPzpteeGDbB1KE9DK398ZEuT8fJPZh+Eg4GPWc/XFf/Pgaxqkg1kIFn1Jgmfr6VjvmD1XNuLJLMG8Ri/d+UK+FpYiF7nBDVChlaGdAkCCTzfQYWM3ZCG3bAV+DIYBdmFuRNCqzsr5JlsqTZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051996; c=relaxed/simple;
	bh=wQ0Jv6CZBwc4VwDi4uwmBPUwc/jwLEKPgHh7BMKik+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKSlQm2D2cILB2EQnhGLGvBrFUbirgPQ5u2yN0vaJlvKruTk4U5MGAdnG8N+LwgOyEPXxD5kLtpBFWdUPcEKtzSQlDPXx3WaOHH2hUh9GWyyXJfgK8JOsjMx8hlZQahB0Jl9yJimfH8c9fY1hfk4bE5DGZbe3o14yFBZO1P6fj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FDOUAK+Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KWiuhOrKURFpDF1jEF6HDs7VsJ1uOu4RR59xEAk1d1I=; b=FDOUAK+Z6YcXPnG3ObMXyYfXyu
	pqX9OEVNzDjCVhE7Q6ZtgKXR8HhZY5Wn5qUpkAAeElMhXJZtktRJaQy7bjPuIQ8yot2uMVu3VheQ9
	7KC6hUJ4UtLhDw/jUPAGtDN0657kI0ZMcCLJArV30LN0fyZAUNqDeR9Q3KVetqPqOy1BrdAVvPTJw
	DsMw8gAT5540Qhv7dm7yVJ6SJkti2PK/6Mofbg4FvwTm/n8JX03y/lxiFTa1UsHTlL2aI/XmJxkTX
	fL9a6wmIUwvChVwqoY4b25w8Oa4LPBo4705Eeq3/vLv+orFaQ0yFS08Qz6X0db5M1/F88omJBehbY
	IviTwLNg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJaMH-00000007oHL-0pG0;
	Thu, 13 Nov 2025 16:39:41 +0000
Date: Thu, 13 Nov 2025 16:39:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 14/16] memcg: Convert mem_cgroup_from_obj_folio() to
 mem_cgroup_from_obj_slab()
Message-ID: <aRYJzbZpd-UP3jh9@casper.infradead.org>
References: <20251113000932.1589073-1-willy@infradead.org>
 <20251113000932.1589073-15-willy@infradead.org>
 <20251113161424.GB3465062@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113161424.GB3465062@cmpxchg.org>

On Thu, Nov 13, 2025 at 11:14:24AM -0500, Johannes Weiner wrote:
> On Thu, Nov 13, 2025 at 12:09:28AM +0000, Matthew Wilcox (Oracle) wrote:
> > -	/*
> > -	 * folio_memcg_check() is used here, because in theory we can encounter
> > -	 * a folio where the slab flag has been cleared already, but
> > -	 * slab->obj_exts has not been freed yet
> > -	 * folio_memcg_check() will guarantee that a proper memory
> > -	 * cgroup pointer or NULL will be returned.
> > -	 */
> > -	return folio_memcg_check(folio);
> > +	off = obj_to_index(slab->slab_cache, slab, p);
> > +	if (obj_exts[off].objcg)
> > +		return obj_cgroup_memcg(obj_exts[off].objcg);
> > +
> > +	return NULL;
> >  }
> >  
> >  /*
> > @@ -2637,7 +2627,7 @@ struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
> >  	if (mem_cgroup_disabled())
> >  		return NULL;
> >  
> > -	return mem_cgroup_from_obj_folio(virt_to_folio(p), p);
> > +	return mem_cgroup_from_obj_slab(virt_to_slab(p), p);
> 
> The name undoubtedly sucks, but there is a comment above this function
> that this can be used on non-slab kernel pages as well.

Oh, I see.  Usercopy calls this kind of thing 'heap object', so
perhaps eventually rename this function to mem_cgroup_from_heap_obj()?

> E.g. !vmap kernel stack pages -> mod_lruvec_kmem_state -> mem_cgroup_from_obj_slab

That actually seems to be the only user ... and I wasn't testing on a
!VMAP_STACK build, so I wouldn't've caught it.

> How about:
> 
> 	if ((slab = virt_to_slap(p)))
> 		return mem_cgroup_from_obj_slab(slab, p);
> 	return folio_memcg_check(virt_to_folio(p), p);

Mild updates, here's my counteroffer:

commit 6ca8243530e4
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Thu Nov 13 11:30:59 2025 -0500

    fix-memcg-slab

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 597673e272a9..a2e6f409c5e8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2599,9 +2599,6 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 	struct slabobj_ext *obj_exts;
 	unsigned int off;
 
-	if (!slab)
-		return NULL;
-
 	obj_exts = slab_obj_exts(slab);
 	if (!obj_exts)
 		return NULL;
@@ -2624,10 +2621,15 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
  */
 struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
 {
+	struct slab *slab;
+
 	if (mem_cgroup_disabled())
 		return NULL;
 
-	return mem_cgroup_from_obj_slab(virt_to_slab(p), p);
+	slab = virt_to_slab(p);
+	if (slab)
+		return mem_cgroup_from_obj_slab(slab, p);
+	return folio_memcg_check(virt_to_folio(p));
 }
 
 static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)

