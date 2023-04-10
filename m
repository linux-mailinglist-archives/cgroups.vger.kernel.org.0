Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2636DC948
	for <lists+cgroups@lfdr.de>; Mon, 10 Apr 2023 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDJQ1Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Apr 2023 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjDJQ1X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Apr 2023 12:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0D8210D
        for <cgroups@vger.kernel.org>; Mon, 10 Apr 2023 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681143980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3K4izxTpeZeRb9RjlSqD5EHbDYTo8MP2lTjHdQRyzJo=;
        b=fLLlypiAdOEgziS4D6QbKHWq9QVtwwtMs0lc8xokDafzBlKAuzs/tGPBvkgMsDeIaM8PDc
        QPfR20p0nyvYQSXPgevZrgDl0midUD7Jn9r9EDImOUXdL8nUlIbTdHaToPp+z+J1hrHeWU
        pic1Z0Bm75+iQyg0WT0pSmTW0p4ggx8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-gt_EIpKkNJeGxp2tSJwrfw-1; Mon, 10 Apr 2023 12:26:16 -0400
X-MC-Unique: gt_EIpKkNJeGxp2tSJwrfw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0E1F3806627;
        Mon, 10 Apr 2023 16:26:15 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 778E0492B00;
        Mon, 10 Apr 2023 16:26:15 +0000 (UTC)
Message-ID: <0978e4c6-0af5-be68-dc8d-3b55d00ec2cd@redhat.com>
Date:   Mon, 10 Apr 2023 12:26:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] mm: oom: introduce cpuset oom
Content-Language: en-US
To:     Gang Li <ligang.bdlg@bytedance.com>, Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-kernel@vger.kernel.org
References: <20230410025056.22103-1-ligang.bdlg@bytedance.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230410025056.22103-1-ligang.bdlg@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/9/23 22:50, Gang Li wrote:
> Cpusets constrain the CPU and Memory placement of tasks.
> `CONSTRAINT_CPUSET` type in oom  has existed for a long time, but
> has never been utilized.
>
> When a process in cpuset which constrain memory placement triggers
> oom, it may kill a completely irrelevant process on other numa nodes,
> which will not release any memory for this cpuset.
>
> We can easily achieve node aware oom by using `CONSTRAINT_CPUSET` and
> selecting victim from all cpusets with the same mems_allowed as the
> current cpuset.
>
> Example:
>
> Create two processes named mem_on_node0 and mem_on_node1 constrained
> by cpusets respectively. These two processes alloc memory on their
> own node. Now node0 has run out of memory, OOM will be invokled by
> mem_on_node0.
>
> Before this patch:
>
> Since `CONSTRAINT_CPUSET` do nothing, the victim will be selected from
> the entire system. Therefore, the OOM is highly likely to kill
> mem_on_node1, which will not free any memory for mem_on_node0. This
> is a useless kill.
>
> ```
> [ 2786.519080] mem_on_node0 invoked oom-killer
> [ 2786.885738] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> [ 2787.181724] [  13432]     0 13432   787016   786745  6344704        0             0 mem_on_node1
> [ 2787.189115] [  13457]     0 13457   787002   785504  6340608        0             0 mem_on_node0
> [ 2787.216534] oom-kill:constraint=CONSTRAINT_CPUSET,nodemask=(null),cpuset=test,mems_allowed=0
> [ 2787.229991] Out of memory: Killed process 13432 (mem_on_node1)
> ```
>
> After this patch:
>
> The victim will be selected only in all cpusets that have the same
> mems_allowed as the cpuset that invoked oom. This will prevent
> useless kill and protect innocent victims.
>
> ```
> [  395.922444] mem_on_node0 invoked oom-killer
> [  396.239777] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> [  396.246128] [   2614]     0  2614  1311294  1144192  9224192        0             0 mem_on_node0
> [  396.252655] oom-kill:constraint=CONSTRAINT_CPUSET,nodemask=(null),cpuset=test,mems_allowed=0
> [  396.264068] Out of memory: Killed process 2614 (mem_on_node0)
> ```
>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Cc: <cgroups@vger.kernel.org>
> Cc: <linux-mm@kvack.org>
> Cc: <rientjes@google.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
Thanks for the update.
> ---
> Changes in v3:
> - Provide more details about the use case, testing, implementation.
> - Document the userspace visible change in Documentation.
> - Rename cpuset_cgroup_scan_tasks() to cpuset_scan_tasks() and add
>    a doctext comment about its purpose and how it should be used.
> - Take cpuset_rwsem to ensure that cpusets are stable.
>
> Changes in v2:
> - https://lore.kernel.org/all/20230404115509.14299-1-ligang.bdlg@bytedance.com/
> - Select victim from all cpusets with the same mems_allowed as the current cpuset.
>    (David Rientjes <rientjes@google.com>)
>
> v1:
> - https://lore.kernel.org/all/20220921064710.89663-1-ligang.bdlg@bytedance.com/
> - Introduce cpuset oom.
> ---
>   .../admin-guide/cgroup-v1/cpusets.rst         | 14 +++++-
>   include/linux/cpuset.h                        |  6 +++
>   kernel/cgroup/cpuset.c                        | 44 +++++++++++++++++++
>   mm/oom_kill.c                                 |  4 ++
>   4 files changed, 66 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> index 5d844ed4df69..d686cd47e91d 100644
> --- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
> +++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> @@ -25,7 +25,8 @@ Written by Simon.Derr@bull.net
>        1.6 What is memory spread ?
>        1.7 What is sched_load_balance ?
>        1.8 What is sched_relax_domain_level ?
> -     1.9 How do I use cpusets ?
> +     1.9 What is cpuset oom ?
> +     1.10 How do I use cpusets ?
>      2. Usage Examples and Syntax
>        2.1 Basic Usage
>        2.2 Adding/removing cpus
> @@ -607,8 +608,17 @@ If your situation is:
>    - The latency is required even it sacrifices cache hit rate etc.
>      then increasing 'sched_relax_domain_level' would benefit you.
>   
> +1.9 What is cpuset oom ?
> +--------------------------
> +If there is no available memory to allocate on the nodes specified by
> +cpuset.mems, then an OOM (Out-Of-Memory) will be invoked.
> +
> +Since the victim selection is a heuristic algorithm, we cannot select
> +the "perfect" victim. Therefore, currently, the victim will be selected
> +from all the cpusets that have the same mems_allowed as the cpuset
> +which invoked OOM.
Nit: That feature is not specific to cgroup v1, as it applies to v2 as 
well. Maybe you can be more specific about that.
>   
> -1.9 How do I use cpusets ?
> +1.10 How do I use cpusets ?
>   --------------------------
>   
>   In order to minimize the impact of cpusets on critical kernel
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 980b76a1237e..75465bf58f74 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -171,6 +171,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>   	task_unlock(current);
>   }
>   
> +int cpuset_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg);
> +
>   #else /* !CONFIG_CPUSETS */
>   
>   static inline bool cpusets_enabled(void) { return false; }
> @@ -287,6 +289,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>   	return false;
>   }
>   
> +static inline int cpuset_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
> +{
> +	return 0;
> +}
>   #endif /* !CONFIG_CPUSETS */
>   
>   #endif /* _LINUX_CPUSET_H */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index bc4dcfd7bee5..4c51225568aa 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4013,6 +4013,50 @@ void cpuset_print_current_mems_allowed(void)
>   	rcu_read_unlock();
>   }
>   
> +/**
> + * cpuset_scan_tasks - specify the oom scan range
> + * @fn: callback function to select oom victim
> + * @arg: argument for callback function, usually a pointer to struct oom_control
> + *
> + * Description: This function is used to specify the oom scan range. Return 0 if
> + * no task is selected, otherwise return 1. The selected task will be stored in
> + * arg->chosen. Thins function can only be called in select_bad_process()
> + * while oc->onstraint == CONSTRAINT_CPUSET.

Nit: That is not strictly correct as dump_tasks() will call this as well.

Cheers,
Longman

