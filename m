Return-Path: <cgroups+bounces-15933-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCK8HkFxBWoTXAIAu9opvQ
	(envelope-from <cgroups+bounces-15933-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 08:52:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE753E8E5
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 08:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C04F303A8D6
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FAB3ACF1F;
	Thu, 14 May 2026 06:51:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C03ACF06
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741462; cv=none; b=IMH705fgihOGj7EE3ltUX5889SJp0BiOuLWgQi05qUa0akV7n3lsqKNY+CuwYQ5w3bMo8x0/pEuk/XgxMn/gPbmimkCdZMvXKAcjm3AjKurfsJlHA9Nf9M/jPhNGV/EL2q+20Ja6udFyiFfJCjJqCu09wV5Xrnd5ZFioVN0rtBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741462; c=relaxed/simple;
	bh=ob8/E3cvtMmG4Vs+KsmhlXVl1uqntQSno5UE6MOgoz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9/p1kVdpemmhTDfQ8q2MqAvB3k6RsiLUimfoRQpasyOFGdn/CI+YUSHZBUTUJm2O3dOxkMVk71QuYF2ZAuJ8wQlubM64f2mHlRAbOxJ0QKKiKv89DydI/cjoU45ux0t3QhyJGb5IfKegH9Eekbb+TQPyRjb4TDN7DZNuaj3CD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 417b692c4f6111f1aa26b74ffac11d73-20260514
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6c96f610-23d7-4767-bed8-3eae4e0aa7c9,IP:10,
	URL:0,TC:0,Content:100,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:105
X-CID-INFO: VERSION:1.3.12,REQID:6c96f610-23d7-4767-bed8-3eae4e0aa7c9,IP:10,UR
	L:0,TC:0,Content:100,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
	ION:quarantine,TS:105
X-CID-META: VersionHash:e7bac3a,CLOUDID:613fa493b5a833b70d33d027ff6ab38c,BulkI
	D:260514145057N66FUGHZ,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|12
	7|898,TC:nil,Content:3|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 417b692c4f6111f1aa26b74ffac11d73-20260514
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2000655600; Thu, 14 May 2026 14:50:55 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v3 4/4] cgroup/rdma: document rdma.peak, rdma.events and rdma.events.local
Date: Thu, 14 May 2026 14:50:34 +0800
Message-ID: <20260514065034.387197-5-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514065034.387197-1-cuitao@kylinos.cn>
References: <20260514065034.387197-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 02EE753E8E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
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
	TAGGED_FROM(0.00)[bounces-15933-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Action: no action

Add interface file documentation for the new rdma cgroup files to
Documentation/admin-guide/cgroup-v2.rst.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 53 +++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed99..993446ab66d0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2785,6 +2785,59 @@ RDMA Interface Files
 	  mlx4_0 hca_handle=1 hca_object=20
 	  ocrdma1 hca_handle=1 hca_object=23
 
+  rdma.peak
+	A read-only nested-keyed file that exists for all the cgroups
+	except root.  It shows the historical high watermark of
+	resource usage per device since the cgroup was created.
+
+	An example for mlx4 and ocrdma device follows::
+
+	  mlx4_0 hca_handle=1 hca_object=20
+	  ocrdma1 hca_handle=0 hca_object=23
+
+  rdma.events
+	A read-only nested-keyed file which exists on non-root
+	cgroups.  The following nested keys are defined.
+
+	  max
+		The number of times a process in this cgroup or its
+		descendants attempted an RDMA resource allocation that
+		was rejected because a rdma.max limit in the subtree
+		was reached.  This is a hierarchical counter: the event
+		is propagated upward to all ancestor cgroups.  A value
+		change in this file generates a file modified event.
+
+	  alloc_fail
+		The number of RDMA resource allocation attempts that
+		originated in this cgroup or its descendants and failed
+		due to a rdma.max limit being reached.  This is a
+		hierarchical counter propagated upward.
+
+	An example for mlx4 device follows::
+
+	  mlx4_0 hca_handle.max=5 hca_handle.alloc_fail=3 hca_object.max=0 hca_object.alloc_fail=0
+
+  rdma.events.local
+	Similar to rdma.events but the fields in the file are local
+	to the cgroup i.e. not hierarchical.  The file modified event
+	generated on this file reflects only the local events.
+
+	The following nested keys are defined.
+
+	  max
+		The number of times a process in this cgroup or its
+		descendants attempted an RDMA resource allocation that
+		was rejected because this cgroup's own rdma.max limit
+		was reached.
+	  alloc_fail
+		The number of RDMA resource allocation attempts
+		originating from this cgroup that failed due to this
+		cgroup's or an ancestor's rdma.max limit.
+
+	An example for mlx4 device follows::
+
+	  mlx4_0 hca_handle.max=5 hca_handle.alloc_fail=0 hca_object.max=0 hca_object.alloc_fail=0
+
 DMEM
 ----
 
-- 
2.43.0


