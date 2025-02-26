Return-Path: <cgroups+bounces-6717-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43997A45216
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2025 02:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651D43A9971
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2025 01:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3121156F54;
	Wed, 26 Feb 2025 01:20:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634A3EEBB;
	Wed, 26 Feb 2025 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532838; cv=none; b=iEpcerMbNYeDSqR5JNimtm7D07HAgXKjB2dtCjjwoXFOsHWAAiT/pF5rOuWiJ+JSiRUtT0JWkgcl1/KFX4GDWnQmf4hXjvKENEcqTk5ofpHLBedBVCIzh6kw5D1UsZNZHi/xhwlCckIt0emtnuZxBCEOTll1YCgib79X4enrr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532838; c=relaxed/simple;
	bh=1y+CsCuTNBZX2g/3ocZNhC6n59KFuU6Pz+bZyclOKXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTS0SoLj3sl2sRNunxTJ1Wi9PkgmN4X/i/rDC9z7L6XyWgumYys5lFr4RWWrbY9k/mM5uKBClFdFot1iI8Nom63lupLoJ8gHo6cm2UeG0TXCgqTTI3v4c9GdfppqtBM8h295Jd3NnS83iustI3xxHf6/ZENJOg0q4J/YtS6TTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z2c8m06hZz4f3l2C;
	Wed, 26 Feb 2025 09:20:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 43BF11A06DC;
	Wed, 26 Feb 2025 09:20:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2BbbL5nY96kEw--.12272S4;
	Wed, 26 Feb 2025 09:20:29 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: ming.lei@redhat.com,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	vgoyal@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] blk-throttle: fix lower bps rate by throtl_trim_slice()
Date: Wed, 26 Feb 2025 09:16:27 +0800
Message-Id: <20250226011627.242912-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2BbbL5nY96kEw--.12272S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4DCr4UArWfGF1fuw18Grg_yoW5Cw13pF
	W3Ar4agFWUXFy2kFW3X3Z3Jay0k3yrGFy5Gwn5ur4rAa45Cr1fKFnxAr4Yka43A3s3ur4a
	v3WqvryxCF1jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The bio submission time may be a few jiffies more than the expected
waiting time, due to 'extra_bytes' can't be divided in
tg_within_bps_limit(), and also due to timer wakeup delay. In this
case, adjust slice_start to jiffies will discard the extra wait time,
causing lower rate than expected.

This problem will cause blktests throtl/001 failure in case of
CONFIG_HZ_100=y, fix it by preserving one finished slice in
throtl_trim_slice() and allowing deviation between [0, 2 slices).

For example, assume bps_limit is 1000bytes, 1 jiffes is 10ms, and
slice is 20ms(2 jiffies), expected rate is 1000 / 1000 * 20 = 20 bytes
per slice.

If user issues two 21 bytes IO, then wait time will be 30ms for the
first IO:

bytes_allowed = 20, extra_bytes = 1;
jiffy_wait = 1 + 2 = 3 jiffies

and consider
extra 1 jiffies by timer, throtl_trim_slice() will be called at:

jiffies = 40ms
slice_start = 0ms, slice_end= 40ms
bytes_disp = 21

In this case, before the patch, real rate in the first two slices is
10.5 bytes per slice, and slice will be updated to:

jiffies = 40ms
slice_start = 40ms, slice_end = 60ms,
bytes_disp = 0;

Hence the second IO will have to wait another 30ms;

With the patch, the real rate in the first slice is 20 bytes per slice,
which is the same as expected, and slice will be updated:

jiffies=40ms,
slice_start = 20ms, slice_end = 60ms,
bytes_disp = 1;

And now, there is still 19 bytes allowed in the second slice, and the
second IO will only have to wait 10ms;

Fixes: e43473b7f223 ("blkio: Core implementation of throttle policy")
Reported-by: Ming Lei <ming.lei@redhat.com>
Closes: https://lore.kernel.org/linux-block/20250222092823.210318-3-yukuai1@huaweicloud.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8d149aff9fd0..cb472cf7b6b6 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -599,14 +599,23 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	 * sooner, then we need to reduce slice_end. A high bogus slice_end
 	 * is bad because it does not allow new slice to start.
 	 */
-
 	throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
 
 	time_elapsed = rounddown(jiffies - tg->slice_start[rw],
 				 tg->td->throtl_slice);
-	if (!time_elapsed)
+	/* Don't trim slice until at least 2 slices are used */
+	if (time_elapsed < tg->td->throtl_slice * 2)
 		return;
 
+	/*
+	 * The bio submission time may be a few jiffies more than the expected
+	 * waiting time, due to 'extra_bytes' can't be divided in
+	 * tg_within_bps_limit(), and also due to timer wakeup delay. In this
+	 * case, adjust slice_start to jiffies will discard the extra wait time,
+	 * causing lower rate than expected. Therefore, one slice is preserved,
+	 * allowing deviation that is less than two slices.
+	 */
+	time_elapsed -= tg->td->throtl_slice;
 	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
 					     time_elapsed) +
 		     tg->carryover_bytes[rw];
-- 
2.39.2


