Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A49C584776
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 23:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiG1VEa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 17:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiG1VE3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 17:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCE8633E13
        for <cgroups@vger.kernel.org>; Thu, 28 Jul 2022 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659042267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PRBCCH+EkIgUpXOLdlJYEsIwuOxdedTFnF9t4CuFePQ=;
        b=hez/2kAh35IiVYm9jKtm0kUQl+tEZ07DggSIOutlcWDLR6HbAbhj10240R+6lt8Jw4CYGG
        GCbatS2aJDNMd8emBeZgD//keLmDRh4SGT9+3z8N7C2wYJu42gB4fY/mHqvOZ59wGuS4nb
        LpfpJSrItHr6ks4FAN/Fpz49e9/X2IQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-hc4-0P1tNrmW5ouNv8cVHw-1; Thu, 28 Jul 2022 17:04:22 -0400
X-MC-Unique: hc4-0P1tNrmW5ouNv8cVHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA6EE280303F;
        Thu, 28 Jul 2022 21:04:21 +0000 (UTC)
Received: from [10.22.9.86] (unknown [10.22.9.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C582D140EBE3;
        Thu, 28 Jul 2022 21:04:19 +0000 (UTC)
Message-ID: <c470d3f7-f0f8-b8e6-4a95-7b334f0a824b@redhat.com>
Date:   Thu, 28 Jul 2022 17:04:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220728005815.1715522-1-longman@redhat.com>
 <YuLF+xXaCzwWi2BR@slm.duckdns.org>
 <1ae1cc6c-dca9-4958-6b22-24a5777c5e8d@redhat.com>
 <YuLdX7BYGvo57LNU@slm.duckdns.org>
 <606ed69e-8ad0-45d5-9de7-48739df7f48d@redhat.com>
 <YuL1NijxSEv2xadk@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YuL1NijxSEv2xadk@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/28/22 16:44, Tejun Heo wrote:
> Hello,
>
> On Thu, Jul 28, 2022 at 03:21:26PM -0400, Waiman Long wrote:
>> On 7/28/22 15:02, Tejun Heo wrote:
>>> On Thu, Jul 28, 2022 at 02:57:28PM -0400, Waiman Long wrote:
>>>> There can be a counter argument that if a user found out that there is not
>>>> enough cpus in a cpuset to meet its performance target, one can always
>>>> increase the number of cpus in the cpuset. Generalizing this behavior to all
>>>> the tasks irrespective if they have explicitly set cpus affinity before will
>>>> disallow this use case.
>>> This is nasty.
>> That is a nasty example, I know. There may be users depending on the
>> existing behavior even if they don't know it. So I am a bit hesitant to
>> change the default behavior like that. On the other hand, tasks that have
>> explicitly set its cpu affinity certainly don't want to have unexpected
>> change to that.
> Yeah, I hear you. I'm on the same page.
>
>>> The real solution here is separating out what user requested
>>> and the mask that cpuset (or cpu hotplug) needs to apply on top. ie.
>>> remember what the user requested in a separate cpumask and compute the
>>> intersection into p->cpus_maks whenever something changes and apply
>>> fallbacks on that final mask. Multiple parties updating the same variable is
>>> never gonna lead to anything consistent and we're patching up for whatever
>>> the immediate use case seems to need at the moment. That said, I'm not
>>> necessarily against patching it up but if you're interested in delving into
>>> it deeper, that'd be great.
>> I believe the current code is already restricting what cpu affinity that a
>> user can request by limiting to those allowed by the current cpuset. Hotplug
>> is another issue that may need to be addressed. I will update my patch to
>> make it handle hotplug in a more graceful way.
> af
> So, the patch you proposed is making the code remember one special aspect of
> user requested configuration - whether it configured it or not, and trying
> to preserve that particular state as cpuset state changes. It addresses the
> immediate problem but it is a very partial approach. Let's say a task wanna
> be affined to one logical thread of each core and set its mask to 0x5555.
> Now, let's say cpuset got enabled and enforced 0xff and affined the task to
> 0xff. After a while, the cgroup got more cpus allocated and its cpuset now
> has 0xfff. Ideally, what should happen is the task now having the effective
> mask of 0x555. In practice, tho, it either would get 0xf55 or 0x55 depending
> on which way we decide to misbehave.

OK, I see what you want to accomplish. To fully address this issue, we 
will need to have a new cpumask variable in the the task structure which 
will be allocated if sched_setaffinity() is ever called. I can rework my 
patch to use this approach.

Thanks,
Longman

