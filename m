Return-Path: <cgroups+bounces-15434-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NlSK1t852nC9QEAu9opvQ
	(envelope-from <cgroups+bounces-15434-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 15:32:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEA343B628
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41E263043D2E
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596A03D667F;
	Tue, 21 Apr 2026 13:29:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7D3CFF50;
	Tue, 21 Apr 2026 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776778165; cv=none; b=W1mPnVxWmQ3dby+W0FSJP8Fm4iWH2+BDsJYVyg+Z7AZlcg/03woYd+zICLyGjlWEV6Sq3FD4N927Xu2Xw29aPfm9pZ2km8sZmnBV+ct4MKFuuEY1vYxjEO0FxQBNxUAaphkAVo1dcPLWzLJOqrJ925CN5uXnMqMPytDIf9HVqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776778165; c=relaxed/simple;
	bh=PNaS1SHVm3s29Z3E1HbN6ZesriVMpiWEfrYL7UfpjJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DGv5ILkMFDUyVvfpIKw66p8pPUc0T5SlgB4Wvhz4X1yGrpwfOVfZniXzLACZk1MF/5T6/6rx0LD1tyZL3GAbFeZ6TWqurq2RoIdKjFVv/xHrmLA2B6y4aARlYyie6H33U2qiVskxD25JfxZerrh29BVEo0XPyHbFFCKRx9oZBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id E3B5623397;
	Tue, 21 Apr 2026 16:29:20 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] blk-cgroup: Reinit blkg_iostat_set after clearing in blkcg_reset_stats()
Date: Tue, 21 Apr 2026 16:29:20 +0300
Message-Id: <20260421132920.38748-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15434-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[altlinux.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NEQ_ENVFROM(0.00)[kovalev@altlinux.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,altlinux.org:mid,altlinux.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,foxmail.com:email]
X-Rspamd-Queue-Id: 1FEA343B628
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Waiman Long <longman@redhat.com>

[ Upstream commit 3d2af77e31ade05ff7ccc3658c3635ec1bea0979 ]

When blkg_alloc() is called to allocate a blkcg_gq structure
with the associated blkg_iostat_set's, there are 2 fields within
blkg_iostat_set that requires proper initialization - blkg & sync.
The former field was introduced by commit 3b8cc6298724 ("blk-cgroup:
Optimize blkcg_rstat_flush()") while the later one was introduced by
commit f73316482977 ("blk-cgroup: reimplement basic IO stats using
cgroup rstat").

Unfortunately those fields in the blkg_iostat_set's are not properly
re-initialized when they are cleared in v1's blkcg_reset_stats(). This
can lead to a kernel panic due to NULL pointer access of the blkg
pointer. The missing initialization of sync is less problematic and
can be a problem in a debug kernel due to missing lockdep initialization.

Fix these problems by re-initializing them after memory clearing.

Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
Fixes: f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230606180724.2455066-1-longman@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ Remove this line: bis -> blkg = blkg for blkg was introduced by commit
  3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()") since v6.2. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 0561aa6033dd181594116d705c41fc16e97161a2)
[ kovalev: bp to fix CVE-2023-53421 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 block/blk-cgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index dbd18b75ec91..7ffdc3360a6c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -464,8 +464,12 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 			struct blkg_iostat_set *bis =
 				per_cpu_ptr(blkg->iostat_cpu, cpu);
 			memset(bis, 0, sizeof(*bis));
+
+			/* Re-initialize the cleared blkg_iostat_set */
+			u64_stats_init(&bis->sync);
 		}
 		memset(&blkg->iostat, 0, sizeof(blkg->iostat));
+		u64_stats_init(&blkg->iostat.sync);
 
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
-- 
2.50.1


