Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFCE686E5B
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 19:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjBASrJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 13:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjBASrG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 13:47:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA72E44B9
        for <cgroups@vger.kernel.org>; Wed,  1 Feb 2023 10:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675277179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WMJxGKUxICdJkr3IJm0KcD0HtsJ23RP/wU90pxKymkc=;
        b=CoARRrjKtZiwemYPGXGI0z6wkLCemDMnXi91JXigpXtkzhJd2piDw6MtR6btdrDGnvCmH4
        /fKwW0uZNLfKZ3ZlJoHxN538oE3OTQ+GgCCsAuoKzuWLo+Ch7mrB6n8L3UM24okLBCxqtw
        u2jlv2sBB5jovJjXQCDyKGphmHmtTb0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-sSPZQ4WkOkmzIKi8gGgpHQ-1; Wed, 01 Feb 2023 13:46:13 -0500
X-MC-Unique: sSPZQ4WkOkmzIKi8gGgpHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C25F1885622;
        Wed,  1 Feb 2023 18:46:11 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 250102166B33;
        Wed,  1 Feb 2023 18:46:11 +0000 (UTC)
Message-ID: <a892d340-ea99-1562-0e70-176f02f195c2@redhat.com>
Date:   Wed, 1 Feb 2023 13:46:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9otWX+MGOLDKU6t@hirez.programming.kicks-ass.net>
 <83e53632-27ed-8dde-84f4-68c6776d6da8@redhat.com>
In-Reply-To: <83e53632-27ed-8dde-84f4-68c6776d6da8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/1/23 10:16, Waiman Long wrote:
> On 2/1/23 04:14, Peter Zijlstra wrote:
>> On Tue, Jan 31, 2023 at 11:14:27PM -0500, Waiman Long wrote:
>>> On 1/31/23 17:17, Will Deacon wrote:
>>>> From: Peter Zijlstra <peterz@infradead.org>
>>>>
>>>> There is a difference in behaviour between CPUSET={y,n} that is now
>>>> wrecking havoc with {relax,force}_compatible_cpus_allowed_ptr().
>>>>
>>>> Specifically, since commit 8f9ea86fdf99 ("sched: Always preserve the
>>>> user requested cpumask") relax_compatible_cpus_allowed_ptr() is
>>>> calling __sched_setaffinity() unconditionally.
>>>>
>>>> But the underlying problem goes back a lot further, possibly to
>>>> commit: ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}") which
>>>> switched cpuset_cpus_allowed() from cs->cpus_allowed to
>>>> cs->effective_cpus.
>>>>
>>>> The problem is that for CPUSET=y cpuset_cpus_allowed() will filter out
>>>> all offline CPUs. For tasks that are part of a (!root) cpuset this is
>>>> then later fixed up by the cpuset hotplug notifiers that re-evaluate
>>>> and re-apply cs->effective_cpus, but for (normal) tasks in the root
>>>> cpuset this does not happen and they will forever after be excluded
>>>> from CPUs onlined later.
>>>>
>>>> As such, rewrite cpuset_cpus_allowed() to return a wider mask,
>>>> including the offline CPUs.
>>>>
>>>> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested 
>>>> cpumask")
>>>> Reported-by: Will Deacon <will@kernel.org>
>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Link: 
>>>> https://lkml.kernel.org/r/20230117160825.GA17756@willie-the-truck
>>>> Signed-off-by: Will Deacon <will@kernel.org>
>>> Before cgroup v2, cpuset had only one cpumask - cpus_allowed. It only
>>> tracked online cpus and ignored the offline ones. It behaves more like
>>> effective_cpus in cpuset v2. With v2, we have 2 cpumasks - 
>>> cpus_allowed and
>>> effective_cpus. When cpuset v1 is mounted, cpus_allowed and 
>>> effective_cpus
>>> are effectively the same and track online cpus. With cpuset v2, 
>>> cpus_allowed
>>> contains what the user has written into and it won't be changed until
>>> another write happen. However, what the user written may not be what 
>>> the
>>> system can give it and effective_cpus is what the system decides a 
>>> cpuset
>>> can use.
>>>
>>> Cpuset v2 is able to handle hotplug correctly and update the task's 
>>> cpumask
>>> accordingly. So missing previously offline cpus won't happen with v2.
>>>
>>> Since v1 keeps the old behavior, previously offlined cpus are lost 
>>> in the
>>> cpuset's cpus_allowed. However tasks in the root cpuset will still 
>>> be fine
>>> with cpu hotplug as its cpus_allowed should track cpu_online_mask. 
>>> IOW, only
>>> tasks in a non-root cpuset suffer this problem.
>>>
>>> It was a known issue in v1 and I believe is one of the major reasons 
>>> of the
>>> cpuset v2 redesign.
>>>
>>> A major concern I have is the overhead of creating a poor man 
>>> version of v2
>>> cpus_allowed. This issue can be worked around even for cpuset v1 if 
>>> it is
>>> mounted with the cpuset_v2_mode option to behave more like v2 in its 
>>> cpumask
>>> handling. Alternatively we may be able to provide a config option to 
>>> make
>>> this the default for v1 without the special mount option, if necessary.
>> You're still not getting it -- even cpuset (be it v1 or v2) *MUST* *NOT*
>> mask offline cpus for root cgroup tasks, ever. (And the only reason it
>> gets away with masking offline for !root is that it re-applies the mask
>> every time it changes.)
>>
>> Yes it did that for a fair while -- but it is wrong and broken and a
>> very big behavioural difference between CONFIG_CPUSET={y,n}. This must
>> not be.
>>
>> Arguably cpuset-v2 is still wrong for masking offline cpus in it's
>> effective_cpus mask, but I really didn't want to go rewrite cpuset.c for
>> something that needs to go into /urgent *now*.
>>
>> Hence this minimal patch that at least lets sched_setaffinity() work as
>> intended.
>
> I don't object to the general idea of keeping offline cpus in a task's 
> cpu affinity. In the case of cpu offline event, we can skip removing 
> that offline cpu from the task's cpu affinity. That will partially 
> solve the problem here and is also simpler.
>
> I believe a main reason why effective_cpus holds only online cpus is 
> because of the need to detect when there is no online cpus available 
> in a given cpuset. In this case, it will fall back to the nearest 
> ancestors with online cpus.
>
> This offline cpu problem with cpuset v1 is a known problem for a long 
> time. It is not a recent regression.

Note that using cpus_allowed directly in cgroup v2 may not be right 
because cpus_allowed may have no relationship to effective_cpus at all 
in some cases, e.g.

    root
     |
     V
     A (cpus_allowed = 1-4, effective_cpus = 1-4)
     |
     V
     B (cpus_allowed = 5-8, effective_cpus = 1-4)

In the case of cpuset B, passing back cpus 5-8 as the allowed_cpus is wrong.

I wonder how often is cpu hotplug happening in those arm64 cpu systems 
that only have a subset of cpus that can run 32-bit programs.

Cheers,
Longman

