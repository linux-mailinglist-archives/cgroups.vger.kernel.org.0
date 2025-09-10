Return-Path: <cgroups+bounces-9930-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC903B51CBC
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39FD564B77
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB72B327A39;
	Wed, 10 Sep 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wXMKFYqC"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA7263C8C;
	Wed, 10 Sep 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520040; cv=none; b=rkYCmw2gRuo7BpDBXmeerKwUcOBi4LA0lT6Ug/xheQhHXbZ9Bh2mB9DLvk5H6U8pu+MUnzrYmNTH6ZyuV4zYOsFfCrkHp23UgqfFIV2w5i+oFd9s8RifCqxnUhx46e8O/b0PPEmOHcWO4Bc/Pg6iPySl0eNY8t34pKfzoJ0cW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520040; c=relaxed/simple;
	bh=Ery/m/ymaCv8Geadtsn1pePjxnemu9/a18+D5BpfCoE=;
	h=Message-ID:Date:From:To:Cc:Subject; b=sXmhtylTPaa9QSG5Z7VOEjvOqMdybDEkxVj/iDzqnLBituVkDmJok4Xk0sgjVKG5obURiLWrdzBJgmHghVUW49IOnylu7hbH+qX6jY4dNU4Ow2Ogpr3vQv/ZoZSRfnoFq/ZIk33IDgPUC7Ajl+OiJRu5Xnz8FKA0dShz8bFWlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wXMKFYqC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3nPWYVZLi4EsLuFnMP2WkL3uTXLlvWuGl/pOpk6o1Y0=; b=wXMKFYqCwbDBaEYCKw8U2RVGcy
	sOumpdb/oPdXeaWFVxJZvf5Y1LQQzuj/ouJyX5AR3+QuyAExVvGkrvaLBf5XPJbujZF5HlQ/cFLVi
	j8yvfP5X7kXxDp4cDxqvx1GOubuyx7yKZPhD57ztCp4z4gV+sJicwRqKjn5UsuG4S2+Nt26j7vVAh
	FXdAx0ACSf71n6umHd4C1U2fAbJL40aOuSs+wcQUcgqIxlLlGuoRl9LZ7DCpLBOJmMKZ3HlBgoYqq
	RrhZ6rY1jMqyikqMlUv19ifO2N4hX5FG2xIXQeU73xKVDNV2/z2m8leCMl2nERZjt2DYF00PKddhz
	EExOC+ww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFF-0000000BXos-3xjh;
	Wed, 10 Sep 2025 16:00:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 75141300342; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910154409.446470175@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 longman@redhat.com,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 cgroups@vger.kernel.org,
 sched-ext@lists.linux.dev,
 liuwenfang@honor.com,
 tglx@linutronix.de
Subject: [PATCH 00/14] sched: Support shared runqueue locking
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Hi,

As mentioned [1], a fair amount of sched ext weirdness (current and proposed)
is down to the core code not quite working right for shared runqueue stuff.

Instead of endlessly hacking around that, bite the bullet and fix it all up.

With these patches, it should be possible to clean up pick_task_scx() to not
rely on balance_scx(). Additionally it should be possible to fix that RT issue,
and the dl_server issue without further propagating lock breaks.

As is, these patches boot and run/pass selftests/sched_ext with lockdep on.

I meant to do more sched_ext cleanups, but since this has all already taken
longer than I would've liked (real life interrupted :/), I figured I should
post this as is and let TJ/Andrea poke at it.

Patches are also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup


[1] https://lkml.kernel.org/r/20250904202858.GN4068168@noisy.programming.kicks-ass.net


---
 include/linux/cleanup.h  |   5 +
 include/linux/sched.h    |   6 +-
 kernel/cgroup/cpuset.c   |   2 +-
 kernel/kthread.c         |  15 +-
 kernel/sched/core.c      | 370 +++++++++++++++++++++--------------------------
 kernel/sched/deadline.c  |  26 ++--
 kernel/sched/ext.c       | 104 +++++++------
 kernel/sched/fair.c      |  23 ++-
 kernel/sched/idle.c      |  14 +-
 kernel/sched/rt.c        |  13 +-
 kernel/sched/sched.h     | 225 ++++++++++++++++++++--------
 kernel/sched/stats.h     |   2 +-
 kernel/sched/stop_task.c |  14 +-
 kernel/sched/syscalls.c  |  80 ++++------
 14 files changed, 495 insertions(+), 404 deletions(-)


