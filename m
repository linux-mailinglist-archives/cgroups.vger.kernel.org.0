Return-Path: <cgroups+bounces-7361-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C31A7C2B7
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 19:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59543BC98C
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 17:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADFF218ABA;
	Fri,  4 Apr 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t5T4Dr7h"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3316219313
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788660; cv=none; b=QgE+BEsfnFhVuzlXhSJwAuGfcAGpuIXHc7X8uYMB0B++pZXExMJzsf4Avjr07grPoN3v591lPmxp+db9vxriIDlPiB6qODJmG0Y5+Ff0vLjtfjzBaMCZDLMpd0mg3KDGM13cXmMuLcCU5cLtNW7brAJplENW5SXgjWUWRCSTLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788660; c=relaxed/simple;
	bh=9kbUhOAyhetS4xhEPixDx3Ns3cI3Ff1jUuFX/GEgq4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1D526U/jVvrKzshZPm6eMyXQRLJ0lhYqGoVXjCC5zYPUo3uOAvh23EVXvPZgqBEzf+v9h+v8dQ+xE1spAYXpStR/uzHtklq4cs6GoyMHAHIya8ALLmWdt5TLsTnyqPjKR1SOuj7+Cc/baoIeWs1J9vmLWeQvnJWyeY7VZEp3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t5T4Dr7h; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 4 Apr 2025 10:44:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743788651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hAbFaoCIBrF7ogP+htLpu049h28pPIGGISVjJEaZKxY=;
	b=t5T4Dr7hR3euhMs8iUsoJ6+MGtIHU1VIxv/U63uAfrO57mvnJcw6LNWNiDqVWihPttnals
	ZvJTkKh+1CWvippnlhUsz4G/S+kQO1xFqsE5lz7FjXArsKKR2HqmD1mIBtFk79PSyuOaON
	13EPtlEV/WH6cW6D1eewEpMTqbW6/6w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: vmalloc: simplify MEMCG_VMALLOC updates
Message-ID: <bmlkdbqgwboyqrnxyom7n52fjmo76ux77jhqw5odc6c6dfon3h@zdylwtmlywbt>
References: <20250403053326.26860-1-shakeel.butt@linux.dev>
 <Z-5uQlaPjZtB61C4@pc636>
 <gl5u2fkxaqe4todqwzsfktvnlghb7vnan2n3bpxum7ibwaznpd@xomzodg47qwe>
 <Z--1uXnfqfQthYvh@pc636>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z--1uXnfqfQthYvh@pc636>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 04, 2025 at 12:34:33PM +0200, Uladzislau Rezki wrote:
> On Thu, Apr 03, 2025 at 11:20:18AM -0700, Shakeel Butt wrote:
> > On Thu, Apr 03, 2025 at 01:17:22PM +0200, Uladzislau Rezki wrote:
> > > On Wed, Apr 02, 2025 at 10:33:26PM -0700, Shakeel Butt wrote:
> > > > The vmalloc region can either be charged to a single memcg or none. At
> > > > the moment kernel traverses all the pages backing the vmalloc region to
> > > > update the MEMCG_VMALLOC stat. However there is no need to look at all
> > > > the pages as all those pages will be charged to a single memcg or none.
> > > > Simplify the MEMCG_VMALLOC update by just looking at the first page of
> > > > the vmalloc region.
> > > > 
> > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > ---
> > > >  mm/vmalloc.c | 13 +++++--------
> > > >  1 file changed, 5 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 3ed720a787ec..cdae76994488 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -3370,12 +3370,12 @@ void vfree(const void *addr)
> > > >  
> > > >  	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
> > > >  		vm_reset_perms(vm);
> > > > +	if (vm->nr_pages && !(vm->flags & VM_MAP_PUT_PAGES))
> > > > +		mod_memcg_page_state(vm->pages[0], MEMCG_VMALLOC, -vm->nr_pages);
> > > >
> > > Could you please add a comment stating that the first page should be
> > > modified?
> > > 
> > 
> > Sorry, what do you mean by first page should be modified?
> > mod_memcg_page_state() will not modify the page but extract memcg from
> > it and modify its vmalloc stat.
> > 
> I meant what you wrote in the commit message. A mod_memcg_page_state() can
> be invoked only on a first page within a mapped range, because the rest is
> anyway is associated with the same mem_cgroup struct.
> 
> Just add a comment that we do not need to check all pages. Can you add it?

Ack. Andrew, please squash the following into the patch.


From 982971062e6bd04feabf4f6a745469cb9bddef03 Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Fri, 4 Apr 2025 10:41:52 -0700
Subject: [PATCH] memcg : simplify MEMCG_VMALLOC updates - fix

Add comment

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/vmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index cdae76994488..bcc90d4357e4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3370,6 +3370,7 @@ void vfree(const void *addr)
 
 	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
 		vm_reset_perms(vm);
+	/* All pages of vm should be charged to same memcg, so use first one. */
 	if (vm->nr_pages && !(vm->flags & VM_MAP_PUT_PAGES))
 		mod_memcg_page_state(vm->pages[0], MEMCG_VMALLOC, -vm->nr_pages);
 	for (i = 0; i < vm->nr_pages; i++) {
@@ -3671,6 +3672,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		node, page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
+	/* All pages of vm should be charged to same memcg, so use first one. */
 	if (gfp_mask & __GFP_ACCOUNT && area->nr_pages)
 		mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
 				     area->nr_pages);
-- 
2.47.1


