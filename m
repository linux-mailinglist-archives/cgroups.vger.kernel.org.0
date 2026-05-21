Return-Path: <cgroups+bounces-16137-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCnVOW5aDmo4+AUAu9opvQ
	(envelope-from <cgroups+bounces-16137-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 03:05:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF559D81E
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 03:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62BA9302F9C1
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 01:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D672C21DF;
	Thu, 21 May 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QR5Fl/3T"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6D13635E
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325547; cv=none; b=ej9b1ZoGPYtBJR/gIRRxQx/aqBTUH25ex6Xuei1Sbt//n6PAQbJwFxdaUrKWHKHP/yM+GUf8dUIlAIOsdjyXDncJ+wq8cbMrEoTSvsXDUHFd/O8ztnaW1UX3JVo2DQPTqP1R9NEVA7XdZXJ1VcWUqAI1yV7qc91HYUrBXEJ7zck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325547; c=relaxed/simple;
	bh=nVxkgnMlulZVxFt7nmN3XdCH9Os6TPziFvH2oRgtKAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4uCeiXHIhuKKJuUBOSLBuJJgH9462BrScxY3oPaQ6Xkn+pT2xl1+InTvGC73opFQ4C3FgHsNw3G2SxPoLP5bP9Jrf4IyaDQCUKs6sGVUM2hOA1InZfDGmVqaMDmjoujiObSh5EXzKujNXIeKJg8GnTUhIKJRMN1GskfzD+uptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QR5Fl/3T; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 May 2026 18:05:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779325543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1MTLIIAhH9UvgwVNHsziM8OkcgXCZAnwRaysqlVF3I=;
	b=QR5Fl/3T42AWhOS0T14rdTy6QqS8+DeaDevCSsA/S9l9kCVGm82RVcfZLwxJ8LcOTqRN8+
	bvoBSGwy7CVoFcdQEMyEosrRn4RpEE9HUBytIp70iBKeCCNH8EopGTiB+orK8XIm2zmcmx
	dvs5Fq5UTZhlkzR5d2hbSjRCvLigMQw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Harry Yoo <harry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 4/4] memcg: multi objcg charge support
Message-ID: <ag5Z9uIMoXpr3rLP@linux.dev>
References: <20260520053123.2709959-1-shakeel.butt@linux.dev>
 <20260520053123.2709959-5-shakeel.butt@linux.dev>
 <4e20f643-6983-4b6e-b12d-c6c4eb20ae0c@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e20f643-6983-4b6e-b12d-c6c4eb20ae0c@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16137-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 8DCF559D81E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:35:30PM +0900, Harry Yoo wrote:
> 
> 
> On 5/20/26 2:31 PM, Shakeel Butt wrote:
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
> >    offset 0  : lock(1) + index(1) + node_id(2) + slab stats(4) = 8B
> >    offset 8  : nr_bytes[5]                                     = 10B
> >    offset 18 : padding                                         = 6B
> >    offset 24 : cached[5]                                       = 40B
> >    offset 64 : (line 2) work_struct + flags (cold)
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
> > @@ -3350,19 +3405,45 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> >   		goto out;
> >   	}
> > -	stock_nr_bytes = stock->nr_bytes;
> > -	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> > -		drain_obj_stock(stock);
> > +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> > +		struct obj_cgroup *cached = READ_ONCE(stock->cached[i]);
> > +
> > +		if (!cached) {
> > +			if (empty_slot == -1)
> > +				empty_slot = i;
> > +			continue;
> > +		}
> > +		if (cached == objcg) {
> > +			slot = i;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (slot == -1) {
> > +		slot = empty_slot;
> > +		if (slot == -1) {
> > +			slot = get_random_u32_below(NR_OBJ_STOCK);
> 
> It would break kmalloc_nolock() because _get_random_bytes() uses a spinlock.
> perhaps prandom_u32_state() should be sufficient in this case.
> 
> Is there a reason why it uses random eviction, unlike multi-memcg percpu
> charge cache?

Oh I didn't know and actually we are already using get_random_u32_below() in
refill_stock(). So, it need fixing as well. That would be a separate patch.

I will explore prandom_u32_state().

