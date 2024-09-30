Return-Path: <cgroups+bounces-4985-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACC1989D67
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 10:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2F11F21572
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 08:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D94185B6F;
	Mon, 30 Sep 2024 08:56:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B5017F394;
	Mon, 30 Sep 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686575; cv=none; b=eV5qW6AeVu4oCjwXJlLjZy686SqfjKVzhbQkwymkeZa25TR+rWpDNfNiJuA9YilNISQ2ZasHXIA/5DeWRFNpYTUrmAKPzuuQ8TBx4b0SORfEemqPVNwYUKRH3nt3BQfqvyFyb2orAK5UhFxD1BdV6Jt0B2D2pmLiFpLWUfqciqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686575; c=relaxed/simple;
	bh=RFIvMPwKm0xIVQzM4CMA7QmMFVA7grTf9FolwLFzK9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KQTwvU/Y+6CYDrEcAcDNDENgQHttuNzWYxGLkGLjJaOdU/dHq5aMq1RJslO+EI7uQZgWEu1lwO0HBcFG8oVw+VbLJmS4mel+xYbbsRIu22s2ZbfBsBH9Lo8myVcVpY9jDWwSQGXYIx245v2whqZcOo57FFBi/2RPGE1Uhcx4oq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XHFKW1lPmz4f3jkY;
	Mon, 30 Sep 2024 16:55:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A4C2A1A092F;
	Mon, 30 Sep 2024 16:56:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn28emZ_pmgEUMCw--.63034S9;
	Mon, 30 Sep 2024 16:56:10 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 5/5] blk-cgroup: use new helper blkg_print_dev_name()
Date: Mon, 30 Sep 2024 16:53:02 +0800
Message-Id: <20240930085302.1558217-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240930085302.1558217-1-yukuai1@huaweicloud.com>
References: <20240930085302.1558217-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn28emZ_pmgEUMCw--.63034S9
X-Coremail-Antispam: 1UD129KBjvJXoWxur4fCF18Jw4Uur4fKFy5XFb_yoW5uw1kpF
	WayFnIk34akFnrZ3WYqa47Z34rJw40q3yag393C34a9F17ur1IkF1jk3sYq34ruFyfJrs8
	XFn0vFyUKF4UKwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

To avoid abuse of bdi_dev_name(), and remove blkg_dev_name() since it's
not used anymore.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup-rwstat.c | 13 +++++++------
 block/blk-cgroup.c        | 19 ++++---------------
 block/blk-cgroup.h        |  1 -
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
index a55fb0c53558..a0a1694572da 100644
--- a/block/blk-cgroup-rwstat.c
+++ b/block/blk-cgroup-rwstat.c
@@ -43,21 +43,22 @@ u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 		[BLKG_RWSTAT_ASYNC]	= "Async",
 		[BLKG_RWSTAT_DISCARD]	= "Discard",
 	};
-	const char *dname = blkg_dev_name(pd->blkg);
 	u64 v;
 	int i;
 
-	if (!dname)
+	if (!pd->blkg->q->disk)
 		return 0;
 
-	for (i = 0; i < BLKG_RWSTAT_NR; i++)
-		seq_printf(sf, "%s %s %llu\n", dname, rwstr[i],
-			   rwstat->cnt[i]);
+	for (i = 0; i < BLKG_RWSTAT_NR; i++) {
+		blkg_print_dev_name(sf, pd->blkg);
+		seq_printf(sf, " %s %llu\n", rwstr[i], rwstat->cnt[i]);
+	}
 
 	v = rwstat->cnt[BLKG_RWSTAT_READ] +
 		rwstat->cnt[BLKG_RWSTAT_WRITE] +
 		rwstat->cnt[BLKG_RWSTAT_DISCARD];
-	seq_printf(sf, "%s Total %llu\n", dname, v);
+	blkg_print_dev_name(sf, pd->blkg);
+	seq_printf(sf, " Total %llu\n", v);
 	return v;
 }
 EXPORT_SYMBOL_GPL(__blkg_prfill_rwstat);
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e68c725cf8d9..475fb826d92b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -682,13 +682,6 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	return 0;
 }
 
-const char *blkg_dev_name(struct blkcg_gq *blkg)
-{
-	if (!blkg->q->disk)
-		return NULL;
-	return bdi_dev_name(blkg->q->disk->bdi);
-}
-
 /**
  * blkcg_print_blkgs - helper for printing per-blkg data
  * @sf: seq_file to print to
@@ -740,12 +733,10 @@ EXPORT_SYMBOL_GPL(blkcg_print_blkgs);
  */
 u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v)
 {
-	const char *dname = blkg_dev_name(pd->blkg);
-
-	if (!dname)
+	if (!blkg_print_dev_name(sf, pd->blkg))
 		return 0;
 
-	seq_printf(sf, "%s %llu\n", dname, (unsigned long long)v);
+	seq_printf(sf, " %llu\n", (unsigned long long)v);
 	return v;
 }
 EXPORT_SYMBOL_GPL(__blkg_prfill_u64);
@@ -1144,18 +1135,16 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 {
 	struct blkg_iostat_set *bis = &blkg->iostat;
 	u64 rbytes, wbytes, rios, wios, dbytes, dios;
-	const char *dname;
 	unsigned seq;
 	int i;
 
 	if (!blkg->online)
 		return;
 
-	dname = blkg_dev_name(blkg);
-	if (!dname)
+	if (!blkg_print_dev_name(s, blkg))
 		return;
 
-	seq_printf(s, "%s ", dname);
+	seq_putc(s, ' ');
 
 	do {
 		seq = u64_stats_fetch_begin(&bis->sync);
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index d62bcc2bae14..ab9365bc23ef 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -202,7 +202,6 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol);
 void blkcg_deactivate_policy(struct gendisk *disk,
 			     const struct blkcg_policy *pol);
 
-const char *blkg_dev_name(struct blkcg_gq *blkg);
 void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 		       u64 (*prfill)(struct seq_file *,
 				     struct blkg_policy_data *, int),
-- 
2.39.2


