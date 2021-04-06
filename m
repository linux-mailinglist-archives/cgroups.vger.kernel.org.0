Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CED03557B5
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbhDFP1q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 11:27:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23172 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345641AbhDFP1q (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 6 Apr 2021 11:27:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617722858; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=N2XZ7tfCbdSWcpcPpZVDCTg9WG6BB/yssYJITFghUsM=; b=STIhAg9i+v+vHzk8xd73lt9mwuowy5g+FJIPE/XHGDUI95SrzXEXs33HqyRXOTtxBgGYk9fh
 v1Tjy7eD7pJAxYDWCAvhf2Vj4wNXWPpO++dHgAZYFSLqNxqvIxtDfs4HOr2uO5e4SaCL+KmA
 Ewx6XX0u92kje1vdj1OO3uo5NAE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3MmZiMyIsICJjZ3JvdXBzQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 606c7ddbf34440a9d49be3ec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Apr 2021 15:27:23
 GMT
Sender: pkondeti=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E34EC43462; Tue,  6 Apr 2021 15:27:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B17CC433CA;
        Tue,  6 Apr 2021 15:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B17CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 6 Apr 2021 20:57:15 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Quentin Perret <qperret@google.com>, Wei Wang <wvw@google.com>
Subject: Re: [PATCH] cgroup: Relax restrictions on kernel threads moving out
 of root cpu cgroup
Message-ID: <20210406152715.GB21941@codeaurora.org>
References: <1617714261-18111-1-git-send-email-pkondeti@codeaurora.org>
 <YGxjwKbec68sCcqo@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGxjwKbec68sCcqo@slm.duckdns.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On Tue, Apr 06, 2021 at 09:36:00AM -0400, Tejun Heo wrote:
> Hello,
> 
> On Tue, Apr 06, 2021 at 06:34:21PM +0530, Pavankumar Kondeti wrote:
> > In Android GKI, CONFIG_FAIR_GROUP_SCHED is enabled [1] to help prioritize
> > important work. Given that CPU shares of root cgroup can't be changed,
> > leaving the tasks inside root cgroup will give them higher share
> > compared to the other tasks inside important cgroups. This is mitigated
> > by moving all tasks inside root cgroup to a different cgroup after
> > Android is booted. However, there are many kernel tasks stuck in the
> > root cgroup after the boot.
> > 
> > We see all kworker threads are in the root cpu cgroup. This is because,
> > tasks with PF_NO_SETAFFINITY flag set are forbidden from cgroup migration.
> > This restriction is in place to avoid kworkers getting moved to a cpuset
> > which conflicts with kworker affinity. Relax this restriction by explicitly
> > checking if the task is moving out of a cpuset cgroup. This allows kworkers
> > to be moved out root cpu cgroup when cpu and cpuset cgroup controllers
> > are mounted on different hierarchies.
> > 
> > We also see kthreadd_task and any kernel thread created after the Android boot
> > also stuck in the root cgroup. The current code prevents kthreadd_task moving
> > out root cgroup to avoid the possibility of creating new RT kernel threads
> > inside a cgroup with no RT runtime allocated. Apply this restriction when tasks
> > are moving out of cpu cgroup under CONFIG_RT_GROUP_SCHED. This allows all
> > kernel threads to be moved out of root cpu cgroup if the kernel does not
> > enable RT group scheduling.
> 
> The fundamental reason why those kthreads are in the root cgroup is because
> they're doing work on behalf of the entire system and their resource usages
> can't be attributed to any specific cgroup. What we want to do is accounting
> actual usages to the originating cgroups so that cpu cycles spent by kswapd
> is charged to the originating cgroups, however well we can define them, and
> then throttle the origin if the consumption is going over budget for that
> cgroup's allocation. This is how we already handle shared IOs.

Thanks for your reply. I understand the reasoning on why we don't allow
kworkers to a custom cgroup.

> 
> The problem with the proposed patch is that it breaks the logical
> organization of resource hierarchy in a way which hinders proper future
> solutions.
> 
> If all you want is deprioritizing certain kworkers, please use workqueue
> attrs instead.
> 
Yeah. The workqueue attrs comes in handy to reduce the nice/prio of a
background workqueue if we identify that it is cpu intensive. However, this
needs case by case analysis, tweaking etc. If there is no other alternative,
we might end up chasing the background workers and reduce their nice value.

The problem at our hand (which you might be knowing already) is that, lets say
we have 2 cgroups in our setup and we want to prioritize UX over background.
IOW, reduce the cpu.shares of background cgroup. This helps in prioritizing
Task-A and Task-B over Task-X and Task-Y. However, each individual kworker
can potentially have CPU share equal to the entire UX cgroup.

-kworker/0:0
-kworker/1:0
- UX
----Task-A
----Task-B
- background
----Task-X
----Task-Y

Hence we want to move all kernel threads to another cgroup so that this cgroup
will have CPU share equal to UX.

The patch presented here allows us to create the above setup. Any other
alternative approaches to achieve the same without impacting any future
designs/requirements?

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

