Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D56869AC
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 16:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjBAPL6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 10:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjBAPLS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 10:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6106E9B
        for <cgroups@vger.kernel.org>; Wed,  1 Feb 2023 07:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675264201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSFGQnJKj8/Bp7/utfIPR5eu4HZIdNy/TbWIaePtzGs=;
        b=TfD/0g4rfmQ9wIxUEx7j9D0NqIMTZcs7JW6mv1VS+y9VD+09BIW35/vaIrCR+dRd1GVuu9
        3/GqSoEajCjgGy4P27Avby/084qZgBojwnXFe+TNfrFiQe7YDlxAyqR0Z03I9dbF4QAGYG
        9ouGjqBQp4D7QHqAYZt6E/Cw4rmSi/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-79VmOYT6PBagsGl4iztLCA-1; Wed, 01 Feb 2023 10:03:29 -0500
X-MC-Unique: 79VmOYT6PBagsGl4iztLCA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BC3E101A55E;
        Wed,  1 Feb 2023 15:03:28 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21BA0492B06;
        Wed,  1 Feb 2023 15:03:28 +0000 (UTC)
Message-ID: <2d450978-5d7d-9a21-adf9-2fdb2bb512a5@redhat.com>
Date:   Wed, 1 Feb 2023 10:03:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] cpuset: Call set_cpus_allowed_ptr() with appropriate
 mask for task
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-3-will@kernel.org>
 <66cdf2e8-f1aa-5dfe-cd2e-0e37dc0ae799@redhat.com>
 <Y9otsg1ihF3LH2vG@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9otsg1ihF3LH2vG@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/1/23 04:15, Peter Zijlstra wrote:
> On Tue, Jan 31, 2023 at 09:22:44PM -0500, Waiman Long wrote:
>> On 1/31/23 17:17, Will Deacon wrote:
>>> set_cpus_allowed_ptr() will fail with -EINVAL if the requested
>>> affinity mask is not a subset of the task_cpu_possible_mask() for the
>>> task being updated. Consequently, on a heterogeneous system with cpusets
>>> spanning the different CPU types, updates to the cgroup hierarchy can
>>> silently fail to update task affinities when the effective affinity
>>> mask for the cpuset is expanded.
>>>
>>> For example, consider an arm64 system with 4 CPUs, where CPUs 2-3 are
>>> the only cores capable of executing 32-bit tasks. Attaching a 32-bit
>>> task to a cpuset containing CPUs 0-2 will correctly affine the task to
>>> CPU 2. Extending the cpuset to CPUs 0-3, however, will fail to extend
>>> the affinity mask of the 32-bit task because update_tasks_cpumask() will
>>> pass the full 0-3 mask to set_cpus_allowed_ptr().
>>>
>>> Extend update_tasks_cpumask() to take a temporary 'cpumask' paramater
>>> and use it to mask the 'effective_cpus' mask with the possible mask for
>>> each task being updated.
>>>
>>> Fixes: 431c69fac05b ("cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()")
>>> Signed-off-by: Will Deacon <will@kernel.org>
>>> ---
>>>
>>> Note: We wondered whether it was worth calling guarantee_online_cpus()
>>> if the cpumask_and() returns 0 in update_tasks_cpumask(), but given that
>>> this path is only called when the effective mask changes, it didn't
>>> seem appropriate. Ultimately, if you have 32-bit tasks attached to a
>>> cpuset containing only 64-bit cpus, then the affinity is going to be
>>> forced.
>> Now I see how the sched_setaffinity() change is impacting arm64. Instead of
>> putting in the bandage in cpuset. I would suggest doing another cpu masking
>> in __set_cpus_allowed_ptr() similar to what is now done for user_cpus_ptr.
> NO! cpuset is *BROKEN* it has been for a while, it needs to get fixed.
>
> Masking the offline CPUs is *WRONG*.
>
This patch is not related to offline cpus at all. It is all about the 
32-bit misfit cpus in some arm64 system.

Cheers,
Longman

