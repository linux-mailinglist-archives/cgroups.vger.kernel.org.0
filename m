Return-Path: <cgroups+bounces-16603-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wKxKDgQTIGoEvgAAu9opvQ
	(envelope-from <cgroups+bounces-16603-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 13:41:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0538637297
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 13:41:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=DxnyhF3A;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16603-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16603-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89CD5301A9AB
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C283B3C10;
	Wed,  3 Jun 2026 11:41:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1239387590
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 11:41:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486900; cv=none; b=dHwooHqJdN+92kbl17YUadi13d61+BQbjmlwMKIj+ofFE+cPmAN2yYuS57dmtA8Us6OP/LVtowIn4Wjnr7Vr+WgjkG0/vz7+CUdwM7G9KWjzcoxJebwGHsDvLZTz6HzGNuo3BIVJeI3xDynEUrdckSxX1KredbM6H5rJ+JuFZk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486900; c=relaxed/simple;
	bh=hc2Cp48soPbJR5D4VEbHGsIlJEiWpmw2CIjouWpcxv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKO96nmIBEoHV9PgAiuQOlcWHxsnUz8S37xQZdx5zHcae7jeBZz2QB9yBLT7pT+/KcnWuwGwc3je6suSU3P+eUDWglbXjQn7uSr28y3m1UkKmDn164mVwFnc/nO16t8aZYXrhN5LugOkFOpffjsMVVmtZkfJOodk/WxNQ0R7Nyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=DxnyhF3A; arc=none smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9157f7c1c0eso176532585a.1
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 04:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1780486898; x=1781091698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QunYua40k0szh1VG1CUNujPHNQ9BbnVbc6N14Ce3Fc0=;
        b=DxnyhF3Af/UqIH/Gh9ggung2xDuA8LGmil4P47D3aE1dYeHgDBcqrGciv4xvqIMT09
         zJ2Ndy8wiiWcgRqjrQqhHNmQelut5LecnGz6AvmziiA6HC+QkhL5u+AsCHMW7jg6H7hU
         +7idKsAK7E0Yf2YuN1msKW1hWSnXwoeH7SBP8dWDS2JWhyP47WOx26xdzealeqUxxU3E
         CznKZBppq/WMUHxdlEFdJOSIVndPS/ulhHbN7R+meJb2NUwFuE8s74CTUEx1saS9q2vd
         RWNt1amAANXpAgUTKaWBQRN+lh5MSKUgUZfZJZPn0VedRywfpXo2Qj9qXusGK6gZCv3n
         if8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780486898; x=1781091698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QunYua40k0szh1VG1CUNujPHNQ9BbnVbc6N14Ce3Fc0=;
        b=KZdYzyQ9JMrBGjAhm2SdzHeyVMQvepIO79DAflIWtSHY8K4LJgecWdcE+ZeqEMkQKz
         428jZvlS5S5y3Tv7GAdmOI+Z+jzjd3zUEEj8y4/aAaS0yWeGfKZ4IFal9jhYvg7eo6ft
         Otkun1dAoogot+hvd0UCdbL/b69m4ZKyZ2VO+9yz5370ur5ISnk8XeKindh6ERJuPJJq
         n62fTLDUGKSn7wWeRg25ztfQnB4Tp0vn9AHVH9x0Rl3Dklq6TnX2y4xvjYacwhU4fa1J
         qsTfGf47g9Ti9ThhzWg8THWLING+zdwyg+XgHvv3peBwPMmjgAO4p5UGjTYvL0LqGfiB
         Bgww==
X-Forwarded-Encrypted: i=1; AFNElJ+Ts8/Nvp5gEhuDWTpo2iuMJ5fK3k4s034DMthktiM/Lb5jE/QpxgvnwJGs/5U3Cb867IY8g9+T@vger.kernel.org
X-Gm-Message-State: AOJu0YwErd4eX0mp0Ks94OiM4KEAI/jUTeupGEjTY/5NBneLARx27PYm
	hjVv6C4DuKKs7mNFqvSoZeNNL5qvTIB3yQgoIMJg/sAWT3Q0MmHUjS1uTdl03GHv3+k=
X-Gm-Gg: Acq92OG/kdUanfcIbKwZ7J14VkezsYBzCieIHyKxUy1BiN2zo8YCBCKllgpMXAdOMrY
	KuayvU9b5ym2haQEp9bpquDk4NbcfYHFIAdU3I/CeMZZ6R2HMJxFVxtg5kmBiP5QLtdAf4+ERQW
	7jCXcMdRtL3CAGgwHVOCXiWcgjYQIAkRCHILPEXHzF55NoJAFX2agy/XJgrK1NbZZSBn0HxlC2U
	evnXZcbRqGlVb/zN+uDmWIJYECYzTdpDY0V5gP8NbKGikeJf+4s5UCqYUHOfpaClYy7YRwQqoBq
	vmzdnV8ccAOgZgGdd7VkK4WQ+Csj1DR91cBr1p31cqA1aQOKkalIP6krMjc9FUg62teSs6k89vW
	dU1UStT6ju64yFAU02OaWcfI7DAndTnONVO4RtVpZZDY4ltSvp9C1CHav/Dd4RuA2CKbpbETDG3
	XyBD9x6ubgAO6beKpGJW5v+UGmyh26saPr
X-Received: by 2002:a05:620a:a0d2:20b0:915:79c8:ec9c with SMTP id af79cd13be357-9158a798ff1mr350904085a.35.1780486897606;
        Wed, 03 Jun 2026 04:41:37 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd263003sm17426686d6.42.2026.06.03.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:41:36 -0700 (PDT)
Date: Wed, 3 Jun 2026 07:41:32 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	shakeel.butt@linux.dev, mhocko@kernel.org, david@fromorbit.com,
	roman.gushchin@linux.dev, muchun.song@linux.dev, qi.zheng@linux.dev,
	yosry.ahmed@linux.dev, ziy@nvidia.com, liam@infradead.org,
	usama.arif@linux.dev, kas@kernel.org, vbabka@kernel.org,
	ryncsn@gmail.com, zaslonko@linux.ibm.com, gor@linux.ibm.com,
	baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com,
	npache@redhat.com, ryan.roberts@arm.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] mm: switch THP shrinker to list_lru
Message-ID: <aiAS7GxsffqXWILD@cmpxchg.org>
References: <ah9PGv12mqai84ES@cmpxchg.org>
 <20260603044426.54863-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603044426.54863-1-lance.yang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16603-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_RECIPIENTS(0.00)[m:lance.yang@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:david@fromorbit.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:qi.zheng@linux.dev,m:yosry.ahmed@linux.dev,m:ziy@nvidia.com,m:liam@infradead.org,m:usama.arif@linux.dev,m:kas@kernel.org,m:vbabka@kernel.org,m:ryncsn@gmail.com,m:zaslonko@linux.ibm.com,m:gor@linux.ibm.com,m:baolin.wang@linux.alibaba.com,m:baohua@kernel.org,m:dev.jain@arm.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0538637297

On Wed, Jun 03, 2026 at 12:44:26PM +0800, Lance Yang wrote:
> 
> On Tue, Jun 02, 2026 at 05:46:02PM -0400, Johannes Weiner wrote:
> >On Mon, Jun 01, 2026 at 04:36:52PM +0800, Lance Yang wrote:
> >> As the changelog above says, the old queue is per-memcg only, rather
> >> than per-memcg-per-node. So reclaim on one node can still walk the whole
> >> memcg queue and split underused THPs from other nodes in the same memcg.
> >> 
> >> But I think the new one can lose reclaim in the cgroup.memory=nokmem
> >> case ...
> >> 
> >> With nokmem, the deferred shrinker can still run from memcg reclaim,
> >> because it is SHRINKER_NONSLAB. But the list_lru is no longer per-memcg:
> >> 
> >> __list_lru_init() clears memcg_aware,
> >> 
> >> 	if (mem_cgroup_kmem_disabled())
> >> 		memcg_aware = false;
> >> 
> >> so list_lru_from_memcg_idx() falls back to the shared node list:
> >> 
> >> static inline struct list_lru_one *
> >> list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
> >> {
> >> 	if (list_lru_memcg_aware(lru) && idx >= 0) {
> >> [...]
> >> 	}
> >> 	return &lru->node[nid].lru;
> >> }
> >> 
> >> That makes the shrinker bit unreliable. __list_lru_add() still sets the
> >> bit on the memcg passed in, but only when the list goes from empty to
> >> non-empty:
> >> 
> >> bool __list_lru_add(struct list_lru *lru, struct list_lru_one *l,
> >> 		    struct list_head *item, int nid,
> >> 		    struct mem_cgroup *memcg)
> >> {
> >> 	if (list_empty(item)) {
> >> [...]
> >> 		if (!l->nr_items++)
> >> 			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
> >> [...]
> >> 		return true;
> >> 	}
> >> 	return false;
> >> }
> >> 
> >> If memcg A adds the first folio, A gets the bit. If memcg B later adds a
> >> folio to the same shared list, B does not get a bit, because the list
> >> was already non-empty.
> >> 
> >> So in the A-first/B-later case, reclaim from B may not call the deferred
> >> shrinker at all. The shared list is scanned from memcg reclaim only if
> >> reclaim runs from the memcg that has the bit, such as A here, or from
> >> global reclaim :)
> >> 
> >> Anyway, only after the shared list is emptied does the next memcg to add
> >> a folio get to be the one with the bit, IIUC :)
> >
> >Sorry for the delay, this took me a bit to think about. The shrinker
> >code is a mess.
> >
> >I read it the same way you do. And this is true for all list_lru users
> >when nokmem is set: we just set random nonsense shrinker bits.
> >
> >HOWEVER, the generic shrinker code fixes that up by IGNORING random
> >shrinker bits like this when !memcg_kmem_online(). And shrinking
> >correctly happens only against the shared root queue when the reclaim
> >iterator walks root_mem_cgroup.
> >
> >HOWEVER, the THP shrinker explicitly sets SHRINKER_NONSLAB, which in
> >turn overrides the previous override. So yes there is a weirdness: we
> >get the root cgroup invocation against the shared queue, and then one
> >more time triggered by that random memcg bit.
> >
> >The most direct fix is to just drop SHRINKER_NONSLAB. It declares
> >independence from kmem, which is no longer true.
> >
> >Cleaning up the shrinker code is left for another day.
> 
> Thanks for working on this!
> 
> Wondering if this fix trades one problem for another, though ...
> 
> Before this series, the deferred split shrinker had a real per-memcg
> queue. Even with cgroup.memory=nokmem, memcg reclaim could still scan
> that memcg's own deferred_split_queue:
> 
> memcg reclaim -> deferred split shrinker -> sc->memcg->deferred_split_queue
> 
> With the fix, nokmem + w/o SHRINKER_NONSLAB falls back to a
> non-memcg-aware shrinker:
> 
> memcg reclaim -> skip deferred split shrinker
> 
> root/global reclaim -> deferred split shrinker -> shared list_lru
> 
> Is that expected? There woud be no memcg-driven deferred split reclaim
> under nokmem, IIUC ...

Yes, this is all correct. list_lru is still inherently tied to the
kmem component of memcg (memcg_kmem_id()).

So without kmem, no isolation. But without kmem, no isolation *for a
lot of stuff*. It's a legacy knob when slab accounting was new and
expensive. But so many things depend on it now, disabling it just
punches a nassive hole into memcg functionality and isolation
coverage. It's not a sanctioned production use flag.

This change is negligible from a memcg semantics POV.

> Not sure what the right fix is, as I am not a memcg expert ...

