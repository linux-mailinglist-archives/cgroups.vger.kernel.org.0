Return-Path: <cgroups+bounces-10706-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6153FBD7156
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 04:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E19F4F6C72
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 02:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427AC305053;
	Tue, 14 Oct 2025 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KpqpeIje"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B83304BC7;
	Tue, 14 Oct 2025 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408939; cv=none; b=Vjw++J2UPrK7ohjMtKl0RFE8tHykxatXNQfA5TQSR1GX0/BACyp1H1IPyfvd7BCqoK/I1QsyuM1DHOEGyHsUCm4UGHqfI4os7GQsnkYuwsXRpyn6nTMYm29HOCPOqOheeTuWDBlwD09Xib1lTM6imYth8I2+qdDszAGusT5Mt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408939; c=relaxed/simple;
	bh=83LxqPSmaKqT6oPSJNHpuHnNWWtKTdxRlFfa9O0QxG8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k/VOvOdQF2fyYdwe1Y1C9Lqcqqv5tH18youcxOfeyCreIo/l43WyIgrXt6gJiPmSu4Dyu8IqfSzXqpGCpyQU0eOk/BAbUay8+n+QCA3v4DnF3IlPc5mQudDeJm8xhVmPXshJVVAU86I+ZtrhdgVtTInd9+wYAcymEc8zzwqekTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KpqpeIje; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=spUlGNd3PRzUgzFG5DqbOsYzvbtVh170NkQNmyFlJH4=;
	b=KpqpeIjejPqM3yW1Ucg+Fo0oxu+g/zUexI2WVDDmmAIo39NPPSOSle3AwB9FRYGwNyTqYG6Q4
	z63Me3FPkYDkJ4SGu0L4qA5vRtQCYGNyTt0r6IWxvvuWXPDzonSscgUsCxGvzWIKScg+iB1YOr+
	vfjTfKmBmyibTdTwyROaATU=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4clymq362mzpSwb;
	Tue, 14 Oct 2025 10:27:55 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
	by mail.maildlp.com (Postfix) with ESMTPS id C467D1402DA;
	Tue, 14 Oct 2025 10:28:47 +0800 (CST)
Received: from huawei.com (10.50.87.129) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 14 Oct
 2025 10:28:47 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <nilay@linux.ibm.com>, <ming.lei@redhat.com>, <tj@kernel.org>,
	<josef@toxicpanda.com>, <axboe@kernel.dk>
CC: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<johnny.chenyi@huawei.com>
Subject: [PATCH 0/4] blk-rq-qos: fix possible deadlock
Date: Tue, 14 Oct 2025 10:21:45 +0800
Message-ID: <20251014022149.947800-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500007.china.huawei.com (7.202.194.92)

Currently rq-qos debugfs entries is created from rq_qos_add(), while
rq_qos_add() requires queue to be freezed. This can deadlock because

creating new entries can trigger fs reclaim.

Fix this problem by delaying creating rq-qos debugfs entries until
it's initialization is complete.

- For wbt, it can be initialized by default of by blk-sysfs, fix it by
  delaying after wbt_init();
- For other policies, they can only be initialized by blkg configuration,
  fix it by delaying to blkg_conf_end();

Noted this set is cooked on the top of my other thread:
https://lore.kernel.org/all/20251010091446.3048529-1-yukuai@kernel.org/

And the deadlock can be reporduced with above thead, by running blktests
throtl/001 with wbt enabled by default. While the deadlock is really a
long term problem.

BTW, it's probably better to fix this problem before the above huge
refactor, I'm sending this set anyway to make sure if people will aggree
about the solution.

Yu Kuai (4):
  blk-mq-debugfs: warn about possible deadlock
  blk-mq-debugfs: factor out a helper blk_mq_debugfs_register_rq_qos()
  blk-rq-qos: fix possible deadlock
  blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static

 block/blk-cgroup.c     |  6 +++++
 block/blk-mq-debugfs.c | 58 ++++++++++++++++++++++++++++++------------
 block/blk-mq-debugfs.h |  4 +--
 block/blk-rq-qos.c     |  7 -----
 block/blk-sysfs.c      |  4 +++
 block/blk-wbt.c        |  7 ++++-
 6 files changed, 60 insertions(+), 26 deletions(-)

-- 
2.39.2


