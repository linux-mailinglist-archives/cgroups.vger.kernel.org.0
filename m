Return-Path: <cgroups+bounces-12347-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DBDCB8986
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 11:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5511F3004C8A
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 10:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556A531A57C;
	Fri, 12 Dec 2025 10:15:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F64B31A07C;
	Fri, 12 Dec 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765534536; cv=none; b=XlYY343BBfQkS2m3FNiQBqN6eTxdVLi+Xzk+ivgg9XgGNdIo+zBHIcP4yId+5wXAtjvMXUrHHrfGcsJ4DOoq1pJAder223mgbG1vxmJSy/Bc6q9Fv7d4B4iDHJeFD7Uc3NXLE4myDRdcn1s0qWSXQuviIlrzddO74ofHXiZJfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765534536; c=relaxed/simple;
	bh=M0sOfmxD3AiO8ypIspot2QyB4955YaY26/MqBq2Fhek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZkCu4pGx6UcyMbi7OCNfv8bxFjy3Xb5OWHlB87hLrNOkd2s0ZFKfZeMcOCpVi89VaHklRWwLoB86lOQRprI/duAr8L1B0rMj4xVf0Lgy91KmL8BAXNCksz7nUgbKW43r7eTA3sbzFh363OtQ4xTSWAZwqh+A4WcrAsT21XwYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dSQM33chrzKHMhw;
	Fri, 12 Dec 2025 18:15:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CA85F1A1A70;
	Fri, 12 Dec 2025 18:15:28 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgCHwX096ztpFD3hBQ--.55276S2;
	Fri, 12 Dec 2025 18:15:26 +0800 (CST)
Message-ID: <3eefcf06-e33f-4f5f-bba1-6d53ddc495d5@huaweicloud.com>
Date: Fri, 12 Dec 2025 18:15:24 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 0/5] mm/mglru: remove memcg lru
To: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 zhengqi.arch@bytedance.com
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, lujialin4@huawei.com,
 zhongjinji@honor.com
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251209012557.1949239-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHwX096ztpFD3hBQ--.55276S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4DurWxAF4xJFW8tF13Arb_yoW5Wr1rpF
	Z3WasIka1rArW7X3Z7KayUu3y8Za1xAw47Wr92g3yfArnIya4ktr47tw4rZFWUCrWSqry7
	Xr98u3W8XF1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/9 9:25, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The memcg LRU was introduced to improve scalability in global reclaim,
> but its implementation has grown complex and can cause performance
> regressions when creating many memory cgroups [1].
> 
> This series implements mem_cgroup_iter with a reclaim cookie in
> shrink_many() for global reclaim, following the pattern already used in
> shrink_node_memcgs(), an approach suggested by Johannes [1]. The new
> design maintains good fairness across cgroups by preserving iteration
> state between reclaim passes.
> 
> Testing was performed using the original stress test from Yu Zhao [2] on a
> 1 TB, 4-node NUMA system. The results show:
> 
>     pgsteal:
>                                         memcg LRU    memcg iter
>     stddev(pgsteal) / mean(pgsteal)     106.03%       93.20%
>     sum(pgsteal) / sum(requested)        98.10%       99.28%
>     
>     workingset_refault_anon:
>                                         memcg LRU    memcg iter
>     stddev(refault) / mean(refault)     193.97%      134.67%
>     sum(refault)                       1,963,229    2,027,567
> 
> The new implementation shows clear fairness improvements, reducing the
> standard deviation relative to the mean by 12.8 percentage points for
> pgsteal and bringing the pgsteal ratio closer to 100%. Refault counts
> increased by 3.2% (from 1,963,229 to 2,027,567).
> 
> To simplify review:
> 1. Patch 1 uses mem_cgroup_iter with reclaim cookie in shrink_many()
> 2. Patch 2 removes the now-unused memcg LRU code
> 3. Patches 3–5 combine shrink_many and shrink_node_memcgs
>    (This reorganization is clearer after switching to mem_cgroup_iter)
> 
> ---
> 
> Changes from RFC series:
> 1. Updated the test result data.
> 2. Added patches 3–5 to combine shrink_many and shrink_node_memcgs.
> 
> RFC: https://lore.kernel.org/all/20251204123124.1822965-1-chenridong@huaweicloud.com/
> 
> Chen Ridong (5):
>   mm/mglru: use mem_cgroup_iter for global reclaim
>   mm/mglru: remove memcg lru
>   mm/mglru: extend shrink_one for both lrugen and non-lrugen
>   mm/mglru: combine shrink_many into shrink_node_memcgs
>   mm/mglru: factor lrugen state out of shrink_lruvec
> 
>  Documentation/mm/multigen_lru.rst |  30 ---
>  include/linux/mmzone.h            |  89 --------
>  mm/memcontrol-v1.c                |   6 -
>  mm/memcontrol.c                   |   4 -
>  mm/mm_init.c                      |   1 -
>  mm/vmscan.c                       | 332 ++++--------------------------
>  6 files changed, 44 insertions(+), 418 deletions(-)
> 

Hello all,

There's a warning from the kernel test robot, and I would like to update the series to fix it along
with any feedback from your reviews.

I'd appreciate it if you could take a look at this patch series when convenient.

Hi Shakeel, I would be very grateful if you could review patches 3-5. They combine shrink_many and
shrink_node_memcgs as you suggested — does that look good to you?

-- 
Best regards,
Ridong


