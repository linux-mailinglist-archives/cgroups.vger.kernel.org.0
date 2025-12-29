Return-Path: <cgroups+bounces-12797-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6ECCE650A
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 10:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2403F3006A59
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 09:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61959257821;
	Mon, 29 Dec 2025 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ADEric+f"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223E823D7C5
	for <cgroups@vger.kernel.org>; Mon, 29 Dec 2025 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001629; cv=none; b=CT5tjhN/BHHsh4VFOsEmb9yOs+QG5U0ST61o0TjJsw6BqVkpHGUjuFCxBviaX7J+uwpzXEEFho/hMIkXibpbO9AHS7f356BfAF/2aKjkxG59B0zTq0fD01FcS2aeiJgqkm4FPhi0aAH4ZJ1BibvnkcJrngwnq0ZxfE9lH57/Vsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001629; c=relaxed/simple;
	bh=JHsAw+sxjaefErSfKqar1zZP4f95B6Pdu0va9HBBEBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+4QsdgKrieMs85KLXbbxyTkIffyHXeDwJMK9n2YcJFo3gaDxAnuQk9NHiePylUPf/EFaLIt85P+YDO3es05l28jahB/XGebzMJ/aW7EaGnMB/Nimbpk6sD5V+ua02BGyzwd9g5Tyf1WKilhvaGgCjNQbOc9UQ+q2dq/E2l8B/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ADEric+f; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9bc4b18b-ef3a-486f-a911-f0bde17d0fda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767001612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OKyxTjD0H3g5gaPUdSXPikpKgZJEr/E+X1ne1t0XVQ=;
	b=ADEric+fKhdk/4/PBMwv5RLooXGGqJ8T+4VjOhN/w522cWz+MZQsm13YJbhDGEOIPO8CzC
	QAvo0LeFbG8w/k1EzoJp+l6jxm9OzNuNugXTlERmkp4a5d6Ab4S2KrArB9RgAHKKCeP6UZ
	hruzehW/3NpqebHBeaTMA9lloLxmuC0=
Date: Mon, 29 Dec 2025 17:46:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed
 <yosry.ahmed@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
 <vsr4khfsp4unk73a75ky7i35nzdjqsbodyeeuxipu3arormfjr@awi2srdwawfu>
 <1264fd2b-e9bd-4a3b-86ad-eb919941f0a4@linux.dev> <aVJDuObeV2Y99em-@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aVJDuObeV2Y99em-@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/29/25 5:35 PM, Harry Yoo wrote:
> On Mon, Dec 29, 2025 at 03:48:26PM +0800, Qi Zheng wrote:
>>
>>
>> On 12/24/25 7:20 AM, Shakeel Butt wrote:
>>> On Tue, Dec 23, 2025 at 08:04:50PM +0000, Yosry Ahmed wrote:
>>> [...]
>>>>
>>>> I think there might be a problem with non-hierarchical stats on cgroup
>>>> v1, I brought it up previously [*]. I am not sure if this was addressed
>>>> but I couldn't immediately find anything.
>>>
>>> Sigh, the curse of memcg-v1. Let's see what we can do to not break v1.
>>
>> The memcg-v1 was originally planned to be removed, could we skip
>> supporting v1?
> 
> You mean not reparenting LRU pages if CONFIG_MEMCG_V1 is set?
> 
> That may work, but IMHO given that there is no clear timeline for removal
> yet (some v1-specific features have been officially deprecated,
> but memcg v1 as a whole hasn't), implementing Shakeel's suggestion [1]
> may be a good option (it doesn't seem to add much complexity)
> 
> But it can be argued that it's not good enough reason to
> delay the series; adding support for V1 later sounds sensible to me.

Yeah, I will continue to take a closer look at how to support memcg-v1.

> 
> Anyway I'm fine either way and I'm not a memcg maintainer myself,
> so this is just my two cents.
> 
> [1] https://lore.kernel.org/linux-mm/wvj4w7ifmrifnh5bvftdziudsj52fdnwlhbt2oifwmxmi4eore@ob3mrfahhnm5/
> 


