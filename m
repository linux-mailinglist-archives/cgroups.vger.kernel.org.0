Return-Path: <cgroups+bounces-17366-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YFJxCNUMQmrezQkAu9opvQ
	(envelope-from <cgroups+bounces-17366-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 08:12:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7356D6356
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 08:12:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17366-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17366-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE9B2302C7B8
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 06:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5577F394783;
	Mon, 29 Jun 2026 06:07:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14D393DCA;
	Mon, 29 Jun 2026 06:07:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713233; cv=none; b=ceNcleQJ8SanVvaN5HfBxDkJ/G5HGRnj0WUb2KwQIi37yZHA5nCOJ3rpQScDRIgb1tIqak5W5yKiiIjkTKYxP8M4Y7G/2rd7eGDXDTEzblrpFRRiaDXqHEMrFqXWeuGOjeckvLA3J/sF8JDV9jMoVNlq8iSeQeEFxAcK3/HAZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713233; c=relaxed/simple;
	bh=euC0r2zWJPZGoCGT32YgAzbNzVvqm6KONJ+verk7KoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oWmnyXkNlMimN6dVlMqTAyNV00jtcL5KgR6M9Wyht4+aFATO24cAPlAS9Ki7js/FEOPSUJpuWhFMQleR32Yg06uCS9zNXRwzlCsj64DJEHq/wggj54GP7uggciZDM1L40CJIW8mx3Ci/ZOP7okeiQpz/Fgh+fE2I4DBt+mk8fFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: bdbf1630738011f1aa26b74ffac11d73-20260629
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:061ebb43-a123-488e-bc92-1a9951ad7928,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:061ebb43-a123-488e-bc92-1a9951ad7928,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:aa9a21a9133b91db1514a1f681957751,BulkI
	D:260629140702YO8BPXHF,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
	136|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bdbf1630738011f1aa26b74ffac11d73-20260629
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1082564114; Mon, 29 Jun 2026 14:07:00 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	corbet@lwn.net,
	cui.tao@linux.dev,
	hannes@cmpxchg.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	sunshaojie@kylinos.cn,
	tj@kernel.org
Subject: [PATCH v3] cgroup/cpu: document cpu.stat.local and clarify cpu.stat behavior
Date: Mon, 29 Jun 2026 14:06:36 +0800
Message-Id: <20260629060636.200118-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aj6PQPz4IDoVTnPL@localhost.localdomain>
References: <aj6PQPz4IDoVTnPL@localhost.localdomain>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_FROM(0.00)[bounces-17366-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:corbet@lwn.net,m:cui.tao@linux.dev,m:hannes@cmpxchg.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skhan@linuxfoundation.org,m:sunshaojie@kylinos.cn,m:tj@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sunshaojie@kylinos.cn,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sunshaojie@kylinos.cn,cgroups@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA7356D6356

Add documentation for the cpu.stat.local interface file, which reports
the throttled_usec stat -- the actual throttling time incurred by the
cgroup's own runqueues, which may include throttling inherited from
ancestor cgroup bandwidth limits. Unlike cpu.stat's throttled_usec
which only accounts for throttling caused by the cgroup's own CFS
bandwidth limit.

When the controller is not enabled, the stat is not reported.

Also clarify cpu.stat descriptions: note that the three base CPU usage
stats (usage_usec, user_usec, system_usec) include descendant cgroups,
and that the five CFS bandwidth stats are non-hierarchical -- they only
account for throttling caused by the cgroup's own bandwidth limit.

Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
---
Changes in v3:
- Clarify that the three base CPU usage stats include descendant
  cgroups.
- Add a note explaining that the five CFS bandwidth stats are
  non-hierarchical.
---
 Documentation/admin-guide/cgroup-v2.rst | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 993446ab66d0..91ad91680cf0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1145,7 +1145,7 @@ will be referred to. All time durations are in microseconds.
 	This file exists whether the controller is enabled or not.
 
 	It always reports the following three stats, which account for all the
-	processes in the cgroup:
+	processes in the cgroup (including those in descendant cgroups):
 
 	- usage_usec
 	- user_usec
@@ -1160,6 +1160,27 @@ will be referred to. All time durations are in microseconds.
 	- nr_bursts
 	- burst_usec
 
+	Note that the above five CFS bandwidth stats are non-hierarchical;
+	they only account for throttling caused by this cgroup's own bandwidth
+	limit, not including throttling inherited from ancestor cgroups.
+
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


