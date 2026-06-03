Return-Path: <cgroups+bounces-16607-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R6EtEzMwIGpoyQAAu9opvQ
	(envelope-from <cgroups+bounces-16607-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 15:46:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43603638376
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 15:46:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16607-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16607-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=fygo.io (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 026E9310CD4D
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 13:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2E543C077;
	Wed,  3 Jun 2026 13:28:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96615314D35;
	Wed,  3 Jun 2026 13:28:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493281; cv=none; b=OgrUgtejjJ++MiRmnNIAa7avareA/INDEuRfqucRzGQDI23zLbr0/JNHUE3dKf7QY155iZfV7JwWCo5Oy2hD38+A+m5ig91IEhytexVWvqkgTJe+zrClBauXjM4abc5hCi0Uh2JcYyDQrnQxEdcM+TM07qWFTaiYeFUDZWOsUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493281; c=relaxed/simple;
	bh=+bW8TuG9nbXBGA9Q8CVmvFkxaNdWjWVVyjvtj/3M5oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL5XtN4qNrmp+MlV7ph4e9wseR3Hmf/zNTHocziKds9YaKse416k5o4goS5YQqM8j30inP5iicz7NwuE6d+KIrDy/HYxFXJUWilwSHM/DSg3/KC+VtEoCBHGIhEU0dQyECmO8VrvttlyFAf2iN0VKeUL4NxVG0XnyhSDJ33repI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABF01F00899;
	Wed,  3 Jun 2026 13:27:57 +0000 (UTC)
From: Yu Kuai <yukuai@fygo.io>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] bfq: protect q->blkg_list iteration in bfq_end_wr_async() with blkcg_mutex
Date: Wed,  3 Jun 2026 21:27:42 +0800
Message-ID: <89f9448c5d703e6123e1be6c8e0550c803e9c057.1780492756.git.yukuai@fygo.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780492756.git.yukuai@fygo.io>
References: <cover.1780492756.git.yukuai@fygo.io>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[fygo.io : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16607-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,toxicpanda.com,gmail.com,linux.ibm.com,acm.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:tom.leiming@gmail.com,m:nilay@linux.ibm.com,m:bvanassche@acm.org,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tomleiming@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fygo.io:mid,fygo.io:from_mime,fygo.io:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43603638376

bfq_end_wr_async() iterates q->blkg_list while only holding bfqd->lock,
but not blkcg_mutex. This can race with blkg_free_workfn() that removes
blkgs from the list while holding blkcg_mutex.

Add blkcg_mutex protection in bfq_end_wr() before taking bfqd->lock to
ensure proper synchronization when iterating q->blkg_list.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/bfq-cgroup.c  | 3 ++-
 block/bfq-iosched.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 37ab70930c8d..f765e767d36a 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -939,11 +939,12 @@ void bfq_end_wr_async(struct bfq_data *bfqd)
 	struct blkcg_gq *blkg;
 
 	list_for_each_entry(blkg, &bfqd->queue->blkg_list, q_node) {
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
-		bfq_end_wr_async_queues(bfqd, bfqg);
+		if (bfqg)
+			bfq_end_wr_async_queues(bfqd, bfqg);
 	}
 	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
 }
 
 static int bfq_io_show_weight_legacy(struct seq_file *sf, void *v)
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 141c602d5e85..42ccfd0c6140 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2643,10 +2643,13 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
 static void bfq_end_wr(struct bfq_data *bfqd)
 {
 	struct bfq_queue *bfqq;
 	int i;
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	mutex_lock(&bfqd->queue->blkcg_mutex);
+#endif
 	spin_lock_irq(&bfqd->lock);
 
 	for (i = 0; i < bfqd->num_actuators; i++) {
 		list_for_each_entry(bfqq, &bfqd->active_list[i], bfqq_list)
 			bfq_bfqq_end_wr(bfqq);
@@ -2654,10 +2657,13 @@ static void bfq_end_wr(struct bfq_data *bfqd)
 	list_for_each_entry(bfqq, &bfqd->idle_list, bfqq_list)
 		bfq_bfqq_end_wr(bfqq);
 	bfq_end_wr_async(bfqd);
 
 	spin_unlock_irq(&bfqd->lock);
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	mutex_unlock(&bfqd->queue->blkcg_mutex);
+#endif
 }
 
 static sector_t bfq_io_struct_pos(void *io_struct, bool request)
 {
 	if (request)
-- 
2.51.0


