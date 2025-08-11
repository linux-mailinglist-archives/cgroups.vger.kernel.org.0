Return-Path: <cgroups+bounces-9069-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E482BB201EC
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 10:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85ECB16A24A
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9072DAFB1;
	Mon, 11 Aug 2025 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jYFR/GPs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8dElX3fL"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BE2DAFA5;
	Mon, 11 Aug 2025 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901387; cv=none; b=N2/Bc/hLiGRD/4t9aNC2X9bqlFfdRIbYmB4tVARyj4lRSgfZ5HarUpyBd0NFRyhAo/EDHpbwRTVVlFBiWZe1IK0unZEf4sCdIhJcVAbowtTMAIaJQC+H+hTr66bS1P1VSMxxzbnftVV6BI1wLEqSZjvH/bCneFuSKRWBl0GgCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901387; c=relaxed/simple;
	bh=qkLNx9/jdqIjH/y0D4XPJ4PH80pKsVdpf+fHeeopqHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlcAU4eOaKxT+zopzUr5DgsiHdxGJhqIGExWPpSwxPSrNjMaelpKm4zWHx7iyXVb4LiYZpseUUUcvztR8xg6MsBbRMgsnw0HHpjIv4sLGpS82Q15VX4LAGuSklDKbW3CfdNqC+Uqnd+UxD1HyhPvyz6tViMUPa08Pl8wKnDOA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jYFR/GPs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8dElX3fL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Aug 2025 10:36:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754901384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qkLNx9/jdqIjH/y0D4XPJ4PH80pKsVdpf+fHeeopqHg=;
	b=jYFR/GPsR4/ksEJy7+2EWRq50gWo0tmSllRR+SYeaS4qgZrapIqQxcqZSFuTAaMH13jNW9
	0+cNZRP+N3Z3+CkwXKgslR0fXb3Ur6AbfMRcFYWNzbgizqVOh0zQVQrxiTZvWtWaLaaeG+
	SnfBUkT+7JeMxYeOk41v9UoP/latOV7CWxA/rYxqWN3apMj+vPYdzunY0w/wrFPgfJFFh6
	cW3Np9gj719sdJ9Aa5nnUUEU7yTPhHg5qz7aJ1opuMCUgyeCgvq1xsPQOwypxs2CuKKyQy
	2UqzXmnchALRUSi+CtjCvUwa1cD+laZDT4Bx5ZbxD+U2zaIiyQgPskG/epYfEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754901384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qkLNx9/jdqIjH/y0D4XPJ4PH80pKsVdpf+fHeeopqHg=;
	b=8dElX3fL+T2gCN6B6RNrGBXGrWXMUnEFKmme9ACCcLnyFgFSY6ixcPIFjW7176RFUhTjiu
	THJg0DI862ppBvBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, will@kernel.org, boqun.feng@gmail.com,
	longman@redhat.com, clrkwllms@kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/cgroup: Lock optimize for cgroup cpu throttle
Message-ID: <20250811083622.C29-WNtR@linutronix.de>
References: <20250811070838.416176-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811070838.416176-1-jackzxcui1989@163.com>

On 2025-08-11 15:08:38 [+0800], Xin Zhao wrote:
> After enabling PREEMPT_RT, ordinary spinlocks can also be subject to cgroup
> limits during the lock-holding period. This can lead to seemingly unrelated
> threads experiencing timing dependencies due to underlying logic, such as
> memory allocation, resulting in delayed wake-up behaviors that are difficult
> to understand when analyzing traces captured by tools like Perfetto.
> Due to the prevalence of this performance issue when using cgroup CPU
> throttling with PREEMPT_RT, the CGROUP_LOCK_OPTIMIZE configuration will be
> enabled by default when both PREEMPT_RT and CFS_BANDWIDTH are activated.
> This configuration option temporarily increases the priority of tasks to
> SCHED_RR 1 if they hold a lock (excluding raw spinlocks, RCU, and seqlock)
> and are limited by cgroup, provided they are SCHED_NORMAL. Once the lock is
> released, the priority will be restored.
> This patch is a derivative of the priority inheritance patch. While priority
> inheritance can cover scenarios involving spinlocks and mutexes, it cannot
> address the timing dependency issues between two SCHED_NORMAL tasks caused
> by underlying locks. Additionally, the lazy_preempt feature does not cover
> scenarios where a real-time task, such as a ktimer, interrupts a lock-holding
> SCHED_NORMAL task, which is then throttled by cgroup cpu.
> This patch not only addresses the issue of cgroup limits affecting spinlocks
> under PREEMPT_RT but also resolves issues related to holding mutex or
> semaphore locks, as well as other core rt_mutex locks under PREEMPT_RT.
> The following stack trace illustrates the delayed wake-up behavior caused by
> two seemingly unrelated threads due to underlying logic:

urgh.

What about using task_work_add() and throttling the task on its way to
userland? The callback will be invoked without any locks held.

Sebastian

