Return-Path: <cgroups+bounces-6626-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBB7A3E287
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 18:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621483A5E24
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 17:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E8E212D69;
	Thu, 20 Feb 2025 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DTmirjTC"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37055212D68
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072374; cv=none; b=LZaOjwiRwT2ILKIlyyReoYfe88gwhN9+y2Rn4g7pW7SeKzx/IMAxc2aZOiF9FiA1McxjV6Mpxv25Owg/A9fDQsuyo+WMc736saF1ifB/8PZ84bdc52SRtS3aN62Fll59xGdI4190xOuVAxVGiy9nrsfSI6r+dP6WAlGVzGa0oJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072374; c=relaxed/simple;
	bh=f/3FDl23e3PbpHYgNyUxhu8OulS6SRc1hvA/c3EoWYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTZBwiZAh/2SHO+bd9ccmqwXM/uCfNR8Y/JirYMn/pOtIOo8ztRgmIqlO1zOFNe3vOWIwM/X/tD/hrMNhXWI3xdSOp1mXclNvz49Ab6K6uArqTa/S8yWolhG+8D0QkaqA1lujQegAzP1M+VAgXOJgmndWFQHXrLf6fIKfBsD7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DTmirjTC; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 17:26:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740072370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jRhcU0Mbg7q4PcqTiSxujPYCwqAbOKh6TIuigOs+K/c=;
	b=DTmirjTC8kIJMnUqZYRlMTUzBmQQXrBr2Wx90i5dg0AlqMgZ+oz0TdMt58iS8xuglNzfT3
	Tyav2oAynhkWI5AyZfNpO7VBc5vyO3TfDZn7D1d4bYXwPxeonVYEWktGjVxaHtvxd5DUMu
	sck1z8GB+a9zsJ8aP9T24uv2TJt9EOw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, tj@kernel.org, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 00/11] cgroup: separate rstat trees
Message-ID: <Z7dlrEI-dNPajxik@google.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-1-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 17, 2025 at 07:14:37PM -0800, JP Kobryn wrote:
> The current design of rstat takes the approach that if one subsystem is to
> be flushed, all other subsystem controllers with pending updates should
> also be flushed. It seems that over time, the stat-keeping of some
> subsystems has grown in size to the extent that they are noticeably slowing
> down others. This has been most observable in situations where the memory
> controller is enabled. One big area where the issue comes up is system
> telemetry, where programs periodically sample cpu stats. It would be a
> benefit for programs like this if the overhead of flushing memory stats
> (and others) could be eliminated. It would save cpu cycles for existing
> cpu-based telemetry programs and improve scalability in terms of increasing
> sampling frequency and volume of hosts the program is running on - the cpu
> cycles saved helps free up the budget for cycles to be spent on the desired
> stats.
> 
> This series changes the approach of "flush all subsystems" to "flush only the
> requested subsystem". The core design change is moving from a single unified
> rstat tree to having separate trees: one for each enabled subsystem controller
> (if it implements css_rstat_flush()), one for the base stats (cgroup::self)
> subsystem state, and one dedicated to bpf-based cgroups (if enabled). A layer
> of indirection was introduced to rstat. Where a cgroup reference was previously
> used as a parameter, the updated/flush families of functions were changed to
> instead accept a references to a new cgroup_rstat struct along with a new
> interface containing ops that perform type-specific pointer offsets for
> accessing common types. The ops allow rstat routines to work only with common
> types while hiding away any unique types. Together, the new struct and
> interface allows for extending the type of entity that can participate in
> rstat. In this series, the cgroup_subsys_state and the cgroup_bpf are now
> participants. For both of these structs, the cgroup_rstat struct was added as a
> new field and ops were statically defined for both types in order to provide
> access to related objects. To illustrate, the cgroup_subsys_state was given an
> rstat_struct field and one of its ops was defined to get a pointer to the
> rstat_struct of its parent.  Public api's were changed. In order for clients to
> be specific about which stats are being updated or flushed, a reference to the
> given cgroup_subsys_state is passed instead of the cgroup. For the bpf api's, a
> cgroup is still passed as an argument since there is no subsystem state
> associated with these custom cgroups. However, the names of the api calls were
> changed and now have a "bpf_" prefix. Since separate trees are in use, the
> locking scheme was adjusted to prevent any contention. Separate locks exist for
> the three categories: base stats (cgroup::self), formal subsystem controllers
> (memory, io, etc), and bpf-based cgroups. Where applicable, the functions for
> lock management were adjusted to accept parameters instead of globals.
> 
> Breaking up the unified tree into separate trees eliminates the overhead
> and scalability issue explained in the first section, but comes at the
> expense of using additional memory. In an effort to minimize the additional
> memory overhead, a conditional allocation is performed. The
> cgroup_rstat_cpu originally contained the rstat list pointers and the base
> stat entities. The struct was reduced to only contain the list pointers.
> For the single case of where base stats are participating in rstat, a new
> struct cgroup_rstat_base_cpu was created that contains the list pointers
> and the base stat entities. The conditional allocation is done only when
> the cgroup::self subsys_state is initialized. Since the list pointers exist
> at the beginning of the cgroup_rstat_cpu and cgroup_rstat_base_cpu struct,
> a union is used to access one type of pointer or the other depending on if
> cgroup::self is detected; it is the one subsystem state where the subsystem
> pointer is NULL. With this change, the total memory overhead on a per-cpu
> basis is:
> 
> nr_cgroups * (
> 	sizeof(struct cgroup_rstat_base_cpu) +
> 	sizeof(struct cgroup_rstat_cpu) * nr_controllers
> )
> 
> if bpf-based cgroups are enabled:
> 
> nr_cgroups * (
> 	sizeof(struct cgroup_rstat_base_cpu) +
> 	sizeof(struct cgroup_rstat_cpu) * (nr_controllers + 1)
> )

Adding actual numbers here as examples would help, instead of people
having to look at the size of these structs at the end of the series.
You can calculate the per CPU per cgroup size on a popular arch (e.g.
x86_64) and that here.

Also, it would be useful to specify the change in memory overhead. IIUC,
sizeof(struct cgroup_rstat_base_cpu) is irrelevant because we are
already using that today anyway, so the actual increase is sizeof(struct
cgroup_rstat_cpu) * (nr_controllers - 1).

Another question is, does it make sense to keep BPF flushing in the
"self" css with base stats flushing for now? IIUC BPF flushing is not
very popular now anyway, and doing so will remove the need to support
flushing and updating things that are not css's. Just food for thought.

> 
> ... where nr_controllers is the number of enabled cgroup controllers
> that implement css_rstat_flush().
> 
> With regard to validation, there is a measurable benefit when reading a
> specific set of stats. Using the cpu stats as a basis for flushing, some
> experiments were set up to measure the perf and time differences.
> 
> The first experiment consisted of a parent cgroup with memory.swap.max=0
> and memory.max=1G. On a 52-cpu machine, 26 child cgroups were created and
> within each child cgroup a process was spawned to encourage the updating of
> memory cgroup stats by creating and then reading a file of size 1T
> (encouraging reclaim). These 26 tasks were run in parallel.  While this was
> going on, a custom program was used to open cpu.stat file of the parent
> cgroup, read the entire file 1M times, then close it. The perf report for
> the task performing the reading showed that most of the cycles (42%) were
> spent on the function mem_cgroup_css_rstat_flush() of the control side. It
> also showed a smaller but significant number of cycles spent in
> __blkcg_rstat_flush. The perf report for patched kernel differed in that no
> cycles were spent in these functions. Instead most cycles were spent on
> cgroup_base_stat_flush(). Aside from the perf reports, the amount of time
> spent running the program performing the reading of cpu.stats showed a gain
> when comparing the control to the experimental kernel.The time in kernel
> mode was reduced.
> 
> before:
> real    0m18.449s
> user    0m0.209s
> sys     0m18.165s
> 
> after:
> real    0m6.080s
> user    0m0.170s
> sys     0m5.890s
> 
> Another experiment on the same host was setup using a parent cgroup with
> two child cgroups. The same swap and memory max were used as the previous
> experiment. In the two child cgroups, kernel builds were done in parallel,
> each using "-j 20". The program from the previous experiment was used to
> perform 1M reads of the parent cpu.stat file. The perf comparison showed
> similar results as the previous experiment. For the control side, a
> majority of cycles (42%) on mem_cgroup_css_rstat_flush() and significant
> cycles in __blkcg_rstat_flush(). On the experimental side, most cycles were
> spent on cgroup_base_stat_flush() and no cycles were spent flushing memory
> or io. As for the time taken by the program reading cpu.stat, measurements
> are shown below.
> 
> before:
> real    0m17.223s
> user    0m0.259s
> sys     0m16.871s
> 
> after:
> real    0m6.498s
> user    0m0.237s
> sys     0m6.220s
> 
> For the final experiment, perf events were recorded during a kernel build
> with the same host and cgroup setup. The builds took place in the child
> node.  Control and experimental sides both showed similar in cycles spent
> on cgroup_rstat_updated() and appeard insignificant compared among the
> events recorded with the workload.
> 
> JP Kobryn (11):
>   cgroup: move rstat pointers into struct of their own
>   cgroup: add level of indirection for cgroup_rstat struct
>   cgroup: move cgroup_rstat from cgroup to cgroup_subsys_state
>   cgroup: introduce cgroup_rstat_ops
>   cgroup: separate rstat for bpf cgroups
>   cgroup: rstat lock indirection
>   cgroup: fetch cpu-specific lock in rstat cpu lock helpers
>   cgroup: rstat cpu lock indirection
>   cgroup: separate rstat locks for bpf cgroups
>   cgroup: separate rstat locks for subsystems
>   cgroup: separate rstat list pointers from base stats
> 
>  block/blk-cgroup.c                            |   4 +-
>  include/linux/bpf-cgroup-defs.h               |   3 +
>  include/linux/cgroup-defs.h                   |  98 +--
>  include/linux/cgroup.h                        |  11 +-
>  include/linux/cgroup_rstat.h                  |  97 +++
>  kernel/bpf/cgroup.c                           |   6 +
>  kernel/cgroup/cgroup-internal.h               |   9 +-
>  kernel/cgroup/cgroup.c                        |  65 +-
>  kernel/cgroup/rstat.c                         | 556 +++++++++++++-----
>  mm/memcontrol.c                               |   4 +-
>  .../selftests/bpf/progs/btf_type_tag_percpu.c |   5 +-
>  .../bpf/progs/cgroup_hierarchical_stats.c     |   6 +-
>  12 files changed, 594 insertions(+), 270 deletions(-)
>  create mode 100644 include/linux/cgroup_rstat.h
> 
> -- 
> 2.43.5
> 
> 

