Return-Path: <cgroups+bounces-16390-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFgaJ1NNGGomiwgAu9opvQ
	(envelope-from <cgroups+bounces-16390-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 16:12:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 037405F3793
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 16:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E277330160E2
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408C529A9E9;
	Thu, 28 May 2026 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="g5Cr2PMD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B6233950
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976931; cv=none; b=Ozu3ZCyslMDYUqyESgJ2gBk0OH4Aq6IzsfB/wnZxOuBOzt6XdHleCFHhxCiyoONAxzmwUjHQNBuEGd3IYnfN/rtdOJC8LLZNFvgk54FTeBNXkXG+u03QydoNhqV5UmEiFwoGgBT0i7OID89Vt9MhHBd2zI/fH3sSrBNkgMMmuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976931; c=relaxed/simple;
	bh=faBJi79lTUhe/bRv39kjceYaSpZ5zHVs021AOV1s3Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAzJsXYsWc9c1MdVuhA6Qv3XXfznFBp0T8SYJPIgzjwsPPcqx5wEawNQJEICIBkOtAuSJvqa3WJJ+v9WqB23DZIzlrmPb9+t6x7XHzTz398Q3JT1NqhnsRD5cakU9xvAZpwntq5HcQk3GbBFi7Zi2oH3v3vmli0jtv7kC7qgQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=g5Cr2PMD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51306c9f2e1so148787981cf.0
        for <cgroups@vger.kernel.org>; Thu, 28 May 2026 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779976927; x=1780581727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWqHhRZrJdYq3LgBVddMXMAngLR9XNgV7phzSAMcWeM=;
        b=g5Cr2PMDfyWYsFZ0w883/linnyfXNd0LZDN4cuOwtm1ng8QNHaT3dNIXqz4ug0LhqE
         VSVjGCoHKW4971bWsvzXGKs3MminGHfE52jrx9BHAZ36mFaRxkoRCsT0r5txc/olR57h
         UGsT3UfJ9/DpT0/temXFbZ94KD9ORpzv9GmfHqZlFk434Uqln8/+EWadlqcwX5ua92SD
         8jfmtCsPvHrXQmZ2ItU5LK8PrcvEMukBiX2/msBfEjjPw4YNHgicYGcHkydXKNA6BpWR
         /tVmH+KX6wsalU9qZ46ZDPlCByY4KIkGX1jEPF00QzCvMl70TS60iDuC8cTIIAsPmHqP
         vjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976927; x=1780581727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWqHhRZrJdYq3LgBVddMXMAngLR9XNgV7phzSAMcWeM=;
        b=RW1ogVeyQfLLYyhimwsqupFe3bnSDgzU7tcJuxaeXKIdybiJeYZXpAl2Ft9qFWxNZd
         FxopjHhKbsvdCL43Rh5iLHUx3bBKC2hwIfrLmXSi4Y78A9c510Phnze9fw4ES8cIhC3d
         K48LzFhf0F6kDgB1J8Ts2vEFrp6mkJZfm6eblLdYr5Q43bbgufmpRsixCuqFuYCyTL6I
         g8FpUff62Kcwj0JO1ebZAG5bfaQZZZinkBiooBuh7wWCBCFuzY5DJWvi97VMaDT30YZt
         Srcu7SN9T/p0VMh8ln8qqIx+vyI9ApB0st8V7CnZP12WruqcmNsN2HZctq0Wvprb+eQW
         mnHw==
X-Forwarded-Encrypted: i=1; AFNElJ/81JcZgtrIZ2RKmufNcfRIfsoH8MELteC+/Te++YX0TYFRp8Dh1a84Fc27vQZj2XzFarfJD+TL@vger.kernel.org
X-Gm-Message-State: AOJu0YyNe6iPyB8IvpYeQmETF5UA08xxiBhDg/ni3KrySCVbElJpKZJ0
	G6m+r4A4cZEEMQxk/CRP6WwhjIkS6YoqfhWxvf+lHmnqM5T5+MIhIt0tU2ZlEfgkaes=
X-Gm-Gg: Acq92OG9v5S102ZpCDyc83LYNUZJbzYRYgxBcaQAHacC+9IE5QACSQXKkwz+7LabCwk
	vtFH701NesQhrmsPNtQ0CojdWdz3sW2OhZ9hlHw27I9/NT/PonVNxC64er/CwYbeRaqpm17euwL
	a98rApxllVsJpgQUtQbjyHDQbEB2besotowGIj0ur6RhCPYNBxeHitPAm4GQ2ET5hL0qprzZM+h
	S+/oz/wuKP6VwicC8rif3O7BbfBE1o0KliJz06M4aN1AKLWiwvKwhrpZsKhLqtAAQNpyLLAax9F
	4oJDkHuEB1pP3D1aDOOcfpnjkEjcRfOJKNmPi9eNbla8+zrM6p6KADZ4re5gd3CRQllQcvx0Oh3
	n7Rb8xz10EzBbqS345P8FGu1a75JEBnSJAQJrTyOInOwGtyide+K/nG8butOzYWR9Jw==
X-Received: by 2002:a05:622a:a6da:b0:50f:9c33:af18 with SMTP id d75a77b69052e-516d4428303mr295741211cf.51.1779976927300;
        Thu, 28 May 2026 07:02:07 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706b066e5sm72303461cf.26.2026.05.28.07.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:02:05 -0700 (PDT)
Date: Thu, 28 May 2026 10:02:04 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 9/9] mm: switch deferred split shrinker to list_lru
Message-ID: <ahhK3AKksNbJ4zbY@cmpxchg.org>
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
 <20260527204757.2544958-10-hannes@cmpxchg.org>
 <6f9c78b2-3846-4f75-bcc2-41bf91230513@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f9c78b2-3846-4f75-bcc2-41bf91230513@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16390-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Queue-Id: 037405F3793
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 02:32:06PM +0100, Usama Arif wrote:
> 
> 
> On 27/05/2026 21:45, Johannes Weiner wrote:
> > The deferred split queue handles cgroups in a suboptimal fashion. The
> > queue is per-NUMA node or per-cgroup, not the intersection. That means
> > on a cgrouped system, a node-restricted allocation entering reclaim
> > can end up splitting large pages on other nodes:
> > 
> >         alloc/unmap
> >           deferred_split_folio()
> >             list_add_tail(memcg->split_queue)
> >             set_shrinker_bit(memcg, node, deferred_shrinker_id)
> > 
> >         for_each_zone_zonelist_nodemask(restricted_nodes)
> >           mem_cgroup_iter()
> >             shrink_slab(node, memcg)
> >               shrink_slab_memcg(node, memcg)
> >                 if test_shrinker_bit(memcg, node, deferred_shrinker_id)
> >                   deferred_split_scan()
> >                     walks memcg->split_queue
> > 
> > The shrinker bit adds an imperfect guard rail. As soon as the cgroup
> > has a single large page on the node of interest, all large pages owned
> > by that memcg, including those on other nodes, will be split.
> > 
> > list_lru properly sets up per-node, per-cgroup lists. As a bonus, it
> > streamlines a lot of the list operations and reclaim walks. It's used
> > widely by other major shrinkers already. Convert the deferred split
> > queue as well.
> > 
> > The list_lru per-memcg heads are instantiated on demand when the first
> > object of interest is allocated for a cgroup, by calling
> > folio_memcg_alloc_deferred(). Add calls to where splittable pages are
> > created: anon faults, swapin faults, khugepaged collapse.
> > 
> > These calls create all possible node heads for the cgroup at once, so
> > the migration code (between nodes) doesn't need any special care.
> > 
> > Reported-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> > Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  include/linux/huge_mm.h    |   7 +-
> >  include/linux/memcontrol.h |   4 -
> >  include/linux/mmzone.h     |  12 --
> >  mm/huge_memory.c           | 364 +++++++++++++------------------------
> >  mm/internal.h              |   2 +-
> >  mm/khugepaged.c            |   5 +
> >  mm/memcontrol.c            |  12 +-
> >  mm/memory.c                |   4 +
> >  mm/mm_init.c               |  15 --
> >  mm/swap_state.c            |  10 +
> >  10 files changed, 150 insertions(+), 285 deletions(-)
> > 
> 
> [...]
> 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 135f5c0f57bd..f22e61d8c8de 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5222,6 +5222,10 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> >  			folio_put(folio);
> >  			goto next;
> >  		}
> > +		if (order > 1 && folio_memcg_alloc_deferred(folio)) {
> > +			folio_put(folio);
> 
> Ah sorry, should have caught this in the previous version, do we need
> 
> count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
> 
> here?

This isn't an allocation we expect to fail with any sort of routine
that we'd need to capture it in the event counter. It would warn in
dmesg if it did. But in practice it can't happen at all, since it's a
sub-costly-order slab allocation and the allocator would loop and OOM
kill stuff until it succeeds.

> or maybe we just goto next instead of goto fallback and trty next
> viable order?

Again I don't think it matters, but fallback seems a bit more correct
because the size of the list_lru allocation doesn't change with lower
orders (until we hit 0).

So I think we can just leave it as is.

