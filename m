Return-Path: <cgroups+bounces-2222-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F588FA21
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 09:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C795B23119
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9235858108;
	Thu, 28 Mar 2024 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R++0w6li"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D74E1C3;
	Thu, 28 Mar 2024 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615321; cv=none; b=Xg7DQQlEZiOXN1dcIAjfq4pk0KIDrb+b93FPaXI12AotpsG2XvxwoA8bxZlvoZ1MsSw2i+68nTqNPniVm4B3X/sbM3C0bGfCZ4hpA22NcyS4fHgbb9/mrA94s3+egM7Ks/5fGXx/y/BftfdZCdA0q5DUBf2l9xVoI6/PI0WqGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615321; c=relaxed/simple;
	bh=Wh5f//B3rvnZbHNlgyZBvjiD46kT3A9mrR2aVd1LGCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmkbIc9yomYA/UJws+wiWcvgemF/G5NOYqyOU187S0gpJcJWDviSGkeC37Iw51z0xFJBQ3GGf+lrP6vh6u+O7Q1enqB5vqNr618sil4vkOdiQ2H5Vi1lk8NxudCsusCaG3uI+EOYpZefu29unJc4BP8lOlJ0NKjSfCu2m3eszbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R++0w6li; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hVD7v6+6VwinFLL4+rPTgZw4Dh8MNBSsRuuP0sddVvY=; b=R++0w6lim+4zleZWWe9q8WW5Gh
	zEMHf8d+qNK2NpO9tiG3VTN0CGUQrXb8SXgkRyxq6+mKLH0WgWYzsAgYJSyXmSJBfwau07CeYMv4M
	EJOc+7qxZKUG2fbW8MjSQIwAgvYkZVqD7i5RJtI66kqL0KfrP4ePdUEBktayYHAP64zAracECiIdb
	6pvaQAviS1MhiNCgvkw6FTp6jgiODnbbctxBpgSsElbbAxyt0Bwv23r7TlQk6NAAg6M3QBp8qsg52
	9/ghfSi8yCrge6+/ccJ3K3jjKl+zdkex955yHvMhcgbL1dpAlD5M8kNX1qIlSC12ysyDhnO4efXwp
	Myfqp48Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplKe-0000000D7ac-4Aur;
	Thu, 28 Mar 2024 08:41:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Matthew Sakai <msakai@redhat.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	dm-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] blk-cgroup: use bio_list_merge_init
Date: Thu, 28 Mar 2024 09:41:45 +0100
Message-Id: <20240328084147.2954434-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328084147.2954434-1-hch@lst.de>
References: <20240328084147.2954434-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use bio_list_merge_init instead of open coding bio_list_merge and
bio_list_init.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bdbb557feb5a0e..8598e4591e7966 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -218,8 +218,7 @@ static void blkg_async_bio_workfn(struct work_struct *work)
 
 	/* as long as there are pending bios, @blkg can't go away */
 	spin_lock(&blkg->async_bio_lock);
-	bio_list_merge(&bios, &blkg->async_bios);
-	bio_list_init(&blkg->async_bios);
+	bio_list_merge_init(&bios, &blkg->async_bios);
 	spin_unlock(&blkg->async_bio_lock);
 
 	/* start plug only when bio_list contains at least 2 bios */
-- 
2.39.2


