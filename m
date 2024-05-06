Return-Path: <cgroups+bounces-2787-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3358BCD52
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 14:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857972855B4
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 12:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB45142E85;
	Mon,  6 May 2024 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRfikGBB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F801DFCE;
	Mon,  6 May 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997032; cv=none; b=QbyQ5EDz/zHy7A/Z5XsxbHBz1BNmcwHXoqCYYdQdxC6YvdTCA47x9TGWXwX9x6XrTYlwsnhsuWsxAhELO8KQTUIDFbg4cHNtk0UlmzJyqnhIz6uojuEHBxCAVl5L57BtLbPF0snqulaGvICTzi6uAcwkFjUm+47hzeLAE1MU4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997032; c=relaxed/simple;
	bh=vZLDlCQywQMMqzP/n/DNibtb3u8+gJTHpgsfApvLK+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4rvLQA61RpuLUHgHBERH/dnpBG5rlUbJXRVftR1UXOnvrpouG49apKGPicUIY2Xp6TlHuNLo16fyJChneGDj42SsEA/NkYXoF8+FNlbsDUf+iXOd2nedUZzfnzdEgCqop50tW/NbGJoS/IfEe2cyuw6PO821bGYhBhVwZQebaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRfikGBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E45C116B1;
	Mon,  6 May 2024 12:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714997031;
	bh=vZLDlCQywQMMqzP/n/DNibtb3u8+gJTHpgsfApvLK+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mRfikGBBMDfRbhbVjp8yMC9P2JhRVQmwe2R5TqSMwrZxsMYqXnJltFfO1KktXB7fH
	 YAiJFUlK5NqPiubLZNyasP6pvVoLj3gNTiuhSpT6mOPzLlBXd6iOko1sjmJhIi0VzZ
	 h44gU3sD7wPdclAgEWk4PYDsIrKjmDpHfDH2ItVHJwTWn7Dhpk0Ng2fYb9WCnhv7CF
	 0XxFfeu3kiAeJhjdthxZwdO7X5WSRg5cmJ8Z7Ga+MBI55uWicKsvBnmTpksKe+Hsmv
	 NYVfR0xF2OW3F4s0r3BKi60/7HlcZIzF5jP1DhLP0QNIzf2NWh/HGfX77zyc6qjwpY
	 UQwZIeICTmloQ==
Message-ID: <55854a94-681e-4142-9160-98b22fa64d61@kernel.org>
Date: Mon, 6 May 2024 14:03:47 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Waiman Long <longman@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, cgroups@vger.kernel.org, yosryahmed@google.com,
 netdev@vger.kernel.org, linux-mm@kvack.org, kernel-team@cloudflare.com,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Daniel Dao <dqminh@cloudflare.com>, Ivan Babrou <ivan@cloudflare.com>,
 jr@cloudflare.com
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
 <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com>
 <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
 <203fdb35-f4cf-4754-9709-3c024eecade9@redhat.com>
 <b74c4e6b-82cc-4b26-b817-0b36fbfcc2bd@kernel.org>
 <b161e21f-9d66-4aac-8cc1-83ed75f14025@redhat.com>
 <42a6d218-206b-4f87-a8fa-ef42d107fb23@kernel.org>
 <4gdfgo3njmej7a42x6x6x4b6tm267xmrfwedis4mq7f4mypfc7@4egtwzrfqkhp>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <4gdfgo3njmej7a42x6x6x4b6tm267xmrfwedis4mq7f4mypfc7@4egtwzrfqkhp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/05/2024 21.18, Shakeel Butt wrote:
> On Fri, May 03, 2024 at 04:00:20PM +0200, Jesper Dangaard Brouer wrote:
>>
>>
> [...]
>>>
>>> I may have mistakenly thinking the lock hold time refers to just the
>>> cpu_lock. Your reported times here are about the cgroup_rstat_lock.
>>> Right? If so, the numbers make sense to me.
>>>
>>
>> True, my reported number here are about the cgroup_rstat_lock.
>> Glad to hear, we are more aligned then :-)
>>
>> Given I just got some prod machines online with this patch
>> cgroup_rstat_cpu_lock tracepoints, I can give you some early results,
>> about hold-time for the cgroup_rstat_cpu_lock.
> 
> Oh you have already shared the preliminary data.
> 
>>
>>  From this oneliner bpftrace commands:
>>
>>    sudo bpftrace -e '
>>           tracepoint:cgroup:cgroup_rstat_cpu_lock_contended {
>>             @start[tid]=nsecs; @cnt[probe]=count()}
>>           tracepoint:cgroup:cgroup_rstat_cpu_locked {
>>             $now=nsecs;
>>             if (args->contended) {
>>               @wait_per_cpu_ns=hist($now-@start[tid]); delete(@start[tid]);}
>>             @cnt[probe]=count(); @locked[tid]=$now}
>>           tracepoint:cgroup:cgroup_rstat_cpu_unlock {
>>             $now=nsecs;
>>             @locked_per_cpu_ns=hist($now-@locked[tid]); delete(@locked[tid]);
>>             @cnt[probe]=count()}
>>           interval:s:1 {time("%H:%M:%S "); print(@wait_per_cpu_ns);
>>             print(@locked_per_cpu_ns); print(@cnt); clear(@cnt);}'
>>
>> Results from one 1 sec period:
>>
>> 13:39:55 @wait_per_cpu_ns:
>> [512, 1K)              3 |      |
>> [1K, 2K)              12 |@      |
>> [2K, 4K)             390
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [4K, 8K)              70 |@@@@@@@@@      |
>> [8K, 16K)             24 |@@@      |
>> [16K, 32K)           183 |@@@@@@@@@@@@@@@@@@@@@@@@      |
>> [32K, 64K)            11 |@      |
>>
>> @locked_per_cpu_ns:
>> [256, 512)         75592 |@      |
>> [512, 1K)        2537357
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [1K, 2K)          528615 |@@@@@@@@@@      |
>> [2K, 4K)          168519 |@@@      |
>> [4K, 8K)          162039 |@@@      |
>> [8K, 16K)         100730 |@@      |
>> [16K, 32K)         42276 |      |
>> [32K, 64K)          1423 |      |
>> [64K, 128K)           89 |      |
>>
>>   @cnt[tracepoint:cgroup:cgroup_rstat_cpu_lock_contended]: 3 /sec
>>   @cnt[tracepoint:cgroup:cgroup_rstat_cpu_unlock]: 3200  /sec
>>   @cnt[tracepoint:cgroup:cgroup_rstat_cpu_locked]: 3200  /sec
>>
>>
>> So, we see "flush-code-path" per-CPU-holding @locked_per_cpu_ns isn't
>> exceeding 128 usec.
> 
> Hmm 128 usec is actually unexpectedly high. 

> How does the cgroup hierarchy on your system looks like? 
I didn't design this, so hopefully my co-workers can help me out here? 
(To @Daniel or @Jon)

My low level view is that, there are 17 top-level directories in 
/sys/fs/cgroup/.
There are 649 cgroups (counting occurrence of memory.stat).
There are two directories that contain the major part.
  - /sys/fs/cgroup/system.slice = 379
  - /sys/fs/cgroup/production.slice = 233
  - (production.slice have directory two levels)
  - remaining 37

We are open to changing this if you have any advice?
(@Daniel and @Jon are actually working on restructuring this)

> How many cgroups have actual workloads running?
Do you have a command line trick to determine this?


> Can the network softirqs run on any cpus or smaller
> set of cpus? I am assuming these softirqs are processing packets from
> any or all cgroups and thus have larger cgroup update tree. 

Softirq and specifically NET_RX is running half of the cores (e.g. 64).
(I'm looking at restructuring this allocation)

> I wonder if
> you comment out MEMCG_SOCK stat update and still see the same holding
> time.
>

It doesn't look like MEMCG_SOCK is used.

I deduct you are asking:
  - What is the update count for different types of mod_memcg_state() calls?

// Dumped via BTF info
enum memcg_stat_item {
         MEMCG_SWAP = 43,
         MEMCG_SOCK = 44,
         MEMCG_PERCPU_B = 45,
         MEMCG_VMALLOC = 46,
         MEMCG_KMEM = 47,
         MEMCG_ZSWAP_B = 48,
         MEMCG_ZSWAPPED = 49,
         MEMCG_NR_STAT = 50,
};

sudo bpftrace -e 'kfunc:vmlinux:__mod_memcg_state{@[args->idx]=count()} 
END{printf("\nEND time elapsed: %d sec\n", elapsed / 1000000000);}'
Attaching 2 probes...
^C
END time elapsed: 99 sec

@[45]: 17996
@[46]: 18603
@[43]: 61858
@[47]: 21398919

It seems clear that MEMCG_KMEM = 47 is the main "user".
  - 21398919/99 = 216150 calls per sec

Could someone explain to me what this MEMCG_KMEM is used for?


>>
>> My latency requirements, to avoid RX-queue overflow, with 1024 slots,
>> running at 25 Gbit/s, is 27.6 usec with small packets, and 500 usec
>> (0.5ms) with MTU size packets.  This is very close to my latency
>> requirements.
>>
>> --Jesper
>>

