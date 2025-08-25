Return-Path: <cgroups+bounces-9368-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9F1B33B64
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 11:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968A53B390B
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130332D0611;
	Mon, 25 Aug 2025 09:45:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA32C15B1;
	Mon, 25 Aug 2025 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115131; cv=none; b=iARcn0YzN+X3IUVJrXjB15KlT04obxjbgBjAKz/ePhuzdy0SgzTHIao+BvI5n5EtbGNw4u7Qo6+ueOSj13gzAP8RSWqCiIw/caVkOBxKrkLEiBE9twoG+b68s7+9d8JUA3RE29tLQBVZYZd1UXTdt7GZKZSh3WrKjelCRXnf/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115131; c=relaxed/simple;
	bh=2yjjvo3ufYFsl3ZDOcn9W92qBsYVrRKHbAkhuPAHNBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JcAK0YX+oyVjHJJCNlO/Q8oIuvHC+Ai4Wk3+PNlUnkYIaFFlgkSQuHCSKxs5miczdwIBjb5kgI1OPwcISKgdvaKF7Yl+zIHFHol/e0L9TomI4sLBI2q6a8PJt0MibQnes9LyFvTKQa/kp+HniCH1uMFYGE0U4y7baONvNEpCzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9Qrm3p0nzYQvgT;
	Mon, 25 Aug 2025 17:45:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 104B31A1003;
	Mon, 25 Aug 2025 17:45:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIy1MKxonJnxAA--.44975S4;
	Mon, 25 Aug 2025 17:45:26 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	tieren@fnnas.com,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	yukuai3@huawei.com,
	akpm@linux-foundation.org,
	neil@brown.name
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC 0/7] block: fix disordered IO in the case recursive split
Date: Mon, 25 Aug 2025 17:36:53 +0800
Message-Id: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIy1MKxonJnxAA--.44975S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Jry8XrWxWF45tF45XF1kZrb_yoW8Jr1DpF
	43WrW3Zr18Gr1a9r9xZw4Ut3Z8JF48G34UKrnxXw48XF9xZFy0yw1UAry8Gryjgryft3yU
	Xr1UAr45GF1UGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRRBT5DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

patch 1 export a bio split helper;
patch 2-6 unfiy bio split code from mdraid to use the helper;
patch 7 convert the helper to insert split bio to the head of current
bio_list

This set is just test for raid5 for now, see details in patch 7;

Yu Kuai (7):
  block: export helper bio_submit_split()
  md/raid0: convert raid0_handle_discard() to use bio_submit_split()
  md/raid1: convert to use bio_submit_split()
  md/raid10: convert read/write to use bio_submit_split()
  md/raid5: convert to use bio_submit_split()
  md/md-linear: convert to use bio_submit_split()
  block: fix disordered IO in the case recursive split

 block/blk-core.c       | 54 ++++++++++++++++++++++++-------------
 block/blk-merge.c      | 60 +++++++++++++++++++++++++++---------------
 block/blk-throttle.c   |  2 +-
 block/blk.h            |  3 ++-
 drivers/md/md-linear.c | 14 +++-------
 drivers/md/raid0.c     | 20 ++++++--------
 drivers/md/raid1.c     | 35 ++++++++++--------------
 drivers/md/raid10.c    | 53 ++++++++++++++++---------------------
 drivers/md/raid10.h    |  1 +
 drivers/md/raid5.c     | 12 +++++----
 include/linux/bio.h    |  2 ++
 11 files changed, 135 insertions(+), 121 deletions(-)

-- 
2.39.2


