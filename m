Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFAA680055
	for <lists+cgroups@lfdr.de>; Sun, 29 Jan 2023 17:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjA2Q4J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 29 Jan 2023 11:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2Q4I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 29 Jan 2023 11:56:08 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A21ABF9
        for <cgroups@vger.kernel.org>; Sun, 29 Jan 2023 08:56:06 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id dr8so4208330ejc.12
        for <cgroups@vger.kernel.org>; Sun, 29 Jan 2023 08:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ACDU4kQxNu6BcX/kdRYpciYrt4iQOPv2Av6CD1oe0mo=;
        b=sONIQ8Ju1ocXuq+s24/PKcuIZFLjmW+XXWa0sAGQoltZAdtVAYwC8eRRQbI2GCbat9
         2ESmTjMDqW83uo00HVm1AQwRg2mGjPIjdIZGz/BcDA3cGbCR3IFHQ6ttO9rIHYOXXdTV
         a37P2Bfp84R1pLG69KrgCX90E1BmwiBDnw7ENp4nNRJ6hjOUGWPBKqungj0Xty67Q2lS
         x2lIiocrG5caxrmK+87iKc72FBOCP1G0gk1iICGk476f3F3oV86+BAj4XrkVw9y43cou
         zCR+ylbpXTcYnXPLe8STidmZtz2jmFJFAvx31M8MvVmAXsL5LdAB2Zz4mwtj5zNjhr6G
         XsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACDU4kQxNu6BcX/kdRYpciYrt4iQOPv2Av6CD1oe0mo=;
        b=bqYbvCImUMC824RnYc8BMUBCq2ZtSz0V/PRA2BHDqWWKYzAWE/1XN2WzFst0nU82Vn
         Kx6mm0uXtIL1rNU1ufq65UTKzJBHeSUB1tLwlusDVle/Hy7504JlfILT8eROmtzl5dqv
         H9vNv0ezDV3dagOLaDMHe7GnqMt/bFuTiYBdZ2Ms6IATqAtNdzbo99JwPxLnAHuPGijD
         TG5B8fpXXeqqym4VgkJ34QZ6os6QXeRkz99icbBQTXOUvdR3HPVVMOD7ZbAZZHl9wvTF
         woTr5tLSc1ytb/dymDqb8HqKWpniVLXu5mCgmJf1ddGh3sqXjsY7kROpCU7Q9kVC8Xn7
         LY1g==
X-Gm-Message-State: AO0yUKUiMgZzRsWPvdpbE0XKv3GzaLlqzbsqPhGZpkKE/TSjCVg3W4R8
        LUBde7UIAym662buah0n4uCyhA==
X-Google-Smtp-Source: AK7set+e4Phc3CG3tK05FL/LKNzQWTMZ5CfV6fi5vOtdtBWURtBCGo09PZ5N4xNEqtk6STfu2QTGdQ==
X-Received: by 2002:a17:906:344d:b0:878:a893:48db with SMTP id d13-20020a170906344d00b00878a89348dbmr10120544ejb.65.1675011364954;
        Sun, 29 Jan 2023 08:56:04 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id z94-20020a509e67000000b0049df0f91b78sm5564744ede.78.2023.01.29.08.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 08:56:04 -0800 (PST)
Date:   Sun, 29 Jan 2023 16:56:03 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v2] sched: cpuset: Don't rebuild sched domains on
 suspend-resume
Message-ID: <20230129165603.cmcdbcydbado4yac@airbuntu>
References: <20230120194822.962958-1-qyousef@layalina.io>
 <c4c2dec6-a72b-d675-fb42-be40e384ea2c@redhat.com>
 <20230125163546.pspvigh4groiwjy7@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230125163546.pspvigh4groiwjy7@airbuntu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 01/25/23 16:35, Qais Yousef wrote:
> On 01/20/23 17:16, Waiman Long wrote:
> > 
> > On 1/20/23 14:48, Qais Yousef wrote:
> > > Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
> > > enabled rebuilding sched domain on cpuset and hotplug operations to
> > > correct deadline accounting.
> > > 
> > > Rebuilding sched domain is a slow operation and we see 10+ ms delay on
> > > suspend-resume because of that.
> > > 
> > > Since nothing is expected to change on suspend-resume operation; skip
> > > rebuilding the sched domains to regain the time lost.
> > > 
> > > Debugged-by: Rick Yiu <rickyiu@google.com>
> > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > > ---
> > > 
> > >      Changes in v2:
> > >      	* Remove redundant check in update_tasks_root_domain() (Thanks Waiman)
> > >      v1 link:
> > >      	https://lore.kernel.org/lkml/20221216233501.gh6m75e7s66dmjgo@airbuntu/
> > > 
> > >   kernel/cgroup/cpuset.c  | 3 +++
> > >   kernel/sched/deadline.c | 3 +++
> > >   2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > > index a29c0b13706b..9a45f083459c 100644
> > > --- a/kernel/cgroup/cpuset.c
> > > +++ b/kernel/cgroup/cpuset.c
> > > @@ -1088,6 +1088,9 @@ static void rebuild_root_domains(void)
> > >   	lockdep_assert_cpus_held();
> > >   	lockdep_assert_held(&sched_domains_mutex);
> > > +	if (cpuhp_tasks_frozen)
> > > +		return;
> > > +
> > >   	rcu_read_lock();
> > >   	/*
> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > index 0d97d54276cc..42c1143a3956 100644
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -2575,6 +2575,9 @@ void dl_clear_root_domain(struct root_domain *rd)
> > >   {
> > >   	unsigned long flags;
> > > +	if (cpuhp_tasks_frozen)
> > > +		return;
> > > +
> > >   	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
> > >   	rd->dl_bw.total_bw = 0;
> > >   	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
> > 
> > cpuhp_tasks_frozen is set when thaw_secondary_cpus() or
> > freeze_secondary_cpus() is called. I don't know the exact suspend/resume
> > calling sequences, will cpuhp_tasks_frozen be cleared at the end of resume
> > sequence? Maybe we should make sure that rebuild_root_domain() is called at
> > least once at the end of resume operation.
> 
> Very good questions. It made me look at the logic again and I realize now that
> the way force_build behaves is causing this issue.
> 
> I *think* we should just make the call rebuild_root_domains() only if
> cpus_updated in cpuset_hotplug_workfn().
> 
> cpuset_cpu_active() seems to be the source of force_rebuild in my case; which
> seems to be called only after the last cpu is back online (what you suggest).
> In this case we can end up with cpus_updated = false, but force_rebuild = true.
> 
> Now you added a couple of new users to force_rebuild in 4b842da276a8a; I'm
> trying to figure out what the conditions would be there. It seems we can have
> corner cases for cpus_update might not trigger correctly?
> 
> Could the below be a good cure?
> 
> AFAICT we must rebuild the root domains if something has changed in cpuset.
> Which should be captured by either having:
> 
> 	* cpus_updated = true
> 	* force_rebuild && !cpuhp_tasks_frozen
> 
> /me goes to test the patch

It works fine.

Can we assume cpus_udpated will always be false in suspend/resume cycle? I can
then check for (force_rebuild && !cpuhp_tasks_frozen) directly in
rebuild_root_domains().


Thanks!

--
Qais Yousef

> 
> --->8---
> 
> 	diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> 	index a29c0b13706b..363e4459559f 100644
> 	--- a/kernel/cgroup/cpuset.c
> 	+++ b/kernel/cgroup/cpuset.c
> 	@@ -1079,6 +1079,8 @@ static void update_tasks_root_domain(struct cpuset *cs)
> 		css_task_iter_end(&it);
> 	 }
> 
> 	+static bool need_rebuild_rd = true;
> 	+
> 	 static void rebuild_root_domains(void)
> 	 {
> 		struct cpuset *cs = NULL;
> 	@@ -1088,6 +1090,9 @@ static void rebuild_root_domains(void)
> 		lockdep_assert_cpus_held();
> 		lockdep_assert_held(&sched_domains_mutex);
> 
> 	+       if (!need_rebuild_rd)
> 	+               return;
> 	+
> 		rcu_read_lock();
> 
> 		/*
> 	@@ -3627,7 +3632,9 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
> 		/* rebuild sched domains if cpus_allowed has changed */
> 		if (cpus_updated || force_rebuild) {
> 			force_rebuild = false;
> 	+               need_rebuild_rd = cpus_updated || (force_rebuild && !cpuhp_tasks_frozen);
> 			rebuild_sched_domains();
> 	+               need_rebuild_rd = true;
> 		}
> 
> 		free_cpumasks(NULL, ptmp);
> 
> 
> --->8---
> 
> Thanks!
> 
> --
> Qais Yousef
