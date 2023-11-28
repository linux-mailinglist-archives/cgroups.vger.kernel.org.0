Return-Path: <cgroups+bounces-636-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A9B7FC799
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 22:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B7F1C211A8
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 21:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7E750266;
	Tue, 28 Nov 2023 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK9pGEHE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8E42ABF;
	Tue, 28 Nov 2023 21:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5570FC433AB;
	Tue, 28 Nov 2023 21:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205804;
	bh=OMDZ9fqASL7nffEFfENMmnry5V0Pn1SmoWTR5bFEqlE=;
	h=From:To:Cc:Subject:Date:From;
	b=lK9pGEHEsC/ILGl0AHGYsGUmHDD0NBfZYEi0+f1k4hHVt4gUMsYo3UNhwFBTuIE8P
	 qhldBZewe5b/P0jvsXyqDlZM0Lm9MiGlQYiIw1L/8LF2YkXGf40ntgY9AX2po7yhHQ
	 lrvoKXP85wVdZeVDxzaw8O6MgyR6S1kUS/nNwXSIMiMUEjzRePcCNjI3T/Umchr4Ri
	 WQbGHPiuT7Zmv07XFqCJVlHDCRAULqlG9aIL/vIvEXPFs10edHWJ9uLSe8hInf4A9r
	 WGvAslYZVWF2SO7lelmYZULA4eMoMg/O006P7rRu3gIkBUMB5siu37c0IY5ErCl7dk
	 Pis+3GTHd5B6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Changhui Zhong <czhong@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	tj@kernel.org,
	josef@toxicpanda.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/10] blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"
Date: Tue, 28 Nov 2023 16:09:50 -0500
Message-ID: <20231128211001.877333-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.300
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 27b13e209ddca5979847a1b57890e0372c1edcee ]

Inside blkg_for_each_descendant_pre(), both
css_for_each_descendant_pre() and blkg_lookup() requires RCU read lock,
and either cgroup_assert_mutex_or_rcu_locked() or rcu_read_lock_held()
is called.

Fix the warning by adding rcu read lock.

Reported-by: Changhui Zhong <czhong@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20231117023527.3188627-2-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-throttle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 853b1770df367..e58c03c504c10 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1383,6 +1383,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		   tg_bps_limit(tg, READ), tg_bps_limit(tg, WRITE),
 		   tg_iops_limit(tg, READ), tg_iops_limit(tg, WRITE));
 
+	rcu_read_lock();
 	/*
 	 * Update has_rules[] flags for the updated tg's subtree.  A tg is
 	 * considered to have rules if either the tg itself or any of its
@@ -1410,6 +1411,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		this_tg->latency_target = max(this_tg->latency_target,
 				parent_tg->latency_target);
 	}
+	rcu_read_unlock();
 
 	/*
 	 * We're already holding queue_lock and know @tg is valid.  Let's
-- 
2.42.0


