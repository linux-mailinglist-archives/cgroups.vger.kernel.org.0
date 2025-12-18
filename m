Return-Path: <cgroups+bounces-12474-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F505CCA73D
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 07:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F3BE3027DB8
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 06:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41130321F2A;
	Thu, 18 Dec 2025 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FuYlSs/7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096F31ED97
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039200; cv=none; b=T2AGp68S7ur8XGnVV2A4wLt9NjIY0/lOsQOSkcj8hRsAmiQqGLWXV9/R7ZcAyKhc8mw6AL8vk3txUAvm5snLbJXhLCrbcnuOCYLbF+fZOXJRQZWvf1Sno7+DU4T6WayTv9tf3+Z2wWmF6hTmuhbElLLw91pXI8HjU1bFFyCgddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039200; c=relaxed/simple;
	bh=BUrSYtDFVtqK4zHeFsotjEkNHQZqmpL2EvTw1CUoIr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfHeeVRwujI31odrHRNWIDIdckIX1FDRG0ejlZDNfoKXPaEB9nl85IEbJfwX+jnObZR1iXF9uOOue7x/wTGx9WdtuTDQr516+o5CxvGYQGTzZe9FVzkXRw/BbqzjmzrEy5Qb0tL+v76jECha0SaQnlq9fM3p1Z90mVQ0gJsYqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FuYlSs/7; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0088cfa4-7a60-4a44-afbf-7ee0b6ebb2c4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766039185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQrjMLHrieslIFKAFZlyBoYqknDz5bzEWuLKkBRkaL0=;
	b=FuYlSs/7qmGAWTBWBQxbkrQbCqmEgMoaZbgNCMzzBh2YuxnQ4ybZRmxxhOsEvYhEP/oLbi
	kCd5PStGxyUh0c2Z4AaMItHC8yCAjs4pfvMkkqPWpkdLoA07BFunegRu9McSC8iyvdBI9U
	kiSb3lXDFNSP9K+oqxxW3hL4HtTI+TQ=
Date: Thu, 18 Dec 2025 14:25:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 06/28] mm: memcontrol: allocate object cgroup for
 non-kmem case
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
 <897be76398cb2027d08d1bcda05260ede54dc134.1765956025.git.zhengqi.arch@bytedance.com>
 <aUMfALjD7Q1A3NU8@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aUMfALjD7Q1A3NU8@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 5:22 AM, Johannes Weiner wrote:
> On Wed, Dec 17, 2025 at 03:27:30PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> Pagecache pages are charged at allocation time and hold a reference
>> to the original memory cgroup until reclaimed. Depending on memory
>> pressure, page sharing patterns between different cgroups and cgroup
>> creation/destruction rates, many dying memory cgroups can be pinned
>> by pagecache pages, reducing page reclaim efficiency and wasting
>> memory. Converting LRU folios and most other raw memory cgroup pins
>> to the object cgroup direction can fix this long-living problem.
> 
> Not a big deal, but since the coverletter will be preserved in git, I
> don't think you need to repeat the full thesis.

Got it.

> 
>> As a result, the objcg infrastructure is no longer solely applicable
>> to the kmem case. In this patch, we extend the scope of the objcg
>> infrastructure beyond the kmem case, enabling LRU folios to reuse
>> it for folio charging purposes.
> 
> "To allow LRU page reparenting, the objcg infrastructure [...]"

OK, will do.

> 
>> It should be noted that LRU folios are not accounted for at the root
>> level, yet the folio->memcg_data points to the root_mem_cgroup. Hence,
>> the folio->memcg_data of LRU folios always points to a valid pointer.
>> However, the root_mem_cgroup does not possess an object cgroup.
>> Therefore, we also allocate an object cgroup for the root_mem_cgroup.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Looks good to me.
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!



