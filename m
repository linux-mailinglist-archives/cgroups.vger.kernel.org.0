Return-Path: <cgroups+bounces-630-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5517FC70F
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 22:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE3A1C211DA
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A8E44C7B;
	Tue, 28 Nov 2023 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMrcS4Cs"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19AA44C73;
	Tue, 28 Nov 2023 21:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5BAC43397;
	Tue, 28 Nov 2023 21:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205681;
	bh=02A/pt0jlQKBJvA66EUJWQd5GpOAbf2oDomvdzkTPvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMrcS4CseiI8bT1AhHBhA0C3Fk2htzksSo1GGO29bf1hUeVWxKqXY7Rq6snSQKThp
	 lyAV+flonifENCYW46hbeLu7YWmQpgYqSv+mgpNz4+UYKhlCRh2d8qqrHvGndkFM61
	 d/rFnVWHFpeZ56wxJ2cvF3etXN+3/ISfXW128Eiqd5RF5UzzoEOWnL1YHLTCAzOrMq
	 VB80az/9KmELiKz8m/TAWtdlveUHCxo0khKAxsngS1pi66VVT3hZ3p4xWaupM4JGlg
	 UKBMTGXJ2zJ8oQtrQKIjUCGuk/AdrSRuKQmziB02g9l5VUUhdgevYVwoHFOzu5n3xw
	 slLGRkNKlOtrA==
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
Subject: [PATCH AUTOSEL 6.1 04/25] blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"
Date: Tue, 28 Nov 2023 16:07:20 -0500
Message-ID: <20231128210750.875945-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210750.875945-1-sashal@kernel.org>
References: <20231128210750.875945-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.64
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
index 009b0d76bf036..62a3f62316df1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1333,6 +1333,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		   tg_bps_limit(tg, READ), tg_bps_limit(tg, WRITE),
 		   tg_iops_limit(tg, READ), tg_iops_limit(tg, WRITE));
 
+	rcu_read_lock();
 	/*
 	 * Update has_rules[] flags for the updated tg's subtree.  A tg is
 	 * considered to have rules if either the tg itself or any of its
@@ -1360,6 +1361,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		this_tg->latency_target = max(this_tg->latency_target,
 				parent_tg->latency_target);
 	}
+	rcu_read_unlock();
 
 	/*
 	 * We're already holding queue_lock and know @tg is valid.  Let's
-- 
2.42.0


