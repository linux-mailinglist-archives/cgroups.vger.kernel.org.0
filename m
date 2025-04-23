Return-Path: <cgroups+bounces-7740-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F541A97E23
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 07:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1B417A765
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 05:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96908265CCA;
	Wed, 23 Apr 2025 05:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MXGn9ZF+"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31AA2581;
	Wed, 23 Apr 2025 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745386697; cv=none; b=nkoIxwxSWW4/3Fa7OtyjUzxFLQyE7BeF5ea5LcJvIvAUxEXpnXDpgLFoLDBUfGQ8+wgVKnJnOx78Z2OkxS1yE20d5Wwj9MPjC1Qr8/lnj1G136CebQCHxvFrwHnMsALK6X/0cQFjgBxPs0s1YqSYBLm8ZvghofG+Zh8UYJUgyoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745386697; c=relaxed/simple;
	bh=3ZQJLDtbum9O3NBC5xy0L1tGp20uivvq/7Ie414DyU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/1gtelECiv2YHFTTZoHq+QFsdS3W4RFzQBfBJJubf0EVaDLfTyAzBKkKGytaJXp1NgGejG3Qiyk9Use7FwGC1T/QgnXNGkBFgRBjg1k6h4MOoq0OwYmjixO6wNphTari7h0cXtOY1zrOmmUvC2klyNafTbQRzzo9CqeGe/oGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MXGn9ZF+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IW9/oDnIXjpVtM5oSxACWrPIRV9xnJ97IsPB0qW4bhc=; b=MXGn9ZF+mzqM75+OIdcTVvyIbA
	2VSPK9t6vOBqqZRepet1IIxVdZ6zuV5CQHgJkN5yOh8UW9ayVZPdQJwRSILXtF/Gcn+FeNItZNKac
	npc317mMVg016zV6vLvEAQ64KfnGXNUtGySW9RJGRx0nha5c4G37OCfXJgH23P+KkFthrIe4gRHgI
	gBZ0CmwhSKSXivG7UdE28aym+0lwgcWYYJmbwSypGN1ku2nR856ta2Ak2zFwVLuhJ0dXjzIf1CXAX
	9i3L4glC+O3meHNFYah+txKmeCGmYjzX9BEYcY5N/PasFRYEDI+ixeuqxDnSUjTGb18jMfnLUYqXH
	NVhDzs7g==;
Received: from 2a02-8389-2341-5b80-c0c9-6b8d-e783-b2cd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c0c9:6b8d:e783:b2cd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7SoH-00000009FlH-1Ish;
	Wed, 23 Apr 2025 05:38:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <christian@brauner.io>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: don't autoload block drivers on stat (and cgroup configuration)
Date: Wed, 23 Apr 2025 07:37:38 +0200
Message-ID: <20250423053810.1683309-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

Christian pointed out that the addition of the block device lookup
from stat can cause the legacy driver autoload to trigger from a plain
stat, which is a bad idea.

This series fixes that and also stops autoloading from blk-cgroup
configuration, which isn't quite as bad but still silly.

Diffstat:
 block/bdev.c           |   17 +++++++----------
 block/blk-cgroup.c     |    2 +-
 block/blk.h            |    3 +++
 block/fops.c           |    2 +-
 include/linux/blkdev.h |    4 ----
 5 files changed, 12 insertions(+), 16 deletions(-)

