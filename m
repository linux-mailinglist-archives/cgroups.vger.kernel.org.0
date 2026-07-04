Return-Path: <cgroups+bounces-17490-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FVvFDrlkSWrZ1AAAu9opvQ
	(envelope-from <cgroups+bounces-17490-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:53:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D173770854E
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:53:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K4lNN0dG;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17490-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17490-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A303030B04
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2026 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B830FF31;
	Sat,  4 Jul 2026 19:52:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282A12FF69;
	Sat,  4 Jul 2026 19:52:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194769; cv=none; b=SuCXRMZ7LMNbQt+QxA8fGiteVn51SHeNHV18Fe0HMaIQb4GZoq/3GtYTNLVpUwncNFJtYgd+O8x8X0cbeEnsTRU21cg6kNaTeY9fNfKcFM+XyDBec22RNgC/kpvyulqA35nPsszIgnQI9ghnUMDcHpFS76fhgv+u55ruRhy8V4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194769; c=relaxed/simple;
	bh=mTow1tmrdP9XeBM1b31QKMHtfH2seK9YXYtGLsyFW8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dnga2I3PNeT/RiwLTDDAkERknqhtHV5Lzhb6fjfs17Iq7Q1awt7aHV7C+sOZypn9vKrjackTLBCWX8bgd8MtOvok35tj431o+h8BC2+guZQhQkAC6+QoEorihiGyjtQOrG4WWPXVHQlQtQKzDDdVooW+UmpHDddiACqyjENliAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4lNN0dG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73361F000E9;
	Sat,  4 Jul 2026 19:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194767;
	bh=mXJiwwaeOWgN5pHsCgD632laX9hPGfy7GVg2b2/T7js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K4lNN0dGzzywNRxaL6RbtTbW0krF8yl7KvNm1psx9S8v+EoFuxPY356jqfIV6HtoT
	 MRluYXHFNTfis30lYXNmexdz9HdrBxACIAIDGZpGXI/cko4cY0p+fvUq+dfd9OyHIS
	 kpqjkeT6Di+7DaVQJ3V9SZ8QxhwJXmMKwewHuS+ljc7PMoDVi6RlrDpgwTSnsPkvvS
	 Rw58JYOrk0fQHEuk1f6ps4AbBYosAKE41/Oae2Bn0pXS782aD8g/AnCznb3ktD8dKl
	 cXk/qoyh9YABGrlWysWaRk/IBvOJ5IPZKMtunTfBT5AUi9LMRjYb3V6SFzyay8NF3i
	 veottqF8gIpqA==
From: Yu Kuai <yukuai@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>,
	Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev,
	linux-bcache@vger.kernel.org
Subject: [RFC PATCH v1 05/17] block: add bio_alloc_atomic() for atomic bio users
Date: Sun,  5 Jul 2026 03:51:12 +0800
Message-ID: <20260704195124.1375075-6-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260704195124.1375075-1-yukuai@kernel.org>
References: <20260704195124.1375075-1-yukuai@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17490-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:hch@lst.de,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:yukuai@fygo.io,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:linux-bcache@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D173770854E

From: Yu Kuai <yukuai@fygo.io>

Add bio_alloc_atomic() for callers that need a GFP_ATOMIC bio from the
default bio set but cannot safely pass a bdev during allocation. The
helper returns an unattached bio, leaving callers to set bi_bdev and
attach blkcg state explicitly before submission.

Use the helper for virtio-pmem flush child bios and OCFS2 heartbeat I/O.
Both allocate bios from atomic paths and must avoid creating missing blkgs
once blkg creation is protected by q->blkcg_mutex. virtio-pmem clones the
parent bio's blkg association; OCFS2 binds heartbeat I/O to the root blkg.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/nvdimm/nd_virtio.c   |  8 ++++----
 fs/ocfs2/cluster/heartbeat.c | 15 ++++++++++++---
 include/linux/bio.h          |  6 ++++++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 4176046627be..13d1ed1c466c 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -115,13 +115,13 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 	 * parent bio. Otherwise directly call nd_region flush.
 	 */
 	if (bio && bio->bi_iter.bi_sector != -1) {
-		struct bio *child = bio_alloc(bio->bi_bdev, 0,
-					      REQ_OP_WRITE | REQ_PREFLUSH,
-					      GFP_ATOMIC);
+		struct bio *child = bio_alloc_atomic(0,
+						REQ_OP_WRITE | REQ_PREFLUSH);
 
 		if (!child)
 			return -ENOMEM;
-		bio_clone_blkg_association(child, bio);
+		child->bi_bdev = bio->bi_bdev;
+			bio_clone_blkg_association(child, bio);
 		child->bi_iter.bi_sector = -1;
 		bio_chain(child, bio);
 		submit_bio(child);
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index d12784aaaa4b..ec70f3b62837 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/bio.h>
+#include <linux/blk-cgroup.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/file.h>
@@ -519,16 +520,24 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	struct bio *bio;
 	struct page *page;
 
-	/* Testing has shown this allocation to take long enough under
+	/*
+	 * Testing has shown this allocation to take long enough under
 	 * GFP_KERNEL that the local node can get fenced. It would be
 	 * nicest if we could pre-allocate these bios and avoid this
-	 * all together. */
-	bio = bio_alloc(reg_bdev(reg), 16, opf, GFP_ATOMIC);
+	 * all together.
+	 *
+	 * Use the atomic bio allocation helper so bio_init() does not create a
+	 * missing blkg. Heartbeat IO is cluster-liveness IO, so account it to
+	 * the root blkcg instead.
+	 */
+	bio = bio_alloc_atomic(16, opf);
 	if (!bio) {
 		mlog(ML_ERROR, "Could not alloc slots BIO!\n");
 		bio = ERR_PTR(-ENOMEM);
 		goto bail;
 	}
+	bio->bi_bdev = reg_bdev(reg);
+	bio_associate_blkg_from_css(bio, blkcg_root_css);
 
 	/* Must put everything in 512 byte sectors for the bio... */
 	bio->bi_iter.bi_sector = (reg->hr_start_block + cs) << (bits - 9);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8f33f717b14f..f7d94d37893f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -366,6 +366,12 @@ static inline struct bio *bio_alloc(struct block_device *bdev,
 	return bio_alloc_bioset(bdev, nr_vecs, opf, gfp_mask, &fs_bio_set);
 }
 
+static inline struct bio *bio_alloc_atomic(unsigned short nr_vecs,
+					   blk_opf_t opf)
+{
+	return bio_alloc_bioset(NULL, nr_vecs, opf, GFP_ATOMIC, &fs_bio_set);
+}
+
 void submit_bio(struct bio *bio);
 
 extern void bio_endio(struct bio *);
-- 
2.51.0


