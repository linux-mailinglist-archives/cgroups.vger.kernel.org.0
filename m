Return-Path: <cgroups+bounces-12565-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C56CD4A37
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 04:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3C113006A5B
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 03:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D06325498;
	Mon, 22 Dec 2025 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VMFlsarU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D2262808
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 03:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766374453; cv=none; b=Gk/AA7GbigwJtRwpeF7oX0OeuKE5QSoJYjTiRIYLjCvxkAxGdVZpk421yzIfO5x6E+zPFHRPdR5UupbCm+OWTM68RknQ/l602EB51DliaZqcYg3/lARrnmvF7sK/DdEjZ29owrJhwYsrehVjIYK0Ox47sZG4TfPjbEdZSpZl1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766374453; c=relaxed/simple;
	bh=oM70Tf3uuJzEpVwt8qJafyICt12TZ9lSmVsTOwXHJzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIVe/9y/i+GtXxmdhvngzH6gV3tSI5l4vB82fDr6j+7dlY9Z/Rdx72cTpnkz6LrpWMTYC0OkbJWgRaFDaasoHJc7OE0rCc41q/X/lm051zpizvHCGCUPMxkpRoaLB/ncwb4mcuRE3WTifQSORYWFiNKtpWfewKr4P+OjTTGj9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VMFlsarU; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <75f31ec7-1605-4f50-9adb-6d84e9e81101@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766374443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGqa+G9yooe1hEmvBfRcJmjA7QA8SkNJctdApIJNl98=;
	b=VMFlsarUjmbbIJb0UCStjyxyJrACCyd77zr3JpIq+0OrxRPujQeEJ28zq7ZaQcUjjSRK+m
	45woNINIu2xTjOA9jAQGZrhluNaExT/eu5KnzscPJgAt2nP00wenDmKJuQiyJw2LbGvIUu
	PXSVuQFB4EVTsQET3xVVnLZC6boeT7A=
Date: Mon, 22 Dec 2025 11:33:48 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 17/28] mm: thp: prevent memory cgroup release in
 folio_split_queue_lock{_irqsave}()
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4cb81ea06298a3b41873b7086bfc68f64b2ba8be.1765956025.git.zhengqi.arch@bytedance.com>
 <aUMuRfPVxkfccdmp@cmpxchg.org>
 <ejywj2fho37z4zdtgvryxzsztgtdrfop4ekenee4fewholyugq@xrbvtg5ui3ty>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <ejywj2fho37z4zdtgvryxzsztgtdrfop4ekenee4fewholyugq@xrbvtg5ui3ty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/20/25 9:11 AM, Shakeel Butt wrote:
> On Wed, Dec 17, 2025 at 05:27:17PM -0500, Johannes Weiner wrote:
>> On Wed, Dec 17, 2025 at 03:27:41PM +0800, Qi Zheng wrote:
>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> In the near future, a folio will no longer pin its corresponding memory
>>> cgroup. To ensure safety, it will only be appropriate to hold the rcu read
>>> lock or acquire a reference to the memory cgroup returned by
>>> folio_memcg(), thereby preventing it from being released.
>>>
>>> In the current patch, the rcu read lock is employed to safeguard against
>>> the release of the memory cgroup in folio_split_queue_lock{_irqsave}().
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>> ---
>>>   mm/huge_memory.c | 16 ++++++++++++++--
>>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 12b46215b30c1..b9e6855ec0b6a 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1154,13 +1154,25 @@ split_queue_lock_irqsave(int nid, struct mem_cgroup *memcg, unsigned long *flags
>>>   
>>>   static struct deferred_split *folio_split_queue_lock(struct folio *folio)
>>>   {
>>> -	return split_queue_lock(folio_nid(folio), folio_memcg(folio));
>>> +	struct deferred_split *queue;
>>> +
>>> +	rcu_read_lock();
>>> +	queue = split_queue_lock(folio_nid(folio), folio_memcg(folio));
>>> +	rcu_read_unlock();
>>
>> Ah, the memcg destruction path is acquiring the split queue lock for
>> reparenting. Once you have it locked, it's safe to drop the rcu lock.
> 
> Qi, please add the above explanation in a comment and with that:

OK, will do.

> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks!



