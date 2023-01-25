Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B667B6FD
	for <lists+cgroups@lfdr.de>; Wed, 25 Jan 2023 17:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjAYQfv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Jan 2023 11:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjAYQfv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Jan 2023 11:35:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F512BED9
        for <cgroups@vger.kernel.org>; Wed, 25 Jan 2023 08:35:49 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q10so693364wrm.4
        for <cgroups@vger.kernel.org>; Wed, 25 Jan 2023 08:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASFlQvqBFf2+5cfZFM0tnDhN0cmGUnXdcMgd/XrWuzI=;
        b=bFW8Q0SAsCFre+6x3yP+2SyUjrYalHBu1AKf3hNSB3DS1ve3TjqfAiABaHJ5k7x2yg
         Gok2XiNmpaqk4Q9Y4N/bQFHHH/FwypWdbgr1tdGmBsJT6g10gQrO17U9epFhwJ8QHo5O
         VFAE54N8hQmLOeUt2/8ZCAEwHDyGS3SrOoj3rxkt1zQoBmfIZ7wqtBFSRKAyF/tLO9Fv
         pWfsizlSv7z/p7DRtpl/9zp+5P2OLKTeTLNPXQdDSb7x7e6wl/dusiCZlqtUpju+8abF
         3j57gQHnefwvp6xfyjI1y3cAn0Oar1juPv7Fnqzb6fQbvcXsERA1w8EZhEkcOuojnGTZ
         O4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASFlQvqBFf2+5cfZFM0tnDhN0cmGUnXdcMgd/XrWuzI=;
        b=pte2rQ3yo/Q8vJcH9F4d3FcqqVoYen+9WtlHfXRNE+TJnC087GrUbkeVutBsuYhEPw
         Nx6ki+OxnDET7w749yRrzlH14+qMA+5SZ/llgC3WlctY3zNcPertA/1Cj3J4sltqibJg
         zzDUMnfWttgSFFFDuoxLi05I5VGEugNZ2kFsCXP9l9zpBEAL+A2FNaKxHIzYdNKyq22R
         fABVY83yznJ2rMmY0iQ3VQPmWwZuUSHsOM5YL56EEje2fiJ/xJRA63PWx8umz6C5h1mj
         R822PEc0JYVPUI+xrgoICt78KG8Skparmm2IINmVQwlK0H4H/b/DkyEz/eFDEhVv8193
         N0nw==
X-Gm-Message-State: AO0yUKUXeCIU9oDT0pcVBZTPQTF4dZgpZJrvjB0e6oCwoKUegVVlf/4Q
        ThKfdddejqPsvMnIOA+RmSV3eDs/Ydim7Qpj
X-Google-Smtp-Source: AK7set877JoLU/rLX1cYG/9G0z1LOBdfsORkeGVXzsa+7RkiPtt94c3q8kdsrRc/y95JrLfIqt3qvQ==
X-Received: by 2002:a5d:694f:0:b0:2bf:b743:f035 with SMTP id r15-20020a5d694f000000b002bfb743f035mr3371024wrw.28.1674664548237;
        Wed, 25 Jan 2023 08:35:48 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id t9-20020adff049000000b002bddaea7a0bsm4846651wro.57.2023.01.25.08.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:35:47 -0800 (PST)
Date:   Wed, 25 Jan 2023 16:35:46 +0000
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
Message-ID: <20230125163546.pspvigh4groiwjy7@airbuntu>
References: <20230120194822.962958-1-qyousef@layalina.io>
 <c4c2dec6-a72b-d675-fb42-be40e384ea2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4c2dec6-a72b-d675-fb42-be40e384ea2c@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 01/20/23 17:16, Waiman Long wrote:
> 
> On 1/20/23 14:48, Qais Yousef wrote:
> > Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
> > enabled rebuilding sched domain on cpuset and hotplug operations to
> > correct deadline accounting.
> > 
> > Rebuilding sched domain is a slow operation and we see 10+ ms delay on
> > suspend-resume because of that.
> > 
> > Since nothing is expected to change on suspend-resume operation; skip
> > rebuilding the sched domains to regain the time lost.
> > 
> > Debugged-by: Rick Yiu <rickyiu@google.com>
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> > 
> >      Changes in v2:
> >      	* Remove redundant check in update_tasks_root_domain() (Thanks Waiman)
> >      v1 link:
> >      	https://lore.kernel.org/lkml/20221216233501.gh6m75e7s66dmjgo@airbuntu/
> > 
> >   kernel/cgroup/cpuset.c  | 3 +++
> >   kernel/sched/deadline.c | 3 +++
> >   2 files changed, 6 insertions(+)
> > 
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index a29c0b13706b..9a45f083459c 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -1088,6 +1088,9 @@ static void rebuild_root_domains(void)
> >   	lockdep_assert_cpus_held();
> >   	lockdep_assert_held(&sched_domains_mutex);
> > +	if (cpuhp_tasks_frozen)
> > +		return;
> > +
> >   	rcu_read_lock();
> >   	/*
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 0d97d54276cc..42c1143a3956 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2575,6 +2575,9 @@ void dl_clear_root_domain(struct root_domain *rd)
> >   {
> >   	unsigned long flags;
> > +	if (cpuhp_tasks_frozen)
> > +		return;
> > +
> >   	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
> >   	rd->dl_bw.total_bw = 0;
> >   	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
> 
> cpuhp_tasks_frozen is set when thaw_secondary_cpus() or
> freeze_secondary_cpus() is called. I don't know the exact suspend/resume
> calling sequences, will cpuhp_tasks_frozen be cleared at the end of resume
> sequence? Maybe we should make sure that rebuild_root_domain() is called at
> least once at the end of resume operation.

Very good questions. It made me look at the logic again and I realize now that
the way force_build behaves is causing this issue.

I *think* we should just make the call rebuild_root_domains() only if
cpus_updated in cpuset_hotplug_workfn().

cpuset_cpu_active() seems to be the source of force_rebuild in my case; which
seems to be called only after the last cpu is back online (what you suggest).
In this case we can end up with cpus_updated = false, but force_rebuild = true.

Now you added a couple of new users to force_rebuild in 4b842da276a8a; I'm
trying to figure out what the conditions would be there. It seems we can have
corner cases for cpus_update might not trigger correctly?

Could the below be a good cure?

AFAICT we must rebuild the root domains if something has changed in cpuset.
Which should be captured by either having:

	* cpus_updated = true
	* force_rebuild && !cpuhp_tasks_frozen

/me goes to test the patch

--->8---

	diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
	index a29c0b13706b..363e4459559f 100644
	--- a/kernel/cgroup/cpuset.c
	+++ b/kernel/cgroup/cpuset.c
	@@ -1079,6 +1079,8 @@ static void update_tasks_root_domain(struct cpuset *cs)
		css_task_iter_end(&it);
	 }

	+static bool need_rebuild_rd = true;
	+
	 static void rebuild_root_domains(void)
	 {
		struct cpuset *cs = NULL;
	@@ -1088,6 +1090,9 @@ static void rebuild_root_domains(void)
		lockdep_assert_cpus_held();
		lockdep_assert_held(&sched_domains_mutex);

	+       if (!need_rebuild_rd)
	+               return;
	+
		rcu_read_lock();

		/*
	@@ -3627,7 +3632,9 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
		/* rebuild sched domains if cpus_allowed has changed */
		if (cpus_updated || force_rebuild) {
			force_rebuild = false;
	+               need_rebuild_rd = cpus_updated || (force_rebuild && !cpuhp_tasks_frozen);
			rebuild_sched_domains();
	+               need_rebuild_rd = true;
		}

		free_cpumasks(NULL, ptmp);


--->8---

Thanks!

--
Qais Yousef
