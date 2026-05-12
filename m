Return-Path: <cgroups+bounces-15806-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOrNBR2cAmrxuwEAu9opvQ
	(envelope-from <cgroups+bounces-15806-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 05:18:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6642F519354
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 05:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFF97301B725
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 03:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B132248A0;
	Tue, 12 May 2026 03:18:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D151F5EA
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778555929; cv=none; b=RDzJzGSsqkcjo8j24gyIo9A8PnsAw2zBd4OVsq9UQmnknxQ+Vi2vy8CmYSWqR2Bgv90nzwydU8emTIRBOVOUSw5ExZ49FGKd9zXDaqVT3VMH4D5ILxguiKZG2MO+gc+V70aG3k/jGbMxFDeC+nbk/1aH0De+bpwuAe+p6X0suXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778555929; c=relaxed/simple;
	bh=SrKPg3rvkvlslder2SZYpM5Y4rHZKo28ZpwIR6ADxyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLqLNtvkOmQGTfzQY9qGnftaNEvhg79aJub8zZw1rB8xJLJxZjTkLomBXuLxIQf0X1O2d+GgsQeByZ0cdfOFGdU6BoWOskX4tn66c5Nsv1JvrrG7n5q6TF/ElX1+mLcFYr8ot1DNO57hV7FCNAmt93876RK6iktmultbuewHIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 46ccfb7c4db111f1aa26b74ffac11d73-20260512
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
X-CID-O-INFO: VERSION:1.3.12,REQID:25df06ff-0597-4cdf-8547-34fb7205ef95,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.12,REQID:25df06ff-0597-4cdf-8547-34fb7205ef95,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:e7bac3a,CLOUDID:5f7a592576fe785269b291c9f69e8b70,BulkI
	D:260512111843W6E5H62R,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 46ccfb7c4db111f1aa26b74ffac11d73-20260512
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 785014899; Tue, 12 May 2026 11:18:41 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/3] cgroup/rdma: add rdma.peak and rdma.events[.local]
Date: Tue, 12 May 2026 11:17:16 +0800
Message-ID: <20260512031719.273507-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6642F519354
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
	TAGGED_FROM(0.00)[bounces-15806-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.687];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid,rdma.events:url]
X-Rspamd-Action: no action

Hi,

This series adds three new cgroup interface files to the RDMA controller
to improve observability of resource usage and limit enforcement:

  - rdma.peak:        per-device high watermark of resource usage
  - rdma.events:      hierarchical max event counters
  - rdma.events.local: per-cgroup local max and failcnt counters

Why these interfaces?

Currently rdma.current only shows the instantaneous resource usage per
device.  Administrators who need to set appropriate rdma.max limits have
no way to observe usage spikes or detect when limits are being hit.

rdma.peak addresses the observability gap: it tracks the historical high
watermark so administrators can determine a sensible rdma.max based on
actual peak demand rather than guesswork.  This is directly analogous to
memory.peak.

rdma.events and rdma.events.local address the notification gap: they
provide per-device counters that track how often resource limits block
allocations, and can be monitored via poll/epoll for real-time alerting
when a cgroup hits its rdma.max.  This follows the pids.events /
pids.events.local design, where events are attributed to the cgroup
whose limit was exceeded rather than the cgroup where the allocation was
attempted.

Patch overview:

  Patch 1: rdma.peak
    Adds peak tracking in the charge path and the rdma.peak interface
    file.  rpools are kept alive while peak is non-zero so the values
    persist as historical records.

  Patch 2: rdma.events
    Adds hierarchical max event counters that propagate upward from the
    cgroup whose limit was hit.  Introduces rdmacg_event_locked() and
    the rdma.events interface file with poll notification support.

  Patch 3: rdma.events.local
    Extends the event infrastructure with per-cgroup local counters:
    local max counts how often this cgroup's limit blocked an allocation,
    failcnt counts how often allocations from this subtree were rejected.
    Adds the rdma.events.local interface file.

These patches have been tested locally.

Tao Cui (3):
  cgroup/rdma: add rdma.peak for per-device peak usage tracking
  cgroup/rdma: add rdma.events to track resource limit exhaustion
  cgroup/rdma: add rdma.events.local for per-cgroup allocation failure
    attribution

 include/linux/cgroup_rdma.h |   4 +
 kernel/cgroup/rdma.c        | 165 +++++++++++++++++++++++++++++++++++-
 2 files changed, 165 insertions(+), 4 deletions(-)

-- 
2.43.0


