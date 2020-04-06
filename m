Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF3119F3E1
	for <lists+cgroups@lfdr.de>; Mon,  6 Apr 2020 12:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgDFKz1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Apr 2020 06:55:27 -0400
Received: from foss.arm.com ([217.140.110.172]:44210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgDFKz1 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 6 Apr 2020 06:55:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA60230E;
        Mon,  6 Apr 2020 03:55:26 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA9A83F52E;
        Mon,  6 Apr 2020 03:55:25 -0700 (PDT)
Date:   Mon, 6 Apr 2020 11:55:23 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Prateek Sood <prsood@codeaurora.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Deadlock due to "cpuset: Make cpuset hotplug synchronous"
Message-ID: <20200406105522.c66p4vzzzylety5d@e107158-lin.cambridge.arm.com>
References: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
 <20200325191922.GM162390@mtj.duckdns.org>
 <20200326101529.xh763j5frq2r7mqv@e107158-lin>
 <20200403145523.GC162390@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403145523.GC162390@mtj.duckdns.org>
User-Agent: NeoMutt/20171215
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 04/03/20 10:55, Tejun Heo wrote:
> On Thu, Mar 26, 2020 at 10:15:32AM +0000, Qais Yousef wrote:
> > On 03/25/20 15:19, Tejun Heo wrote:
> > > On Wed, Mar 25, 2020 at 03:16:56PM -0400, Qian Cai wrote:
> > > > The linux-next commit a49e4629b5ed (“cpuset: Make cpuset hotplug synchronous”)
> > > > introduced real deadlocks with CPU hotplug as showed in the lockdep splat, since it is
> > > > now making a relation from cpu_hotplug_lock —> cgroup_mutex.
> > > 
> > > Prateek, can you please take a look? Given that the merge window is just around
> > > the corner, we might have to revert and retry later if it can't be resolved
> > > quickly.
> > 
> > I've ran cpuset_hotplug and cpuhotplug LTP tests using next-20200325 but
> > couldn't reproduce it.
> > 
> > Hopefully that can be fixed, but if you had to revert it, do you mind picking
> > this instead to fix the LTP issue I encountered before?
> > 
> > 	https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/
> 
> So, I'd rather not, for now anyway. It isn't a real problem and I don't wanna
> add a wait vector there.

What would be the right approach to get a fix in then? We have been skipping
this test for a while and we'd like to enable it but this failure is a
blocking issue.

Android relies on cpuset and some devices use hotplug to manage thermal/power.
So it's an interesting combination to be able to test for us.

Thanks

--
Qais Yousef
