Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAD6688884
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 21:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjBBUrw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 15:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjBBUrj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 15:47:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960A086613
        for <cgroups@vger.kernel.org>; Thu,  2 Feb 2023 12:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675370766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aQR1X76WMCq90MTRO1i7qJ75QChOwEsWK87cj0V0RuA=;
        b=a+iSWoWqJ3OB7PRyhiVFJXxV0bl/xHZafgryN+aATc0sWGwsdqXnieHYxvLYLu6oG/zWK1
        xiLx0VAU9inpjbEhLEF7GJvJ8Wl9w2sGNB0WqFU5SNwsrBb5znnAg+nOfUaHuxsAThK4zQ
        Q9Qw1ZhNyKFPghGgm223emqzWp2SIVQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557--ANhIVXXNWeJ4TTXZXd1Rg-1; Thu, 02 Feb 2023 15:46:03 -0500
X-MC-Unique: -ANhIVXXNWeJ4TTXZXd1Rg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF9D13810794;
        Thu,  2 Feb 2023 20:46:02 +0000 (UTC)
Received: from [10.22.8.157] (unknown [10.22.8.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5037B2026D4B;
        Thu,  2 Feb 2023 20:46:02 +0000 (UTC)
Message-ID: <2bc730db-704d-080b-6869-02f6d0035fad@redhat.com>
Date:   Thu, 2 Feb 2023 15:46:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9t1sP/6nFht7RSN@hirez.programming.kicks-ass.net>
 <d630ca53-71f0-c735-fbc3-e826479aa86b@redhat.com>
 <Y9wSC1Wxlm8CKKlN@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9wSC1Wxlm8CKKlN@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/2/23 14:42, Peter Zijlstra wrote:
> On Thu, Feb 02, 2023 at 11:06:51AM -0500, Waiman Long wrote:
>
>> After taking a close look at the patch, my understanding of what it is doing
>> is as follows:
>>
>> v2: cpus_allowed will not be affected by hotplug. So the new
>> cpuset_cpus_allowed() will return effective_cpus + offline cpus that should
>> have been part of effective_cpus if online before masking it with allowable
>> cpus and then go up the cpuset hierarchy if necessary.
>>
>> v1: cpus_allowed is equivalent to v2 effective_cpus. It starts at the
>> current cpuset and move up the hierarchy if necessary to find a cpuset that
>> have at least one allowable cpu.
>>
>> First of all, it does not take into account of the v2 partition feature that
>> may cause it to produce incorrect result if partition is enabled somewhere.
> How so? For a partition the cpus_allowed mask should be the parition
> CPUs. The only magical bit about partitions is that any one CPU cannot
> belong to two partitions and load-balancing is split.
There can be a child partition underneath it that uses up some of the 
cpus in cpus_allowed mask. So if you cascading up the cpuset tree from 
another child, your code will wrongly include those cpus that are 
dedicated to the other child partition.
>
>> Secondly, I don't see any benefit other than having some additional offline
>> cpu available in a task's cpumask which the scheduler will ignore anyway.
> Those CPUs can come online again -- you're *again* dismissing the true
> bug :/
>
> If you filter out the offline CPUs at sched_setaffinity() time, you
> forever lose those CPUs, the task will never again move to those CPUs,
> even if they do come online after.
>
> It is really simple to reproduce this:
>
>   - boot machine
>   - offline all CPUs except one
>   - taskset -p ffffffff $$
>   - online all CPUs
>
> and observe your shell (and all its decendants) being stuck to the one
> CPU. Do the same thing on a CPUSET=n build and note the difference (you
> retain the full mask).

With the new sched_setaffinity(), the original mask should be stored in 
user_cpus_ptr. The cpuset code is supposed to call 
set_cpus_allowed_ptr() which then set the mask correctly. I will run 
your test and figure out why it does not work as I would have expected.


>
>> v2 is able to recover a previously offlined cpu. So we don't gain any
>> net benefit other than the going up the cpuset hierarchy part.
> Only for !root tasks. Not even v2 will re-set the affinity of root tasks
> afaict.
>
>> For v1, I agree we should go up the cpuset hierarchy to find a usable
>> cpuset. Instead of introducing such a complexity in cpuset_cpus_allowed(),
>> my current preference is to do the hierarchy climbing part in an enhanced
>> cpuset_cpus_allowed_fallback() after an initial failure of
>> cpuset_cpus_allowed(). That will be easier to understand than having such
>> complexity and overhead in cpuset_cpus_allowed() alone.
>>
>> I will work on a patchset to do that as a counter offer.
> We will need a small and simple patch for /urgent, or I will need to
> revert all your patches -- your call.
>
> I also don't tihnk you fully appreciate the ramifications of
> task_cpu_possible_mask(), cpuset currently gets that quite wrong.

OK, I don't realize the urgency of that. If it is that urgent, I will 
have no objection to get it in for now. We can improve it later on. So 
are you planning to get it into the current 6.2 rc or 6.3?

Tejun, are you OK with that as you are the cgroup maintainer?

Cheers,
Longman

