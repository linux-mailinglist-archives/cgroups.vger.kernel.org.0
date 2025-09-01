Return-Path: <cgroups+bounces-9524-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C83B3D789
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A2E188CEEE
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE8E21A425;
	Mon,  1 Sep 2025 03:41:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604A52F99;
	Mon,  1 Sep 2025 03:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698078; cv=none; b=J8rcxPTbsYCtRjbUuwrVg629zPpmFU1oRcoAYl7Nfws5uXYJRS6JlMCuMjpQFFB2pAtuFZpA1+a0DkVfIh49hO/MHX7hJBSivgtL6kc0g4+O49XMDW2Z/8HMCQmSfivYjgAxgdxB9wg93COCwk865WVvh1U58qb6F5uvryr8DXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698078; c=relaxed/simple;
	bh=L6kY369ygnM7s2a8RN7xIRPMZh5a0TVH61deIUF6TzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCD/2LY7AI9nwk7N56cNWty86Wa1IjaQuYugQYihgX44LgYIG3d79SSbuCwVc8NV5ywNJOdQGObii29EDlNTrAvVSq2FTS577BiNe1LkrRBpDsbXdxz/VDUCWnO6Qe9S4G6eXBv1Tpp0BMDXuBZ1SstOxKrWG80b5vN+iBoVlwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cFZRF3ny9zKHN5Q;
	Mon,  1 Sep 2025 11:41:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 57E691A0877;
	Mon,  1 Sep 2025 11:41:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzWFbVotmf1Aw--.38057S4;
	Mon, 01 Sep 2025 11:41:12 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	kmo@daterainc.com,
	satyat@google.com,
	ebiggers@google.com,
	neil@brown.name,
	akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC v3 00/15] block: fix disordered IO in the case recursive split
Date: Mon,  1 Sep 2025 11:32:05 +0800
Message-Id: <20250901033220.42982-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIzWFbVotmf1Aw--.38057S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW7KryUXF4UJFWfCF15Arb_yoW8KFyxpw
	43Wr4fZr48GF9IgFsxX3W7tFn5GanYgFy5Gr9aqws5ZFyDZryxtw48Ar18tryUGrWSk34U
	Xr1UArWUGr15GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Changes in v3:
 - add patch 1,2 to cleanup bio_issue;
 - add patch 3,4 to fix missing processing for split bio first;
 - bypass zoned device in patch 14;
Changes in v2:
 - export a new helper bio_submit_split_bioset() instead of
export bio_submit_split() directly;
 - don't set no merge flag in the new helper;
 - add patch 7 and patch 10;
 - add patch 8 to skip bio checks for resubmitting split bio;

patch 1,2 cleanup bio_issue;
patch 3,4 to fix missing processing for split bio;
patch 5 export a bio split helper;
patch 6-12 unify bio split code;
path 13,14 convert the helper to insert split bio to the head of current
bio list;
patch 15 is a follow cleanup for raid0;

This set is just test for raid5 for now, see details in patch 9;

Yu Kuai (15):
  block: cleanup bio_issue
  block: add QUEUE_FLAG_BIO_ISSUE
  md: fix mssing blktrace bio split events
  blk-crypto: fix missing processing for split bio
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
  block: fix disordered IO in the case recursive split
  md/raid0: convert raid0_make_request() to use
    bio_submit_split_bioset()

 block/bio.c                 |  2 +-
 block/blk-cgroup.h          |  5 ++-
 block/blk-core.c            | 35 +++++++++++++++++----
 block/blk-crypto-fallback.c | 15 +++------
 block/blk-iolatency.c       | 15 +++------
 block/blk-merge.c           | 63 ++++++++++++++++++++++++-------------
 block/blk-mq-debugfs.c      |  1 +
 block/blk-throttle.c        |  2 +-
 block/blk.h                 | 45 ++------------------------
 drivers/md/md-linear.c      | 11 ++-----
 drivers/md/raid0.c          | 30 ++++++------------
 drivers/md/raid1.c          | 38 ++++++++--------------
 drivers/md/raid1.h          |  4 ++-
 drivers/md/raid10.c         | 54 ++++++++++++++-----------------
 drivers/md/raid10.h         |  2 ++
 drivers/md/raid5.c          | 10 +++---
 include/linux/blk_types.h   |  7 ++---
 include/linux/blkdev.h      |  3 ++
 18 files changed, 152 insertions(+), 190 deletions(-)

-- 
2.39.2


