Return-Path: <cgroups+bounces-2439-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193628A1240
	for <lists+cgroups@lfdr.de>; Thu, 11 Apr 2024 12:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F3E281E27
	for <lists+cgroups@lfdr.de>; Thu, 11 Apr 2024 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAF7146A89;
	Thu, 11 Apr 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6O7sCX2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BE2EAE5;
	Thu, 11 Apr 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832768; cv=none; b=k0fgTbeVuEE/8dV9vERkzC+jnw1GybKnkr584weJzDtXqUzRjqiyJxdfJeZWAJ1SXXuv1lNS3QrXJOVPiSlYzWAbSveb28i0q3AZMtxJPdGYtAQYQJf4C3/ewE+U4Yi50himFm5WTFgeDOUfnacvtfpMnLDB+1TTWRU/D7EVsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832768; c=relaxed/simple;
	bh=2+BMqv0zv41ze5j96rjYFka98tDLkisxXseZQcP/9sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJ+ofa7xQ0jp8lLUjI2Plv2d/kREUx2auQiD68wf6dbhNczJlQP7t1/Uam9s4NsnTOW+tc7HDwx/xcRoC0S5hBJT9cQfOJ82RWNKbl0c5uswm42oSCoj0FkxWJH1hRS0YGtVrdo3/I60ct/y4Qz8aiguOqYWPNM75mPzgDcEzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6O7sCX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C50C433F1;
	Thu, 11 Apr 2024 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712832768;
	bh=2+BMqv0zv41ze5j96rjYFka98tDLkisxXseZQcP/9sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6O7sCX2TFLbIuAYfCTUnb6DevJ+Olt4zVslsQlxjUrX/ROYGVwZCG6jSa7vqBud5
	 aA+h7S7OiK7FN4fBwwA4+2Sv4g7nv6DHu8K2ji0D35jF4gWPJ/3dtlZtCfT/04WMkL
	 t63QgcXvM+DCHlgSm+2YhfOa5TOU811tt4BL7XO3uxRhMkhXSYkHdKWOefT1G0mHtD
	 ZPqN2zWl2u+7V80InKPJB+F+4lpk8q2w7js4S+bEDOTIiP0FtrGnxxssNICx9wtcXs
	 17D5IfyupQ3H1JGzTLZRvG82jdriXAoqn/MXqVFBsHx9TLqgfmR9PMrA8jfZmStc6H
	 O0iPfmriejbhg==
Date: Thu, 11 Apr 2024 07:52:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
	Jesper Dangaard Brouer <jesper@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Shakeel Butt <shakeelb@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	kernel-team <kernel-team@cloudflare.com>, cgroups@vger.kernel.org,
	Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Ivan Babrou <ivan@cloudflare.com>
Subject: Re: Advice on cgroup rstat lock
Message-ID: <ZhfA_OQZxAp7ubYL@x1>
References: <7cd05fac-9d93-45ca-aa15-afd1a34329c6@kernel.org>
 <20240319154437.GA144716@cmpxchg.org>
 <56556042-5269-4c7e-99ed-1a1ab21ac27f@kernel.org>
 <CAJD7tkYbO7MdKUBsaOiSp6-qnDesdmVsTCiZApN_ncS3YkDqGQ@mail.gmail.com>
 <bf94f850-fab4-4171-8dfe-b19ada22f3be@kernel.org>
 <CAJD7tkbn-wFEbhnhGWTy0-UsFoosr=m7wiJ+P96XnDoFnSH7Zg@mail.gmail.com>
 <ac4cf07f-52dd-454f-b897-2a4b3796a4d9@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac4cf07f-52dd-454f-b897-2a4b3796a4d9@kernel.org>

On Tue, Apr 09, 2024 at 01:08:40PM +0200, Jesper Dangaard Brouer wrote:
> Let move this discussion upstream.
> 
> On 22/03/2024 19.32, Yosry Ahmed wrote:
> > [..]
> > > > There was a couple of series that made all calls to
> > > > cgroup_rstat_flush() sleepable, which allows the lock to be dropped
> > > > (and IRQs enabled) in between CPU iterations. This fixed a similar
> > > > problem that we used to face (except in our case, we saw hard lockups
> > > > in extreme scenarios):
> > > > https://lore.kernel.org/linux-mm/20230330191801.1967435-1-yosryahmed@google.com/
> > > > https://lore.kernel.org/lkml/20230421174020.2994750-1-yosryahmed@google.com/
> > > 
> > > I've only done the 6.6 backport, and these were in 6.5/6.6.
> 
> Given I have these in my 6.6 kernel. You are basically saying I should
> be able to avoid IRQ-disable for the lock, right?
> 
> My main problem with the global cgroup_rstat_lock[3] is it disables IRQs
> and (thereby also) BH/softirq (spin_lock_irq).  This cause production
> issues elsewhere, e.g. we are seeing network softirq "not-able-to-run"
> latency issues (debug via softirq_net_latency.bt [5]).
> 
>   [3]
> https://elixir.bootlin.com/linux/v6.9-rc3/source/kernel/cgroup/rstat.c#L10
>   [5] https://github.com/xdp-project/xdp-project/blob/master/areas/latency/softirq_net_latency.bt
> 
> 
> > > And between 6.1 to 6.6 we did observe an improvement in this area.
> > > (Maybe I don't have to do the 6.1 backport if the 6.6 release plan progress)
> > > 
> > > I've had a chance to get running in prod for 6.6 backport.
> > > As you can see in attached grafana heatmap pictures, we do observe an
> > > improved/reduced softirq wait time.
> > > These softirq "not-able-to-run" outliers is *one* of the prod issues we
> > > observed.  As you can see, I still have other areas to improve/fix.
> > 
> > I am not very familiar with such heatmaps, but I am glad there is an
> > improvement with 6.6 and the backports. Let me know if there is
> > anything I could do to help with your effort.
> 
> The heatmaps give me an overview, but I needed a debugging tool, so I
> developed some bpftrace scripts [1][2] I'm running on production.
> To measure how long time we hold the cgroup rstat lock (results below).
> Adding ACME and Daniel as I hope there is an easier way to measure lock
> hold time and congestion. Notice tricky release/yield in
> cgroup_rstat_flush_locked[4].

Have you tried:

root@number:~# echo 1 > /proc/sys/vm/drop_caches
root@number:~# perf lock contention -b find / > /dev/null
 contended   total wait     max wait     avg wait         type   caller

         8     16.32 s       7.08 s       2.04 s      spinlock   tick_do_update_jiffies64+0x25
         2      1.58 s       1.58 s     787.88 ms     spinlock   raw_spin_rq_lock_nested+0x1c
        19    165.77 us     24.93 us      8.72 us      rwsem:R   __btrfs_tree_read_lock+0x1b
        17    103.15 us     16.31 us      6.07 us      rwsem:R   __btrfs_tree_read_lock+0x1b
         3     21.45 us      7.88 us      7.15 us      rwsem:R   __btrfs_tree_read_lock+0x1b
         1     10.62 us     10.62 us     10.62 us     spinlock   raw_spin_rq_lock_nested+0x1c
         1      5.57 us      5.57 us      5.57 us      rwsem:R   __btrfs_tree_read_lock+0x1b
         1      5.49 us      5.49 us      5.49 us     spinlock   tick_do_update_jiffies64+0x25
root@number:~# perf lock contention -b find / > /dev/null
 contended   total wait     max wait     avg wait         type   caller

         1      5.91 us      5.91 us      5.91 us      rwsem:R   __btrfs_tree_read_lock+0x1b
root@number:~#

?

There are other modes of operation:

root@number:~# perf lock contention --help

 Usage: perf lock contention [<options>]

    -a, --all-cpus        System-wide collection from all CPUs
    -b, --use-bpf         use BPF program to collect lock contention stats
    -C, --cpu <cpu>       List of cpus to monitor
    -E, --entries <n>     display this many functions
    -F, --field <contended,wait_total,wait_max,avg_wait>
                          output fields (contended / wait_total / wait_max / wait_min / avg_wait)
    -G, --cgroup-filter <CGROUPS>
                          Filter specific cgroups
    -k, --key <wait_total>
                          key for sorting (contended / wait_total / wait_max / wait_min / avg_wait)
    -l, --lock-addr       show lock stats by address
    -L, --lock-filter <ADDRS/NAMES>
                          Filter specific address/symbol of locks
    -M, --map-nr-entries <num>
                          Max number of BPF map entries
    -o, --lock-owner      show lock owners instead of waiters
    -p, --pid <pid>       Trace on existing process id
    -S, --callstack-filter <NAMES>
                          Filter specific function in the callstack
    -t, --threads         show per-thread lock stats
    -x, --field-separator <separator>
                          print result in CSV format with custom separator
    -Y, --type-filter <FLAGS>
                          Filter specific type of locks
        --lock-cgroup     show lock stats by cgroup
        --max-stack <num>
                          Set the maximum stack depth when collecting lock contention, Default: 8
        --stack-skip <n>  Set the number of stack depth to skip when finding a lock caller, Default: 4
        --tid <tid>       Trace on existing thread id (exclusive to --pid)

root@number:~#

Looking at:

git log tools/perf/util/bpf_skel/lock_contention.bpf.c tools/perf/builtin-lock.c

Will show you more examples and details about its implementation that
may help in tailoring it to your needs.

- Arnaldo
 
> My production results on 6.6 with backported patches (below signature)
> vs a our normal 6.6 kernel, with script [2]. The `@lock_time_hist_ns`
> shows how long time the lock+IRQs were disabled (taking into account it
> can be released in the loop [4]).
> 
> Patched kernel:
> 
> 21:49:02  time elapsed: 43200 sec
> @lock_time_hist_ns:
> [2K, 4K)              61 |      |
> [4K, 8K)             734 |      |
> [8K, 16K)         121500 |@@@@@@@@@@@@@@@@      |
> [16K, 32K)        385714
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [32K, 64K)        145600 |@@@@@@@@@@@@@@@@@@@      |
> [64K, 128K)       156873 |@@@@@@@@@@@@@@@@@@@@@      |
> [128K, 256K)      261027 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> [256K, 512K)      291986 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> [512K, 1M)        101859 |@@@@@@@@@@@@@      |
> [1M, 2M)           19866 |@@      |
> [2M, 4M)           10146 |@      |
> [4M, 8M)           30633 |@@@@      |
> [8M, 16M)          40365 |@@@@@      |
> [16M, 32M)         21650 |@@      |
> [32M, 64M)          5842 |      |
> [64M, 128M)            8 |      |
> 
> And normal 6.6 kernel:
> 
> 21:48:32  time elapsed: 43200 sec
> @lock_time_hist_ns:
> [1K, 2K)              25 |      |
> [2K, 4K)            1146 |      |
> [4K, 8K)           59397 |@@@@      |
> [8K, 16K)         571528 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> [16K, 32K)        542648 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> [32K, 64K)        202810 |@@@@@@@@@@@@@      |
> [64K, 128K)       134564 |@@@@@@@@@      |
> [128K, 256K)       72870 |@@@@@      |
> [256K, 512K)       56914 |@@@      |
> [512K, 1M)         83140 |@@@@@      |
> [1M, 2M)          170514 |@@@@@@@@@@@      |
> [2M, 4M)          396304 |@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> [4M, 8M)          755537
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [8M, 16M)         231222 |@@@@@@@@@@@@@@@      |
> [16M, 32M)         76370 |@@@@@      |
> [32M, 64M)          1043 |      |
> [64M, 128M)           12 |      |
> 
> 
> For the unpatched kernel we see more events in 4ms to 8ms bucket than
> any other bucket.
> For patched kernel, we clearly see a significant reduction of events in
> the 4 ms to 64 ms area, but we still have some events in this area.  I'm
> very happy to see these patches improves the situation.  But for network
> processing I'm not happy to see events in area 16ms to 128ms area.  If
> we can just avoid disabling IRQs/softirq for the lock, I would be happy.
> 
> How far can we go... could cgroup_rstat_lock be converted to a mutex?
> 
> --Jesper
> 
>  [1] https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_latency.bt
>  [2] https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_latency_steroids.bt
>  [3]
> https://elixir.bootlin.com/linux/v6.9-rc3/source/kernel/cgroup/rstat.c#L10
>  [4]
> https://elixir.bootlin.com/linux/v6.9-rc3/source/kernel/cgroup/rstat.c#L226
> cgroup_rstat_flush_locked
>  [5] https://github.com/xdp-project/xdp-project/blob/master/areas/latency/softirq_net_latency.bt
> 
> 
> 
> Backported to 6.6
> 
> List of **main** patches address issue - to backport for 6.6:
>  - 508bed884767 mm: memcg: change flush_next_time to flush_last_time
>    - v6.8-rc1~180^2~205
>  - e0bf1dc859fd mm: memcg: move vmstats structs definition above flushing
> code
>    - v6.8-rc1~180^2~204
>  - 8d59d2214c23 mm: memcg: make stats flushing threshold per-memcg
>    - v6.8-rc1~180^2~203
>  - b00684722262 mm: workingset: move the stats flush into
> workingset_test_recent()
>    - v6.8-rc1~180^2~202
>  - 7d7ef0a4686a mm: memcg: restore subtree stats flushing
>    - v6.8-rc1~180^2~201
> 
> And extra (thanks Longman)
> 
>  - e76d28bdf9ba ("cgroup/rstat: Reduce cpu_lock hold time in
> cgroup_rstat_flush_locked()")
>   - v6.8-rc1~182^2~8
> 
> And list of patches that contain **fixes** for backports above:
>  - 9cee7e8ef3e3 mm: memcg: optimize parent iteration in
> memcg_rstat_updated()
>    - v6.8-rc4~3^2~12
>  - 13ef7424577f mm: memcg: don't periodically flush stats when memcg is
> disabled
>    - v6.8-rc5-69-g13ef7424577f
> 

