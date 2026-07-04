Return-Path: <cgroups+bounces-17492-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sY3/L9VkSWro1AAAu9opvQ
	(envelope-from <cgroups+bounces-17492-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:53:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A1870856F
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:53:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JKlDDY81;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17492-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17492-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6113230342A5
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2026 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D20E318EF6;
	Sat,  4 Jul 2026 19:53:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC212FF69;
	Sat,  4 Jul 2026 19:53:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194788; cv=none; b=q4H7Gwth9EjG8X5gVmWjyeIefQ1v8lnJyKl2MpvJMAjcRjpt7CcJ857OQONMneaflQ8Meeod/C0oprdYtsFEs8aI+XwNA59Jj2URpPwaYvK02J2g9CgxYGx6T/3XmyONd7N0DBUDh6luf93Su/FWzr0y1Y/yFNNmVm0ETKnB+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194788; c=relaxed/simple;
	bh=zz3NRbEvLSAiSUMwPoSdmiYJ+uTSvZtQMY/4EyU7c8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1ND1GOoHeJ9ctO2KM2A00DgriyuEJO922lyje9EVPTxEpXrJkUcHB13q3cqnDBFsjdaI8Pae4BbG0y4xR+frYyQchO0Hx8bMJK+T7tqch4soZWttN5Ey3F4yX7Lxhl3d15gNkHh8H4GfTWFU74WMitU+fvj4NpaICrVZ+Gd2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKlDDY81; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75FD1F000E9;
	Sat,  4 Jul 2026 19:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194786;
	bh=1FpL4WUmWFei6Nrd4vePrJQcJLiUUV2Fb3+2p1inoVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JKlDDY8150KEk8TH9saEzRJac0guinUj9WaTe0AEgETybWxhsAdR98DyWdHRx4la2
	 HCwe/avjUI0pBBqGjzz2Su4uGTLHuStqBmqZujQBanW2/g++DowjckdKqLmuha+Z/F
	 qs0oUTkecOP8UiYlhzharbzr4kvqdlH/kCWNCQtFhKrCtsJPTURx69DkLwGD/Uymet
	 FDATUJPb+ZawZymAtVFzmvCtx07c7YgIEnEd61Qhz9EvPQaAawCIvr0aicEX6wzATt
	 GxPz7sgZubYsyzdAsVJlUryPkFD7Brnm7t+y1rS/Ke94UzoeolFsJA42K8249dgkB1
	 k8vC1YaY9Vhjw==
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
Subject: [RFC PATCH v1 07/17] block: support non-blocking bio allocation with a bdev
Date: Sun,  5 Jul 2026 03:51:14 +0800
Message-ID: <20260704195124.1375075-8-yukuai@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17492-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58A1870856F

From: Yu Kuai <yukuai@fygo.io>

bio_alloc_clone(), bio_init_clone(), and bio_alloc_bioset() can be called
with non-blocking GFP masks.  Passing a bdev into bio initialization may
need to associate blkcg state and, after missing blkg creation is serialized
by q->blkcg_mutex, that association can sleep.

Keep the generic block layer simple by letting bio_alloc_bioset() handle this
case directly.  Non-blocking allocations initialize the bio without a bdev,
set the bdev fields, and associate the blkg with nowait=true.  If the needed
blkg is missing and would have to be created, allocation fails normally so the
caller can retry from a blocking context.

Blocking callers keep the existing allocation-time association behavior.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/bio.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b74e9961c8ee..863ae73a4222 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -259,6 +259,20 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 }
 EXPORT_SYMBOL(bio_init);
 
+static bool bio_init_nowait(struct bio *bio, struct block_device *bdev,
+		struct bio_vec *table, unsigned short max_vecs, blk_opf_t opf)
+{
+	bio_init(bio, NULL, table, max_vecs, opf);
+	if (bdev) {
+		bio_set_dev_no_blkg(bio, bdev);
+		if (bio_associate_blkg(bio, true))
+			return true;
+		bio_uninit(bio);
+		return false;
+	}
+	return true;
+}
+
 /**
  * bio_reset - reinitialize a bio
  * @bio:	bio to reset
@@ -599,12 +613,25 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 		}
 	}
 
-	if (nr_vecs && nr_vecs <= BIO_INLINE_VECS)
-		bio_init_inline(bio, bdev, nr_vecs, opf);
-	else
-		bio_init(bio, bdev, bvecs, nr_vecs, opf);
+	if (nr_vecs && nr_vecs <= BIO_INLINE_VECS) {
+		bvecs = bio_inline_vecs(bio);
+		if (gfpflags_allow_blocking(saved_gfp))
+			bio_init(bio, bdev, bvecs, nr_vecs, opf);
+		else if (!bio_init_nowait(bio, bdev, bvecs, nr_vecs, opf))
+			goto fail_free_bio;
+	} else {
+		if (gfpflags_allow_blocking(saved_gfp))
+			bio_init(bio, bdev, bvecs, nr_vecs, opf);
+		else if (!bio_init_nowait(bio, bdev, bvecs, nr_vecs, opf))
+			goto fail_free_bio;
+	}
 	bio->bi_pool = bs;
 	return bio;
+
+fail_free_bio:
+	bio->bi_pool = bs;
+	bio_put(bio);
+	return NULL;
 }
 EXPORT_SYMBOL(bio_alloc_bioset);
 
@@ -857,7 +884,9 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 		if (bio->bi_bdev == bio_src->bi_bdev &&
 		    bio_flagged(bio_src, BIO_REMAPPED))
 			bio_set_flag(bio, BIO_REMAPPED);
-		bio_clone_blkg_association(bio, bio_src, false);
+		if (!bio_clone_blkg_association(bio, bio_src,
+					!gfpflags_allow_blocking(gfp)))
+			return -ENOMEM;
 	}
 
 	if (bio_crypt_clone(bio, bio_src, gfp) < 0)
@@ -913,9 +942,14 @@ EXPORT_SYMBOL(bio_alloc_clone);
 int bio_init_clone(struct block_device *bdev, struct bio *bio,
 		struct bio *bio_src, gfp_t gfp)
 {
+	bool blocking = gfpflags_allow_blocking(gfp);
 	int ret;
 
-	bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	if (blocking)
+		bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	else if (!bio_init_nowait(bio, bdev, bio_src->bi_io_vec, 0,
+				bio_src->bi_opf))
+		return -ENOMEM;
 	ret = __bio_clone(bio, bio_src, gfp);
 	if (ret)
 		bio_uninit(bio);
-- 
2.51.0


