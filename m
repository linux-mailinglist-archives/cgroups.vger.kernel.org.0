Return-Path: <cgroups+bounces-15026-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMD3IhOzwmmRkwQAu9opvQ
	(envelope-from <cgroups+bounces-15026-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 16:51:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDD6318641
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 16:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B23A306DFE3
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3B03DA5B0;
	Tue, 24 Mar 2026 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0x6/rX/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C42039768D
	for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367060; cv=none; b=SP/WoSfbnnqjZN+0BYGMUP8dMZHSBXe07OW2sCaXdOaWH4/xyBTOkquMqQuUw3WTHnt4N1l9vh6Q1kMU2N3g6OM1v6HZtbQT3P3W1hhiVUXgiUQ/AiCEt85IsdnYLiomooCiX06vsaRR1CHVhUsY5VgsCS5S+pfax9S1hUT+c3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367060; c=relaxed/simple;
	bh=Vehk0QM2fXERzlwYeIb5QCPQ2DmgSyzpx0RkxsHDeP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkKVsHd8TSC7JaRcuXPB0MJ3aA/THyHpUQHR6J3sWdch5/4SJUhDVPZDp0R+/8jmyhtza/fYVmr0Mo2UTBrQSuO91ZDdD573uOgToRJXdDZOmM+3CnAZcXb0CV9VqzenHvOZOq2kUwrm13V1DCWOIB1yaA7LQnlGfiS7tYWrWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0x6/rX/; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d75371d873so4609833a34.3
        for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367056; x=1774971856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/z+GYpxsMEozZLGaH6wDzqozrpwK3g4rVLvamGwvHc=;
        b=S0x6/rX/u04ODOeRtOqzK/5Cq2Ur+ZDEacYvhHkrZp44Bg2MX2XbC+2SnovCv6jpVf
         ojnVg92045PQiPRaetAVAbDxz55mzbk3Z75TmZgMIiO0ClRAFttR9ol8jpuKuXx+668l
         xTpgq3REg6NX3gKD2Kq6B2CZn6er4JIv8Z5MEb7dk+GEcQoQlGBSDKfE44o6sPkizCKo
         FIy2GQ4yGn/QneEB37gsQsU68SWLgQSr3rkEwaLSj/Me/7BA2+IIvHxNSJt4I28mJoXD
         X0+HC7Tog9VqFF0hm5T0omEZ31YNILcgSKoM70XxbeIJ8JPCEJtNoxVsNRQosq0kiTpZ
         r42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367056; x=1774971856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/z+GYpxsMEozZLGaH6wDzqozrpwK3g4rVLvamGwvHc=;
        b=ML4SbUs1SjRu4OJv64aLcUXjxm61GcoWrV6YV4KSEpvaddzlfHI58tW0gyIEAbilIo
         PzbStVix9rZA8awFNZSCvYsLTnuEgp4CmUefmd9Qm+qo9l5MhK4tNloHoFm2vUP6JsHQ
         UiLcolflyXjvBa/W56ew5R/xTrjc49uLy1UnuwUs40AOYPmK8QLwnZz4Aee8E19+bIYW
         HqUEYdbhhpe2473UPwRNKY5zxhdAYJwjXIxsGJurPwzgecqzliJx5iv3KS+P+ildlNT2
         XV0abA+VGKgUzrdoiUCWVvir2n3gb9erm8dx07WgPXQW4pwdw1OaVpbSAR/iKKaw4Y9T
         ht5w==
X-Forwarded-Encrypted: i=1; AJvYcCU19I8QS2vqEiPDKa+dbpelVsP16atba7OIaDszgaXCmvCha7Wa2xDd/ApWM0Os0ne+LjXZ7TpH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs3ZVJgjA3b46UZQpEa1pMyUCWUKuJJIjmLufm+SvJ/gY0YIOl
	wUQz/vv/oQBNjfLWHmY4TvpZ2D9MyTNiaUztOQGgcxz4M4HtjmvFuD8k
X-Gm-Gg: ATEYQzyCUwhL1mP7E8HmkpADzcEHqv09afHF9L5S0vaYMUMDAYIZfqO0i2r3xeYMkAw
	noAppZo0LWpUP6LdXOgBHOJlX0dFdbEjoEKX4wNipIMgmrH9YBsmbVTQHzWVWKb1MfG+14YfQB+
	COmlJWpnxsZVoH0n65H5TOr2bbu2mWdyt/B4uHM3pIMaiMumcuMk6XKsdQ6hGkapHLY90MMLz+A
	X9H/f5sS+48C2pWjhTFY0/mdopMVtGh6AUUHS4JZEeQ3bGOsWfD+azdBSgeQsbqawbJJvGKELv9
	PkVpm3LXnjiyW8uAQ4VHJO/ExQ6fLJTAFjIpeqS5Paf7dheThLL39nT/bipr6Prq2absz8UqDY1
	FMK1EVLXpqQfzpCchnRExO7NNCTGpqKxyjgplXRnQAFsBvHE4bR00p1bvoKVmdlnwRHNxvmwZLV
	s3j5y/7QtLB353HzXMH0S7jw==
X-Received: by 2002:a05:6830:43aa:b0:7d7:d673:c1c with SMTP id 46e09a7af769-7d7eb011282mr10512912a34.33.1774367056385;
        Tue, 24 Mar 2026 08:44:16 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadd17d9sm13472356a34.14.2026.03.24.08.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:44:15 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [RFC PATCH 6/6] mm/memcontrol: Make memory.high tier-aware
Date: Tue, 24 Mar 2026 08:44:12 -0700
Message-ID: <20260324154414.195150-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <90749965-ebc8-43b2-92e3-baec5f6e3de0@linux.ibm.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15026-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFDD6318641
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 16:21:06 +0530 Donet Tom <donettom@linux.ibm.com> wrote:

> 
> On 2/24/26 4:08 AM, Joshua Hahn wrote:
> > On machines serving multiple workloads whose memory is isolated via the
> > memory cgroup controller, it is currently impossible to enforce a fair
> > distribution of toptier memory among the workloads, as the only
> > enforcable limits have to do with total memory footprint, but not where
> > that memory resides.
> >
> > This makes ensuring a consistent and baseline performance difficult, as
> > each workload's performance is heavily impacted by workload-external
> > factors wuch as which other workloads are co-located in the same host,
> > and the order at which different workloads are started.
> >
> > Extend the existing memory.high protection to be tier-aware in the
> > charging and enforcement to limit toptier-hogging for workloads.
> >
> > Also, add a new nodemask parameter to try_to_free_mem_cgroup_pages,
> > which can be used to selectively reclaim from memory at the
> > memcg-tier interection of a cgroup.
> >
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > ---
> >   include/linux/swap.h |  3 +-
> >   mm/memcontrol-v1.c   |  6 ++--
> >   mm/memcontrol.c      | 85 +++++++++++++++++++++++++++++++++++++-------
> >   mm/vmscan.c          | 11 +++---
> >   4 files changed, 84 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 0effe3cc50f5..c6037ac7bf6e 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -368,7 +368,8 @@ extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> >   						  unsigned long nr_pages,
> >   						  gfp_t gfp_mask,
> >   						  unsigned int reclaim_options,
> > -						  int *swappiness);
> > +						  int *swappiness,
> > +						  nodemask_t *allowed);
> >   extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
> >   						gfp_t gfp_mask, bool noswap,
> >   						pg_data_t *pgdat,
> > diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> > index 0b39ba608109..29630c7f3567 100644
> > --- a/mm/memcontrol-v1.c
> > +++ b/mm/memcontrol-v1.c
> > @@ -1497,7 +1497,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
> >   		}
> >   
> >   		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> > -				memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, NULL)) {
> > +				memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP,
> > +				NULL, NULL)) {
> >   			ret = -EBUSY;
> >   			break;
> >   		}
> > @@ -1529,7 +1530,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
> >   			return -EINTR;
> >   
> >   		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> > -						  MEMCG_RECLAIM_MAY_SWAP, NULL))
> > +						  MEMCG_RECLAIM_MAY_SWAP,
> > +						  NULL, NULL))
> >   			nr_retries--;
> >   	}
> >   
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 8aa7ae361a73..ebd4a1b73c51 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2184,18 +2184,30 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
> >   
> >   	do {
> >   		unsigned long pflags;
> > -
> > -		if (page_counter_read(&memcg->memory) <=
> > -		    READ_ONCE(memcg->memory.high))
> > +		nodemask_t toptier_nodes, *reclaim_nodes;
> > +		bool mem_high_ok, toptier_high_ok;
> > +
> > +		mt_get_toptier_nodemask(&toptier_nodes, NULL);
> > +		mem_high_ok = page_counter_read(&memcg->memory) <=
> > +			      READ_ONCE(memcg->memory.high);
> > +		toptier_high_ok = !(tier_aware_memcg_limits &&
> > +				    mem_cgroup_toptier_usage(memcg) >
> > +				    page_counter_toptier_high(&memcg->memory));
> > +		if (mem_high_ok && toptier_high_ok)
> >   			continue;
> >   
> > +		if (mem_high_ok && !toptier_high_ok)
> > +			reclaim_nodes = &toptier_nodes;
> > +		else
> > +			reclaim_nodes = NULL;
> 
> 
> IIUC The intent of this patch is to partition cgroup memory such that
> 0 → toptier_high is backed by higher-tier memory, and
> toptier_high → max is backed by lower-tier memory.
> 
> Based on this:
> 
> 1.If top-tier usage exceeds toptier_high, pages should be
>    demoted to the lower tier.
> 
> 2. If lower-tier usage exceeds (max - toptier_high), pages
>    should be swapped out.
> 
> 3. If total memory usage exceeds max, demotion should be
>    avoided and reclaim should directly swap out pages.
> 
> I think we are only handling case (1) in this patch. When
> mem_high_ok && !toptier_high_ok, we are reclaiming pages (demotion first)
> 
> However, if !mem_high_ok, the memcg reclaim path works as if
> there is no memory tiering  in cgroup. This can lead to more demotion
> and may eventually result in OOM.
> 
> Should we also handle cases (2) and (3) in this patch?

Hello Donet! I hope you are doing well.

For the second condition, should pages be swapped out? If a workload
is using 0 toptier memory (extreme case, let's say they haven't set
memory.low) then lower-tier should be able to use all the way up to
max memory.

Maybe you mean if lowtier_usage exceeds (max - toptier_usage) pages
should be swapped out? But if we rearrange this

                lowtier_usage >= max - toptier_usage
lowtier_usage + toptier_usage >= max
                  total_usage >= max

And this is just the memory.max check and is already handled by
existing reclaim semantics : -)

I think case 3 is a bit more nuanced. If we directly swap out from 
high tier and skip demotions, this is introducing a priority inversion
since memory in toptier should be hotter than memory in lowtier, so
we should prefer to swap out the colder memory in lowtier before
swapping out memory in toptier.

The idea was discussed at length at [1]. It also feels like an orthogonal
discussion since the behavior isn't related to toptier high or low
behaviors.

Please let me know what you think. Thank you, I hope you have a great day!
Joshua

[1] https://lore.kernel.org/linux-mm/20260317230720.990329-3-bingjiao@google.com/

