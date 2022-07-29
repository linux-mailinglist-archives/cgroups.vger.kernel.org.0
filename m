Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79845854FF
	for <lists+cgroups@lfdr.de>; Fri, 29 Jul 2022 20:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiG2SbM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 14:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiG2SbJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 14:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D59891D320
        for <cgroups@vger.kernel.org>; Fri, 29 Jul 2022 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659119466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWKVK6OoM1bKr67knlvEgc7AaGfjBxkEmDKqD2fNc5c=;
        b=Wh5qmbewGcqCiYMrQARW1kBIi6g9bmakX+CqLkz68N62F8Ud0XtIucy6z+0xtTjL+NzdET
        BjeTOdYPRW2U+sI4ivTZybz51VcAyTrSV4Sld5TkNpP7gMEAkCfoNPo/3pXsJHgHyPK5s+
        Cim0Sl5/ZwYxbuqky4XC10QdcZyZOwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-HEfqHrfIM6a6xvhRHbdgkQ-1; Fri, 29 Jul 2022 14:31:03 -0400
X-MC-Unique: HEfqHrfIM6a6xvhRHbdgkQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D87AC185A7A4;
        Fri, 29 Jul 2022 18:31:02 +0000 (UTC)
Received: from [10.22.34.17] (unknown [10.22.34.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF117404D883;
        Fri, 29 Jul 2022 18:31:01 +0000 (UTC)
Message-ID: <c9d82d78-b47d-0f4a-f1ca-81df78e1baa6@redhat.com>
Date:   Fri, 29 Jul 2022 14:31:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
References: <20220728005815.1715522-1-longman@redhat.com>
 <YuLF+xXaCzwWi2BR@slm.duckdns.org>
 <1ae1cc6c-dca9-4958-6b22-24a5777c5e8d@redhat.com>
 <YuLdX7BYGvo57LNU@slm.duckdns.org>
 <606ed69e-8ad0-45d5-9de7-48739df7f48d@redhat.com>
 <YuL1NijxSEv2xadk@slm.duckdns.org>
 <c470d3f7-f0f8-b8e6-4a95-7b334f0a824b@redhat.com>
 <YuMCB86fH2K3NcqM@slm.duckdns.org> <xhsmhy1wcc8dq.mognet@vschneid.remote.csb>
 <92f68392-12d2-f64a-9bb9-1a3a15f99d02@redhat.com>
In-Reply-To: <92f68392-12d2-f64a-9bb9-1a3a15f99d02@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/29/22 10:50, Waiman Long wrote:
> On 7/29/22 10:15, Valentin Schneider wrote:
>> On 28/07/22 11:39, Tejun Heo wrote:
>>> Hello, Waiman.
>>>
>>> On Thu, Jul 28, 2022 at 05:04:19PM -0400, Waiman Long wrote:
>>>>> So, the patch you proposed is making the code remember one special 
>>>>> aspect of
>>>>> user requested configuration - whether it configured it or not, 
>>>>> and trying
>>>>> to preserve that particular state as cpuset state changes. It 
>>>>> addresses the
>>>>> immediate problem but it is a very partial approach. Let's say a 
>>>>> task wanna
>>>>> be affined to one logical thread of each core and set its mask to 
>>>>> 0x5555.
>>>>> Now, let's say cpuset got enabled and enforced 0xff and affined 
>>>>> the task to
>>>>> 0xff. After a while, the cgroup got more cpus allocated and its 
>>>>> cpuset now
>>>>> has 0xfff. Ideally, what should happen is the task now having the 
>>>>> effective
>>>>> mask of 0x555. In practice, tho, it either would get 0xf55 or 0x55 
>>>>> depending
>>>>> on which way we decide to misbehave.
>>>> OK, I see what you want to accomplish. To fully address this issue, 
>>>> we will
>>>> need to have a new cpumask variable in the the task structure which 
>>>> will be
>>>> allocated if sched_setaffinity() is ever called. I can rework my 
>>>> patch to
>>>> use this approach.
>>> Yeah, we'd need to track what user requested separately from the 
>>> currently
>>> effective cpumask. Let's make sure that the scheduler folks are on 
>>> board
>>> before committing to the idea tho. Peter, Ingo, what do you guys think?
>>>
>> FWIW on a runtime overhead side of things I think it'll be OK as that
>> should be just an extra mask copy  in sched_setaffinity() and a subset
>> check / cpumask_and() in set_cpus_allowed_ptr(). The policy side is a 
>> bit
>> less clear (when, if ever, do we clear the user-defined mask? Will it 
>> keep
>> haunting us even after moving a task to a disjoint cpuset partition?).
>
> The runtime overhead should be minimal. It is the behavioral side that 
> we should be careful about. It is a change in existing behavior and we 
> don't want to cause surprise to the users. Currently, a task that set 
> its cpu affinity explicitly will have its affinity reset whenever 
> there is any change to the cpuset it belongs to or a hotplug event 
> touch any cpu in the current cpuset. The new behavior we are proposing 
> here is that it will try its best to keep the cpu affinity that the 
> user requested within the constraint of the current cpuset as well as 
> the cpu hotplug state.
>
>
>>
>> There's also if/how that new mask should be exposed, because attaching a
>> task to a cpuset will now yield a not-necessarily-obvious affinity -
>> e.g. in the thread affinity example above, if the initial affinity 
>> setting
>> was done ages ago by some system tool, IMO the user needs a way to be 
>> able
>> to expect/understand the result of 0x555 rather than 0xfff.
>
> Users can use sched_getaffinity(2) to retrieve the current cpu 
> affinity. It is up to users to set another one if they don't like the 
> current one. I don't think we need to return what the previous 
> requested cpu affinity is. They are suppose to know that or they can 
> set their own if they don't like it. \

Looking at Will's series that introduced user_cpus_ptr, I think we can 
overlay our proposal on top of that. So calling sched_setaffinity() will 
also update user_cpus_ptr. We may still need a flag to indicate whether 
user_cpus_ptr is set up because of sched_setaffinity() or due to a call 
to force_compatible_cpus_allowed_ptr() from arm64 arch code. That will 
make our work easier as some of the infrastructure is already there. I 
am looking forward for your feedback.

Thanks,
Longman

