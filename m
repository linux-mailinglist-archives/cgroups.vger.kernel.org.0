Return-Path: <cgroups+bounces-14838-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPjcGVoxuWn4uAEAu9opvQ
	(envelope-from <cgroups+bounces-14838-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:47:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B642A835A
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88EC23040311
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32318372ED2;
	Tue, 17 Mar 2026 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hlQLeuql"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9850366DBE;
	Tue, 17 Mar 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744469; cv=none; b=infMRvno0u5eVlA4JAPGBctRiJHSPKqGc7wED22dcflZBPBFPWUF0ta4KwQ5J+ILfFsKAB08FFVggWSiTx3/5OClyCaNYoGSwdHRDgLxh6h7TODOEppPIJm4w9K2mIQU0Zkmn5I7PkfXjGriKVvEGooRjIMIohpXWrJubLEYvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744469; c=relaxed/simple;
	bh=LsndlaB279OGpWRX13K6Qdom0IdfuWu6lNJv94FC218=;
	h=Message-ID:Date:From:To:Cc:Subject; b=vEk2X1nlUvnTLW2jV/em81Q2BDT8b6WBK9ouchIhwsoRVJhRnHmdDcaypjnrRat8S6ZPjjcgPBOhcJ13zu42vk7kmI29irsa2kdb2zTC0oK/j/1ycYb8vJE5ozGu7VePB7Kmed9YVO1xzb/96XYW/Pd3nZzLiPE/FEPCXsY8pmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hlQLeuql; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=L2xnFUmZV99zms7V3Y+9UKAMeOJvAtaVqSk5hJw4Tsc=; b=hlQLeuqlfdNAvxSxEpcRSwRso4
	Lyx8hBRiTT7DqSi+rc2yuygWv39MByQEL6fIqnxjIXBwzmJvRgFRf/us0cSvbuH+FvADgRvC07tte
	uwVcUJJX8xZ09fZnKAwDhEyqBvEfxTV/YAXctDcVXt7nf1qtjm9zn8HptfABN7LXhqksg1UvWEYNd
	I7WKYKFOUbg0/eBWmnzrS+6qxf0uvkpW7JYfDfjJcBGQilBN877MSB933qf56YvN4ht0ftZ2kfMNK
	7pl666Si0b1V330q5qeCPmHcsj19Llyqb6Z3i7UViXesqd4TY3i2bejdHeT93eG84ymkiYfTKGfX6
	GA9XjJJw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2RxX-00000008kbp-2VC7;
	Tue, 17 Mar 2026 10:47:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 11853303244; Tue, 17 Mar 2026 11:47:35 +0100 (CET)
Message-ID: <20260317095113.387450089@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 17 Mar 2026 10:51:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: longman@redhat.com,
 chenridong@huaweicloud.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 jstultz@google.com,
 kprateek.nayak@amd.com
Subject: [RFC][PATCH 0/8] sched: Flatten the pick
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-14838-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: D3B642A835A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi!

So cgroup scheduling has always been a pain in the arse. The problems start
with weight distribution and end with hierachical picks and it all sucks.

The problems with weight distribution are related to that infernal global
fraction:

             tg->w * grq_i->w
   ge_i->w = ----------------
             \Sum_j grq_j->w

which we've approximated reasonably well by now. However, the immediate
consequence of this fraction is that the total group weight (tg->w) gets
fragmented across all your CPUs. And at 64 CPUs that means your per-cpu cgroup
weight ends up being a nice 19 task worth. And more CPUs more tiny. Combine
with the fact that 256 CPU systems are relatively common these days, this
becomes painful.

The common 'solution' is to inflate the group weight by 'nr_cpus'; the
immediate problem with that is that when all load of a group gets concentrated
on a single CPU, the per-cpu cgroup weight becomes insanely large, easily
exceeding nice -20.

Additionally there are numerical limits on the max weight you can have before
the math starts suffering overflows. As such there is a definite limit on the
total group weight. Which has annoyed people ;-)

The first few patches add a knob /debug/sched/cgroup_mode and a few different
options on how to deal with this. My favourite is 'concur', but obviously that
is also the most expensive one :-/ It adds a tg->tasks counter which makes the
update_tg_load_avg() thing more expensive.

I have some ideas but I figured I ought to share these things before sinking
more time into it.


On to the hierarchical pick; this has been causing trouble for a very long
time. So once again an attempt at flatting it. The basic idea is to keep the
full hierarchical load tracking as-is, but keep all the runnable entities in a
single level. The immediate concequence of all this is ofcourse that we need to
constantly re-compute the effective weight of each entity as things progress.

Reweight is done on:
 - enqueue
 - pick -- or rather set_next_entity(.first=true)
 - tick

So while the {en,de}queue operations are still O(depth) due to the full
accounting mess, the pick is now a single level. Removing the intermediate
levels that obscure runnability etc.


Anyway, these patches stopped crashing a few days ago and I figured it ought to
be good enough to post.

Can also be had:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/flat

---
 include/linux/cpuset.h |    6 +
 include/linux/sched.h  |    1 +
 kernel/cgroup/cpuset.c |   15 +
 kernel/sched/core.c    |   27 +-
 kernel/sched/debug.c   |  188 ++++++---
 kernel/sched/fair.c    | 1032 ++++++++++++++++++++++--------------------------
 kernel/sched/sched.h   |   20 +-
 7 files changed, 641 insertions(+), 648 deletions(-)


