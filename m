Return-Path: <cgroups+bounces-17487-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /xmWNoBkSWq61AAAu9opvQ
	(envelope-from <cgroups+bounces-17487-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:52:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4DE70850D
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:52:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZCleqOGY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17487-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17487-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2072E302592E
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2026 19:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1F530BF70;
	Sat,  4 Jul 2026 19:52:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84012FF69;
	Sat,  4 Jul 2026 19:52:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194733; cv=none; b=PlfYZPSURTi1HdB1M0W5F4+X9W9Dna45iTGX5ADd4s+D7hXCkfxlA6UuVDo/NdFbewNa4dB1lJGcv5fe4aI9usOh3g/acMRYS45yIMoTGZe4ynpc5ra4w/Gy/3wieD3jiRxg3Flr8WacDH3gQaUwtJaNttmRA+u3GIhrSSp8EtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194733; c=relaxed/simple;
	bh=d1mIsWoDFKquCnFkzgP0w75KDFMqJUbggfaQLhSE/fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGJHehLmDF6ShvdwMdLODC43Yea+KRmcGTRNW4trsnVliKt8ykMJiM/iSOFaLfi6PbDoYEOYmNaQUDmkX8v/6OR0GmJqHUX0N/SB2IRtDRtJHxte9YtVeCP2Ze9kpANxyku0Ft9ksb9Xy+jq++ATu2ZwEFBcFcDPMES0YU18JmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCleqOGY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D27A1F00A3D;
	Sat,  4 Jul 2026 19:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194731;
	bh=meOw3Z9Denlj5voe7/+ys0H168Jrgw9IPm8tzXoGU8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZCleqOGY6Uz+hi0/zU6kBYPX4JkgvvTkKyjqWmrJU/2q9rYkqtbUxVTXZUz1xSr6L
	 JlZMHeED72uBZdY27eg8DN+RV7s7+2xWEZ3RAryRAU7nq29ggpFn5tMwvxwMMjeNeC
	 mtckbJ1SdrUm0/bbZ/P8Lm0QL/vgZkBHl/uNFw13H/ipHe3JABKjTjyIaxWjfxMpq0
	 xvwOV9dEQOqFe6kjXyzVGgd2olEOgdLFFbVZi+jdMeQkASR5axcoj9Wavfg7dth4F6
	 pIVd1jrnnBAGfy9bSJfMpiHv6km/k9d6SFU9bsMKxt2QwNEZ1a8CWPqmKK6fKqYwMn
	 QhvjMXXLC78wg==
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
Subject: [RFC PATCH v1 02/17] dm thin: avoid bio_set_dev under pool lock
Date: Sun,  5 Jul 2026 03:51:09 +0800
Message-ID: <20260704195124.1375075-3-yukuai@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-17487-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:hch@lst.de,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:yukuai@fygo.io,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:linux-bcache@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[fygo.io:server fail,vger.kernel.org:server fail,sea.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo.io:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C4DE70850D

From: Yu Kuai <yukuai@fygo.io>

bio_set_dev() is about to become explicitly sleepable because it can
associate the bio with a blkg for the destination queue.  pool_map()
calls bio_set_dev() while holding pool->lock with interrupts disabled,
which would be invalid once bio_set_dev() may sleep.

The lock is not needed in this map path.  The pool target is a singleton
mapping and pool_map() only reads pt->data_dev, which is a target-private
device reference acquired during construction and released during target
destruction.  It does not inspect or modify pool state protected by
pool->lock.

Remove the lock so the remap stays in the normal sleepable DM map context
while the data device pointer remains stable for the table lifetime.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/md/dm-thin.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 59392de7a477..358ed77ffb2b 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -3438,14 +3438,11 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 static int pool_map(struct dm_target *ti, struct bio *bio)
 {
 	struct pool_c *pt = ti->private;
-	struct pool *pool = pt->pool;
 
 	/*
 	 * As this is a singleton target, ti->begin is always zero.
 	 */
-	spin_lock_irq(&pool->lock);
 	bio_set_dev(bio, pt->data_dev->bdev);
-	spin_unlock_irq(&pool->lock);
 
 	return DM_MAPIO_REMAPPED;
 }
-- 
2.51.0


