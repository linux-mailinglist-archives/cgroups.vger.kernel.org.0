Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A525676007
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 23:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjATWRt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 17:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjATWRs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 17:17:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB0E1735
        for <cgroups@vger.kernel.org>; Fri, 20 Jan 2023 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674253020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PymHzUQySveMLAeF0IwXdw52bO+MwC9kbQnHrMu8WUY=;
        b=CW6Ozsn7//fTUgxjZQSr5IOxvgVYkfJdQ7448gAJZN/FAouMSRAZJ2Vf3oZlasD6qydlCk
        5ppD7tIKWvAcuHBKJ3Kt+uoTmp3vR/5sFL1gis3uH8jgATu+OhZn98mCV5UhwWnsZh9S8X
        DqQTIpAVpXTDCU5ussFdjn7DkgIw39M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-bKRJsAD2Mz-gc6apOXEULA-1; Fri, 20 Jan 2023 17:16:57 -0500
X-MC-Unique: bKRJsAD2Mz-gc6apOXEULA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD91E185A78B;
        Fri, 20 Jan 2023 22:16:56 +0000 (UTC)
Received: from [10.22.17.220] (unknown [10.22.17.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CC49C15BAD;
        Fri, 20 Jan 2023 22:16:55 +0000 (UTC)
Message-ID: <c4c2dec6-a72b-d675-fb42-be40e384ea2c@redhat.com>
Date:   Fri, 20 Jan 2023 17:16:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] sched: cpuset: Don't rebuild sched domains on
 suspend-resume
To:     Qais Yousef <qyousef@layalina.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>
References: <20230120194822.962958-1-qyousef@layalina.io>
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230120194822.962958-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 1/20/23 14:48, Qais Yousef wrote:
> Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
> enabled rebuilding sched domain on cpuset and hotplug operations to
> correct deadline accounting.
>
> Rebuilding sched domain is a slow operation and we see 10+ ms delay on
> suspend-resume because of that.
>
> Since nothing is expected to change on suspend-resume operation; skip
> rebuilding the sched domains to regain the time lost.
>
> Debugged-by: Rick Yiu <rickyiu@google.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>
>      Changes in v2:
>      
>      	* Remove redundant check in update_tasks_root_domain() (Thanks Waiman)
>      
>      v1 link:
>      
>      	https://lore.kernel.org/lkml/20221216233501.gh6m75e7s66dmjgo@airbuntu/
>
>   kernel/cgroup/cpuset.c  | 3 +++
>   kernel/sched/deadline.c | 3 +++
>   2 files changed, 6 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a29c0b13706b..9a45f083459c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1088,6 +1088,9 @@ static void rebuild_root_domains(void)
>   	lockdep_assert_cpus_held();
>   	lockdep_assert_held(&sched_domains_mutex);
>   
> +	if (cpuhp_tasks_frozen)
> +		return;
> +
>   	rcu_read_lock();
>   
>   	/*
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0d97d54276cc..42c1143a3956 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2575,6 +2575,9 @@ void dl_clear_root_domain(struct root_domain *rd)
>   {
>   	unsigned long flags;
>   
> +	if (cpuhp_tasks_frozen)
> +		return;
> +
>   	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
>   	rd->dl_bw.total_bw = 0;
>   	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);

cpuhp_tasks_frozen is set when thaw_secondary_cpus() or 
freeze_secondary_cpus() is called. I don't know the exact suspend/resume 
calling sequences, will cpuhp_tasks_frozen be cleared at the end of 
resume sequence? Maybe we should make sure that rebuild_root_domain() is 
called at least once at the end of resume operation.

Cheers,
Longman

