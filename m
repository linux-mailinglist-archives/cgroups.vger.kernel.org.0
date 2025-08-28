Return-Path: <cgroups+bounces-9452-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE4B3948B
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 09:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F07168789
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 07:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037782D249A;
	Thu, 28 Aug 2025 07:06:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8C27B35F;
	Thu, 28 Aug 2025 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364782; cv=none; b=HfkvwfmrcYimMYb4JqJyaO1KkvDRJSF7iWck0VUttPlKj1JJqg9VUrLqVPMrhWoZINUYsrKUw+ITac6pfgdndo1KAXV0RlX/vNMGH7zvmIzkvVORKZntsvqBuxKbHQ9AVwHfZLLyz2LWhgmxsfklSR7M+fThT0a2DwARmkWsjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364782; c=relaxed/simple;
	bh=3GtacDy0fynn68cetc6FdcOBuEARvE0UkBR+DvwmVqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rVTj9y+y+vBvYtdt+eg6oH0JeBI8DEY0LiZoQeIoj/wDBmuKphe09RiTr/Y+4HtQ9IQWO8DdJK7NHKtUriTSSf/9W/VFqccYiCXDSQ7O4PqxTEOQH3yX+zrAZB4RECm6D/GgmT7AX/5uPXiHto3sWSUTdA2GKaP87s52ZW2hhgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCC9b6MdrzKHLx4;
	Thu, 28 Aug 2025 15:06:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 90F661A1CB1;
	Thu, 28 Aug 2025 15:06:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Izh_69o_X89Ag--.14658S4;
	Thu, 28 Aug 2025 15:06:11 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	neil@brown.name,
	akpm@linux-foundation.org,
	hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	tieren@fnnas.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC v2 00/10] block: fix disordered IO in the case recursive split
Date: Thu, 28 Aug 2025 14:57:23 +0800
Message-Id: <20250828065733.556341-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Izh_69o_X89Ag--.14658S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4Duw43GFWrJF4rtw1DJrb_yoW8AF4Upa
	yagFW3Zr1UCr4agFnxZ3WUt3Z5C3WvgryrGr93Xws5XF9rZrWIkw4UAr1rKry5GFWrG34U
	Xr1kCrWUWF15GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v2:
 - export a new helper bio_submit_split_bioset() instead of
export bio_submit_split() directly;
 - don't set no merge flag in the new helper;
 - add patch 7 and patch 10;
 - add patch 8 to skip bio checks for resubmitting split bio;

patch 1 export a bio split helper;
patch 2-7 unify bio split code;
path 8-9 convert the helper to insert split bio to the head of current
bio list;
patch 10 is a follow cleanup for raid0;

This set is just test for raid5 for now, see details in patch 9;

Yu Kuai (10):
  block: factor out a helper bio_submit_split_bioset()
  md/raid0: convert raid0_handle_discard() to use
    bio_submit_split_bioset()
  md/raid1: convert to use bio_submit_split_bioset()
  md/raid10: convert read/write to use bio_submit_split_bioset()
  md/raid5: convert to use bio_submit_split_bioset()
  md/md-linear: convert to use bio_submit_split_bioset()
  blk-crypto: convert to use bio_submit_split_bioset()
  block: skip unnecessary checks for split bio
  block: fix disordered IO in the case recursive split
  md/raid0: convert raid0_make_request() to use
    bio_submit_split_bioset()

 block/blk-core.c            | 34 ++++++++++++++++----
 block/blk-crypto-fallback.c | 15 +++------
 block/blk-merge.c           | 63 ++++++++++++++++++++++++-------------
 block/blk-throttle.c        |  2 +-
 block/blk.h                 |  3 +-
 drivers/md/md-linear.c      | 14 ++-------
 drivers/md/raid0.c          | 31 ++++++------------
 drivers/md/raid1.c          | 35 +++++++++------------
 drivers/md/raid1.h          |  4 ++-
 drivers/md/raid10.c         | 51 +++++++++++++-----------------
 drivers/md/raid10.h         |  2 ++
 drivers/md/raid5.c          | 10 +++---
 include/linux/blkdev.h      |  2 ++
 13 files changed, 137 insertions(+), 129 deletions(-)

-- 
2.39.2


