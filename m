Return-Path: <cgroups+bounces-17208-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GqDVOgdLO2qhVggAu9opvQ
	(envelope-from <cgroups+bounces-17208-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 05:12:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F326BB0A8
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 05:12:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17208-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17208-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81E40302D941
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 03:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C06930567D;
	Wed, 24 Jun 2026 03:11:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3480E271456;
	Wed, 24 Jun 2026 03:11:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270718; cv=none; b=qcY+t2QngV3tWagOVCvIXD0XUw1t4xvcufty7SfbXpIRxnNIJrtXKjsAl/PnziieNADirXtgYo0K+e+ZDieiDjh/vEJBkVwRo4VaGIzmbsWqFZnC5V1j0jvE6RICMVDb9NbOf8BQ2MrvCpCVn/uYInHgRMLHQcW9a+GlYyRQ3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270718; c=relaxed/simple;
	bh=yPIWxGPvE4iaKtHdTpjGavmyj9xWArn7j1YZOkHUzbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F2MHxWNrwYfJtxgzdGNJGM7VLILK1KZdYLqpR6/p2eOvqnY+Cg2wwAL+9Y+zkCLyhB95BY4UhsHF4wSWLtN7MaFZ+Xkf0awPxc7Nfd65K4y5YkyUHzTdYhVMkgBn0lYDJM3bd0Wfvx3Kqwj/Xp88TOgkh1FEPkv5ub5iFaj2Gh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 70cad3f06f7a11f1aa26b74ffac11d73-20260624
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:40cce9cb-9cbd-4073-bc3d-8fa85a66feb8,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:40cce9cb-9cbd-4073-bc3d-8fa85a66feb8,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:c8cbf633666dd95c95bf9c332716aa7e,BulkI
	D:260624111150J8X2XGI2,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 70cad3f06f7a11f1aa26b74ffac11d73-20260624
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 900636280; Wed, 24 Jun 2026 11:11:49 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	dev@lankhorst.se,
	mripard@kernel.org,
	natalie.vock@gmx.de
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH 0/2] cgroup/dmem: add per-region event counters
Date: Wed, 24 Jun 2026 11:11:05 +0800
Message-Id: <20260624031107.667253-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:dev@lankhorst.se,m:mripard@kernel.org,m:natalie.vock@gmx.de,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:lihongfu@kylinos.cn,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,lankhorst.se,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[lihongfu@kylinos.cn,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17208-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongfu@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dmem.events:url,kylinos.cn:mid,kylinos.cn:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45F326BB0A8

This patch series adds event counters to the device memory (dmem) cgroup
controller.

The dmem controller exposes per-region limits and current usage, but
not how often those limits are hit.  It is hard to tell whether failures
come from this cgroup, a parent limit, or pressure elsewhere in the
hierarchy.

To provide that visibility, this series introduces:
  - dmem.events:       reports hierarchical low/max counts per region.
  - dmem.events.local: reports per-region low/max counts for this cgroup only.

Patch overview:

Patch 1/2:
  - Add dmem.events with hierarchical low/max counters per region.
  - Record dmem.max allocation failures and dmem.low protection events.
  - Document the interface in cgroup-v2.rst.

Patch 2/2:
  - Add dmem.events.local for local-only per-region counts.
  - Share the events show logic between both files.
  - Update cgroup-v2.rst accordingly.

Example output (dmem.events):

  drm/0000:03:00.0/vram0 low 0 max 3
  drm/0000:03:00.0/stolen low 0 max 0

  low  - reclaim/eviction considered the cgroup below its effective
         dmem.low protection
  max  - allocation failed because the cgroup or an ancestor hit dmem.max

Both files exist for all non-root cgroups, like dmem.max and dmem.current.

These patches have been tested locally.

Hongfu Li (2):
  cgroup/dmem: add per-region event counters
  cgroup/dmem: introduce dmem.events.local for local counts

 Documentation/admin-guide/cgroup-v2.rst | 17 +++++
 kernel/cgroup/dmem.c                    | 85 ++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

-- 
2.25.1


