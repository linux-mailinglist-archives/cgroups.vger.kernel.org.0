Return-Path: <cgroups+bounces-15338-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LzeKM2r4Wl1wgAAu9opvQ
	(envelope-from <cgroups+bounces-15338-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 05:41:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D63C416A56
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 05:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9242D303028F
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 03:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FDC334C17;
	Fri, 17 Apr 2026 03:38:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D85286AC;
	Fri, 17 Apr 2026 03:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397122; cv=none; b=VFOVC2TqCnGOvY+W57Dela4i8K7MncgmBt9RSqIHnxRGxIkZekvlJUFI8jLaMgDgozwWg9T+0BW64kDs5q10dFzntr5ZzwuqBjZaZdOD3Nrmrb3xAJceJjfP6juGf0e/6hr8kShme+mvCNE5gIF8lURGzZ7tK+qMB9bRvyTNWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397122; c=relaxed/simple;
	bh=aShfdK9MvlNYlLeAMRP0BTKdPnnfUm9rjkK3DECKDjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkahbDBVZPfOxWyDRW/GldqQHiByWTIvJ0r+5BsWFef31/8DFITMmcOQp9wQxokfUlW20q4hYbSE94w8wFBSyMxQUJAjtC5NYA2fJYCAsmdvtdUq666xsCzU3hXa69L1rOpCT0aE3v9wUntihC4J42A31NySYEoZzE8b4ZWqijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e792f4fa3a0e11f1aa26b74ffac11d73-20260417
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
X-CID-O-INFO: VERSION:1.3.12,REQID:e501130b-3f71-4270-91d4-5e67a25c92ba,IP:10,
	URL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:-45
X-CID-INFO: VERSION:1.3.12,REQID:e501130b-3f71-4270-91d4-5e67a25c92ba,IP:10,UR
	L:0,TC:0,Content:-25,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:NOTI_GNA5D1EA,A
	CTION:release,TS:-45
X-CID-META: VersionHash:e7bac3a,CLOUDID:20167e21a3d88a3a306d33e4c403286f,BulkI
	D:2604171138334ZKLAGK4,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:2|44,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_EDM_RNO,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e792f4fa3a0e11f1aa26b74ffac11d73-20260417
X-User: zhangguopeng@kylinos.cn
Received: from yan.. [(183.242.174.22)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1543285358; Fri, 17 Apr 2026 11:38:31 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	shuah@kernel.org,
	chenridong@huaweicloud.com
Cc: cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH 0/2] cgroup/cpuset: fix DL rollback accounting and add a selftest
Date: Fri, 17 Apr 2026 11:37:40 +0800
Message-ID: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
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
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-15338-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D63C416A56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series fixes a cpuset DL bandwidth rollback bug and adds a selftest to cover it.

cpuset_can_attach() only reserves deadline bandwidth when migrating DL
tasks to a disjoint CPU mask, but cpuset_cancel_attach() rolls back based
only on the presence of migrating DL tasks. This makes the rollback path
asymmetric: it can call dl_bw_free() even when no dl_bw_alloc() was done.
Because the alloc and free CPU selection also differed, rollback could
return bandwidth to a different root domain than the one originally
charged.

Patch 1 fixes the rollback accounting by recording the CPU used for
dl_bw_alloc() during attach and using that exact state in
cpuset_cancel_attach(). If no allocation happened, rollback skips
dl_bw_free(). Successful attach behavior is unchanged.

Patch 2 adds a sched_ext selftest which exercises the real attach
rollback path from userspace. The test uses a sched_ext scheduler whose
cgroup_prep_move() rejects SCHED_DEADLINE tasks so that the cpu
controller fails after cpuset has already accepted the move. It then
checks that dl_bw->total_bw on the target CPU remains unchanged across
the failed move.

Local testing:

With patch 1:
ok 1 cpuset_dl_rollback

Without patch 1:
ERR: cpuset_dl_rollback.c:760
Expected total_bw for CPU0 to remain unchanged (1677696 != 2027221)
not ok 1 cpuset_dl_rollback

Guopeng Zhang (2):
  cgroup/cpuset: record DL BW alloc CPU for attach rollback
  selftests/sched_ext: add cpuset DL rollback test

 kernel/cgroup/cpuset-internal.h               |   5 +
 kernel/cgroup/cpuset.c                        |  13 +-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../sched_ext/cpuset_dl_rollback.bpf.c        |  28 +
 .../selftests/sched_ext/cpuset_dl_rollback.c  | 810 ++++++++++++++++++
 5 files changed, 853 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/cpuset_dl_rollback.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/cpuset_dl_rollback.c

-- 
2.43.0


