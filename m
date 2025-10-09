Return-Path: <cgroups+bounces-10627-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D20BCAA32
	for <lists+cgroups@lfdr.de>; Thu, 09 Oct 2025 21:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEB994E80DA
	for <lists+cgroups@lfdr.de>; Thu,  9 Oct 2025 19:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8874231A21;
	Thu,  9 Oct 2025 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iKpFldBH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7604CA31
	for <cgroups@vger.kernel.org>; Thu,  9 Oct 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760036542; cv=none; b=Er9wrAjITJ5WiIgJ4YoxEcWBTzNhg9SZI8FXcYDzAy1Ka0+06UrEZU6Ij5yW4H1QyqarcA2bSBeg0EPF6xBW7w4A8yF7v46h4Jxt11Jw+O8bqd/+2xHPOZwEj9Ngikp10bEQnhMjlMrAgLshsODcrF5LigFvr5c0hSAGHTLmyT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760036542; c=relaxed/simple;
	bh=ZqJ3aigxqyk4sKyNQTbbDXLiXw5cyJyw45Clehrvmwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOr0vQfjBqD7srJIFZutaUvhqOI7JBmyRatZulpQL4XGzonSD1ffBn7QF457aesldEOeAJb2yVXNyJ8R0PrkxVOU6nXUbWN/h5oLV6ZLZpkGpva8M3C6yw8bu8DaZEmru7ENgo5Njd5oF0rKSGG3Dy1j+aR+fiFrcjlcmNHmkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iKpFldBH; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760036528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEZY6b9Il/bPIuUgXhNINbaf1qEh3uV81jyRdL6VxBg=;
	b=iKpFldBHyIIoqxe6JgGEDlkn6AJo8vprgXkgchWpTr+HDYbXIVn0Wo0bfG6Qj9Kx1si1qA
	dt5eDxW521POW0bcUPeN/UWnyHgbK7GLEwG1g3EPenu0oHvml/5Jc5SUsum/acZdSTrAH4
	pezT2MwlyiGTAisl7TC1BJF2YoEM34I=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>,  "David S. Miller"
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
In-Reply-To: <qdblzbalf3xqohvw2az3iogevzvgn3c3k64nsmyv2hsxyhw7r4@oo7yrgsume2h>
	(Shakeel Butt's message of "Thu, 9 Oct 2025 11:32:56 -0700")
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
	<87qzvdqkyh.fsf@linux.dev>
	<13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
	<87o6qgnl9w.fsf@linux.dev>
	<tr7hsmxqqwpwconofyr2a6czorimltte5zp34sp6tasept3t4j@ij7acnr6dpjp>
	<87a5205544.fsf@linux.dev>
	<qdblzbalf3xqohvw2az3iogevzvgn3c3k64nsmyv2hsxyhw7r4@oo7yrgsume2h>
Date: Thu, 09 Oct 2025 12:02:00 -0700
Message-ID: <875xcn526v.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> On Thu, Oct 09, 2025 at 10:58:51AM -0700, Roman Gushchin wrote:
>> Shakeel Butt <shakeel.butt@linux.dev> writes:
>> 
>> > On Thu, Oct 09, 2025 at 08:32:27AM -0700, Roman Gushchin wrote:
>> >> Daniel Sedlak <daniel.sedlak@cdn77.com> writes:
>> >> 
>> >> > Hi Roman,
>> >> >
>> >> > On 10/8/25 8:58 PM, Roman Gushchin wrote:
>> >> >>> This patch exposes a new file for each cgroup in sysfs which is a
>> >> >>> read-only single value file showing how many microseconds this cgroup
>> >> >>> contributed to throttling the throughput of network sockets. The file is
>> >> >>> accessible in the following path.
>> >> >>>
>> >> >>>    /sys/fs/cgroup/**/<cgroup name>/memory.net.throttled_usec
>> >> >> Hi Daniel!
>> >> >> How this value is going to be used? In other words, do you need an
>> >> >> exact number or something like memory.events::net_throttled would be
>> >> >> enough for your case?
>> >> >
>> >> > Just incrementing a counter each time the vmpressure() happens IMO
>> >> > provides bad semantics of what is actually happening, because it can
>> >> > hide important details, mainly the _time_ for how long the network
>> >> > traffic was slowed down.
>> >> >
>> >> > For example, when memory.events::net_throttled=1000, it can mean that
>> >> > the network was slowed down for 1 second or 1000 seconds or something
>> >> > between, and the memory.net.throttled_usec proposed by this patch
>> >> > disambiguates it.
>> >> >
>> >> > In addition, v1/v2 of this series started that way, then from v3 we
>> >> > rewrote it to calculate the duration instead, which proved to be
>> >> > better information for debugging, as it is easier to understand
>> >> > implications.
>> >> 
>> >> But how are you planning to use this information? Is this just
>> >> "networking is under pressure for non-trivial amount of time ->
>> >> raise the memcg limit" or something more complicated?
>> >> 
>> >> I am bit concerned about making this metric the part of cgroup API
>> >> simple because it's too implementation-defined and in my opinion
>> >> lack the fundamental meaning.
>> >> 
>> >> Vmpressure is calculated based on scanned/reclaimed ratio (which is
>> >> also not always the best proxy for the memory pressure level), then
>> >> if it reaches some level we basically throttle networking for 1s.
>> >> So it's all very arbitrary.
>> >> 
>> >> I totally get it from the debugging perspective, but not sure about
>> >> usefulness of it as a permanent metric. This is why I'm asking if there
>> >> are lighter alternatives, e.g. memory.events or maybe even tracepoints.
>> >> 
>> >
>> > I also have a very similar opinion that if we expose the current
>> > implementation detail through a stable interface, we might get stuck
>> > with this implementation and I want to change this in future.
>> >
>> > Coming back to what information should we expose that will be helpful
>> > for Daniel & Matyas and will be beneficial in general. After giving some
>> > thought, I think the time "network was slowed down" or more specifically
>> > time window when mem_cgroup_sk_under_memory_pressure() returns true
>> > might not be that useful without the actual network activity. Basically
>> > if no one is calling mem_cgroup_sk_under_memory_pressure() and doing
>> > some actions, the time window is not that useful.
>> >
>> > How about we track the actions taken by the callers of
>> > mem_cgroup_sk_under_memory_pressure()? Basically if network stack
>> > reduces the buffer size or whatever the other actions it may take when
>> > mem_cgroup_sk_under_memory_pressure() returns, tracking those actions
>> > is what I think is needed here, at least for the debugging use-case.
>> >
>> > WDYT?
>> 
>> I feel like if it's mostly intended for debugging purposes,
>> a combination of a trace point and bpftrace can work pretty well,
>> so there is no need to create a new sysfs interface.
>> 
>
> Definitely not a new interface but I think having such information in
> memory.events or memory.stat would be more convenient. Basically the
> number of times the sockets in this memcg have to be clamped due to
> memory pressure would be useful in general.

Yeah, if we're going to add something, memory.events looks like the best
option, also because it allows to poll and get notified when the event
occurs.

