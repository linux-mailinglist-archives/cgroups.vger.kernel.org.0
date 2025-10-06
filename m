Return-Path: <cgroups+bounces-10551-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 675FEBBDBF5
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDDFE34AA3C
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D592638B2;
	Mon,  6 Oct 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mgE9T5GE"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220F226D04;
	Mon,  6 Oct 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747560; cv=none; b=njk6QuGPtTUQCs38WgDjrbxnbb0ERYIG793Xg9yuR+bCtRV8XjDxTJxZIUakFGVSEVNC/C/5ualShQf/RvaOp0CBqZtJwCjQMyJcHk8PGQUFh+pvM7x51tQ3zXbsmUOIo7ltMxMeEw6S5wshAYZpZOHjGr8ufM4/uAjOURvgHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747560; c=relaxed/simple;
	bh=SJuqhW6HIAs1hnZxAtuHk5FOuuHiAuRz80iClowh8tE=;
	h=Message-ID:Date:From:To:Cc:Subject; b=cjKUI08Tu665wNSjb1NkJKQ7WOHeZW1dsZczxac4A1vnTq2nf0s1G2rSpGyXOfMrd/T3kLOzffs27M+70kV4dBD41HZjMGUf+qW2tBgoMm884qiqONBDSfvdgGS2/hTNHJER7if9sVE6iuDu/sWaZJG/eipNPwRWktzndLyiT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mgE9T5GE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=u8sTZhK+VFuN43OOXM4F4xgejAViSHTYmi05SwhJRFY=; b=mgE9T5GEpjTg6YF9l4Z2jR4tD6
	4fv12FJAEVPUUN9Rvp+AT8e1xdFmPNad9suhOCOZR/FrdpPTkFC7IJhaiLwK9dD2XjV3VydHov/Z2
	9TiAjKIxjp82lfbEbqXOoRiEAqRv7KVVWI7ym7TN7xxsQgtgUwMez21cnkDx9opUbntLB0OJvaq0W
	gh6+041zc+lc97W+hDzY4hoXxnANjOTenkmdYUMmRN5EK3Lg+aZD6hseEIxnesgfzMBtFpbT12cCa
	0j5PnkOmk3lmrZBlmUT/S5aHr7RsOqvnAZ7/m9+BwUcOzrFzEclYgDAo9n39QwgxdvO54ZPTfsD30
	QaHd+Ocw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5iix-00000009yaJ-0GaQ;
	Mon, 06 Oct 2025 10:45:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id BA130300212; Mon, 06 Oct 2025 12:45:47 +0200 (CEST)
Message-ID: <20251006104402.946760805@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:44:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@kernel.org,
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
Subject: [PATCH 00/12] sched: Cleanup the change-pattern and related locking
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>


Hi,

There here patches clean up the scheduler 'change' pattern and related locking
some. They are the less controversial bit of some proposed sched_ext changes
and stand on their own.

I would like to queue them into sched/core after the merge window.


Also in:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup

---
 include/linux/cleanup.h  |   5 +
 include/linux/sched.h    |   4 +-
 kernel/cgroup/cpuset.c   |   2 +-
 kernel/kthread.c         |  15 +--
 kernel/sched/core.c      | 327 ++++++++++++++++++-----------------------------
 kernel/sched/deadline.c  |  20 +--
 kernel/sched/ext.c       |  47 +++----
 kernel/sched/fair.c      |  15 ++-
 kernel/sched/idle.c      |   9 +-
 kernel/sched/rt.c        |   7 +-
 kernel/sched/sched.h     | 198 ++++++++++++++++++++--------
 kernel/sched/stats.h     |   2 +-
 kernel/sched/stop_task.c |   9 +-
 kernel/sched/syscalls.c  |  84 ++++--------
 14 files changed, 373 insertions(+), 371 deletions(-)



