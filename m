Return-Path: <cgroups+bounces-14587-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMEsJRrip2mrlAAAu9opvQ
	(envelope-from <cgroups+bounces-14587-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 08:41:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5E1FBBC6
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 08:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AEE23032CE4
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 07:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC3036F438;
	Wed,  4 Mar 2026 07:38:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D036D9EB;
	Wed,  4 Mar 2026 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609893; cv=none; b=bFAz363/PxGtaVck+j68e7IuPXLB+rQWU0k0ZKmtf2VL8qfnogYmtPaPfSH4N+oDtfVEApUAh807q8MPvyPb+/ztLLOPXpdAaiGnqQ8sj/cfTuRh0l4YOJbve/9hbd0rjKEld6PS8Nl7HkA4CONTpLXlmbNGFh+3Bn0LsPBiFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609893; c=relaxed/simple;
	bh=f1bpQYIZui21k5bgNFbVyOEc+yWnqPnJhdVlPA/la6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V6IK4k5VtM5e3rqTVTFeZXPeK782Epp+GL6TuXf2+FDEbfbkhPcCguWpLHtREOY9LiXHi6Bb+OpMGw/2Ly9S6WE2cgiEWfyyNyLK7xXxlZefyl1XD5b/s1hhci9ztjPaKwL27oF3TM6pVCa6aIED5yWBj83RRpEUsz3BSOxs8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49943C19423;
	Wed,  4 Mar 2026 07:38:11 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zheng Qixing <zhengqixing@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 0/7] blk-cgroup: fix races related to blkg_list iteration
Date: Wed,  4 Mar 2026 15:38:01 +0800
Message-ID: <20260304073809.3438679-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1D5E1FBBC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14587-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fnnas.com:mid]
X-Rspamd-Action: no action

This series fixes several race conditions related to q->blkg_list iteration
and improves the locking around blkcg policy activation/deactivation.

Patch 1-2: Protect q->blkg_list iteration with blkcg_mutex in blkg_destroy_all()
and bfq_end_wr_async() to prevent races with blkg_free_workfn().

Patch 3-4: Fix use-after-free and memory leak issues in blkcg_activate_policy()
by extending blkcg_mutex coverage and skipping dying blkgs.

Patch 5: Refactor policy pd teardown into a helper function.

Patch 6: Restructure blkcg_activate_policy() to allocate pds before freezing
the queue, avoiding potential deadlocks from percpu allocation. Also fix
locking order in blkcg_deactivate_policy() to be consistent with
blkcg_activate_policy() (mutex -> freeze).

Patch 7: Move rq_qos_mutex handling inside rq_qos_add()/rq_qos_del() to
simplify the locking and eliminate potential deadlocks.

Note: queue_lock is still used in many places to protect queue blkg.
Future work is to convert it to blkcg_mutex entirely.

Changes v2 -> v3:
- Patch 2: Wrap mutex_lock/unlock with #ifdef CONFIG_BFQ_GROUP_IOSCHED to
  fix compile error when CONFIG_BLK_CGROUP is disabled.
- Patch 6: Fix locking order in blkcg_deactivate_policy() to match
  blkcg_activate_policy() (mutex -> freeze instead of freeze -> mutex).
- Patch 7: Remove stale lockdep_assert_held() in iolatency_set_limit().

Changes v1 -> v2:
- Link: https://lore.kernel.org/all/20260108014416.3656493-1-zhengqixing@huaweicloud.com/

Yu Kuai (4):
  blk-cgroup: protect q->blkg_list iteration in blkg_destroy_all() with
    blkcg_mutex
  bfq: protect q->blkg_list iteration in bfq_end_wr_async() with
    blkcg_mutex
  blk-cgroup: allocate pds before freezing queue in
    blkcg_activate_policy()
  blk-rq-qos: move rq_qos_mutex acquisition inside rq_qos_add/del

Zheng Qixing (3):
  blk-cgroup: fix race between policy activation and blkg destruction
  blk-cgroup: skip dying blkg in blkcg_activate_policy()
  blk-cgroup: factor policy pd teardown loop into helper

 block/bfq-cgroup.c    |   3 +-
 block/bfq-iosched.c   |   6 ++
 block/blk-cgroup.c    | 205 ++++++++++++++----------------------------
 block/blk-cgroup.h    |   2 -
 block/blk-iocost.c    |  11 +--
 block/blk-iolatency.c |   5 --
 block/blk-rq-qos.c    |  31 ++++---
 block/blk-wbt.c       |   2 -
 8 files changed, 97 insertions(+), 168 deletions(-)

-- 
2.51.0


