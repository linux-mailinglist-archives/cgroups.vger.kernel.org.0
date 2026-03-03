Return-Path: <cgroups+bounces-14562-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF9aBpPspmmQaAAAu9opvQ
	(envelope-from <cgroups+bounces-14562-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 15:13:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C43611F12E3
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 15:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAE65304D56C
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF973BED07;
	Tue,  3 Mar 2026 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GSbjRNaI"
X-Original-To: cgroups@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244B362121;
	Tue,  3 Mar 2026 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547097; cv=none; b=Ka3io60gXCV0cloMsWmaNPyMgTG4iBehSPSF0OPjXQIxdqrKuffTN3cx5HEC9ya0jmqASkQfwF9GRHHGYXDJ9Fqkha1mYJwCUnF7aojmLxpzIdNDRXaquxCO2B8vW9zOWUejHn5lYZcj26BdvzhTaELFC3fkshmJvpdBrO/g6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547097; c=relaxed/simple;
	bh=gRb5Q9YI+ym8+95kKkS+hRTOyMkhQ5+z/S0MPFREgQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sN8+5pj3CvPFaOCkz8zCyV+ppT5rTReht2rcczZPW/Jf0dQWn+TUZUuh7itO2ReUVfrcS0MphHRqEJZJba4fgN7qeKDUrIne9cUeKlLj0eka/2B0gYLjWG0h3phbHwJicTo2qRKnJrhq+Hm/w7eSHkM9S+61XLuM9JBZj+px0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GSbjRNaI; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=/sc0gv5n3HTa2+ensifFm2Ixdrdjn5M3YKYyX65Jgk4=; b=GSbjRNaI9Tw45hJXi2j6h5lyh0
	FKIRfkSEg7sgd3Oa9/LSEsSZNY2LoBDn86eWXkisWs0DJrjVq84IsOEA5QUMbsmTsYtl3ecEbNqpW
	sc2I4Oqqz7bECQrsgpUTKqb+O1Ej9tblQiaHLvDGkG0wsOnH6XqEije+yRmEfzUJEvc1bOUkhgCoJ
	HrzDsJzWkGGfV2zS9JlRIkZU9AE+aiMz395i4Ct/fRxQegnQ5iHxQ6fd2Ey9eGCgY4GAls2xXxtvW
	ydszWVgq68Mg55w036Mt7EuOkcoum1LNeYHWFqArf7uhwGrzyR5aEJChG6mH+wLfDg3lPdMyO8XXG
	7BrBMcLw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vxQTD-00FEjl-P7; Tue, 03 Mar 2026 14:11:32 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 03 Mar 2026 06:11:15 -0800
Subject: [PATCH v2] blk-cgroup: always display debug stats in io.stat
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260303-blk_cgroup_debug_stats-v2-1-196c713cb762@debian.org>
X-B4-Tracking: v=1; b=H4sIAAPspmkC/4WNSwqDMBQArxLe2pQkTetn1XsUEROfMW0xkhelR
 bx70R6gy4FhZgXC6JGgYitEXDz5MELFVMbADu3okPsOKgZKqKtQQnPzejbWxTBPTYdmdg2lNhH
 HQpqiyPvSngVkDKaIvX8f4Xv9Y5rNA23aa7sxeEohfo7zInfv72SRXHJRWpFftNFKq1uHxrfjK
 UQH9bZtX3GbGBbPAAAA
X-Change-ID: 20260204-blk_cgroup_debug_stats-e81b887f9c30
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, thevlad@meta.com, kernel-team@meta.com, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=4080; i=leitao@debian.org;
 h=from:subject:message-id; bh=gRb5Q9YI+ym8+95kKkS+hRTOyMkhQ5+z/S0MPFREgQ4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBppuwP/L99GgvgPkddfNY6PW3omGvIjY27ZpX0R
 mJO+rBeTJGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaabsDwAKCRA1o5Of/Hh3
 bZg+D/9bKc2EUQrurpSAhVc5Ua+wIhLsNFwKI7qtxGP+1uU+kaD0J2BDZiUynt2ot/DErQiBa18
 uE6Aa2E1FCKUObtbWI9Q/SfWQ0BjIjeM/cVPdyEPAq6V8KMxK+2OXagoVIEkLZVL7NRhIUorIy4
 D6WAnu8YQ5D6X+LPsGWUgXFEZEisGZZM422xVeFq8FklOYKIqpYbLQ6IfVczoT6QWzxfbPGnxtC
 +U49m38vV1AIWoxbJyuHOjKNMUyVmHLTy0oc96A/t1MSjICk6qdHRi4f9ttPnUBGMpoigtQBuXP
 NvhfOe6uq34//BpOA51ime/wSbgv8fMudkIUd4/IxhwxMvNfz3RHaVksqqa8w4Dec3ZTnRrMCYA
 /1yjYFyK0jBpKO4ibbItndhpLUP437EWB/DCQMfBIv81dWFkDpDo89l33tyr+MeCVJH7uIUkLjc
 LoQCiaz6Whm8DyAkMGZYGxf9EFNUeGsgGxU1ROUwrS600fe5BIS7VcqyIp7bMq9goAFLY9B4BkV
 9s+060DLYQmW94lE5u2RzrhzwvwmlLmXa5pdoHZb40Mvq/1+/SA0jeMU9lpsdb1JIvLhySb+bxv
 YzAqybv4AZBY4IcY7YZHi23lxVqGeLijFtsvQvg+G0IFYEL+fbl4XBl8aNZ9Gv/IDIM7nsQ7vNq
 t1SK3Se4G9RyKew==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: C43611F12E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14562-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[debian.org:+]
X-Rspamd-Action: no action

Remove the blkcg_debug_stats toggle and always display detailed
statistics in the cgroup io.stat file. This includes use_delay and
delay_nsec information, cost.wait/cost.indebt/cost.indelay for iocost,
and latency statistics for iolatency.

The stats are already being collected regardless of the toggle, so
gating their display provides no real benefit. Additionally, blk-cgroup
has not been modularized since commit 32e380aedc3de ("blkcg: make
CONFIG_BLK_CGROUP bool"), making the module parameter a historical
artifact. Readers of the nested-keys format should be able to handle
additional fields.

Before (without blkcg_debug_stats enabled):
  253:0 rbytes=6273024 wbytes=0 rios=20 wios=0 dbytes=0 dios=0 cost.usage=0

After:
  253:0 rbytes=6273024 wbytes=0 rios=20 wios=0 dbytes=0 dios=0 cost.usage=0 cost.wait=0 cost.indebt=0 cost.indelay=0

Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Remove blkcg_debug_stats instead of creating a CONFIG_ to set it. (Michal)
- Link to v1: https://patch.msgid.link/20260204-blk_cgroup_debug_stats-v1-1-09c0754b4242@debian.org
---
 block/blk-cgroup.c    | 6 +-----
 block/blk-cgroup.h    | 1 -
 block/blk-iocost.c    | 9 ++++-----
 block/blk-iolatency.c | 3 ---
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b70096497d389..8b89a1ce6927a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -56,8 +56,6 @@ static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
 
 static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
-bool blkcg_debug_stats = false;
-
 static DEFINE_RAW_SPINLOCK(blkg_stat_lock);
 
 #define BLKG_DESTROY_BATCH_SIZE  64
@@ -1209,7 +1207,7 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 			dbytes, dios);
 	}
 
-	if (blkcg_debug_stats && atomic_read(&blkg->use_delay)) {
+	if (atomic_read(&blkg->use_delay)) {
 		seq_printf(s, " use_delay=%d delay_nsec=%llu",
 			atomic_read(&blkg->use_delay),
 			atomic64_read(&blkg->delay_nsec));
@@ -2246,5 +2244,3 @@ bool blk_cgroup_congested(void)
 	return ret;
 }
 
-module_param(blkcg_debug_stats, bool, 0644);
-MODULE_PARM_DESC(blkcg_debug_stats, "True if you want debug stats, false if not");
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 1cce3294634d1..ac38bc3e2486b 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -189,7 +189,6 @@ struct blkcg_policy {
 };
 
 extern struct blkcg blkcg_root;
-extern bool blkcg_debug_stats;
 
 void blkg_init_queue(struct request_queue *q);
 int blkcg_init_disk(struct gendisk *disk);
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d145db61e5c31..a913e67d0f695 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3060,11 +3060,10 @@ static void ioc_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
 
 	seq_printf(s, " cost.usage=%llu", iocg->last_stat.usage_us);
 
-	if (blkcg_debug_stats)
-		seq_printf(s, " cost.wait=%llu cost.indebt=%llu cost.indelay=%llu",
-			iocg->last_stat.wait_us,
-			iocg->last_stat.indebt_us,
-			iocg->last_stat.indelay_us);
+	seq_printf(s, " cost.wait=%llu cost.indebt=%llu cost.indelay=%llu",
+		iocg->last_stat.wait_us,
+		iocg->last_stat.indebt_us,
+		iocg->last_stat.indelay_us);
 }
 
 static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 53e8dd2dfa8ad..e99abc97050a0 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -946,9 +946,6 @@ static void iolatency_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
 	unsigned long long avg_lat;
 	unsigned long long cur_win;
 
-	if (!blkcg_debug_stats)
-		return;
-
 	if (iolat->ssd)
 		return iolatency_ssd_stat(iolat, s);
 

---
base-commit: d517cb8cea012f43b069617fc8179b45404f8018
change-id: 20260204-blk_cgroup_debug_stats-e81b887f9c30

Best regards,
--  
Breno Leitao <leitao@debian.org>


