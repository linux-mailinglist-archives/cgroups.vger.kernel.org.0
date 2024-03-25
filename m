Return-Path: <cgroups+bounces-2157-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B8288B6AE
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 02:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA84FB3D04F
	for <lists+cgroups@lfdr.de>; Mon, 25 Mar 2024 23:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8BD839F3;
	Mon, 25 Mar 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq4Pi4Db"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26382D76;
	Mon, 25 Mar 2024 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408904; cv=none; b=sGl5N2ynjyzZrGQBYeuSJS4mPxnQVCcInxUOWHJkfWKKqvW1oXF+Lrm91hw5p0qs9SaX1tAJSr11gZT8ly76ViGRy8gu1Gr2wm3wfBWvBiAxWsGOmX1iPAgr7I8uHcPmxMh5pSIw21njnZ5uesfxKPZYcG9GgVZoDs9ZmSWEO8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408904; c=relaxed/simple;
	bh=uE45ocbqlizhPUeGtrVHccbnWtXfuAaF9hu2gthCdsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuzEKvrZcEZ2Nw5fjULAXPlDnKd2L24g4ZtGhd4br/8pAbCqb/15fZsChkS1z8jWtdRFDcZ8MsLzBhSeVq7Q6UF/Lsqz0gkbru7OaBqIWCZQbSGIbh/aPR8BRla6kRVpSnZAJ4Vz0t4mVdffWYzSYNLoSAmOyqxcvbeXeIpMgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq4Pi4Db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA0BC433C7;
	Mon, 25 Mar 2024 23:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711408904;
	bh=uE45ocbqlizhPUeGtrVHccbnWtXfuAaF9hu2gthCdsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lq4Pi4DbOyj9mlv3h4O7boEvYbtJbDwqK/DwTKyH5yzuSceQpIsoHK1X3UlrlIbbv
	 M9SNouCM+9LUwuqM0oyQec34FtJ9Plt3FMQGiaqGv2JJZlR0KTwx8orq5EMt4d2zpm
	 Z0kVjFU9BJRKQvRm0WXGflp52AL7P32e/Oyyk2A/lHSt8Y9Ch/xbMLMu1tN+o0dpi4
	 r3Gsd3poBdWJ19bNGY9yjT7VclRDrS6O0PAneZIK7DtfTpOvHbSvF2Y1f8ALrGMxS7
	 EvOzSg/ThHGNEBwaJ4itBaUuZXrG2wtxHE52ks/MMthazWqXjUlKDaa2fANohUiFbx
	 aieAPfQHPiSLQ==
Date: Tue, 26 Mar 2024 00:21:41 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Cestmir Kalina <ckalina@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH 1/2] sched/isolation: Exclude dynamically isolated CPUs
 from housekeeping masks
Message-ID: <ZgIHBaF0gGQTKlvU@pavilion.home>
References: <20240229021414.508972-1-longman@redhat.com>
 <20240229021414.508972-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229021414.508972-2-longman@redhat.com>

Le Wed, Feb 28, 2024 at 09:14:13PM -0500, Waiman Long a écrit :
> The housekeeping CPU masks, set up by the "isolcpus" and "nohz_full"
> boot command line options, are used at boot time to exclude selected CPUs
> from running some kernel background processes to minimize disturbance
> to latency sensitive userspace applications. Some of housekeeping CPU
> masks are also checked at run time to avoid using those isolated CPUs.
> 
> The cpuset subsystem is now able to dynamically create a set of isolated
> CPUs to be used in isolated cpuset partitions. The long term goal is
> to make the degree of isolation as close as possible to what can be
> done statically using those boot command line options.
> 
> This patch is a step in that direction by making the housekeeping CPU
> mask APIs exclude the dynamically isolated CPUs when they are called
> at run time. The housekeeping CPU masks will fall back to the bootup
> default when all the dynamically isolated CPUs are released.
> 
> A new housekeeping_exlude_isolcpus() function is added which is to be
> called by the cpuset subsystem to provide a list of isolated CPUs to
> be excluded.

Can we instead overwrite housekeeping_boot.cpumasks from cpusets entirely and
forget about the original boot value forever?

Thanks.

