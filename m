Return-Path: <cgroups+bounces-13237-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A52CD227CB
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 07:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F33F0304A93C
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 06:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621D285074;
	Thu, 15 Jan 2026 06:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="scuVfxqH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0172D839C
	for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457170; cv=none; b=HwOUlnLpkLYbNznIqJkGk8f5JOt1OezgdbrhN4plq72kE1ZKA2XJnJkgDodD6RmfDsu8kPevsrb9S8LI6Ia4pe4lO9SUvXWDBBLsaOYr+5pXwHDqbrxAcB9ZvWC2eACltFFtApm0QlEMKcSp4gxfHdDkgY053sx2WmM0uTPD2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457170; c=relaxed/simple;
	bh=Wot21i1ixzzeTT2lKY5qJYV4zcsj9xuTLbIjZ1Cr4Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajLvXcklJNd83NwMngLelGHaQRn4Ve9PvgkK+ZGbVybKKy80JnIxYjxoTmh4gLoLFh1VaJ5HGq4BgaS3YPd3zN8i699wr7aI7NdavLlCwZAyUC8mnb6qJFkHlD2Kfnxt0WReMaPkzMyl/6zCv5AQK8T4perWaQVwchLMDpfRHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=scuVfxqH; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f91fb10b-19cc-471a-8a45-2cf52d62156a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768457156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cp95f05P+xA83/rUgh+jT3tO7oOGwmlpf1fGjpsoUdo=;
	b=scuVfxqH0RS0DP4ECtaLqxeLhUm/MS0pkZ3DN29Jl1v51x5jAQDJI0sam/Mebc5IBmiJbY
	Cr2n1UfaQcHd+BT4UCQczYjJLbH/dlfcEVIsG2SsS1SwNM0LRFM8kw055llt0WrMPuOiFt
	sI7eKBZ+FvUrwZ4wof0jBQiTUgrTEh8=
Date: Thu, 15 Jan 2026 14:05:46 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/30] Eliminate Dying Memory Cgroup
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <20260114095839.eabf8106e97bf3bcf0917341@linux-foundation.org>
 <98819615-5001-45f6-8e63-c4220a242257@linux.dev>
 <20260114215917.8eee7b9fa4da37305b74d6f2@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260114215917.8eee7b9fa4da37305b74d6f2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/15/26 1:59 PM, Andrew Morton wrote:
> On Thu, 15 Jan 2026 11:52:04 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> 
>>
>>
>> On 1/15/26 1:58 AM, Andrew Morton wrote:
>>> On Wed, 14 Jan 2026 19:26:43 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
>>>
>>>> This patchset is intended to transfer the LRU pages to the object cgroup
>>>> without holding a reference to the original memory cgroup in order to
>>>> address the issue of the dying memory cgroup.
>>>
>>> Thanks.  I'll add this to mm.git for testing.  A patchset of this
>>> magnitude at -rc5 is a little ambitious, but Linus is giving us an rc8
>>> so let's see.
>>>
>>> I'll suppress the usual added-to-mm email spray.
>>
>> Hi Andrew,
>>
>> The issue reported by syzbot needs to be addressed. If you want to test
>> this patchset, would you like me to provide a fix patch, or would you
>> prefer me to update to v4?
> 
> A fix would be preferred if that's reasonable - it's a lot of patches
> be resending!

OK, I'll send the fix ASAP.


