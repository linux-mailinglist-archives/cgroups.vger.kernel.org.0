Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6732063711A
	for <lists+cgroups@lfdr.de>; Thu, 24 Nov 2022 04:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiKXDdy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 22:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiKXDdx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 22:33:53 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2854AC655A
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 19:33:50 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d6so341200pll.7
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 19:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0A6IGdis8UFb2G4Z4L2JyFM1cHNL6BHSqh/4YAf0zi4=;
        b=kujSbxlTKyrW4i9i1/6mTJGpSMZE0X6OJ5IPMp3RRmF7qSCPjYv+2bVxe8n5Z8h/1g
         bJGk7Cy/wlCFbrYiAvpjMcNitplpF2Irh4BVshd+J0kP2wCcUImQPf7nRdWE0KFTBCBA
         lUI3rkT+qdxxs4B5g9tz4i2utI3kBEdq2Z51ez6CUhh/TLH5lZGFJlLxdgiXfecaVzJR
         TOJx8T7q5eFaM7U0Lm/aFpSPHRnULvKj6FlOBrG6m8NdlPkNBKxV+tDtgNgcv0Kf4Fpg
         9O/nQtv9++vzQ8l/n6hQMNKzXkEgHwAAHgN6yKPHGneCTt+7qdcfdgrJ8uepOPM1Q7kM
         RAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0A6IGdis8UFb2G4Z4L2JyFM1cHNL6BHSqh/4YAf0zi4=;
        b=OtB+pr/M+mTRBxHjjuma/BQcA/casUR1T1YGi0HFn44xo9N9O+3VO6+qXEArEBN67a
         bLAMIi/S4TM4/I2xF3WdOZlNVC/nQkozkioeuHKwrm2NSyOJ2lXU1P8suxlOFrJdMqa3
         oU7ZiJh2pNDAEMO9JCpMdZFko1PP0H3vTBo/JGilZQbt/DOD24X8blJCYu+1Ui9bOxuX
         wnqfEzPiJBBGRgLXCJKhNYaTPRhfElqZdzYeu9zcf2/tzy28U27FYrwA8uVyge4ACeDu
         3fH1RjOgTNMWAaCwWBtizB4LQ30gC8QA8bGn1IGSIR3YFYvEYMXac6Ii38QyjABtTu4R
         lMgA==
X-Gm-Message-State: ANoB5pmveO8N3pzHB6d5sic1L4GxL2zEYndANPZAM/KV1fQISLyV29ob
        qG7vPh459mZNL1Ktlb7K/Lp9hwwCeY6+hNiQ
X-Google-Smtp-Source: AA0mqf6TFuqVrxr7UJmls3+J/pP7Y0nu9EDSLYgEWnCPCi0hiUFNc0AibJoUBv/4x0cfITAjgPAKxw==
X-Received: by 2002:a17:902:6b89:b0:188:bb79:4892 with SMTP id p9-20020a1709026b8900b00188bb794892mr14662401plk.60.1669260829624;
        Wed, 23 Nov 2022 19:33:49 -0800 (PST)
Received: from [10.54.24.49] (static-ip-147-99-134-202.rev.dyxnet.com. [202.134.99.147])
        by smtp.gmail.com with ESMTPSA id ik18-20020a170902ab1200b001767f6f04efsm4416322plb.242.2022.11.23.19.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 19:33:48 -0800 (PST)
Message-ID: <4de8821b-e0c0-bf63-4d76-b0ce208cce3b@shopee.com>
Date:   Thu, 24 Nov 2022 11:33:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] cgroup/cpuset: Optimize update_tasks_nodemask()
To:     Waiman Long <longman@redhat.com>
Cc:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221123082157.71326-1-haifeng.xu@shopee.com>
 <2ac6f207-e08a-2a7f-01ae-dfaf15eefaf6@redhat.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <2ac6f207-e08a-2a7f-01ae-dfaf15eefaf6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2022/11/24 04:23, Waiman Long wrote:
> On 11/23/22 03:21, haifeng.xu wrote:
>> When change the 'cpuset.mems' under some cgroup, system will hung
>> for a long time. From the dmesg, many processes or theads are
>> stuck in fork/exit. The reason is show as follows.
>>
>> thread A:
>> cpuset_write_resmask /* takes cpuset_rwsem */
>>    ...
>>      update_tasks_nodemask
>>        mpol_rebind_mm /* waits mmap_lock */
>>
>> thread B:
>> worker_thread
>>    ...
>>      cpuset_migrate_mm_workfn
>>        do_migrate_pages /* takes mmap_lock */
>>
>> thread C:
>> cgroup_procs_write /* takes cgroup_mutex and cgroup_threadgroup_rwsem */
>>    ...
>>      cpuset_can_attach
>>        percpu_down_write /* waits cpuset_rwsem */
>>
>> Once update the nodemasks of cpuset, thread A wakes up thread B to
>> migrate mm. But when thread A iterates through all tasks, including
>> child threads and group leader, it has to wait the mmap_lock which
>> has been take by thread B. Unfortunately, thread C wants to migrate
>> tasks into cgroup at this moment, it must wait thread A to release
>> cpuset_rwsem. If thread B spends much time to migrate mm, the
>> fork/exit which acquire cgroup_threadgroup_rwsem also need to
>> wait for a long time.
>>
>> There is no need to migrate the mm of child threads which is
>> shared with group leader. Just iterate through the group
>> leader only.
>>
>> Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
>> ---
>>   kernel/cgroup/cpuset.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 589827ccda8b..43cbd09546d0 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1968,6 +1968,9 @@ static void update_tasks_nodemask(struct cpuset
>> *cs)
>>             cpuset_change_task_nodemask(task, &newmems);
>>   +        if (!thread_group_leader(task))
>> +            continue;
>> +
>>           mm = get_task_mm(task);
>>           if (!mm)
>>               continue;
> 
> Could you try the attached test patch to see if it can fix your problem?
> Something along the line of this patch will be more acceptable.
> 
> Thanks,
> Longman
> 

Hi, Longman.
Thanks for your patch, but there are still some problems.

1）
  (group leader, node: 0,1)
         cgroup0
         /     \
        /       \
    cgroup1   cgroup2
   (threads)  (threads)

If set node 0 in cgroup1 and node 1 in cgroup2, both of them will update
the mm. And the nodemask of mm depends on who set the node last.

2）
   (process, node: 0,1)
         cgroup0
         /     \
        /       \
    cgroup1   cgroup2
   (node: 0)  (node: 1)

If migrate thread from cgroup0 to cgroup1 or cgroup2, cpuset_attach
won't update the mm. So the nodemask of thread, including mems_allowed
and mempolicy（updated in cpuset_change_task_nodemask）, is different from
the vm_policy in vma(updated in mpol_rebind_mm).


In a word, if threads have different cpusets with different nodemask, it
will cause inconsistent memory behavior.

Thanks,
Haifeng.


