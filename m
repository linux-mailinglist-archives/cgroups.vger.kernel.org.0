Return-Path: <cgroups+bounces-10055-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F4B56398
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 00:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B967189C8C3
	for <lists+cgroups@lfdr.de>; Sat, 13 Sep 2025 22:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D3F25FA0A;
	Sat, 13 Sep 2025 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s06s7Cdc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6481D7984;
	Sat, 13 Sep 2025 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757802749; cv=none; b=jtwZdZ+sSw+7cSZXBdgAX3farg82V9nZn4w24REJFZcuYrp07+OtczSqfBFbfM0f5EE2Rx89+TvbynvGmbf1zSTB0Pjw7VW23R8EF+6oP6U/JvIxO8QzAUFW4gfwNh6qeExLM7vuWjcXcAhh4Fwc1cgZUnFvzzTyjvawH3DrcNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757802749; c=relaxed/simple;
	bh=+cx1XGB5AUqRTT31YlcTyMc4JGYSAoJbSnKDP8tEAu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PN+TQFTITC8vbzEFkey+0+Dajviro+ePlS+dPjwzA5/6s78F2Ign18Lwl2deS/AM2gwGgiGRKdDEN155+lEQv9QliF35Pkc1G7aTPDrq07YUrOhXmvn2XRF6dcQKtP/2y4erPNYpJjNFKDsUcwbtv6kKK9jx8gioxMFWPa3LauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s06s7Cdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE1FC4CEEB;
	Sat, 13 Sep 2025 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757802749;
	bh=+cx1XGB5AUqRTT31YlcTyMc4JGYSAoJbSnKDP8tEAu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s06s7CdcaszdHuwxPqGiSsBxOluZLuB1g8e04OmqX1Ip99TmI8xwE8O+/+Fw/oAIM
	 w0klN7r5vjBZxTAWPTSS8HfoioXin74uMgrDfHsovLYJ7GVNy/Kk0sTXcpRJ0ebkJ0
	 y6YRWNBx3DgFdd6EDAlZwJOUE4BlkYcl4kTZYqi4mgMvwTjljtfmVEjs0gltvMSk2U
	 yH4QszBzqC8dUhV9u+lqMY4H/d8XX+a6MhtXwsC5t/Ez/f3ZwtumzM+mM+GFw9Uafv
	 ubGqqPSSQeXAckfPhYdQffmhMxegMGSipMNqiGWEEZ4yoVZRvi8+ZtvTycMal/yqIo
	 oQe6kde9hO9hw==
Date: Sat, 13 Sep 2025 12:32:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 13/14] sched: Add {DE,EN}QUEUE_LOCKED
Message-ID: <aMXw-xvmGIZ9-UFJ@slm.duckdns.org>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.800554594@infradead.org>
 <aMItk3c5H6Z2CD4X@slm.duckdns.org>
 <20250911094240.GW3289052@noisy.programming.kicks-ass.net>
 <aMMzpnyx__ZgZGRc@slm.duckdns.org>
 <20250912141904.GA3289052@noisy.programming.kicks-ass.net>
 <aMRLIEtmcWc0XNmg@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMRLIEtmcWc0XNmg@slm.duckdns.org>

Hello,

On Fri, Sep 12, 2025 at 06:32:32AM -1000, Tejun Heo wrote:
> Yeah, or I can make scx_tasks iteration smarter so that it can skip through
> the list for tasks which aren't runnable. As long as it doesn't do lock ops
> on every task, it should be fine. I think this is solvable one way or
> another. Let's continue in the other subthread.

Thought more about it. There's another use case for this runnable list,
which is the watchdog. As in the migration synchronization, I think the
right thing to do here is just adding a nested lock. That doesn't add any
overhead or complications to other sched classes and from sched_ext POV
given how expensive migrations can be, if we make that a bit cheaper (and I
believe we will with changes being discussed), added up, the outcome would
likely be lower overhead.

Thanks.

-- 
tejun

