Return-Path: <cgroups+bounces-4668-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D53E96885C
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 15:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72941F21111
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CA918455B;
	Mon,  2 Sep 2024 13:05:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4BD3D9E;
	Mon,  2 Sep 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282300; cv=none; b=rpUwCkoB9L4WzY7mVcPzAoIqgh73BWiTYP+++lrwoxm3I9FHshuk/L4fxi4T5sTkw6bNAgxuDuWonfKojYTKW5PmCObgSQX7+br/Pt6yPZ5XsJ2WSjv6Bl170DApxPIpJ/0sBzCDgTpObP8zyl1MeSVPBcj9s4XVaPVjrIkXnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282300; c=relaxed/simple;
	bh=kZc3V9mc3EJ/bu5BlgzKg/xanEcipBBLyq6NMf/dg1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i8BEVJVYM8WkkXEybmsLaw6nbKXNCsyowQS2mD9lCKkF0h5SVsB1p7uuc31mBfaQdjbIhU76rzuMqlmFRowoH8B5NVKtcTFJz+3koa85jRALigoPzipk2Z3bmSR1zUJVIEbl894o8bTGeFJHEtVfvZMwZC72XvE3+XikQf62Kdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wy89M6t6Lz4f3m6Z;
	Mon,  2 Sep 2024 21:04:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B00261A0568;
	Mon,  2 Sep 2024 21:04:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8f1t9Vm9+rAAA--.25569S4;
	Mon, 02 Sep 2024 21:04:55 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	paolo.valente@unimore.it,
	mauro.andreolini@unimore.it,
	avanzini.arianna@gmail.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to bfqq merging
Date: Mon,  2 Sep 2024 21:03:25 +0800
Message-Id: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8f1t9Vm9+rAAA--.25569S4
X-Coremail-Antispam: 1UD129KBjvdXoWruw15CFWDWrW5Zr1fuF1kGrg_yoWxCrc_Za
	sYkr93Jr4rWFW3AFy3Ar1jv3Z8ta13Xr1jyF98Krs8Xr13XFn7CwnrKFs2qFWrWan5J34r
	JryYv3y8Jr42vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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

Our syzkaller report a UAF problem(details in patch 1), however it can't
be reporduced. And this set are some corner cases fix that might be
related, and they are found by code review.

Yu Kuai (4):
  block, bfq: fix possible UAF for bfqq->bic with merge chain
  block, bfq: choose the last bfqq from merge chain in
    bfq_setup_cooperator()
  block, bfq: don't break merge chain in bfq_split_bfqq()
  block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()

 block/bfq-cgroup.c  |  7 +------
 block/bfq-iosched.c | 17 +++++++++++------
 block/bfq-iosched.h |  2 ++
 3 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.39.2


