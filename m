Return-Path: <cgroups+bounces-6635-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042D0A3F799
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 15:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE7F189A026
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416EC20F09A;
	Fri, 21 Feb 2025 14:45:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05D513B787;
	Fri, 21 Feb 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149114; cv=none; b=Jj94YvKAypqr+TLkgC36vCLb7ZNARTnzEtP4F+6sAgf0F90UG7/HAIA9eChl1OezO75+bqjjfGkO1erjz8cdUOwu5bfta8y6A2HYAujJMMLrYaAxmZEaaO5ONvamFbq0F4Bmn30OmZYQ7qRhv6KP+hCzBXBk41IMOGejQ03oXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149114; c=relaxed/simple;
	bh=R7JS7jIZcjDSPrwz8G0a0Y/N00Su0rg91ouIBSJPJcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLQ5/jmBwldG/MKPadHk1JVKpXQOCoZjm5LAVFecvMiYP4gpQIdyYe2wdYjB4BKll5Oo5EfJo3mncwSOlMSkw5cHZnAEIlZP7F9Xh2+IVUxdd9IGeGdlpl0ezb5mlYF2twT5y7v/SVxk4bEZmvlpXzV/1H0WXgRz8KuvOjcSZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5183A106F;
	Fri, 21 Feb 2025 06:45:27 -0800 (PST)
Received: from [192.168.2.132] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E84843F5A1;
	Fri, 21 Feb 2025 06:45:04 -0800 (PST)
Message-ID: <d5162d16-e9fd-408f-9bc5-68748e4b1f87@arm.com>
Date: Fri, 21 Feb 2025 15:45:03 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Jon Hunter <jonathanh@nvidia.com>, Juri Lelli <juri.lelli@redhat.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
 <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>
 <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
 <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>
 <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
 <4c045707-6f5a-44fd-b2d1-3ad13c2b11ba@arm.com>
 <537f2207-b46b-4a5e-884c-d6b42f56cb02@arm.com>
 <Z7cGrlXp97y_OOfY@jlelli-thinkpadt14gen4.remote.csb>
 <Z7dJe7XfG0e6ECwr@jlelli-thinkpadt14gen4.remote.csb>
 <1c75682e-a720-4bd0-8bcc-5443b598457f@nvidia.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <1c75682e-a720-4bd0-8bcc-5443b598457f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/02/2025 12:56, Jon Hunter wrote:
> 
> On 20/02/2025 15:25, Juri Lelli wrote:
>> On 20/02/25 11:40, Juri Lelli wrote:
>>> On 19/02/25 19:14, Dietmar Eggemann wrote:

[...]

> Latest branch is not building for me ...
> 
>   CC      kernel/time/hrtimer.o
> In file included from kernel/sched/build_utility.c:88:
> kernel/sched/topology.c: In function ‘partition_sched_domains’:
> kernel/sched/topology.c:2817:9: error: implicit declaration of function
> ‘dl_rebuild_rd_accounting’ [-Werror=implicit-function-declaration]
>  2817 |         dl_rebuild_rd_accounting();
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~

This should fix it for now:

-->8--

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52243dcc61ab..3484dda93a94 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -954,7 +954,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
        css_task_iter_end(&it);
 }
 
-static void dl_rebuild_rd_accounting(void)
+extern void dl_rebuild_rd_accounting(void);
+
+void dl_rebuild_rd_accounting(void)
 {
        struct cpuset *cs = NULL;
        struct cgroup_subsys_state *pos_css;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9892e6fa3e57..60c9996ccf47 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2806,6 +2806,8 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
        update_sched_domain_debugfs();
 }
 
+extern void dl_rebuild_rd_accounting(void);
+
 /*
  * Call with hotplug lock held
  */


