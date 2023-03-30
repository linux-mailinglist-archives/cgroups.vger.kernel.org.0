Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C4A6D0AD5
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjC3QOy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjC3QOs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 12:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A890EB79
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+HJ4WLfm8Z01D2cI/A0RfbJSBHfv/6mLfrOQoLhihI=;
        b=co7ujp5qUL/OpZZaSoZ6+Dx7Tcxuhv27nma2OYyKSZKHxTZDWicCEkcpMX/2QsVDfcvpZ1
        72Q63JbZ6o/UEXSbpTgBsjzkpgyPk8f0MhK9kMdoCC8YFiGn7Cys+wpazleH3lok4D8KU6
        LYnLALnlx65YEs496mkG7nihTPMyyTk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-f7E3ZRQAP965kJ04DbTPXQ-1; Thu, 30 Mar 2023 12:13:11 -0400
X-MC-Unique: f7E3ZRQAP965kJ04DbTPXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A603857FB3;
        Thu, 30 Mar 2023 16:13:05 +0000 (UTC)
Received: from [10.22.33.26] (unknown [10.22.33.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36455202701F;
        Thu, 30 Mar 2023 16:13:03 +0000 (UTC)
Message-ID: <3268bedc-ee36-519a-de37-3c366129baae@redhat.com>
Date:   Thu, 30 Mar 2023 12:13:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/6] cgroup/cpuset: Free DL BW in case can_attach() fails
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-6-juri.lelli@redhat.com>
 <f8dfc30b-5079-2f44-7ab1-42ac25bd48b7@redhat.com>
 <f8baea06-eeda-439a-3699-1cad7cde659e@redhat.com>
 <cdede77a-5dc5-8933-a444-a2046b074b12@arm.com>
 <b7ad39b1-c615-3ebc-6980-d9db0f2ab0a0@redhat.com>
 <5ff103f9-1366-0a9b-bd97-419ced1de07f@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <5ff103f9-1366-0a9b-bd97-419ced1de07f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/30/23 11:14, Dietmar Eggemann wrote:
> On 29/03/2023 20:09, Waiman Long wrote:
>> On 3/29/23 12:39, Dietmar Eggemann wrote:
>>> On 29/03/2023 16:31, Waiman Long wrote:
>>>> On 3/29/23 10:25, Waiman Long wrote:
>>>>> On 3/29/23 08:55, Juri Lelli wrote:
>>>>>> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>> [...]
>>>
>>>>>> @@ -2518,11 +2547,21 @@ static int cpuset_can_attach(struct
>>>>>> cgroup_taskset *tset)
>>>>>>     static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>>>>>>     {
>>>>>>         struct cgroup_subsys_state *css;
>>>>>> +    struct cpuset *cs;
>>>>>>           cgroup_taskset_first(tset, &css);
>>>>>> +    cs = css_cs(css);
>>>>>>           mutex_lock(&cpuset_mutex);
>>>>>> -    css_cs(css)->attach_in_progress--;
>>>>>> +    cs->attach_in_progress--;
>>>>>> +
>>>>>> +    if (cs->nr_migrate_dl_tasks) {
>>>>>> +        int cpu = cpumask_any(cs->effective_cpus);
>>>>>> +
>>>>>> +        dl_bw_free(cpu, cs->sum_migrate_dl_bw);
>>>>>> +        reset_migrate_dl_data(cs);
>>>>>> +    }
>>>>>> +
>>>> Another nit that I have is that you may have to record also the cpu
>>>> where the DL bandwidth is allocated in cpuset_can_attach() and free the
>>>> bandwidth back into that cpu or there can be an underflow if another cpu
>>>> is chosen.
>>> Many thanks for the review!
>>>
>>> But isn't the DL BW control `struct dl_bw` per `struct root_domain`
>>> which is per exclusive cpuset. So as long cpu is from
>>> `cs->effective_cpus` shouldn't this be fine?
>> Sorry for my ignorance on how the deadline bandwidth operation work. I
>> check the bandwidth code and find that we are storing the bandwidth
>> information in the root domain, not on the cpu. That shouldn't be a
>> concern then.
>>
>> However, I still have some question on how that works when dealing with
>> cpuset. First of all, not all the CPUs in a given root domains are in
>> the cpuset. So there may be enough bandwidth on the root domain, but it
>> doesn't mean there will be enough bandwidth in the set of CPUs in a
>> particular cpuset. Secondly, how do you deal with isolated CPUs that do
>> not have a corresponding root domain? It is now possible to create a
>> cpuset with isolated CPUs.
> Sorry, I overlooked this email somehow.
>
> IMHO, this is only done for exclusive cpusets:
>
>    cpuset_can_attach()
>
>      if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus))
>
> So they should have their own root_domain congruent to their cpumask.

I am sorry that I missed that check.

Parallel attach is actually an existing problem in cpuset as there is a 
shared cpuset_attach_old_cs variable being used by cpuset between 
cpuset_can_attach() and cpuset_attach(). So any parallel attach can lead 
to corruption of this common data causing incorrect result. So this 
problem is not specific to this patch series. So please ignore this 
patch for now. It has to be addressed separately.

Cheers,
Longman

