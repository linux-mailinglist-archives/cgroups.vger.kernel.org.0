Return-Path: <cgroups+bounces-14752-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAX4DDbcsGmHnwIAu9opvQ
	(envelope-from <cgroups+bounces-14752-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 04:06:30 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 865F125B44E
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 04:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF289306CEFC
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 03:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06B2FD7C3;
	Wed, 11 Mar 2026 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dAvyt5ry"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745442F3C3E
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 03:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198387; cv=none; b=toMZ8Ld0dnu01VS7sj8kFcCZqXW2qlgcSSib72mY52agAasucwscTuzfLyoeMzWAYf6WgTu8LJG/1K9V6g6/gXcn6fiXyCdRpSpQXOtEhkDk4x0l8PuAO5Li8RF/eJJtV3UdE7UnfB+TaRB2ZQTDFcyELHPG8frX1gmZmVVUF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198387; c=relaxed/simple;
	bh=WJNEuudC1gDCXpbLPovNaD7zZyG+9rJza+6MdbvSZwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAMrlUbvoX+xsQ4hLGwLJpEmXkhtD5EvnOojTzFSOr329O32BhS1SYbnsiyGXLruybH46PE5Ds+9CLVnQCS0byp2R3vvoTALMUiwo3qopEtr6HMDeVQ2abjaDS0d0RjF3leUmokDKL6G8MEzGT5zPt41ptXt3mHOZsvCKm47vLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dAvyt5ry; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Mar 2026 11:06:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773198383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kYOYGnrkLB9Ow4Bw65owtN+BtAuCoQOFqB6t3I3SeU=;
	b=dAvyt5ry8mq2RbaSF6G1SFClTulZETLboPrAdgs6rTl3hPpd51q5Y8ivfi5YeZX2Y/YfRs
	Y/7MJMuRB5Zcd2okhZTHVW4/AAtIwwQlk5N+orbzK4lGc7j6yLQl4OPbkJe+DY5oI7oebE
	q/NDsp22PeOcrOI7CjDzWE8E41emAGU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: ranxiaokai627@163.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	akpm@linux-foundation.org, vbabka@kernel.org, cl@gentwo.org, rientjes@google.com, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ran.xiaokai@zte.com.cn
Subject: Re: [PATCH 0/2] fix kmem over-charging for embedded obj_exts array
Message-ID: <exe5r2q526ym5qcypup73yltv3jqnplwhybr3zwxgcs5vfgoin@t6yj2ntfs7jk>
References: <20260310113804.245647-1-ranxiaokai627@163.com>
 <abDPvjUld-2BTpRa@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abDPvjUld-2BTpRa@hyeyoo>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 865F125B44E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14752-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[163.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,gentwo.org,google.com,vger.kernel.org,kvack.org,zte.com.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 11:13:18AM +0900, Harry Yoo wrote:
> On Tue, Mar 10, 2026 at 11:38:02AM +0000, ranxiaokai627@163.com wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > 
> > Since commit a77d6d338685 ("mm/slab: place slabobj_ext metadata
> > in unused space within s->size"), the struct slabobj_ext array can
> > use slab leftover space or be embedded into the slub object to save
> > memory. In these cases, no extra kmalloc space is allocated for the
> > obj_exts array.
> > 
> > However, obj_full_size() always returns extra sizeof(struct obj_cgroup *)
> > bytes for every object, which leads to over-charging for slabs with
> > embedded obj_exts.
> > 
> > This series optimizes obj_full_size() to check whether obj_exts uses
> > slab leftover space or is embedded in the object. If so, only the object
> > size is charged. Otherwise, the extra obj_cgroup pointer space is also
> > charged.
> 
> Hi Ran,
> 
> At first look, I'm not sure if it's a good idea - although it's
> allocated from wasted space, it's still memory that's needed to
> charge objects.

Yes, I've been thinking about this as well.

For slabobj_ext that lives at the end of the whole slab, it seems reasonable to
charge it to the cgroup.

> 
> But for "embedded into the slub object" case, yeah,
> the metadata is charged twice, as it's already included in s->size.

While reading patch 2, I was also thinking about whether it would make sense to
call obj_exts_in_slab() on every object allocation and free for this case...

I wonder if we could use objext_flags to carry a bit of information about where
slabobj_ext is located.

-- 
Thanks,
Hao

