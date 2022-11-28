Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC6B63A1FD
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 08:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiK1Hec (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 02:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiK1Heb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 02:34:31 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8485E0CD
        for <cgroups@vger.kernel.org>; Sun, 27 Nov 2022 23:34:29 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id l7so7155622pfl.7
        for <cgroups@vger.kernel.org>; Sun, 27 Nov 2022 23:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5OQ0+HkEwysNm14BQXMxnO8hH5pCig2NftJNgO6du0=;
        b=RReTjXzCQ0D7Ue2ywprGw6Ng9pgYkX1/w8H21qM0JrNDKDmPHD/EloVDmyiJt6SP3a
         EVA5B/iRRoccrue5N8UFHZDtJ3H2+eeB7JLeIamvAY9p3vAKhJVRKyS50PLdYRf8sUW/
         BIjCXBFmzrpnpULJ0RrFZSunPrp8lm1WIijgMROxJg8AlgbfCD1NXZAZ+2JrP+EHVDg+
         7NvquqBEn6OzMPVOIvzTse/04WIlG0M5x2/gKXmkglO1hEZv2/EwhevlZl8F6RXoFrfd
         f5XSkyPGXFgaSzI4tWJlafWkNo5BTaMOt/t1xroh/Cj58xW0z6fQPoi5Au6eGK9AJTEJ
         IUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f5OQ0+HkEwysNm14BQXMxnO8hH5pCig2NftJNgO6du0=;
        b=rtYcDUCy+Qoq2/KSdntbe1l5OHHVZmeeOQfcg8OzxT2zawvq0v5LRUAw5bMEQ0QSaH
         Dbqy9uMjUeuyTz9fJ0lec7g27gYkIMOCKIQ6bZsGX88K385H4Xf9i5RQPunovyztVHgl
         xlO8BQ3o7kRJMtUcgXgIPzmHLRPckk0lnz13tMW1imuomb4kJTUMwzHo2ZaZuIa9mljh
         adna4u0UKxNQfmrIxy/ngNyYGj3FQh5ZvvCE7MZXCtuiLuJJEqH2xYCPdbr2hULS+NcI
         OblTGrUT15RKXXvarwzRZUo7fNTUTnb2hy9fk9Czp6xPeHQRz9n2FbJJBfsroOUPrRwU
         5s5Q==
X-Gm-Message-State: ANoB5pk0qWqC4zRMpsnu8LaJ4EL0cwfkR8vy8WhtpCiBMk/HD6YAfTFC
        GrrUtLFSSfsQfXIrPSJbcr6tAA==
X-Google-Smtp-Source: AA0mqf4mMCiPth1vKdy9I3rsn6kFdwmyzKNOSdEy7d8GFsixX5CepX9q301xI9TnkXpQAWgT96YwYA==
X-Received: by 2002:a65:5a4c:0:b0:477:ba9d:ef8 with SMTP id z12-20020a655a4c000000b00477ba9d0ef8mr21952298pgs.98.1669620869171;
        Sun, 27 Nov 2022 23:34:29 -0800 (PST)
Received: from [10.54.24.49] (static-ip-147-99-134-202.rev.dyxnet.com. [202.134.99.147])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b001837b19ebb8sm8030579plf.244.2022.11.27.23.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 23:34:28 -0800 (PST)
Message-ID: <b1c6f583-5cb1-442a-ea64-4f999b939216@shopee.com>
Date:   Mon, 28 Nov 2022 15:34:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] cgroup/cpuset: Optimize update_tasks_nodemask()
To:     Waiman Long <longman@redhat.com>
Cc:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221123082157.71326-1-haifeng.xu@shopee.com>
 <2ac6f207-e08a-2a7f-01ae-dfaf15eefaf6@redhat.com>
 <4de8821b-e0c0-bf63-4d76-b0ce208cce3b@shopee.com>
 <dfcbffb9-b58a-6d25-2174-39394eb0ccde@redhat.com>
 <21e73dad-c6d0-21ea-dcdf-355b71c8537b@shopee.com>
 <1a997ea7-bb63-1710-14d6-c3b88a22bdb3@redhat.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <1a997ea7-bb63-1710-14d6-c3b88a22bdb3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2022/11/25 07:00, Waiman Long wrote:
> On 11/24/22 02:49, Haifeng Xu wrote:
>>
>> On 2022/11/24 12:24, Waiman Long wrote:
>>> On 11/23/22 22:33, Haifeng Xu wrote:
>>>> On 2022/11/24 04:23, Waiman Long wrote:
>>>>> On 11/23/22 03:21, haifeng.xu wrote:
>>>>>> When change the 'cpuset.mems' under some cgroup, system will hung
>>>>>> for a long time. From the dmesg, many processes or theads are
>>>>>> stuck in fork/exit. The reason is show as follows.
>>>>>>
>>>>>> thread A:
>>>>>> cpuset_write_resmask /* takes cpuset_rwsem */
>>>>>>      ...
>>>>>>        update_tasks_nodemask
>>>>>>          mpol_rebind_mm /* waits mmap_lock */
>>>>>>
>>>>>> thread B:
>>>>>> worker_thread
>>>>>>      ...
>>>>>>        cpuset_migrate_mm_workfn
>>>>>>          do_migrate_pages /* takes mmap_lock */
>>>>>>
>>>>>> thread C:
>>>>>> cgroup_procs_write /* takes cgroup_mutex and
>>>>>> cgroup_threadgroup_rwsem */
>>>>>>      ...
>>>>>>        cpuset_can_attach
>>>>>>          percpu_down_write /* waits cpuset_rwsem */
>>>>>>
>>>>>> Once update the nodemasks of cpuset, thread A wakes up thread B to
>>>>>> migrate mm. But when thread A iterates through all tasks, including
>>>>>> child threads and group leader, it has to wait the mmap_lock which
>>>>>> has been take by thread B. Unfortunately, thread C wants to migrate
>>>>>> tasks into cgroup at this moment, it must wait thread A to release
>>>>>> cpuset_rwsem. If thread B spends much time to migrate mm, the
>>>>>> fork/exit which acquire cgroup_threadgroup_rwsem also need to
>>>>>> wait for a long time.
>>>>>>
>>>>>> There is no need to migrate the mm of child threads which is
>>>>>> shared with group leader. Just iterate through the group
>>>>>> leader only.
>>>>>>
>>>>>> Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
>>>>>> ---
>>>>>>     kernel/cgroup/cpuset.c | 3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>>>> index 589827ccda8b..43cbd09546d0 100644
>>>>>> --- a/kernel/cgroup/cpuset.c
>>>>>> +++ b/kernel/cgroup/cpuset.c
>>>>>> @@ -1968,6 +1968,9 @@ static void update_tasks_nodemask(struct cpuset
>>>>>> *cs)
>>>>>>               cpuset_change_task_nodemask(task, &newmems);
>>>>>>     +        if (!thread_group_leader(task))
>>>>>> +            continue;
>>>>>> +
>>>>>>             mm = get_task_mm(task);
>>>>>>             if (!mm)
>>>>>>                 continue;
>>>>> Could you try the attached test patch to see if it can fix your problem?
>>>>> Something along the line of this patch will be more acceptable.
>>>>>
>>>>> Thanks,
>>>>> Longman
>>>>>
>>>> Hi, Longman.
>>>> Thanks for your patch, but there are still some problems.
>>>>
>>>> 1）
>>>>     (group leader, node: 0,1)
>>>>            cgroup0
>>>>            /     \
>>>>           /       \
>>>>       cgroup1   cgroup2
>>>>      (threads)  (threads)
>>>>
>>>> If set node 0 in cgroup1 and node 1 in cgroup2, both of them will update
>>>> the mm. And the nodemask of mm depends on who set the node last.
>>> Yes, that is the existing behavior. It was not that well defined in the
>>> past and so it is somewhat ambiguous as to what we need to do about it.
>>>
>> The test patch works if the child threads are in same cpuset with group
>> leader which has same logic with my patch. But if they are in different
>> cpusets, the test patch will fail because the contention of mmap_lock
>> still exsits and seems similar to the original logic.
> 
> That is true. I am thinking about adding a nodemask to mm_struct so that we can figure out if we need to propagate the changes down to all the VMAs and do the migration. That will enable us to avoid doing wasteful work.
> 
> Current node mask handling isn't that efficient especially for distros that have a relatively large NODES_SHIFT value. Some work may also be need in this area.
> 
>>> BTW, cgroup1 has a memory_migrate flag which will force page migration
>>> if set. I guess you may have it set in your case as it will introduce a
>>> lot more delay as page migration takes time. That is probably the reason
>>> why you are seeing a long delay. So one possible solution is to turn
>>> this flag off. Cgroup v2 doesn't have this flag.
>>>
>> Dou you mean 'CS_MEMORY_MIGRATE'? This flag can be turn off in Cgroup
>> v1, but it has been set in Cgroup v2 (cpuset_css_alloc) in default and
>> couldn't be changed.
> You are right. Cgroup v2 has CS_MEMORY_MIGRATE enabled by default and can't be turned off.

Hi, Longman.
'dfl_files' is just a minimal set. Shall we enable memory_migrate feature in Cgroup V2?
So it can be turned off and help to solve the problem.
>>
>>>> 2）
>>>>      (process, node: 0,1)
>>>>            cgroup0
>>>>            /     \
>>>>           /       \
>>>>       cgroup1   cgroup2
>>>>      (node: 0)  (node: 1)
>>>>
>>>> If migrate thread from cgroup0 to cgroup1 or cgroup2, cpuset_attach
>>>> won't update the mm. So the nodemask of thread, including mems_allowed
>>>> and mempolicy（updated in cpuset_change_task_nodemask）, is different
>>>> from
>>>> the vm_policy in vma(updated in mpol_rebind_mm).
>>> Yes, that can be the case.
>>>
>>>>
>>>> In a word, if threads have different cpusets with different nodemask, it
>>>> will cause inconsistent memory behavior.
>>> So do you have suggestion of what we need to do going forward?
>> Should we prevent thread from migrating to those cgroups which have
>> different nodemask with the cgroup that contains the group leader?
>>
>> In addition, the group leader and child threads should be in same cgroup
>> tree, also the level of cgroup containes group leader must be higher
>> than these cgroups contain child threads, so update_nodemask will work.
>>
>> Or just disable thread migration in cpuset？It's easy to achieve but will
>> affect cpu bind.
> 
> As said above, my current inclination is to add a nodemask to mm_struct and revise the way nodemask is being handled. That will take some time.
> 
> Cheers,
> Longman
> 
