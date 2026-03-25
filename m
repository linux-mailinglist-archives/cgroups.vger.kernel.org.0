Return-Path: <cgroups+bounces-15052-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJHRFrkrxGmZwgQAu9opvQ
	(envelope-from <cgroups+bounces-15052-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 19:38:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3FE32AA8E
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 19:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB572301D483
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93514334C1D;
	Wed, 25 Mar 2026 18:36:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F890311975
	for <cgroups@vger.kernel.org>; Wed, 25 Mar 2026 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463814; cv=none; b=COo0gaTq22oUNxI/KiM3PGhIGdTKUd5bx5xdPTsBBXDJ36WKrA/cVeX8IlnKyxSKZdITTp1W97nGLgE5FGELv7W/kDvcrFA+KeF25G55rauk7vTJUH3JdNLbe9r/Gnj8iIUXxq5d/M4HAEcyNFCNT2MnKeSE/aI3DhMADJNRp2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463814; c=relaxed/simple;
	bh=caD87+u92zEtkpCjBqLx1b1xohIodhH4i7hTlROlaGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBalaqtsD6aHRmvtSMlQF1m83wKCZ+lFquXcX/p94ADjsbaRlOnd/Gq22Oe5PQBFTVNyvI4+gLX2OO6qNHFELau0IgUx8GiJczgU77OxKjyCVLwZVRvgPyykAWFNoU7ZugCNuTeTZHIWp2h/x2KOtHBX6g6dDs07J/tdZ+WwrpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 26 Mar 2026 03:36:49 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Thu, 26 Mar 2026 03:36:49 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com,
	cgroups@vger.kernel.org, chengming.zhou@linux.dev,
	chrisl@kernel.org, corbet@lwn.net, david@kernel.org,
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org,
	hughd@google.com, jannh@google.com, joshua.hahnjy@gmail.com,
	lance.yang@linux.dev, lenb@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev,
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com,
	peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org,
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org,
	ryan.roberts@arm.com, shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com, surenb@google.com, tglx@kernel.org,
	vbabka@suse.cz, weixugc@google.com, ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev, yuanchu@google.com,
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com,
	riel@surriel.com
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
Message-ID: <acQrQYHJgqof0yx4@yjaykim-PowerEdge-T330>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15052-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B3FE32AA8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:27:14PM -0700, Nhat Pham wrote:
> 
> This patch series is based on 6.19. There are a couple more
> swap-related changes in mainline that I would need to coordinate
> with, but I still want to send this out as an update for the
> regressions reported by Kairui Song in [15]. It's probably easier
> to just build this thing rather than dig through that series of
> emails to get the fix patch :)

Hi Nhat,

I wanted to fully understand the patches before asking questions,
but reviewing everything takes time, and I didn't want to miss the
timing. So let me share some thoughts and ask about your direction. 

These are the perspectives I'm coming from:

Pros:
- The architecture is very clean.
- Zero entries currently consume swap space, which can prevent
  actual swap usage in some cases.
- It resolves zswap's dependency on swap device size.
- And so on.

Cons:
- An additional virtual allocation step is introduced per every swap.
- not easy to merge (change swap infrastructure totally?)

To address the cons, I think if we can demonstrate that the
benefits always outweigh the costs, it could fully replace the
existing mechanism. However, if this can be applied selectively,
we get only the pros without the cons.

1. Modularization

You removed CONFIG_* and went with a unified approach. I recall
you were also considering a module-based structure at some point.
What are your thoughts on that direction?

If we take that approach, we could extend the recent swap ops
patchset (https://lore.kernel.org/linux-mm/20260302104016.163542-1-bhe@redhat.com/)
as follows:
- Make vswap a swap module
- Have cluster allocation functions reside in swapops
- Enable vswap through swapon

I think this could result in a similar structure. An additional
benefit would be that it enables various configurations:

- vswap + regular swap together
- vswap only
- And other combinations

And merge is not that hard. it is not the total change of swap infra structure.

But, swapoff fastness might disappear? it is not that critical as I think.

2. Flash-friendly swap integration (for my use case)

I've been thinking about the flash-friendly swap concept that
I mentioned before and recently proposed:
(https://lore.kernel.org/linux-mm/aZW0voL4MmnMQlaR@yjaykim-PowerEdge-T330/)

One of its core functions requires buffering RAM-swapped pages
and writing them sequentially at an appropriate time -- not
immediately, but in proper block-sized units, sequentially.

This means allocated offsets must essentially be virtual, and
physical offsets need to be managed separately at the actual
write time.

If we integrate this into the current vswap, we would either
need vswap itself to handle the sequential writes (bypassing
the physical device and receiving pages directly), or swapon
a swap device and have vswap obtain physical offsets from it.
But since those offsets cannot be used directly (due to
buffering and sequential write requirements), they become
virtual too, resulting in:

  virtual -> virtual -> physical

This triple indirection is not ideal.

However, if the modularization from point 1 is achieved and
vswap acts as a swap device itself, then we can cleanly
establish a:

  virtual -> physical

relationship within it.

I noticed you seem to be exploring collaboration with Kairui
as well. I'm curious whether you have a compromise direction
in mind, or if you plan to stick with the current approach.

P.S. I definitely want to review the vswap code in detail
when I get the time. great work and code.

Thanks,
Youngjun Park

