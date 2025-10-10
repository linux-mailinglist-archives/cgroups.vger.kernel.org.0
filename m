Return-Path: <cgroups+bounces-10646-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7299BCC49B
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82C053412D4
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A1A2749D9;
	Fri, 10 Oct 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5SV/D+Q"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA9217723;
	Fri, 10 Oct 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087741; cv=none; b=pSZIwQa/8UAhR9q6xqUvINVke6iolw2OYZU/KRKTDIhEeIJXhaHCxfCdLMW7Wqmd9kIrsU2+XjagvXU8JvsTRg5loIX/3u1i9DXEH20hK4D8PpHUc3cZu1YTvwfDekKUCvRujLkKZrTm1aBiC+q77hXxMdy1YfwWNRRlC3UUy/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087741; c=relaxed/simple;
	bh=R9L4Dfzvxc48pIpRSH2GwrKBjgbQXWcbaCisT1DQcVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCplrfp6APU0Udo1faeqG5M7T2gQoJGtJ8fzzz4fs8Qwwd4PAyXVKsrOKb7LgWPPlKYyi2Jd+/KgB6Pu5G7qSQnti2OW9ivbpeEQGq8wlx8NFs1zi+IU6mLmlM6hvueRF862QptNvlUycnlJrxg6XXc71TIQm00PkY/wxt6DpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5SV/D+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6B8C4CEF8;
	Fri, 10 Oct 2025 09:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087741;
	bh=R9L4Dfzvxc48pIpRSH2GwrKBjgbQXWcbaCisT1DQcVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5SV/D+QlEUmh3ZuhCIqcng4zG0GCCkFGbiEg8ie+ryPtdnPNLIkW+8KBUnNUZCii
	 RkFgDTjJ9lPxsaXWv7U0WEUoK5IsxwSQiWMGC+uL0grK92MGaYSwv7gpcr1U55JrSf
	 h3GiT1Z+sPds8cBCcb2SaAFgpZ1wZCKUz8F9TR+S7i9F4rLIEwJy04GO6s12SQC/lU
	 wAXzOo0wPxINFL7paX3e4zfUwz/QyoAh3iqcvSWSp/FE3SPbNUIS+CYUpnWlRkRODi
	 mmfqIr5qRJAIfZ9gfSjmUP+tVzoQNJkNv94sxr9UEpwld2hz0JKaKNymBVyutwL9DB
	 UjthDQnAtZtuw==
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
Subject: [PATCH v2 17/19] blk-iolatency: convert to use blkg_conf_{start, end}
Date: Fri, 10 Oct 2025 17:14:42 +0800
Message-ID: <20251010091446.3048529-18-yukuai@kernel.org>
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

No functional changes are intended, make code cleaner.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iolatency.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index ce25fbb8aaf6..1199447a2a33 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -768,7 +768,7 @@ static int blk_iolatency_init(struct gendisk *disk)
 			 &blkcg_iolatency_ops);
 	if (ret)
 		goto err_free;
-	ret = blkcg_activate_policy(disk, &blkcg_policy_iolatency);
+	ret = __blkcg_activate_policy(disk, &blkcg_policy_iolatency);
 	if (ret)
 		goto err_qos_del;
 
@@ -837,10 +837,9 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 	int ret;
 
 	blkg_conf_init(&ctx, buf);
-
-	ret = blkg_conf_open_bdev(&ctx);
+	ret = blkg_conf_start(blkcg, &ctx);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
@@ -852,10 +851,6 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 	if (ret)
 		goto out;
 
-	ret = blkg_conf_prep(blkcg, &blkcg_policy_iolatency, &ctx);
-	if (ret)
-		goto out;
-
 	iolat = blkg_to_lat(ctx.blkg);
 	p = ctx.body;
 
@@ -890,7 +885,7 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 		iolatency_clear_scaling(blkg);
 	ret = 0;
 out:
-	blkg_conf_exit(&ctx);
+	blkg_conf_end(&ctx);
 	return ret ?: nbytes;
 }
 
-- 
2.51.0


