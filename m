Return-Path: <cgroups+bounces-10611-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE52BC663A
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 20:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BAA19E40D4
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099192C0F7B;
	Wed,  8 Oct 2025 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bAWpZV9G"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9472BF007;
	Wed,  8 Oct 2025 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949939; cv=none; b=ZFaiq871ak1M7AXE0wqcTjXIHJkdPO6FW/N1nwolFgVJh3KhlMfGEZgp7UhAlHYePklzo7sA39VUz1QvG3EVBbSykfudUwaYUQzwxo7dc19fIdOGFoowPC7z9J3nlPaXyXOvO4UFmgMXRn8hN4pRNJEWuZK2IqNyXXrjP5L+cVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949939; c=relaxed/simple;
	bh=c+0c4CdEK2kCFfGJq0QIVWU1nPEXnA+v4w5Ud2YK5bw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jN0vl7lXLTZH4S0niVtdIuIp+/0fLn+zzhoM6jZjaY0MOy/Hnr/sdTMWUFSzNoIqcvRoV5edfyXff/npcZgW6otfDWmqA1NJtHE+fxoM+u6/Xdc96wxz5Kx2yO8g3UXorYm12Grmv2ryFteK3Ku3tCMF/w8u7mfhWjHX2iWFJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bAWpZV9G; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759949934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vn4CeiQ0r8D1fLDDSKVzE9nFg8D/XnQ/f/O/x7Mav0A=;
	b=bAWpZV9GgcU6ICDKvxnFP/BX5aTzYHu83vlKFmn8sop/6mwxvNFV4Gbb57/60XhwrsHmN/
	nlXpscz7x1d1+uEhGdVcRQiOu698MexiqvJR21p2ou7uq7NLluZLTsb/GfbtevazchB6gS
	50+qEMBoZzXgBXA8fulFj+VYVWDOIHg=
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
In-Reply-To: <20251007125056.115379-1-daniel.sedlak@cdn77.com> (Daniel
	Sedlak's message of "Tue, 7 Oct 2025 14:50:56 +0200")
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
Date: Wed, 08 Oct 2025 11:58:46 -0700
Message-ID: <87qzvdqkyh.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Daniel Sedlak <daniel.sedlak@cdn77.com> writes:

> This patch is a result of our long-standing debug sessions, where it all
> started as "networking is slow", and TCP network throughput suddenly
> dropped from tens of Gbps to few Mbps, and we could not see anything in
> the kernel log or netstat counters.
>
> Currently, we have two memory pressure counters for TCP sockets [1],
> which we manipulate only when the memory pressure is signalled through
> the proto struct [2]. However, the memory pressure can also be signaled
> through the cgroup memory subsystem, which we do not reflect in the
> netstat counters. In the end, when the cgroup memory subsystem signals
> that it is under pressure, we silently reduce the advertised TCP window
> with tcp_adjust_rcv_ssthresh() to 4*advmss, which causes a significant
> throughput reduction.
>
> Keep in mind that when the cgroup memory subsystem signals the socket
> memory pressure for a given cgroup, it affects all sockets used in that
> cgroup, including children cgroups.
>
> This patch exposes a new file for each cgroup in sysfs which is a
> read-only single value file showing how many microseconds this cgroup
> contributed to throttling the throughput of network sockets. The file is
> accessible in the following path.
>
>   /sys/fs/cgroup/**/<cgroup name>/memory.net.throttled_usec

Hi Daniel!

How this value is going to be used? In other words, do you need an
exact number or something like memory.events::net_throttled would be
enough for your case?

Thanks!

