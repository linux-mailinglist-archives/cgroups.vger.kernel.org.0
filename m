Return-Path: <cgroups+bounces-16135-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKRlO4pZDmo4+AUAu9opvQ
	(envelope-from <cgroups+bounces-16135-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 03:02:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A914459D7AD
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 03:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A695300C38B
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 01:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A652BEFF5;
	Thu, 21 May 2026 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LE8g0B/v"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512B824BBFD
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325317; cv=none; b=azPkBBNP++9yq2u9vQHInE2W3afZ4PDBdssCkz3wSndVDyJDDFU7bEa7s/wGhugR4XgyrX2sJrtjBlKB6ac+El8wCocEVeH80NFwKpHVpdQVDmTgR9yveSBw04RFeXUQSI1B8dDsZQ8HfOulusQXOTR98mGLziCSVywitHYChf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325317; c=relaxed/simple;
	bh=1nOSyPNSmCQ/i7zE+Zk8FkfLP4yEaJjqcXtopu96evA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlZrCwNShyDjFFjt2GMl2iWV1j13fb2b2WcNA+vqoRPt+OHeCIBP0o2JAPwnmvXNctFdl3NtdE1tnbQvj/aTvHiNCiz/mpKs34nvXWcJIc/gpEqruCXJzKLBOYowpI084tmCc4prr0DZO975VzeD5QrPCXCmA7z06ZuVf/HlyXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LE8g0B/v; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 May 2026 18:01:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779325303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N6+eCAO9BUhXRuKgK/q3rPe94yeakgzBDRKqgv0P63E=;
	b=LE8g0B/vDcnIlCW6Tn+CdVICwGSpp0kHWRyiIVzSfJQxgHaUVCsj+vP7wxYFU0CeHTovPV
	ueE2l0yfH5UUOw9Rchqd8mw6i5zjC7QrXobCW2RrPImRrwnzf9B0blMA5ZH95XQWs9mPnL
	6x2ORFtbESwq8Jv717LlEr5fepfUea8=
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
Subject: Re: [PATCH 2/4] memcg: uint16_t for nr_bytes in obj_stock_pcp
Message-ID: <ag5ZXSKgUz3tt4mV@linux.dev>
References: <20260520053123.2709959-1-shakeel.butt@linux.dev>
 <20260520053123.2709959-3-shakeel.butt@linux.dev>
 <55d36f91-fcae-4506-9b76-4a7cad3d256d@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55d36f91-fcae-4506-9b76-4a7cad3d256d@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16135-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: A914459D7AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 04:01:45PM +0900, Harry Yoo wrote:
> 
> 
> On 5/20/26 2:31 PM, Shakeel Butt wrote:
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
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> > ---
> >   mm/memcontrol.c | 33 +++++++++++++++++++++++++++------
> >   1 file changed, 27 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index d7c162946719..b3d63d9f267c 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
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
> > +	if ((allow_uncharge && (stock_nr_bytes > PAGE_SIZE)) ||
> > +	    stock_nr_bytes >= U16_MAX) {
> 
> nit: This should be > U16_MAX?

Ack.


