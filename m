Return-Path: <cgroups+bounces-17215-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YijOK1N9O2qvYggAu9opvQ
	(envelope-from <cgroups+bounces-17215-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 08:46:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F046BBDEC
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 08:46:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HDBgCtkD;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17215-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17215-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D342930086A2
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 06:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE82E3890E0;
	Wed, 24 Jun 2026 06:46:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615283812DB;
	Wed, 24 Jun 2026 06:46:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782283595; cv=none; b=FzzZs31DMYHsGltCY6nTFlZrMpu7RjI/T2KHdvz20njveOdumKIWuiLrO7L9x8lwic+eVWWRN6yrcz35khwQJAyKI6SrwTYoDxx1FAhQsCQEfmRZJeQoSgjyN2ym4elFj/Pu/x1DpJHoESS2DAQMJhM7o375+AfMwPkOHoN1tMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782283595; c=relaxed/simple;
	bh=g6EqeEXBnoaVRejOJ9u5Dj/ZEULH5FgloATObUGA1CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjjiVL81sp66GS5jZdFx0jasUiMpZ8VKgHlT6Agsa5D+0CEtXInEWDolM7FdfAYQ2wBi/jvD7fO2TsA2ZIm4YdaaHOk7KtK1WFb3S+JAMLvQmB9HETNd8lTe9s+nyA6jwAmFBdCxNhS3AIPMGCqlNA6W3qnwQalwtUb3qUFM+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDBgCtkD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8128D1F00A3A;
	Wed, 24 Jun 2026 06:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782283594;
	bh=o78VMkMHXJafuebuik6iANSdovRwVCbx8HrhJTxecac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HDBgCtkD0N0m3G4ByJftgW2z4xVPErZsjaf5Ijggo12hRQrHk869fmM4GA8WkIjqv
	 Fzz2qz1AS7SJ2AP1pWrtvaEfzMwlZRv/6bGfBhXl1fUsNqb7SYVrx1PQD+A596NdUJ
	 P9/fBBmiGd6UIdYrYqbRw1Cvj/MZu5auE/5xqfiI6InmpOjpJcwWLTSEIQoCj3PWpk
	 OqzgaXF1XbRSIYR73R3NVV2AgirldWGZP1k4whw7coVekCwojLmQVT1QkicjY1yZeE
	 qANSC7h/5A7nOeJJ7e5EHAl253SG5MCFtI7BOWbx+29v0tZzgOtSaTsi94Ib8Is8E4
	 gEun5GaVKgDKQ==
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
Subject: [PATCH 2/2] ext4: add unraid mount option for single-disk-per-group mode
Date: Wed, 24 Jun 2026 14:46:20 +0800
Message-ID: <20260624064625.1743650-2-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260624064625.1743650-1-yukuai@kernel.org>
References: <20260624064625.1743650-1-yukuai@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:zhengqixing@huawei.com,m:hch@lst.de,m:yizhou.tang@shopee.com,m:nilay@linux.ibm.com,m:ming.lei@redhat.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17215-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,fnnas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0F046BBDEC

From: Yu Kuai <yukuai@fnnas.com>

Add support for an "unraid" mount option that enables a special mode
designed for use with fault-tolerant md-linear arrays. In this mode:

1. Variable block groups: Each block group can have a different size,
   allowing one physical disk per group. Lookup tables are used for
   block-to-group mapping instead of fixed-size calculations.

2. Distributed metadata: Every block group has its own superblock and
   group descriptor table copy, enabling the filesystem to remain
   accessible even if some disks fail.

3. Single-group allocation: Files are allocated entirely within a
   single block group. If a group doesn't have enough space, the
   allocation fails with -ENOSPC instead of trying other groups.
   This ensures each file resides on a single physical disk.

4. Inode locality: Inodes are allocated in the same group as their
   parent directory, keeping files and their metadata on the same disk.

This enables unraid-like functionality where:
- Each disk is independent and can be read separately
- Disk failures only affect files on that specific disk
- The filesystem continues operating with reduced capacity

Usage:
  mount -t ext4 -o unraid /dev/md0 /mnt

Note: This requires a specially formatted filesystem where each block
group corresponds to one physical disk. A future mkfs.ext4 extension
will support creating such filesystems.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 fs/ext4/balloc.c  | 45 ++++++++++++++++++++++++++++++++++++++++-----
 fs/ext4/ext4.h    | 15 ++++++++++++++-
 fs/ext4/ialloc.c  | 13 +++++++++++++
 fs/ext4/mballoc.c |  8 ++++++++
 fs/ext4/super.c   | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 143 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8040c731b3e4..bd151dc5480b 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -54,17 +54,43 @@ ext4_group_t ext4_get_group_number(struct super_block *sb,
 void ext4_get_group_no_and_offset(struct super_block *sb, ext4_fsblk_t blocknr,
 		ext4_group_t *blockgrpp, ext4_grpblk_t *offsetp)
 {
-	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_super_block *es = sbi->s_es;
 	ext4_grpblk_t offset;

 	blocknr = blocknr - le32_to_cpu(es->s_first_data_block);
+
+	/* Unraid mode: binary search through variable-size groups */
+	if (sbi->s_group_first_block) {
+		ext4_group_t lo = 0, hi = sbi->s_groups_count - 1;
+		ext4_fsblk_t first_data = le32_to_cpu(es->s_first_data_block);
+
+		blocknr += first_data; /* restore original block number */
+
+		while (lo < hi) {
+			ext4_group_t mid = (lo + hi + 1) / 2;
+
+			if (blocknr < sbi->s_group_first_block[mid])
+				hi = mid - 1;
+			else
+				lo = mid;
+		}
+		if (blockgrpp)
+			*blockgrpp = lo;
+		if (offsetp) {
+			offset = (blocknr - sbi->s_group_first_block[lo]) >>
+				 sbi->s_cluster_bits;
+			*offsetp = offset;
+		}
+		return;
+	}
+
 	offset = do_div(blocknr, EXT4_BLOCKS_PER_GROUP(sb)) >>
-		EXT4_SB(sb)->s_cluster_bits;
+		sbi->s_cluster_bits;
 	if (offsetp)
 		*offsetp = offset;
 	if (blockgrpp)
 		*blockgrpp = blocknr;
-
 }

 /*
@@ -162,8 +188,13 @@ static unsigned ext4_num_overhead_clusters(struct super_block *sb,
 static unsigned int num_clusters_in_group(struct super_block *sb,
 					  ext4_group_t block_group)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	unsigned int blocks;

+	/* Unraid mode: use per-group blocks count */
+	if (sbi->s_group_blocks_count)
+		return EXT4_NUM_B2C(sbi, sbi->s_group_blocks_count[block_group]);
+
 	if (block_group == ext4_get_groups_count(sb) - 1) {
 		/*
 		 * Even though mke2fs always initializes the first and
@@ -171,11 +202,11 @@ static unsigned int num_clusters_in_group(struct super_block *sb,
 		 * we need to make sure we calculate the right free
 		 * blocks.
 		 */
-		blocks = ext4_blocks_count(EXT4_SB(sb)->s_es) -
+		blocks = ext4_blocks_count(sbi->s_es) -
 			ext4_group_first_block_no(sb, block_group);
 	} else
 		blocks = EXT4_BLOCKS_PER_GROUP(sb);
-	return EXT4_NUM_B2C(EXT4_SB(sb), blocks);
+	return EXT4_NUM_B2C(sbi, blocks);
 }

 /* Initializes an uninitialized block bitmap */
@@ -855,6 +886,13 @@ int ext4_bg_has_super(struct super_block *sb, ext4_group_t group)
 {
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;

+	/*
+	 * Unraid mode: every group has a superblock copy for fault tolerance.
+	 * This allows mounting the filesystem even if some disks fail.
+	 */
+	if (test_opt2(sb, UNRAID))
+		return 1;
+
 	if (group == 0)
 		return 1;
 	if (ext4_has_feature_sparse_super2(sb)) {
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 56112f201cac..063e37a82654 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1295,6 +1295,9 @@ struct ext4_inode_info {
 						    * scanning in mballoc
 						    */
 #define EXT4_MOUNT2_ABORT		0x00000100 /* Abort filesystem */
+#define EXT4_MOUNT2_UNRAID		0x00000200 /* Unraid mode: one disk per
+						    * group, single-group alloc
+						    */

 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
@@ -1687,6 +1690,10 @@ struct ext4_sb_info {
 	struct flex_groups * __rcu *s_flex_groups;
 	ext4_group_t s_flex_groups_allocated;

+	/* Unraid mode: variable block groups (one disk per group) */
+	ext4_fsblk_t *s_group_first_block;	/* First block of each group */
+	ext4_grpblk_t *s_group_blocks_count;	/* Blocks count per group */
+
 	/* workqueue for reserved extent conversions (buffered io) */
 	struct workqueue_struct *rsv_conversion_wq;

@@ -2627,8 +2634,14 @@ struct dir_private_info {
 static inline ext4_fsblk_t
 ext4_group_first_block_no(struct super_block *sb, ext4_group_t group_no)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	/* Unraid mode: variable block groups, use lookup table */
+	if (sbi->s_group_first_block)
+		return sbi->s_group_first_block[group_no];
+
 	return group_no * (ext4_fsblk_t)EXT4_BLOCKS_PER_GROUP(sb) +
-		le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block);
+		le32_to_cpu(sbi->s_es->s_first_data_block);
 }

 /*
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b20a1bf866ab..98fda602073e 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -438,6 +438,19 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 	int flex_size = ext4_flex_bg_size(sbi);
 	struct dx_hash_info hinfo;

+	/*
+	 * Unraid mode: always allocate inode in parent's group.
+	 * This ensures files and their inodes stay on the same disk.
+	 */
+	if (test_opt2(sb, UNRAID)) {
+		desc = ext4_get_group_desc(sb, parent_group, NULL);
+		if (desc && ext4_free_inodes_count(sb, desc) > 0) {
+			*group = parent_group;
+			return 0;
+		}
+		return -1; /* No free inodes in parent's group */
+	}
+
 	ngroups = real_ngroups;
 	if (flex_size > 1) {
 		ngroups = (real_ngroups + flex_size - 1) >>
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 56d50fd3310b..9de674ec2f77 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2997,6 +2997,14 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	if (err || ac->ac_status == AC_STATUS_FOUND)
 		goto out;

+	/*
+	 * Unraid mode: files must be allocated entirely within a single group.
+	 * If the goal group doesn't have enough space, fail with -ENOSPC
+	 * instead of trying other groups.
+	 */
+	if (test_opt2(sb, UNRAID))
+		goto out;
+
 	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
 		goto out;

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d0..9534a4ffbee7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1255,6 +1255,12 @@ static void ext4_group_desc_free(struct ext4_sb_info *sbi)
 		brelse(group_desc[i]);
 	kvfree(group_desc);
 	rcu_read_unlock();
+
+	/* Free unraid mode arrays */
+	kvfree(sbi->s_group_first_block);
+	kvfree(sbi->s_group_blocks_count);
+	sbi->s_group_first_block = NULL;
+	sbi->s_group_blocks_count = NULL;
 }

 static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
@@ -1677,6 +1683,7 @@ enum {
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
 	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
 	Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
+	Opt_unraid,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
 #endif
@@ -1819,6 +1826,7 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_flag	("reservation",		Opt_removed),	/* mount option from ext2/3 */
 	fsparam_flag	("noreservation",	Opt_removed),	/* mount option from ext2/3 */
 	fsparam_u32	("journal",		Opt_removed),	/* mount option from ext2/3 */
+	fsparam_flag	("unraid",		Opt_unraid),
 	{}
 };

@@ -1912,6 +1920,7 @@ static const struct mount_opts {
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
 #endif
 	{Opt_abort, EXT4_MOUNT2_ABORT, MOPT_SET | MOPT_2},
+	{Opt_unraid, EXT4_MOUNT2_UNRAID, MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_err, 0, 0}
 };

@@ -4845,6 +4854,65 @@ static int ext4_check_geometry(struct super_block *sb,
 	return 0;
 }

+/*
+ * Initialize unraid mode data structures.
+ * In unraid mode, each block group can have a different size (one disk per group).
+ * This function allocates and populates the lookup tables for variable-size groups.
+ *
+ * For now, this uses the standard fixed-size groups from the superblock.
+ * A future mkfs extension will store per-group sizes in the group descriptors.
+ */
+static int ext4_unraid_init(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	ext4_group_t ngroups = sbi->s_groups_count;
+	ext4_fsblk_t first_data_block;
+	ext4_group_t i;
+
+	if (!test_opt2(sb, UNRAID))
+		return 0;
+
+	sbi->s_group_first_block = kvmalloc_array(ngroups,
+						  sizeof(ext4_fsblk_t),
+						  GFP_KERNEL);
+	if (!sbi->s_group_first_block)
+		return -ENOMEM;
+
+	sbi->s_group_blocks_count = kvmalloc_array(ngroups,
+						   sizeof(ext4_grpblk_t),
+						   GFP_KERNEL);
+	if (!sbi->s_group_blocks_count) {
+		kvfree(sbi->s_group_first_block);
+		sbi->s_group_first_block = NULL;
+		return -ENOMEM;
+	}
+
+	/*
+	 * Initialize with standard fixed-size groups for now.
+	 * TODO: Read per-group sizes from extended group descriptors
+	 * when mkfs supports creating variable-size groups.
+	 */
+	first_data_block = le32_to_cpu(sbi->s_es->s_first_data_block);
+	for (i = 0; i < ngroups; i++) {
+		sbi->s_group_first_block[i] = first_data_block +
+			(ext4_fsblk_t)i * EXT4_BLOCKS_PER_GROUP(sb);
+
+		if (i == ngroups - 1) {
+			/* Last group may be smaller */
+			sbi->s_group_blocks_count[i] =
+				ext4_blocks_count(sbi->s_es) -
+				sbi->s_group_first_block[i];
+		} else {
+			sbi->s_group_blocks_count[i] = EXT4_BLOCKS_PER_GROUP(sb);
+		}
+	}
+
+	ext4_msg(sb, KERN_INFO, "unraid mode enabled: %u groups",
+		 ngroups);
+
+	return 0;
+}
+
 static int ext4_group_desc_init(struct super_block *sb,
 				struct ext4_super_block *es,
 				ext4_fsblk_t logical_sb_block,
@@ -4904,7 +4972,8 @@ static int ext4_group_desc_init(struct super_block *sb,
 		return -EFSCORRUPTED;
 	}

-	return 0;
+	/* Initialize unraid mode data structures if enabled */
+	return ext4_unraid_init(sb);
 }

 static int ext4_load_and_init_journal(struct super_block *sb,
--
2.43.0

