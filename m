Return-Path: <cgroups+bounces-16241-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCIIKZbkE2rhHAcAu9opvQ
	(envelope-from <cgroups+bounces-16241-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 07:56:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D20E5C61AA
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 07:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4635F3037499
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 05:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204E235F176;
	Mon, 25 May 2026 05:55:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA4535E1A4;
	Mon, 25 May 2026 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779688533; cv=none; b=CbnWUCGyuXhwU8ZcOtLD/ZFjuujEyr9EW/G7zbQ+glIxUvwYl3TWXvNB0Vt0P98fdE7dRVN4arJ6FLTkcFUVXZOLSAkmRF9xyO61xojmADIlf3narQ09JolSQat9KXRnXujFofadQBAWxsZfzPflo6kJS/iUL5UpSD/LGVzkUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779688533; c=relaxed/simple;
	bh=ktOk/GvLve51kE1T9N84D/rZ4ewXUW0v2NqXJU89u+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bW8yWRCdTSdfV0Wda3r4uijrbyOrh6qccL6kXQQPebWs4HCipSF2/gwKb+fVcRa+EpgWRTTcV2XUctYjX6B9fK4IYDJf6sOyQwq1fh3JI3lvl4dmvFrIcpbVA07cTt273Z3U/Z0I1pe6QfGMawPIYtxCwBqyx7fQCxRDmNjEW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 532822f057fe11f1aa26b74ffac11d73-20260525
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cd665136-72d9-49bd-9825-e40b1ed7c5ba,IP:20,
	URL:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:120
X-CID-INFO: VERSION:1.3.12,REQID:cd665136-72d9-49bd-9825-e40b1ed7c5ba,IP:20,UR
	L:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
	ON:quarantine,TS:120
X-CID-META: VersionHash:e7bac3a,CLOUDID:e31643a14b2771712a6429d1f3648d56,BulkI
	D:260525135528FZ0IOAOM,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|12
	7|865|898,TC:nil,Content:3|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 532822f057fe11f1aa26b74ffac11d73-20260525
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1325786295; Mon, 25 May 2026 13:55:25 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	cgroups@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [RFC PATCH rdma-next 5/5] cgroup/rdma: update cgroup resource list for QP, MR and MR_MEM
Date: Mon, 25 May 2026 13:55:06 +0800
Message-ID: <20260525055506.2002985-6-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525055506.2002985-1-cuitao@kylinos.cn>
References: <20260525055506.2002985-1-cuitao@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16241-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 0D20E5C61AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RDMA cgroup now supports per-type resource counting for QP, MR
(count) and MR_MEM (cumulative memory size in bytes).  Update the
rdma.rst document to list all five resources and revise the usage
examples accordingly.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 993446ab66d0..512af59e302a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2769,12 +2769,15 @@ RDMA Interface Files
 	  ==========	=============================
 	  hca_handle	Maximum number of HCA Handles
 	  hca_object 	Maximum number of HCA Objects
+	  qp		Maximum number of Queue Pairs
+	  mr		Maximum number of Memory Regions
+	  mr_mem	Maximum cumulative MR memory size in bytes
 	  ==========	=============================
 
 	An example for mlx4 and ocrdma device follows::
 
-	  mlx4_0 hca_handle=2 hca_object=2000
-	  ocrdma1 hca_handle=3 hca_object=max
+	  mlx4_0 hca_handle=2 hca_object=2000 qp=100 mr=500 mr_mem=1073741824
+	  ocrdma1 hca_handle=3 hca_object=max qp=max mr=max mr_mem=max
 
   rdma.current
 	A read-only file that describes current resource usage.
@@ -2782,8 +2785,8 @@ RDMA Interface Files
 
 	An example for mlx4 and ocrdma device follows::
 
-	  mlx4_0 hca_handle=1 hca_object=20
-	  ocrdma1 hca_handle=1 hca_object=23
+	  mlx4_0 hca_handle=1 hca_object=20 qp=5 mr=10 mr_mem=10485760
+	  ocrdma1 hca_handle=1 hca_object=23 qp=3 mr=8 mr_mem=8388608
 
   rdma.peak
 	A read-only nested-keyed file that exists for all the cgroups
@@ -2792,8 +2795,8 @@ RDMA Interface Files
 
 	An example for mlx4 and ocrdma device follows::
 
-	  mlx4_0 hca_handle=1 hca_object=20
-	  ocrdma1 hca_handle=0 hca_object=23
+	  mlx4_0 hca_handle=1 hca_object=20 qp=5 mr=10 mr_mem=10485760
+	  ocrdma1 hca_handle=0 hca_object=23 qp=3 mr=8 mr_mem=8388608
 
   rdma.events
 	A read-only nested-keyed file which exists on non-root
@@ -2815,7 +2818,7 @@ RDMA Interface Files
 
 	An example for mlx4 device follows::
 
-	  mlx4_0 hca_handle.max=5 hca_handle.alloc_fail=3 hca_object.max=0 hca_object.alloc_fail=0
+	  mlx4_0 hca_handle.max=5 hca_handle.alloc_fail=3 hca_object.max=0 hca_object.alloc_fail=0 qp.max=0 qp.alloc_fail=0 mr.max=0 mr.alloc_fail=0 mr_mem.max=0 mr_mem.alloc_fail=0
 
   rdma.events.local
 	Similar to rdma.events but the fields in the file are local
@@ -2836,7 +2839,7 @@ RDMA Interface Files
 
 	An example for mlx4 device follows::
 
-	  mlx4_0 hca_handle.max=5 hca_handle.alloc_fail=0 hca_object.max=0 hca_object.alloc_fail=0
+	  mlx4_0 hca_handle.max=5 hca_handle.alloc_fail=0 hca_object.max=0 hca_object.alloc_fail=0 qp.max=0 qp.alloc_fail=0 mr.max=0 mr.alloc_fail=0 mr_mem.max=0 mr_mem.alloc_fail=0
 
 DMEM
 ----
-- 
2.43.0


