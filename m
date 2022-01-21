Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9A6495F2E
	for <lists+cgroups@lfdr.de>; Fri, 21 Jan 2022 13:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380428AbiAUMnS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jan 2022 07:43:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350560AbiAUMnR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jan 2022 07:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642768997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4npqjtp4XyHuyXZdSlqBznaQ1OqDTHRAdb5cB+lM/zc=;
        b=PXIn/UNnBJVjU84zryMv1X6arDqVGAVkQ5mkZBKPAj4GJOVqRnPW25ZhurHfLRA8WF0VmP
        +K+fALcOy13dirYaS5VuNWnM7aTuTLiRy0MRRq3vZhBd+4dp/nKW7bHH7JHVjzdmzF+t3y
        fjxxtDh+7JHwx6PhNyU2hXinvnP0tNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-1ueiQlrZOEm5vfO2ZKx8Qg-1; Fri, 21 Jan 2022 07:43:13 -0500
X-MC-Unique: 1ueiQlrZOEm5vfO2ZKx8Qg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B8C91006AA5;
        Fri, 21 Jan 2022 12:43:11 +0000 (UTC)
Received: from [10.22.16.178] (unknown [10.22.16.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D6697AB75;
        Fri, 21 Jan 2022 12:43:09 +0000 (UTC)
Message-ID: <a166a39f-aa9f-95af-3f3f-f4e17e7c3305@redhat.com>
Date:   Fri, 21 Jan 2022 07:43:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] cgroup/cpuset: Fix a race between cpuset_attach() and cpu
 hotplug
Content-Language: en-US
To:     Zhang Qiao <zhangqiao22@huawei.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        matthltc@us.ibm.com, bblum@google.com, menage@google.com,
        akpm@linux-foundation.org, mkoutny@suse.com, zhaogongyi@huawei.com
References: <20220121101210.84926-1-zhangqiao22@huawei.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220121101210.84926-1-zhangqiao22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/21/22 05:12, Zhang Qiao wrote:
> As previously discussed(https://lkml.org/lkml/2022/1/20/51),
> cpuset_attach() is affected with similar cpu hotplug race,
> as follow scenario:
>
>       cpuset_attach()				cpu hotplug
>      ---------------------------            ----------------------
>      down_write(cpuset_rwsem)
>      guarantee_online_cpus() // (load cpus_attach)
> 					sched_cpu_deactivate
> 					  set_cpu_active()
> 					  // will change cpu_active_mask
>      set_cpus_allowed_ptr(cpus_attach)
>        __set_cpus_allowed_ptr_locked()
>         // (if the intersection of cpus_attach and
>           cpu_active_mask is empty, will return -EINVAL)
>      up_write(cpuset_rwsem)
>
> To avoid races such as described above, protect cpuset_attach() call
> with cpu_hotplug_lock.
>
> Fixes: be367d099270 ("cgroups: let ss->can_attach and ss->attach do whole threadgroups at a time")
> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index dc653ab26e50..0af5725cc1df 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2252,6 +2252,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	cgroup_taskset_first(tset, &css);
>   	cs = css_cs(css);
>
> +	cpus_read_lock();
>   	percpu_down_write(&cpuset_rwsem);
>
>   	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
> @@ -2305,6 +2306,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   		wake_up(&cpuset_attach_wq);
>
>   	percpu_up_write(&cpuset_rwsem);
> +	cpus_read_unlock();
>   }
>
>   /* The various types of files and directories in a cpuset file system */
> --
> 2.18.0

The locking sequence looks right.

Acked-by: Waiman Long <longman@redhat.com>

