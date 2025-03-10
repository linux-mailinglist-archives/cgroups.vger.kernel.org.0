Return-Path: <cgroups+bounces-6949-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AB7A5A370
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 19:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4753F170104
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415DD233731;
	Mon, 10 Mar 2025 18:54:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB8717A2E8;
	Mon, 10 Mar 2025 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632860; cv=none; b=GIXdIeJN9qIRrntMRcJuxxiGrybiwAjWecVPjkmipMAjLSxBhjYLPJ0lR3XL9n/dqtYpATXlTkC1u7lEx/9nwq84Mf7KAkedZ64YmnPbCdoB9epIIvjEUtTahFKmTD5rJfKxB5wT+e1MI/FBruqaHdv1oOYVH5vYXs85DvUFqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632860; c=relaxed/simple;
	bh=hT3x+r+R8WhMdNfqjVdlozV1NUSgalwcbMabl58jFOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCK4O5ue8SeEvrmjJ165l1a+Jcy4JPLpuh8Zo1p7nP+w2ei++O5N/a9ZEWSxQNC8DpQS4F82m14wRkL+En/iuUAduMlloCnB7RSdTallGgDYr3vnatuYLjNxKwnNIloyHwgqmaMM+Mu5qSyatK7WcnjrYgbKeGkeOTpzUrLc+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03222152B;
	Mon, 10 Mar 2025 11:54:29 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 872983F673;
	Mon, 10 Mar 2025 11:54:14 -0700 (PDT)
Message-ID: <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
Date: Mon, 10 Mar 2025 19:54:13 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2025 10:37, Juri Lelli wrote:
> Rebuilding of root domains accounting information (total_bw) is
> currently broken on some cases, e.g. suspend/resume on aarch64. Problem

Nit: Couldn't spot any arch dependency here. I guess it was just tested
on Arm64 platforms so far.

[...]

> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 44093339761c..363ad268a25b 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>  	ndoms_cur = ndoms_new;
>  
>  	update_sched_domain_debugfs();
> +	dl_rebuild_rd_accounting();

Won't dl_rebuild_rd_accounting()'s lockdep_assert_held(&cpuset_mutex)
barf when called via cpuhp's:

sched_cpu_deactivate()

  cpuset_cpu_inactive()

    partition_sched_domains()

      partition_sched_domains_locked()

        dl_rebuild_rd_accounting()

?

[...]

