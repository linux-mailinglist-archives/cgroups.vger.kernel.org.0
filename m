Return-Path: <cgroups+bounces-15883-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNG+EL1XBGqjHAIAu9opvQ
	(envelope-from <cgroups+bounces-15883-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 12:51:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313C531A84
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 12:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B0E3022FB6
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81000396588;
	Wed, 13 May 2026 10:51:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62B38B7B1
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669482; cv=none; b=bDkaYCy0Ot2OjvOLnp7rRlE+i3OfAzmgqEBNvxzsYBWg9l5+14fan0zBNqV+P1B7VINbT0GA0s0Uk/DBBlvfxJCAs6Y7cq3cjeQhfqQJFC4okoPGeLp2umd+fqB5o9tQdp+XFQIupKLeWiadlwHgCiFYHk2YtAa+/ivqkxXN/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669482; c=relaxed/simple;
	bh=sVAx7HMkoozIaLAOlIGlU4fsYPqGA/hHlSQuFeoCW+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3fbQTDpz56+g33PUZKkeeo0LpxOnEvwooFIXY0n4h4+H2M2l6NjPaxj4TdY4MylLIjxFlRxh11njmhmnsiGQ0xzpbJE7DclnXIIn/rAa3AL/avI55SlzSuICIDnmGdvljjjSdng0MyuPje3laDxHTcxtVz6ZBgBuoh0xdKXFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a76782dc4eb911f1aa26b74ffac11d73-20260513
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
X-CID-O-INFO: VERSION:1.3.12,REQID:1e1b35a7-5480-458e-9fce-4000948959d6,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:1e1b35a7-5480-458e-9fce-4000948959d6,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:401154a22ce69dc51e5c2f998318837d,BulkI
	D:2605131851135QSB0OWI,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a76782dc4eb911f1aa26b74ffac11d73-20260513
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 736620289; Wed, 13 May 2026 18:51:10 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 0/4] cgroup/rdma: add rdma.peak and rdma.events[.local]
Date: Wed, 13 May 2026 18:49:52 +0800
Message-ID: <20260513104956.373216-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9313C531A84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-15883-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pids.events:url]
X-Rspamd-Action: no action

Hi,

This is v2 of the RDMA cgroup observability series.  Thanks to the
reviewers for the detailed feedback on v1.  

This series adds new cgroup interface files to the RDMA controller
to improve observability of resource usage and limit enforcement:

  - rdma.peak:        per-device high watermark of resource usage
  - rdma.events:      hierarchical max and alloc_fail event counters
  - rdma.events.local: per-cgroup local max and alloc_fail counters

rdma.peak tracks the historical high watermark so administrators can
determine a sensible rdma.max based on actual peak demand rather than
guesswork.  This is directly analogous to memory.peak.

rdma.events and rdma.events.local provide per-device counters that
track how often resource limits block allocations, and can be monitored
via poll/epoll for real-time alerting.  Both files expose the same
keys (max and alloc_fail); rdma.events aggregates hierarchically while
rdma.events.local shows per-cgroup values.  This follows the
pids.events / pids.events.local design.

Patch overview:
  Patch 1 introduces rdma.peak, adding a per-resource peak field to track
  the high watermark of usage, updated only after a full hierarchical
  charge succeeds, and extends rpool lifetime to preserve non-zero
  peak values.
  Patch 2 adds rdma.events, which introduces rdmacg_event_locked() to
  propagate hierarchical max counters upward from the over-limit
  cgroup, with poll/epoll notification via cgroup_file_notify().
  Patch 3 adds rdma.events.local and hierarchical alloc_fail, extending
  the event framework with per-cgroup local counters (local_max for
  the over-limit cgroup, local_alloc_fail for the requesting cgroup)
  and a hierarchical alloc_fail counter propagated from the requestor
  upward.
  Patch 4 documents all three new interface files in cgroup-v2.rst.

Tao Cui (4):
  cgroup/rdma: add rdma.peak for per-device peak usage tracking
  cgroup/rdma: add rdma.events to track resource limit exhaustion
  cgroup/rdma: add rdma.events.local for per-cgroup allocation failure
    attribution
  cgroup/rdma: document rdma.peak, rdma.events and rdma.events.local

 Documentation/admin-guide/cgroup-v2.rst |  54 +++++++
 include/linux/cgroup_rdma.h             |   4 +
 kernel/cgroup/rdma.c                    | 180 ++++++++++++++++++++++++
 3 files changed, 238 insertions(+)

---
Changes in v2:
  - Fix peak updated before full hierarchical charge succeeds.
  - Use find_cg_rpool_locked() to avoid creating spurious rpools.
  - Replace atomic64_t with u64 + READ_ONCE (all under rdmacg_mutex).
  - Use key=value output format, remove trailing spaces.
  - Always list all devices, show zero for devices without an rpool.
  - Extend rpool-free condition to preserve non-zero event counters.
  - Rename "failcnt" to "alloc_fail" (cgroup v2 naming convention).
  - Fix alloc_fail semantics: local to the requesting cgroup only.
  - Add hierarchical alloc_fail to rdma.events for key consistency.
  - Add documentation in Documentation/admin-guide/cgroup-v2.rst.

v1:
  https://lore.kernel.org/all/20260512031719.273507-1-cuitao@kylinos.cn/
-- 
2.43.0


