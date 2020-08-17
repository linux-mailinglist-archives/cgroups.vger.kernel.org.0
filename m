Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B5C2475AE
	for <lists+cgroups@lfdr.de>; Mon, 17 Aug 2020 21:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbgHQT0a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Aug 2020 15:26:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:52068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730405AbgHQT02 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 17 Aug 2020 15:26:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EBF88B032;
        Mon, 17 Aug 2020 19:26:51 +0000 (UTC)
Date:   Mon, 17 Aug 2020 21:26:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
Message-ID: <20200817192625.GF28270@dhcp22.suse.cz>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200817152655.GE28270@dhcp22.suse.cz>
 <e66d6b5f-6f02-8c8f-681e-1d6da7a72224@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66d6b5f-6f02-8c8f-681e-1d6da7a72224@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 17-08-20 11:55:37, Waiman Long wrote:
> On 8/17/20 11:26 AM, Michal Hocko wrote:
> > On Mon 17-08-20 10:08:23, Waiman Long wrote:
> > > Memory controller can be used to control and limit the amount of
> > > physical memory used by a task. When a limit is set in "memory.high" in
> > > a v2 non-root memory cgroup, the memory controller will try to reclaim
> > > memory if the limit has been exceeded. Normally, that will be enough
> > > to keep the physical memory consumption of tasks in the memory cgroup
> > > to be around or below the "memory.high" limit.
> > > 
> > > Sometimes, memory reclaim may not be able to recover memory in a rate
> > > that can catch up to the physical memory allocation rate. In this case,
> > > the physical memory consumption will keep on increasing.  When it reaches
> > > "memory.max" for memory cgroup v2 or when the system is running out of
> > > free memory, the OOM killer will be invoked to kill some tasks to free
> > > up additional memory. However, one has little control of which tasks
> > > are going to be killed by an OOM killer. Killing tasks that hold some
> > > important resources without freeing them first can create other system
> > > problems down the road.
> > > 
> > > Users who do not want the OOM killer to be invoked to kill random
> > > tasks in an out-of-memory situation can use the memory control
> > > facility provided by this new patchset via prctl(2) to better manage
> > > the mitigation action that needs to be performed to various tasks when
> > > the specified memory limit is exceeded with memory cgroup v2 being used.
> > > 
> > > The currently supported mitigation actions include the followings:
> > > 
> > >   1) Return ENOMEM for some syscalls that allocate or handle memory
> > >   2) Slow down the process for memory reclaim to catch up
> > >   3) Send a specific signal to the task
> > >   4) Kill the task
> > > 
> > > The users that want better memory control for their applicatons can
> > > either modify their applications to call the prctl(2) syscall directly
> > > with the new memory control command code or write the desired action to
> > > the newly provided memctl procfs files of their applications provided
> > > that those applications run in a non-root v2 memory cgroup.
> > prctl is fundamentally about per-process control while cgroup (not only
> > memcg) is about group of processes interface. How do those two interact
> > together? In other words what is the semantic when different processes
> > have a different views on the same underlying memcg event?
> As said in a previous mail, this patchset is derived from a customer request
> and per-process control is exactly what the customer wants. That is why
> prctl() is used. This patchset is intended to supplement the existing memory
> cgroup features. Processes in a memory cgroup that don't use this new API
> will behave exactly like before. Only processes that opt to use this new API
> will have additional mitigation actions applied on them in case the
> additional limits are reached.

Please keep in mind that you are proposing a new user API that we will
have to maintain for ever. That requires that the interface is
consistent and well defined. As I've said the fundamental problem with
this interface is that you are trying to hammer a process centric
interface into a framework that is fundamentally process group oriented.
Maybe there is a sensible way to do that without all sorts of weird
corner cases but I haven't seen any of that explained here.

Really just try to describe a semantic when two different tasks in the
same memcg have a different opinion on the same event. One wants ENOMEM
and other a specific signal to be delivered. Right now the behavior will
be timing specific because who hits the oom path is non-deterministic
from the userspace POV. Let's say that you can somehow handle that, now
how are you going implement ENOMEM for any context other than current
task? I am pretty sure the more specific questions you will have the
more this will get awkward.
-- 
Michal Hocko
SUSE Labs
