Return-Path: <cgroups+bounces-2670-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5038AE4AF
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 13:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C041C22C86
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB813E3EA;
	Tue, 23 Apr 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP8f49jh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE513E04F;
	Tue, 23 Apr 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872456; cv=none; b=nKrItd9HfMlUgwMk0F9ludd41YT3/lboN7vZ7YDMSwqiiIMFDG7nslJARkkL8/eRquaXcZ6U2LSLS4g85NUcrkii8LI4IoRH4tZaslJycTuOHfUH1rlhIcDH2Ixh4ztuA7DygOs05kNF4ybOjSBHqzEZh/MD7gxfkZXeLZ90vM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872456; c=relaxed/simple;
	bh=4g0p/N75RcsA9tw6EzoYo7lJL11XjAoHwbaElJQ0eXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq9IFKDBTR2qTVD23wQPCOk7m44ocO6fD4Yvm0zVM/MPDEuvnETMRg4o6YSkKjk9TTLfCB5QLuQ4JVTQL33k6f07K25XnUdHSAvq/0rxewTKIokJpSSKySAwwv0Wh+Jmx3uSPHx/HAngaQG45lk9aIgu0H3EJb3dJZb0MxUx9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qP8f49jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477EBC3277B;
	Tue, 23 Apr 2024 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872456;
	bh=4g0p/N75RcsA9tw6EzoYo7lJL11XjAoHwbaElJQ0eXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qP8f49jhoReQ+QzJI13lpFWv9+RLGpv7kyNPIXO3b0IAELyHRHwGR5TLOA5iWFLhg
	 hcADCbRBrCWUjhNEGBJ7D4+qNkvHI4paCPETWNbToXHPXG9D3kpWzmSD9dtqKYg/2R
	 gQ5Bc4JY8JOB45ZNPGixD5qYC3Zq/smhanYa3NsanTAkBhwCMjKiH7TQ4av739vxu7
	 M1OQQuM2aLHs0v2sp7UC2p/U1N9Mqg4AJf3S4L4/S+SyU444yRu5iIIOiegmtJbTl2
	 mvOyU6XoScVsdbJ7rB9sTr4GhUf1I40c4xezkahAoPmksMW94BM9Mdu2TmGz9SSi4f
	 YLpsHGs/voMYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	josef@toxicpanda.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/16] blk-iocost: do not WARN if iocg was already offlined
Date: Tue, 23 Apr 2024 07:01:49 -0400
Message-ID: <20240423110151.1658546-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Li Nan <linan122@huawei.com>

[ Upstream commit 01bc4fda9ea0a6b52f12326486f07a4910666cf6 ]

In iocg_pay_debt(), warn is triggered if 'active_list' is empty, which
is intended to confirm iocg is active when it has debt. However, warn
can be triggered during a blkcg or disk removal, if iocg_waitq_timer_fn()
is run at that time:

  WARNING: CPU: 0 PID: 2344971 at block/blk-iocost.c:1402 iocg_pay_debt+0x14c/0x190
  Call trace:
  iocg_pay_debt+0x14c/0x190
  iocg_kick_waitq+0x438/0x4c0
  iocg_waitq_timer_fn+0xd8/0x130
  __run_hrtimer+0x144/0x45c
  __hrtimer_run_queues+0x16c/0x244
  hrtimer_interrupt+0x2cc/0x7b0

The warn in this situation is meaningless. Since this iocg is being
removed, the state of the 'active_list' is irrelevant, and 'waitq_timer'
is canceled after removing 'active_list' in ioc_pd_free(), which ensures
iocg is freed after iocg_waitq_timer_fn() returns.

Therefore, add the check if iocg was already offlined to avoid warn
when removing a blkcg or disk.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20240419093257.3004211-1-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 7ee8d85c2c68d..b2e913fe61e67 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1438,8 +1438,11 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
 	lockdep_assert_held(&iocg->ioc->lock);
 	lockdep_assert_held(&iocg->waitq.lock);
 
-	/* make sure that nobody messed with @iocg */
-	WARN_ON_ONCE(list_empty(&iocg->active_list));
+	/*
+	 * make sure that nobody messed with @iocg. Check iocg->pd.online
+	 * to avoid warn when removing blkcg or disk.
+	 */
+	WARN_ON_ONCE(list_empty(&iocg->active_list) && iocg->pd.online);
 	WARN_ON_ONCE(iocg->inuse > 1);
 
 	iocg->abs_vdebt -= min(abs_vpay, iocg->abs_vdebt);
-- 
2.43.0


