Return-Path: <cgroups+bounces-3831-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C44D9381C2
	for <lists+cgroups@lfdr.de>; Sat, 20 Jul 2024 17:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786EB281CB3
	for <lists+cgroups@lfdr.de>; Sat, 20 Jul 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD0A12C477;
	Sat, 20 Jul 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+DGjn7M"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8DC946C;
	Sat, 20 Jul 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721487958; cv=none; b=vE+CtQXtU3Ip6V+Dbop6ZEqjpGUKz4OYrpRRTgBTun/j/HDloxT5G73NQ63pokZt0EGBFtIJN3MSNfTdJv3DI8+hnMAfp8pk/iL1egEIX/AwMS7NqcrTskkaknFPX96JhBJHGHWq/v2oi1p7JycP8e1DSwlHHszcD6BwGEprKXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721487958; c=relaxed/simple;
	bh=k4QH3qMZmc5lt/JCKiyiytBQFLERwz8/NvfvAG7HuYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqnSvxN/m7A0TBhGL1m9D1QMrF2vHHwgu2lr9ncbpBQiusP/QM7hIZxdYfpe2pcv7Ezpryr5e7GZ1CurISdS2m0L7jvQVaDT2ulvNAhsQpGtJiMalBcATKptCW5/mmomfNQarvdxTggRQB54ur+ZTBiEjN/s2NBJq6qkFos5HdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+DGjn7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E50C2BD10;
	Sat, 20 Jul 2024 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721487958;
	bh=k4QH3qMZmc5lt/JCKiyiytBQFLERwz8/NvfvAG7HuYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M+DGjn7MLbUQhFphHGMvKeKFSIMXZHy756KSGeg0DFq6CF6/z6WaCDSm22ll3ezC9
	 HXNyeRDvPR03lSm8Hy5ovam0PGDkz4B2TKvUSTj5dD58Nil02gPJ8+c7E7xKw6cTRO
	 h6GJnOvZ/XcBFHkrYwXSFeMhRQDvujnTuZXDWP4PyRxRtG1c0ddYexC4shqw3GUd2G
	 hBdtOHzgt1WnuVA93sdGrqTZ7nif0yZHxTKjwrWG4f0MDe6w30BM9+QpAdwszVDRjn
	 adjOEKiz557c6KMLgohObDU3yitNCpQmNMU85A+513/zjIBJet3cwj3DCgtmnRhR72
	 1wF1XMzcPNHSw==
Message-ID: <74c53382-5c31-41e9-94a2-0a7f88c0d2a5@kernel.org>
Date: Sat, 20 Jul 2024 17:05:53 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Yosry Ahmed <yosryahmed@google.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
 <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
 <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org>
 <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
 <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com>
 <CAJD7tkaypFa3Nk0jh_ZYJX8YB0i7h9VY2YFXMg7GKzSS+f8H5g@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkaypFa3Nk0jh_ZYJX8YB0i7h9VY2YFXMg7GKzSS+f8H5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/07/2024 06.52, Yosry Ahmed wrote:
> On Fri, Jul 19, 2024 at 9:52 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>> On Fri, Jul 19, 2024 at 3:48 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>
>>> On Fri, Jul 19, 2024 at 09:54:41AM GMT, Jesper Dangaard Brouer wrote:
>>>>
>>>>
>>>> On 19/07/2024 02.40, Shakeel Butt wrote:
>>>>> Hi Jesper,
>>>>>
>>>>> On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wrote:
>>>>>>
>>>>> [...]
>>>>>>
>>>>>>
>>>>>> Looking at the production numbers for the time the lock is held for level 0:
>>>>>>
>>>>>> @locked_time_level[0]:
>>>>>> [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
>>>>>> [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>>>>>> [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                   |
>>>>>> [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                    |
>>>>>>
>>>>>
>>>>> Is it possible to get the above histogram for other levels as well?
>>>>
>>>> Data from other levels available in [1]:
>>>>   [1]
>>>> https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9ab5@kernel.org/
>>>>
>>>> IMHO the data shows we will get most out of skipping level-0 root-cgroup
>>>> flushes.
>>>>
>>>
>>> Thanks a lot of the data. Are all or most of these locked_time_level[0]
>>> from kswapds? This just motivates me to strongly push the ratelimited
>>> flush patch of mine (which would be orthogonal to your patch series).
>>

There are also others flushing level 0.
Extended the bpftrace oneliner to also capture the process 'comm' name.
(I reduced 'kworker' to one entry in below, e.g pattern 'kworker/u392:19').

grep 'level\[' out01.bpf_oneliner_locked_time | awk -F/ '{print $1}' | 
sort | uniq
@locked_time_level[0, cadvisor]:
@locked_time_level[0, consul]:
@locked_time_level[0, kswapd0]:
@locked_time_level[0, kswapd10]:
@locked_time_level[0, kswapd11]:
@locked_time_level[0, kswapd1]:
@locked_time_level[0, kswapd2]:
@locked_time_level[0, kswapd3]:
@locked_time_level[0, kswapd4]:
@locked_time_level[0, kswapd5]:
@locked_time_level[0, kswapd6]:
@locked_time_level[0, kswapd7]:
@locked_time_level[0, kswapd8]:
@locked_time_level[0, kswapd9]:
@locked_time_level[0, kworker
@locked_time_level[0, lassen]:
@locked_time_level[0, thunderclap-san]:
@locked_time_level[0, xdpd]:
@locked_time_level[1, cadvisor]:
@locked_time_level[2, cadvisor]:
@locked_time_level[2, kworker
@locked_time_level[2, memory-saturati]:
@locked_time_level[2, systemd]:
@locked_time_level[2, thread-saturati]:
@locked_time_level[3, cadvisor]:
@locked_time_level[3, cat]:
@locked_time_level[3, kworker
@locked_time_level[3, memory-saturati]:
@locked_time_level[3, systemd]:
@locked_time_level[3, thread-saturati]:
@locked_time_level[4, cadvisor]:


>> Jesper and I were discussing a better ratelimiting approach, whether
>> it's measuring the time since the last flush, or only skipping if we
>> have a lot of flushes in a specific time frame (using __ratelimit()).
>> I believe this would be better than the current memcg ratelimiting
>> approach, and we can remove the latter.
>>
>> WDYT?
> 
> Forgot to link this:
> https://lore.kernel.org/lkml/CAJD7tkZ5nxoa7aCpAix1bYOoYiLVfn+aNkq7jmRAZqsxruHYLw@mail.gmail.com/
> 

I agree that ratelimiting is orthogonal to this patch, and that we 
really need to address this in follow up patchset.

The proposed mem_cgroup_flush_stats_ratelimited patch[1] helps, but is
limited to memory area.  I'm proposing a more generic solution in [2]
that helps all users of rstat.

It is time based, because it makes sense to observe the time it takes to
flush root (service rate), and then limit how quickly after another
flusher can run (limiting arrival rate). From practical queue theory we
intuitively know that we should keep arrival rate below service rate,
else queuing happens.

--Jesper

[1] "memcg: use ratelimited stats flush in the reclaim"
  - 
https://lore.kernel.org/all/20240615081257.3945587-1-shakeel.butt@linux.dev/

[2] "cgroup/rstat: introduce ratelimited rstat flushing"
  - 
https://lore.kernel.org/all/171328990014.3930751.10674097155895405137.stgit@firesoul/


