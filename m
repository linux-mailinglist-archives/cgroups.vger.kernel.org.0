Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283806CEF99
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 18:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjC2Qji (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC2Qjh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 12:39:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE9F5A7;
        Wed, 29 Mar 2023 09:39:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA20A1FB;
        Wed, 29 Mar 2023 09:40:20 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 124B53F6C4;
        Wed, 29 Mar 2023 09:39:32 -0700 (PDT)
Message-ID: <cdede77a-5dc5-8933-a444-a2046b074b12@arm.com>
Date:   Wed, 29 Mar 2023 18:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/6] cgroup/cpuset: Free DL BW in case can_attach() fails
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <f8baea06-eeda-439a-3699-1cad7cde659e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 29/03/2023 16:31, Waiman Long wrote:
> On 3/29/23 10:25, Waiman Long wrote:
>>
>> On 3/29/23 08:55, Juri Lelli wrote:
>>> From: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]

>>> @@ -2518,11 +2547,21 @@ static int cpuset_can_attach(struct
>>> cgroup_taskset *tset)
>>>   static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>>>   {
>>>       struct cgroup_subsys_state *css;
>>> +    struct cpuset *cs;
>>>         cgroup_taskset_first(tset, &css);
>>> +    cs = css_cs(css);
>>>         mutex_lock(&cpuset_mutex);
>>> -    css_cs(css)->attach_in_progress--;
>>> +    cs->attach_in_progress--;
>>> +
>>> +    if (cs->nr_migrate_dl_tasks) {
>>> +        int cpu = cpumask_any(cs->effective_cpus);
>>> +
>>> +        dl_bw_free(cpu, cs->sum_migrate_dl_bw);
>>> +        reset_migrate_dl_data(cs);
>>> +    }
>>> +
> 
> Another nit that I have is that you may have to record also the cpu
> where the DL bandwidth is allocated in cpuset_can_attach() and free the
> bandwidth back into that cpu or there can be an underflow if another cpu
> is chosen.

Many thanks for the review!

But isn't the DL BW control `struct dl_bw` per `struct root_domain`
which is per exclusive cpuset. So as long cpu is from
`cs->effective_cpus` shouldn't this be fine?


