Return-Path: <cgroups+bounces-7243-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F7AA73A43
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 18:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E780D1887F2E
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F4187332;
	Thu, 27 Mar 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DbjYPUBz"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815432114
	for <cgroups@vger.kernel.org>; Thu, 27 Mar 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095830; cv=none; b=NaUPc1fulMi/xRAKZ3MziJAnbGt3xD68bq6NkJ8RmBeRstCCdxeLQOjQTaJZatKDl3fu6QS4u3aC/8PPa3jN1Ig6KtUQM0hf22ETq66Mm753r/psxMBjR3ELF+XSQSOxdN5UN0p07K0V5MQ9TtSL5kFyaUrAR3UJfcz/0I9EPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095830; c=relaxed/simple;
	bh=F3Us6le0sIiVn4g7WXS2x7d7NBrZXcRAh8W39F5pEJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDVFOV7cRnsYJIdIm4bjcXUMw0Ydg7Gg07lV14Q678VSahEJuuv+mXJOZPWKF6hKOguGO+utzFUT9ueNvfCSYajMXnp2TjrSQQs1/EvV6upLv83dOM2QROa0i+0TfeOBgTJASUL5POaQKikhjuGlL7N8xWnAsmVEuBDNhFWQMAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DbjYPUBz; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Mar 2025 17:17:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743095826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7bRxmqvl0+EuoCZKk7jNhwWn1DNhdJGHNDr013jHgxA=;
	b=DbjYPUBz42FxzuG4ZqZCVqWnpgGhfPXHNMZS+EKOSShqqcziRC01QRCKJqMEAUA86jYT7c
	VQYhH2WpnOaSP0rYN4bB8X4OlJbZZgIZz7iUp5CKNAsiIq3wYc1yNJQCrzFCdLEt+QdLgx
	eVHrqdlkrvzfCWhV0YqlS2BGROUvuDM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <Z-WIDWP1o4g-N5mg@google.com>
References: <20250319071330.898763-1-gthelen@google.com>
 <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>
 <Z9r8TX0WiPWVffI0@google.com>
 <2vznaaotzkgkrfoi2qitiwdjinpl7ozhpz7w6n7577kaa2hpki@okh2mkqqhbkq>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vznaaotzkgkrfoi2qitiwdjinpl7ozhpz7w6n7577kaa2hpki@okh2mkqqhbkq>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 27, 2025 at 03:38:50PM +0100, Mateusz Guzik wrote:
> On Wed, Mar 19, 2025 at 05:18:05PM +0000, Yosry Ahmed wrote:
> > On Wed, Mar 19, 2025 at 11:47:32AM +0100, Mateusz Guzik wrote:
> > > Is not this going a little too far?
> > > 
> > > the lock + irq trip is quite expensive in its own right and now is
> > > going to be paid for each cpu, as in the total time spent executing
> > > cgroup_rstat_flush_locked is going to go up.
> > > 
> > > Would your problem go away toggling this every -- say -- 8 cpus?
> > 
> > I was concerned about this too, and about more lock bouncing, but the
> > testing suggests that this actually overall improves the latency of
> > cgroup_rstat_flush_locked() (at least on tested HW).
> > 
> > So I don't think we need to do something like this unless a regression
> > is observed.
> > 
> 
> To my reading it reduces max time spent with irq disabled, which of
> course it does -- after all it toggles it for every CPU.
> 
> Per my other e-mail in the thread the irq + lock trips remain not cheap
> at least on Sapphire Rapids.
> 
> In my testing outlined below I see 11% increase in total execution time
> with the irq + lock trip for every CPU in a 24-way vm.
> 
> So I stand by instead doing this every n CPUs, call it 8 or whatever.
> 
> How to repro:
> 
> I employed a poor-man's profiler like so:
> 
> bpftrace -e 'kprobe:cgroup_rstat_flush_locked { @start[tid] = nsecs; } kretprobe:cgroup_rstat_flush_locked /@start[tid]/ { print(nsecs - @start[tid]); delete(@start[tid]); } interval:s:60 { exit(); }'
> 
> This patch or not, execution time varies wildly even while the box is idle.
> 
> The above runs for a minute, collecting 23 samples (you may get
> "lucky" and get one extra, in that case remove it for comparison).
> 
> A sysctl was added to toggle the new behavior vs old one. Patch at the
> end.
> 
> "enabled"(1) means new behavior, "disabled"(0) means the old one.
> 
> Sum of nsecs (results piped to: awk '{ sum += $1 } END { print sum }'):
> disabled:	903610
> enabled:	1006833 (+11.4%)

IIUC this calculates the amount of elapsed time between start and
finish, not necessarily the function's own execution time. Is it
possible that the increase in time is due to more interrupts arriving
during the function execution (which is what we want), rather than more
time being spent on disabling/enabling IRQs?

