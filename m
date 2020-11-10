Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213FE2ADA72
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 16:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgKJPcN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Nov 2020 10:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730666AbgKJPcM (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 10 Nov 2020 10:32:12 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE7172076E;
        Tue, 10 Nov 2020 15:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605022331;
        bh=K8VDqFdwKyqA5Y+dk5hxgwCzE73NJ2L201GMD5MtvM4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cUKAIFuHhEVNGDkyQhX0/0PFsVhuyVsW6jOBKvmQyyEsUcsqjIV+Isdq32WM4nFf6
         YSYVcRUuHFKsuSYVJPoVOxOC4bBi2XGgMdAtwkdA4ZsAKEMiA8cs9qzjRDIOBh7jzh
         ijck5y3HvRUwYrotWhZlntHnEbufKa9nzkc/7vo0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5723F35226CB; Tue, 10 Nov 2020 07:32:11 -0800 (PST)
Date:   Tue, 10 Nov 2020 07:32:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        rdunlap@infradead.org, colin.king@canonical.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH v2 0/4] support for global CPU list abbreviations
Message-ID: <20201110153211.GU3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201110040725.1478297-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110040725.1478297-1-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 09, 2020 at 11:07:21PM -0500, Paul Gortmaker wrote:
> RFC/v1 ---> v2:
> 
> commit #1:
>    leave one line stub behind for !SMP solving build failures.
>    Reported by Randy Dunlap and various build bots.
> 
> commit #4
>    manage to remember '\0' char in strlen from one line to the next.
>    Reported by Colin King.
> 
> Original description from v1/RFC below remains unchanged...

Queued and this time kicking off testing that actually includes your
patches!  ;-)

							Thanx, Paul

>  ---
> 
> The basic objective here was to add support for "nohz_full=8-last" and/or
> "rcu_nocbs="4-last" -- essentially introduce "last" as a portable
> reference evaluated at boot/runtime for anything using a CPU list.
> 
> The thinking behind this, is that people carve off a few early CPUs to
> support housekeeping tasks, and perhaps dedicate one to a busy I/O
> peripheral, and then the remaining pool of CPUs out to the end are a
> part of a commonly configured pool used for the real work the user
> cares about.
> 
> Extend that logic out to a fleet of machines - some new, and some
> nearing EOL, and you've probably got a wide range of core counts to
> contend with - even though the early number of cores dedicated to the
> system overhead probably doesn't vary.
> 
> This change would enable sysadmins to have a common bootarg across all
> such systems, and would also avoid any off-by-one fencepost errors that
> happen for users who might briefly forget that core counts start at
> zero.
> 
> Looking around before starting, I noticed RCU already had a short-form
> abbreviation "all" -- but if we want to treat CPU lists in a uniform
> matter, then tokens shouldn't be implemented at a subsystem level and
> hence be subsystem specific; each with their own variations.
> 
> So I moved "all" to global use - for boot args, and for cgroups.  Then
> I added the inverse "none" and finally, the one I wanted -- "last".
> 
> The use of "last" isn't a standalone word like "all" or "none".  It will
> be a part of a complete range specification, possibly with CSV separate
> ranges, and possibly specified multiple times.  So I had to be a bit
> more careful with string matching - and hence un-inlined the parse
> function as commit #1 in this series.
> 
> But it really is a generic support for "replace token ABC with known at
> boot value XYZ" - for example, it would be trivial to extend support to
> add "half" as a dynamic token to be replaced with 1/2 the core count,
> even though I wouldn't suggest that has a use case like "last" does.
> 
> I tested the string matching with a bunch of intentionally badly crafted
> strings in a user-space harness, and tested bootarg use with nohz_full
> and rcu_nocbs, and also the post-boot cgroup use case as per below:
> 
>    root@hackbox:/sys/fs/cgroup/cpuset# mkdir foo
>    root@hackbox:/sys/fs/cgroup/cpuset# cd foo
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>    
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 10-last > cpuset.cpus
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>    10-15
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo all > cpuset.cpus
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>    0-15
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo none > cpuset.cpus
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>    
>    root@hackbox:/sys/fs/cgroup/cpuset/foo#
> 
> This was on a 16 core machine with CONFIG_NR_CPUS=16 in .config file.
> 
> Note that the two use cases (boot and runtime) are why you see "early"
> parameter in the code - I entertained just sticking the string copy on
> the stack vs. the early alloc dance, but this felt more correct/robust.
> The cgroup and modular code using cpulist_parse() are runtime cases.
> 
> ---
> 
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Li Zefan <lizefan@huawei.com>
> 
> Paul Gortmaker (4):
>   cpumask: un-inline cpulist_parse for SMP; prepare for ascii helpers
>   cpumask: make "all" alias global and not just RCU
>   cpumask: add a "none" alias to complement "all"
>   cpumask: add "last" alias for cpu list specifications
> 
>  .../admin-guide/kernel-parameters.rst         |  20 +++
>  .../admin-guide/kernel-parameters.txt         |   4 +-
>  include/linux/cpumask.h                       |   8 ++
>  kernel/rcu/tree_plugin.h                      |  13 +-
>  lib/cpumask.c                                 | 132 ++++++++++++++++++
>  5 files changed, 165 insertions(+), 12 deletions(-)
> 
> -- 
> 2.25.1
> 
