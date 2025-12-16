Return-Path: <cgroups+bounces-12369-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87909CC05DA
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 01:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 857F530194E6
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 00:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E831495E5;
	Tue, 16 Dec 2025 00:46:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3ADA59;
	Tue, 16 Dec 2025 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765845968; cv=none; b=Yr0AEkh0lS8Aka0GSrqTmvHkEpy3VYjNKTZDL8aYTL36kRgw0WM8XFBSRQFgA0poMqz1rApzLUgeIrzhqSYyceFE+ORklz0TRlFdpF7AytCAypgWXP4GuEoa+oo9O2knu4Y6WXAblhWJ/wePZcdRG2X3toqti53iWQib4z3/Sjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765845968; c=relaxed/simple;
	bh=1+3Lh7U450ydlqvQpXQTIkg3yK7v4Zeps4wTkwJZaU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMogLGvDquHo3D+BXlq9Xjulip23dDiWX04G+1SqgqmWe/wZTYysRmduPqbsTPU4wPOrDD5MrFjWeh+2kC6FNYScuuLs0YAtCEpch1MxXalXDJUVKXK2BkkJ9oiC3YYA+UD0Tto0NpUPNMev4PoT6RvZAz8nVln1tXsxV5cfInQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dVdWg2XzYzYQttN;
	Tue, 16 Dec 2025 08:45:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AEA161A06D7;
	Tue, 16 Dec 2025 08:45:59 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBHYH_Gq0BpmudUAQ--.49701S2;
	Tue, 16 Dec 2025 08:45:59 +0800 (CST)
Message-ID: <9c5a5020-107c-4521-9402-41e614bd2803@huaweicloud.com>
Date: Tue, 16 Dec 2025 08:45:57 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 0/5] mm/mglru: remove memcg lru
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 zhengqi.arch@bytedance.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, lujialin4@huawei.com,
 zhongjinji@honor.com
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
 <oa62a226nagmrqbc23kys3yw3ouxkn5spcizyqqevsuhkurbsv@tvvwqlgu5yum>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <oa62a226nagmrqbc23kys3yw3ouxkn5spcizyqqevsuhkurbsv@tvvwqlgu5yum>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHYH_Gq0BpmudUAQ--.49701S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UCFWfJFWkAryUGry7GFg_yoW8urWDpF
	Wvka48Ka1fJry7Jrs2y3WUZayY9ayxAw4UAr43GryxA3s8ZryFgr4Iqa15uF4kCr48Wr1a
	qr1q93ZxXFs8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/12/16 0:18, Michal Koutný wrote:
> Hi.
> 
> On Tue, Dec 09, 2025 at 01:25:52AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The memcg LRU was introduced to improve scalability in global reclaim,
>> but its implementation has grown complex and can cause performance
>> regressions when creating many memory cgroups [1].
>>
>> This series implements mem_cgroup_iter with a reclaim cookie in
>> shrink_many() for global reclaim, following the pattern already used in
>> shrink_node_memcgs(), an approach suggested by Johannes [1]. The new
>> design maintains good fairness across cgroups by preserving iteration
>> state between reclaim passes.
>>
>> Testing was performed using the original stress test from Yu Zhao [2] on a
>> 1 TB, 4-node NUMA system. The results show:
> 
> (I think the cover letter somehow lost the targets of [1],[2]. I assume
> I could retrieve those from patch 1/5.)
> 

Hi Michal,

Thanks for the reminder—I appreciate you pointing that out.

Apologies for missing the links in the cover letter. You can find them in patch 1/5.

> 
>>
>>     pgsteal:
>>                                         memcg LRU    memcg iter
>>     stddev(pgsteal) / mean(pgsteal)     106.03%       93.20%
>>     sum(pgsteal) / sum(requested)        98.10%       99.28%
>>     
>>     workingset_refault_anon:
>>                                         memcg LRU    memcg iter
>>     stddev(refault) / mean(refault)     193.97%      134.67%
>>     sum(refault)                       1,963,229    2,027,567
>>
>> The new implementation shows clear fairness improvements, reducing the
>> standard deviation relative to the mean by 12.8 percentage points for
>> pgsteal and bringing the pgsteal ratio closer to 100%. Refault counts
>> increased by 3.2% (from 1,963,229 to 2,027,567).
> 
> Just as a quick clarification -- this isn't supposed to affect regular
> (CONFIG_LRU_GEN_ENABLED=n) reclaim, correct?
> 
> Thanks,
> Michal

That's correct. To be precise, it only affects root reclaim when lru_gen_enabled() returns true.

Note that the generation LRU can still be enabled via /sys/kernel/mm/lru_gen/enabled even when
CONFIG_LRU_GEN_ENABLED=n.

-- 
Best regards,
Ridong


