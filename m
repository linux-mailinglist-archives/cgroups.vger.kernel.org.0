Return-Path: <cgroups+bounces-15996-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Fk8JMuv/B2qXUQMAu9opvQ
	(envelope-from <cgroups+bounces-15996-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 07:26:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD5855A466
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 07:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D868430089BA
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 05:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D14299931;
	Sat, 16 May 2026 05:26:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210CA28686
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 05:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778909160; cv=none; b=kOBw/FkcunVPrLVCRYJNOeTtRTQVjDyOtTaNDGb8tBe7d0fAHtpPPItMXlkb02IBN+InoSpbM3riL+oXhYAJK4lpswAc9gotId2N3BEY7olfBOSxbrTTAHjDQgs98fJ3aX52i9InDi27tjH43r2c6zcf0teFNNDEivYqb/4j5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778909160; c=relaxed/simple;
	bh=fXyhZ2BvGa9rnz4w5iiYXktW/Js9hCvW6EcC/DS5ohE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7k3XuLsIW7Jv2ikWa8AqWbKP57oplzpruFaSHp1tzkbdGfjA8YUAr04BTZBkovH8Ylpa8bOFPqhpgVqTUR1loZp4W4EGyDLGROmRDDphmSrQg9sVdvzeE4D9SzZqRU6TzdwxeW2uNM4OrzXT91CB/PQELnhfYCAaNk9mCmcuY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b35f0cb050e711f1aa26b74ffac11d73-20260516
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:09ca0fd4-fddd-4e60-ad66-557fcba73fa0,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-INFO: VERSION:1.3.12,REQID:09ca0fd4-fddd-4e60-ad66-557fcba73fa0,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:b5b6690e91e241b0ced1904908f90158,BulkI
	D:260516132551YMT9YNIF,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b35f0cb050e711f1aa26b74ffac11d73-20260516
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1400751814; Sat, 16 May 2026 13:25:50 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] cgroup/rdma: drop unnecessary READ_ONCE() on event counters
Date: Sat, 16 May 2026 13:25:37 +0800
Message-ID: <20260516052537.450732-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BD5855A466
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-15996-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Action: no action

All accesses to the event counters are serialized by rdmacg_mutex,
making the READ_ONCE() annotations unnecessary. Remove them.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/cgroup/rdma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 7c238a9d64d4..5e82a03b3270 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -145,10 +145,10 @@ static bool rpool_has_persistent_state(struct rdmacg_resource_pool *rpool)
 	 */
 	for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
 		if (rpool->resources[i].peak ||
-		    READ_ONCE(rpool->events_max[i]) ||
-		    READ_ONCE(rpool->events_local_max[i]) ||
-		    READ_ONCE(rpool->events_alloc_fail[i]) ||
-		    READ_ONCE(rpool->events_local_alloc_fail[i]))
+		    rpool->events_max[i] ||
+		    rpool->events_local_max[i] ||
+		    rpool->events_alloc_fail[i] ||
+		    rpool->events_local_alloc_fail[i])
 			return true;
 	}
 	return false;
@@ -654,9 +654,9 @@ static int rdmacg_events_show(struct seq_file *sf, void *v)
 		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
 			seq_printf(sf, "%s.max=%llu %s.alloc_fail=%llu",
 				   rdmacg_resource_names[i],
-				   rpool ? READ_ONCE(rpool->events_max[i]) : 0ULL,
+				   rpool ? rpool->events_max[i] : 0ULL,
 				   rdmacg_resource_names[i],
-				   rpool ? READ_ONCE(rpool->events_alloc_fail[i]) : 0ULL);
+				   rpool ? rpool->events_alloc_fail[i] : 0ULL);
 			if (i < RDMACG_RESOURCE_MAX - 1)
 				seq_putc(sf, ' ');
 		}
@@ -683,9 +683,9 @@ static int rdmacg_events_local_show(struct seq_file *sf, void *v)
 		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
 			seq_printf(sf, "%s.max=%llu %s.alloc_fail=%llu",
 				   rdmacg_resource_names[i],
-				   rpool ? READ_ONCE(rpool->events_local_max[i]) : 0ULL,
+				   rpool ? rpool->events_local_max[i] : 0ULL,
 				   rdmacg_resource_names[i],
-				   rpool ? READ_ONCE(rpool->events_local_alloc_fail[i]) : 0ULL);
+				   rpool ? rpool->events_local_alloc_fail[i] : 0ULL);
 			if (i < RDMACG_RESOURCE_MAX - 1)
 				seq_putc(sf, ' ');
 		}
-- 
2.43.0


