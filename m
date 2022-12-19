Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52B2650865
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 09:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiLSIHh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Dec 2022 03:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiLSIHf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Dec 2022 03:07:35 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6100362D2
        for <cgroups@vger.kernel.org>; Mon, 19 Dec 2022 00:07:34 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id k3so3375723qki.13
        for <cgroups@vger.kernel.org>; Mon, 19 Dec 2022 00:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SEgPCMOuM3toHAMRnPEv0nKP/n56PHLERtNl5qSP27Y=;
        b=GeCE1XpHOPsjmhot1alfGm10UwZR8WweYcK7Ys0ml6q0SKl29iSB4V/YGoLSd4bF1D
         k/gNkETnjVkPJ3Mu1VpAF8eFG5GiSNeo69v3wu2KtdmT4uHcvtB1BF5MN9dPZFmdphob
         1mLvk0O3KpQe0zjxF6uDeaTIgsHmR8OuHDTH08g4AUFwm1wAsHiRLxiWMjfR8b1Dt2bt
         iyWWQAJD+eRSch1JqaY7QuT/BfK6poPY9PQY9D0PW4C07QFqWjcRmkGZNLBGT1Q6HBOs
         oyx07AoRsJLtXSd2iqJrF0eHZPK97da/C0T3ywoEpIBiJqNzLY4mwLdMjx05xon0pZLw
         nANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEgPCMOuM3toHAMRnPEv0nKP/n56PHLERtNl5qSP27Y=;
        b=vivdl0Lpqor1RmjxOe+g62ahPYVwFkK+lhHqtwxhAX/m83rg3LZSrsaM1PI+VmHnPR
         BuetsI77PJzlyKZFp6mwgEayj1u22kbccoftaPMlkNr3QICzuwKLVo5+inM6KceEWFsM
         XcL7iKCEYuxaYjxQVw8DtCxHnsb7XPHK1PHS74h+MBFNE/R4QBD3YrvCRdqymwrt10H0
         HhcbrndSX3qu3/hTGn7cHlsFUmzSguY30V8P2/aN73hrmn0e7NtzGDRhA4QWLW4t5Uks
         x7PhCCvNZSw0PXaS/tPVzydBNnl1FY5kMC9jjNEqC3ONQLF7xQA81TvuNboH7GvR3RlB
         KTNw==
X-Gm-Message-State: ANoB5pm7xx1NM9fkWE6qK285YCGvibgBS+GPWG9UB9fLS2H+TCDMyszo
        ZHfXfOH8MRJPFfjPtXJtNnD4bjkxQiXGqyWA9M97jw==
X-Google-Smtp-Source: AA0mqf4hYcWqPwq7UNurh/zcWd4YRTG/jTjM6/0NYYnoB+BRyABPbRkLCDZqXLnbNzo8v38MVmQrUBGL+qURaCEBFHY=
X-Received: by 2002:a05:620a:8109:b0:6ff:a7f1:ff4e with SMTP id
 os9-20020a05620a810900b006ffa7f1ff4emr752607qkn.292.1671437253480; Mon, 19
 Dec 2022 00:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20190719140000.31694-1-juri.lelli@redhat.com> <20190719140000.31694-4-juri.lelli@redhat.com>
 <20221216233501.gh6m75e7s66dmjgo@airbuntu>
In-Reply-To: <20221216233501.gh6m75e7s66dmjgo@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 19 Dec 2022 09:07:21 +0100
Message-ID: <CAKfTPtA0M5XOP4UdkFeSNen98e842OfKTBDOt0r-y_TD4w54jw@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting information
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 17 Dec 2022 at 00:35, Qais Yousef <qyousef@layalina.io> wrote:
>
> Hi
>
> On 07/19/19 15:59, Juri Lelli wrote:
> > When the topology of root domains is modified by CPUset or CPUhotplug
> > operations information about the current deadline bandwidth held in the
> > root domain is lost.
> >
> > This patch addresses the issue by recalculating the lost deadline
> > bandwidth information by circling through the deadline tasks held in
> > CPUsets and adding their current load to the root domain they are
> > associated with.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
>
> We see that rebuild_root_domain() can take 10+ ms (I get a max of 20ms quite
> consistently) on suspend/resume.
>
> Do we actually need to rebuild_root_domain() if we're going through
> a suspend/resume cycle?

During suspend to ram, there are cpus hotplug operation but If you use
suspend to idle, you will skip cpus hotplug operation and its
associated rebuild.

>
> ie: would something like the below make sense? We'd skip this logic if
> cpuhp_tasks_frozen is set which indicates it's not a real hotplug operation but
> we're suspending/resuming.
>
>
> Cheers
>
> --
> Qais Yousef
>
>
> --->8---
>
>
> From 4cfd50960ad872c5eb810ad3038eaf840bab5182 Mon Sep 17 00:00:00 2001
> From: Qais Yousef <qyousef@layalina.io>
> Date: Tue, 29 Nov 2022 19:01:52 +0000
> Subject: [PATCH] sched: cpuset: Don't rebuild sched domains on suspend-resume
>
> Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
> enabled rebuilding sched domain on cpuset and hotplug operations to
> correct deadline accounting.
>
> Rebuilding sched domain is a slow operation and we see 10+ ms delays
> on suspend-resume because of that.
>
> Since nothing is expected to change on suspend-resume operation; skip
> rebuilding the sched domains to regain some of the time lost.
>
> Debugged-by: Rick Yiu <rickyiu@google.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/cgroup/cpuset.c  | 6 ++++++
>  kernel/sched/deadline.c | 3 +++
>  2 files changed, 9 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b474289c15b8..2ff68d625b7b 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1067,6 +1067,9 @@ static void update_tasks_root_domain(struct cpuset *cs)
>         struct css_task_iter it;
>         struct task_struct *task;
>
> +       if (cpuhp_tasks_frozen)
> +               return;
> +
>         css_task_iter_start(&cs->css, 0, &it);
>
>         while ((task = css_task_iter_next(&it)))
> @@ -1084,6 +1087,9 @@ static void rebuild_root_domains(void)
>         lockdep_assert_cpus_held();
>         lockdep_assert_held(&sched_domains_mutex);
>
> +       if (cpuhp_tasks_frozen)
> +               return;
> +
>         rcu_read_lock();
>
>         /*
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0d97d54276cc..42c1143a3956 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2575,6 +2575,9 @@ void dl_clear_root_domain(struct root_domain *rd)
>  {
>         unsigned long flags;
>
> +       if (cpuhp_tasks_frozen)
> +               return;
> +
>         raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
>         rd->dl_bw.total_bw = 0;
>         raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
> --
> 2.25.1
>
