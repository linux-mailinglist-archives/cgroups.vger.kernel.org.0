Return-Path: <cgroups+bounces-7100-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20415A645C7
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 09:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A5E16A22B
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 08:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D4821D5B4;
	Mon, 17 Mar 2025 08:39:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0750D191499;
	Mon, 17 Mar 2025 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200766; cv=none; b=lEFm/tqhVO4rgkBlpR9Jvehd1fDrJmm7cz0ZQHApeIrgJkb24J1x7BcgdYydrOAGTmH9NBQYvfK0Z8wtNikK4VXAvISXTAlDyfV+w+MNJtzAhqxg4UyJ8HEXBdPru4iY0B0ySmH9z55wV4HRgkdEBoRLKkhKJq6bpEuBn1yJSaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200766; c=relaxed/simple;
	bh=+5XmRgA4GrGrjVNj2D9ijBICElrzdke1udcBi+zTG/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgyktdl6/vh9qxKrugCtw0opDLdT0HPjQlKpVbGl+tnmKdojl239r2g3IqhfW7ykm/RptpP30sWS7+e3QRhQbCYBMUNR+NIhn2IxBW5c3Wzvr77PFoqbUv2SrzYFFKuepuUEfFgVU4ltShzN7AMGjSsupSSmTZR6BLgT24qixjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C79613D5;
	Mon, 17 Mar 2025 01:39:32 -0700 (PDT)
Received: from [172.18.154.215] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 761D73F673;
	Mon, 17 Mar 2025 01:39:16 -0700 (PDT)
Message-ID: <92a9cb8f-761a-4cc6-82f9-ea66aeecddfe@arm.com>
Date: Mon, 17 Mar 2025 09:39:04 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
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
References: <20250313170011.357208-1-juri.lelli@redhat.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20250313170011.357208-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2025 18:00, Juri Lelli wrote:
> Hello!
> 
> Jon reported [1] a suspend regression on a Tegra board configured to
> boot with isolcpus and bisected it to commit 53916d5fd3c0
> ("sched/deadline: Check bandwidth overflow earlier for hotplug").
> 
> Root cause analysis pointed out that we are currently failing to
> correctly clear and restore bandwidth accounting on root domains after
> changes that initiate from partition_sched_domains(), as it is the case
> for suspend operations on that board.
> 
> This is v4 [2] of the proposed approach to fix the issue. With respect
> to v3 only patch 04 has changed as I have added the wrappers Waiman
> created to make sure we always call partition_sched_domains() while
> holding cpuset_mutex (issue pointed out by Dietmar on v3).
> 
> Dietmar also pointed out that the issue at hand is not fixed by this set
> for !CONFIG_CPUSETS configuration. But, given the fact that bandwidth
> accounting has been broken for such configuration so far (sigh) and that
> the vast majority (if not all) distributions have CPUSETS enabled, we
> decided to leave fixing the remaining issue for later. I will soon try
> to find time to keep looking into it.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Testcase: suspend/resume

on Arm64 big.LITTLE cpumask=[LITTLE][big]=[0,3-5][1-2]
plus cmd line option 'isolcpus=3,4'.

