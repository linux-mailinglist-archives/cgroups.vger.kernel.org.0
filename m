Return-Path: <cgroups+bounces-13265-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7C0D2ABB7
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 04:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99C903032E8A
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 03:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA68F3385BE;
	Fri, 16 Jan 2026 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kawZwRZ0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4489338594
	for <cgroups@vger.kernel.org>; Fri, 16 Jan 2026 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534100; cv=none; b=f8mXpuRmnKqbf67IngHRlglCaBTkK5AN++Y5YnfiA+4Y2itu/eDOONdXB0dR/KJrUPI+Uc5x+zCAwOSGm0WcWXBTjCLVCl3xsJ9jZtImsNHe2RBVwNSWgirxs2B5cXHl0at4P/WBouUqJs1n/8fiYrHDOBYVqxnTdsRmtvXxAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534100; c=relaxed/simple;
	bh=D4eEoiTsek1sJGNZSQI6hNZiuu4TWe6MsmZNEeN4N1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbASK42mtwFl/fzhvkC9AqIOBfk76+WQ7AyMHdwMQBPb4Zx9JjRw4y+NrAhNkbe8A+6SwRifDiAx9OFu1UEK/QClEnEiCih7rQ4Xoc0Z0SDpGgLwnB0MQiVpx5tX8/NRvI4GhISZaSiOx12Ncs4P0pW7hRpLySEHW8EHY+Jwo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kawZwRZ0; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19a35b15-b7ce-40fc-8f6e-ed84cff84a17@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768534096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DzqnhNxvLI0laCKLwCbDwSiE4A2VzYWibr9B0HZ9UY=;
	b=kawZwRZ0yr6J0LNYij00kshaTdb5nuUx2T60E4pjQvKILtWpaKJycNZR71fhyREdb2Xrnw
	+gzfIZeJs9TXKrTUoxf5Y9o6O7rQD1+i0WNl7mXlwmpPfVKn1+64txNPh4r6WZLMfOUWQy
	29o/khTKalijqtl9LKWABLc9TQ6Oa9U=
Date: Fri, 16 Jan 2026 11:27:46 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 28/30 fix 1/2] mm: memcontrol: fix
 lruvec_stats->state_local reparenting
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
References: <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
 <e5afd1b5ae95d70f82433b9b4e13201342d16707.1768473427.git.zhengqi.arch@bytedance.com>
 <20260115094704.17d35583bbcff28677b5bc12@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260115094704.17d35583bbcff28677b5bc12@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/16/26 1:47 AM, Andrew Morton wrote:
> On Thu, 15 Jan 2026 18:41:38 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> 
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> What was "fixed"?

[1/2] fixed the issue reported by 
https://lore.kernel.org/all/6967cd38.050a0220.58bed.0001.GAE@google.com/.

Previuosly, state_local was protected by ss_rstat_lock. Since
[PATCH v3 28/30] added a concurrent path, [2/2] changed state_local
to the atomic_long_t type for protection.

> 
> I queued this and [2/2] as squashable fixes against "mm: memcontrol:
> prepare for reparenting state_local".

Thanks!

> 


