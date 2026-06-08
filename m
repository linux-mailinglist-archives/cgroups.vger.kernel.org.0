Return-Path: <cgroups+bounces-16699-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WY5JH389JmpiTwIAu9opvQ
	(envelope-from <cgroups+bounces-16699-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 05:56:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1304B652871
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 05:56:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="I/hy1WWM";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16699-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16699-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFA133056506
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 03:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E055C34D4C9;
	Mon,  8 Jun 2026 03:43:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C8534CFC2;
	Mon,  8 Jun 2026 03:43:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780890214; cv=none; b=MrRxL2mf62CuDMBdGWo3P/P+i/dpRICGlTzbxRKwJAmz3lvPj2xSO+oj93UJCCgfqhEjs8QgYsU23SrbKofYvlJJkFoPfbIcxeoXsRcjDMYZ2zIHPHJr+bA6hoyFIRLE6rw8bwOkpU9Zt5Ep5H25RI6JEq7RTnhYvliy+0R4qaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780890214; c=relaxed/simple;
	bh=Zb2XE25uaHlK/+opsNgYdYZJXxMxNofDlF0d2ZJgiGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHknd98WT451Tv1kpBaw8Al2+4u6jbT7oguDbJjfbu/MZ5irwT1UF7T438/55okQBxmBBaB/XpA7CgeuegH4qMrHfvtlk1Uifdvd/oQr36LukRXCeTkZWLhEUpO/8DNVQa+yVrcTkVzpwvG4GhcgIgMKNNlRQD1g9uvoIRNs65U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/hy1WWM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FB51F00898;
	Mon,  8 Jun 2026 03:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780890213;
	bh=AonplpX8sMcYxl+OvnPIJmvLE6nh3WkDiHtVVORseZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I/hy1WWM0CXwiJZsze4Z95np3aJq6uUHdKzNYSVT8eFfJc8A8LFQpseaCtzOdOpAb
	 UE3j53LDXK6ypjGYSIdIPUdfqOMczpANEUCyukcBALvGj1Rv64qZTEfXBixfsMm7Yi
	 u8J+/5ib6E24hQ/VCBMxIZ6mseDM5o6Rinb3revCHCGp93zLytyucnuMiwzg16L81n
	 19aTzKCP0MxwTu9WN0iPjTe6QgC4TqCUhKVea7Cj2PeWPAKWZ2A8l2UyiQ+j3k4iX7
	 ezLRGxkEFmVWu7ajqdqTqn6E9agBUPjnj4s2qGA0uxFvxTFfkwLS6mur1TLoA8CFz5
	 V8mrh/8dkQdNQ==
From: Yu Kuai <yukuai@kernel.org>
To: nilay@linux.ibm.com,
	tom.leiming@gmail.com,
	bvanassche@acm.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai@fygo.io
Cc: akpm@linux-foundation.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] block, bfq: don't grab queue_lock to initialize bfq
Date: Mon,  8 Jun 2026 11:42:49 +0800
Message-ID: <1965073ea20f33114a8d903816b986e483b9bb34.1780621988.git.yukuai@fygo.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780621988.git.yukuai@fygo.io>
References: <cover.1780621988.git.yukuai@fygo.io>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[fygo.io:mid,fygo.io:email];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16699-lists,cgroups=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nilay@linux.ibm.com,m:tom.leiming@gmail.com,m:bvanassche@acm.org,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:yukuai@fygo.io,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:baohua@kernel.org,m:youngjun.park@lge.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:tomleiming@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,gmail.com,acm.org,kernel.org,toxicpanda.com,kernel.dk,fygo.io];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fygo.io:mid,fygo.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1304B652871
X-Spam: Yes

From: Yu Kuai <yukuai@fygo.io>

The request_queue is frozen and quiesced while the elevator init_sched()
method runs, so queue_lock is not needed for BFQ cgroup initialization.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/bfq-iosched.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 42ccfd0c6140..5cabee2d4e7c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7207,14 +7207,11 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 	bfqd = kzalloc_node(sizeof(*bfqd), GFP_KERNEL, q->node);
 	if (!bfqd)
 		return -ENOMEM;
 
 	eq->elevator_data = bfqd;
-
-	spin_lock_irq(&q->queue_lock);
 	q->elevator = eq;
-	spin_unlock_irq(&q->queue_lock);
 
 	/*
 	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
 	 * Grab a permanent reference to it, so that the normal code flow
 	 * will not attempt to free it.
@@ -7243,11 +7240,10 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 	bfqd->num_actuators = 1;
 	/*
 	 * If the disk supports multiple actuators, copy independent
 	 * access ranges from the request queue structure.
 	 */
-	spin_lock_irq(&q->queue_lock);
 	if (ia_ranges) {
 		/*
 		 * Check if the disk ia_ranges size exceeds the current bfq
 		 * actuator limit.
 		 */
@@ -7269,11 +7265,10 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 	/* Otherwise use single-actuator dev info */
 	if (bfqd->num_actuators == 1) {
 		bfqd->sector[0] = 0;
 		bfqd->nr_sectors[0] = get_capacity(q->disk);
 	}
-	spin_unlock_irq(&q->queue_lock);
 
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
 	hrtimer_setup(&bfqd->idle_slice_timer, bfq_idle_slice_timer, CLOCK_MONOTONIC,
 		      HRTIMER_MODE_REL);
-- 
2.51.0

