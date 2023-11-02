Return-Path: <cgroups+bounces-160-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DA97DEFDF
	for <lists+cgroups@lfdr.de>; Thu,  2 Nov 2023 11:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629BB281961
	for <lists+cgroups@lfdr.de>; Thu,  2 Nov 2023 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4644910969;
	Thu,  2 Nov 2023 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKQus1Ru"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6CE13AC8
	for <cgroups@vger.kernel.org>; Thu,  2 Nov 2023 10:26:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF46B133
	for <cgroups@vger.kernel.org>; Thu,  2 Nov 2023 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698920808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cHxlEPIDbvrN3Wa2WIuH++2PNSEmRnJ4aw0+ivxO1Y=;
	b=TKQus1RueitYYbkRWV1QNkb990bm4rhPCV2v/x/qXAMm/3ttlxx0z4Q20WZrNDnAcz2UXT
	jUNl3ytb5bFAMbrnkPK4hGE1dIbJ0lK2cGwE8k2TiWjkdUGVLBxiFg5A0g5O2gMXYn33gl
	v0C5Oo+70bHYVBxZNvUEtoDT/mXgpo0=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-WbiLmhV7OSeWg2iJlqbidg-1; Thu, 02 Nov 2023 06:26:46 -0400
X-MC-Unique: WbiLmhV7OSeWg2iJlqbidg-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d32c33f7b7so113192a34.1
        for <cgroups@vger.kernel.org>; Thu, 02 Nov 2023 03:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698920806; x=1699525606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cHxlEPIDbvrN3Wa2WIuH++2PNSEmRnJ4aw0+ivxO1Y=;
        b=IX4lvI5YGuv5KNMaZekAKdRzwbCkeDBxBbfKNjh9doURmMAPPr13kMP9gQSrvCbQqA
         8D+DpI8Vdt3FtwCafV4xmZgw54zpYdaC4elh5L0kdQDDt48jdmg0OK4q0w5oMHxqVzSi
         Kgo1L3bwvJMrKpvJUlKAR92q50hDmrmbyloF9MshhskGpwWaZQetV9lfNegChTvPwHi5
         ArayfPnrGSMXMpX59sI2p6zvvA+/S3pbzOCNsa98ws8T8BClic/Zrnf61pIKL8d1+A8N
         QkpY4V3okHuHVcOTep6kNt2Cah6opML9t4nB4JEK1fUpR2rX+5kLjQ0fbkleoe0tKb3e
         mjoQ==
X-Gm-Message-State: AOJu0YxcEEcO8SYHprm02pYIXERn0ST9Xlv80ni3jJypS9ZVevwemyln
	ZbVktXqtHSpRtxNd0qA32P88R7Y8pd6V/MdPl53bDDASB3ZYyYRU7GDS58a9/SdzVbG6OzQqH2Q
	QTg1SVA0MWS3mOHqkfA==
X-Received: by 2002:a05:6830:2703:b0:6bd:a47:7bb6 with SMTP id j3-20020a056830270300b006bd0a477bb6mr18573849otu.14.1698920806124;
        Thu, 02 Nov 2023 03:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYGVhNLb1tTHfRerVfK7RRNSLAZHWweQKR7mRKblGTqXiT4x6O9uTLdQsSnxv7n/dD76I9fA==
X-Received: by 2002:a05:6830:2703:b0:6bd:a47:7bb6 with SMTP id j3-20020a056830270300b006bd0a477bb6mr18573840otu.14.1698920805849;
        Thu, 02 Nov 2023 03:26:45 -0700 (PDT)
Received: from localhost.localdomain ([151.29.57.115])
        by smtp.gmail.com with ESMTPSA id fg8-20020a05622a580800b0040399fb5ef3sm2172854qtb.0.2023.11.02.03.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:26:45 -0700 (PDT)
Date: Thu, 2 Nov 2023 11:26:39 +0100
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
Message-ID: <ZUN5XyOs3pWcJBo2@localhost.localdomain>
References: <20231024141834.4073262-1-longman@redhat.com>
 <rzzosab2z64ae5kemem6evu5qsggef2mcjz3yw2ieysoxzsvvp@26mlfo2qidml>
 <8e1b5497-d4ca-50a0-7cb1-ffa098e0a1c2@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e1b5497-d4ca-50a0-7cb1-ffa098e0a1c2@redhat.com>

Hi Waiman,

On 01/11/23 13:59, Waiman Long wrote:
> On 11/1/23 12:34, Michal Koutný wrote:
> > On Tue, Oct 24, 2023 at 10:18:34AM -0400, Waiman Long <longman@redhat.com> wrote:
> > > The nr_deadline_tasks field in cpuset structure was introduced by
> > > commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
> > > in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
> > > cpuset_mutex, nr_deadline_tasks can be updated under two different
> > > locks - cpuset_mutex in most cases or css_set_lock in cgroup_exit(). As
> > > a result, data races can happen leading to incorrect nr_deadline_tasks
> > > value.
> > The effect is that dl_update_tasks_root_domain() processes tasks
> > unnecessarily or that it incorrectly skips dl_add_task_root_domain()?
> The effect is that dl_update_tasks_root_domain() may return incorrectly or
> it is doing unnecessary work. Will update the commit log to reflect that.
> > 
> > > Since it is not practical to somehow take cpuset_mutex in cgroup_exit(),
> > > the easy way out to avoid this possible race condition is by making
> > > nr_deadline_tasks an atomic_t value.
> > If css_set_lock is useless for this fields and it's going to be atomic,
> > could you please add (presumably) a cleanup that moves dec_dl_tasks_cs()
> > from under css_set_lock in cgroup_exit() to a (new but specific)
> > cpuset_cgrp_subsys.exit() handler?
> 
> But css_set_lock is needed for updating other css data. It is true that we
> can move dec_dl_tasks_cs() outside of the lock. I can do that in the next
> version.

Not sure if you had a chance to check my last question/comment on your
previous posting?

https://lore.kernel.org/lkml/ZSjfBWgZf15TchA5@localhost.localdomain/

Thanks,
Juri


