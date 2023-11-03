Return-Path: <cgroups+bounces-167-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62AF7E056C
	for <lists+cgroups@lfdr.de>; Fri,  3 Nov 2023 16:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC7D28203D
	for <lists+cgroups@lfdr.de>; Fri,  3 Nov 2023 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961C1B267;
	Fri,  3 Nov 2023 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCam4LTq"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E91B278
	for <cgroups@vger.kernel.org>; Fri,  3 Nov 2023 15:18:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB0D48
	for <cgroups@vger.kernel.org>; Fri,  3 Nov 2023 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699024724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZgd71r6OuelYL2EyyGKF+wHNj4NwxkmydfoEVL9Wis=;
	b=ZCam4LTqwSS0Pcg5vb/gtdmdUCbQwOBewWizL1HQkrE/fxLeTPId58zfsX8o/P5ZQEMlM5
	+8Bd4YNpfNyUB6ZHugSRajjkkFmOcD5gNJMOcUfX90QZ1SWb1SRBhzhkgilDvnxc7ktBBt
	ecGhyFcDIl0P4ObeZv2C5DAsq7LWJgw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-hLZcLZEUOsWwLMI1bZBoWw-1; Fri, 03 Nov 2023 11:18:42 -0400
X-MC-Unique: hLZcLZEUOsWwLMI1bZBoWw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6712bdfe06dso23347016d6.0
        for <cgroups@vger.kernel.org>; Fri, 03 Nov 2023 08:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699024722; x=1699629522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZgd71r6OuelYL2EyyGKF+wHNj4NwxkmydfoEVL9Wis=;
        b=G6V4GiHhg7Mye/KClDGGxe5qLA9bjGeO2EYsBBAdv8rjW1ZfP3rKNGTyxB+1netvJH
         44bs/lpyyTVIX7hZaqRvCSbLtlw4epoUdkQ7Jw+gZNtVzjkbi2X4jh2vSw+JH3NdHvaY
         7NdCZlTi2m4h6f8LccUlitNb+v4AH/1FS1DO8+K6RVHkce63X9OwqWIYg+8YUwRmtw8P
         mJUYu6wWLJCYRYcM9LPqn3JMJv19FNOEb/dVSX0kjwMUMFzu1eUqlm8nRCAnt+jG2QaP
         9urgZEm7gcxIkc1TpEdIsLecQck0CpnuGy3feLGM3h5Zf+0XpP0dcwP63Ny5N6uNX3Q9
         N1KA==
X-Gm-Message-State: AOJu0Yw2b6jSOKqxhHCAZn04Es33aDFZ8+uXBnecbAiSKDteGptSs9St
	84bOJ8o25+tDEvU2Y4LjVgXJc3k3pu9ixWtMxvAS07Ql6SzmllTTAPO7pj/74L4RKiFcSZzOodX
	UgSRtjdXrBWtqKVAvHQ==
X-Received: by 2002:ad4:5946:0:b0:672:2989:589c with SMTP id eo6-20020ad45946000000b006722989589cmr18085734qvb.27.1699024721729;
        Fri, 03 Nov 2023 08:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyrH5+42CRKsdqjMyO0nFa8phCSPN0EON9cI95efewIb7vPaE/dcIrIteMtHV/A0MkvylbXg==
X-Received: by 2002:ad4:5946:0:b0:672:2989:589c with SMTP id eo6-20020ad45946000000b006722989589cmr18085692qvb.27.1699024721365;
        Fri, 03 Nov 2023 08:18:41 -0700 (PDT)
Received: from localhost.localdomain ([151.29.128.41])
        by smtp.gmail.com with ESMTPSA id b3-20020a0ce883000000b0066cfd398ab5sm812199qvo.146.2023.11.03.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 08:18:41 -0700 (PDT)
Date: Fri, 3 Nov 2023 16:18:35 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
	Hao Luo <haoluo@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Xia Fukun <xiafukun@huawei.com>
Subject: Re: [PATCH v2] cgroup/cpuset: Change nr_deadline_tasks to an
 atomic_t value
Message-ID: <ZUUPS6aRrkDjOywb@localhost.localdomain>
References: <20231024141834.4073262-1-longman@redhat.com>
 <rzzosab2z64ae5kemem6evu5qsggef2mcjz3yw2ieysoxzsvvp@26mlfo2qidml>
 <8e1b5497-d4ca-50a0-7cb1-ffa098e0a1c2@redhat.com>
 <ZUN5XyOs3pWcJBo2@localhost.localdomain>
 <63726aac-2a9b-11f2-6c24-9f33ced68706@redhat.com>
 <a705454c-b64d-c58b-7ed1-6a3554582a6b@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a705454c-b64d-c58b-7ed1-6a3554582a6b@redhat.com>

On 02/11/23 14:08, Waiman Long wrote:
> On 11/2/23 09:01, Waiman Long wrote:
> > 
> > On 11/2/23 06:26, Juri Lelli wrote:
> > > Hi Waiman,
> > > 
> > > On 01/11/23 13:59, Waiman Long wrote:
> > > > On 11/1/23 12:34, Michal Koutný wrote:
> > > > > On Tue, Oct 24, 2023 at 10:18:34AM -0400, Waiman Long
> > > > > <longman@redhat.com> wrote:
> > > > > > The nr_deadline_tasks field in cpuset structure was introduced by
> > > > > > commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
> > > > > > in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
> > > > > > cpuset_mutex, nr_deadline_tasks can be updated under two different
> > > > > > locks - cpuset_mutex in most cases or css_set_lock in
> > > > > > cgroup_exit(). As
> > > > > > a result, data races can happen leading to incorrect
> > > > > > nr_deadline_tasks
> > > > > > value.
> > > > > The effect is that dl_update_tasks_root_domain() processes tasks
> > > > > unnecessarily or that it incorrectly skips dl_add_task_root_domain()?
> > > > The effect is that dl_update_tasks_root_domain() may return
> > > > incorrectly or
> > > > it is doing unnecessary work. Will update the commit log to
> > > > reflect that.
> > > > > > Since it is not practical to somehow take cpuset_mutex
> > > > > > in cgroup_exit(),
> > > > > > the easy way out to avoid this possible race condition is by making
> > > > > > nr_deadline_tasks an atomic_t value.
> > > > > If css_set_lock is useless for this fields and it's going to
> > > > > be atomic,
> > > > > could you please add (presumably) a cleanup that moves
> > > > > dec_dl_tasks_cs()
> > > > > from under css_set_lock in cgroup_exit() to a (new but specific)
> > > > > cpuset_cgrp_subsys.exit() handler?
> > > > But css_set_lock is needed for updating other css data. It is
> > > > true that we
> > > > can move dec_dl_tasks_cs() outside of the lock. I can do that in
> > > > the next
> > > > version.
> > > Not sure if you had a chance to check my last question/comment on your
> > > previous posting?
> > > 
> > > https://lore.kernel.org/lkml/ZSjfBWgZf15TchA5@localhost.localdomain/
> > 
> > Thanks for the reminder. I look at your comment again. Even though
> > dl_rebuild_rd_accounting() operates on css(es) via css_task_iter_start()
> > and css_task_iter_next(), the css_set_lock is released at the end of it.
> > So it is still possible that a task can call cgroup_exit() after
> > css_task_iter_next() and is being processed by
> > dl_add_task_root_domain(). Is there a helper in the do_exit() path to
> > nullify the dl_task() check. Or maybe we can also check for PF_EXITING
> > in dl_add_task_root_domain() under the pi_lock and do the dl_task()
> > check the under pi_lock to synchronize with dl_add_task_root_domain().
> > What do you think?
> > 
> > I still believe that it doesn't really matter if we call
> > dec_dl_tasks_cs() inside or outside the css_set_lock.
> 
> Just curious. Does the deadline code remove the deadline quota of an exiting
> task?

Ah, interesting observation. We do indeed remove a DL tasks bandwidth
from either within task_non_contending (if zerolag time has passed at
the time the task is dying) or a bit later when the inactive timer fires
(check related paths with TASK_DEAD in task_non_contending and
inactive_task_timer). So, maybe we could do the cs subtraction at this
point as well? Maybe it's even more correct I'm now thinking (or maybe it's
just Friday :).


