Return-Path: <cgroups+bounces-166-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 308027E04AE
	for <lists+cgroups@lfdr.de>; Fri,  3 Nov 2023 15:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5202B2135A
	for <lists+cgroups@lfdr.de>; Fri,  3 Nov 2023 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719219BD9;
	Fri,  3 Nov 2023 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlJfoEno"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D149168AB
	for <cgroups@vger.kernel.org>; Fri,  3 Nov 2023 14:29:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29DED4D
	for <cgroups@vger.kernel.org>; Fri,  3 Nov 2023 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699021758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFrz1T06ZV9wRLR/AaSeQ5njOC3A6YG14M3hWOUp/Z8=;
	b=QlJfoEnoUZVG1AX5L8M6CZJWF88gaJjqiKmjK+8L7HPZ7tYP491mYCv1lf91WichQqc8np
	eQSM/EoqWuM9W1w679G5QOFsTrlxt93QlGbWvISKSNazcCTkgq9jONC3uVp0gvZf9w7D1W
	wLCQug4ceTE0hmUDPv7EzpXvkOA/bdM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-GTJ4Z7spPHGmWFW1JvoliA-1; Fri, 03 Nov 2023 10:29:17 -0400
X-MC-Unique: GTJ4Z7spPHGmWFW1JvoliA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66fbd3bc8ebso23761456d6.1
        for <cgroups@vger.kernel.org>; Fri, 03 Nov 2023 07:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021757; x=1699626557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFrz1T06ZV9wRLR/AaSeQ5njOC3A6YG14M3hWOUp/Z8=;
        b=awA649j7x0jUe04K70yESX2e2GklPaFUaHt4qkbl3GmH+WxP/B9WNYFUM1BwuA6OgR
         6/LNkhmmV2G/X+n7flSkSWB3qp9LW7PJeO72Ac8cqyOcv7k7PvLVmJh+/bzjcUXcEc+p
         FgRnqWfic3VygEdLDo/SS96HX6KLoq+OxuLJP1WnN/XAd9PE+sU/GEmMWnlXMxaR2HEn
         jY7dGdMjtuiCBELzqThu9MmCChTRCwzr+Aaw2b8UaTk6viDbUpuTyCTdCaop780fQtsF
         ESRDIsL4ftgsBOJyWX/I3Le01v1b8pzKKjqaFTNwt3UD61jmvzFVvSU5zD98das5/kG7
         oIwg==
X-Gm-Message-State: AOJu0YxDpUSMsbXBpEPIJFj8oN1fXNwtvNOKWGSVRJ27gUbj5TBJ7n2J
	rVim/roMPv/Hg3xMJ06Mhmf387q1j5P74a8Q4+NX+P92WoyoQZ5M6hDlWzlI33Be1lLWkr2gWx5
	MbokQC1kBh7tdsz3BAw==
X-Received: by 2002:ad4:5c62:0:b0:66d:8184:dd8c with SMTP id i2-20020ad45c62000000b0066d8184dd8cmr26898762qvh.54.1699021757279;
        Fri, 03 Nov 2023 07:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnf6nWK8JYc1GZzpLOlS0paMCKupoCJR7jKRm8P63Ly0yon6nTC76VZNwvH/JsM2gH3J4Sxg==
X-Received: by 2002:ad4:5c62:0:b0:66d:8184:dd8c with SMTP id i2-20020ad45c62000000b0066d8184dd8cmr26898743qvh.54.1699021757003;
        Fri, 03 Nov 2023 07:29:17 -0700 (PDT)
Received: from localhost.localdomain ([151.29.128.41])
        by smtp.gmail.com with ESMTPSA id ne18-20020a056214425200b0066cf4fa7b47sm792703qvb.4.2023.11.03.07.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:29:16 -0700 (PDT)
Date: Fri, 3 Nov 2023 15:29:10 +0100
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
Message-ID: <ZUUDtm4+OO+DQHX5@localhost.localdomain>
References: <20231024141834.4073262-1-longman@redhat.com>
 <rzzosab2z64ae5kemem6evu5qsggef2mcjz3yw2ieysoxzsvvp@26mlfo2qidml>
 <8e1b5497-d4ca-50a0-7cb1-ffa098e0a1c2@redhat.com>
 <ZUN5XyOs3pWcJBo2@localhost.localdomain>
 <63726aac-2a9b-11f2-6c24-9f33ced68706@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63726aac-2a9b-11f2-6c24-9f33ced68706@redhat.com>

On 02/11/23 09:01, Waiman Long wrote:
> 
> On 11/2/23 06:26, Juri Lelli wrote:
> > Hi Waiman,
> > 
> > On 01/11/23 13:59, Waiman Long wrote:
> > > On 11/1/23 12:34, Michal Koutný wrote:
> > > > On Tue, Oct 24, 2023 at 10:18:34AM -0400, Waiman Long <longman@redhat.com> wrote:
> > > > > The nr_deadline_tasks field in cpuset structure was introduced by
> > > > > commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
> > > > > in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
> > > > > cpuset_mutex, nr_deadline_tasks can be updated under two different
> > > > > locks - cpuset_mutex in most cases or css_set_lock in cgroup_exit(). As
> > > > > a result, data races can happen leading to incorrect nr_deadline_tasks
> > > > > value.
> > > > The effect is that dl_update_tasks_root_domain() processes tasks
> > > > unnecessarily or that it incorrectly skips dl_add_task_root_domain()?
> > > The effect is that dl_update_tasks_root_domain() may return incorrectly or
> > > it is doing unnecessary work. Will update the commit log to reflect that.
> > > > > Since it is not practical to somehow take cpuset_mutex in cgroup_exit(),
> > > > > the easy way out to avoid this possible race condition is by making
> > > > > nr_deadline_tasks an atomic_t value.
> > > > If css_set_lock is useless for this fields and it's going to be atomic,
> > > > could you please add (presumably) a cleanup that moves dec_dl_tasks_cs()
> > > > from under css_set_lock in cgroup_exit() to a (new but specific)
> > > > cpuset_cgrp_subsys.exit() handler?
> > > But css_set_lock is needed for updating other css data. It is true that we
> > > can move dec_dl_tasks_cs() outside of the lock. I can do that in the next
> > > version.
> > Not sure if you had a chance to check my last question/comment on your
> > previous posting?
> > 
> > https://lore.kernel.org/lkml/ZSjfBWgZf15TchA5@localhost.localdomain/
> 
> Thanks for the reminder. I look at your comment again. Even though
> dl_rebuild_rd_accounting() operates on css(es) via css_task_iter_start() and
> css_task_iter_next(), the css_set_lock is released at the end of it. So it
> is still possible that a task can call cgroup_exit() after
> css_task_iter_next() and is being processed by dl_add_task_root_domain(). Is
> there a helper in the do_exit() path to nullify the dl_task() check. Or
> maybe we can also check for PF_EXITING in dl_add_task_root_domain() under
> the pi_lock and do the dl_task() check the under pi_lock to synchronize with
> dl_add_task_root_domain(). What do you think?
> 
> I still believe that it doesn't really matter if we call dec_dl_tasks_cs()
> inside or outside the css_set_lock.

Hummm, what if we move dec_dl_tasks_cs outside css_set_lock guard in
cgroup_exit and we grab cpuset_mutex (for dl_tasks) before doing the
decrement in there?


