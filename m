Return-Path: <cgroups+bounces-16604-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WOMqFCEZIGoLvwAAu9opvQ
	(envelope-from <cgroups+bounces-16604-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 14:08:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A3E637537
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 14:08:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="X/BAccuz";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16604-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16604-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9A5130453A5
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C54466B52;
	Wed,  3 Jun 2026 11:53:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC13441054
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 11:53:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487618; cv=none; b=mRL70DmaWd1FzHLqiYbMO8OKAD/4fT/LzzhQGlqLs6JPjaSqLNdQW5pSX88JAK/V9tqO+eo3Wyrvoi4vYMv4ROn1QWI/VE6Dr53F5gatqyPgk8LC7ak5H5wY42j94EAgzYMCTXxekHhDZVrXdPbLQAljmWpOLkBKUZzOoOHmBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487618; c=relaxed/simple;
	bh=xV5X40UJB+xxHtXRfMMr2kdqCKKSoanWJV4O5fQjubE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNMUlPjHy5h5qM67jbq43pOzR1DaJN0ajhNt2zbuSLVh4bmORktW/4tG7a0X/U0i+/OAGH4FwjQj1GrR9TMCqAFAC8D9bdFgshJBpItAmfuPJuLTLrqaZ2CF7vTWuWUCusWZYaqMGKFixz6aKMYDjWqjC/UnCjDw1/KWc9/B0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X/BAccuz; arc=none smtp.client-ip=95.215.58.182
Message-ID: <4b2ebbf7-8c5e-45ca-a17c-111f68e2324c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780487613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oO32gU/6GqPqmsbPD/EqqtNbEEfCeRvWof7NPW20STY=;
	b=X/BAccuz5VRKWoWp8Tw5a2hyusMTKMdhoDQBENIqijF2kktRaXNzuLf0junIel8CkvdmcH
	7CkezdTUzOvIYcG1228DGzW2sck4oSGXaI2Nlo29boIh8aW+zNXC1v/kuuOV14NgNLfCos
	zI20XgSI/HCz3BejCUKEmsHCU+3KC+A=
Date: Wed, 3 Jun 2026 19:53:17 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/9] mm: switch THP shrinker to list_lru
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, david@fromorbit.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, qi.zheng@linux.dev,
 yosry.ahmed@linux.dev, ziy@nvidia.com, liam@infradead.org,
 usama.arif@linux.dev, kas@kernel.org, vbabka@kernel.org, ryncsn@gmail.com,
 zaslonko@linux.ibm.com, gor@linux.ibm.com, baolin.wang@linux.alibaba.com,
 baohua@kernel.org, dev.jain@arm.com, npache@redhat.com,
 ryan.roberts@arm.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <ah9PGv12mqai84ES@cmpxchg.org>
 <20260603044426.54863-1-lance.yang@linux.dev> <aiAS7GxsffqXWILD@cmpxchg.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aiAS7GxsffqXWILD@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16604-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:david@fromorbit.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:qi.zheng@linux.dev,m:yosry.ahmed@linux.dev,m:ziy@nvidia.com,m:liam@infradead.org,m:usama.arif@linux.dev,m:kas@kernel.org,m:vbabka@kernel.org,m:ryncsn@gmail.com,m:zaslonko@linux.ibm.com,m:gor@linux.ibm.com,m:baolin.wang@linux.alibaba.com,m:baohua@kernel.org,m:dev.jain@arm.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4A3E637537



On 2026/6/3 19:41, Johannes Weiner wrote:
> On Wed, Jun 03, 2026 at 12:44:26PM +0800, Lance Yang wrote:
>>
>> On Tue, Jun 02, 2026 at 05:46:02PM -0400, Johannes Weiner wrote:
>>> On Mon, Jun 01, 2026 at 04:36:52PM +0800, Lance Yang wrote:
>>>> As the changelog above says, the old queue is per-memcg only, rather
>>>> than per-memcg-per-node. So reclaim on one node can still walk the whole
>>>> memcg queue and split underused THPs from other nodes in the same memcg.
>>>>
>>>> But I think the new one can lose reclaim in the cgroup.memory=nokmem
>>>> case ...
>>>>
>>>> With nokmem, the deferred shrinker can still run from memcg reclaim,
>>>> because it is SHRINKER_NONSLAB. But the list_lru is no longer per-memcg:
>>>>
>>>> __list_lru_init() clears memcg_aware,
>>>>
>>>> 	if (mem_cgroup_kmem_disabled())
>>>> 		memcg_aware = false;
>>>>
>>>> so list_lru_from_memcg_idx() falls back to the shared node list:
>>>>
>>>> static inline struct list_lru_one *
>>>> list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
>>>> {
>>>> 	if (list_lru_memcg_aware(lru) && idx >= 0) {
>>>> [...]
>>>> 	}
>>>> 	return &lru->node[nid].lru;
>>>> }
>>>>
>>>> That makes the shrinker bit unreliable. __list_lru_add() still sets the
>>>> bit on the memcg passed in, but only when the list goes from empty to
>>>> non-empty:
>>>>
>>>> bool __list_lru_add(struct list_lru *lru, struct list_lru_one *l,
>>>> 		    struct list_head *item, int nid,
>>>> 		    struct mem_cgroup *memcg)
>>>> {
>>>> 	if (list_empty(item)) {
>>>> [...]
>>>> 		if (!l->nr_items++)
>>>> 			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
>>>> [...]
>>>> 		return true;
>>>> 	}
>>>> 	return false;
>>>> }
>>>>
>>>> If memcg A adds the first folio, A gets the bit. If memcg B later adds a
>>>> folio to the same shared list, B does not get a bit, because the list
>>>> was already non-empty.
>>>>
>>>> So in the A-first/B-later case, reclaim from B may not call the deferred
>>>> shrinker at all. The shared list is scanned from memcg reclaim only if
>>>> reclaim runs from the memcg that has the bit, such as A here, or from
>>>> global reclaim :)
>>>>
>>>> Anyway, only after the shared list is emptied does the next memcg to add
>>>> a folio get to be the one with the bit, IIUC :)
>>>
>>> Sorry for the delay, this took me a bit to think about. The shrinker
>>> code is a mess.
>>>
>>> I read it the same way you do. And this is true for all list_lru users
>>> when nokmem is set: we just set random nonsense shrinker bits.
>>>
>>> HOWEVER, the generic shrinker code fixes that up by IGNORING random
>>> shrinker bits like this when !memcg_kmem_online(). And shrinking
>>> correctly happens only against the shared root queue when the reclaim
>>> iterator walks root_mem_cgroup.
>>>
>>> HOWEVER, the THP shrinker explicitly sets SHRINKER_NONSLAB, which in
>>> turn overrides the previous override. So yes there is a weirdness: we
>>> get the root cgroup invocation against the shared queue, and then one
>>> more time triggered by that random memcg bit.
>>>
>>> The most direct fix is to just drop SHRINKER_NONSLAB. It declares
>>> independence from kmem, which is no longer true.
>>>
>>> Cleaning up the shrinker code is left for another day.
>>
>> Thanks for working on this!
>>
>> Wondering if this fix trades one problem for another, though ...
>>
>> Before this series, the deferred split shrinker had a real per-memcg
>> queue. Even with cgroup.memory=nokmem, memcg reclaim could still scan
>> that memcg's own deferred_split_queue:
>>
>> memcg reclaim -> deferred split shrinker -> sc->memcg->deferred_split_queue
>>
>> With the fix, nokmem + w/o SHRINKER_NONSLAB falls back to a
>> non-memcg-aware shrinker:
>>
>> memcg reclaim -> skip deferred split shrinker
>>
>> root/global reclaim -> deferred split shrinker -> shared list_lru
>>
>> Is that expected? There woud be no memcg-driven deferred split reclaim
>> under nokmem, IIUC ...
> 
> Yes, this is all correct. list_lru is still inherently tied to the
> kmem component of memcg (memcg_kmem_id()).
> 
> So without kmem, no isolation. But without kmem, no isolation *for a
> lot of stuff*. It's a legacy knob when slab accounting was new and
> expensive. But so many things depend on it now, disabling it just
> punches a nassive hole into memcg functionality and isolation
> coverage. It's not a sanctioned production use flag.
> 
> This change is negligible from a memcg semantics POV.

Thanks for clarifying!

No strong objection from me. Just wanted to call out the nokmem
behavior change and hear what folks think :D

>> Not sure what the right fix is, as I am not a memcg expert ...


