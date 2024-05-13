Return-Path: <cgroups+bounces-2863-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB118C4094
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2024 14:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BF01F21B3F
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2024 12:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0692514F13E;
	Mon, 13 May 2024 12:19:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592314D2BF;
	Mon, 13 May 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715602759; cv=none; b=g+IX9AyHIsItsdh07nEWCJvBuW9eqkxRvItiElbBIy2wYfMuugzYit2EElmdxYEtGCjFpPYGlXgM7t/zGMtqpFMYrIVvUoXlqd7qhocq9hyy5FiPeTbg9leeKi+Zf2lUx30i03a37KgiXdkRwoyAJkqNpv2oWR0aMhq/Xyz/y5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715602759; c=relaxed/simple;
	bh=qn0QvlNJNTgRfoeiDuTPG0CLGGWtTC/IQU2gxVE4PAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LYSEmtW4zEnTyDucA8cy0bHk79SobNIgvPEbfzZyhA2W99Z6hqd2mnyyBrwD5imSREavBl9GoawtOCnFbTgV+Fj987xy8MMKtJARIjnN+kNt+BKLkfILLn13nOu7VOkqh5gGKe1DL4raOaFgLe+YdhenkSC5/y7rY8pXT4cMt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VdJSM2NKKz4f3n6Z;
	Mon, 13 May 2024 20:18:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 698CD1A01D2;
	Mon, 13 May 2024 20:19:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g46BUJm8iY0Mg--.57325S6;
	Mon, 13 May 2024 20:19:09 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next 2/2] blk-throttle: fix lower control under super low iops limit
Date: Mon, 13 May 2024 20:08:48 +0800
Message-Id: <20240513120848.2828797-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240513120848.2828797-1-yukuai1@huaweicloud.com>
References: <20240513120848.2828797-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g46BUJm8iY0Mg--.57325S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWrGrW3KryfXF1xZFyUGFg_yoW5XFWfpr
	W3ur43KF1qqFZFkF43ArZxtFWY9ws7Zry5J343Wr4fAr12gFnrWr1DZr4YkFW8AF93ua1x
	AFn8JryDGF4UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

User will configure allowed iops limit in 1s, and calculate_io_allowed()
will calculate allowed iops in the slice by:

limit * HZ / throtl_slice

However, if limit is quite low, the result can be 0, then
allowed IO in the slice is 0, this will cause missing dispatch and
control will be lower than limit.

For example, set iops_limit to 5 with HD disk, and test will found that
iops will be 3.

This is usually not a big deal, because user will unlikely to configure
such low iops limit, however, this is still a problem in the extreme
scene.

Fix the problem by using MAX_THROTL_SLICE in this case, so that
calculate_io_allowed() is guaranteed not to return 0, since we don't care
about more smoother control effect in this case.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 18 ++++++++++++++++++
 block/blk-throttle.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 69f1bb91ea78..69429288b50b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -491,6 +491,8 @@ static bool throtl_schedule_next_dispatch(struct throtl_service_queue *sq,
 
 static unsigned int tg_throtl_slice(struct throtl_grp *tg, int rw)
 {
+	if (tg->throtl_slice[rw])
+		return tg->throtl_slice[rw];
 	return tg->td->throtl_slice;
 }
 
@@ -1169,6 +1171,21 @@ static int tg_print_conf_uint(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static void tg_set_throtl_slice(struct throtl_grp *tg)
+{
+	int rw;
+
+	for (rw = READ; rw <= WRITE; rw++) {
+		u32 limit = tg_iops_limit(tg, rw);
+
+		if (limit == UINT_MAX ||
+		    calculate_io_allowed(limit, tg->td->throtl_slice) != 0)
+			tg->throtl_slice[rw] = tg->td->throtl_slice;
+		else
+			tg->throtl_slice[rw] = MAX_THROTL_SLICE;
+	}
+}
+
 static void tg_conf_updated(struct throtl_grp *tg, bool global)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
@@ -1200,6 +1217,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	}
 	rcu_read_unlock();
 
+	tg_set_throtl_slice(tg);
 	/*
 	 * We're already holding queue_lock and know @tg is valid.  Let's
 	 * apply the new config directly.
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 393c3d134b96..0424d2be90ff 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -126,6 +126,12 @@ struct throtl_grp {
 
 	unsigned long last_check_time;
 
+	/*
+	 * This is usually td->throtl_slice, however, if iops limit is quite
+	 * low that allowed io in that slice is 0, throtl_slice in this tg will
+	 * be set to MAX_THROTL_SLICE.
+	 */
+	unsigned int throtl_slice[2];
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
-- 
2.39.2


