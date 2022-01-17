Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998824900D3
	for <lists+cgroups@lfdr.de>; Mon, 17 Jan 2022 05:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiAQEfJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 16 Jan 2022 23:35:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237026AbiAQEfI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 16 Jan 2022 23:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642394108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/P/ypTuhDlNT2khZtoqQnlH9KNKYs2Yo8kxciMPhnpE=;
        b=XFK8t8f1Jqex8UyCBraJUkezRKoeUWcH6vr/1VjtXZSNGRzEnc6OeM/5M2IvI/daNSGdDg
        f1KgUjs3VvGolQungn9CgzAZzH3vapLoksefPm2yKZSQoJrkd0n3qMlYl2XrVeIIrlRMCj
        UjDsC0hKvUoytiMcnb2mySg+paUyJZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-D_Zrm3McP5iX17s0LQOkIA-1; Sun, 16 Jan 2022 23:35:06 -0500
X-MC-Unique: D_Zrm3McP5iX17s0LQOkIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F498814245;
        Mon, 17 Jan 2022 04:35:04 +0000 (UTC)
Received: from [10.22.8.181] (unknown [10.22.8.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59ABC1037F42;
        Mon, 17 Jan 2022 04:35:03 +0000 (UTC)
Message-ID: <a8789e06-ebae-30f1-f592-add05df818d9@redhat.com>
Date:   Sun, 16 Jan 2022 23:35:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [Question] set_cpus_allowed_ptr() call failed at cpuset_attach()
Content-Language: en-US
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>
References: <09ce5796-798e-83d0-f1a6-ba38a787bfc5@huawei.com>
 <4415cd09-6de3-bb2d-386d-8beb4927fb46@huawei.com>
 <YeGi2yjRi/uZIF/2@slm.duckdns.org>
 <8bda2a8d-7faf-621d-c3c0-6351a49219ea@redhat.com>
 <c618f413-8b58-d1d8-3129-bb5624fc140a@huawei.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <c618f413-8b58-d1d8-3129-bb5624fc140a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/16/22 21:25, Zhang Qiao wrote:
> hello
>
> 在 2022/1/15 4:33, Waiman Long 写道:
>> On 1/14/22 11:20, Tejun Heo wrote:
>>> (cc'ing Waiman and Michal and quoting whole body)
>>>
>>> Seems sane to me but let's hear what Waiman and Michal think.
>>>
>>> On Fri, Jan 14, 2022 at 09:15:06AM +0800, Zhang Qiao wrote:
>>>> Hello everyone
>>>>
>>>>      I found the following warning log on qemu. I migrated a task from one cpuset cgroup to
>>>> another, while I also performed the cpu hotplug operation, and got following calltrace.
>>>>
>>>>      This may lead to a inconsistency between the affinity of the task and cpuset.cpus of the
>>>> dest cpuset, but this task can be successfully migrated to the dest cpuset cgroup.
>>>>
>>>>      Can we use cpus_read_lock()/cpus_read_unlock() to guarantee that set_cpus_allowed_ptr()
>>>> doesn't fail, as follows:
>>>>
>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>> index d0e163a02099..2535d23d2c51 100644
>>>> --- a/kernel/cgroup/cpuset.c
>>>> +++ b/kernel/cgroup/cpuset.c
>>>> @@ -2265,6 +2265,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>>>           guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>>>>
>>>>           cgroup_taskset_for_each(task, css, tset) {
>>>> +               cpus_read_lock();
>>>>                   if (cs != &top_cpuset)
>>>>                           guarantee_online_cpus(task, cpus_attach);
>>>>                   else
>>>> @@ -2274,6 +2275,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>>>                    * fail.  TODO: have a better way to handle failure here
>>>>                    */
>>>>                   WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
>>>> +               cpus_read_unlock();
>>>>
>>>>
>>>>      Is there a better solution?
>>>>
>>>>      Thanks
>> The change looks OK to me. However, we may need to run the full set of regression test to make sure that lockdep won't complain about potential deadlock.
>>
> I run the test with lockdep enabled, and got lockdep warning like that below.
> so we should take the cpu_hotplug_lock first, then take the cpuset_rwsem lock.
>
> thanks,
> Zhang Qiao
>
> [   38.420372] ======================================================
> [   38.421339] WARNING: possible circular locking dependency detected
> [   38.422312] 5.16.0-rc4+ #13 Not tainted
> [   38.422920] ------------------------------------------------------
> [   38.423883] bash/594 is trying to acquire lock:
> [   38.424595] ffffffff8286afc0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_attach+0xc2/0x1e0
> [   38.425880]
> [   38.425880] but task is already holding lock:
> [   38.426787] ffffffff8296a5a0 (&cpuset_rwsem){++++}-{0:0}, at: cpuset_attach+0x3e/0x1e0
> [   38.428015]
> [   38.428015] which lock already depends on the new lock.
> [   38.428015]
> [   38.429279]
> [   38.429279] the existing dependency chain (in reverse order) is:
> [   38.430445]
> [   38.430445] -> #1 (&cpuset_rwsem){++++}-{0:0}:
> [   38.431371]        percpu_down_write+0x42/0x130
> [   38.432085]        cpuset_css_online+0x2b/0x2e0
> [   38.432808]        online_css+0x24/0x80
> [   38.433411]        cgroup_apply_control_enable+0x2fa/0x330
> [   38.434273]        cgroup_mkdir+0x396/0x4c0
> [   38.434930]        kernfs_iop_mkdir+0x56/0x80
> [   38.435614]        vfs_mkdir+0xde/0x190
> [   38.436220]        do_mkdirat+0x7d/0xf0
> [   38.436824]        __x64_sys_mkdir+0x21/0x30
> [   38.437495]        do_syscall_64+0x3a/0x80
> [   38.438145]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   38.439015]
> [   38.439015] -> #0 (cpu_hotplug_lock){++++}-{0:0}:
> [   38.439980]        __lock_acquire+0x17f6/0x2260
> [   38.440691]        lock_acquire+0x277/0x320
> [   38.441347]        cpus_read_lock+0x37/0xc0
> [   38.442011]        cpuset_attach+0xc2/0x1e0
> [   38.442671]        cgroup_migrate_execute+0x3a6/0x490
> [   38.443461]        cgroup_attach_task+0x22c/0x3d0
> [   38.444197]        __cgroup1_procs_write.constprop.21+0x10d/0x170
> [   38.445145]        cgroup_file_write+0x6f/0x230
> [   38.445860]        kernfs_fop_write_iter+0x130/0x1b0
> [   38.446636]        new_sync_write+0x120/0x1b0
> [   38.447319]        vfs_write+0x359/0x3b0
> [   38.447937]        ksys_write+0xa2/0xe0
> [   38.448540]        do_syscall_64+0x3a/0x80
> [   38.449183]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   38.450057]
> [   38.450057] other info that might help us debug this:
> [   38.450057]
> [   38.451297]  Possible unsafe locking scenario:
> [   38.451297]
> [   38.452218]        CPU0                    CPU1
> [   38.452935]        ----                    ----
> [   38.453650]   lock(&cpuset_rwsem);
> [   38.454188]                                lock(cpu_hotplug_lock);
> [   38.455148]                                lock(&cpuset_rwsem);
> [   38.456069]   lock(cpu_hotplug_lock);

Yes, you need to play around with lock ordering to make sure that 
lockdep won't complain.

Cheers,
Longman

