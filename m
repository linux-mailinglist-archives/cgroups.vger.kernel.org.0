Return-Path: <cgroups+bounces-8360-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDDAAC58BB
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 19:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB143ADFA6
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F25527FB10;
	Tue, 27 May 2025 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZHBAysI3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110442A9B
	for <cgroups@vger.kernel.org>; Tue, 27 May 2025 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368118; cv=none; b=rVlYySlLbi9TCCwzWuA9Y6FcueLIcNSsjkY4aG9ybS5HgA1XZi6YC8xz0fg+a+/Jz1iuV9nSC0CZ+Iwcjc+BECdUdwYJPMUyqqO07Xh20j5/u4/D/an+4TWiXjgVs44SCdg85AOZ4Kv99RfEweKkbwU3t7+5pjuGNWMqDjCNEWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368118; c=relaxed/simple;
	bh=zacgsMYOqWILDnDHjYRXe7knHpcE0yjWJV54mpR//9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCtADKpjG9U9M3JeijdEW6vP38KcGasbgYO2GZjOBm0XBFvVnlbuvH8Wid/FUrui85kyYWjqnNbpOS+c6CzgYFJL6P90B38cELkCaIC3UY0kQA4st82zdASABitBqLhcORUR86i5q427/CHwcQQAWeZOkTWA6bRF1i5fGKf3MDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZHBAysI3; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 May 2025 10:48:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748368112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eTgeKip1dFEF8TN491NA/pilIthAMBoQOcmCRidVyX8=;
	b=ZHBAysI3TGX9PbZFh2Ha984UVBpYhYZH9MEejkZiWAWahrYeFnFSeHrnCLyH4p4/7871H8
	68ehRduLxEcj1NthLGOgi80gP6he0VYxbHYjSK95djwgQKhAN6n08wz7dXCxq2XqF58WVK
	/0uKxEJuzz7+hqp7z79Kggd6trMieEw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: peterz@infradead.org, akpm@linux-foundation.org, mkoutny@suse.com, 
	mingo@redhat.com, tj@kernel.org, hannes@cmpxchg.org, corbet@lwn.net, 
	mgorman@suse.de, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, tim.c.chen@intel.com, aubrey.li@intel.com, libo.chen@oracle.com, 
	kprateek.nayak@amd.com, vineethr@linux.ibm.com, venkat88@linux.ibm.com, ayushjai@amd.com, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yu.chen.surf@foxmail.com
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
Message-ID: <qcasnjdjet57uxhwavfiaxepq7anf2zvmi4rzkp5lxysovqwme@wwcyh4nvlxiv>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
 <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5>
 <ad9f8af5-6bac-48c0-924b-498863370079@intel.com>
 <CAGj-7pX9yFFEFuMPgXBL_gsWevX8MtUZix5qyUQxOqWGKcbFzA@mail.gmail.com>
 <52a1b56b-9598-499d-ac9c-de99479d5166@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a1b56b-9598-499d-ac9c-de99479d5166@intel.com>
X-Migadu-Flow: FLOW_OUT

On Sun, May 25, 2025 at 08:35:24PM +0800, Chen, Yu C wrote:
> On 5/25/2025 1:32 AM, Shakeel Butt wrote:
[...]
> > can you please give an end-to-end> flow/story of all these events
> happening on a timeline.
> > 
> 
> Yes, sure, let me have a try.
> 
> The goal of NUMA balancing is to co-locate a task and its
> memory pages on the same NUMA node. There are two strategies:
> migrate the pages to the task's node, or migrate the task to
> the node where its pages reside.
> 
> Suppose a task p1 is running on Node 0, but its pages are
> located on Node 1. NUMA page fault statistics for p1 reveal
> its "page footprint" across nodes. If NUMA balancing detects
> that most of p1's pages are on Node 1:
> 
> 1.Page Migration Attempt:
> The Numa balance first tries to migrate p1's pages to Node 0.
> The numa_page_migrate counter increments.
> 
> 2.Task Migration Strategies:
> After the page migration finishes, Numa balance checks every
> 1 second to see if p1 can be migrated to Node 1.
> 
> Case 2.1: Idle CPU Available
> If Node 1 has an idle CPU, p1 is directly scheduled there. This event is
> logged as numa_task_migrated.
> Case 2.2: No Idle CPU (Task Swap)
> If all CPUs on Node1 are busy, direct migration could cause CPU contention
> or load imbalance. Instead:
> The Numa balance selects a candidate task p2 on Node 1 that prefers
> Node 0 (e.g., due to its own page footprint).
> p1 and p2 are swapped. This cross-node swap is recorded as
> numa_task_swapped.
> 

Thanks for the explanation, this is really helpful and I would like this
to be included in the commit message.

> > Beside that, do you think there might be some other scheduling events
> > (maybe unrelated to numa balancing) which might be suitable for
> > memory.stat? Basically I am trying to find if having sched events in
> > memory.stat be an exception for numa balancing or more general.
> 
> If the criterion is a combination of task scheduling strategy and
> page-based operations, I cannot find any other existing scheduling
> events. For now, NUMA balancing seems to be the only case.

Mainly I was looking if in future we need to add more sched events to
memory.stat file.

Let me reply on the other email chain on what should we do next.

