Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67329680E56
	for <lists+cgroups@lfdr.de>; Mon, 30 Jan 2023 14:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbjA3NAp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Jan 2023 08:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbjA3NAo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Jan 2023 08:00:44 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE1D8692
        for <cgroups@vger.kernel.org>; Mon, 30 Jan 2023 05:00:43 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m2so30999882ejb.8
        for <cgroups@vger.kernel.org>; Mon, 30 Jan 2023 05:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPi27oxB4DF456BzhJqV6TJpIF6QgAwWPIaoiwGORiA=;
        b=42fVBR9gT45Z7+QeYw7RXcYPaPHLdXd1EVx/6xfDdHi2QPOL1d4jGzIxEkrDKdqh8c
         D6eE4DC7H2ZHrixFV7BuysO5lIcaLcB3WrhCzUcM9SZ0gCs5a9QMbikE0jEMBMETXT5P
         rMFNAla6oqwPQJggUkX8CeTbdU2TUE8iQMm04aalE0s1TxucGm1enAH8FLdLRT71RNYm
         Y2790LlDWUbSr4OORzPtdMRrdtCX2xbgRyUhqMZG6wxwRVlW90YNy3yVshgaMS6qU7aE
         /QbVR+4nNhV5plpNAVmVA/qbfm6cfkP4yXsg3slx1ynwlaph0DLQS56SuKb3zAe71tXx
         qy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPi27oxB4DF456BzhJqV6TJpIF6QgAwWPIaoiwGORiA=;
        b=slk0i11QUUpnZ1OMN560HZEbHUN9OJ1EUIWMfz5cqrP4hY+iZ3vVkdbMimnAv9CuDU
         zRyan9d/fLDv4GysFgkEFZTTzBToU46VymM5jDBr3bjV2XINetjJeUcX0J2NXQe2+oR1
         NCL2pF5omXa4BJiFYIu13K3iCR5xMB3gIJmwlArlHZpP+2oME6+7kx/4whPk+jtfw8vu
         YRybeFkkoIPkNKxzVbVr4Irj9VZVy+T+PRcMCwWzZDVN37znCIonJPGuYq7YxDAALvyJ
         dBD2VzirFwnVcWiw1u2Wjp3ojzNXrwN7Ld7rlLgs2l9DXvFCF5fW/+dRH3nx2wT5U4iU
         1bgA==
X-Gm-Message-State: AO0yUKVNOltaeksr/qejRsRRLF7qO8PVVGecjLOboVuPrTZRLAnBPE+c
        aW9xjILIJHZSk4cvrQ1Y0P5I5Q==
X-Google-Smtp-Source: AK7set8Xfa66K7VRZaYWl5ez9KA/EvZzuz2RkEN1pPEdogJHLCk63Neah94a5EhT0rA7J8fayVqXTQ==
X-Received: by 2002:a17:906:d7b3:b0:884:9b56:e418 with SMTP id pk19-20020a170906d7b300b008849b56e418mr8242349ejb.57.1675083641759;
        Mon, 30 Jan 2023 05:00:41 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906380900b008786619684csm6766741ejc.125.2023.01.30.05.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 05:00:41 -0800 (PST)
Date:   Mon, 30 Jan 2023 13:00:38 +0000
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
Message-ID: <20230130130038.2qx3pkzut6ypqdub@airbuntu>
References: <20230120194822.962958-1-qyousef@layalina.io>
 <c4c2dec6-a72b-d675-fb42-be40e384ea2c@redhat.com>
 <20230125163546.pspvigh4groiwjy7@airbuntu>
 <45e0f8ea-d229-1ae7-5c12-7f0a64c6767a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45e0f8ea-d229-1ae7-5c12-7f0a64c6767a@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 01/29/23 21:49, Waiman Long wrote:
> On 1/25/23 11:35, Qais Yousef wrote:
> > On 01/20/23 17:16, Waiman Long wrote:
> > > On 1/20/23 14:48, Qais Yousef wrote:
> > > > Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
> > > > enabled rebuilding sched domain on cpuset and hotplug operations to
> > > > correct deadline accounting.
> > > > 
> > > > Rebuilding sched domain is a slow operation and we see 10+ ms delay on
> > > > suspend-resume because of that.
> > > > 
> > > > Since nothing is expected to change on suspend-resume operation; skip
> > > > rebuilding the sched domains to regain the time lost.
> > > > 
> > > > Debugged-by: Rick Yiu <rickyiu@google.com>
> > > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > > > ---
> > > > 
> > > >       Changes in v2:
> > > >       	* Remove redundant check in update_tasks_root_domain() (Thanks Waiman)
> > > >       v1 link:
> > > >       	https://lore.kernel.org/lkml/20221216233501.gh6m75e7s66dmjgo@airbuntu/
> > > > 
> > > >    kernel/cgroup/cpuset.c  | 3 +++
> > > >    kernel/sched/deadline.c | 3 +++
> > > >    2 files changed, 6 insertions(+)
> > > > 
> > > > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > > > index a29c0b13706b..9a45f083459c 100644
> > > > --- a/kernel/cgroup/cpuset.c
> > > > +++ b/kernel/cgroup/cpuset.c
> > > > @@ -1088,6 +1088,9 @@ static void rebuild_root_domains(void)
> > > >    	lockdep_assert_cpus_held();
> > > >    	lockdep_assert_held(&sched_domains_mutex);
> > > > +	if (cpuhp_tasks_frozen)
> > > > +		return;
> > > > +
> > > >    	rcu_read_lock();
> > > >    	/*
> > > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > > index 0d97d54276cc..42c1143a3956 100644
> > > > --- a/kernel/sched/deadline.c
> > > > +++ b/kernel/sched/deadline.c
> > > > @@ -2575,6 +2575,9 @@ void dl_clear_root_domain(struct root_domain *rd)
> > > >    {
> > > >    	unsigned long flags;
> > > > +	if (cpuhp_tasks_frozen)
> > > > +		return;
> > > > +
> > > >    	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
> > > >    	rd->dl_bw.total_bw = 0;
> > > >    	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
> > > cpuhp_tasks_frozen is set when thaw_secondary_cpus() or
> > > freeze_secondary_cpus() is called. I don't know the exact suspend/resume
> > > calling sequences, will cpuhp_tasks_frozen be cleared at the end of resume
> > > sequence? Maybe we should make sure that rebuild_root_domain() is called at
> > > least once at the end of resume operation.
> > Very good questions. It made me look at the logic again and I realize now that
> > the way force_build behaves is causing this issue.
> > 
> > I *think* we should just make the call rebuild_root_domains() only if
> > cpus_updated in cpuset_hotplug_workfn().
> > 
> > cpuset_cpu_active() seems to be the source of force_rebuild in my case; which
> > seems to be called only after the last cpu is back online (what you suggest).
> > In this case we can end up with cpus_updated = false, but force_rebuild = true.
> > 
> > Now you added a couple of new users to force_rebuild in 4b842da276a8a; I'm
> > trying to figure out what the conditions would be there. It seems we can have
> > corner cases for cpus_update might not trigger correctly?
> > 
> > Could the below be a good cure?
> > 
> > AFAICT we must rebuild the root domains if something has changed in cpuset.
> > Which should be captured by either having:
> > 
> > 	* cpus_updated = true
> > 	* force_rebuild && !cpuhp_tasks_frozen
> > 
> > /me goes to test the patch
> > 
> > --->8---
> > 
> > 	diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > 	index a29c0b13706b..363e4459559f 100644
> > 	--- a/kernel/cgroup/cpuset.c
> > 	+++ b/kernel/cgroup/cpuset.c
> > 	@@ -1079,6 +1079,8 @@ static void update_tasks_root_domain(struct cpuset *cs)
> > 		css_task_iter_end(&it);
> > 	 }
> > 
> > 	+static bool need_rebuild_rd = true;
> > 	+
> > 	 static void rebuild_root_domains(void)
> > 	 {
> > 		struct cpuset *cs = NULL;
> > 	@@ -1088,6 +1090,9 @@ static void rebuild_root_domains(void)
> > 		lockdep_assert_cpus_held();
> > 		lockdep_assert_held(&sched_domains_mutex);
> > 
> > 	+       if (!need_rebuild_rd)
> > 	+               return;
> > 	+
> > 		rcu_read_lock();
> > 
> > 		/*
> > 	@@ -3627,7 +3632,9 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
> > 		/* rebuild sched domains if cpus_allowed has changed */
> > 		if (cpus_updated || force_rebuild) {
> > 			force_rebuild = false;
> > 	+               need_rebuild_rd = cpus_updated || (force_rebuild && !cpuhp_tasks_frozen);
> > 			rebuild_sched_domains();
> > 	+               need_rebuild_rd = true;
> 
> You do the force_check check after it is set to false in the previous
> statement which is definitely not correct. So it will be false whenever
> cpus_updated is false.
> 
> If you just want to skip rebuild_sched_domains() call for hotplug, why don't

We just need to skip rebuild_root_domains(). I think rebuild_sched_domains()
should still happen.

The issue, AFAIU, is that we assume this hotplug operation results in changes
in cpuset and the DEADLINE accounting is now wrong and must be re-calculated.
But s2ram will cause hotplug operation without actually changing the cpuset
configuration - the re-calculation is not required. But it'd be good to get
a confirmation from Juri.

> just skip the call here if the condition is right? Like
> 
>         /* rebuild sched domains if cpus_allowed has changed */
>         if (cpus_updated || (force_rebuild && !cpuhp_tasks_frozen)) {
>                 force_rebuild = false;
>                 rebuild_sched_domains();
>         }
> 
> Still, we will need to confirm that cpuhp_tasks_frozen will be cleared
> outside of the suspend/resume cycle.

I think it's fine to use this variable from the cpuhp callback context only.
Which I think this cpuset workfn is considered an extension of.

But you're right, I can't use cpuhp_tasks_frozen directly in
rebuild_root_domains() as I did in v1 because it doesn't get cleared after
calling the last _cpu_up(). force_rebuild will only be set after the last cpu
is brought online though - so this should happen once at the end.

(will update the comment too)

It seems I still need more time to study the code. What appeared simple, looks
is actually not..


Cheers

--
Qais Yousef
