Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF826A4C92
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 21:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjB0U5c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 15:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0U5b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 15:57:31 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED0725E12
        for <cgroups@vger.kernel.org>; Mon, 27 Feb 2023 12:57:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so4619712wmc.5
        for <cgroups@vger.kernel.org>; Mon, 27 Feb 2023 12:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mIN6ww9oLAv0WN7ho6gwiiph4rXuoFMoHbwtuWGbIHU=;
        b=Bs3g5spl/LV0O4iixDMwb4HTPJIpTc4sSBY9TtNyJL/a3/Nrx2kG5iGhiEX08R9jBR
         gCcRIOqtI3O6Y3suKyaQJfD7NVzanN4Vj5SFZOL854LgBBdVnnQwJcG3WpU3k89X744Y
         IiZlrJdvjiVqN0gYOioxEghDHwwp+0DdIOlpwzB18fM00B8mVRsockbPsOkP4mfo2eNp
         ZRz3sxf5CAG7g9y+dy7ZEieNW7LQY3+UX3vy1Pxh6mNeA1dNKYnhLC+/CDdKre9YRDhb
         Gnczi0b8tPU04O1L0L2Sg6YmZo8O6b05iyzA19wLaeNrkoSaWVYPq8TySqXIzDw7bHRu
         qS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIN6ww9oLAv0WN7ho6gwiiph4rXuoFMoHbwtuWGbIHU=;
        b=5Zxdptg+3M9JwxlxCihEKcrzJAlk6mooGtj/v3Y8tXvNwkQtPbMNOm9sdvxlyILZ/o
         2VsUC7uGa6ObJM+NGJrnECL+IQZZoLP/U1l1seFvFdPP9+HGzcK7lgCluU4AU57/JzBL
         ffv4dnEXXgl44vdexsCWTYMisFtu08HCMK26mYrnVUsVP/NP4J/Vjpq+lAqP55TlKuRN
         fpuIrVdOz+qbzmq/43laiGzY826YWi79genqoPb6PifVppn6tXhPGaQqn0FDoo5DoDty
         aoyu1ssmrrr2zUJERAbbu+WJmjOvnKTgt2tx5MvynQJKNgudLOAtz+T4+LQazby1fBwx
         YjSQ==
X-Gm-Message-State: AO0yUKUBgDRVTDHE8F1O7jFkIfruYXmU3xZnKf90U4y1g9Ny6AzaGGoS
        bJYOTCmyJmyXrHx8yFf7hcI0bRawoZj7hpje
X-Google-Smtp-Source: AK7set9cV982AukExVNBM7MELBIvJxaOh5XSQ0Jm7pXb7qLYusYIVl6TO/LrXSSLszGi4N40OISX5g==
X-Received: by 2002:a05:600c:540a:b0:3eb:fc6:79cf with SMTP id he10-20020a05600c540a00b003eb0fc679cfmr398908wmb.6.1677531447998;
        Mon, 27 Feb 2023 12:57:27 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id c16-20020a05600c0ad000b003e214803343sm13479356wmr.46.2023.02.27.12.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 12:57:27 -0800 (PST)
Date:   Mon, 27 Feb 2023 20:57:25 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Message-ID: <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 02/24/23 16:14, Dietmar Eggemann wrote:
> On 23/02/2023 16:38, Qais Yousef wrote:
> 
> IMHO the patch title is misleading since what you want to avoid in
> certain cases is that the RD DL accounting is updated.

The code calls it rebuild_root_domain() ..

> 
> > On 02/06/23 22:14, Qais Yousef wrote:
> >> Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")

.. and so is the original patch title.

I think I have enough explanation in the commit message and renamed the
function name to be more descriptive too.

> >> enabled rebuilding root domain on cpuset and hotplug operations to
> >> correct deadline accounting.
> >>
> >> Rebuilding root domain is a slow operation and we see 10+ of ms delays
> >> on suspend-resume because of that (worst case captures 20ms which
> >> happens often).
> >>
> >> Since nothing is expected to change on suspend-resume operation; skip
> >> rebuilding the root domains to regain the some of the time lost.
> >>
> >> Achieve this by refactoring the code to pass whether dl accoutning needs
> >> an update to rebuild_sched_domains(). And while at it, rename
> >> rebuild_root_domains() to update_dl_rd_accounting() which I believe is
> >> a more representative name since we are not really rebuilding the root
> >> domains, but rather updating dl accounting at the root domain.
> >>
> >> Some users of rebuild_sched_domains() will skip dl accounting update
> >> now:
> >>
> >> 	* Update sched domains when relaxing the domain level in cpuset
> >> 	  which only impacts searching level in load balance
> 
> This one is cpuset related. (1)
> 
> >> 	* update sched domains when cpufreq governor changes and we need
> >> 	  to create the perf domains
> 
> This one is drivers/base/arch_topology.c [arm/arm64/...] related. (2)
> 
> There are several levels of passing this `update_dl_accounting`
> information through. I guess it looks like this:
> 
> 					update_dl_accounting
> 
> arm/arm64/riscv/parisc specific:
> update_topology_flags_workfn()		true
> rebuild_sched_domains_energy()		false (2)
> 
> cpuset_hotplug_workfn()                 cpus_updated ||
>                          force_rebuild == CPUSET_FORCE_REBUILD_PRS_ERROR
> 
> ->rebuild_sched_domains(update_dl_accounting)
> 
>   update_cpumasks_hier()		true
>   update_relax_domain_level()		false (1)
>   update_flag()				true
>   update_prstate()			true
> 
>   ->rebuild_sched_domains_locked(update_dl_accounting)
> 
>     ->partition_and_rebuild_sched_domains(..., update_dl_accounting)
> 
>         if (update_dl_accounting)
>           update_dl_rd_accounting()
> 
> 
> There is already a somehow hidden interface for `sd/rd rebuild`
> 
>   int __weak arch_update_cpu_topology(void)
> 
> which lets partition_sched_domains_locked() figure out whether sched
> domains have to be rebuild..
> 
> But in your case it is more on the interface `cpuset/hotplug -> sd/rd
> rebuild` and not only `arch -> `sd/rd rebuild``.
> 
> IMHO, it would be still nice to have only one way to tell `sd/rd
> rebuild` what to do and what not to do during sd/rd/(pd) rebuild.

IIUC you're suggesting to introduce some new mechanism to detect if hotplug has
lead to a cpu to disappear or not and use that instead? Are you saying I can
use arch_update_cpu_topology() for that? Something like this?

	diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
	index e5ddc8e11e5d..60c3dcf06f0d 100644
	--- a/kernel/cgroup/cpuset.c
	+++ b/kernel/cgroup/cpuset.c
	@@ -1122,7 +1122,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
	 {
		mutex_lock(&sched_domains_mutex);
		partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
	-       if (update_dl_accounting)
	+       if (arch_update_cpu_topology())
			update_dl_rd_accounting();
		mutex_unlock(&sched_domains_mutex);
	 }

I am not keen on this. arm64 seems to just read a value without a side effect.
But x86 does reset this value so we can't read it twice in the same call tree
and I'll have to extract it.

The better solution that was discussed before is to not iterate through every
task in the system and let cpuset track when dl tasks are added to it and do
smarter iteration. ATM even if there are no dl tasks in the system we'll
blindly go through every task in the hierarchy to update nothing.

But I'll leave that to Juri to address if he wants. The original change has
introduced a regression and people have noticed when phones cycle through
suspend resume (screen unlock). Juri - could you please chip in on how you want
to address this regression? In theory I should be just a reporter, but trying
my best to help ;-)


Cheers

--
Qais Yousef
