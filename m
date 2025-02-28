Return-Path: <cgroups+bounces-6749-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E193BA4A15A
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 19:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0C016ED15
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 18:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5781226B971;
	Fri, 28 Feb 2025 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TyFNH99Z"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706781A2554
	for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766990; cv=none; b=ps3A3dWhCOmRBTH3IoutVUbHBvFjR2G+rimizfEwT+QZAQmO7s5bRn6nRmqYNVgRbQZ/6mTEXmy3PMQvaH2oBXq1rPBAgz5saQiDiCiB6ZAI/sIup39/eAwVxwGNYXoiznN9J4Oqrt0oOQWXjMx5+JqTbN7lhBe73+cv/ml/srs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766990; c=relaxed/simple;
	bh=dLxsZpLuGZuTSZNYagAQdnqYBdPtkVDIIrJGnNlroaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfMPw7XqnShyRk6xVsr+l0r+S2hCKb1Kt8rJ1iP2Gg00twVAMJJue/yS51EtaNzznvDTsQGipELhMD+lxixMmSrt7oYFyL9h7eXe0doO+5rETPw1nburh3KXLqeiBpuX9klHIIEcWVrTA4q74Me8gV3T256mY9YhK0EZ7is++Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TyFNH99Z; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Feb 2025 18:22:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740766983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A++5dfea9+dtEZ6XcVvMlUULHW9afvXKCEIx5VskUj0=;
	b=TyFNH99ZEHwwRfI7FoHWHjw6wcUfX+ITwvt8/6ol0hug9pytcB51uW0SB2WztZT6dTSJdQ
	PtM3ap75PbeTn/LFkITGG52XIUuvqWdSHHCn5LYcr/y/4qKVco6q6Xo9VjOgHjK5GlcDM+
	L0ed88ZC/EVvgwHfSbF6ksfhHq0Inqg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: inwardvessel <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/4 v2] cgroup: separate rstat trees
Message-ID: <Z8H_Afv2XwL_2NxJ@google.com>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227215543.49928-1-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 01:55:39PM -0800, inwardvessel wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
> 
> The current design of rstat takes the approach that if one subsystem is
> to be flushed, all other subsystems with pending updates should also be
> flushed. It seems that over time, the stat-keeping of some subsystems
> has grown in size to the extent that they are noticeably slowing down
> others. This has been most observable in situations where the memory
> controller is enabled. One big area where the issue comes up is system
> telemetry, where programs periodically sample cpu stats. It would be a
> benefit for programs like this if the overhead of having to flush memory
> stats (and others) could be eliminated. It would save cpu cycles for
> existing cpu-based telemetry programs and improve scalability in terms
> of sampling frequency and volume of hosts.
> 
> This series changes the approach of "flush all subsystems" to "flush
> only the requested subsystem". The core design change is moving from a
> single unified rstat tree of cgroups to having separate trees made up of
> cgroup_subsys_state's. There will be one (per-cpu) tree for the base
> stats (cgroup::self) and one for each enabled subsystem (if it
> implements css_rstat_flush()). In order to do this, the rstat list
> pointers were moved off of the cgroup and onto the css. In the
> transition, these list pointer types were changed to
> cgroup_subsys_state. This allows for rstat trees to now be made up of
> css nodes, where a given tree will only contains css nodes associated
> with a specific subsystem. The rstat api's were changed to accept a
> reference to a cgroup_subsys_state instead of a cgroup. This allows for
> callers to be specific about which stats are being updated/flushed.
> Since separate trees will be in use, the locking scheme was adjusted.
> The global locks were split up in such a way that there are separate
> locks for the base stats (cgroup::self) and each subsystem (memory, io,
> etc). This allows different subsystems (including base stats) to use
> rstat in parallel with no contention.
> 
> Breaking up the unified tree into separate trees eliminates the overhead
> and scalability issue explained in the first section, but comes at the
> expense of using additional memory. In an effort to minimize this
> overhead, a conditional allocation is performed. The cgroup_rstat_cpu
> originally contained the rstat list pointers and the base stat entities.
> This struct was renamed to cgroup_rstat_base_cpu and is only allocated
> when the associated css is cgroup::self. A new compact struct was added
> that only contains the rstat list pointers. When the css is associated
> with an actual subsystem, this compact struct is allocated. With this
> conditional allocation, the change in memory overhead on a per-cpu basis
> before/after is shown below.
> 
> before:
> sizeof(struct cgroup_rstat_cpu) =~ 176 bytes /* can vary based on config */
> 
> nr_cgroups * sizeof(struct cgroup_rstat_cpu)
> nr_cgroups * 176 bytes
> 
> after:
> sizeof(struct cgroup_rstat_cpu) == 16 bytes
> sizeof(struct cgroup_rstat_base_cpu) =~ 176 bytes
> 
> nr_cgroups * (
> 	sizeof(struct cgroup_rstat_base_cpu) +
> 		sizeof(struct cgroup_rstat_cpu) * nr_rstat_controllers
> 	)
> 
> nr_cgroups * (176 + 16 * nr_rstat_controllers)
> 
> ... where nr_rstat_controllers is the number of enabled cgroup
> controllers that implement css_rstat_flush(). On a host where both
> memory and io are enabled:
> 
> nr_cgroups * (176 + 16 * 2)
> nr_cgroups * 208 bytes
> 
> With regard to validation, there is a measurable benefit when reading
> stats with this series. A test program was made to loop 1M times while
> reading all four of the files cgroup.stat, cpu.stat, io.stat,
> memory.stat of a given parent cgroup each iteration. This test program
> has been run in the experiments that follow.
> 
> The first experiment consisted of a parent cgroup with memory.swap.max=0
> and memory.max=1G. On a 52-cpu machine, 26 child cgroups were created
> and within each child cgroup a process was spawned to frequently update
> the memory cgroup stats by creating and then reading a file of size 1T
> (encouraging reclaim). The test program was run alongside these 26 tasks
> in parallel. The results showed a benefit in both time elapsed and perf
> data of the test program.
> 
> time before:
> real    0m44.612s
> user    0m0.567s
> sys     0m43.887s
> 
> perf before:
> 27.02% mem_cgroup_css_rstat_flush
>  6.35% __blkcg_rstat_flush
>  0.06% cgroup_base_stat_cputime_show
> 
> time after:
> real    0m27.125s
> user    0m0.544s
> sys     0m26.491s
> 
> perf after:
> 6.03% mem_cgroup_css_rstat_flush
> 0.37% blkcg_print_stat
> 0.11% cgroup_base_stat_cputime_show
> 
> Another experiment was setup on the same host using a parent cgroup with
> two child cgroups. The same swap and memory max were used as the
> previous experiment. In the two child cgroups, kernel builds were done
> in parallel, each using "-j 20". The perf comparison of the test program
> was very similar to the values in the previous experiment. The time
> comparison is shown below.
> 
> before:
> real    1m2.077s
> user    0m0.784s
> sys     1m0.895s
> 
> after:
> real    0m32.216s
> user    0m0.709s
> sys     0m31.256s

Great results, and I am glad that the series went down from 11 patches
to 4 once we simplified the BPF handling. The added memory overhead
doesn't seem to be concerning (~320KB on a system with 100 cgroups and
100 CPUs).

Nice work.

