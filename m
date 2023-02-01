Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65E5685D4F
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 03:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjBACXg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 21:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBACXf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 21:23:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962AB50855
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 18:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675218168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2C4BiigdKT84bDNRIWzBmLkBfIRGo6QWd2Ll/wDEDrM=;
        b=Pjh5mxwFWIvX/xkPT06+g4Ey1qrBwJ0fvc83yjRkpG/J0ZmWvadP413ZHOvyCnDjeJanin
        Gv153xfRqWFutPsagn143Q/lfsHMVKqkpuzJEe4wZpcuZirpdF8ooGzO6x/zBHmGhKGY0N
        xNfp65pIJiAFS8QfdZFKw6WpHOZObPE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-2PwwgUdlNuuiJGVcyD99RQ-1; Tue, 31 Jan 2023 21:22:45 -0500
X-MC-Unique: 2PwwgUdlNuuiJGVcyD99RQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE2773806622;
        Wed,  1 Feb 2023 02:22:44 +0000 (UTC)
Received: from [10.22.9.39] (unknown [10.22.9.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7349F492B05;
        Wed,  1 Feb 2023 02:22:44 +0000 (UTC)
Message-ID: <66cdf2e8-f1aa-5dfe-cd2e-0e37dc0ae799@redhat.com>
Date:   Tue, 31 Jan 2023 21:22:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] cpuset: Call set_cpus_allowed_ptr() with appropriate
 mask for task
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-3-will@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230131221719.3176-3-will@kernel.org>
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

On 1/31/23 17:17, Will Deacon wrote:
> set_cpus_allowed_ptr() will fail with -EINVAL if the requested
> affinity mask is not a subset of the task_cpu_possible_mask() for the
> task being updated. Consequently, on a heterogeneous system with cpusets
> spanning the different CPU types, updates to the cgroup hierarchy can
> silently fail to update task affinities when the effective affinity
> mask for the cpuset is expanded.
>
> For example, consider an arm64 system with 4 CPUs, where CPUs 2-3 are
> the only cores capable of executing 32-bit tasks. Attaching a 32-bit
> task to a cpuset containing CPUs 0-2 will correctly affine the task to
> CPU 2. Extending the cpuset to CPUs 0-3, however, will fail to extend
> the affinity mask of the 32-bit task because update_tasks_cpumask() will
> pass the full 0-3 mask to set_cpus_allowed_ptr().
>
> Extend update_tasks_cpumask() to take a temporary 'cpumask' paramater
> and use it to mask the 'effective_cpus' mask with the possible mask for
> each task being updated.
>
> Fixes: 431c69fac05b ("cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()")
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>
> Note: We wondered whether it was worth calling guarantee_online_cpus()
> if the cpumask_and() returns 0 in update_tasks_cpumask(), but given that
> this path is only called when the effective mask changes, it didn't
> seem appropriate. Ultimately, if you have 32-bit tasks attached to a
> cpuset containing only 64-bit cpus, then the affinity is going to be
> forced.

Now I see how the sched_setaffinity() change is impacting arm64. Instead 
of putting in the bandage in cpuset. I would suggest doing another cpu 
masking in __set_cpus_allowed_ptr() similar to what is now done for 
user_cpus_ptr.

Another suggestion that I have is to add a helper like 
has_task_cpu_possible_mask() that returns a true/false value. In this 
way, we only need to do an additional masking if we have some mismatched 
32-bit only cpus available in the system running 32-bit binaries so that 
we can skip this step in most cases compiling them out in non-arm64 systems.

By doing that, we may be able to remove some of the existing usages of 
task_cpu_possible_mask().

Thought?

Cheers,
Longman

