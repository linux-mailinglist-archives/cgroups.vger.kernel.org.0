Return-Path: <cgroups+bounces-10620-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76958BC9CE7
	for <lists+cgroups@lfdr.de>; Thu, 09 Oct 2025 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5314F1883FB0
	for <lists+cgroups@lfdr.de>; Thu,  9 Oct 2025 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA41E835D;
	Thu,  9 Oct 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dvObJYKt"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09917BEBF
	for <cgroups@vger.kernel.org>; Thu,  9 Oct 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023971; cv=none; b=DggJSmtXW56Uluc5KFyQ8T4Deb7omqanAaFijNjAwdGsQIExB/011uaZUv84ZAojzwMBlgjvtmtoMGyzzAjGaVtfn0zOAL7sPu8dKOv3haSiuRHQkIQEBY96jvbsDCeTS4VBpujiSxFeoeeb7C0igGVneDyoPU4BSg5DU4QhBc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023971; c=relaxed/simple;
	bh=5P/I5u30Z40zqVOpeikDrUc8zSbhhugs7Ju8Q22pzao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ChW3uHpeFO+W8F2gV0rb9pQoqX7PCHmJpuLhTAwkc4neNcEBvPjvS8CYCrlNmY6T23HQiFjlS9bmXp99YLGGHAiswGBVKhZrr0M/ky3+m1tkgTYEGCfzhbd92RIJe/hVlTFEIZ03XXJ6K+gBKWkSPak0hQX9Ox398sgUJltdxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dvObJYKt; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760023956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ar5DXhZwopHAzrQe7Nhnw3uLFpeXIHyKZmHhawwMIWU=;
	b=dvObJYKtcK1ChPuL5tvzQaR6EnoAGGZhmQEEIEXoDr/1yYtpNAnUnCYHxMgj38b6l9mov0
	LsbZFVNDM3eH35oGiLpDApraYsWmRU3XCc57vv+oSVGixLEZfYcF5MsvgamAAkCTEWEGEP
	cZ4KuIePH+I1bi6kYe6Dsh5rGPJDA3s=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  Neal Cardwell <ncardwell@google.com>,  Kuniyuki
 Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Yosry Ahmed <yosry.ahmed@linux.dev>,
  linux-mm@kvack.org,  netdev@vger.kernel.org,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  cgroups@vger.kernel.org,  Tejun Heo
 <tj@kernel.org>,  Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
  Matyas Hurtik
 <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
In-Reply-To: <13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com> (Daniel Sedlak's
	message of "Thu, 9 Oct 2025 16:44:04 +0200")
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
	<87qzvdqkyh.fsf@linux.dev>
	<13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
Date: Thu, 09 Oct 2025 08:32:27 -0700
Message-ID: <87o6qgnl9w.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Daniel Sedlak <daniel.sedlak@cdn77.com> writes:

> Hi Roman,
>
> On 10/8/25 8:58 PM, Roman Gushchin wrote:
>>> This patch exposes a new file for each cgroup in sysfs which is a
>>> read-only single value file showing how many microseconds this cgroup
>>> contributed to throttling the throughput of network sockets. The file is
>>> accessible in the following path.
>>>
>>>    /sys/fs/cgroup/**/<cgroup name>/memory.net.throttled_usec
>> Hi Daniel!
>> How this value is going to be used? In other words, do you need an
>> exact number or something like memory.events::net_throttled would be
>> enough for your case?
>
> Just incrementing a counter each time the vmpressure() happens IMO
> provides bad semantics of what is actually happening, because it can
> hide important details, mainly the _time_ for how long the network
> traffic was slowed down.
>
> For example, when memory.events::net_throttled=1000, it can mean that
> the network was slowed down for 1 second or 1000 seconds or something
> between, and the memory.net.throttled_usec proposed by this patch
> disambiguates it.
>
> In addition, v1/v2 of this series started that way, then from v3 we
> rewrote it to calculate the duration instead, which proved to be
> better information for debugging, as it is easier to understand
> implications.

But how are you planning to use this information? Is this just
"networking is under pressure for non-trivial amount of time ->
raise the memcg limit" or something more complicated?

I am bit concerned about making this metric the part of cgroup API
simple because it's too implementation-defined and in my opinion
lack the fundamental meaning.

Vmpressure is calculated based on scanned/reclaimed ratio (which is
also not always the best proxy for the memory pressure level), then
if it reaches some level we basically throttle networking for 1s.
So it's all very arbitrary.

I totally get it from the debugging perspective, but not sure about
usefulness of it as a permanent metric. This is why I'm asking if there
are lighter alternatives, e.g. memory.events or maybe even tracepoints.

Thanks!

