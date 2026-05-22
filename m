Return-Path: <cgroups+bounces-16204-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKGFFFcgEGqjTwYAu9opvQ
	(envelope-from <cgroups+bounces-16204-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 11:22:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7CE5B1117
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 11:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 686D3304CEAD
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 09:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460E3A6F03;
	Fri, 22 May 2026 09:15:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553512F0C7E;
	Fri, 22 May 2026 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441352; cv=none; b=LMW2c5XJRrhvmtmzd4Y+Fz3DLO+6U+kIOcULLi0gqWdW9olzJ7Iobvs2i4a1ScfIVf+ETX8o6DGcESbLuaGUZsHE6DZ4N8Bt2jgJwKw2mrTdS74Glc+mP+nu/Cdg42cJhxFM+js1W/9SxEhJpyWRyX+VcWd1E52FDA8+7wjgZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441352; c=relaxed/simple;
	bh=oBYHzTU1lkSpFLiOM57OLlBnNVrEaNVBbd5dBdlf2WU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jbf4YYJc8zlk19y7ioleqb1FkV+tzae9CJtycUG9pc+x26yyzJn5N+XuXJeJ86W29TIwgEjIjOwi2oKDjJEHJrRgsNOD+BwEnrANDQY7NepI0tbot38OuJLX9d+9JZwf7CRtEyU6hV2YZodwjaJsyHm5KWZruHAx/HOEZ8Y+Eno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cfadd1b855be11f1aa26b74ffac11d73-20260522
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:92af8e96-0972-472c-9c22-53e277bb93bf,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-10
X-CID-INFO: VERSION:1.3.12,REQID:92af8e96-0972-472c-9c22-53e277bb93bf,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:e7bac3a,CLOUDID:086bd40506295a46c59a6d8ea38ce2ea,BulkI
	D:260522171546EOHFZZSX,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
	TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cfadd1b855be11f1aa26b74ffac11d73-20260522
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 170641192; Fri, 22 May 2026 17:15:44 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	cgroups@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] blk-throttle: schedule parent dispatch in tg_flush_bios()
Date: Fri, 22 May 2026 17:15:30 +0800
Message-ID: <20260522091530.1901437-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16204-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5F7CE5B1117
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tg_flush_bios() schedules pending_timer on the child tg's own
service_queue, which causes throtl_pending_timer_fn() to dispatch from
the child's pending_tree.  For leaf cgroups this tree is empty, so the
timer fires and exits without dispatching the throttled bio.

The throttled bio sits in the parent's pending_tree with disptime set
to jiffies (THROTL_TG_CANCELING zeroes all dispatch times), but the
parent's timer is never explicitly rescheduled.  The bio only gets
dispatched when the parent timer eventually fires at its previously
scheduled expiry.

Fix by calling throtl_schedule_next_dispatch(sq->parent_sq, true)
instead, matching what tg_set_limit() already does.  This forces the
parent's dispatch cycle to run immediately and flush all canceling
bios without waiting for a stale timer.

For the device deletion path (blk_throtl_cancel_bios), directly
complete throttled bios with EIO via bio_io_error() instead of
dispatching them through the timer -> work -> submission chain.
This avoids a race with the SCSI state machine where bios can reach
the SCSI layer while the device is in SDEV_CANCEL state, causing
ENODEV instead of the expected EIO.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/all/ag2owaQQoigp_fSV@shinmob/
Signed-off-by: Tao Cui <cuitao@kylinos.cn>

---
Changes in v2:
- Rewrite blk_throtl_cancel_bios() to directly complete throttled
  bios with EIO via bio_io_error() instead of dispatching them
  through the timer -> work -> submission chain.  This avoids a
  race with the SCSI state machine during device deletion where
  bios can reach the SCSI layer while the device is in SDEV_CANCEL
  state, causing ENODEV instead of the expected EIO.
- Add Reported-by and Link tags from Shin'ichiro Kawasaki's report.

v1:
  https://lore.kernel.org/all/20260520062420.1762788-1-cuitao@kylinos.cn/
---
 block/blk-throttle.c | 51 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index cabf91f0d0dc..88986dde1e18 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1649,7 +1649,7 @@ static void tg_flush_bios(struct throtl_grp *tg)
 	 */
 	tg_update_disptime(tg);
 
-	throtl_schedule_pending_timer(sq, jiffies + 1);
+	throtl_schedule_next_dispatch(sq->parent_sq, true);
 }
 
 static void throtl_pd_offline(struct blkg_policy_data *pd)
@@ -1668,11 +1668,52 @@ struct blkcg_policy blkcg_policy_throtl = {
 	.pd_free_fn		= throtl_pd_free,
 };
 
+static void tg_cancel_writeback_bios(struct throtl_grp *tg,
+				      struct bio_list *cancel_bios)
+{
+	struct throtl_service_queue *sq = &tg->service_queue;
+	struct throtl_data *td = sq_to_td(sq);
+	int rw;
+
+	if (tg->flags & THROTL_TG_CANCELING)
+		return;
+	tg->flags |= THROTL_TG_CANCELING;
+
+	for (rw = READ; rw <= WRITE; rw++) {
+		struct throtl_qnode *qn, *tmp;
+		unsigned int nr_bios = 0;
+
+		list_for_each_entry_safe(qn, tmp, &sq->queued[rw], node) {
+			struct bio *bio;
+
+			while ((bio = bio_list_pop(&qn->bios_iops))) {
+				sq->nr_queued_iops[rw]--;
+				bio_list_add(&cancel_bios[rw], bio);
+				nr_bios++;
+			}
+			while ((bio = bio_list_pop(&qn->bios_bps))) {
+				sq->nr_queued_bps[rw]--;
+				bio_list_add(&cancel_bios[rw], bio);
+				nr_bios++;
+			}
+
+			list_del_init(&qn->node);
+			blkg_put(tg_to_blkg(qn->tg));
+		}
+
+		td->nr_queued[rw] -= nr_bios;
+	}
+
+	throtl_dequeue_tg(tg);
+}
+
 void blk_throtl_cancel_bios(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct cgroup_subsys_state *pos_css;
 	struct blkcg_gq *blkg;
+	struct bio_list cancel_bios[2] = { };
+	int rw;
 
 	if (!blk_throtl_activated(q))
 		return;
@@ -1693,10 +1734,16 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 		 * Cancel bios here to ensure no bios are inflight after
 		 * del_gendisk.
 		 */
-		tg_flush_bios(blkg_to_tg(blkg));
+		tg_cancel_writeback_bios(blkg_to_tg(blkg), cancel_bios);
 	}
 	rcu_read_unlock();
 	spin_unlock_irq(&q->queue_lock);
+
+	for (rw = READ; rw <= WRITE; rw++) {
+		struct bio *bio;
+		while ((bio = bio_list_pop(&cancel_bios[rw])))
+			bio_io_error(bio);
+	}
 }
 
 static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
-- 
2.43.0


