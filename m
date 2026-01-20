Return-Path: <cgroups+bounces-13319-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGl/CaRqcGkVXwAAu9opvQ
	(envelope-from <cgroups+bounces-13319-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 06:56:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8340A51C7A
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 06:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FA9D643BD9
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 11:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF3040757D;
	Tue, 20 Jan 2026 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FoBP3E4u"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317822D6E61
	for <cgroups@vger.kernel.org>; Tue, 20 Jan 2026 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909912; cv=none; b=BNdL2cTggolB+iW7+rTJIi3IYe7SYwa95SJR5l6TxER7J5ly8mO1rIEVPMvhomeI2P2upGLggkoQvsGdQuadr/NO/YvcgmRBpD4fwXPizOQWEJ2BALojkz8rQnZBDBVJp3cFVUCesGtAnCmUk9yGUdRjo0ef7+c641TRR4a0aNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909912; c=relaxed/simple;
	bh=DcBZF4Ct6AA2MM2+TYCml14It0rlK9s2VHXmWNBQ/4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gM7ZrubyZqqy5shvnwDainLIhAmmMYkryWknbS3TTZGwzr0MCRcZ/QNVpxrEFXjqXwW3LJ/+BVVpyv5nhoS4N9Au1BCyGe2CoYcGWhKkRMdwELywadBzTCPQ2YYY56L9Ks1f7coHZErBAxbU6gLFUbXtDfQdggkuOLI/0rtM/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FoBP3E4u; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <88d90d30-8f54-43f5-98d6-1769aa05a10a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768909908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9xxVtMuSeOSiPFHs2DPvF1bZM+k4doJowUTIgEXb84=;
	b=FoBP3E4uU4cp25iVs0YnuLXf8CmTrLWVI1GO/15ajs+mzhMyEradq4fhK4j0VFhngoJ5kb
	qw0gnnUyDkR14vYXjGlGgA9V4nPaMOxs8iZwchUgWN6gFNOpS0ruLM+dl7Uex3jPp9EbCf
	oGjXSaTppQvh1No36QGTU8/5TF9RLj8=
Date: Tue, 20 Jan 2026 19:51:29 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 24/30] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <0252f9acc29d4b1e9b8252dc003aff065c8ac1f6.1768389889.git.zhengqi.arch@bytedance.com>
 <aW86_5SOdtQQnVr7@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aW86_5SOdtQQnVr7@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13319-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.dev:mid,linux.dev:dkim,bytedance.com:email]
X-Rspamd-Queue-Id: 8340A51C7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/20/26 4:21 PM, Harry Yoo wrote:
> On Wed, Jan 14, 2026 at 07:32:51PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> The following diagram illustrates how to ensure the safety of the folio
>> lruvec lock when LRU folios undergo reparenting.
>>
>> In the folio_lruvec_lock(folio) function:
>> ```
>>      rcu_read_lock();
>> retry:
>>      lruvec = folio_lruvec(folio);
>>      /* There is a possibility of folio reparenting at this point. */
>>      spin_lock(&lruvec->lru_lock);
>>      if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
>>          /*
>>           * The wrong lruvec lock was acquired, and a retry is required.
>>           * This is because the folio resides on the parent memcg lruvec
>>           * list.
>>           */
>>          spin_unlock(&lruvec->lru_lock);
>>          goto retry;
>>      }
>>
>>      /* Reaching here indicates that folio_memcg() is stable. */
>> ```
>>
>> In the memcg_reparent_objcgs(memcg) function:
>> ```
>>      spin_lock(&lruvec->lru_lock);
>>      spin_lock(&lruvec_parent->lru_lock);
>>      /* Transfer folios from the lruvec list to the parent's. */
>>      spin_unlock(&lruvec_parent->lru_lock);
>>      spin_unlock(&lruvec->lru_lock);
>> ```
>>
>> After acquiring the lruvec lock, it is necessary to verify whether
>> the folio has been reparented. If reparenting has occurred, the new
>> lruvec lock must be reacquired. During the LRU folio reparenting
>> process, the lruvec lock will also be acquired (this will be
>> implemented in a subsequent patch). Therefore, folio_memcg() remains
>> unchanged while the lruvec lock is held.
>>
>> Given that lruvec_memcg(lruvec) is always equal to folio_memcg(folio)
>> after the lruvec lock is acquired, the lruvec_memcg_debug() check is
>> redundant. Hence, it is removed.
>>
>> This patch serves as a preparation for the reparenting of LRU folios.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> ---
>>   include/linux/memcontrol.h | 45 +++++++++++++++++++----------
>>   include/linux/swap.h       |  1 +
>>   mm/compaction.c            | 29 +++++++++++++++----
>>   mm/memcontrol.c            | 59 +++++++++++++++++++++-----------------
>>   mm/swap.c                  |  4 +++
>>   5 files changed, 91 insertions(+), 47 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 4b6f20dc694ba..26c3c0e375f58 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -742,7 +742,15 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>>    * folio_lruvec - return lruvec for isolating/putting an LRU folio
>>    * @folio: Pointer to the folio.
>>    *
>> - * This function relies on folio->mem_cgroup being stable.
>> + * Call with rcu_read_lock() held to ensure the lifetime of the returned lruvec.
>> + * Note that this alone will NOT guarantee the stability of the folio->lruvec
>> + * association; the folio can be reparented to an ancestor if this races with
>> + * cgroup deletion.
>> + *
>> + * Use folio_lruvec_lock() to ensure both lifetime and stability of the binding.
>> + * Once a lruvec is locked, folio_lruvec() can be called on other folios, and
>> + * their binding is stable if the returned lruvec matches the one the caller has
>> + * locked. Useful for lock batching.
>>    */
>>   static inline struct lruvec *folio_lruvec(struct folio *folio)
>>   {
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 548e67dbf2386..a1573600d4188 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> diff --git a/mm/swap.c b/mm/swap.c
>> index cb1148a92d8ec..7e53479ca1732 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -284,9 +286,11 @@ void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
>>   		}
>>   
>>   		spin_unlock_irq(&lruvec->lru_lock);
>> +		rcu_read_unlock();
>>   		lruvec = parent_lruvec(lruvec);
> 
> It looks bit weird to call parent_lruvec(lruvec) outside RCU read lock
> because the reason why it holds RCU read lock is to prevent release of
> memory cgroup and its lruvec.
> 
> I guess this isn't broken (for now) because all callers of
> lru_note_cost_unlock_irq() are holding a reference to the memcg?

I checked all the callers again, and they do indeed hold the refcnt
for the memcg, so it's safe for now. But it seems rather fragile,
perhaps we should also include parent_lruvec() within the RCU lock.

> 
>>   		if (!lruvec)
>>   			break;
>> +		rcu_read_lock();
>>   		spin_lock_irq(&lruvec->lru_lock);
>>   	}
>>   }
> 


