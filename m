Return-Path: <cgroups+bounces-628-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6325C7FC6BE
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 22:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0272854A8
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 21:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8AE42A9F;
	Tue, 28 Nov 2023 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igFjAcK9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E742A99;
	Tue, 28 Nov 2023 21:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57823C433CD;
	Tue, 28 Nov 2023 21:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205589;
	bh=jHQHIXl0xO48jebk8B97gUWZa/J0o18AtfcAttsPF/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igFjAcK9jtQjQnibaCpVEgTd5X+X9x7e2Fg66+3navsjU78CJAisPDUI5N7WtdDLL
	 BsDpxodO/hi1fagToM0bS4fM/XyBZV417P5qmxM0tcoNLNa67rMJgWS2v6qVey+E/c
	 mrYVdnn544SgwOzOA5lGUcEg2tr9jsi47lMLCYKRma6ja/pzlD3ttZUS1dAAIZk3jN
	 hjTmcqqrLrJsETlh7uwX4X9PFmxmLFmllboNtjbudGpVNmc2fOLMrsgulhcf0HKSBD
	 p6P0uUEucqD9EYuQQ5KWY700ZSvF0xr63kbNWh4R3IlnBZ7yIphsWS7wBpmaiMcS6y
	 QOCkqXmFpfdXg==
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
Subject: [PATCH AUTOSEL 6.6 05/40] blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"
Date: Tue, 28 Nov 2023 16:05:11 -0500
Message-ID: <20231128210615.875085-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
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
index 13e4377a8b286..16f5766620a41 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1320,6 +1320,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		   tg_bps_limit(tg, READ), tg_bps_limit(tg, WRITE),
 		   tg_iops_limit(tg, READ), tg_iops_limit(tg, WRITE));
 
+	rcu_read_lock();
 	/*
 	 * Update has_rules[] flags for the updated tg's subtree.  A tg is
 	 * considered to have rules if either the tg itself or any of its
@@ -1347,6 +1348,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		this_tg->latency_target = max(this_tg->latency_target,
 				parent_tg->latency_target);
 	}
+	rcu_read_unlock();
 
 	/*
 	 * We're already holding queue_lock and know @tg is valid.  Let's
-- 
2.42.0


