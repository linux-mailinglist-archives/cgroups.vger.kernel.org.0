Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3933915BE05
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2020 12:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgBMLuV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Feb 2020 06:50:21 -0500
Received: from foss.arm.com ([217.140.110.172]:45544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMLuV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 13 Feb 2020 06:50:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A767E1FB;
        Thu, 13 Feb 2020 03:50:20 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA2403F6CF;
        Thu, 13 Feb 2020 03:50:19 -0800 (PST)
Date:   Thu, 13 Feb 2020 11:50:16 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Fix a race condition when reading cpuset.*
Message-ID: <20200213115015.hkd6uqwfjosxjfpm@e107158-lin.cambridge.arm.com>
References: <20200211141554.24181-1-qais.yousef@arm.com>
 <20200212221543.GL80993@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212221543.GL80993@mtj.thefacebook.com>
User-Agent: NeoMutt/20171215
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun

On 02/12/20 17:15, Tejun Heo wrote:
> On Tue, Feb 11, 2020 at 02:15:54PM +0000, Qais Yousef wrote:
> > LTP cpuset_hotplug_test.sh was failing with the following error message
> > 
> > 	cpuset_hotplug 1 TFAIL: root group's cpus isn't expected(Result: 0-5, Expect: 0,2-5).
> > 
> > Which is due to a race condition between cpu hotplug operation and
> > reading cpuset.cpus file.
> > 
> > When a cpu is onlined/offlined, cpuset schedules a workqueue to sync its
> > internal data structures with the new values. If a read happens during
> > this window, the user will read a stale value, hence triggering the
> > failure above.
> > 
> > To fix the issue make sure cpuset_wait_for_hotplug() is called before
> > allowing any value to be read, hence forcing the synchronization to
> > happen before the read.
> > 
> > I ran 500 iterations with this fix applied with no failure triggered.
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> 
> Hello, Qais. I just applied a patch which makes the operation
> synchronous. Can you see whether the problem is gone on the
> cgroup/for-next branch?
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next

I ran 500 iterations of cpuset_hotplug_test.sh on the branch, it passed.

I also cherry-picked commit 6426bfb1d5f0 ("cpuset: Make cpuset hotplug synchronous")
into v5.6-rc1 and ran 100 iterations and it passed too.

While investigating the problem, I could reproduce it all the way back to v5.0.
Stopped there so earlier versions could still have the problem.

Do you think it's worth porting the change to stable trees? Admittedly the
problem should be benign, but it did trigger an LTP failure.

I can check 4.19 and 4.14 stable trees (which at least in Android world are
still relevant) if you agree it makes sense to put a fix in stable.

Thanks

--
Qais Yousef
