Return-Path: <cgroups+bounces-10662-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB80BD385E
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583D61884738
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4234925487B;
	Mon, 13 Oct 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="zjZ2hhR6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5D19C556;
	Mon, 13 Oct 2025 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365868; cv=none; b=BjhG7ljQHJILTjJ3vc9WAEqxzkJtP1ly+V37FiScvao/5M0R9kfbzdz/l1QWkWyAiwqJvGaXdJD3HbFH30fRtUJUq29diSLiPKJzdCA3VxRfqHbTmannLm7iryostLV2nLi6oPStGXf6pUAj3TWQ54LMOsuCS8oW/DPQcVnIV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365868; c=relaxed/simple;
	bh=/vNrdQwxkl+WHNpIf66r7ANjlkW+J54ipvvz+/gJbOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NK1HBEZQ7H4iThIpuqhwHD3Vs7GpJAOgr/PxHdq5X2Lx9ZElaDakSpl3j0JZmnWrZCMmUEr2u9yz80T8mwlNgvmcyn/0ojx2EtCnZbjLmr1HKQwCipXzRUInCXS8oN8JS/ubNcJbOII2dEhOr9BI2DVDzxAVadpeYpauTWZbs2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=zjZ2hhR6; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1760365855; x=1760970655; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=4+zeKz23GcC8G0cCKClcwBTlkpCur/puh9HJz5dxq7g=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=zjZ2hhR6nzhJIj2WKDmpSgSXTHEddDcN9agWH15DleRsMmw6CBfQSvFskrFwOGXZitXcohfNavuDdRvLRPYzNg15iEen5oJ5V2nnrCDtTsOnd/Kk7H6O7xxGjfBNaR/4493s4wOU7SZ7jnaRDl5pZZaBX0xcpsBjCqkBZEKYn2E=
Received: from [10.26.3.35] ([80.250.18.198])
        by mail.sh.cz (14.1.0 build 17 ) with ASMTP (SSL) id 202510131630537100;
        Mon, 13 Oct 2025 16:30:53 +0200
Message-ID: <89618dcb-7fe3-4f15-931b-17929287c323@cdn77.com>
Date: Mon, 13 Oct 2025 16:30:53 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
To: Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
 netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Matyas Hurtik <matyas.hurtik@cdn77.com>
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
 <87qzvdqkyh.fsf@linux.dev> <13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
 <87o6qgnl9w.fsf@linux.dev>
 <tr7hsmxqqwpwconofyr2a6czorimltte5zp34sp6tasept3t4j@ij7acnr6dpjp>
 <87a5205544.fsf@linux.dev>
 <qdblzbalf3xqohvw2az3iogevzvgn3c3k64nsmyv2hsxyhw7r4@oo7yrgsume2h>
 <875xcn526v.fsf@linux.dev>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <875xcn526v.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A2D030A.68ED0D1E.004D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 10/9/25 9:02 PM, Roman Gushchin wrote:
> Shakeel Butt <shakeel.butt@linux.dev> writes:
> 
>> On Thu, Oct 09, 2025 at 10:58:51AM -0700, Roman Gushchin wrote:
>>> Shakeel Butt <shakeel.butt@linux.dev> writes:
>>>
>>>> On Thu, Oct 09, 2025 at 08:32:27AM -0700, Roman Gushchin wrote:
>>>>> Daniel Sedlak <daniel.sedlak@cdn77.com> writes:
>>>>>
>>>>>> Hi Roman,
>>>>>>
>>>>>> On 10/8/25 8:58 PM, Roman Gushchin wrote:
>>>>>>>> This patch exposes a new file for each cgroup in sysfs which is a
>>>>>>>> read-only single value file showing how many microseconds this cgroup
>>>>>>>> contributed to throttling the throughput of network sockets. The file is
>>>>>>>> accessible in the following path.
>>>>>>>>
>>>>>>>>     /sys/fs/cgroup/**/<cgroup name>/memory.net.throttled_usec
>>>>>>> Hi Daniel!
>>>>>>> How this value is going to be used? In other words, do you need an
>>>>>>> exact number or something like memory.events::net_throttled would be
>>>>>>> enough for your case?
>>>>>>
>>>>>> Just incrementing a counter each time the vmpressure() happens IMO
>>>>>> provides bad semantics of what is actually happening, because it can
>>>>>> hide important details, mainly the _time_ for how long the network
>>>>>> traffic was slowed down.
>>>>>>
>>>>>> For example, when memory.events::net_throttled=1000, it can mean that
>>>>>> the network was slowed down for 1 second or 1000 seconds or something
>>>>>> between, and the memory.net.throttled_usec proposed by this patch
>>>>>> disambiguates it.
>>>>>>
>>>>>> In addition, v1/v2 of this series started that way, then from v3 we
>>>>>> rewrote it to calculate the duration instead, which proved to be
>>>>>> better information for debugging, as it is easier to understand
>>>>>> implications.
>>>>>
>>>>> But how are you planning to use this information? Is this just
>>>>> "networking is under pressure for non-trivial amount of time ->
>>>>> raise the memcg limit" or something more complicated?

We plan to use it mostly for observability purposes and to better 
understand which traffic patterns affect the socket pressure the most 
(so we can try to fix/delay/improve it). We do not know how commonly 
this issue appears in other deployments, but in our deployment, many of 
servers were affected by this slowdown, which varied in terms of 
hardware and software configuration. Currently, it is very hard to 
detect if the socket is under pressure without using tools like 
bpftrace, so we would like to expose this metric in a more accessible 
way. So in the end, we do not really care in which file this "socket 
pressure happened" notification will be stored.
>>>>> I totally get it from the debugging perspective, but not sure about
>>>>> usefulness of it as a permanent metric. This is why I'm asking if there
>>>>> are lighter alternatives, e.g. memory.events or maybe even tracepoints.

If the combination of memory.events(.local) and tracepoint hook(s) is 
okay with you(?), we can use that and export the same information as in 
the current patch version. We can incorporate that into the next version.

Also, would it be possible to make the socket pressure signal 
configurable, e.g., allowing it to be configured via sysctl or per 
cgroup not to trigger the socket pressure signal? I cannot find the 
reasoning why this throttling cannot (maybe it can) be opt-out.
>>>> I also have a very similar opinion that if we expose the current
>>>> implementation detail through a stable interface, we might get stuck
>>>> with this implementation and I want to change this in future.
>>>>
>>>> Coming back to what information should we expose that will be helpful
>>>> for Daniel & Matyas and will be beneficial in general. After giving some
>>>> thought, I think the time "network was slowed down" or more specifically
>>>> time window when mem_cgroup_sk_under_memory_pressure() returns true
>>>> might not be that useful without the actual network activity. Basically
>>>> if no one is calling mem_cgroup_sk_under_memory_pressure() and doing
>>>> some actions, the time window is not that useful.
>>>>
>>>> How about we track the actions taken by the callers of
>>>> mem_cgroup_sk_under_memory_pressure()? Basically if network stack
>>>> reduces the buffer size or whatever the other actions it may take when
>>>> mem_cgroup_sk_under_memory_pressure() returns, tracking those actions
>>>> is what I think is needed here, at least for the debugging use-case.

I am not against it, but I feel that conveying those tracked actions (or 
how to represent them) to the user will be much harder. Are there 
already existing APIs to push this information to the user?

Thanks!
Daniel.


