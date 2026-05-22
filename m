Return-Path: <cgroups+bounces-16216-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oqq8ARuGEGqEYwYAu9opvQ
	(envelope-from <cgroups+bounces-16216-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 18:36:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 504CA5B7A30
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 18:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B86300EF41
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 16:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09311347BC6;
	Fri, 22 May 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LMxJgL/e"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F985201113
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467454; cv=none; b=hE2/dlyK7Eo8ezRj0wrHmqk2ge1iHoIafNQZiFEH4mKl59M/x55lENBRf5uto4lbUR8faH5HW+9QvI0nrPs6PqeIsdJi9vq+JpQeOH54YFp6TRcAt/14jBbUGv24QarcQmrOV6Kcwt7+P/qrXY69XjrEJZWgKtYhHqV75lRqT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467454; c=relaxed/simple;
	bh=QHzWEtbuSKb/JJvn1bGFxXQBbT44e1eQ3aRoIoJcQ1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NezcT8wGkgmhsFh1WdHtGAyi/7Fag9LR+mpzdxBYAtxX6Ba33nPsHn0TrFqTWHaI/J6TjMXycGlgOf9Ypw+gNVVXUD5vvvuDvkfGrbU9gI+ZXyPB+dl1P+73ZDLRBfJA83dcvTJqFgigqtUQfS4uQ5tMlvLX0/uxMXADwvZi+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LMxJgL/e; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 May 2026 09:30:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779467441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gKpPpe4GL/AF8/K5ETy+5C0gs61AGrcVfBSMkf6XxtU=;
	b=LMxJgL/e+Zm5EdDJJwMV83A0V58TmvF+e9XMAAv62o9k9aHtpJuQzajDHm2KAbNM8GW+3+
	ixc0GBsVZeK4BzdTl/r2qNh+OWUPHnAOzbDW+UTocrK2zdDXdwIKs/nXep3SJy2ZIK/7hx
	MO4H+bja785IzMZyZEYan7pDBkMCwxI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Harry Yoo <harry@kernel.org>, Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/4] memcg: uint16_t for nr_bytes in obj_stock_pcp
Message-ID: <ahCEfIJWrPLVpYsc@linux.dev>
References: <20260522011908.1669332-1-shakeel.butt@linux.dev>
 <20260522011908.1669332-3-shakeel.butt@linux.dev>
 <3eaa3522-b41f-4e69-a260-ebfd94fad722@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eaa3522-b41f-4e69-a260-ebfd94fad722@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16216-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim,intel.com:email]
X-Rspamd-Queue-Id: 504CA5B7A30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 10:23:31AM +0800, Qi Zheng wrote:
> 
> 
> On 5/22/26 9:19 AM, Shakeel Butt wrote:
> > Currently struct obj_stock_pcp stores nr_bytes in an 'unsigned int'
> > which is 4 bytes on 64-bit machines. Switch the field to uint16_t to
> > shrink the per-CPU cache.
> > 
> > The kernel supports PAGE_SIZE_4KB, _8KB, _16KB, _32KB, _64KB and
> > _256KB (see HAVE_PAGE_SIZE_* in arch/Kconfig). After the
> > PAGE_SIZE-aligned flush in __refill_obj_stock(), the sub-page
> > remainder fits in uint16_t up through 64KiB pages where PAGE_SIZE - 1
> > == U16_MAX, but on 256KiB pages PAGE_SIZE - 1 == 0x3FFFF exceeds
> > U16_MAX. The accumulator also needs to stay within uint16_t between
> > page-aligned flushes on 64KiB pages where PAGE_SIZE itself is
> > U16_MAX + 1.
> > 
> > Accumulate the new total in an 'unsigned int' local, then:
> > 
> >    1. Flush whenever the accumulator would hit U16_MAX. Together with
> >       the existing allow_uncharge flush at PAGE_SIZE, this keeps the
> >       uint16_t safe on PAGE_SIZE <= 64KiB.
> > 
> >    2. On configs with PAGE_SHIFT > 16 (PAGE_SIZE_256KB on hexagon and
> >       powerpc 44x), push any sub-page remainder above U16_MAX into
> >       objcg->nr_charged_bytes via atomic_add before storing back, so
> >       the store cannot silently truncate. The PAGE_SHIFT > 16 guard
> >       folds the branch out at compile time on smaller page sizes.
> > 
> > Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> > ---
> > 
> > Changes since v1:
> > - Collected tags
> > - Rearrange fields of obj_stock_pcp (David Laight)
> > - Fix comparison operator (Harry)
> > 
> >   mm/memcontrol.c | 33 +++++++++++++++++++++++++++------
> >   1 file changed, 27 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index d7c162946719..e4f00a8159d5 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2019,8 +2019,8 @@ static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
> >   struct obj_stock_pcp {
> >   	local_trylock_t lock;
> > -	unsigned int nr_bytes;
> >   	struct obj_cgroup *cached_objcg;
> > +	uint16_t nr_bytes;
> >   	int16_t node_id;
> >   	int nr_slab_reclaimable_b;
> >   	int nr_slab_unreclaimable_b;
> > @@ -3331,6 +3331,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> >   			       bool allow_uncharge)
> >   {
> >   	unsigned int nr_pages = 0;
> > +	unsigned int stock_nr_bytes;
> >   	if (!stock) {
> >   		nr_pages = nr_bytes >> PAGE_SHIFT;
> > @@ -3339,21 +3340,41 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> >   		goto out;
> >   	}
> > +	stock_nr_bytes = stock->nr_bytes;
> >   	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> >   		drain_obj_stock(stock);
> >   		obj_cgroup_get(objcg);
> > -		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> > +		stock_nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> >   				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
> >   		WRITE_ONCE(stock->cached_objcg, objcg);
> >   		allow_uncharge = true;	/* Allow uncharge when objcg changes */
> >   	}
> > -	stock->nr_bytes += nr_bytes;
> > +	stock_nr_bytes += nr_bytes;
> > +
> > +	/* Since stock->nr_bytes is uint16_t, don't refill >= U16_MAX */
> 
>                                                            ^
> 
> should also be changed to: don't refill > U16_MAX ?
> 
> Otherwise:
> 
> Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks. If I send a new version, I will fix this otherwise I will ask Andrew to
fix this inplace.

