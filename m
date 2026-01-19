Return-Path: <cgroups+bounces-13309-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFDED39D3A
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 04:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C174230010FB
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 03:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FAC31283C;
	Mon, 19 Jan 2026 03:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bPRAAvqx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601429BD95
	for <cgroups@vger.kernel.org>; Mon, 19 Jan 2026 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768794262; cv=none; b=NPwz/f7g78aOaCgB2glHpY8PIF9PcM/A97F+cVjwNilu+CvkyhRbtSetXWelCATRYrwPrrsiVQY82WuscntDnj9+L8L4i1ebbRi36pROyt7SwpaZMgbZhnx9wEBDnycPjwIo7P/57iXel1EOkM58FXZan19SEGfxweCPEjVxQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768794262; c=relaxed/simple;
	bh=nYOQQAfTd470VRLzV5s5lAm1anNaSFBaSVx1k4Avc9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIbFB62hHPdcNwqVubOZpZTzyEFrek42xmTy0NQiC98P2UCphCscSZsGtlaXGHpW+qoFRYvsXJvIAwdvySjDvkrp+miNph93EmBb987iqg/N7uvBiM1pO3J58vI7MAnI60XROhZu36WrUr1eQkug/kObK5jkTH1de9vY9vZtojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bPRAAvqx; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd288f1a-e7b0-48ae-9b11-d882f42bab36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768794258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtD5snQPe94FOhhDUrGLnGyiUlaHl47qH8GQDuJHsl8=;
	b=bPRAAvqxtDPjzYKbswHc3HmHGQ9wVvkHc9z+Xmo2VCUXmapU3nrDOgxJFPzlAg7PDRtIcF
	zOP5PEP0dszlYOCUXzIXdRN2r5bnRILRWnJd6Tm7FjHYoAvti5eXRNMcf08nCHqwaP1jHH
	p+XMtJcBfwZz/Qjl6AeDMpqbzGVi8Zk=
Date: Mon, 19 Jan 2026 11:44:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 24/30] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <0252f9acc29d4b1e9b8252dc003aff065c8ac1f6.1768389889.git.zhengqi.arch@bytedance.com>
 <4a1b69d2-df29-4204-91fd-bb00b52350db@linux.dev>
 <e7aa1221-040e-4806-a259-56718844897f@linux.dev>
 <ncg4ibcrecdutsizzwdu4buw2fvqc57yji4rx3hsdwv4mgobkz@krdjtokzz4xg>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <ncg4ibcrecdutsizzwdu4buw2fvqc57yji4rx3hsdwv4mgobkz@krdjtokzz4xg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/18/26 8:44 AM, Shakeel Butt wrote:
> On Fri, Jan 16, 2026 at 05:50:22PM +0800, Qi Zheng wrote:
>>
>>
>> On 1/16/26 5:43 PM, Muchun Song wrote:
>>>
>>>
>>> On 2026/1/14 19:32, Qi Zheng wrote:
>>>> From: Muchun Song <songmuchun@bytedance.com>
>>>>

[...]

>>>
>>> It seems that functions marked as `inline` cannot be decorated with
>>> `__acquires`? We’ve had to move these little helpers into `memcontrol.c`
>>> and declare them as extern, but they’re so short that it hardly feels
>>
>> Right, I received a compilation error reported LKP:
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from crypto/ahash.c:26:
>>     In file included from include/net/netlink.h:6:
>>     In file included from include/linux/netlink.h:9:
>>     In file included from include/net/scm.h:9:
>>     In file included from include/linux/security.h:35:
>>     In file included from include/linux/bpf.h:32:
>>>> include/linux/memcontrol.h:772:14: error: use of undeclared identifier
>> 'lruvec'
>>       772 |         __acquires(&lruvec->lru_lock)
>>           |                     ^~~~~~
>>     include/linux/memcontrol.h:773:13: error: use of undeclared identifier
>> 'rcu'
>>       773 |         __acquires(rcu)
>>           |                    ^~~
>>     include/linux/memcontrol.h:775:14: error: use of undeclared identifier
>> 'lruvec'
>>       775 |         __acquires(&lruvec->lru_lock)
>>           |                     ^~~~~~
>>     include/linux/memcontrol.h:776:13: error: use of undeclared identifier
>> 'rcu'
>>       776 |         __acquires(rcu)
>>           |                    ^~~
>>     include/linux/memcontrol.h:779:14: error: use of undeclared identifier
>> 'lruvec'
>>       779 |         __acquires(&lruvec->lru_lock)
>>           |                     ^~~~~~
>>     include/linux/memcontrol.h:780:13: error: use of undeclared identifier
>> 'rcu'
>>       780 |         __acquires(rcu)
>>           |                    ^~~
>>     include/linux/memcontrol.h:1507:13: error: use of undeclared identifier
>> 'rcu'
>>      1507 |         __acquires(rcu)
>>           |                    ^~~
>>     include/linux/memcontrol.h:1515:13: error: use of undeclared identifier
>> 'rcu'
>>      1515 |         __releases(rcu)
>>           |                    ^~~
>>     include/linux/memcontrol.h:1523:13: error: use of undeclared identifier
>> 'rcu'
>>      1523 |         __releases(rcu)
>>           |                    ^~~
>>     include/linux/memcontrol.h:1532:13: error: use of undeclared identifier
>> 'rcu'
>>      1532 |         __releases(rcu)
>>
>> And I reproduced this error with the following configuration:
>>
>> 1. enable CONFIG_WARN_CONTEXT_ANALYSIS_ALL
>> 2. make CC=clang bzImage (clang version >= 22)
>>
>>> worth the trouble. My own inclination is to drop the `__acquires`
>>> annotations—mainly for performance reasons.
>>
>> If no one else objects, I will drop __acquires/__releases in the next
>> version.
>>
> 
> If you drop these annotations from header file and keep in the C file,
> do you still get the compilation error?

I did test it this way, and it does fix the compilation error, but
Muchun thinks these functions are very simple and there's no need to put
them in a C file.

> 


