Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F52586F62
	for <lists+cgroups@lfdr.de>; Mon,  1 Aug 2022 19:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiHARPs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Aug 2022 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiHARPd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Aug 2022 13:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D40302E6B6
        for <cgroups@vger.kernel.org>; Mon,  1 Aug 2022 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659374128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOv05Z1eCYkz6FAAiCtapLpNeaLhy0ndExjrSMpbgjQ=;
        b=U4ZNiI5bleQW58uubwxLGYnJh6BSJJAiUMUkaFFgKZPSewAxi3Rk0jOTwjtIg+vHch2ikA
        lEv2wq9gO71fb/Z2jIUQzPNWIbr7EQUCmm6R5sXA6OHGZZaZGU/19HaFdDLxQdpUDhFCiT
        pa6fzPA78M9UPnvKGNUroqEhgh9ulc0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-REhpL6ZwNMeao3eS-IOfnw-1; Mon, 01 Aug 2022 13:15:27 -0400
X-MC-Unique: REhpL6ZwNMeao3eS-IOfnw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D937B3C01DEA;
        Mon,  1 Aug 2022 17:15:26 +0000 (UTC)
Received: from [10.22.17.133] (unknown [10.22.17.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E680D401E23;
        Mon,  1 Aug 2022 17:15:25 +0000 (UTC)
Message-ID: <8b5a5be9-9976-a737-952f-67a7960f175f@redhat.com>
Date:   Mon, 1 Aug 2022 13:15:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220801154124.2011987-1-longman@redhat.com>
 <20220801154124.2011987-2-longman@redhat.com>
 <20220801164545.GA26471@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220801164545.GA26471@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/1/22 12:45, Will Deacon wrote:
> On Mon, Aug 01, 2022 at 11:41:23AM -0400, Waiman Long wrote:
>> The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
>> Introduce task_struct::user_cpus_ptr to track requested affinity"). It
>> is currently used only by arm64 arch due to possible asymmetric cpu
>> setup. This patch extends its usage to save user provided cpumask when
>> sched_setaffinity() is called for all arches.
>>
>> To preserve the existing arm64 use case, a new cpus_affinity_set flag is
>> added to differentiate if user_cpus_ptr is set up by sched_setaffinity()
>> or by force_compatible_cpus_allowed_ptr(). user_cpus_ptr
>> set by sched_setaffinity() has priority and won't be
>> overwritten by force_compatible_cpus_allowed_ptr() or
>> relax_compatible_cpus_allowed_ptr().
>>
>> As a call to sched_setaffinity() will no longer clear user_cpus_ptr
>> but set it instead, the SCA_USER flag is no longer necessary and can
>> be removed.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/linux/sched.h |  1 +
>>   kernel/sched/core.c   | 71 +++++++++++++++++++++++++++++++------------
>>   kernel/sched/sched.h  |  1 -
>>   3 files changed, 52 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index c46f3a63b758..60ae022fa842 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -815,6 +815,7 @@ struct task_struct {
>>   
>>   	unsigned int			policy;
>>   	int				nr_cpus_allowed;
>> +	int				cpus_affinity_set;
>>   	const cpumask_t			*cpus_ptr;
>>   	cpumask_t			*user_cpus_ptr;
>>   	cpumask_t			cpus_mask;
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index da0bf6fe9ecd..7757828c7422 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2607,6 +2607,7 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>>   		return -ENOMEM;
>>   
>>   	cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
>> +	dst->cpus_affinity_set = src->cpus_affinity_set;
> I haven't been through this thorougly, but it looks a bit suspicious to me
> to inherit this field directly across fork(). If a 64-bit task with this
> flag set forks and then exec's a 32-bit program, arm64 will be in trouble if
> we're not able to override the affinity forcefully.

I believe you can still override the affinity. What is in user_cpus_ptr 
is not the actual affinity which is in cpus_mask. It is just what the 
users desire. Its value has be masked off by the current cpuset as well 
as what is allowed in task_cpu_possible_mask().

Cheers,
Longman

