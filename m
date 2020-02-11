Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2331590BF
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2020 14:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgBKNyv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Tue, 11 Feb 2020 08:54:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbgBKNyr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 Feb 2020 08:54:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716F8214DB;
        Tue, 11 Feb 2020 13:54:45 +0000 (UTC)
Date:   Tue, 11 Feb 2020 08:54:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [RFC] why can't dynamic isolation just like the static way
Message-ID: <20200211085443.2a112c03@gandalf.local.home>
In-Reply-To: <fed10a26-7423-23b5-316c-c74d354870dd@linux.alibaba.com>
References: <fed10a26-7423-23b5-316c-c74d354870dd@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


You forgot to include the cgroup maintainers.

-- Steve


On Tue, 11 Feb 2020 16:17:34 +0800
王贇 <yun.wang@linux.alibaba.com> wrote:

> Hi, folks
> 
> We are dealing with isolcpus these days and try to do the isolation
> dynamically.
> 
> The kernel doc lead us into the cpuset.sched_load_balance, it's fine
> to achieve the dynamic isolation with it, however we got problem with
> the systemd stuff.
> 
> It's keeping create cgroup with sched_load_balance enabled on default,
> while the cpus are overlapped with the isolated ones, which lead into
> sched domain rebuild and these cpus become non-isolated.
> 
> We're just looking forward an easy way to dynamic isolate some cpus,
> just like the isolation parameter, but sched_load_balance forcing us
> to dealing with the management of cgroups, we really don't get the
> point in here...
> 
> Why do we have to mix the isolation with cgroups? Why not just provide
> a proc entry to read cpumask and rebuild the domains?
> 
> Please let us know if there is any good reason to make the dynamic
> isolation in that way, appreciated in advance :-)
> 
> Regards,
> Michael Wang

