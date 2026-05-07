Return-Path: <cgroups+bounces-15652-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNc6G1YY/GnwLQAAu9opvQ
	(envelope-from <cgroups+bounces-15652-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 06:43:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A4B4E2E8F
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 06:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07F35300939C
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 04:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56837322527;
	Thu,  7 May 2026 04:42:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40D02C0282
	for <cgroups@vger.kernel.org>; Thu,  7 May 2026 04:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778128974; cv=none; b=cpF8FN6tNseeAzuNGhTw7gBdov8y0apUnYLf5a3uryz5ICuhqQO5y5LRsSBNdOpctFrjVs32n6s89SPYID3tWJ7SbfaOnjCf/t6e8AlJFy+q7cz5MdO/S/bzzx/tvaM9tPCggW7xwNkJ1UPXjlS2qdN3boGeJI1tLjiY5lvr8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778128974; c=relaxed/simple;
	bh=vJa/ywjhh7manBjhJs5NZVaAINHW6CytvdU1haJqRbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyLbjMBcw608mrHfoWzrM61gRvBxQF49tg4Zsz0Z2I/W++x0DxyapmuCmkBCtqwt8/1obuAk5eLAlKbghfQSfqFmHLyW9dtowsbQY5Xc+uwD+nrI/Qfwog+CiuHtSzLzJJkjDPQTep0UAvw+KBLuRNodqNGC9SmX3AP5Y7BljFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 305a75b249cf11f1aa26b74ffac11d73-20260507
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_AS_FROM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:bc65f02f-4846-4850-b3f4-02aab8d95371,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:bc65f02f-4846-4850-b3f4-02aab8d95371,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:3353eb11b698cc9b75bcc307c53268bd,BulkI
	D:260507124245GXQ0PMKW,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|102|1
	27|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 305a75b249cf11f1aa26b74ffac11d73-20260507
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1800144690; Thu, 07 May 2026 12:42:44 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: cuitao@kylinos.cn
Cc: axboe@kernel.dk,
	cgroups@vger.kernel.org,
	josef@toxicpanda.com,
	tj@kernel.org
Subject: [PATCH v2] blk-cgroup: fix leaks and online flag on radix_tree_insert failure
Date: Thu,  7 May 2026 12:42:26 +0800
Message-ID: <20260507044226.45832-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506131124.16755-1-cuitao@kylinos.cn>
References: <20260506131124.16755-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 20A4B4E2E8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_FROM(0.00)[bounces-15652-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

When radix_tree_insert() fails in blkg_create(), the error path has two
issues:

1. blkg->online is set to true unconditionally, even when the blkg was
   never fully inserted.  Move the assignment inside the success block.

2. The error path calls blkg_put() without first calling
   percpu_ref_kill().  Because the refcount is still in percpu mode,
   percpu_ref_put() only does this_cpu_sub() without checking for zero,
   so blkg_release() is never triggered.  This permanently leaks the
   blkg memory, its percpu iostat, policy data, the parent blkg
   reference, and the cgroup css reference — the latter preventing the
   cgroup from ever being destroyed.

Fix by adding percpu_ref_kill() before blkg_put(), matching the pattern
used in blkg_destroy().

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---

v2:
- Also fix the percpu_ref leak on the radix_tree_insert() error path by
  adding percpu_ref_kill() before blkg_put(), as pointed out by the
  Sashiko AI review.
---
 block/blk-cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 554c87bb4a86..845211f318fc 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -431,14 +431,15 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 				blkg->pd[i]->online = true;
 			}
 		}
+		blkg->online = true;
 	}
-	blkg->online = true;
 	spin_unlock(&blkcg->lock);
 
 	if (!ret)
 		return blkg;
 
 	/* @blkg failed fully initialized, use the usual release path */
+	percpu_ref_kill(&blkg->refcnt);
 	blkg_put(blkg);
 	return ERR_PTR(ret);
 
-- 
2.43.0


