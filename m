Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A000D68B0F6
	for <lists+cgroups@lfdr.de>; Sun,  5 Feb 2023 17:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBEQfh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Feb 2023 11:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBEQfg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Feb 2023 11:35:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB2B1E9ED
        for <cgroups@vger.kernel.org>; Sun,  5 Feb 2023 08:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675614894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d49dbf4ApQLJMnBbAxM6mEjMGR5NZUZ/1QRfKV1iQZI=;
        b=gMyT/gKu/baTS7LCegfyCT64aYotms6TX9c5DZ7OgItvMdHwhnaUc6HpMrPw7leLK1O8JB
        jd9hKSN2sS+BQAtfZt5j4uvMBi9h5vbPYMVv3LBeEmvaM+1Lb6YZPfLMKG7Wq9Ngr2AQ0N
        fm8mkHzWzgvp89Hk+VPAEA/HH2JNKiM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-oZmtmfP_PjeyRgWko74zKg-1; Sun, 05 Feb 2023 11:34:51 -0500
X-MC-Unique: oZmtmfP_PjeyRgWko74zKg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 251DA184833A;
        Sun,  5 Feb 2023 16:34:51 +0000 (UTC)
Received: from [10.22.16.38] (unknown [10.22.16.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7455D492B16;
        Sun,  5 Feb 2023 16:34:50 +0000 (UTC)
Message-ID: <a9ef4da9-828e-2370-08ed-91bbd8b8e4e5@redhat.com>
Date:   Sun, 5 Feb 2023 11:34:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] cgroup/cpuset: Don't update tasks' cpumasks for
 cpu offline events
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@android.com
References: <20230202143200.128753-1-longman@redhat.com>
 <20230202143200.128753-3-longman@redhat.com>
 <Y94oDD/8PDGqNLTH@hirez.programming.kicks-ass.net>
 <68d7c246-a678-df0c-6f54-d69725a085cc@redhat.com>
In-Reply-To: <68d7c246-a678-df0c-6f54-d69725a085cc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/4/23 23:40, Waiman Long wrote:
>
> On 2/4/23 04:40, Peter Zijlstra wrote:
>> On Thu, Feb 02, 2023 at 09:32:00AM -0500, Waiman Long wrote:
>>> It is a known issue that when a task is in a non-root v1 cpuset, a cpu
>>> offline event will cause that cpu to be lost from the task's cpumask
>>> permanently as the cpuset's cpus_allowed mask won't get back that cpu
>>> when it becomes online again. A possible workaround for this type of
>>> cpu offline/online sequence is to leave the offline cpu in the task's
>>> cpumask and do the update only if new cpus are added. It also has the
>>> benefit of reducing the overhead of a cpu offline event.
>>>
>>> Note that the scheduler is able to ignore the offline cpus and so
>>> leaving offline cpus in the cpumask won't do any harm.
>>>
>>> Now with v2, only the cpu online events will cause a call to
>>> hotplug_update_tasks() to update the tasks' cpumasks. For tasks
>>> in a non-root v1 cpuset, the situation is a bit different. The cpu
>>> offline event will not cause change to a task's cpumask. Neither does a
>>> subsequent cpu online event because "cpuset.cpus" had that offline cpu
>>> removed and its subsequent onlining won't be registered as a change
>>> to the cpuset. An exception is when all the cpus in the original
>>> "cpuset.cpus" have gone offline once. In that case, "cpuset.cpus" will
>>> become empty which will force task migration to its parent. A task's
>>> cpumask will also be changed if set_cpus_allowed_ptr() is somehow 
>>> called
>>> for whatever reason.
>>>
>>> Of course, this patch can cause a discrepancy between v1's 
>>> "cpuset.cpus"
>>> and and its tasks' cpumasks. Howver, it can also largely work around
>>> the offline cpu losing problem with v1 cpuset.
>> I don't thikn you can simply not update on offline, even if
>> effective_cpus doesn't go empty, because the intersection between
>> task_cpu_possible_mask() and effective_cpus might have gone empty.
>>
>> Very fundamentally, the introduction of task_cpu_possible_mask() means
>> that you now *HAVE* to always consider affinity settings per-task, you
>> cannot group them anymore.
>
> Right, it makes sense to me. That is why I am thinking that we should 
> have an API like may_have_task_cpu_possible_mask() that returns true 
> for heterogeneous systems. That will allow us to apply some 
> optimizations in systems with homogeneous cpus. So far, this is an 
> arm64 only feature. We shouldn't penalize other arches because arm64 
> needs that. In the future, maybe more arches will have that.

It turns out there still gaps in the handling of 
task_cpu_possible_mask() in existing cpuset code. We currently do not 
check for the returned value of set_cpus_allowed_ptr() which may fails 
in case task_cpu_possible_mask() returns a different mask. I think it 
may be too late for the upcoming merge window. I am planning to have 
that addressed in the next one.

In the case of cpu offline, one possible solution may be to move the 
task to its parent like what is done for v1 when effective_cpus becomes 
empty. In the case of cpuset.cpus update, perhaps just ignore the 
failure and print an info message about that.

Cheers,
Longman

