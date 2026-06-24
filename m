Return-Path: <cgroups+bounces-17216-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jsgxC1R9O2qwYggAu9opvQ
	(envelope-from <cgroups+bounces-17216-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 08:46:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C08936BBDF1
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 08:46:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QH8jpjUT;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17216-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17216-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FBC4301EB56
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 06:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62438A726;
	Wed, 24 Jun 2026 06:46:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA435E1A1;
	Wed, 24 Jun 2026 06:46:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782283596; cv=none; b=ngqOJEUenyAMiIyJkD1SBggHtxwTERha6sNkM0UMVr3anB6LY6ECr0Ide9VI0TPbJg0TGeXullUPASNqiPtKm1gRnHGHwtQp10UOJoAfu73bRWPZy0DNv/bH0ICbXwNSYyT8fKrnT90XMDbwi/Zn29cAxRHLDfkrM3aQcp2uyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782283596; c=relaxed/simple;
	bh=JohLVIOOj0NauXvt4WSRy3GjttDcZozn8cwIQ7iH/es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CAVSAt8T2xwt3pXCgFSk8B+zZMsPOLX9wb5jOKZLqS/V1JWUk1R/fy72gP8crUEynfY26igDi5ocGoxNzxC3DVJFQv7CfoAICHkdm8lLiwoapOT8rvfYax0tS/aI0kzqrpJ/tHm4BvWohc48b2netgWvKRvbE6/BA3F1+SUBr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH8jpjUT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFF91F000E9;
	Wed, 24 Jun 2026 06:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782283591;
	bh=qTgdzMLMshCYVBpBD/xe8FOx9yUbqJSARpmgFJAB3Iw=;
	h=From:To:Cc:Subject:Date;
	b=QH8jpjUTlUoj1NgHALKWJgnSXsWAOV405Km6mouiSfvnrHjpogGiLvQckgjUzzMV1
	 j4xDAORKOg8Ax7AQCrkko2N2s/bMn8DhMPsYdheJI46ZgyO8yDnvLMktI89T+AvQUi
	 ZG+WtmcAV9vYzXWzmQQJcaEwtLsmorS4L8Wl+jYwKBdBinu2GXEvVytYy3ZdpY3N8+
	 UC84oegyinVGyLoZfgYZcHPaIC7quSPDLsZbfNXKmOk9Sl4Y/b3cfgo6rLG1zvsTqz
	 fsRYky47MJStPe79xeH/e18mT742U+Ohskw2BdnzMbjLEYR7QO0W1nkM9V2URzJDZb
	 qj2hTmLswNzow==
From: Yu Kuai <yukuai@kernel.org>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Zheng Qixing <zhengqixing@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Tang Yizhou <yizhou.tang@shopee.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] md/linear: add fault-tolerant mode for unraid-like setups
Date: Wed, 24 Jun 2026 14:46:19 +0800
Message-ID: <20260624064625.1743650-1-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:zhengqixing@huawei.com,m:hch@lst.de,m:yizhou.tang@shopee.com,m:nilay@linux.ibm.com,m:ming.lei@redhat.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17216-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,fnnas.com:email,fdn.fr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C08936BBDF1

From: Yu Kuai <yukuai@fnnas.com>

Add a module parameter 'fault_tolerant' that changes how md-linear
handles disk failures. When enabled:

- Disk failures are isolated instead of failing the entire array
- I/O to failed disks returns -EIO while healthy disks continue
- The array remains operational with reduced capacity
- Failed disk count is tracked and shown in /proc/mdstat

This enables unraid-like functionality where individual disk failures
don't bring down the entire array, allowing continued access to data
on healthy disks.

The fault_tolerant parameter can be set at module load time or
dynamically via /sys/module/md_linear/parameters/fault_tolerant.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 drivers/md/md-linear.c | 63 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 8d7b82c4a723..8afc6665cfde 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -2,6 +2,10 @@
 /*
  * linear.c : Multiple Devices driver for Linux Copyright (C) 1994-96 Marc
  * ZYNGIER <zyngier@ufr-info-p7.ibp.fr> or <maz@gloups.fdn.fr>
+ *
+ * Fault-tolerant mode added for unraid-like setups.
+ * When fault_tolerant=1, disk failures are isolated - I/O to failed disks
+ * returns -EIO while healthy disks continue operating normally.
  */

 #include <linux/blkdev.h>
@@ -21,9 +25,15 @@ struct linear_conf {
 	sector_t                array_sectors;
 	/* a copy of mddev->raid_disks */
 	int                     raid_disks;
+	atomic_t		failed_disks;	/* count of failed disks */
 	struct dev_info         disks[] __counted_by(raid_disks);
 };

+static bool fault_tolerant;
+module_param(fault_tolerant, bool, 0644);
+MODULE_PARM_DESC(fault_tolerant,
+	"Enable fault-tolerant mode: isolate disk failures instead of failing array (default: false)");
+
 /*
  * find which device holds a particular offset
  */
@@ -96,6 +106,8 @@ static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
 	if (!conf)
 		return ERR_PTR(-ENOMEM);

+	atomic_set(&conf->failed_disks, 0);
+
 	/*
 	 * conf->raid_disks is copy of mddev->raid_disks. The reason to
 	 * keep a copy of mddev->raid_disks in struct linear_conf is,
@@ -251,7 +263,8 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 		     bio_sector < start_sector))
 		goto out_of_bounds;

-	if (unlikely(is_rdev_broken(tmp_dev->rdev))) {
+	if (unlikely(is_rdev_broken(tmp_dev->rdev) ||
+		     test_bit(Faulty, &tmp_dev->rdev->flags))) {
 		md_error(mddev, tmp_dev->rdev);
 		bio_io_error(bio);
 		return true;
@@ -296,16 +309,47 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)

 static void linear_status(struct seq_file *seq, struct mddev *mddev)
 {
+	struct linear_conf *conf = mddev->private;
+
 	seq_printf(seq, " %dk rounding", mddev->chunk_sectors / 2);
+	if (fault_tolerant) {
+		int failed = atomic_read(&conf->failed_disks);
+
+		seq_puts(seq, " fault-tolerant");
+		if (failed)
+			seq_printf(seq, " [%d failed]", failed);
+	}
 }

 static void linear_error(struct mddev *mddev, struct md_rdev *rdev)
 {
-	if (!test_and_set_bit(MD_BROKEN, &mddev->flags)) {
-		char *md_name = mdname(mddev);
-
-		pr_crit("md/linear%s: Disk failure on %pg detected, failing array.\n",
-			md_name, rdev->bdev);
+	char *md_name = mdname(mddev);
+
+	if (fault_tolerant) {
+		/*
+		 * Fault-tolerant mode: isolate the failed disk instead of
+		 * failing the entire array. I/O to this disk will return -EIO
+		 * but other disks continue operating normally.
+		 */
+		if (!test_and_set_bit(Faulty, &rdev->flags)) {
+			struct linear_conf *conf = mddev->private;
+
+			atomic_inc(&conf->failed_disks);
+			pr_warn("md/linear%s: Disk failure on %pg detected, isolating device (fault-tolerant mode).\n",
+				md_name, rdev->bdev);
+			pr_warn("md/linear%s: %d disk(s) now failed, array continues with reduced capacity.\n",
+				md_name, atomic_read(&conf->failed_disks));
+			/* Notify userspace about the state change */
+			sysfs_notify_dirent_safe(rdev->sysfs_state);
+		}
+	} else {
+		/*
+		 * Standard mode: fail the entire array on any disk failure.
+		 */
+		if (!test_and_set_bit(MD_BROKEN, &mddev->flags)) {
+			pr_crit("md/linear%s: Disk failure on %pg detected, failing array.\n",
+				md_name, rdev->bdev);
+		}
 	}
 }

@@ -344,7 +388,7 @@ static void linear_exit(void)
 module_init(linear_init);
 module_exit(linear_exit);
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Linear device concatenation personality for MD (deprecated)");
+MODULE_DESCRIPTION("Linear device concatenation personality for MD with optional fault-tolerant mode");
 MODULE_ALIAS("md-personality-1"); /* LINEAR - deprecated*/
 MODULE_ALIAS("md-linear");
 MODULE_ALIAS("md-level--1");
--
2.43.0

