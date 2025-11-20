Return-Path: <cgroups+bounces-12129-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E4C7459E
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 14:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61EDB4F78DA
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 13:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7670342501;
	Thu, 20 Nov 2025 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A4d9y4YW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B5340A59
	for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645979; cv=none; b=PGUwBEjBz0EKayaRHEGpucuOFMZx25WfsHRR1+gzWzNaKULv04ursOXnoXGHNJwPWLqyT+tbSLqTp37iZmF4YuGwOjv0gf8D422ya6PhAiDYjWbLAiueP6+zQpXic+2XfkKSgkDKPLlwPFd2vgZY3E/pXueVLvTf4/5C8oBKBE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645979; c=relaxed/simple;
	bh=hkXe7RvFHHVtJLQkpvdP71g/k/1+IGz0BF9TRROxH/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUPUYykPoV5xfHaFf39hHfKmzQUPOjwNhxuOeU23r/zPiReA391n5NOyoQs0AOPxkg6K8yIJ1pWGxkQMLzZEi5aw4sVQVfg4z41GiP5d7IE/myVRaKZnJPM5Sy2/fNtOrGFLbNyeu0Bb/SdB2IJ/BD+0SSZqtrxh8srmVjyhOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A4d9y4YW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <82a16330-f801-46f9-bc4d-b10ae9e1472a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763645963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VBW5d85HPNjGo5XvcopxN5QwpZOcDhSseUA2IDtV6A=;
	b=A4d9y4YWBMIDtkYVklUQaOQptNvSdxm1jgBqV92EzXwKqRp6kfKDevWnXtE/QsdXN65gi5
	n9IUhTH1NvnYDMs2/WbW/QyCefvwAe0xMwYh2pih3XH9sj9UJqFaEJEbaNa6MWWuRZsXvl
	azBSwSk/aVFUYrpaIUusu5PJC937F6A=
Date: Thu, 20 Nov 2025 21:39:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 13/26] mm: mglru: prevent memory cgroup release in
 mglru
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <da4182d4f912a00e0cbe377f424f1e94afd3e5c3.1761658310.git.zhengqi.arch@bytedance.com>
 <aR2YSDDbhHfk4aNs@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aR2YSDDbhHfk4aNs@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/19/25 6:13 PM, Harry Yoo wrote:
> On Tue, Oct 28, 2025 at 09:58:26PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> In the near future, a folio will no longer pin its corresponding
>> memory cgroup. To ensure safety, it will only be appropriate to
>> hold the rcu read lock or acquire a reference to the memory cgroup
>> returned by folio_memcg(), thereby preventing it from being released.
>>
>> In the current patch, the rcu read lock is employed to safeguard
>> against the release of the memory cgroup in mglru.
>>
>> This serves as a preparatory measure for the reparenting of the
>> LRU pages.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/vmscan.c | 23 +++++++++++++++++------
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 660cd40cfddd4..676e6270e5b45 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -4279,6 +4288,8 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
>>   
>>   	arch_leave_lazy_mmu_mode();
>>   
>> +	rcu_read_unlock();
>> +
>>   	/* feedback from rmap walkers to page table walkers */
>>   	if (mm_state && suitable_to_scan(i, young))
>>   		update_bloom_filter(mm_state, max_seq, pvmw->pmd);
> 
> mm_state has the same life cycle as mem_cgroup. So it should be
> protected by rcu read lock?

You are right. The mm_state is defined as follows:

struct lruvec {
         struct lru_gen_mm_state		mm_state;
};

will fix it in the next version.

Thanks,
Qi

> 


