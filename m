Return-Path: <cgroups+bounces-12602-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9686CD83C8
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 07:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A73B83014631
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 06:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5752FF15E;
	Tue, 23 Dec 2025 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p3pNAUjj"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F42FC007
	for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766470464; cv=none; b=AK1n/IY+UU+ihidd4PqzkID50qCF0RY68ZraO+gDN1S0WzvnkRtSWXOxx9j+Txz99UkPoE0yERhpUK+dPrmB1vQX1VkAc7Otf4rkvWVyDsZ3PtYs34Ryu26toDf8umakJVLXEeaP5/1lGsEdZI9WUmxPZsMZCXZnoV3uXYO+xhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766470464; c=relaxed/simple;
	bh=Kh4BnDH5WZg6tz2pomCt0ntKrUSlBhyET3ZZcmbUeGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjIVCDG5kr8yVDgzlzBsNkdla5Yc71RPvPyXcHkhY59ZyYM5o86dN4nXaJLLM3cugUddY45uePNsfzLc6PCes+Un8qraAIvsCyJ9pIv2mOz6Ejy/tmfr8WW43pa5WH8WD/kDOZB9OC7bgAXbIjfLEvG1p0cefeJMpOBAONazlg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p3pNAUjj; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ffc68aa4-cb9d-465f-8c6f-9cd7315eb560@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766470460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1Vxe9QHr773cXPHburX7fEkwO6UQV/y6BuQFvRR+UI=;
	b=p3pNAUjj1hv8lsweRgKt7TABdptgSaVSplZqD1MmYcacqWp56Jo6BybVFtDaZv6+69kQnc
	oEJurwFFBic9lI2wg4vy0AVYfl1Ixwo5Mq6tVEPaKXdhWG1WFv+xQ0BI3dBp4RgSvRuTly
	bbrH8k2y4SlComNwLN0LoW3Q2PL0ZVo=
Date: Tue, 23 Dec 2025 14:14:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 23/28] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
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
 <jdhf6h7weedyentvyaqsr3n3v7dlj4n6k3mrryn2hkyhc255cl@kmexszfblh6s>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <jdhf6h7weedyentvyaqsr3n3v7dlj4n6k3mrryn2hkyhc255cl@kmexszfblh6s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/20/25 10:03 AM, Shakeel Butt wrote:
> On Wed, Dec 17, 2025 at 03:27:47PM +0800, Qi Zheng wrote:
>> @@ -1232,14 +1221,20 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
>>    * - folio frozen (refcount of 0)
>>    *
>>    * Return: The lruvec this folio is on with its lock held and interrupts
>> - * disabled.
>> + * disabled and rcu read lock held.
>>    */
>>   struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
>>   {
>> -	struct lruvec *lruvec = folio_lruvec(folio);
>> +	struct lruvec *lruvec;
>>   
>> +	rcu_read_lock();
>> +retry:
>> +	lruvec = folio_lruvec(folio);
>>   	spin_lock_irq(&lruvec->lru_lock);
>> -	lruvec_memcg_debug(lruvec, folio);
>> +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
>> +		spin_unlock_irq(&lruvec->lru_lock);
>> +		goto retry;
>> +	}
> 
> So after this patch, all folio_lruvec_lock_irq() calls should be paired
> with lruvec_unlock_irq() but lru_note_cost_refault() is calling
> folio_lruvec_lock_irq() without the paired lruvec_unlock_irq(). It is
> using lru_note_cost_unlock_irq() for unlocking lru lock and thus rcu
> read unlock is missed.

Indeed. Will fix in the next version.

> 
> Beside fixing this, I would suggest to add __acquire()/__release() tags
> for both lru lock and rcu for all these functions.

OK, will do.


Thanks,
Qi

> 


