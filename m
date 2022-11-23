Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16921636940
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbiKWStz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbiKWStz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:49:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE11898F8
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 10:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669229334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaE/aOdW+dlAJ1rXJX3+9BcoLCIGWukFU4WSM4KWxKA=;
        b=gGmDCNpszosK6+LzbaPPZrgYt0YBVKYkREhsC+DlV0g51u7/0p+dfsnktLmOYBseRJ8K9Z
        mKgKSByRtXZRGKhfzHh51dKWQ91+p1OlPEjeF2YEWIsxXVrxySbMfbLetISYrLUzFxgoxp
        YDDUmwblJXCLrlnXMHwYftToD9ZupjM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-m9LxdOb8OsqjXZsGFLInog-1; Wed, 23 Nov 2022 13:48:49 -0500
X-MC-Unique: m9LxdOb8OsqjXZsGFLInog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31C1A101A528;
        Wed, 23 Nov 2022 18:48:49 +0000 (UTC)
Received: from [10.22.17.47] (unknown [10.22.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3F9E1415114;
        Wed, 23 Nov 2022 18:48:48 +0000 (UTC)
Message-ID: <5fccf438-fdbe-1bc8-6460-b3911cc51566@redhat.com>
Date:   Wed, 23 Nov 2022 13:48:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] cgroup/cpuset: Optimize update_tasks_nodemask()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, "haifeng.xu" <haifeng.xu@shopee.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221123082157.71326-1-haifeng.xu@shopee.com>
 <Y35Swdpq+rJe+Tu3@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y35Swdpq+rJe+Tu3@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 11/23/22 12:05, Tejun Heo wrote:
> On Wed, Nov 23, 2022 at 08:21:57AM +0000, haifeng.xu wrote:
>> When change the 'cpuset.mems' under some cgroup, system will hung
>> for a long time. From the dmesg, many processes or theads are
>> stuck in fork/exit. The reason is show as follows.
>>
>> thread A:
>> cpuset_write_resmask /* takes cpuset_rwsem */
>>    ...
>>      update_tasks_nodemask
>>        mpol_rebind_mm /* waits mmap_lock */
>>
>> thread B:
>> worker_thread
>>    ...
>>      cpuset_migrate_mm_workfn
>>        do_migrate_pages /* takes mmap_lock */
>>
>> thread C:
>> cgroup_procs_write /* takes cgroup_mutex and cgroup_threadgroup_rwsem */
>>    ...
>>      cpuset_can_attach
>>        percpu_down_write /* waits cpuset_rwsem */
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
>> shared with group leader.
> This is only a problem in cgroup1 and cgroup1 doesn't require the threads of
> a given task to be in the same cgroup. I don't think you can optimize it
> this way.

I think it is an issue anyway if different threads of a process are in 
different cpusets with different node mask. It is not a configuration 
that should be used at all.

This patch makes update_tasks_nodemask() somewhat similar to 
cpuset_attach() where all tasks are iterated to update the node mask but 
only the task leaders are required to update the mm. For a non-group 
leader task, maybe we can check if the group leader is in the same 
cpuset. If so, we can skip the mm update. Do we need similar change in 
cpuset_attach()?

I do think the "migrate = is_memory_migrate(cs);" line can be moved 
outside of the loop, though. Of course, that won't help much in this case.

Cheers,
Longman


