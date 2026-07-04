Return-Path: <cgroups+bounces-17495-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z8d6H8pkSWrm1AAAu9opvQ
	(envelope-from <cgroups+bounces-17495-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:53:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2177708567
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:53:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RYJLAz9V;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17495-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17495-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7889301649C
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2026 19:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164B031E83D;
	Sat,  4 Jul 2026 19:53:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557B12FF69;
	Sat,  4 Jul 2026 19:53:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194823; cv=none; b=OR/ackZ/qMhvusH69xNPQjwd6JAhdKJ7gt7V6iEuwFOZ9a62XzBWZADbuaZVz5NTeQETeeTbHjvtbUZPqr1tLQHU8y8Q1L5jDhT0rYzCuMxVS03taF2iN7uaz3uPEY6XDHCXdVKKVlg8QW6FHka5o9IfCv628tnPC1pog3d3sy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194823; c=relaxed/simple;
	bh=ZAeSgmaMDILBVptwMaySFUTMFBfNDTdMFMa8qixecos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTbnlOs17rCG/rV8k8ykxGOVRAmUymSC50oECdwwzzaNYZ0xJy5hbyoOQrQVWTnKTA3qg66nZlbHcoMxQnOdAfbVw/uGXKYzzHrfeOmU6ufp3aEav/6r9hA07jEqMBSX5IV9qLZOt6Z0R5C5Izocc6sV1K6o/7MQYdesjrwEMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYJLAz9V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8EC1F00A3A;
	Sat,  4 Jul 2026 19:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194822;
	bh=ZHOaqZ/LhOhHQYZrYbmcZFHexqdd2uvYRy06XraBRZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYJLAz9VYwydHo4sD+p6eGMOD8kpwfPJtash7Ltij6VmKmwEyHRwoDKBdWdX3DqAS
	 n4qwbrhW32pOz0qBM+pR+OwA06+0/8Lxh3TMqAypDQKjqcLgziKaWlR/iRevm20zrp
	 1VPKHNmg45HWT2FZ8irnbc0fMwCgNTtekSIUjxoKXZ8Q/oCo95Q19im7QAMNGhTwHX
	 36XKdC6l5/vhmc1QiisH8s98dSAkp6KhllcyXZY0lQb9NJhpdnbtxX36t1hN+r9H9u
	 7SMMa4MnKT0JKPx1nWvMXTtUprjhiXMEL/43sSAby6/bnJivg7IO0oyPKPoDigpN4R
	 kcCfUOGMqAxQw==
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
Subject: [RFC PATCH v1 10/17] dm pcache: handle non-blocking bio clone init failure
Date: Sun,  5 Jul 2026 03:51:17 +0800
Message-ID: <20260704195124.1375075-11-yukuai@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17495-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo.io:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2177708567

From: Yu Kuai <yukuai@fygo.io>

dm-pcache may preallocate backing requests with GFP_NOWAIT and initialize
the embedded bio with bio_init_clone().  Non-blocking clone initialization
can now fail if cloning the blkg association would need to create a blkg.

Check the return value and free the preallocated request on failure so the
existing caller can retry through its GFP_NOIO preallocation path.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/md/dm-pcache/backing_dev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-pcache/backing_dev.c b/drivers/md/dm-pcache/backing_dev.c
index 7165fc0364bb..5bde289ec5d7 100644
--- a/drivers/md/dm-pcache/backing_dev.c
+++ b/drivers/md/dm-pcache/backing_dev.c
@@ -204,6 +204,7 @@ static struct pcache_backing_dev_req *req_type_req_alloc(struct pcache_backing_d
 	struct pcache_request *pcache_req = opts->req.upper_req;
 	struct pcache_backing_dev_req *backing_req;
 	struct bio *orig = pcache_req->bio;
+	int ret;
 
 	backing_req = mempool_alloc(&backing_dev->req_pool, opts->gfp_mask);
 	if (!backing_req)
@@ -211,13 +212,20 @@ static struct pcache_backing_dev_req *req_type_req_alloc(struct pcache_backing_d
 
 	memset(backing_req, 0, sizeof(struct pcache_backing_dev_req));
 
-	bio_init_clone(backing_dev->dm_dev->bdev, &backing_req->bio, orig, opts->gfp_mask);
+	ret = bio_init_clone(backing_dev->dm_dev->bdev, &backing_req->bio,
+			     orig, opts->gfp_mask);
+	if (ret)
+		goto free_backing_req;
 
 	backing_req->type = BACKING_DEV_REQ_TYPE_REQ;
 	backing_req->backing_dev = backing_dev;
 	atomic_inc(&backing_dev->inflight_reqs);
 
 	return backing_req;
+
+free_backing_req:
+	mempool_free(backing_req, &backing_dev->req_pool);
+	return NULL;
 }
 
 static struct pcache_backing_dev_req *kmem_type_req_alloc(struct pcache_backing_dev *backing_dev,
-- 
2.51.0


