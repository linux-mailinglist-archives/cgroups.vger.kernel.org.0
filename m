Return-Path: <cgroups+bounces-17301-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b3AiEW/RPWoP6wgAu9opvQ
	(envelope-from <cgroups+bounces-17301-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 03:10:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BA36C9604
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 03:10:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17301-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17301-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 132DF3048AD7
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 01:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42E32BE035;
	Fri, 26 Jun 2026 01:10:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAED5CDF1;
	Fri, 26 Jun 2026 01:09:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782436200; cv=none; b=qctVKGYscpe+hMFkXdwpXSLs25cGxfDbiCyflW2qIIMKwA3EVc68BZOx+7tvmyc4S5Cuvj2XPW4rrAGAoC6+IrTvEtuCltGB85vnzarTu4VOXaychkZY8S1aDI+eSI9agZRaIcFlZg3nDPuMepJ27nM1slB1TJvp/Cqa4gx62qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782436200; c=relaxed/simple;
	bh=b8UTX8K/jQDmLmm5QgeTE5CJgwVngPZT3rQqoCXZi4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSNlq5GdzvnlNK5NLgED+rywe484++7TkAt9xET/pIh/3PUz0+0xwo54FNF9RO42kCBd4X5qfNa1oxGcZ3av+JwUFg4PS7TBMLNSurCAIyg8MBhLwzgQ1JVa/LEZAM1TtRfOINr4+zAwmpoTjb2rkHrHYWoOmyktHz4WsiEOs2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: bc8bc32670fb11f1aa26b74ffac11d73-20260626
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CHARSET
	HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
	HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN
	HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS
	HR_TO_CHARSET, HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:46897d3c-036a-4d77-9621-b50c7b3f8caa,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:46897d3c-036a-4d77-9621-b50c7b3f8caa,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:dccdbe6ecc1e3a64ad24b863b0e5a716,BulkI
	D:2606260909539MXW8NQA,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|136|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:n
	il,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bc8bc32670fb11f1aa26b74ffac11d73-20260626
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1149555224; Fri, 26 Jun 2026 09:09:52 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: cui.tao@linux.dev,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>
Subject: [PATCH v2] cgroup/cpu: document cpu.stat.local
Date: Fri, 26 Jun 2026 09:09:14 +0800
Message-Id: <20260626010914.1154495-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d9ada3a3-6978-4602-a11d-689e0fa4171a@linux.dev>
References: <d9ada3a3-6978-4602-a11d-689e0fa4171a@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17301-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sunshaojie@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sunshaojie@kylinos.cn,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunshaojie@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5BA36C9604

Add documentation for the cpu.stat.local interface file, which reports
the throttled_usec stat -- the actual throttling time incurred by the
cgroup's own runqueues, which may include throttling inherited from
ancestor cgroup bandwidth limits. Unlike cpu.stat's throttled_usec
which only accounts for throttling caused by the cgroup's own CFS
bandwidth limit.

When the controller is not enabled, the stat is not reported.

Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
---
v2:
- Remove "which exists on non-root cgroups" since the file is also
  present on the root cgroup, matching cpu.stat behavior.
---
 Documentation/admin-guide/cgroup-v2.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 993446ab66d0..c2c24000f5cc 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1160,6 +1160,23 @@ will be referred to. All time durations are in microseconds.
 	- nr_bursts
 	- burst_usec
 
+  cpu.stat.local
+	A read-only flat-keyed file.
+	This file exists whether the controller is enabled or not.
+
+	It reports the following stat when the controller is enabled:
+
+	- throttled_usec
+
+	Unlike the ``throttled_usec`` reported by ``cpu.stat`` which
+	accounts for throttling caused by this cgroup's own CFS
+	bandwidth limit, ``cpu.stat.local`` reports the actual
+	throttling time incurred by this cgroup's own runqueues,
+	which may include throttling inherited from ancestor
+	cgroup bandwidth limits.
+
+	When the controller is not enabled, this stat is not reported.
+
   cpu.weight
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "100".
-- 
2.25.1


