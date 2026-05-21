Return-Path: <cgroups+bounces-16136-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGeqLF1aDmo4+AUAu9opvQ
	(envelope-from <cgroups+bounces-16136-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 03:05:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1686259D80E
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 03:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56EFB3088D55
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 01:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12F72C032E;
	Thu, 21 May 2026 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j6LV4LV+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE9B2BF002
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325412; cv=none; b=faI6uZABU+Lmc0WmmklWkAqUFcqqdZcvlX/KimAp523OyuY5JeywbtP6W60Du/NYrE0WbRp3+P/FKQAihBpmgCeGXU9GcIU3RybZeHDxMzA7HfcmdyedZ/egA43iSETc4uhrufkIieiJ0SJ8p98uOvge5guLc2FJUatchVKcyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325412; c=relaxed/simple;
	bh=K859RgrLUB6wQTiJk1boKClVLnt5BOS3LZSjCfxq/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS0BDkBNEPjY7kZvITnhsf3NYXcU9AGlZdvFPH6bmhEyqAaYArHQSbKul+nB2hhMtEgV0jS4o+Rd6DyRVcIbE3PxGSNuXL8bGUF/a/0szKJ5BJv2mHHr+TBfhyJIgNVuwrV3qix8lPMccIKi20A7V1+OIhXVZfTGoYbSZ+mLCsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j6LV4LV+; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 May 2026 18:03:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779325399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWovRyu7TnS4H+kwdxrm7oVBHQW0yNncYwQSYPO+Gvg=;
	b=j6LV4LV+gJnHuP5vaZFF3lT53uKAZT2pLPiHjyiGTZiKbLpe9h8/D62lPeKi0augmUVBep
	78FCkrDSxR15aaI8AyG4LEClbjjJ8eE3gaxJ57kyB4FmmHqPmjLCngHsXdwv0250i71qE3
	BTW/r8e8Wbu2o3MfX6kl/BFk0MLLvOE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Harry Yoo <harry@kernel.org>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 2/4] memcg: uint16_t for nr_bytes in obj_stock_pcp
Message-ID: <ag5Ze4ugWTbOnSCe@linux.dev>
References: <20260520053123.2709959-1-shakeel.butt@linux.dev>
 <20260520053123.2709959-3-shakeel.butt@linux.dev>
 <20260520142023.6eae5ec7@pumpkin>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520142023.6eae5ec7@pumpkin>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16136-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 1686259D80E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 02:20:23PM +0100, David Laight wrote:
> On Tue, 19 May 2026 22:31:20 -0700
> Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
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
> >   1. Flush whenever the accumulator would hit U16_MAX. Together with
> >      the existing allow_uncharge flush at PAGE_SIZE, this keeps the
> >      uint16_t safe on PAGE_SIZE <= 64KiB.
> > 
> >   2. On configs with PAGE_SHIFT > 16 (PAGE_SIZE_256KB on hexagon and
> >      powerpc 44x), push any sub-page remainder above U16_MAX into
> >      objcg->nr_charged_bytes via atomic_add before storing back, so
> >      the store cannot silently truncate. The PAGE_SHIFT > 16 guard
> >      folds the branch out at compile time on smaller page sizes.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> > ---
> >  mm/memcontrol.c | 33 +++++++++++++++++++++++++++------
> >  1 file changed, 27 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index d7c162946719..b3d63d9f267c 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2019,7 +2019,7 @@ static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
> >  
> >  struct obj_stock_pcp {
> >  	local_trylock_t lock;
> > -	unsigned int nr_bytes;
> > +	uint16_t nr_bytes;
> >  	struct obj_cgroup *cached_objcg;
> >  	int16_t node_id;
> 
> You might want to move it to this hole.
> The size of 'lock' depends on kernel build options.

Thanks. In the final patch, I am rearranging the fields for better packing.
Please take a look at 4th patch and see if it still need fixing.

