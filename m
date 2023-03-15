Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC16BBAAC
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 18:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjCORQB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 13:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjCORP6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 13:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21AA8C0E0
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678900507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6VcWUrmZWQSzNyQ8ftR0w788OL4o4wXFbfra/mB0OVc=;
        b=KmzaNp7wCkkIbvp5KLG+beU+9+GdZdUIZCMqg2OdTTGqybicAPgkZcNP3nAZ/KvvZA1eVv
        A5+JSrrSU1/fgY/VSCq7lRSN0ud2Qj0XDYT/aS6bShlGj72h66p8wfpDLU2a0Mes+yqor4
        vIszlemYwzy8V2jrL/oQgYvq8sG/AhY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-fo65g-dQNzGCF5ToWr10EA-1; Wed, 15 Mar 2023 13:15:05 -0400
X-MC-Unique: fo65g-dQNzGCF5ToWr10EA-1
Received: by mail-wm1-f72.google.com with SMTP id j6-20020a05600c1c0600b003eaf882cb85so1004540wms.9
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 10:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678900502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VcWUrmZWQSzNyQ8ftR0w788OL4o4wXFbfra/mB0OVc=;
        b=2/ivEhEL5vg838JQOPBtE40q5wxlDtxP2zT06dkRYgnmeqqphrVzse/Sqp9BgvXIX8
         QKhckYcwbVm6S9lvVbyaTwsLG1vxuc7KzosgU4E8A6ewolAUFy2CZUoBUgZP6Ol7rhac
         Y6sczKk7Fej6iVqgpK1LVFsq3YzO+awF0W4Xk4wtb+LRVzgpsK4X40a9Y+InH6ICuBGG
         6PQuNLVBJtUUbV5EPz/oUqwWWayk3YcLSIBL+qhI5nNtE6kjiv0cgjODPEru7vvgsIYz
         mPd1wCybNBO7tKml0CwDwOo6uIF8X+zFsd5tEvepmIINxhgisLedqFEHEFeaEo4MKcdb
         PnkA==
X-Gm-Message-State: AO0yUKV+e7RZC8/ND+jlcxzRWW3CrDTSnMelnmTQHxMQYjG083SIwRdo
        69S7J2t3a/PCpphwhuopOg7qNC4KJS0HdT2kvYcTPNB57/eLqSHOKztnqJ4L83sDIw0O+GJOQL9
        Pis7m9boDDyhFpaA6Hw==
X-Received: by 2002:adf:f243:0:b0:2ce:a8f1:3cf9 with SMTP id b3-20020adff243000000b002cea8f13cf9mr2537432wrp.46.1678900502222;
        Wed, 15 Mar 2023 10:15:02 -0700 (PDT)
X-Google-Smtp-Source: AK7set+1DhzvZKgVT4IyPD0MWKLbtYVFY+u0UDD3VBuf3Qz4g7N/ZGSL2mfoZ/tYPBNd+zRKfMeK9w==
X-Received: by 2002:adf:f243:0:b0:2ce:a8f1:3cf9 with SMTP id b3-20020adff243000000b002cea8f13cf9mr2537413wrp.46.1678900501899;
        Wed, 15 Mar 2023 10:15:01 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:4a21:6f01:ac73:9611:643a:5397])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d568c000000b002cfe3f842c8sm5122512wrv.56.2023.03.15.10.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:15:01 -0700 (PDT)
Date:   Wed, 15 Mar 2023 17:14:59 +0000
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 2/3] sched/cpuset: Keep track of SCHED_DEADLINE tasks
 in cpusets
Message-ID: <ZBH9E7lCEXcFDBG4@localhost.localdomain>
References: <20230315121812.206079-1-juri.lelli@redhat.com>
 <20230315121812.206079-3-juri.lelli@redhat.com>
 <7a3b31bf-4f6a-6525-9c6a-2bae44d7b0af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a3b31bf-4f6a-6525-9c6a-2bae44d7b0af@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 15/03/23 11:46, Waiman Long wrote:
> 
> On 3/15/23 08:18, Juri Lelli wrote:
> > Qais reported that iterating over all tasks when rebuilding root domains
> > for finding out which ones are DEADLINE and need their bandwidth
> > correctly restored on such root domains can be a costly operation (10+
> > ms delays on suspend-resume).
> > 
> > To fix the problem keep track of the number of DEADLINE tasks belonging
> > to each cpuset and then use this information (followup patch) to only
> > perform the above iteration if DEADLINE tasks are actually present in
> > the cpuset for which a corresponding root domain is being rebuilt.
> > 
> > Reported-by: Qais Yousef <qyousef@layalina.io>
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >   include/linux/cpuset.h |  4 ++++
> >   kernel/cgroup/cgroup.c |  4 ++++
> >   kernel/cgroup/cpuset.c | 25 +++++++++++++++++++++++++
> >   kernel/sched/core.c    | 10 ++++++++++
> >   4 files changed, 43 insertions(+)
> > 
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index 355f796c5f07..0348dba5680e 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -71,6 +71,8 @@ extern void cpuset_init_smp(void);
> >   extern void cpuset_force_rebuild(void);
> >   extern void cpuset_update_active_cpus(void);
> >   extern void cpuset_wait_for_hotplug(void);
> > +extern void inc_dl_tasks_cs(struct task_struct *task);
> > +extern void dec_dl_tasks_cs(struct task_struct *task);
> >   extern void cpuset_lock(void);
> >   extern void cpuset_unlock(void);
> >   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
> > @@ -196,6 +198,8 @@ static inline void cpuset_update_active_cpus(void)
> >   static inline void cpuset_wait_for_hotplug(void) { }
> > +static inline void inc_dl_tasks_cs(struct task_struct *task) { }
> > +static inline void dec_dl_tasks_cs(struct task_struct *task) { }
> >   static inline void cpuset_lock(void) { }
> >   static inline void cpuset_unlock(void) { }
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index c099cf3fa02d..357925e1e4af 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -57,6 +57,7 @@
> >   #include <linux/file.h>
> >   #include <linux/fs_parser.h>
> >   #include <linux/sched/cputime.h>
> > +#include <linux/sched/deadline.h>
> >   #include <linux/psi.h>
> >   #include <net/sock.h>
> > @@ -6673,6 +6674,9 @@ void cgroup_exit(struct task_struct *tsk)
> >   	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
> >   	cset->nr_tasks--;
> > +	if (dl_task(tsk))
> > +		dec_dl_tasks_cs(tsk);
> > +
> >   	WARN_ON_ONCE(cgroup_task_frozen(tsk));
> >   	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
> >   		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 8d82d66d432b..57bc60112618 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -193,6 +193,12 @@ struct cpuset {
> >   	int use_parent_ecpus;
> >   	int child_ecpus_count;
> > +	/*
> > +	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
> > +	 * know when to rebuild associated root domain bandwidth information.
> > +	 */
> > +	int nr_deadline_tasks;
> > +
> >   	/* Invalid partition error code, not lock protected */
> >   	enum prs_errcode prs_err;
> > @@ -245,6 +251,20 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
> >   	return css_cs(cs->css.parent);
> >   }
> > +void inc_dl_tasks_cs(struct task_struct *p)
> > +{
> > +	struct cpuset *cs = task_cs(p);
> > +
> > +	cs->nr_deadline_tasks++;
> > +}
> > +
> > +void dec_dl_tasks_cs(struct task_struct *p)
> > +{
> > +	struct cpuset *cs = task_cs(p);
> > +
> > +	cs->nr_deadline_tasks--;
> > +}
> > +
> >   /* bits in struct cpuset flags field */
> >   typedef enum {
> >   	CS_ONLINE,
> > @@ -2472,6 +2492,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
> >   		ret = security_task_setscheduler(task);
> >   		if (ret)
> >   			goto out_unlock;
> > +
> > +		if (dl_task(task)) {
> > +			cs->nr_deadline_tasks++;
> > +			cpuset_attach_old_cs->nr_deadline_tasks--;
> > +		}
> >   	}
> 
> Any one of the tasks in the cpuset can cause the test to fail and abort the
> attachment. I would suggest that you keep a deadline task transfer count in
> the loop and then update cs and cpouset_attach_old_cs only after all the
> tasks have been iterated successfully.

Right, Dietmar I think commented pointing out something along these
lines. Think though we already have this problem with current
task_can_attach -> dl_cpu_busy which reserves bandwidth for each tasks
in the destination cs. Will need to look into that. Do you know which
sort of operation would move multiple tasks at once?

