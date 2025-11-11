Return-Path: <cgroups+bounces-11772-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 730DDC4A268
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 02:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB0104F5A4D
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F2A25A334;
	Tue, 11 Nov 2025 01:00:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDFD25D209;
	Tue, 11 Nov 2025 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822832; cv=none; b=Cm5+EoDCiCIYvYPpiFFqXYvxCscKADIKlVOHKiANA+pGfcvDVzsTDMX1Lcd179fpdpwC/c1fvQlfef4mdhOd10kT0X/u45zUKybJOXx5VT401ZwrS7tKR97VHjmW8XzR67kdbK4CGNU1fZ0BaWEeAwV65eFoyR4fmz1V0sVv6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822832; c=relaxed/simple;
	bh=T9cxaaQG3GKtP6ySYcldy8TlgDDcEqhl76CGc3Rhrq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFyBdjlTHYBmOlYexBylyBSKFUzp6psJhWhl85ke2viy6EXsZvLnfySOGBD0/k6OOA4fx7J53smNlPl2R7UGYr/kotshFtmukKITXURr7qwDp+F6VjIE5sxsEeR3KAqRKeNWu2OqZwZD0KVbUh7XRmqgU3C1Rtv6+jmP8Eo1ujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d57Vh1k94zKHMSh;
	Tue, 11 Nov 2025 09:00:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 984151A1F0E;
	Tue, 11 Nov 2025 09:00:27 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCnz1yqihJpULVJAQ--.64891S2;
	Tue, 11 Nov 2025 09:00:27 +0800 (CST)
Message-ID: <7d46ef17-684b-4603-be7a-a9428149da05@huaweicloud.com>
Date: Tue, 11 Nov 2025 09:00:25 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Leon Huang Fu <leon.huangfu@shopee.com>
Cc: linux-mm@kvack.org, tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 akpm@linux-foundation.org, joel.granados@kernel.org, jack@suse.cz,
 laoar.shao@gmail.com, mclapinski@google.com, kyle.meyer@hpe.com,
 corbet@lwn.net, lance.yang@linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
 <ewcsz3553cd6ooslgzwbubnbaxwmpd23d2k7pw5s4ckfvbb7sp@dffffjvohz5b>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ewcsz3553cd6ooslgzwbubnbaxwmpd23d2k7pw5s4ckfvbb7sp@dffffjvohz5b>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnz1yqihJpULVJAQ--.64891S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF13Wr47Gw4kWr1rtr15twb_yoW5Kr15pF
	Z8tasYyw4DKryxCwn7Ww1xXrWFkw4fW3yUtF9xC34fC3ZxJF1S9rW3tFWrKr9I9FWfX34j
	vF4Yva4ruay5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/11/10 21:50, Michal Koutný wrote:
> Hello Leon.
> 
> On Mon, Nov 10, 2025 at 06:19:48PM +0800, Leon Huang Fu <leon.huangfu@shopee.com> wrote:
>> Memory cgroup statistics are updated asynchronously with periodic
>> flushing to reduce overhead. The current implementation uses a flush
>> threshold calculated as MEMCG_CHARGE_BATCH * num_online_cpus() for
>> determining when to aggregate per-CPU memory cgroup statistics. On
>> systems with high core counts, this threshold can become very large
>> (e.g., 64 * 256 = 16,384 on a 256-core system), leading to stale
>> statistics when userspace reads memory.stat files.
>>

We have encountered this problem multiple times when running LTP tests. It can easily occur when
using a 64K page size.

error:
 	memcg_stat_rss 10 TFAIL: rss is 0, 266240 expected

>> This is particularly problematic for monitoring and management tools
>> that rely on reasonably fresh statistics, as they may observe data
>> that is thousands of updates out of date.
>>
>> Introduce a new write-only file, memory.stat_refresh, that allows
>> userspace to explicitly trigger an immediate flush of memory statistics.
> 
> I think it's worth thinking twice when introducing a new file like
> this...
> 
>> Writing any value to this file forces a synchronous flush via
>> __mem_cgroup_flush_stats(memcg, true) for the cgroup and all its
>> descendants, ensuring that subsequent reads of memory.stat and
>> memory.numa_stat reflect current data.
>>
>> This approach follows the pattern established by /proc/sys/vm/stat_refresh
>> and memory.peak, where the written value is ignored, keeping the
>> interface simple and consistent with existing kernel APIs.
>>
>> Usage example:
>>   echo 1 > /sys/fs/cgroup/mygroup/memory.stat_refresh
>>   cat /sys/fs/cgroup/mygroup/memory.stat
>>
>> The feature is available in both cgroup v1 and v2 for consistency.
> 
> First, I find the motivation by the testcase (not real world) weak when
> considering such an API change (e.g. real world would be confined to
> fewer CPUs or there'd be other "traffic" causing flushes making this a
> non-issue, we don't know here).
> 
> Second, this is open to everyone (non-root) who mkdir's their cgroups.
> Then why not make it the default memory.stat behavior? (Tongue-in-cheek,
> but [*].)
> 
> With this change, we admit the implementation (async flushing) and leak
> it to the users which is hard to take back. Why should we continue doing
> any implicit in-kernel flushing afterwards?
> 
> Next, v1 and v2 haven't been consistent since introduction of v2 (unlike
> some other controllers that share code or even cftypes between v1 and
> v2). So I'd avoid introducing a new file to V1 API.
> 

We encountered this problem in v1, I think this is a common problem should be fixed.

> When looking for analogies, I admittedly like memory.reclaim's
> O_NONBLOCK better (than /proc/sys/vm/stat_refresh). That would be an
> argument for flushing by default mentioned abovee [*]).
> 
> Also, this undercuts the hooking of rstat flushing into BPF. I think the
> attempts were given up too early (I read about the verifier vs
> seq_file). Have you tried bypassing bailout from
> __mem_cgroup_flush_stats via trace_memcg_flush_stats?
> 
> 
> All in all, I'd like to have more backing data on insufficiency of (all
> the) rstat optimizations before opening explicit flushes like this
> (especially when it's meant to be exposed by BPF already).
> 
> Thanks,
> Michal
> 
> 

-- 
Best regards,
Ridong


