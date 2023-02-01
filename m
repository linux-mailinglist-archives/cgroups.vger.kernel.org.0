Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D396862AF
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 10:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjBAJRs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 04:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBAJRp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 04:17:45 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35253CE17;
        Wed,  1 Feb 2023 01:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WedS5la9mLRqRPcpM/LzBZJMoT6FGMbFefMNcmxrjFU=; b=iS6sWdgY75YfcjKNKqBjTtQOY+
        sXREcF73H2Sm4jSIl7T0zVjrpPusC5U/Vp5hLjmEfyY+u+fG8UUdDGeQ1TZ/fFByftxzC6u6W6Rvv
        5v1yaiNsNqaCCMe893HIdplPC4WKfMn8sbD812oBPBvR3gEoG5BuR2IX3NN7GiEJc26UXqMVxz8Cd
        kXsh6dT5Q2GLUIzb3NFj+dv4Up3dmhHBFb9hA0IWScpYMEhf36zL6lSNCcW2AuFz/HxQ3UoOfLoCQ
        S08SvIY3y3ncDlIjy3F0cferhgrW3xzjddji6QBc5HrFLj4MskvM4n16BvjB60s172mYn06jq+HkD
        /Cm9U45w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pN9Ci-004i6Z-2E;
        Wed, 01 Feb 2023 09:16:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3722300129;
        Wed,  1 Feb 2023 10:15:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 953F223CDCE2E; Wed,  1 Feb 2023 10:15:30 +0100 (CET)
Date:   Wed, 1 Feb 2023 10:15:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] cpuset: Call set_cpus_allowed_ptr() with appropriate
 mask for task
Message-ID: <Y9otsg1ihF3LH2vG@hirez.programming.kicks-ass.net>
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-3-will@kernel.org>
 <66cdf2e8-f1aa-5dfe-cd2e-0e37dc0ae799@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66cdf2e8-f1aa-5dfe-cd2e-0e37dc0ae799@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 31, 2023 at 09:22:44PM -0500, Waiman Long wrote:
> On 1/31/23 17:17, Will Deacon wrote:
> > set_cpus_allowed_ptr() will fail with -EINVAL if the requested
> > affinity mask is not a subset of the task_cpu_possible_mask() for the
> > task being updated. Consequently, on a heterogeneous system with cpusets
> > spanning the different CPU types, updates to the cgroup hierarchy can
> > silently fail to update task affinities when the effective affinity
> > mask for the cpuset is expanded.
> > 
> > For example, consider an arm64 system with 4 CPUs, where CPUs 2-3 are
> > the only cores capable of executing 32-bit tasks. Attaching a 32-bit
> > task to a cpuset containing CPUs 0-2 will correctly affine the task to
> > CPU 2. Extending the cpuset to CPUs 0-3, however, will fail to extend
> > the affinity mask of the 32-bit task because update_tasks_cpumask() will
> > pass the full 0-3 mask to set_cpus_allowed_ptr().
> > 
> > Extend update_tasks_cpumask() to take a temporary 'cpumask' paramater
> > and use it to mask the 'effective_cpus' mask with the possible mask for
> > each task being updated.
> > 
> > Fixes: 431c69fac05b ("cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()")
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> > 
> > Note: We wondered whether it was worth calling guarantee_online_cpus()
> > if the cpumask_and() returns 0 in update_tasks_cpumask(), but given that
> > this path is only called when the effective mask changes, it didn't
> > seem appropriate. Ultimately, if you have 32-bit tasks attached to a
> > cpuset containing only 64-bit cpus, then the affinity is going to be
> > forced.
> 
> Now I see how the sched_setaffinity() change is impacting arm64. Instead of
> putting in the bandage in cpuset. I would suggest doing another cpu masking
> in __set_cpus_allowed_ptr() similar to what is now done for user_cpus_ptr.

NO! cpuset is *BROKEN* it has been for a while, it needs to get fixed.

Masking the offline CPUs is *WRONG*.
