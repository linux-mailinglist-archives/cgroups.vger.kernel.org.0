Return-Path: <cgroups+bounces-8430-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2E5ACD01C
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 01:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBB63A6B37
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 23:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CCC1A841E;
	Tue,  3 Jun 2025 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wzhjy3Yk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B43AD51;
	Tue,  3 Jun 2025 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748991833; cv=none; b=S9NjjSLEDwR3s7qQzTSrvxkZGDXZJzC3h3tacvJZDy8+eB4uHGmMBpZJmeEU2fhi5gkae2fZ1ga+6A6OiQYmjRB/UxhbROnHnQnnFfFoxcoZL6UepEUVoNlsSL1LBqHc27rzaBJNK6ffMpq6A6d3pw3sbr6SezN2Rci/+EChoIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748991833; c=relaxed/simple;
	bh=A4oj6OPfT1mxvNI32b61Y5z402+URhsCBCG9q2dcoQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+wI64GioCJFDpXvhgVYfs5mvy3+80nw3N3vKVGz/m5gMB+K+rwFcaP0htzO2zIcMhx/zZLtZub7rKSj2WLsrmQGwZ47NcPIPiOz72uLvwdZ/jyprbX/9pTI4U3RCaE5/IsiYtppGCg2LDBc+J5B8mi0BqqWGelY19Z9BWe9ZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wzhjy3Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC69C4CEED;
	Tue,  3 Jun 2025 23:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748991833;
	bh=A4oj6OPfT1mxvNI32b61Y5z402+URhsCBCG9q2dcoQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wzhjy3YkZIV3Lqppzw053X5JGMdhkCh0br5X3j5C0BhGXVtu2+c+BSP9gqA1uEFIP
	 OqGsX6ogYQcFp0Lvp83tfP2lM1xRnuYHIwcdn65/g9S90a1TJZ0K62YTwZCZ8BfcTX
	 pX44dBzKRkQGiKJXXcTCVbTmHioh+FY3ywHz2D2bmgAR5/ZnRUxLlwSy0EW4ptx46D
	 OlhAc5I2/WJWOlAnzBJECl62AaAiuqLkm8yjouz6PFOzIWjIJeORmA0PRwc3TlKn/k
	 DxwbpYOdm6eS/sT82vHyGM9Z+6e/CmEXS2AqLnStmmlRdwn1uD5iovipU6CXSj+ZiK
	 5Sh/AEMD8IKYg==
Date: Tue, 3 Jun 2025 13:03:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	kernel-team@android.com, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chen Ridong <chenridong@huawei.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH] cgroup: Track time in cgroup v2 freezer
Message-ID: <aD9_V1rSqqESFekK@slm.duckdns.org>
References: <20250603224304.3198729-3-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603224304.3198729-3-ynaffit@google.com>

On Tue, Jun 03, 2025 at 10:43:05PM +0000, Tiffany Yang wrote:
> The cgroup v2 freezer controller allows user processes to be dynamically
> added to and removed from an interruptible frozen state from
> userspace. This feature is helpful for application management, as it
> allows background tasks to be frozen to prevent them from being
> scheduled or otherwise contending with foreground tasks for resources.
> Still, applications are usually unaware of their having been placed in
> the freezer cgroup, so any watchdog timers they may have set will fire
> when they exit. To address this problem, I propose tracking the per-task
> frozen time and exposing it to userland via procfs.

Just on a glance, it feels rather odd to be tracking this per task given
that the state is per cgroup. Can you account this per cgroup?

Thanks.

-- 
tejun

