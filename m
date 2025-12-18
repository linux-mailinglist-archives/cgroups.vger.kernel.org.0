Return-Path: <cgroups+bounces-12507-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F9BCCBF81
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 14:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 778ED305E1DF
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDC3313E23;
	Thu, 18 Dec 2025 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vld/X1XQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE32E2DFB
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063847; cv=none; b=b49RdPazXMlZXsady2HTyBQVXUhnpBpCMCo2w3frKmLrmvEXog+RMfIwDmrIQkOxKk5wdaHgtAM04rSAccWM6Xznn+pGhnsgCoSaW/lPLuJVSVOdgcSbo2DxP8whvkVCclheADFCby0IrwhpDXGBF9no6Ub15I5Gsa9jf5i9i5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063847; c=relaxed/simple;
	bh=dBL1XlDlrdmd0EI+bNrsqr6hdTGHlCngf7MUXsWkKJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3Roh3bxNSPhYdhW74M2KVXje570OZ625+EA8VDVB5Ib1rzlkLINN7gEaaxpRQ+mzpUJoQZwB6k++2YzzVKxDV7H9ja7pvPaL3xPhgdn4BPfKDvK6F5i+uGlTLQnoZKXpdc0VxONQixprOUuvqA1TWMJXKt5k1izkcXkV5Ct4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vld/X1XQ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c1dfbf2f-123e-49c7-9a05-c593e8a1b43a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766063837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrnloR37d7v9/SAkXdgcilFjy/jvJ7jYp/30DAx8M64=;
	b=vld/X1XQQrbVF44u/mRdkjbB9pSzWBcemyKWchoxfSV3s/EgcyWQdaGZxSEalDtj7ksg42
	TUy9FBWMLYA+LDMHysOJHZwPIM5FLtYU58RAykLZjSvsnKS2Jpyo5bcxMEhNIrnEGW9iko
	fm66XNkTWDTCO2V7FyhrIL5LK+roYxM=
Date: Thu, 18 Dec 2025 21:17:06 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 23/28] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <6d643ea41dd89134eb3c7af96f5bfb3531da7aa7.1765956026.git.zhengqi.arch@bytedance.com>
 <aUP6_o9WqPv8Y7d-@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aUP6_o9WqPv8Y7d-@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 9:00 PM, Johannes Weiner wrote:
> On Wed, Dec 17, 2025 at 03:27:47PM +0800, Qi Zheng wrote:
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
>> ---
>>   include/linux/memcontrol.h | 26 ++++++++-----------
>>   mm/compaction.c            | 29 ++++++++++++++++-----
>>   mm/memcontrol.c            | 53 +++++++++++++++++++-------------------
>>   3 files changed, 61 insertions(+), 47 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 69c4bcfb3c3cd..85265b28c5d18 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -740,7 +740,11 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>>    * folio_lruvec - return lruvec for isolating/putting an LRU folio
>>    * @folio: Pointer to the folio.
>>    *
>> - * This function relies on folio->mem_cgroup being stable.
>> + * The user should hold an rcu read lock to protect lruvec associated with
>> + * the folio from being released. But it does not prevent binding stability
>> + * between the folio and the returned lruvec from being changed to its parent
>> + * or ancestor (e.g. like folio_lruvec_lock() does that holds LRU lock to
>> + * prevent the change).
> 
> Can you please make this separate paragraphs to highlight the two
> distinct modes of access? Something like this:
> 
> Call with rcu_read_lock() held to ensure the lifetime of the returned
> lruvec. Note that this alone will NOT guarantee the stability of the
> folio->lruvec association; the folio can be reparented to an ancestor
> if this races with cgroup deletion.
> 
> Use folio_lruvec_lock() to ensure both lifetime and stability of the
> binding. Once a lruvec is locked, folio_lruvec() can be called on
> other folios, and their binding is stable if the returned lruvec
> matches the one the caller has locked. Useful for lock batching.

OK, will do in the next version.

> 
> Everything else looks good to me.
> 
> Thanks for putting so much effort into making these patches clean,
> well-documented, and the series so easy to review!
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!



