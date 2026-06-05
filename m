Return-Path: <cgroups+bounces-16659-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TT2sMGHFImrxdQEAu9opvQ
	(envelope-from <cgroups+bounces-16659-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 14:47:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 752656484C5
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 14:47:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=MBzANZ4B;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16659-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16659-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2FDC304673E
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A9A3C1F57;
	Fri,  5 Jun 2026 12:43:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316B639EF3D;
	Fri,  5 Jun 2026 12:43:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663417; cv=none; b=dI54VujTuN3ug58eL8ICx2NjEJ394Jzzsm1cnImABWAr1YWiuL3mgnKHq2mv25if3gjk6EYLl0JyEKUJx5Uiz4Pb3ZoodMx6odYV7gwNlCsf3B30pZtnd6UFb+Q8E7WON718pitLckIWZAAqNPcJUy1nXL4u9C8eKsvBoYYoGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663417; c=relaxed/simple;
	bh=aDIrB95KNzK7HC+Xu3E607OxvbBYLZrnOO19Y/teGeU=;
	h=Message-ID:Date:From:To:Cc:Subject; b=eChACB65WmRWMwjwIdK2JP8X8UA8pJw9GZ59T0ugnmGScRiAYrig1FCgOQR0IaQGAXmJa0UNLh++n+X6Bcb9CpmWsrI7uGeuggNAmPwyxlcFtPdzlKODASSd7Ih02rBGeJyQQYn235XsNKzepDHb5fCYzKT+UcS+1dGq3wqiP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MBzANZ4B; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Q3ny1+Vd+Cmj6V00T3SLK/5xttZKURF3PCHHpqW59ow=; b=MBzANZ4BtdMjsgPReoQ4Bvpj8o
	+cQ6JuBfjPuZ26oRrzE+6ReHApF93pF8Ylqjl+qQ71cN1YeKCfwfjUDKz9d5ypVmsD+al72TAVi3s
	S9nBkyMj+PI+fwU45rvUYJOLLWPwMsGgCgvX+4a3ujRYa7WCOaIDk687KWTMVG/2wFE6v3Fz2ZNYf
	lFwcl6uStZ+r1m35TzPxPFmgzcrgEx3xgoPzm002XDlgRzFL97Khw90io0PpM2QbSqOsycQKza7tl
	M6c/LYzlPcvjm9qJ3n7IpqNpA9e9rrn8q1hWsL4pDPPVp2fnpD2huFSgEPw1WHavSWD8//NvLRT+F
	7GRFYHGQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVTtH-00000007vak-3qhz;
	Fri, 05 Jun 2026 12:43:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 1E0B6300339; Fri, 05 Jun 2026 14:43:11 +0200 (CEST)
Message-ID: <20260605105513.354837583@infradead.org>
User-Agent: quilt/0.68
Date: Fri, 05 Jun 2026 14:40:13 +0200
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
 kprateek.nayak@amd.com,
 qyousef@layalina.io
Subject: [PATCH v3 0/7] sched: Flatten the pick
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@kernel.org,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16659-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:from_mime,infradead.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 752656484C5


Hi!

New version, same story [1]. TL;DR:

 - Adds new cgroup_mode knob and implements new policies to address the
   hierarchy level weight mismatch.

 - Builds upon that base to create a flat / single runqueue scheduler where the
   cgroup hierarchy is expressed through dynamic weight management.

I'm hoping to be able to merge these patches early in the next cycle (after
7.2-rc1).

Random benchmark:

Game vs 'for ((i=0; i<8; i++)) do nice ./spin.sh; done':

  Lutris / GE-Proton10-34 / Steam Runtime 3 (sniper)
  Intel Core i7-2600K
  AMD Radeon RX 580

  Shadows Awakening (GOG)

	  default slice(*)

  FPS min   4.0   29.0
      avg  47.5   59.2
      max  83.7   83.7

  FT  min   9.3   10.2
      avg  34.0   17.0
      max 121.2   30.0

  FPS (Frames Per Second)
  FT  (FrameTime)

  [*] Command prefix: 'chrt -o --sched-runtime 100000 0'


Changes since v2:

 - merged debug and prep patches
 - fixed update_entity_lag() on dequeue (Vincent)
 - fixed throttle vs tick (Prateek)
 - fixed wakeup_preempt_fair()
 - rebased on tip/sched/core
 - rewritten cgroup_mode changelogs
 - reworked cgroup_mode concur
 - added cgroup_mode tasks
 - changed default cgroup_mode


[1] - https://lore.kernel.org/r/20260511113104.563854162@infradead.org

Can also be had:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/flat

 include/linux/cpuset.h |    6 
 include/linux/sched.h  |    1 
 kernel/cgroup/cpuset.c |   15 
 kernel/sched/core.c    |    5 
 kernel/sched/debug.c   |   89 ++++
 kernel/sched/fair.c    |  943 ++++++++++++++++++++++++-------------------------
 kernel/sched/pelt.c    |    6 
 kernel/sched/sched.h   |   30 -
 8 files changed, 607 insertions(+), 488 deletions(-)


