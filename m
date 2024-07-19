Return-Path: <cgroups+bounces-3793-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1D9937443
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 09:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC9C1C21DFC
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 07:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F22502BD;
	Fri, 19 Jul 2024 07:17:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD23BB24;
	Fri, 19 Jul 2024 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721373471; cv=none; b=dWKyZLNd1LxLNhm9ai2J69F33GQ261qHDyRQK9rTBaFZhgBg97QlJkM0qqpvwE1NSadYexbku7fmXN6Sx/ymjKBJxQ8L1UH1l1eWljtm/KSdRfbcs8vzlfwY4C4DUHiEzzyQ/YsS7Nbx83UO5FRYAS42jGOPD0MNHZvwDJsaVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721373471; c=relaxed/simple;
	bh=L7HWCSCLZgrc2zDkIStV4GdiC25G7efaQnFOW1jdrNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OB8v/mY9MfilC1J4d6bUHW69VeuBvSUYoy4lvriFsNworrGHazzNpTJO9J9qJTeAySsROT5lmhXzSZ4ESdqdsuDDLrHx/fOu11/uFwk1I1QcXc5jsdbuoJ0/cCPHLkuwdooOveZdk46+X/YFI4Oe6QFDRitHHeGR1JJl/uGEp24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WQLbd5vyBz4f3jrg;
	Fri, 19 Jul 2024 15:17:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F23D61A0ED9;
	Fri, 19 Jul 2024 15:17:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHazkXE5pmhaA2Ag--.65311S4;
	Fri, 19 Jul 2024 15:17:45 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	bvanassche@acm.org,
	jack@suse.cz,
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
Subject: [PATCH v3 0/3] blk-ioprio: remove per-disk structure
Date: Fri, 19 Jul 2024 15:15:03 +0800
Message-Id: <20240719071506.158075-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHazkXE5pmhaA2Ag--.65311S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1DJFyfCFW8uw4kCr1xKrg_yoWxuwc_uF
	ykAF95XF4fAa1UC3WfAF4aqayv9rWUWr4jvFy8KrW7Xw17Xrs5tr43trWqqF15ua13Cas7
	JryUur1kJr42yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
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

Changes in v3:
 - also fix indentation in path 1;
 - add reviewed tag by hch;

Changes in v2:
 - add patch 1;

The idea is that ioprio doesn't need to access blkg, all it needs is
blkcg, hence blk_register_policy() is enough, and blk_activate_policy()
is not needed.

Yu Kuai (3):
  blk-cgroup: check for pd_(alloc|free)_fn in blkcg_activate_policy()
  blk-ioprio: remove ioprio_blkcg_from_bio()
  blk-ioprio: remove per-disk structure

 block/blk-cgroup.c | 23 +++++++++++--------
 block/blk-ioprio.c | 57 +---------------------------------------------
 block/blk-ioprio.h |  9 --------
 3 files changed, 14 insertions(+), 75 deletions(-)

-- 
2.39.2


