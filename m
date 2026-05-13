Return-Path: <cgroups+bounces-15888-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO1lDltiBGq6HgIAu9opvQ
	(envelope-from <cgroups+bounces-15888-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 13:36:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE749532603
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 13:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A60AE308D18D
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 11:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CC93FE357;
	Wed, 13 May 2026 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K3Yjqy5u"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4FF3A6403;
	Wed, 13 May 2026 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672141; cv=none; b=JXYHYy3fEq464hDadPun7NcpKe0U2phmqyY9HBUyl+X5IEfXZanuKtEh+m6KfDb1zD8TbBhMu+NfcMAcDfIuxjSs7n48QT/a2SQvpBRjMObJvN3UNrRa5bGVIHESfv1XGGWEDAL4oknuiqIn8hMtfPMmC5UGZzXVei4DY3wG68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672141; c=relaxed/simple;
	bh=wYfaGw3jnHUOhqZLBYPdMUGhcpYlXQqdttNkTvWquCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioYF3pVtobTHmeAz/n8gdj4s99ARjOidykFtI0Ckg3R043cKy//CPCI61WU/hJNXLi0elUrZr62fSDChmHpW1x8I+BiGflvxhOoJ73G3+zI6yzl1MB2Puv/ugkkrkDA+eFSwvWX/N4p4IoiI0m1WYxTT6i/B2UygfmfEuuTgTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K3Yjqy5u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WnA7BP+4e8CVqEwTNfcvwk1IqFPZ3MS3560LBe6L7lg=; b=K3Yjqy5uxRKSFs36qX4AknDwR7
	+iMPq8WSDvuzRn22O6Efga/GWOmhRXwW9Ima21x4RxkH89CawlAzBxXc2YsIKnACYarF3JNq78Y2B
	+WMixFVpYP8bSH/aDBSAaXzCy2vJOv22vDTMEbxohXIk+QgWW7bXqBn+SUl33npvtasx8bwlMnte9
	0b+HOgg5aX4Me5mimb4MH9iJ+APc+FzFLJy2qijWCh9SsmFscvEeKTfkABBIHsSrMpQPdYhK1uc9p
	58yB5mZ8a4m5aKsstz0X1YPCGtsscTN/i7PmwvvtHu3IZB1McBw4nh8HDZ/8EqByuNzDqBdsXICfm
	mEBklfJQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN7rs-0000000BYT3-1IYO;
	Wed, 13 May 2026 11:35:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EFE3B3004C9; Wed, 13 May 2026 13:35:10 +0200 (CEST)
Date: Wed, 13 May 2026 13:35:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com, qyousef@layalina.io
Subject: Re: [PATCH v2 00/10] sched: Flatten the pick
Message-ID: <20260513113510.GK1889694@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <CAKfTPtA2aBtuBffVV02VgsRRi5mRK0G5ununzuvJ7h7buygNxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA2aBtuBffVV02VgsRRi5mRK0G5ununzuvJ7h7buygNxg@mail.gmail.com>
X-Rspamd-Queue-Id: AE749532603
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15888-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 10:42:33AM +0200, Vincent Guittot wrote:

> I haven't reviewed the patches yet but I ran some tests with it while
> testing sched latency related changes for short slice wakeup
> preemption. I have some large hackbench regressions with this series
> on HMP system with and without EAS. those figures are unexpected
> because the benchs run on root cfs
> 
> One example with hackbench 8 groups thread pipe
> tip/sched/core  tip/sched/core          +this patchset          +this patchset
> slice 2.8ms     16ms                    2.8ms                   16ms
> dragonboard rb5 with EAS
> 0,748(+/-4,6%)  0,621(+/-3.6%) +17%     1,915(+/-7.9%) -156%
> 0,689(+/- 9.1%) +8%
> 
> radxa orion6 HMP without EAS
> 0,588(+/-5.8%)  0,677(+/-5.9%) -15%     1,505(+/-10%) -156%
> 1,071(+/-5.9%) -82%
> 
> Increasing the slice partly removes regressions but tis is surprising
> because the bench runs at root cfs and I thought that results will not
> change in such a case

D'oh :/

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e54da4c6c945..77d0e1937f2c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9071,7 +9071,7 @@ static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_f
 	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_PICK;
 	struct task_struct *donor = rq->donor;
 	struct sched_entity *nse, *se = &donor->se, *pse = &p->se;
-	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
+	struct cfs_rq *cfs_rq = &rq->cfs;
 	int cse_is_idle, pse_is_idle;
 
 	/*

