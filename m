Return-Path: <cgroups+bounces-11416-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6813EC1DDF8
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 01:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188003A780E
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 00:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1B5148850;
	Thu, 30 Oct 2025 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHCjL+DU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8241B13D638;
	Thu, 30 Oct 2025 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783130; cv=none; b=gYd8tx0RbKjVvh8XCgt2TG5C4gURf8POdZ6a6LThi4wAmXvayZ8Vuc1ugG7pMOZXQdAsqKeWmY00zzUtBdSWZ6ggK7+EIjLkVcXvcxNPYU05SLuYU0bGK+nTheajrKXaZ4Tn8RJTn10lGFPrACs+4EdcMzr+OmVfgR5+yW9NbXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783130; c=relaxed/simple;
	bh=CIFs06lLPmCXIfcpQqnyt7p9qR7NyU2CRaj2bd9BZv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGMG6GgBEJJrmLvUQZ3L29dU54o+smqHGkuf0NhKbH8W86IYGTRPwTtCPYYWL9p1XDeJtN3E2pcx2wMYWbssX1MNusv161Ef4lmptODDXwBdJGaC41R4xif7mbO8nP0/LggCmyE9L+fwVWd46v77wfGLwlx1o/eo5XMubOdkxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHCjL+DU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20A8C4CEFF;
	Thu, 30 Oct 2025 00:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761783130;
	bh=CIFs06lLPmCXIfcpQqnyt7p9qR7NyU2CRaj2bd9BZv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHCjL+DU1FH2n1H3nFtS06p4CyJdPLUOFHW9skJN0+fzgGIln7tuEYsnmAkZBKCw1
	 wbW8Wzm4WBR1+Ok2xwP8nEAa+MPsTCJQdfGsm6l8cKnZ1odlydqAK7fJetwKQ4W8Lm
	 RRcAW6LFC27OaV6Uqd3Jvtt15E2KFs2VxPqxs2yuNnc2pNCllw9cMBBKPBLgwYUAUK
	 +CvB/YrDquwzKb91fJBv06Ww0qz6Z7NQRT0fnSKCeDuifi4TYp52JZagAgUqvuTx3Q
	 0sZG4o9UWxx91bx5NHvF5XeEJ9Fjb+t8bO87Ppy9Tufyfl92A2H++qn3CsBZcRRwLg
	 zL6XBcTKDO8Lw==
Date: Thu, 30 Oct 2025 00:12:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 07/14] sched: Fix do_set_cpus_allowed() locking
Message-ID: <29d7b92b-594e-4835-9dd3-3c9e2b02ada3@sirena.org.uk>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.103475671@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OtNgHFwufC9DIRzZ"
Content-Disposition: inline
In-Reply-To: <20250910155809.103475671@infradead.org>
X-Cookie: What PROGRAM are they watching?


--OtNgHFwufC9DIRzZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2025 at 05:44:16PM +0200, Peter Zijlstra wrote:

> All callers of do_set_cpus_allowed() only take p->pi_lock, which is
> not sufficient to actually change the cpumask. Again, this is mostly
> ok in these cases, but it results in unnecessarily complicated
> reasoning.

We're seeing lockups on some arm64 platforms in -next with the LTP
cpuhotplug02 test, the machine sits there repeatedly complaining that
RCU is stalled on IPIs:

Running tests.......
Name:   cpuhotplug02
Date:   Wed Oct 29 17:22:13 UTC 2025
Desc:   What happens to a process when its CPU is offlined?
CPU is 1
<3>[   89.915745] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
<3>[   89.922145] rcu: 	1-...0: (0 ticks this GP) idle=28f4/1/0x4000000000000000 softirq=2203/2203 fqs=195
<3>[   89.931570] rcu: 	(detected by 4, t=5256 jiffies, g=10357, q=7 ncpus=6)
<6>[   89.938465] Sending NMI from CPU 4 to CPUs 1:
<3>[   99.944589] rcu: rcu_preempt kthread starved for 2629 jiffies! g10357 f0x0 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=0
<3>[   99.955226] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
<3>[   99.964637] rcu: RCU grace-period kthread stack dump:
<6>[   99.969957] task:rcu_preempt     state:R  running task     stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00000012
<6>[   99.982871] Call trace:
<6>[   99.985582]  __switch_to+0xf0/0x1c0 (T)
<6>[   99.989702]  arch_send_call_function_single_ipi+0x30/0x3c
<6>[   99.995389]  __smp_call_single_queue+0xa0/0xb0
<6>[  100.000118]  irq_work_queue_on+0x78/0xd0
<6>[  100.004323]  rcu_watching_snap_recheck+0x304/0x350
<6>[  100.009394]  force_qs_rnp+0x1d0/0x364
<6>[  100.013330]  rcu_gp_fqs_loop+0x324/0x500
<6>[  100.017527]  rcu_gp_kthread+0x134/0x160
<6>[  100.021640]  kthread+0x12c/0x204
<6>[  100.025146]  ret_from_fork+0x10/0x20
<3>[  100.029000] rcu: Stack dump where RCU GP kthread last ran:

with the same stack trace repeating ad infinitum.  A bisect converges
fairly smoothly on this commit which looks plausible though I've not
really looked closely:

git bisect start
# status: waiting for both good and bad commits
# bad: [f9ba12abc5282bf992f9a9ae87ad814fd03a0270] Add linux-next specific files for 20251029
git bisect bad f9ba12abc5282bf992f9a9ae87ad814fd03a0270
# status: waiting for good commit(s), bad commit known
# good: [58efa7cdf77aae9e595b5f195d53d9abc37f1ecf] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect good 58efa7cdf77aae9e595b5f195d53d9abc37f1ecf
# good: [196c1d2131e9e2326e4a6a79eaa1ea54bdc90056] Merge branch 'libcrypto-next' of https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
git bisect good 196c1d2131e9e2326e4a6a79eaa1ea54bdc90056
# good: [47af99b9fa06d7207d03f53099c58ab145819c20] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git bisect good 47af99b9fa06d7207d03f53099c58ab145819c20
# bad: [53ac14eeef9a69b4e881a5cd8d56ecf054a25dc3] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
git bisect bad 53ac14eeef9a69b4e881a5cd8d56ecf054a25dc3
# good: [9ac3f65ed6bd03cc83d86c50e51caa1d223e9e76] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect good 9ac3f65ed6bd03cc83d86c50e51caa1d223e9e76
# good: [301e1f4a2740ba1f8f312412b88fb9aabe3be7ec] Merge branch into tip/master: 'objtool/core'
git bisect good 301e1f4a2740ba1f8f312412b88fb9aabe3be7ec
# bad: [cca14814f28673e48bab2f1db13db420c33a2848] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
git bisect bad cca14814f28673e48bab2f1db13db420c33a2848
# bad: [9b6f0572b2700cad5f3eaee3ca190ae960f56b80] Merge branch into tip/master: 'x86/entry'
git bisect bad 9b6f0572b2700cad5f3eaee3ca190ae960f56b80
# bad: [4c95380701f58b8112f0b891de8d160e4199e19d] sched/ext: Fold balance_scx() into pick_task_scx()
git bisect bad 4c95380701f58b8112f0b891de8d160e4199e19d
# good: [6455ad5346c9cf755fa9dda6e326c4028fb3c853] sched: Move sched_class::prio_changed() into the change pattern
git bisect good 6455ad5346c9cf755fa9dda6e326c4028fb3c853
# bad: [46a177fb01e52ec0e3f9eab9b217a0f7c8909eeb] sched: Add locking comments to sched_class methods
git bisect bad 46a177fb01e52ec0e3f9eab9b217a0f7c8909eeb
# bad: [abfc01077df66593f128d966fdad1d042facc9ac] sched: Fix do_set_cpus_allowed() locking
git bisect bad abfc01077df66593f128d966fdad1d042facc9ac
# good: [942b8db965006cf655d356162f7091a9238da94e] sched: Fix migrate_disable_switch() locking
git bisect good 942b8db965006cf655d356162f7091a9238da94e
# first bad commit: [abfc01077df66593f128d966fdad1d042facc9ac] sched: Fix do_set_cpus_allowed() locking

--OtNgHFwufC9DIRzZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkCrVEACgkQJNaLcl1U
h9DCegf+MDEXPTTzIKBlxsBjgBYvWNQLVvMkFDuqHElORfAwqQWq4B6YEBIdQByz
hE1zWBuVUMPu120s+MEW4YPJrOU4jhFy/hbRDWxuDyFzlhELZZ69ikq0bK4Kiiht
vKdaI6e0HlBe/mNVDf+7zl0utz8HNzcll86hRflpEzaTeO0oLco/z5ANC1Hi9Euj
c16sAXeU2bV3EtLz/9moY941i2yaiyBzeGFAmvFRTK7M5I02tW1F9ZM+5ZLtMbuS
8vXogQTh9HFITdrquAsCT0mv/4AmcWT8kDaMyNpfvZetZgdOvE84cIEFBrRxueIO
rV0kcuqZXFmGJHetSxn8emPi7YQqtQ==
=kGoA
-----END PGP SIGNATURE-----

--OtNgHFwufC9DIRzZ--

