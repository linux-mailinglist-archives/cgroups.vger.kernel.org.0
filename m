Return-Path: <cgroups+bounces-10645-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16352BCC50F
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85B7541991
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D71627F010;
	Fri, 10 Oct 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkNz+mrA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CDE26F2BC;
	Fri, 10 Oct 2025 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087738; cv=none; b=k8yWxGZY5YpcUhkbMMxqARec31LMiXXfa6kyVGgE2kLCFpkdwICTH5sAMWXP1Z5d2N0v2lP9ss4dsnbPPg25nm085Gkq8jKoyb9M/VVWcZbWRNGfXhYXBFdDyX0g2EvOnFoRSa92AkFKvauFJq4VOQYEOF427YqXUJJ3HIH53f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087738; c=relaxed/simple;
	bh=HR7CFnUsZ2dNXHDx2BPlySPGR24lHcrJ1SInaPl9BH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXXmJ0V35vbEa3qi9JAT1Uay9lTF1XsbEeLpMAZNldcrw9sToneeT3ZqKxm2IcssUNF44Oj8wkviiFjarX9v/K8Hvcik155J7sWA60g+mlY7CPWlOw2b69JwQSLN8b0y9fhQOq+q9Dv42LeOkYs329NWD1bjy5ki8Mh/ETt/haA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkNz+mrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24A7C4CEF1;
	Fri, 10 Oct 2025 09:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087738;
	bh=HR7CFnUsZ2dNXHDx2BPlySPGR24lHcrJ1SInaPl9BH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkNz+mrAAi9cH4SSeTgDb7vJkYjB31dwvRo/5LEEpKKVYELUaqoV0XqETOKpR+398
	 I+KoU/GwV/EWgXvyZ0U/BghZ20pUTx3yTFl5UqyDRGmA42KF4dneW5Z1aHRKsRtx9x
	 HtxLDWjJY4JvF7Ifa8UQ2a5ww+LhM93BvSK5mRHLcSjag3X0p5TFRCb5qIyiKtCeX6
	 FLbtP3RBB0+s+utZHyNhxtvlE0caLkrXej442SCcaz1C9N9Tqwiuy/tR9YS01BEGtk
	 NcI6AJIVfZXuMoIRumdrqEgZbdv+BXgp1S2z3+XU+dEIeDWlVnWyofHuv8+X7oQ88/
	 4vYSyjp2nLVtw==
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
Subject: [PATCH v2 16/19] block, bfq: convert to use blkg_conf_{start, end}
Date: Fri, 10 Oct 2025 17:14:41 +0800
Message-ID: <20251010091446.3048529-17-yukuai@kernel.org>
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

Make code cleaner, we'll create new blkg and then return error
if bfq is not enabled for the device, this is fine because this
is super cold path.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 43790ae91b57..d39c7a5db35d 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1056,10 +1056,9 @@ static ssize_t bfq_io_set_device_weight(struct kernfs_open_file *of,
 	u64 v;
 
 	blkg_conf_init(&ctx, buf);
-
-	ret = blkg_conf_prep(blkcg, &blkcg_policy_bfq, &ctx);
+	ret = blkg_conf_start(blkcg, &ctx);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (sscanf(ctx.body, "%llu", &v) == 1) {
 		/* require "default" on dfl */
@@ -1074,6 +1073,10 @@ static ssize_t bfq_io_set_device_weight(struct kernfs_open_file *of,
 	}
 
 	bfqg = blkg_to_bfqg(ctx.blkg);
+	if (!bfqg) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
 
 	ret = -ERANGE;
 	if (!v || (v >= BFQ_MIN_WEIGHT && v <= BFQ_MAX_WEIGHT)) {
@@ -1081,7 +1084,7 @@ static ssize_t bfq_io_set_device_weight(struct kernfs_open_file *of,
 		ret = 0;
 	}
 out:
-	blkg_conf_exit(&ctx);
+	blkg_conf_end(&ctx);
 	return ret ?: nbytes;
 }
 
-- 
2.51.0


