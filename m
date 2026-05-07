Return-Path: <cgroups+bounces-15654-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG0KGo9q/Gn0PgAAu9opvQ
	(envelope-from <cgroups+bounces-15654-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 12:33:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BF14E6D2E
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 12:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 223FE300601D
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715FA3E959C;
	Thu,  7 May 2026 10:33:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9612265CDD;
	Thu,  7 May 2026 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150023; cv=none; b=W3u+nWHYrUdKTkc6ZP0TcGhhvvmT6d9BjpAGEhe0boPp7/qrO1PQyo1wtPQNosxPHCNfWTNj2NVX9itdUQp7ys06mC54u8EDRlWrLi0Aek0Lzmf0gHOTUAFe5B2cA64r5NClx90ihCaji+9ZC4f/46pBL+wa4sGO6DhM/wZxmxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150023; c=relaxed/simple;
	bh=QBgdPnv+txS3w19bCvvAFrtvt8ziztHBy1rj/tW+GUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vl86JOoqApbH0G811Q7enMrxgjXCChWaN6gbRcw+5dckmHGuejFmCGhZXM9dEQI7E/D65gRn0nsk05c5eZn+pAQBuieElce9U5jfiDSMdWpdBRum5iEaNsptYvxc3K6rtnrUd4nseEe/jcZPeBAoavQPyRBSjlCrVoVVMDNkZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 32bc2bbc4a0011f1aa26b74ffac11d73-20260507
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CHARSET
	HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
	HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN
	HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS
	HR_TO_CHARSET, HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:032ef9d8-fb00-404f-ac08-3585c05a1562,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:032ef9d8-fb00-404f-ac08-3585c05a1562,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:3b0079b95154bd1db8da9a43230d314f,BulkI
	D:2605071833362ZLU9Z3U,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 32bc2bbc4a0011f1aa26b74ffac11d73-20260507
X-User: zhangguopeng@kylinos.cn
Received: from yan.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 576330279; Thu, 07 May 2026 18:33:33 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: [PATCH v2 0/2] cgroup/cpuset: fix DL attach bandwidth accounting
Date: Thu,  7 May 2026 18:33:08 +0800
Message-ID: <20260507103310.35849-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 71BF14E6D2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-15654-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.913];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

cpuset_can_attach() and set_cpus_allowed_dl() must make the same
decision about whether migrating a SCHED_DEADLINE task requires moving
bandwidth accounting between root domains.

The can_attach path used the destination cpuset effective CPU mask for
that decision. The attach path, however, applies a per-task target mask
which is constrained by task_cpu_possible_mask(), cpu_active_mask, and
the fallback walk up the cpuset hierarchy. On asymmetric CPU systems,
that per-task mask can be a strict subset of the destination cpuset
effective mask. This can make cpuset_can_attach() skip destination
bandwidth reservation while set_cpus_allowed_dl() later performs the
source-side bandwidth subtraction.

There is also an internal cpuset_can_attach() failure path where
temporary DL migration state can be left behind if a later per-task
check fails before cpuset marks attach_in_progress.

Patch 1 resets the temporary DL migration state on those internal
cpuset_can_attach() failure paths.

Patch 2 computes the same per-task target mask in cpuset_can_attach()
that cpuset_attach_task() later applies, and only includes DL tasks that
actually need a root-domain bandwidth move in the destination bandwidth
reservation.

The broader can_attach()/attach() transaction window is left unchanged.
This series does not attempt to rework sched_setattr() or source cpuset
resmask TOCTOU issues. It only aligns the reservation decision with the
attach-time bandwidth move decision and fixes the temporary state leak.

Guopeng Zhang (2):
  cgroup/cpuset: reset DL migration state on can_attach() failure
  cgroup/cpuset: align DL bandwidth reservation with attach target mask

 include/linux/sched/deadline.h  |   9 +++
 kernel/cgroup/cpuset-internal.h |   1 +
 kernel/cgroup/cpuset.c          | 105 ++++++++++++++++++++++----------
 kernel/sched/deadline.c         |  13 +++-
 4 files changed, 92 insertions(+), 36 deletions(-)

---
Changes since v1:
- Split the original patch into two patches.
- Reset temporary DL migration state on cpuset_can_attach() internal
  failure paths.
- Computed the same per-task attach mask in cpuset_can_attach() as
  cpuset_attach_task().
- Kept nr_migrate_dl_tasks counting all migrating DL tasks for cpuset
  task accounting, while restricting sum_migrate_dl_bw to tasks that need
  destination DL bandwidth reservation.
- Tightened Fixes tags.
- Documented the existing aggregate reservation invariant near the
  dl_bw_cpu selection.
- Removed the unnecessary RCU guard from dl_task_needs_bw_move().

v1:
  https://lore.kernel.org/all/20260421083449.95750-1-zhangguopeng@kylinos.cn

-- 
2.43.0

