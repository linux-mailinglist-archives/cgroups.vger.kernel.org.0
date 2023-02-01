Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1306862C6
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 10:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjBAJ2R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 04:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjBAJ2O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 04:28:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E3926850;
        Wed,  1 Feb 2023 01:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uBqa2qCNn8nNZNQm2RpLKt9huRiq1AbsZ1uxZ3fnKUQ=; b=glL0Vv/ZTQjmiYfBZcx+ukbuuc
        yXnYZAK1ShtCed7HXWnFNlnHecHK6mGLHx5Ozq23gL+EjAYgFaLOTvW1gQtI7NPshMX002felYenk
        Vc225vwbP4Ku+OcbQLDFJIbfHVBdPjpq801dzs/cuFiFwvZGbIUfCnAiXV0fg3w+WrzYR6xpHuj43
        s6839afKxLeZ3rnzkfH9eti0Nf/AtFeZ2nrKxpNNiqMJ9z3LL9zrODPqkl2MTFCdPQY5GsNP0PIaJ
        IiYZ+5M2cuVCHlypJQ3jd5C6lNaqTHcVEdd3QmV/elJwg/F+LwTTS1dECalWorXZT+cakGD8Vwzsa
        Z0cVAt1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pN9Ok-004iHn-1K;
        Wed, 01 Feb 2023 09:27:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E99E300472;
        Wed,  1 Feb 2023 10:27:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F10023CDCE2E; Wed,  1 Feb 2023 10:27:56 +0100 (CET)
Date:   Wed, 1 Feb 2023 10:27:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] cpuset: Call set_cpus_allowed_ptr() with appropriate
 mask for task
Message-ID: <Y9ownMtTdM6R/4tp@hirez.programming.kicks-ass.net>
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131221719.3176-3-will@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 31, 2023 at 10:17:19PM +0000, Will Deacon wrote:
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

Right, so the case above where the cpuset is shrunk to 0-1, then the
intersection between the cpuset and task_cpu_possible_mask() is empty
and it currently simply fails to update mask.

I argued it was probably desired to walk up the tree to find a wider
parent until the intersection of {cpuset, task_cpu_possible_mask,
online} becomes non-empty.

But I suppose that can wait until we have more time.

