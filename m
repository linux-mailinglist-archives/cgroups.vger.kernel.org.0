Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069956F5D59
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 19:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjECRz1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 13:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjECRzZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 13:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889A4B5
        for <cgroups@vger.kernel.org>; Wed,  3 May 2023 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683136476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKPUL7FZWA4e+itJ2WAtXLunhkYaY3Bk3M9ZOMdUVpQ=;
        b=hbM85wjG5OqYg/6yF//dDtyBCiqICqD/YvlKsnu2vkIU53VC4mr/94yTYdIqe8adof3ILw
        JnLfoPEMHfzb8S9I9q9Vlb3+wXIK5eaq+RWYMDqaZPUAFO2BsdOQ2MSYRjqPvMkmr5FyLQ
        GpHV8Cmq0jxDbEmuSUBTIGwsh7eBmCE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-JW0PGHQoOkygat9G0REsvg-1; Wed, 03 May 2023 13:54:32 -0400
X-MC-Unique: JW0PGHQoOkygat9G0REsvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7798886462;
        Wed,  3 May 2023 17:54:27 +0000 (UTC)
Received: from [10.22.17.228] (unknown [10.22.17.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1D64C15BAD;
        Wed,  3 May 2023 17:54:26 +0000 (UTC)
Message-ID: <a3011e82-9e44-9292-dd51-e557d31930c2@redhat.com>
Date:   Wed, 3 May 2023 13:54:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/6] cgroup/cpuset: Rename functions dealing with
 DEADLINE accounting
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
References: <20230503072228.115707-1-juri.lelli@redhat.com>
 <20230503072228.115707-2-juri.lelli@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230503072228.115707-2-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 5/3/23 03:22, Juri Lelli wrote:
> rebuild_root_domains() and update_tasks_root_domain() have neutral
> names, but actually deal with DEADLINE bandwidth accounting.
>
> Rename them to use 'dl_' prefix so that intent is more clear.
>
> No functional change.
>
> Suggested-by: Qais Yousef <qyousef@layalina.io>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e4ca2dd2b764..428ab46291e2 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1066,7 +1066,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   	return ndoms;
>   }
>   
> -static void update_tasks_root_domain(struct cpuset *cs)
> +static void dl_update_tasks_root_domain(struct cpuset *cs)
>   {
>   	struct css_task_iter it;
>   	struct task_struct *task;
> @@ -1079,7 +1079,7 @@ static void update_tasks_root_domain(struct cpuset *cs)
>   	css_task_iter_end(&it);
>   }
>   
> -static void rebuild_root_domains(void)
> +static void dl_rebuild_rd_accounting(void)
>   {
>   	struct cpuset *cs = NULL;
>   	struct cgroup_subsys_state *pos_css;
> @@ -1107,7 +1107,7 @@ static void rebuild_root_domains(void)
>   
>   		rcu_read_unlock();
>   
> -		update_tasks_root_domain(cs);
> +		dl_update_tasks_root_domain(cs);
>   
>   		rcu_read_lock();
>   		css_put(&cs->css);
> @@ -1121,7 +1121,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   {
>   	mutex_lock(&sched_domains_mutex);
>   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> -	rebuild_root_domains();
> +	dl_rebuild_rd_accounting();
>   	mutex_unlock(&sched_domains_mutex);
>   }
>   
Reviewed-by: Waiman Long <longman@redhat.com>

