Return-Path: <cgroups+bounces-16217-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI2VLnCGEGqEYwYAu9opvQ
	(envelope-from <cgroups+bounces-16217-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 18:38:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 635195B7A6E
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 18:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C46CB3001FD3
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 16:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477941C303;
	Fri, 22 May 2026 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="giS18ONg"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060FD370AF3
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467884; cv=none; b=Jt1XGVHe9OjFl/fpeKlsNglYLhSZioX4DpbhKWmJzW63IomH3wizl3z1CoJwgP9+cz9h0GDUzuXWeZk0IuytIrNKIYmuQknuNizUST45/8YEbyUCDN0h3iAn8aR+6iGnm4InCBMYPJAQnHIv9zmOGpG3G00ISPH/nurqC6KB6Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467884; c=relaxed/simple;
	bh=lxNyYQr0cQNVzW3YAilHzvlyx477lK01M8Ia03cHmfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9R8g/eoymchY1f3m5VTS3sRLiDhsfSjoDP8Z1NoxFv080yDejrNP9llKS8Nv1uBPta4KTExRptmmUFHz3lwc6A4BZ2hbvErBcNXI21b7JQCI/UWM+rK55JQa6p8MGgrSRrscSTleuTBX8SEqj4TJ0AKZH2gxEnwN32Ad1eYtCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=giS18ONg; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 May 2026 09:37:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779467871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oGer9ojiBJJKSgW4zmxqBqKbeEU9rBkVQbJdBxhzT0c=;
	b=giS18ONglvazOIz5+CrJmLvo+1ZX/TD6DtT1KkoaLTzb5sdswuQCbKxe6EBNa8gP4WzY3T
	HeuaJ+sBuZnuEds/er5wc87wu0eCq6itAzxxcRAMWc+YtmGQGQyyx4izS9xDU2SUIm1NVo
	J2Ha8K+cWUlsZqyBlo6lKnjYMcimAs0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Harry Yoo <harry@kernel.org>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 4/4] memcg: multi objcg charge support
Message-ID: <ahCGEAQ6USZDYrUo@linux.dev>
References: <20260522011908.1669332-1-shakeel.butt@linux.dev>
 <20260522011908.1669332-5-shakeel.butt@linux.dev>
 <9D6F8C2F-F3E7-4326-A4F6-D5B1433A6C55@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D6F8C2F-F3E7-4326-A4F6-D5B1433A6C55@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16217-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 635195B7A6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 02:33:36PM +0800, Muchun Song wrote:
> 
> 
> > On May 22, 2026, at 09:19, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
> > per-node type") split a memcg's single obj_cgroup into one per NUMA
> > node so that reparenting LRU folios can take per-node lru locks. As a
> > side effect, the per-CPU obj_stock_pcp -- which caches exactly one
> > cached_objcg -- thrashes on workloads where threads of the same memcg
> > run on different NUMA nodes. The kernel test robot reported a 67.7%
> > regression on stress-ng.switch.ops_per_sec from this pattern.
> > 
> > Mirror the multi-slot pattern already used by memcg_stock_pcp: turn
> > nr_bytes and cached_objcg into NR_OBJ_STOCK-element arrays, scan all
> > slots on consume/refill/account, prefer empty slots when inserting,
> > and evict a random slot only when full. With multiple slots a CPU can
> > hold the per-node objcg variants of one memcg plus a few siblings
> > without ever forcing a drain.
> > 
> > A single int8_t index records which slot the cached slab stats belong
> > to; the stats are flushed on slot or pgdat change. With NR_OBJ_STOCK
> > = 5 the layout (verified with pahole) is:
> > 
> >  offset 0  : lock(1) + index(1) + node_id(2) + slab stats(4) = 8B
> >  offset 8  : nr_bytes[5]                                     = 10B
> >  offset 18 : padding                                         = 6B
> >  offset 24 : cached[5]                                       = 40B
> >  offset 64 : (line 2) work_struct + flags (cold)
> > 
> > so consume_obj_stock, refill_obj_stock and the slab account path each
> > touch exactly one 64-byte cache line on non-debug 64-bit builds.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202605121641.b6a60cb0-lkp@intel.com
> > Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> > ---
> > 
> > Changes since v1:
> > - Use round robin for drain
> > 
> > mm/memcontrol.c | 188 ++++++++++++++++++++++++++++++++++--------------
> > 1 file changed, 136 insertions(+), 52 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 78c02451312b..ba17633b0bd0 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -150,14 +150,14 @@ static void obj_cgroup_release(struct percpu_ref *ref)
> > 	* However, it can be PAGE_SIZE or (x * PAGE_SIZE).
> > 	*
> > 	* The following sequence can lead to it:
> > - 	* 1) CPU0: objcg == stock->cached_objcg
> > + 	* 1) CPU0: objcg cached in one of stock->cached[i]
> > 	* 2) CPU1: we do a small allocation (e.g. 92 bytes),
> > 	*          PAGE_SIZE bytes are charged
> > 	* 3) CPU1: a process from another memcg is allocating something,
> > 	*          the stock if flushed,
> > 	*          objcg->nr_charged_bytes = PAGE_SIZE - 92
> > 	* 5) CPU0: we do release this object,
>            ^
>            4
> 
> Since you're already modifying the comments in this section,
> would you mind fixing the numbering as well? I noticed that the
> sequence was wrong a while back :)

Haha I didn't even notice. If I send a new version, I will fix this otherwise I
will ask Andrew to fix inplace.


