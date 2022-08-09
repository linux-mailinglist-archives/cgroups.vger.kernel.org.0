Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5BA58E0D6
	for <lists+cgroups@lfdr.de>; Tue,  9 Aug 2022 22:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245191AbiHIUP7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Aug 2022 16:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbiHIUPf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Aug 2022 16:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7AA26381
        for <cgroups@vger.kernel.org>; Tue,  9 Aug 2022 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660076129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZzTWuyHwis4b2KJ9R8kWXsQlD0tgnuiVwQ48okOh2B0=;
        b=Hxb1IcnzyZnq84YVJcfM0JN++ux6BjP5iwTngr6bHHOxUWwNnQA7OutyHxGHvgt6PvoJi8
        SsgJ8Nt92jDLeAUk0DSxajQ6AYd3IofoARoDoH4Tu7N327vfuocyX0RhIFDc/71RAsjmCh
        E8CM5yiogkwbDoV5wAqE9Iu2Kq0PsyU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-We1pDNjLNLasyQ1PbkmpMg-1; Tue, 09 Aug 2022 16:15:26 -0400
X-MC-Unique: We1pDNjLNLasyQ1PbkmpMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAF141C07552;
        Tue,  9 Aug 2022 20:15:25 +0000 (UTC)
Received: from [10.22.18.32] (unknown [10.22.18.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFBE8C15BA1;
        Tue,  9 Aug 2022 20:15:24 +0000 (UTC)
Message-ID: <7bd2c5c9-edb4-c071-0d24-28c6744f826b@redhat.com>
Date:   Tue, 9 Aug 2022 16:15:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] cgroup/cpuset: Keep user set cpus affinity
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220801154124.2011987-1-longman@redhat.com>
 <20220801154124.2011987-3-longman@redhat.com>
 <YvK7qVkmzbA12Eut@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YvK7qVkmzbA12Eut@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/9/22 15:55, Tejun Heo wrote:
> (cc'ing Linus)
>
> Hello,
>
> On Mon, Aug 01, 2022 at 11:41:24AM -0400, Waiman Long wrote:
>> It was found that any change to the current cpuset hierarchy may reset
>> the cpumask of the tasks in the affected cpusets to the default cpuset
>> value even if those tasks have cpus affinity explicitly set by the users
>> before. That is especially easy to trigger under a cgroup v2 environment
>> where writing "+cpuset" to the root cgroup's cgroup.subtree_control
>> file will reset the cpus affinity of all the processes in the system.
>>
>> That is problematic in a nohz_full environment where the tasks running
>> in the nohz_full CPUs usually have their cpus affinity explicitly set
>> and will behave incorrectly if cpus affinity changes.
>>
>> Fix this problem by looking at user_cpus_ptr which will be set if
>> cpus affinity have been explicitly set before and use it to restrcit
>> the given cpumask unless there is no overlap. In that case, it will
>> fallback to the given one.
>>
>> With that change in place, it was verified that tasks that have its
>> cpus affinity explicitly set will not be affected by changes made to
>> the v2 cgroup.subtree_control files.
> The fact that the kernel clobbers user-specified cpus_allowed as cpu
> availability changes always bothered me and it has been causing this sort of
> problems w/ cpu hotplug and cpuset. We've been patching this up partially
> here and there but I think it would be better if we just make the rules
> really simple - ie. allow users to configure whatever cpus_allowed as long
> as that's within cpu_possible_mask and override only the effective
> cpus_allowed if the mask leaves no runnable CPUs, so that we can restore the
> original configured behavior if and when some of the cpus become available
> again.
>
> One obvious problem with changing the behavior is that it may affect /
> confuse users expecting the current behavior however inconsistent it may be,
> but given that we have partially changed how cpus_allowed interacts with
> hotplug in the past and the current behavior can be inconsistent and
> surprising, I don't think this is a bridge we can't cross. What do others
> think?

My patch will still subject the cpus_allowed list to the constraint 
imposed by the current cpuset. It will keep as much of what the user 
specified though. If we are worrying about backward compatibility, maybe 
we can restrict that change in behavior to cgroup v2 only or we can add 
a sysctl parameter to restore old behavior if the user choose to.

Users are now gradually migrating over to cgroup v2 and they do 
understand that there are some changes in behavior when using cgroup v2.

Cheers,
Longman

