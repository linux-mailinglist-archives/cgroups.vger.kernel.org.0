Return-Path: <cgroups+bounces-9723-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A07B44EF1
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9380485902
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 07:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1D2D8781;
	Fri,  5 Sep 2025 07:15:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE233E1;
	Fri,  5 Sep 2025 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056557; cv=none; b=XvqIx7pv3YaZIJqlC91EmzdqqVoPval7ZB2eEoYVubOcp54AlpiqYfpa48Y3T9qd5mLXa28FPlhISVjH0wCAbaGCHVcF+6XhBtLPqxdQuJGI7jrcKwJ40BNAd8WuJhHA4uG55Tz1/Qg9S+yVhNo2otQiJtTEdNcA5xV8NR8nWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056557; c=relaxed/simple;
	bh=WUqZ/mUGOa9rCdNCzxpP38onIg1k5jMJhJu8ZhqIBZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=trVEn7NpNCqvceLY3sotDA84+fZbeZ6CyY3GNagwkMuSt8ZKSC5vjLJ786QeRSGIc8x7LEa5fugwbjWVJ8/snw4GSbNgXiY2+WdLcEpxcvzGPZzEuhUpBdOuVG39yVon3Y8FuQRHOikbDi+urud7PKnaXYvQV6nTkGpPn2h/WKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cJ7146K3gzYQvYT;
	Fri,  5 Sep 2025 15:15:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5BE8F1A101F;
	Fri,  5 Sep 2025 15:15:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S4;
	Fri, 05 Sep 2025 15:15:50 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	bvanassche@acm.org,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	yukuai3@huawei.com,
	satyat@google.com,
	ebiggers@google.com,
	kmo@daterainc.com,
	akpm@linux-foundation.org,
	neil@brown.name
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 00/16] block: fix reordered IO in the case recursive split
Date: Fri,  5 Sep 2025 15:06:27 +0800
Message-Id: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW7KF48XryfWr15GF43trb_yoW5XF43pw
	4agr4fZr4xGFsagFsIq3W7tFn5GanY9FW5Jr9xXws5ZFyqyry8tw48XrW8tryDGrWfC3yU
	XF1UCryUGr15GFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes from RFC v3:
 - initialize bio->issue_time_ns in blk_mq_submit_bio, patch 2;
 - set/clear new queue_flag when iolatency is enabled/disabled, patch 3;
 - fix compile problem for md-linear, patch 12;
 - make should_fail_bio() non-static, and open code new helper, patch 14;
 - remove the checking for zoned disk, patch 15;
Changes from RFC v2:
 - add patch 1,2 to cleanup bio_issue;
 - add patch 3,4 to fix missing processing for split bio first;
 - bypass zoned device in patch 14;
Changes from RFC:
 - export a new helper bio_submit_split_bioset() instead of
export bio_submit_split() directly;
 - don't set no merge flag in the new helper;
 - add patch 7 and patch 10;
 - add patch 8 to skip bio checks for resubmitting split bio;

patch 1-5 cleanup bio_issue, and fix missing processing for split bio;
patch 6 export a bio split helper;
patch 7-13 unify bio split code;
path 14,15 convert the helper to insert split bio to the head of current
bio list;
patch 16 is a follow cleanup for raid0;

Yu Kuai (16):
  block: cleanup bio_issue
  block: initialize bio issue time in blk_mq_submit_bio()
  blk-mq: add QUEUE_FLAG_BIO_ISSUE_TIME
  md: fix mssing blktrace bio split events
  blk-crypto: fix missing blktrace bio split events
  block: factor out a helper bio_submit_split_bioset()
  md/raid0: convert raid0_handle_discard() to use
    bio_submit_split_bioset()
  md/raid1: convert to use bio_submit_split_bioset()
  md/raid10: add a new r10bio flag R10BIO_Returned
  md/raid10: convert read/write to use bio_submit_split_bioset()
  md/raid5: convert to use bio_submit_split_bioset()
  md/md-linear: convert to use bio_submit_split_bioset()
  blk-crypto: convert to use bio_submit_split_bioset()
  block: skip unnecessary checks for split bio
  block: fix reordered IO in the case recursive split
  md/raid0: convert raid0_make_request() to use
    bio_submit_split_bioset()

 block/bio.c                 |  2 +-
 block/blk-cgroup.h          |  6 ----
 block/blk-core.c            | 19 ++++++-----
 block/blk-crypto-fallback.c | 16 ++++------
 block/blk-iolatency.c       | 19 +++++------
 block/blk-merge.c           | 64 +++++++++++++++++++++++++------------
 block/blk-mq-debugfs.c      |  1 +
 block/blk-mq.c              |  3 ++
 block/blk-throttle.c        |  2 +-
 block/blk.h                 | 45 ++------------------------
 drivers/md/md-linear.c      | 14 ++------
 drivers/md/raid0.c          | 30 ++++++-----------
 drivers/md/raid1.c          | 38 ++++++++--------------
 drivers/md/raid1.h          |  4 ++-
 drivers/md/raid10.c         | 54 ++++++++++++++-----------------
 drivers/md/raid10.h         |  2 ++
 drivers/md/raid5.c          | 10 +++---
 include/linux/blk_types.h   |  7 ++--
 include/linux/blkdev.h      |  3 ++
 19 files changed, 141 insertions(+), 198 deletions(-)

-- 
2.39.2


