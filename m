Return-Path: <cgroups+bounces-3782-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3301D937280
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 04:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD211F21D86
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 02:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44230B657;
	Fri, 19 Jul 2024 02:37:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C12A20;
	Fri, 19 Jul 2024 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721356636; cv=none; b=gIwt9ETZWBdukF9U+55UXOSK3MgmVJrM25Aicbt1cTYkYuoZ+EFmYvcyuqHmgTwWWQ8rc/zJyQWO50mq0wj9Om6rrcqyyGObFkxdmre4MmG0QWVhRHCKacjR5XfhvJZjw4HWeMSH2ga9Ph7ZF4ahVe7w+b8PCiyPliv4XmyHsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721356636; c=relaxed/simple;
	bh=zah+9lJ5Df3NcJR2v4cILmzq85sf4M3XoOUY63U2+3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l2NkZuSFS+zayhuiqD0ImzgTWG3W+qAv5HGjKMyqKHrrLrR1VEu5O098AWwJ9QD7vnOL/GSpfLuPktzDqTMASXKbOZph7aVOC+BgUlAR7tv3t4QjyyeIHCXRrrpsQH4h5bCFnBI/IOx02ZYFCrNUXTI5z56HrBaZjwnNeIv7X3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQDMr6RR5z4f3kvn;
	Fri, 19 Jul 2024 10:36:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 34E541A10B7;
	Fri, 19 Jul 2024 10:37:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDXuzlU0Zlmiw8kAg--.57041S4;
	Fri, 19 Jul 2024 10:37:09 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: bvanassche@acm.org,
	jack@suse.cz,
	hch@infradead.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 0/3] blk-ioprio: remove per-disk structure
Date: Fri, 19 Jul 2024 10:34:28 +0800
Message-Id: <20240719023431.3800647-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXuzlU0Zlmiw8kAg--.57041S4
X-Coremail-Antispam: 1UD129KBjvdXoWrGrWfuw1DZrW8Kr1rXw1xuFg_yoWxGFX_AF
	y8JF95Xrs3Aa1UA3WfAF1aqay09r4DWr4jvFyDtrW7Jw17Xrs5tr43JrWUXr15uF43C34x
	JryUur18Jr42yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v2:
 - add patch 1;

The idea is that ioprio doesn't need to access blkg, all it needs is
blkcg, hence blk_register_policy() is enough, and blk_activate_policy()
is not needed.

Yu Kuai (3):
  blk-cgroup: check for pd_(alloc|free)_fn in blkcg_activate_policy()
  blk-ioprio: remove ioprio_blkcg_from_bio()
  blk-ioprio: remove per-disk structure

 block/blk-cgroup.c | 21 +++++++++--------
 block/blk-ioprio.c | 57 +---------------------------------------------
 block/blk-ioprio.h |  9 --------
 3 files changed, 13 insertions(+), 74 deletions(-)

-- 
2.39.2


