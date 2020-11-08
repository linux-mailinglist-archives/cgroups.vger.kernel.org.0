Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3912AACB7
	for <lists+cgroups@lfdr.de>; Sun,  8 Nov 2020 19:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgKHSCY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Nov 2020 13:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHSCX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 8 Nov 2020 13:02:23 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C88DC206ED;
        Sun,  8 Nov 2020 18:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604858542;
        bh=GK/qj9bZGnpYJo6FWypLDOgY/DwucCX+/OFUjULSa/w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Y0ZvovWB6V4dh9i75Nk1BU9NUHPm4ZnQ6uQgofMyjUEqvKatwzzEvqDT/JSw8vtlA
         CQiDUNP/tSDqwT8SRBOwD+Qq4b4bB6BqvlIyeSIW0PdB5PX4dC+d8qNCefvak5KSzI
         5He+q8UK5hPUGi3ID1G3Mpq1QxnBfv6URjrOGxvw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8F77A352265A; Sun,  8 Nov 2020 10:02:22 -0800 (PST)
Date:   Sun, 8 Nov 2020 10:02:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH 0/4] RFC: support for global CPU list abbreviations
Message-ID: <20201108180222.GA17637@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201108160816.896881-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108160816.896881-1-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Nov 08, 2020 at 11:08:12AM -0500, Paul Gortmaker wrote:
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

I considered doing this when adding "all" for RCU, but was just too
lazy.  So you are a better man than I am!  ;-)

I have queued these for testing, both "all" and "last" work just fine.
Given that "all" works, I hereby declare "none" to be working by
inspection.  Therefore, for 1, 2, and 4:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

For 3:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Or I can carry them if you wish.  My expected changes in response to
this series are shown below, and are also what I used to test it.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
index 5adc675..25a765d 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
@@ -1 +1 @@
-rcutree.rcu_fanout_leaf=4 nohz_full=1-7
+rcutree.rcu_fanout_leaf=4 nohz_full=1-last
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
index 22478fd..94d3844 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
@@ -1,3 +1,3 @@
 rcupdate.rcu_self_test=1
 rcutree.rcu_fanout_exact=1
-rcu_nocbs=0-7
+rcu_nocbs=all
