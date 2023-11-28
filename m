Return-Path: <cgroups+bounces-631-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 207227FC714
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 22:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6590B25086
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8244C8B;
	Tue, 28 Nov 2023 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqV0e0Z6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5344C73;
	Tue, 28 Nov 2023 21:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC66C433CA;
	Tue, 28 Nov 2023 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205683;
	bh=B6jdAq523tUTjoQ/nCF3xKon70u7LX+Geuk+Zb+g6Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqV0e0Z6x5uPyZ+oCWXC3AwUalzh4Q1FYVS1NrD4Oar2zOBmB851+5Q6twvWjulCv
	 +OnN5Pjvb1l1aUMyC6mibXOsgwlIUj46oaHdy+U74fT9TnVGTEjLyfCBNLzDWb6uER
	 DzM2q1302mUKkA8qq9oGBt6ODZt2rEaoh0H5Ff2ozWjauxzOIH1CAMFcEGlKzSKm+q
	 aCtysG2bSLFOK13or5NH5BsjWySadT/zzGm/trKN1+CuvqPNuqCeLuQ2lPSv4aE0o7
	 5aXWSa5s/NmCw4wqHD2T/CbFBeDhLVaUiiYKmiWD0U23pM1E7FHWQE5dIkF+dUfLzf
	 C269ev8dJE91w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	tj@kernel.org,
	josef@toxicpanda.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/25] blk-cgroup: bypass blkcg_deactivate_policy after destroying
Date: Tue, 28 Nov 2023 16:07:21 -0500
Message-ID: <20231128210750.875945-5-sashal@kernel.org>
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

[ Upstream commit e63a57303599b17290cd8bc48e6f20b24289a8bc ]

blkcg_deactivate_policy() can be called after blkg_destroy_all()
returns, and it isn't necessary since blkg_destroy_all has covered
policy deactivation.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20231117023527.3188627-4-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 60f366f98fa2b..1b7fd1fc2f337 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -462,6 +462,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg, *n;
 	int count = BLKG_DESTROY_BATCH_SIZE;
+	int i;
 
 restart:
 	spin_lock_irq(&q->queue_lock);
@@ -487,6 +488,18 @@ static void blkg_destroy_all(struct gendisk *disk)
 		}
 	}
 
+	/*
+	 * Mark policy deactivated since policy offline has been done, and
+	 * the free is scheduled, so future blkcg_deactivate_policy() can
+	 * be bypassed
+	 */
+	for (i = 0; i < BLKCG_MAX_POLS; i++) {
+		struct blkcg_policy *pol = blkcg_policy[i];
+
+		if (pol)
+			__clear_bit(pol->plid, q->blkcg_pols);
+	}
+
 	q->root_blkg = NULL;
 	spin_unlock_irq(&q->queue_lock);
 }
-- 
2.42.0


