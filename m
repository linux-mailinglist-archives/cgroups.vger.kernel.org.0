Return-Path: <cgroups+bounces-162-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75627DF999
	for <lists+cgroups@lfdr.de>; Thu,  2 Nov 2023 19:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5323AB2124D
	for <lists+cgroups@lfdr.de>; Thu,  2 Nov 2023 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59B421110;
	Thu,  2 Nov 2023 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYxzHQP6"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C73C208A4
	for <cgroups@vger.kernel.org>; Thu,  2 Nov 2023 18:10:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAA51AB
	for <cgroups@vger.kernel.org>; Thu,  2 Nov 2023 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698948539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8atlEFdKhiLltidUbIHo3yQFF4oBkvMX6luoN2eXWEM=;
	b=CYxzHQP6Wmouk14O3CgkqVJYG33607bL1dNrK6dQlrNWpvF2kQw7E2iLKMH8Wo1Sj+ClQr
	SV85hsTC8nIcMVA7JRQtiZoxVd/n+MlppgpAjNe0wcgyHtLC+6k3T4FcBKEdATstqc01Uc
	TwxUuqcYgTfxlgzH0WPWAem2BbYCiVU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-DXrnkakaPfqgQGb3kAYGdQ-1; Thu,
 02 Nov 2023 14:08:56 -0400
X-MC-Unique: DXrnkakaPfqgQGb3kAYGdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F14C11C29EA4;
	Thu,  2 Nov 2023 18:08:55 +0000 (UTC)
Received: from [10.22.17.8] (unknown [10.22.17.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BBC05502D;
	Thu,  2 Nov 2023 18:08:54 +0000 (UTC)
Message-ID: <a705454c-b64d-c58b-7ed1-6a3554582a6b@redhat.com>
Date: Thu, 2 Nov 2023 14:08:54 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] cgroup/cpuset: Change nr_deadline_tasks to an atomic_t
 value
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 Hao Luo <haoluo@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Xia Fukun <xiafukun@huawei.com>
References: <20231024141834.4073262-1-longman@redhat.com>
 <rzzosab2z64ae5kemem6evu5qsggef2mcjz3yw2ieysoxzsvvp@26mlfo2qidml>
 <8e1b5497-d4ca-50a0-7cb1-ffa098e0a1c2@redhat.com>
 <ZUN5XyOs3pWcJBo2@localhost.localdomain>
 <63726aac-2a9b-11f2-6c24-9f33ced68706@redhat.com>
In-Reply-To: <63726aac-2a9b-11f2-6c24-9f33ced68706@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 11/2/23 09:01, Waiman Long wrote:
>
> On 11/2/23 06:26, Juri Lelli wrote:
>> Hi Waiman,
>>
>> On 01/11/23 13:59, Waiman Long wrote:
>>> On 11/1/23 12:34, Michal Koutný wrote:
>>>> On Tue, Oct 24, 2023 at 10:18:34AM -0400, Waiman Long 
>>>> <longman@redhat.com> wrote:
>>>>> The nr_deadline_tasks field in cpuset structure was introduced by
>>>>> commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
>>>>> in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
>>>>> cpuset_mutex, nr_deadline_tasks can be updated under two different
>>>>> locks - cpuset_mutex in most cases or css_set_lock in 
>>>>> cgroup_exit(). As
>>>>> a result, data races can happen leading to incorrect 
>>>>> nr_deadline_tasks
>>>>> value.
>>>> The effect is that dl_update_tasks_root_domain() processes tasks
>>>> unnecessarily or that it incorrectly skips dl_add_task_root_domain()?
>>> The effect is that dl_update_tasks_root_domain() may return 
>>> incorrectly or
>>> it is doing unnecessary work. Will update the commit log to reflect 
>>> that.
>>>>> Since it is not practical to somehow take cpuset_mutex in 
>>>>> cgroup_exit(),
>>>>> the easy way out to avoid this possible race condition is by making
>>>>> nr_deadline_tasks an atomic_t value.
>>>> If css_set_lock is useless for this fields and it's going to be 
>>>> atomic,
>>>> could you please add (presumably) a cleanup that moves 
>>>> dec_dl_tasks_cs()
>>>> from under css_set_lock in cgroup_exit() to a (new but specific)
>>>> cpuset_cgrp_subsys.exit() handler?
>>> But css_set_lock is needed for updating other css data. It is true 
>>> that we
>>> can move dec_dl_tasks_cs() outside of the lock. I can do that in the 
>>> next
>>> version.
>> Not sure if you had a chance to check my last question/comment on your
>> previous posting?
>>
>> https://lore.kernel.org/lkml/ZSjfBWgZf15TchA5@localhost.localdomain/
>
> Thanks for the reminder. I look at your comment again. Even though 
> dl_rebuild_rd_accounting() operates on css(es) via 
> css_task_iter_start() and css_task_iter_next(), the css_set_lock is 
> released at the end of it. So it is still possible that a task can 
> call cgroup_exit() after css_task_iter_next() and is being processed 
> by dl_add_task_root_domain(). Is there a helper in the do_exit() path 
> to nullify the dl_task() check. Or maybe we can also check for 
> PF_EXITING in dl_add_task_root_domain() under the pi_lock and do the 
> dl_task() check the under pi_lock to synchronize with 
> dl_add_task_root_domain(). What do you think?
>
> I still believe that it doesn't really matter if we call 
> dec_dl_tasks_cs() inside or outside the css_set_lock.

Just curious. Does the deadline code remove the deadline quota of an 
exiting task?

Regards,
Longman


