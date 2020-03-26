Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09FC0193CC7
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2020 11:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCZKPg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Mar 2020 06:15:36 -0400
Received: from foss.arm.com ([217.140.110.172]:58676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgCZKPg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 26 Mar 2020 06:15:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEF877FA;
        Thu, 26 Mar 2020 03:15:35 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF3B13F52E;
        Thu, 26 Mar 2020 03:15:34 -0700 (PDT)
Date:   Thu, 26 Mar 2020 10:15:32 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Prateek Sood <prsood@codeaurora.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Deadlock due to "cpuset: Make cpuset hotplug synchronous"
Message-ID: <20200326101529.xh763j5frq2r7mqv@e107158-lin>
References: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
 <20200325191922.GM162390@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200325191922.GM162390@mtj.duckdns.org>
User-Agent: NeoMutt/20171215
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03/25/20 15:19, Tejun Heo wrote:
> On Wed, Mar 25, 2020 at 03:16:56PM -0400, Qian Cai wrote:
> > The linux-next commit a49e4629b5ed (“cpuset: Make cpuset hotplug synchronous”)
> > introduced real deadlocks with CPU hotplug as showed in the lockdep splat, since it is
> > now making a relation from cpu_hotplug_lock —> cgroup_mutex.
> 
> Prateek, can you please take a look? Given that the merge window is just around
> the corner, we might have to revert and retry later if it can't be resolved
> quickly.

I've ran cpuset_hotplug and cpuhotplug LTP tests using next-20200325 but
couldn't reproduce it.

Hopefully that can be fixed, but if you had to revert it, do you mind picking
this instead to fix the LTP issue I encountered before?

	https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/

Thanks!

--
Qais Yousef
