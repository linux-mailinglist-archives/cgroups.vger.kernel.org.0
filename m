Return-Path: <cgroups+bounces-12476-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A4CCA903
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 08:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27AB53015DD9
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 07:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D433122B;
	Thu, 18 Dec 2025 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qqYeirWs"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C6331231
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040634; cv=none; b=G6bl9vU20Q6V5QBtyg11P7KraVxY9OHXan3GGm7GgoGQQqEhVKPBXtHmfznIb6FLKZWwdgNjFX2Wl4jW15V59Z9Kwt0syAKdGghI2uMUOz9WrazvorgRAx6ApsDvyth9P+0hxmoBOrVhB1egnD+ZFHPzgPGP51cv/o+dKoev3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040634; c=relaxed/simple;
	bh=V3pWVQx7qFzNjskJIdOmv8h/kW8OOhv/SOKrPzO4Cmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNMReGtj1Q4uA51Ka/rNEPxfbJdl12CkNncfe9LavfZ+BKEDEHCzzEfss/MgONt+e0EVZp9alPhFA9tu3hN7kEHmxi5T1H35JfbT8xyifoAM5hCVgQRAetCmI/nwjMNL9zIPOO65nXwEtQX29UTV4fZ0rajkLB7mEjpDEpF68cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qqYeirWs; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4513ee04-03ff-4de0-bbf4-b5b35dfd41ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766040631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dW1sFUrpgDlh6EpvXxN9ly9S/e1gx9r8RyoILFDsHvs=;
	b=qqYeirWsSALh+5MJ3vqdKKt01VPxpqJMm9SbwN9uQ2gnloClPekoB/b0dUyK0Q/KKCItnz
	lQxU2gJPqVR6ATWE/UNNaLHwgFbkLxIPksppMfCKHALKrQuapRMg2sVGEJQXMUT+PkABkK
	4+ude2eYI1txPiaCzHrkn0AnpdXTx7A=
Date: Thu, 18 Dec 2025 14:50:19 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 14/28] mm: mglru: prevent memory cgroup release in
 mglru
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
 <ab60b720d6aef1069038bc4c52d371fb57eaa6e8.1765956025.git.zhengqi.arch@bytedance.com>
 <aUMsQPjBtYtVWjwf@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aUMsQPjBtYtVWjwf@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 6:18 AM, Johannes Weiner wrote:
> On Wed, Dec 17, 2025 at 03:27:38PM +0800, Qi Zheng wrote:
>> @@ -4242,6 +4244,13 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
>>   		}
>>   	}
>>   
>> +	rcu_read_lock();
>> +	memcg = folio_memcg(folio);
>> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> +	max_seq = READ_ONCE((lruvec)->lrugen.max_seq);
>> +	gen = lru_gen_from_seq(max_seq);
>> +	mm_state = get_mm_state(lruvec);
>> +
>>   	arch_enter_lazy_mmu_mode();
>>   
>>   	pte -= (addr - start) / PAGE_SIZE;
>> @@ -4282,6 +4291,8 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
>>   	if (mm_state && suitable_to_scan(i, young))
>>   		update_bloom_filter(mm_state, max_seq, pvmw->pmd);
>>   
>> +	rcu_read_unlock();
>> +
>>   	return true;
> 
> This seems a bit long to be holding the rcu lock. 

Indeed.

> Maybe do a get and a
> put instead?

OK, will use get_mem_cgroup_from_folio(folio) to do this.

This way, #8 doesn't need to be folded into #27.




