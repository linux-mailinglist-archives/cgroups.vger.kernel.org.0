Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA22864F702
	for <lists+cgroups@lfdr.de>; Sat, 17 Dec 2022 03:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLQC1N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 21:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLQC1M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 21:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7093D3A6
        for <cgroups@vger.kernel.org>; Fri, 16 Dec 2022 18:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671243985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ji+gytidbXOMWyPvLX4LLTm6QX/OlsVTfQzF/90xBXs=;
        b=MXI2utrq6URdh6bfTl9jqQNgccUlFLaPsw157Cflrqr3gTb4XGWRx2mzTVVjYbCXcZc9Ug
        6Z3ltm26By35qYCFACxEKzr2/ZNxGHvmBvJr7dWLqnDyfjHH+9cCL51SUZiwuhGTBEJj0a
        KzO3urTPvxj9o244UXmXMTI3+Oi9GdE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-OfgwyDBZMqah10-vzCPlwA-1; Fri, 16 Dec 2022 21:26:23 -0500
X-MC-Unique: OfgwyDBZMqah10-vzCPlwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F7D685C6E0;
        Sat, 17 Dec 2022 02:26:22 +0000 (UTC)
Received: from [10.22.8.73] (unknown [10.22.8.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FB7A40C2064;
        Sat, 17 Dec 2022 02:26:20 +0000 (UTC)
Message-ID: <af29b121-b1da-64f3-a739-1b233fa04002@redhat.com>
Date:   Fri, 16 Dec 2022 21:26:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting
 information
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com,
        dietmar.eggemann@arm.com, cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-4-juri.lelli@redhat.com>
 <20221216233501.gh6m75e7s66dmjgo@airbuntu>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221216233501.gh6m75e7s66dmjgo@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/16/22 18:35, Qais Yousef wrote:
> Hi
>
> On 07/19/19 15:59, Juri Lelli wrote:
>> When the topology of root domains is modified by CPUset or CPUhotplug
>> operations information about the current deadline bandwidth held in the
>> root domain is lost.
>>
>> This patch addresses the issue by recalculating the lost deadline
>> bandwidth information by circling through the deadline tasks held in
>> CPUsets and adding their current load to the root domain they are
>> associated with.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>> ---
> We see that rebuild_root_domain() can take 10+ ms (I get a max of 20ms quite
> consistently) on suspend/resume.
>
> Do we actually need to rebuild_root_domain() if we're going through
> a suspend/resume cycle?
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
>  From 4cfd50960ad872c5eb810ad3038eaf840bab5182 Mon Sep 17 00:00:00 2001
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
>   kernel/cgroup/cpuset.c  | 6 ++++++
>   kernel/sched/deadline.c | 3 +++
>   2 files changed, 9 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b474289c15b8..2ff68d625b7b 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1067,6 +1067,9 @@ static void update_tasks_root_domain(struct cpuset *cs)
>   	struct css_task_iter it;
>   	struct task_struct *task;
>   
> +	if (cpuhp_tasks_frozen)
> +		return;
> +
>   	css_task_iter_start(&cs->css, 0, &it);
>   
>   	while ((task = css_task_iter_next(&it)))
> @@ -1084,6 +1087,9 @@ static void rebuild_root_domains(void)
>   	lockdep_assert_cpus_held();
>   	lockdep_assert_held(&sched_domains_mutex);
>   
> +	if (cpuhp_tasks_frozen)
> +		return;
> +
>   	rcu_read_lock();
>   
>   	/*

rebuild_root_domains() is the only caller of update_tasks_root_domain(). 
So the first hunk is redundant as update_tasks_root_domain() won't be 
called when cpuhp_tasks_frozen is set.

Cheers,
Longman

