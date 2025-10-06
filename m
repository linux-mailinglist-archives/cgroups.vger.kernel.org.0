Return-Path: <cgroups+bounces-10562-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D49ABBDCFE
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99A8934BE49
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B068325DB12;
	Mon,  6 Oct 2025 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S0Lsku5G"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7D2571C7;
	Mon,  6 Oct 2025 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748229; cv=none; b=fzXQ042aHHCiHdy66sBB8bi3TpE71FdBOp+mPIuGUAkyiiHG+OlKQ3e+y4ZxNbcUNtzgarnP91JtoyhlODxy7/+r5j/9llNxXP9GAnwZDrrG/PEWl8H+HfLhpMaCW0N9qPyOogfuUG3TC29T0h1XSnUvtrxHxtM+rIaRqLh1f9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748229; c=relaxed/simple;
	bh=kJ2k/KpTlJkXpYJI7jzcETKfTErOOfbjLywn8DZJj+U=;
	h=Message-ID:Date:From:To:Cc:Subject; b=gG2laZwZzVkieXoZPVEAQ+1NMWuwiHVJo7J8rQ8Kv0N8jn0FcAIywFWf/yPtJfuL3uZpc3YFe704aKZuwH4XvKdH4AF7uCsd4XwbV4ajnet9orwrLIRcA9dr5Y5Id/y1wuvxX/yOn6dwFAzSadPP/pHl6x7GwObMna4Hl+xzIxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S0Lsku5G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=D398lCGGyukA7oL5SrUXx2HGm7W7zrqEMtIwS88ee4U=; b=S0Lsku5G4GmrlUwUUkVdbdr3G5
	7eENoBlJB4P/LxajudsDFPvwjnODS7KSBR7t2ZH6Y/E0ctMgCgvaRuXPKtbiCm7zP3tBFZCOIjRL1
	Ya2bDk7br30aOy+FO+rTEy7MQpYI7msHS4gvsMxiW9TWScjBkfXVcuY4MHLHV/RxnC1HvohwuTQfC
	sLHIlp84vyw7UcwjCua9j5oK1Q6b5tkDnBI+ZVCib3vb8dk4hPdHKv+Vfe28G5EaHH7vGUNfeVXhJ
	M3ObkS/Q0XcDGUclfljQn5O5vMTIvXa5bP+1bfxbXbPmon3tRQd02hgy6fUB9r5xOPkLw84m6YWme
	eeVkVMGA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5ito-0000000AAlN-0Z9N;
	Mon, 06 Oct 2025 10:57:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 5E6A9300289; Mon, 06 Oct 2025 12:57:00 +0200 (CEST)
Message-ID: <20251006104652.630431579@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:46:52 +0200
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
Subject: [RFC][PATCH 0/3] sched/ext: Cleanup pick_task_scx()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Hi,

So I had a poke at 'give @rf to pick_task() and fold balance_scx() into
pick_task_scx()' option to see how terrible it was. Turns out, not terrible at
all.

I've ran the sched_ext selftest and stress-ng --race-sched 0 thing with various
scx_* thingies on.

These patches were done on top of the 'sched_change' patches posted just now:

  https://lkml.kernel.org/r/20251006104402.946760805@infradead.org

The combined set is also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup-pick


---
 include/linux/sched.h    |  7 ++---
 kernel/sched/core.c      | 50 ++++++++++++++++-------------
 kernel/sched/deadline.c  | 10 +++---
 kernel/sched/ext.c       | 82 +++++++++---------------------------------------
 kernel/sched/fair.c      | 23 +++++++-------
 kernel/sched/idle.c      |  4 ++-
 kernel/sched/rt.c        |  4 ++-
 kernel/sched/sched.h     | 21 ++++++++++---
 kernel/sched/stop_task.c |  4 ++-
 9 files changed, 87 insertions(+), 118 deletions(-)



