Return-Path: <cgroups+bounces-16114-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dSw7Fq5TDWrywAUAu9opvQ
	(envelope-from <cgroups+bounces-16114-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 08:24:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B01215881D4
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 08:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 251BE3014259
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 06:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D452A367B9F;
	Wed, 20 May 2026 06:24:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8662E9ED6;
	Wed, 20 May 2026 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258281; cv=none; b=VrK7cgkz8hvOCr0g5NPypwv86ZdmhJsLbBBl5RF0WSiKqwdYyVqyqJCehZ/6tGlkkuRqMNAOxiJ/OHpcLlQpp6i7NZRumfbY4eNMWSLEEFfZfY9hFnGSAdWCtQ6+wQvWaFwotEHKCKBGSX4H+Mx9TBKC4DbS8WYgiXUyHEg9uzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258281; c=relaxed/simple;
	bh=sLjb42HkoMlV1mqO1uKia2k274xSBZTqAZDTZpZkQwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFZ1/O/tsgeQRLAN0Kg6prjZL3JGAzQEqBqk/xYzb4JMmD1fyvye8khkedhC9Jz/WXPj9insqnO9+n6gxipezT2F5qI0YsFiwdawlaSAkHMCP2BUTxwkoyqT2ppMB5n88Ew3EwnFyoPnloM1rTUNMWiga1hihrEY5vJI2SuCiQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 901ab602541411f1aa26b74ffac11d73-20260520
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:062d1788-4d46-41f8-b492-a9cd2d5d2e37,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:062d1788-4d46-41f8-b492-a9cd2d5d2e37,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:63764f3f94c51278a390290098261ec3,BulkI
	D:260520142433RWPR6ZH2,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 901ab602541411f1aa26b74ffac11d73-20260520
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(183.242.174.20)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1622988839; Wed, 20 May 2026 14:24:31 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	cgroups@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] blk-throttle: schedule parent dispatch in tg_flush_bios()
Date: Wed, 20 May 2026 14:24:20 +0800
Message-ID: <20260520062420.1762788-1-cuitao@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16114-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B01215881D4
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

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2d39977ba9de..0ad30b688ce1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1652,7 +1652,7 @@ static void tg_flush_bios(struct throtl_grp *tg)
 	 */
 	tg_update_disptime(tg);
 
-	throtl_schedule_pending_timer(sq, jiffies + 1);
+	throtl_schedule_next_dispatch(sq->parent_sq, true);
 }
 
 static void throtl_pd_offline(struct blkg_policy_data *pd)
-- 
2.43.0


