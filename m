Return-Path: <cgroups+bounces-3613-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E68E92E2FC
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 11:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397A02813C1
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F02156971;
	Thu, 11 Jul 2024 09:03:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF36014F9E5;
	Thu, 11 Jul 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688602; cv=none; b=kKWSJUTqMigLOb0JoknTircwCdYAej0wI25tOD4gr6OgUWA0xzXcqshE4VCqKdUzLRV5nG8NuOBkwFKBaZibmixTAQwUMdD4XvINMkE4Yectpx1d0oCDp6XG3GQkDv8awi+i3tWgbAPMNF14PpajG9Wjef6H0Bk/PVByjaiGmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688602; c=relaxed/simple;
	bh=ayK7Av2eobw9Jb795Algcx8XW3pCGg96Jxv2WBIVM7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AE22RGrAOFuQnG9Tx8KKoODyVvP8k1chR619/qazK/qJPN9YKMCipEvME9V56FUAt2f0QfVdiKLErks21+UJDaHtkXSufClLqI6od64/KX4c3y+ud3g+nkQIPvnbn7TTmkN0z/Yz7PRgSKKJoSjncQq+JbwuyeG7HO7RbUFaUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WKTK30K4xz4f3jtD;
	Thu, 11 Jul 2024 17:03:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B2CFC1A0568;
	Thu, 11 Jul 2024 17:03:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgB34YbMn49msI0qBw--.62219S5;
	Thu, 11 Jul 2024 17:03:10 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	bvanassche@acm.org,
	jack@suse.cz,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 1/2] blk-ioprio: remove ioprio_blkcg_from_bio()
Date: Thu, 11 Jul 2024 17:00:58 +0800
Message-Id: <20240711090059.3998565-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240711090059.3998565-1-yukuai1@huaweicloud.com>
References: <20240711090059.3998565-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YbMn49msI0qBw--.62219S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tr43tFW7ArWDuF4rWF1kGrg_yoW8Gw4fpF
	43Grs0kFWv9F4Iqr4DWa1xAr9akay7tr15J3s5Ka1Yvr4Uur98K3WrCrs3JFW8AFWUCrZx
	uF1vqFyUJF4UCwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4T5dUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, if config is enabled, then ioprio is always enabeld by
default from blkcg_init_disk(), hence there is no point to check if
the policy is enabled from blkg in ioprio_blkcg_from_bio(). Hence remove
it and get blkcg directly from bio.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-ioprio.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 4051fada01f1..ae52b418e984 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -84,16 +84,6 @@ ioprio_blkcg_from_css(struct cgroup_subsys_state *css)
 	return blkcg_to_ioprio_blkcg(css_to_blkcg(css));
 }
 
-static struct ioprio_blkcg *ioprio_blkcg_from_bio(struct bio *bio)
-{
-	struct blkg_policy_data *pd = blkg_to_pd(bio->bi_blkg, &ioprio_policy);
-
-	if (!pd)
-		return NULL;
-
-	return blkcg_to_ioprio_blkcg(pd->blkg->blkcg);
-}
-
 static int ioprio_show_prio_policy(struct seq_file *sf, void *v)
 {
 	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_css(seq_css(sf));
@@ -186,7 +176,7 @@ static struct blkcg_policy ioprio_policy = {
 
 void blkcg_set_ioprio(struct bio *bio)
 {
-	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_bio(bio);
+	struct ioprio_blkcg *blkcg = blkcg_to_ioprio_blkcg(bio->bi_blkg->blkcg);
 	u16 prio;
 
 	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
-- 
2.39.2


