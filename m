Return-Path: <cgroups+bounces-12793-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCB9CE62A4
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 08:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDE2B30069AD
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 07:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8994B228CA9;
	Mon, 29 Dec 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SA9vSxTu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032123A1E98
	for <cgroups@vger.kernel.org>; Mon, 29 Dec 2025 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766994544; cv=none; b=ZoWhjK3EPHBTRvNOOVWCeRWH0LYemhbvwOQD2xvRh7Wqq4S9ivHLPhh4ZFahl60xtk/WL0e10Ufd2HNhIukQPCOmZQkQT1o/2CUrYS7LZNbP5aILEtm/gHV+Fc3NBVxnMQ7jW1QtytK60DoD+lhe52lh6G5AKyyymXGSQVFOVEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766994544; c=relaxed/simple;
	bh=4qlQMRgBiOeJ9g+nUPQgkzr3ymxS+qJLX6FbdJ9DNwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkwTo9YUIL9dB3CAyV67ucTBWoNFyOn1Xo+E336vZB4L4FN+CN5oZ0fdVJPnmPrpsXA6jDAzBpLjVrGztlKRpjayNGLGeZhVwLB4Gj8Xxttw/k48dPLuISgNwqgCJwhpJWi5fg5xCgDe8D3m3+cnXaSIyQLcYTPHpOSRiYgH1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SA9vSxTu; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1264fd2b-e9bd-4a3b-86ad-eb919941f0a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766994530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1R/ahL6rq4+3c38JNqI4dZ67fdzAfwCNTqIsx/+srY=;
	b=SA9vSxTuD15GpKVc0SGajXBGdyPHOJccBB1B9R0ae6mEHD/IGMctJlYs2L7oHmIN2wryoN
	CELOsJJglhfZzoPhKFCEdl9cQfqll8AjpCzXy3ZnTsHCYTaefqmTAvOY7S6a+lusPV/kFO
	v+7XqFUuuIYvjyytWCNUxzsHpkTS/cI=
Date: Mon, 29 Dec 2025 15:48:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
 <vsr4khfsp4unk73a75ky7i35nzdjqsbodyeeuxipu3arormfjr@awi2srdwawfu>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <vsr4khfsp4unk73a75ky7i35nzdjqsbodyeeuxipu3arormfjr@awi2srdwawfu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/24/25 7:20 AM, Shakeel Butt wrote:
> On Tue, Dec 23, 2025 at 08:04:50PM +0000, Yosry Ahmed wrote:
> [...]
>>
>> I think there might be a problem with non-hierarchical stats on cgroup
>> v1, I brought it up previously [*]. I am not sure if this was addressed
>> but I couldn't immediately find anything.
> 
> Sigh, the curse of memcg-v1. Let's see what we can do to not break v1.

The memcg-v1 was originally planned to be removed, could we skip
supporting v1?

> 



