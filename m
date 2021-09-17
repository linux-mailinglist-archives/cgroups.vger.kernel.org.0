Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A810C40EF9C
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 04:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbhIQCg7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Sep 2021 22:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243079AbhIQCgQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 16 Sep 2021 22:36:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF68B61216;
        Fri, 17 Sep 2021 02:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631846095;
        bh=CRf4pmmB42oIEfAQAof8E/B+8MPRPrSI6N0MyPDOqts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCaV+8XqqfBHz5YbUZf+Plnvr9x15+G+PBKaaxn3YtuPuKS3YIp993qw7oWy3pS84
         RS1XjPlS4+Ic8kAD3Y4JkIuYLwVBoFSMPiVehofGo8LbMe90HslGe526/yhyMNG4Oo
         6XsWnApbIKJO1lXapO4hj6xfs0cLZZO+8SHnNeD2FYepwedaSp9k3NY0snBD6LVQLr
         WFjFSPGPPUclS51MPW+m+Cc6/OSFu685ss98jEh1bpWE68Ju3FuG26H6V18r0E+05w
         Bb5pKCUc3+yalOK9+Dlh2HrjPRPfa01bMAM4jnY8i2vJI23jIx91WPeGABT1oi5nx/
         oV3YQo2wolGgg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Jinlin <lijinlin3@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, tj@kernel.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/5] blk-throttle: fix UAF by deleteing timer in blk_throtl_exit()
Date:   Thu, 16 Sep 2021 22:34:48 -0400
Message-Id: <20210917023449.816713-4-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210917023449.816713-1-sashal@kernel.org>
References: <20210917023449.816713-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Li Jinlin <lijinlin3@huawei.com>

[ Upstream commit 884f0e84f1e3195b801319c8ec3d5774e9bf2710 ]

The pending timer has been set up in blk_throtl_init(). However, the
timer is not deleted in blk_throtl_exit(). This means that the timer
handler may still be running after freeing the timer, which would
result in a use-after-free.

Fix by calling del_timer_sync() to delete the timer in blk_throtl_exit().

Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
Link: https://lore.kernel.org/r/20210907121242.2885564-1-lijinlin3@huawei.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-throttle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 18f773e52dfb..bd870f9ae458 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2414,6 +2414,7 @@ int blk_throtl_init(struct request_queue *q)
 void blk_throtl_exit(struct request_queue *q)
 {
 	BUG_ON(!q->td);
+	del_timer_sync(&q->td->service_queue.pending_timer);
 	throtl_shutdown_wq(q);
 	blkcg_deactivate_policy(q, &blkcg_policy_throtl);
 	free_percpu(q->td->latency_buckets[READ]);
-- 
2.30.2

