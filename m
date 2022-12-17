Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3407564FC90
	for <lists+cgroups@lfdr.de>; Sat, 17 Dec 2022 23:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLQWKQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 17 Dec 2022 17:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLQWKP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 17 Dec 2022 17:10:15 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46037F5B4
        for <cgroups@vger.kernel.org>; Sat, 17 Dec 2022 14:10:14 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f18so5565953wrj.5
        for <cgroups@vger.kernel.org>; Sat, 17 Dec 2022 14:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgznWvPnejDwQ5G194p3C76c3g3BZCk+ljWB2J8CwsQ=;
        b=z60Sqh8HjXVzJehaGoNvHfThICmNQU5lyWECyXUwoLZzKHyW9IHSXNmSWfyibVk0qW
         sLCWrbAdZFv6iyQBOPoWofv3FHef9K4l2JVI3ilXVkmp5ccAWbk07qMJTtcBt33VvGt6
         w61fp0MZNGXsFgXU9m9Uw+w0IsRqbnGCDFzMh5PEiav/r5b/Y5eJxOBH2qVNIOIP9RXv
         /WOsw+fuuy0EViw1TBP9jTZXo8bFfl2dWhIoXkQlCE2V9ULtRLS1vqMxUpV+/WuBNhVY
         vkwYXE8cUzsNbKOqkn+wgFEixC0PPzcsIl2XmdOoES8b7dJ3OUn14AomYEJA4XwRi2bC
         zNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgznWvPnejDwQ5G194p3C76c3g3BZCk+ljWB2J8CwsQ=;
        b=mdHaMAdViRVEkzI+PhBRQFwqeM/9ME0K1TOEdvCE9X1tCMsrOnuXTxuG8gBupHqK15
         D0YzDaRWZ4UFAdseRaE5rxN6rLbYm2Bwus776hPeQTmWo0ClvvnQmVOdn7zDFoz1fpY3
         PqmouNw69TGjFDxtn866q4FoVm+o3pDKTb4yvl9w0STPiK6sf8wodtCdDnAwoOUig6TQ
         MXVJJ6t1Gzy8lh5dMF+P2gygofBJAMbAg9e6GcwvGsVn/zYbZvMqc6rtFjgzNMdnSMXD
         HIfBnStsRoZjZk1W7LTRYNyev7QtAuUjFURsC04ff6ItNA0UDv3mtu/x9hLPyroQhnfB
         rolg==
X-Gm-Message-State: ANoB5pkX/BwyeQGlHUCnmGDcYpgvaU01FDBHg6WgJ9xPd8CRDEpCRhRk
        iO0OI2yAkTvyR+lKARjKRJwi8A==
X-Google-Smtp-Source: AA0mqf5IpVljHD7IKf8/Ml2HfZdjjj82E7iP/3mUppjltS90NSenP+2rdzC5Eri16RwGheEvUmS+Kg==
X-Received: by 2002:a5d:4a0b:0:b0:242:10aa:202f with SMTP id m11-20020a5d4a0b000000b0024210aa202fmr21415703wrq.57.1671315012800;
        Sat, 17 Dec 2022 14:10:12 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d5585000000b0024207478de3sm5728624wrv.93.2022.12.17.14.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 14:10:12 -0800 (PST)
Date:   Sat, 17 Dec 2022 22:10:11 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Waiman Long <longman@redhat.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        dietmar.eggemann@arm.com, cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20221217221011.pqunktdfgkaoufrd@airbuntu>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-4-juri.lelli@redhat.com>
 <20221216233501.gh6m75e7s66dmjgo@airbuntu>
 <af29b121-b1da-64f3-a739-1b233fa04002@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af29b121-b1da-64f3-a739-1b233fa04002@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/16/22 21:26, Waiman Long wrote:
> On 12/16/22 18:35, Qais Yousef wrote:
> > Hi
> > 
> > On 07/19/19 15:59, Juri Lelli wrote:
> > > When the topology of root domains is modified by CPUset or CPUhotplug
> > > operations information about the current deadline bandwidth held in the
> > > root domain is lost.
> > > 
> > > This patch addresses the issue by recalculating the lost deadline
> > > bandwidth information by circling through the deadline tasks held in
> > > CPUsets and adding their current load to the root domain they are
> > > associated with.
> > > 
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > > ---
> > We see that rebuild_root_domain() can take 10+ ms (I get a max of 20ms quite
> > consistently) on suspend/resume.
> > 
> > Do we actually need to rebuild_root_domain() if we're going through
> > a suspend/resume cycle?
> > 
> > ie: would something like the below make sense? We'd skip this logic if
> > cpuhp_tasks_frozen is set which indicates it's not a real hotplug operation but
> > we're suspending/resuming.
> > 
> > 
> > Cheers
> > 
> > --
> > Qais Yousef
> > 
> > 
> > --->8---
> > 
> > 
> >  From 4cfd50960ad872c5eb810ad3038eaf840bab5182 Mon Sep 17 00:00:00 2001
> > From: Qais Yousef <qyousef@layalina.io>
> > Date: Tue, 29 Nov 2022 19:01:52 +0000
> > Subject: [PATCH] sched: cpuset: Don't rebuild sched domains on suspend-resume
> > 
> > Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
> > enabled rebuilding sched domain on cpuset and hotplug operations to
> > correct deadline accounting.
> > 
> > Rebuilding sched domain is a slow operation and we see 10+ ms delays
> > on suspend-resume because of that.
> > 
> > Since nothing is expected to change on suspend-resume operation; skip
> > rebuilding the sched domains to regain some of the time lost.
> > 
> > Debugged-by: Rick Yiu <rickyiu@google.com>
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >   kernel/cgroup/cpuset.c  | 6 ++++++
> >   kernel/sched/deadline.c | 3 +++
> >   2 files changed, 9 insertions(+)
> > 
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index b474289c15b8..2ff68d625b7b 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -1067,6 +1067,9 @@ static void update_tasks_root_domain(struct cpuset *cs)
> >   	struct css_task_iter it;
> >   	struct task_struct *task;
> > +	if (cpuhp_tasks_frozen)
> > +		return;
> > +
> >   	css_task_iter_start(&cs->css, 0, &it);
> >   	while ((task = css_task_iter_next(&it)))
> > @@ -1084,6 +1087,9 @@ static void rebuild_root_domains(void)
> >   	lockdep_assert_cpus_held();
> >   	lockdep_assert_held(&sched_domains_mutex);
> > +	if (cpuhp_tasks_frozen)
> > +		return;
> > +
> >   	rcu_read_lock();
> >   	/*
> 
> rebuild_root_domains() is the only caller of update_tasks_root_domain(). So
> the first hunk is redundant as update_tasks_root_domain() won't be called
> when cpuhp_tasks_frozen is set.

True. I went overzealous and protected all the functions.


Thanks!

--
Qais Yousef
