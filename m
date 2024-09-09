Return-Path: <cgroups+bounces-4754-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFED3971B60
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 15:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDE41C231E2
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E2D1BA287;
	Mon,  9 Sep 2024 13:43:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB11B6549;
	Mon,  9 Sep 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889432; cv=none; b=NGTavwTjJXo+hp4aOycHx41fJUHJUopNclY1yc1hAwEoBAd+GA4NYKNnZl/q22IHhuUHoT3E1SuEAaEpYudFEVY7V7Kjop1jJtxyfFntJhIV34T4sRWKZPKpZDEqXACkNLoVhd6qHax4UrPkqWgbTsuinoZhGdw5dLnKeaEEkUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889432; c=relaxed/simple;
	bh=R/CqUNRn+CDC6sIlr8LozUZmOylZVeixcdggYb+qeAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BATNCAUDRkEmkGkx5LgRYJLeLQpLVkBdjsz+S0YzzOcdtSU/E0sRjVfsTXWDpFTQdctsiB/WjdGJMpOH6gykA/VttSTjH8sy3EOiR3JU5K+8DPfcbCU8G27qc1kzG0LCmJOOauD0oNBoGV4jZDfpW4XOw22wyFoNXIDZ11DkURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X2Sj34d5xz4f3jqt;
	Mon,  9 Sep 2024 21:43:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 302C41A0359;
	Mon,  9 Sep 2024 21:43:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn28eQ+95mhC1hAw--.55605S4;
	Mon, 09 Sep 2024 21:43:45 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai3@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH for-6.12 0/7] block, bfq: bfqq merge chain fixes and cleanup
Date: Mon,  9 Sep 2024 21:41:47 +0800
Message-Id: <20240909134154.954924-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn28eQ+95mhC1hAw--.55605S4
X-Coremail-Antispam: 1UD129KBjvdXoWrur1ftryxJF45CFy5tryrZwb_yoWfurb_uF
	95tFyfGFs7Wa4YkFy7Ar1UAa98CrWUJwn0qF9xGr45Xw17tFn3AwnxKFs3ZFZ8Wan3Gw45
	tr1Sv3y8JrnFqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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

Patch 1 fixes a problem found by xfstests generic/323, tested on scsi
disk with bfq.
Patch 2 fixes a problem while digging the above problem, by a debug patch
to print procress reference.
Patch 3-7 are cleanups while reviewing code.

Yu Kuai (7):
  block, bfq: fix uaf for accessing waker_bfqq after splitting
  block, bfq: fix procress reference leakage for bfqq in merge chain
  block, bfq: merge bfq_release_process_ref() into bfq_put_cooperator()
  block, bfq: remove bfq_log_bfqg()
  block, bfq: remove local variable 'split' in bfq_init_rq()
  block, bfq: remove local variable 'bfqq_already_existing' in
    bfq_init_rq()
  block, bfq: factor out a helper to split bfqq in bfq_init_rq()

 block/bfq-cgroup.c  |   1 -
 block/bfq-iosched.c | 191 ++++++++++++++++++++++++--------------------
 block/bfq-iosched.h |   6 --
 3 files changed, 103 insertions(+), 95 deletions(-)

-- 
2.39.2


