Return-Path: <cgroups+bounces-10634-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DDABCC47F
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45813BACAE
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68926FA77;
	Fri, 10 Oct 2025 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWte+dZe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8725EF87;
	Fri, 10 Oct 2025 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087709; cv=none; b=DuuD2ExgCyxOKiNsr1+rMpNcNTRK4SN8xWCrci9LdtM41tsSGosaC0RMyzH/QOvBiLNTKSFAlazAkStmWd3hKpzJqYbHmMo0Ltv5AfvFo/jw+tn2vuSqatMuYcm11NX1pZove0eOgZvvjgCnwSElvQ65NNNeFn7l+mHvmekO5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087709; c=relaxed/simple;
	bh=sqJuHAprKJQ3RhTMTwL0vwyV20ICgfdd32xYvJ9805M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zonm4HEmyJnf0mQEpmJQlWdHkvw+MOToR8PrWGdCSmnzIPzwQyvov25AmcSiqFKC9gSVRkTyjKP+O1uWVJ58jQt3x+BW/F61SW6gSnCoRXLNbMmYyKsCm/XdkTnwJrDSx68gxD3xcyYQACBezwteIQh+JpYtkwQxTRB9yDVVxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWte+dZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15CBC4CEFE;
	Fri, 10 Oct 2025 09:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087706;
	bh=sqJuHAprKJQ3RhTMTwL0vwyV20ICgfdd32xYvJ9805M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWte+dZepLXYxECs3XRrjQxMe+uiU/DCu0QZCHhdKkyiP8LljthiG/W/MyLdreNRw
	 9FMTpqwyUPLcnFqh5hy2Bz5jY67Z/f6k1oysuenYQxmdJocoKdCTh/kvX5s9+gE4Ci
	 nxO6QuGOQ6i7qAaH8gngIr6ghsbBkY6vkctc86Kxg/qRWstYCBcSxKZcx/8RGnDbzp
	 jYbj+3heIhE57adJd++X0pbi210xpSNNtSQ8FdN/d6hv0uPfV42CVu4nzxxIMrUbbr
	 4/wJ1KiCWr1PaH2RW42MQoBC0iGeZ4w+fJ43XpUMU32+pMuv8uahBbqNUZtDh7s2iO
	 fyUFA3OjuhaTA==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	tj@kernel.org,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2 05/19] blk-cgroup: don't nest queu_lock under rcu in bio_associate_blkg()
Date: Fri, 10 Oct 2025 17:14:30 +0800
Message-ID: <20251010091446.3048529-6-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010091446.3048529-1-yukuai@kernel.org>
References: <20251010091446.3048529-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

If bio is already associated with blkg, blkcg is already pinned until
bio is done, no need for rcu protection; Otherwise protect blkcg_css()
with rcu independently. Prepare to convert protecting blkcg with
blkcg_mutex instead of queue_lock.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3363d2476fed..2234ff2b2b8b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2166,16 +2166,20 @@ void bio_associate_blkg(struct bio *bio)
 	if (blk_op_is_passthrough(bio->bi_opf))
 		return;
 
-	rcu_read_lock();
-
-	if (bio->bi_blkg)
+	if (bio->bi_blkg) {
 		css = bio_blkcg_css(bio);
-	else
+		bio_associate_blkg_from_css(bio, css);
+	} else {
+		rcu_read_lock();
 		css = blkcg_css();
+		if (!css_tryget_online(css))
+			css = NULL;
+		rcu_read_unlock();
 
-	bio_associate_blkg_from_css(bio, css);
-
-	rcu_read_unlock();
+		bio_associate_blkg_from_css(bio, css);
+		if (css)
+			css_put(css);
+	}
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg);
 
-- 
2.51.0


