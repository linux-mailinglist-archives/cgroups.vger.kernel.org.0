Return-Path: <cgroups+bounces-9288-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F07B2D59F
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 10:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3537A16A992
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB7286D55;
	Wed, 20 Aug 2025 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bEKilXbG"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF70626CE12;
	Wed, 20 Aug 2025 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677183; cv=none; b=LiCf6PPAjddGrZfIZkK0etyDHOzOEA/UYU+9j82l4WRxoY7v/WPg+dLaocLoLCojjgChgunquFma2YK/KPrzwuoJkp93VXsmqR+gn81pf4EXtc5opQ0cefLiNiRQ3mBAGuDffEGfpPC54yHvOtia3tMa9Gcu1Oc5JSuHGuoC42s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677183; c=relaxed/simple;
	bh=LACSANs/cXxhNwNx9i9bL5RfMtRv89Vo0GjAwicriWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HYDV4LAdKsFUppsSugNR0Y5KVol8lqBz8zJ3X7auM/BCeWYsqscv+ebB6IOeCGt8RiBdsf4IDgCuc3HKNvb0Vsw6yQlcRKWJX1rTcrHVLCAf0nUSn6EmNJUNmM+sp8CjtKg1lJuUEEVrb8P5L6aeQrq5TunQg2z4te+naSxVdvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bEKilXbG; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kX
	qtCea7zQ8Uhu8Ugt8mlqxt6yqXT08SO/KkM9oJF/o=; b=bEKilXbGOuflwEl7fW
	xCrn1viykPnPkej+hg3jFKUhLuu9rHt7ExxWN1/UWmJiD5991RHzL28D7XYmRVxN
	cMGka7b6QOjOUaa2Y+KzE5gnLP3yXLH3RYYSnfAxyaAAwWMInVBCTpuQN2wdRQC8
	ca9pO4dTCKbQb5+1TUsFV/Zk4=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3DhScgaVo_nyKDA--.32905S2;
	Wed, 20 Aug 2025 16:04:45 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com,
	longman@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/cgroup: Lock optimize for cgroup cpu throttle
Date: Wed, 20 Aug 2025 16:04:44 +0800
Message-Id: <20250820080444.2060410-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3DhScgaVo_nyKDA--.32905S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFy8Xr1xCw4ruFWDAw4Utwb_yoW5CF47pF
	ZYqrWakan8tFn7tr1xGa1vq3y8X395t3y5GFn5Gr45C3yYqrySvrs3Ka15ua4kCws3C3Wj
	vrWYvr93Ca4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jF_M3UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiJR6vCmileuyrDAAAsi

On Tue, 19 Aug 2025 13:28:52 +0200 Valentin wrote:

> What about using task_work_add() and throttling the task on its way to
> userland? The callback will be invoked without any locks held.


> > In addition to the information in my previous response to Sebastian, I would
> > like to add the following point as a reason for my self-recommendation (to
> > explore my patch for solving the cgroup performance issue in RT-Linux):
> > RT-Linux is a system that places a high emphasis on real-time performance.
> > The fact that regular tasks are also included in cgroup groups and throttled
> > suggests that they are relatively low-priority tasks that are not expected to
> > interfere with high-priority tasks. Therefore, is it not a bit too late to
> > impose limits only after returning to user mode?
> 
> Throttling is purely a CFS construct, and does not affect RT or DL
> tasks (outside of the lock contention issues we're trying to fix :-)). If
> an RT or DL task needs to run, it'll just preempt the CFS tasks, it won't
> wait for any throttle or other mechanism.


Dear Valentin,

Indeed, as you mentioned, delaying the throttle time does not affect the execution
of high-priority tasks when they want to run.

I should actually mark this as an RFC PATCH.
On one hand, it allows others using the rt-linux system who are troubled by issues
related to cgroup locking and limits to temporarily bypass these problems with my
patch.
On the other hand, I look forward experts may review the patch to see if there are
any serious or obvious issues that I may have overlooked, or if there are areas
for further improvement.


On Tue, 19 Aug 2025 15:06:56 +0200 Sebastian wrote:

> > Dear Sebastian,
> > 
> > I believe what you mentioned is related to the same issue that Valentin
> > brought up later, which is the current solution of "delaying CPU throttling
> > through the task_work mechanism until returning to user mode."
> > My colleagues and I indeed noticed this from the beginning. However, on our
> > 6.1.134 RT-Linux system, we have tried new versions of this solution one by
> > one, but they have all failed during basic script tests, so none have reached
> > the stage of being used in our project. I see that this modification has been
> > promoted in the community for more than two years, yet it remains in a state
> > that doesn't work well (on our 6.1.134 RT-Linux system). I wonder if the
> > changes require too many considerations or if this modification simply isn't
> > suitable for running on RT-Linux. Our project cannot afford to wait, and
> > there are many performance issues in RT-Linux.
> 
> You are free to use the patch.
> Based on your description I assume that the patch Valentin referenced
> will solve your problem. If not, it will be interesting to know why it
> is not working. Otherwise you keep maintaining your patch.

Dear Sebastian,

I am currently carefully reviewing the existing patches and applying them to our
current project version of rt-linux 6.1.134 to see if I can reproduce the previously
encountered issues. I will provide feedback on any problems as soon as possible.


Thanks
Xin Zhao


