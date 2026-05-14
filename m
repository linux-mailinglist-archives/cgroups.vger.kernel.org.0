Return-Path: <cgroups+bounces-15930-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FtxEjVxBWoTXAIAu9opvQ
	(envelope-from <cgroups+bounces-15930-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 08:52:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A260053E8D6
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 08:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1F6C3034A99
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 06:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC7D3ABD8E;
	Thu, 14 May 2026 06:50:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21D3A4F51
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741456; cv=none; b=Vv5wvTGBSfJjzJR1JNnXq2Zd88oGkYadR6NgrKZuiWOKC/Inrt8OKMH/U5E0o+qQqczJyTKmolgxiOMWtDy08f0iPVCFhBFna4T/XxEyNu2tqM7wqwNqTEGR3MtDEy+Tg+hvOtobGX5gKOWQTUJuwEYPgLS/i6RcQQzHrny64eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741456; c=relaxed/simple;
	bh=YFI56x5vTjqfxlEpo/mpbEkFxndcCuGIuWDwhJDSxpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TT9EoojF9M/wFdwchXUjSexaZYUTOsg62SIgzmGmNFOMx39uFFPWEjZPkjGNMarepiQzirMrAm6LAhb6N+qAAMkABBaAj8bxsYJZd2dzkDhg38axd2o90/iCeI3B7wTvI0TTWfDUofcuLNwjpHrx2nW4kPfiJBTA8QltrQ0aJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3d7aa55e4f6111f1aa26b74ffac11d73-20260514
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b67603c7-1e86-4e26-91d9-9ed65899d7fb,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.12,REQID:b67603c7-1e86-4e26-91d9-9ed65899d7fb,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:e7bac3a,CLOUDID:72eefe5db10bae2ae779a59ac769785c,BulkI
	D:260514145051X9P3K9S3,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3d7aa55e4f6111f1aa26b74ffac11d73-20260514
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1283525578; Thu, 14 May 2026 14:50:48 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v3 0/4] cgroup/rdma: add rdma.peak and rdma.events[.local]
Date: Thu, 14 May 2026 14:50:30 +0800
Message-ID: <20260514065034.387197-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A260053E8D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-15930-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid]
X-Rspamd-Action: no action

Hi,

This is v3 of the RDMA cgroup observability series.  Thanks to the
reviewers for the detailed feedback on v1 and v2.

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
  cgroup using get_cg_rpool_locked() to ensure full hierarchical
  coverage even for ancestors without a prior rpool, with poll/epoll
  notification via cgroup_file_notify().
  Patch 3 adds rdma.events.local and hierarchical alloc_fail, extending
  the event framework with per-cgroup local counters (local_max for
  the over-limit cgroup, local_alloc_fail for the requesting cgroup)
  and a hierarchical alloc_fail counter propagated from the requestor
  upward.  It also extracts the duplicated rpool-keep predicate into
  a rpool_has_persistent_state() helper and replaces the non-error
  goto dev_err in rdmacg_resource_set_max() with an if-guard.
  Patch 4 documents all three new interface files in cgroup-v2.rst.

Tao Cui (4):
  cgroup/rdma: add rdma.peak for per-device peak usage tracking
  cgroup/rdma: add rdma.events to track resource limit exhaustion
  cgroup/rdma: add rdma.events.local for per-cgroup allocation failure
    attribution
  cgroup/rdma: document rdma.peak, rdma.events and rdma.events.local

 Documentation/admin-guide/cgroup-v2.rst |  54 +++++++
 include/linux/cgroup_rdma.h             |   4 +
 kernel/cgroup/rdma.c                    | 199 ++++++++++++++++++++++--
 3 files changed, 247 insertions(+), 10 deletions(-)

---
Changes in v3:
  - Switch rdmacg_event_locked() from find_ to get_cg_rpool_locked()
    in hierarchical propagation loops (events_max and events_alloc_fail)
    to ensure full hierarchical coverage; the rpool-keep check now
    covers event counters, so spurious-rpool concern from v1 no longer
    applies.
  - Extract the duplicated rpool-keep predicate (peak + 4 event
    counters) into rpool_has_persistent_state() helper.
  - Replace the non-error goto dev_err in rdmacg_resource_set_max()
    with an if-guard so dev_err is only used for real error paths.
  - Fix commit message of rdma.events.local patch to mention the
    rdma.events hierarchical alloc_fail extension.
  - Use %llu and drop (s64) cast in rdmacg_events_show() and
    rdmacg_events_local_show() to match u64 counter type.

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
v2:
  https://lore.kernel.org/all/20260513104956.373216-1-cuitao@kylinos.cn/
-- 
2.43.0


