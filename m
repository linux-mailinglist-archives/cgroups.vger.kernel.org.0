Return-Path: <cgroups+bounces-9451-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730D9B39211
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 05:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C6B4623A0
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 03:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436E325BEF8;
	Thu, 28 Aug 2025 03:03:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865DF1A0BD0;
	Thu, 28 Aug 2025 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756350210; cv=none; b=W8t2KgPpDNcL8Qrm6MFskUHqAyzXDn8ASxmNFTUVRjSOOOZiCjK0QnOkw4gpU+pTFkmcrGMvbk1IsyTMT4aFzCWzwDHsRiJtTxxkhue3Dga3drQqonsRitsSlLwbeJOzsb8shAoAd5OpfwwcRozB1kqZAR6GWV06fdmeN6onTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756350210; c=relaxed/simple;
	bh=McBv2WKYiAtFM/Ev/r3aEudSnN2uFfmXW8xy5B85iMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cvgvPVtERn310efwyticoDwflsbWte3S3toBcasmi72bJoLLzKPbo82gofQz9V3pPycPxtnLLN39PEw2ggYzwXuHwOO9RHDAdS/60Z58G+bYSg33QRzlM4DczTQGwna+WnSpNBjdQ3oxXcCoKdsnYUUGr8ZnV7D9vvQGM/gwvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 88bef62c83bb11f0b29709d653e92f7d-20250828
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c8ea5b92-ff40-4466-873f-7b2076a45a3f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:18
X-CID-INFO: VERSION:1.1.45,REQID:c8ea5b92-ff40-4466-873f-7b2076a45a3f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
	release,TS:18
X-CID-META: VersionHash:6493067,CLOUDID:1838626cc82ff7846ff27bbb79bb3582,BulkI
	D:250828110315VR7ZFWK4,BulkQuantity:0,Recheck:0,SF:16|19|24|38|44|66|78|10
	2|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 88bef62c83bb11f0b29709d653e92f7d-20250828
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 582230096; Thu, 28 Aug 2025 11:03:12 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: dev@lankhorst.se,
	mripard@kernel.org,
	natalie.vock@gmx.de,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH] cgroup/dmem: Fix spelling error in dmem.c
Date: Thu, 28 Aug 2025 11:02:36 +0800
Message-Id: <20250828030236.427593-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some spelling errors in the comments.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 kernel/cgroup/dmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 10b63433f057..0459cca9e795 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -19,7 +19,7 @@
 struct dmem_cgroup_region {
 	/**
 	 * @ref: References keeping the region alive.
-	 * Keeps the region reference alive after a succesful RCU lookup.
+	 * Keeps the region reference alive after a successful RCU lookup.
 	 */
 	struct kref ref;
 
@@ -582,7 +582,7 @@ EXPORT_SYMBOL_GPL(dmem_cgroup_uncharge);
  * dmem_cgroup_try_charge() - Try charging a new allocation to a region.
  * @region: dmem region to charge
  * @size: Size (in bytes) to charge.
- * @ret_pool: On succesfull allocation, the pool that is charged.
+ * @ret_pool: On successful allocation, the pool that is charged.
  * @ret_limit_pool: On a failed allocation, the limiting pool.
  *
  * This function charges the @region region for a size of @size bytes.
-- 
2.25.1


