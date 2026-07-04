Return-Path: <cgroups+bounces-17494-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tf09ILlkSWra1AAAu9opvQ
	(envelope-from <cgroups+bounces-17494-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:53:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D46270854F
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:53:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GaWuNgIb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17494-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17494-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07E303018421
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2026 19:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F02031C56D;
	Sat,  4 Jul 2026 19:53:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B130FF31;
	Sat,  4 Jul 2026 19:53:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194806; cv=none; b=BgE3h687HWYqwOwVzz6YH87d5fNqO6Bx2A/hoYhptoHenf29akagIDJyXMRuyizc5UbDFVQ/242N7026NNp/wE2WL7o2GX0vgkfenIDR4YaJ1v98cfmB3XlP2eW+cusmAQdKcBdfE3cd4NLRfjlWoIzeknJRg5eQx1lW6Zj4nsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194806; c=relaxed/simple;
	bh=OKOcxwJnkc/ARSDUgDrCr7CN2a3rBbXYZDdk3XCqiZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwqSxi9q2DX/m8AQ8FB1o8bReEPWsNM4OaThJJdHDsgJ0Cxi45n0PF8gdoZYESoO2bpkJ4KGiQxHVOV10qQEOtKz7OqRZvoCF6Uc/vVEheha67p0KqJ2dSJVCIfYJuSuqEIN3nwwQeqZAjG6Lsqkts8nGBUR3fF2FZvv/QzGlR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaWuNgIb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04741F000E9;
	Sat,  4 Jul 2026 19:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194805;
	bh=zQ8NFFnrfR/LxjP0ImdEIBDB39CcwzRHlHhlzG8LKL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GaWuNgIbCwmzP/42S9NjcYrEKh2oUpGrkIAKeT20J6b1vRH4wcKKjaPAek2aTwMeQ
	 pcr4Byu3MTJJlaWTMeqmVIqfcbjXVq2+US7UGlbSj59zTH6o6yatGKs+z6pDbJysmN
	 QhvYmsxxLbDiaXEseGwF4BD158z4u9o6dB9/p3JvLqCsitCuxqdwoQPFIMqaWj9zpi
	 +5z1Rp8rIjathQmJYXiSGDJca6vTkzlOHZ2NB86clARjAPpiBpiqy9RYPjeas9GdTc
	 BqhNcE5+57HLidXrJwJPAiIYDOZ3hr3s6j0Y6u8Ih8w1PvPidZNL4uJuH5Dp0SDtZy
	 eWs+RLcFRHQDQ==
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
Subject: [RFC PATCH v1 09/17] dm bufio: avoid blkg association from GFP_NOWAIT bio init
Date: Sun,  5 Jul 2026 03:51:16 +0800
Message-ID: <20260704195124.1375075-10-yukuai@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17494-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo.io:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D46270854F

From: Yu Kuai <yukuai@fygo.io>

dm-bufio allocates a bio with bio_kmalloc(GFP_NOWAIT) and then initializes it
with the target bdev.  That initialization can attach blkcg state and sleep to
create a missing blkg once blkg lookup is protected by q->blkcg_mutex.

Initialize the bio without a bdev, set the bdev fields, and associate blkcg
with nowait=true.  Fall back to dm_io if a missing blkg would need to be
created.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/md/dm-bufio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 26fedf5883ef..2002d9020dd6 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1347,7 +1347,14 @@ static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
 		use_dmio(b, op, sector, n_sectors, offset, ioprio);
 		return;
 	}
-	bio_init_inline(bio, b->c->bdev, 1, op);
+	bio_init_inline(bio, NULL, 1, op);
+	bio_set_dev_no_blkg(bio, b->c->bdev);
+	if (!bio_associate_blkg(bio, true)) {
+		bio_uninit(bio);
+		kfree(bio);
+		use_dmio(b, op, sector, n_sectors, offset, ioprio);
+		return;
+	}
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = bio_complete;
 	bio->bi_private = b;
-- 
2.51.0


