Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2CD68A93E
	for <lists+cgroups@lfdr.de>; Sat,  4 Feb 2023 10:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjBDJku (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 4 Feb 2023 04:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBDJkt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 4 Feb 2023 04:40:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAFB2E0D5;
        Sat,  4 Feb 2023 01:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NTZ9jPw8WP52KfsFuE2yWYqe1gYLvZrsudm7m6D0hLA=; b=iaOzaaQ0nfwjJY/vgdhOCngjE+
        kGcKMzQGhg3hRO+bSa//sMUGBtSEKmJRUmsXiBfQBRr2snQtNER4Ilnu+Vb/n5rUKhTzIc8HyRwfe
        tWPMJLs245/42xaqzBWiBH8n2ef6gP1/uu2whT71u0wugElh7cm+f1MdrOOjRJ1uTq2zObszcVHQZ
        tBHBmqN9rhK2TEbWMhN8SVUt9gmV+lXAyoUPosHGvdm8UapZtC7ouV9XHKUFBmx6TMRdLa6iG+O5s
        HSYCZMOP6Yt8bud4YGiia5+fBP82MKShAywaHKOtfGMyqSm6CN0ov+464F+mkB42jHNMB7ZhnyMHD
        UD3jBAxA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOF26-00F4h0-3A; Sat, 04 Feb 2023 09:40:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DCCB9300652;
        Sat,  4 Feb 2023 10:40:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2D5B2C7EB2D0; Sat,  4 Feb 2023 10:40:28 +0100 (CET)
Date:   Sat, 4 Feb 2023 10:40:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/2] cgroup/cpuset: Don't update tasks' cpumasks for
 cpu offline events
Message-ID: <Y94oDD/8PDGqNLTH@hirez.programming.kicks-ass.net>
References: <20230202143200.128753-1-longman@redhat.com>
 <20230202143200.128753-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202143200.128753-3-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 02, 2023 at 09:32:00AM -0500, Waiman Long wrote:
> It is a known issue that when a task is in a non-root v1 cpuset, a cpu
> offline event will cause that cpu to be lost from the task's cpumask
> permanently as the cpuset's cpus_allowed mask won't get back that cpu
> when it becomes online again. A possible workaround for this type of
> cpu offline/online sequence is to leave the offline cpu in the task's
> cpumask and do the update only if new cpus are added. It also has the
> benefit of reducing the overhead of a cpu offline event.
> 
> Note that the scheduler is able to ignore the offline cpus and so
> leaving offline cpus in the cpumask won't do any harm.
> 
> Now with v2, only the cpu online events will cause a call to
> hotplug_update_tasks() to update the tasks' cpumasks. For tasks
> in a non-root v1 cpuset, the situation is a bit different. The cpu
> offline event will not cause change to a task's cpumask. Neither does a
> subsequent cpu online event because "cpuset.cpus" had that offline cpu
> removed and its subsequent onlining won't be registered as a change
> to the cpuset. An exception is when all the cpus in the original
> "cpuset.cpus" have gone offline once. In that case, "cpuset.cpus" will
> become empty which will force task migration to its parent. A task's
> cpumask will also be changed if set_cpus_allowed_ptr() is somehow called
> for whatever reason.
> 
> Of course, this patch can cause a discrepancy between v1's "cpuset.cpus"
> and and its tasks' cpumasks. Howver, it can also largely work around
> the offline cpu losing problem with v1 cpuset.

I don't thikn you can simply not update on offline, even if
effective_cpus doesn't go empty, because the intersection between
task_cpu_possible_mask() and effective_cpus might have gone empty.

Very fundamentally, the introduction of task_cpu_possible_mask() means
that you now *HAVE* to always consider affinity settings per-task, you
cannot group them anymore.


