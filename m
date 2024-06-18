Return-Path: <cgroups+bounces-3224-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1D90C37C
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 08:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EA21C20FA3
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 06:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B813BB59;
	Tue, 18 Jun 2024 06:22:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC1F55E58;
	Tue, 18 Jun 2024 06:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691723; cv=none; b=VuEO5kWe9GxT2KpeFrGBBGjJuePR8XlO2uLKZOjtI1Wnv+0/z80KQcncRZ5couitkH4n2GKdJOaL6AXpv/rbaFaiQFaR4A2fJMoXWktd1BRKDJe0dIdn+iYupB4qF2k7RxB7+57t1X84oi6ZDhXyglItdRC/EMWq2mFqULR8sDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691723; c=relaxed/simple;
	bh=m1zG2yEWX7cBjqsBzhezr80cVaRI1m/8Ekw9b0fms2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LwlznVw7ggqdV4IOgxExIwwiTeCFB15yK1fg/iMNM8U4um1HpTtbNoAwI5D8Ea1zBaVQXQWB3sgtZSsius8K5iK36Dr+md2n+asef2+6AuH4BTJWYQDH6FwQ+CoTyzaY/mOLYfbHhbCmyXwQt9d54iYMedrcA3VtpozJ9+h8+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W3Gqd6Qk9z4f3jLV;
	Tue, 18 Jun 2024 14:21:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AC8ED1A016E;
	Tue, 18 Jun 2024 14:21:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCH7wyCJ3Fm1K4IAQ--.17725S4;
	Tue, 18 Jun 2024 14:21:56 +0800 (CST)
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
Subject: [PATCH v2] blk-throttle: fix lower control under super low iops limit
Date: Tue, 18 Jun 2024 14:21:08 +0800
Message-Id: <20240618062108.3680835-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH7wyCJ3Fm1K4IAQ--.17725S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1kCryfZFykGr47Kw4UJwb_yoW8GF45pr
	W3Kr1jgF4DWFn7KF43Gw4ayFy8CFWkZr9xJ398uw1ayr13CF17Krn3CF4Yyw4xZFZa9FW7
	ury8ta4kAF1UCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUoOJ5UUUUU
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

Fix the problem by making sure the wait time calculated by
tg_within_iops_limit() should allow at least one IO to be dispatched.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v2:
 - instead of extend thorlt_slice, extend wait time;
 block/blk-throttle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c1bf73f8c75d..dc6140fa3de0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -704,6 +704,9 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
 
 	/* Calc approx time to dispatch */
 	jiffy_wait = jiffy_elapsed_rnd - jiffy_elapsed;
+
+	/* make sure at least one io can be dispatched after waiting */
+	jiffy_wait = max(jiffy_wait, HZ / iops_limit + 1);
 	return jiffy_wait;
 }
 
-- 
2.39.2


