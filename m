Return-Path: <cgroups+bounces-10702-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D06BD7001
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 03:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4588350786
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 01:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A421E98EF;
	Tue, 14 Oct 2025 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FTfxEID/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD56FC5
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406242; cv=none; b=XqEVlfmZFXhRcBtKrWgWbW77Qg2uwvhcPApaZgP1tztXs3HD1SPXlz21sZLye/uMFc/pgGfge2A6X6Y9HjSlIgnf+EmjNeu88NSd28p1Jp0r2T2O9KpPFSWnt1YU+WBWjjk18//dTh5y2emq+ja+QfPIj27ZEbc7H0o+i1wC2l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406242; c=relaxed/simple;
	bh=IyIx6WhWzH3QfEjg9TeTpMEVNRzJZtsFVjeIaWYGLdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nQ7BwvdizfmPfOU99dZ8nGXvUnpaKdDqXxubqVsX3/uqv8hpex4hwjqkN7w1RXFUy1RW4US4rL9ZXgeAJjm418UEmxNC4kpuXDDbd6OmOwtWwkhmaHx3Tgt0R4xY28PywmPp+SpeP0F1oavt5IQH83SzjcBS/4tlOorB+Sdfm8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FTfxEID/; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760406237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vO/ZDB4TMtmLh64kPiFotXh5bUAaUBwq3BsPKySjreM=;
	b=FTfxEID/GkjBTTNzzbc45gGoh12Ba6wQqrzY/bO5nzi4cY4mfksqWw34ZkxG1aUz4cnX5l
	taZo3/Bi+V1OBjRFo9bvgPqAb9tbY0t0Dknl/C/QBjFoIbPjxAIWONbpk1/ahMJVoCvZBq
	INPVlegL1EDnAvlD6y6JwifiV1O529E=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Neal
 Cardwell <ncardwell@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  David Ahern <dsahern@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Yosry Ahmed <yosry.ahmed@linux.dev>,
  linux-mm@kvack.org,  netdev@vger.kernel.org,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  cgroups@vger.kernel.org,  Tejun Heo
 <tj@kernel.org>,  Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
  Matyas Hurtik
 <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
In-Reply-To: <89618dcb-7fe3-4f15-931b-17929287c323@cdn77.com> (Daniel Sedlak's
	message of "Mon, 13 Oct 2025 16:30:53 +0200")
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
	<87qzvdqkyh.fsf@linux.dev>
	<13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
	<87o6qgnl9w.fsf@linux.dev>
	<tr7hsmxqqwpwconofyr2a6czorimltte5zp34sp6tasept3t4j@ij7acnr6dpjp>
	<87a5205544.fsf@linux.dev>
	<qdblzbalf3xqohvw2az3iogevzvgn3c3k64nsmyv2hsxyhw7r4@oo7yrgsume2h>
	<875xcn526v.fsf@linux.dev>
	<89618dcb-7fe3-4f15-931b-17929287c323@cdn77.com>
Date: Mon, 13 Oct 2025 18:43:45 -0700
Message-ID: <87h5w2w94e.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Daniel Sedlak <daniel.sedlak@cdn77.com> writes:

> On 10/9/25 9:02 PM, Roman Gushchin wrote:
>> Shakeel Butt <shakeel.butt@linux.dev> writes:
>> 
>>> On Thu, Oct 09, 2025 at 10:58:51AM -0700, Roman Gushchin wrote:
>>>> Shakeel Butt <shakeel.butt@linux.dev> writes:
>>>>
>>>>> On Thu, Oct 09, 2025 at 08:32:27AM -0700, Roman Gushchin wrote:
>>>>>> Daniel Sedlak <daniel.sedlak@cdn77.com> writes:
>>>>>>
>>>>>>> Hi Roman,
>>>>>>>
>>>>>>> On 10/8/25 8:58 PM, Roman Gushchin wrote:
>>>>>>>>> This patch exposes a new file for each cgroup in sysfs which is a
>>>>>>>>> read-only single value file showing how many microseconds this cgroup
>>>>>>>>> contributed to throttling the throughput of network sockets. The file is
>>>>>>>>> accessible in the following path.
>>>>>>>>>
>>>>>>>>>     /sys/fs/cgroup/**/<cgroup name>/memory.net.throttled_usec
>>>>>>>> Hi Daniel!
>>>>>>>> How this value is going to be used? In other words, do you need an
>>>>>>>> exact number or something like memory.events::net_throttled would be
>>>>>>>> enough for your case?
>>>>>>>
>>>>>>> Just incrementing a counter each time the vmpressure() happens IMO
>>>>>>> provides bad semantics of what is actually happening, because it can
>>>>>>> hide important details, mainly the _time_ for how long the network
>>>>>>> traffic was slowed down.
>>>>>>>
>>>>>>> For example, when memory.events::net_throttled=1000, it can mean that
>>>>>>> the network was slowed down for 1 second or 1000 seconds or something
>>>>>>> between, and the memory.net.throttled_usec proposed by this patch
>>>>>>> disambiguates it.
>>>>>>>
>>>>>>> In addition, v1/v2 of this series started that way, then from v3 we
>>>>>>> rewrote it to calculate the duration instead, which proved to be
>>>>>>> better information for debugging, as it is easier to understand
>>>>>>> implications.
>>>>>>
>>>>>> But how are you planning to use this information? Is this just
>>>>>> "networking is under pressure for non-trivial amount of time ->
>>>>>> raise the memcg limit" or something more complicated?
>
> We plan to use it mostly for observability purposes and to better
> understand which traffic patterns affect the socket pressure the most
> (so we can try to fix/delay/improve it). We do not know how commonly
> this issue appears in other deployments, but in our deployment, many
> of servers were affected by this slowdown, which varied in terms of
> hardware and software configuration. Currently, it is very hard to
> detect if the socket is under pressure without using tools like
> bpftrace, so we would like to expose this metric in a more accessible
> way. So in the end, we do not really care in which file this "socket
> pressure happened" notification will be stored.
>>>>>> I totally get it from the debugging perspective, but not sure about
>>>>>> usefulness of it as a permanent metric. This is why I'm asking if there
>>>>>> are lighter alternatives, e.g. memory.events or maybe even tracepoints.
>
> If the combination of memory.events(.local) and tracepoint hook(s) is
> okay with you(?), we can use that and export the same information as
> in the current patch version. We can incorporate that into the next
> version.

In my opinion
tracepoint > memory.events entry > memory.stat entry > new cgroupfs file.

>
> Also, would it be possible to make the socket pressure signal
> configurable, e.g., allowing it to be configured via sysctl or per
> cgroup not to trigger the socket pressure signal? I cannot find the
> reasoning why this throttling cannot (maybe it can) be opt-out.

It's a good point.

First, I think that vmpressure implementation is not the best
and we might want to switch to PSI (or something else) there.
This is why I'm resistant to exposing implementation-specific
metrics.

That said, I believe that some level of customization here is justified.
Maybe opting out completely is too much, but in the end it's hard for
the kernel to balance the importance of e.g. page cache vs networking
buffers as it might be really workload-dependent. Or some workloads
would prefer to risk being oom-killed rather than to tolerate a sub-par
networking performance.

Thanks!

