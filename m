Return-Path: <cgroups+bounces-15690-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BwYFs0K/2mv1QAAu9opvQ
	(envelope-from <cgroups+bounces-15690-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 12:22:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883574FF348
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 12:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D34723007C91
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 10:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198693A1A41;
	Sat,  9 May 2026 10:21:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF034DCD7;
	Sat,  9 May 2026 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778322072; cv=none; b=UIxSOJUlOqDSJi4AfjR5M0AF2HCLD5Prc5Ji6aNQ2B4QXQxLQNfIr+K4KuA+QYBO3+jmHO3hJyrmSjD53uP+q9oIJFUTRaTLW/x8jYCSG1sLY5DnSx16rx826fvOzDzl+RFidgziX1RXdkpYSnUgahdWC+rpl6+2j0wstghI0YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778322072; c=relaxed/simple;
	bh=6835E2PRzdrd31nNd2DJIDB7DODiEHtT4mRk25j2zeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjzDLYTRHc1HWTjqh4Bm0gRmX4wOlFhHHa8HmVuH8871DXf5Lp/KN7IkcZlUa6LdyxLEzExGnEOP/g9H+WVcnjlOFanST/nsBUosMyFXn5S3KKvDZLyLTxfD4UKJdD7XyBf8DNWZuWrnittxTesxbrYlsMDW79TGrmdeu2AZIE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c7f073644b9011f1aa26b74ffac11d73-20260509
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CHARSET
	HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
	HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN
	HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS
	HR_TO_CHARSET, HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:04623cf2-4ce3-4e39-a232-a17e232e7935,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:04623cf2-4ce3-4e39-a232-a17e232e7935,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:40b5c49ee527a977d8cfcd881fb46d61,BulkI
	D:260509182103X6OSL6BC,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c7f073644b9011f1aa26b74ffac11d73-20260509
X-User: zhangguopeng@kylinos.cn
Received: from yan.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1971415662; Sat, 09 May 2026 18:21:02 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH v3 0/2] cgroup/cpuset: fix DL attach accounting
Date: Sat,  9 May 2026 18:20:29 +0800
Message-ID: <20260509102031.97608-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 883574FF348
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
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-15690-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.725];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid]
X-Rspamd-Action: no action

Hi,

This v3 series contains two cpuset fixes for SCHED_DEADLINE attach
accounting.

Patch 1 fixes an internal cpuset_can_attach() failure path where
temporary DL migration state can be left behind if a later per-task
check fails before cpuset marks attach_in_progress.

Patch 2 keeps cpuset DL bandwidth reservation aligned with the condition
used by set_cpus_allowed_dl() for source-side bandwidth removal. It keeps
counting all migrating DL tasks for cpuset task accounting, but reserves
destination DL bandwidth only for tasks that actually need a root-domain
bandwidth move.

Guopeng Zhang (2):
  cgroup/cpuset: reset DL migration state on can_attach() failure
  cgroup/cpuset: reserve DL bandwidth only for root-domain moves

 include/linux/sched/deadline.h  |  9 ++++++++
 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset.c          | 39 ++++++++++++++++++---------------
 kernel/sched/deadline.c         | 13 ++++++++---
 4 files changed, 41 insertions(+), 21 deletions(-)

---
Changes in v3:
- Patch 1: use common ret != 0 cleanup in cpuset_can_attach(), as
  suggested by Waiman Long and Chen Ridong.
- Patch 2: drop task_cpu_possible_mask() / attach-target-mask handling
  as suggested by Waiman Long.
- Patch 2: keep the change limited to reserving DL bandwidth only for
  tasks that need a root-domain bandwidth move.
- Leave the broader can_attach()/attach() transaction model unchanged.

Changes in v2:
- Split the original change into two patches.
- Add a separate fix for resetting pending DL migration state on
  cpuset_can_attach() failure.
- Clarify that nr_migrate_dl_tasks counts all migrating DL tasks for
  cpuset task accounting, while sum_migrate_dl_bw only tracks bandwidth
  needing destination root-domain reservation.

v2:
  https://lore.kernel.org/all/20260507103310.35849-1-zhangguopeng@kylinos.cn/

v1:
  https://lore.kernel.org/all/20260421083449.95750-1-zhangguopeng@kylinos.cn

-- 
2.43.0

