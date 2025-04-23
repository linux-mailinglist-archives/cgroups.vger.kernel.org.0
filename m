Return-Path: <cgroups+bounces-7744-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE022A97E2A
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 07:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D2A179D0A
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 05:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6216266595;
	Wed, 23 Apr 2025 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CkZbW2Ys"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8862580CB;
	Wed, 23 Apr 2025 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745386708; cv=none; b=SUKg4YDZVTyM/LPqc2CXSYvCKa244dodzWK4KUnqE5Yg4bUBVsgI+pzkUUJa9TefAfij8ceGDxDhlyUXsRQA2afyBnfsSfb0Wqh04v11z9UuYdfKsyA4LNt+hfr+CnWzGT4VnHY56kN96sqO33Bmpfde4A5BSO44T2xPTuX8MGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745386708; c=relaxed/simple;
	bh=fDtBlgA/FZi/YVL3NuJ2ilVaq+ts+hMqW16Sff2Gq7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfkG8PZKim7OxFLgz2gRpaJVs5ollW7sDs1IP9eLrMsQ27kSqjksYJawHRCo7JsG+f7mhOVb8WkW2kZs3su/vH0cVdXRj7RZObIK5ZKfzdAgf3phoDgdpsNeq5shqK2amawR6eb2z6AHbQJ4gk9lQvZs+YPHILNHn/etGZLC1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CkZbW2Ys; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=o3mNDRSEKX+lnt1RCcpvVk1rjl+X0sHf+WAvmf/tSz4=; b=CkZbW2YsqdgNqQVAT4KKLdQ5Xd
	blBsfjMvPGdgvFTur8cWsJnWl59UsbFOOGkzc/ZM6IbnRgOhhCZhgevEPN4Xo+KID668EU7BsPtpf
	75zcU3ALR1vLRayWlIOtxJo7eww3CxDyymFCPjyb7KPgwsU3Yk9d1aASjuBmwFWWj/XBQS0riNQEO
	ivrG31/d/GDaKuAeGj01dW/wGiMdGcDOdWeOuwedqBAEQtQN++Nz7TuXtDoUFVTLaJC8H7AWMSUhk
	7WIEsdjejW5TMuLNH2NQ2/mViKcFlO0BiIqxIxXIUc8x4SjU9Fd3WeSOk1At2eca95qzFVxnYGA1E
	wMhmDl9A==;
Received: from 2a02-8389-2341-5b80-c0c9-6b8d-e783-b2cd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c0c9:6b8d:e783:b2cd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7SoT-00000009FmB-3uSA;
	Wed, 23 Apr 2025 05:38:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <christian@brauner.io>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH 4/4] block: don't autoload drivers on blk-cgroup configuration
Date: Wed, 23 Apr 2025 07:37:42 +0200
Message-ID: <20250423053810.1683309-5-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250423053810.1683309-1-hch@lst.de>
References: <20250423053810.1683309-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Loading a driver just to configure blk-cgroup doesn't make sense, as that
assumes and already existing device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e172aeda4183..ce93706555c5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -797,7 +797,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 		return -EINVAL;
 	input = skip_spaces(input);
 
-	bdev = blkdev_get_no_open(MKDEV(major, minor), true);
+	bdev = blkdev_get_no_open(MKDEV(major, minor), false);
 	if (!bdev)
 		return -ENODEV;
 	if (bdev_is_partition(bdev)) {
-- 
2.47.2


