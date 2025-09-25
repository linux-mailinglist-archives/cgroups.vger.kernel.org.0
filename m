Return-Path: <cgroups+bounces-10442-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16A4B9E0B1
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC94B3B6D7E
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397852EA753;
	Thu, 25 Sep 2025 08:25:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452CB2E9ECF;
	Thu, 25 Sep 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788757; cv=none; b=bjCOjYwryKpqhBYrQvZLGUTiJDz7vb+uD87HRDrsYlM7z0MiFtyEusJtHb7N3qVMKjn+tZcuJEuYZOsLCO2Co6SRfKg9+gYuy5ET6WbhNlr+0yisHAaPrBqQURs7RoM6K9RSapQ03F04RawbyWzoEvzwG/ssnF3RXGysre88l/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788757; c=relaxed/simple;
	bh=6hKjv7hJAGzo5d3GJA8MetP/AmZUT7an+Knm0jSkuCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a7wYXoDJ26PgwsywEXq68MY8Sgthbaud7s2zqZ3UcsIUKCjKOx52b5HaPXVsIE4QaqpgHDo0a7R0hz3QPaEFRTdmiF9sqTbK55FYLDZPJa+MDOJiD2QRRZCd+jH4GB6r0k4Wb8r5Z/J2RLRD26A/Dmhlm/gKw63mQOkgSxdlMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cXRcK2H40zYQvXc;
	Thu, 25 Sep 2025 16:25:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 46CD91A1796;
	Thu, 25 Sep 2025 16:25:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCna2OH_NRodTcIAw--.12615S4;
	Thu, 25 Sep 2025 16:25:45 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	hch@lst.de,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	akpm@linux-foundation.org,
	vgoyal@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 00/10] blk-cgroup: don't use queue_lock for protection and fix deadlock
Date: Thu, 25 Sep 2025 16:15:15 +0800
Message-Id: <20250925081525.700639-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCna2OH_NRodTcIAw--.12615S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww45GF4UXr4UCw47Gr4kZwb_yoW8Gr1kpF
	9Iqr1agw12vFn7Zr1ag3W2gF1rG3yxGrWDJwnIqr4rCF17Zry8ZF18Zw4kuFWSqF92yan8
	tr18AryIkF1j9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

patch 1-6 is prep patches to make sure queue_lock is not nested under
rcu and other spinlocks in blk-cgroup;
patch 7 convert blk-cgroup to use blkcg_mutex to protect blkgs;
patch 8-9 are follow cleanups;
patch 10 fix deadlock in blk-throttle;

BTW, with this set, we can unify blkg_conf_prep() and other related
helpers.

Yu Kuai (10):
  blk-cgroup: use cgroup lock and rcu to protect iterating blkcg blkgs
  blk-cgroup: don't nest queue_lock under rcu in blkg_lookup_create()
  blk-cgroup: don't nest queu_lock under rcu in bio_associate_blkg()
  blk-cgroup: don't nest queue_lock under blkcg->lock in
    blkcg_destroy_blkgs()
  mm/page_io: don't nest queue_lock under rcu in
    bio_associate_blkg_from_page()
  block, bfq: don't grab queue_lock to initialize bfq
  blk-cgroup: convert to protect blkgs with blkcg_mutex
  blk-cgroup: remove radix_tree_preload()
  blk-cgroup: remove preallocate blkg for blkg_create()
  blk-throttle: fix possible deadlock due to queue_lock in timer

 block/bfq-cgroup.c        |   6 +-
 block/bfq-iosched.c       |  13 +-
 block/blk-cgroup-rwstat.c |   2 -
 block/blk-cgroup.c        | 329 ++++++++++++++++----------------------
 block/blk-cgroup.h        |   6 +-
 block/blk-throttle.c      |  31 ++--
 mm/page_io.c              |   7 +-
 7 files changed, 163 insertions(+), 231 deletions(-)

-- 
2.39.2


