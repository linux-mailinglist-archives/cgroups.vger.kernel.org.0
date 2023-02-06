Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67D468BAF0
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 12:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjBFLFv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 06:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBFLFt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 06:05:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69A0199E1;
        Mon,  6 Feb 2023 03:05:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7196160E7F;
        Mon,  6 Feb 2023 11:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539ABC433D2;
        Mon,  6 Feb 2023 11:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675681546;
        bh=3ssH3tyyX9Wb/OOZG7J5+HJgVkFrClE5hsZSLWktyNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMIa50dZ3HGJEZYNP2DN7M2vNBlXnI3ip7kSC5LkVLi2rS5u1MffbjVgbjrgO6JEj
         6jD7041iJkFWALRFMCi8CY3dVzG4NpnRIiP29SVxrMDJeESW8qLO1rjyWKoanWnYV8
         VABXRQwZlOfL27DjJjVy7oqHOEinD0/IxWZlWBxsBct0Ohpob3uF9YgK3iFCMeZJXh
         bHbQyTbmSMDe8iO/QM5QmAASCEHcw2LFxSNG9hDWHWQ3JK3mSpNnFoI1IYR7AllRE+
         MWZospnEVhToI9PYoSZK9+1vIRGjqQSTxrpJ5XaAUnSTQYMCyXsQJ+eTSrlrOBO/P3
         gO1c2xJrjlJZA==
Date:   Mon, 6 Feb 2023 11:05:41 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] cgroup/cpuset: Don't filter offline CPUs in
 cpuset_cpus_allowed() for top cpuset tasks
Message-ID: <20230206110540.GA11024@willie-the-truck>
References: <20230203164040.213437-1-longman@redhat.com>
 <Y94s8mzrE9VyUJLa@hirez.programming.kicks-ass.net>
 <f356b916-1c10-1565-73fb-34027c6c510a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f356b916-1c10-1565-73fb-34027c6c510a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Feb 05, 2023 at 12:00:25AM -0500, Waiman Long wrote:
> On 2/4/23 05:01, Peter Zijlstra wrote:
> > On Fri, Feb 03, 2023 at 11:40:40AM -0500, Waiman Long wrote:
> > > Since commit 8f9ea86fdf99 ("sched: Always preserve the user
> > > requested cpumask"), relax_compatible_cpus_allowed_ptr() is calling
> > > __sched_setaffinity() unconditionally. This helps to expose a bug in
> > > the current cpuset hotplug code where the cpumasks of the tasks in
> > > the top cpuset are not updated at all when some CPUs become online or
> > > offline. It is likely caused by the fact that some of the tasks in the
> > > top cpuset, like percpu kthreads, cannot have their cpu affinity changed.
> > > 
> > > One way to reproduce this as suggested by Peter is:
> > >   - boot machine
> > >   - offline all CPUs except one
> > >   - taskset -p ffffffff $$
> > >   - online all CPUs
> > > 
> > > Fix this by allowing cpuset_cpus_allowed() to return a wider mask that
> > > includes offline CPUs for those tasks that are in the top cpuset. For
> > > tasks not in the top cpuset, the old rule applies and only online CPUs
> > > will be returned in the mask since hotplug events will update their
> > > cpumasks accordingly.
> > So you get the task_cpu_possible_mask() interaction vs cpusets horribly
> > wrong here, but given the very sorry state of task_cpu_possible_mask()
> > correctness of cpuset as a whole that might just not matter at this
> > point.
> > 
> > I do very much hate how you add exceptions on exceptions instead of
> > looking to do something right :-(
> > 
> > Fixing that parition case in my patch is 1 extra line and then I think
> > it fundamentally does the right thing and can serve as a basis for
> > fixing cpuset as a whole.
> 
> I am not saying that your patch is incorrect other than handling the
> partition case. However, it is rather complex and is hard to understand
> especially for those that are not that familiar with the cpuset code. From
> the maintainability point of view, a simpler solution that is easier to
> understand is better.
> 
> If we want to get it into the next merge windows, there isn't much time left
> for linux-next testing. So a lower risk solution is better from that
> perspective too.

This needs to land for 6.2 to fix the regression. The next merge window is
too late. That's why I cooked the reverts [1] as an alternative.

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=ssa-reverts
