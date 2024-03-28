Return-Path: <cgroups+bounces-2220-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169588FA19
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 09:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EB51F25A21
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6CF53E04;
	Thu, 28 Mar 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FNO/h73+"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0951C3F;
	Thu, 28 Mar 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615316; cv=none; b=Hag8G+l+Te1kw7ls4JRg/gDvESbq4OE6zZxkF4EDYQGKFLBjv+m8ZFxMGw2yOXN6hjZZrC3XFFPKq84JMBeHAfgolBL+p0llPQAPl17MBx5Ol2mRjmIZqB0LXDUeHZNXXxS20lEei0JssyhvwycaKRUA7PXfb3ASu2oAN4tVTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615316; c=relaxed/simple;
	bh=bQ6sIDaWMZnS1ZxvvWFcBbL5BnIX1t941zeHWT/pefY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SzVLSDQFYcmRmfB1P0QReiDAbCqwwmaMSunKNJ/Lm7igJfbEuPxweCeN1ifBhfnqxo8QbSKqglBNuqRy9N3Fq4k2RaDPKufWQhRFHA6/UuV2OdssnMDJ8rkSMh/Dh1bYYD+yq62P1KdzvqTNTrn1QrO54fnPjcZ0w6AztOH108g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FNO/h73+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=uqofCw0wgdNvDhJdTyh0peuy864HLYBQRj9COQ6fL8I=; b=FNO/h73+2XhZZpmv5mEMkXsUwE
	dgf6fdSz3xofIvGEfsT1qOxGsW3DNCh4PJqtKLM60WAJO64V0mIoG0XhrfzQtsGpoCz4PrMpS0ikD
	jg7LWbK3kM0MaYIEl2uaNYQw3I+YPFHbFLSFnlevQVZLG9rpYDE9gozFOwGZffARFB0+dq0kQeSq9
	9peS9FYveEKjHNCkAW0BrMNQ8jHd7ojP52hzRVGOCXWUVv6ZVrV0Idxs+O6GUHxsXKvhQDgevHqMN
	Kj6gCkPoN3o01PHVol2uprTvub0ZB3DPonn/ZQgnDaaNid6lRBvH3HS+9fsAoq9CptQriunJMDHKw
	Eh69Hjrg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplKY-0000000D7YK-3FKD;
	Thu, 28 Mar 2024 08:41:51 +0000
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
Subject: add a bio_list_merge_init helper
Date: Thu, 28 Mar 2024 09:41:43 +0100
Message-Id: <20240328084147.2954434-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

the bio_list API is missing a helper that reinitializes the list
spliced onto another one.  Add one to simplify the code similar
to what the normal list.h can do.

Diffstat:
 block/blk-cgroup.c            |    3 +--
 drivers/md/dm-bio-prison-v2.c |    3 +--
 drivers/md/dm-cache-target.c  |   12 ++++--------
 drivers/md/dm-clone-target.c  |   14 +++++---------
 drivers/md/dm-era-target.c    |    3 +--
 drivers/md/dm-mpath.c         |    3 +--
 drivers/md/dm-thin.c          |   12 +++---------
 drivers/md/dm-vdo/data-vio.c  |    3 +--
 drivers/md/dm-vdo/flush.c     |    3 +--
 fs/btrfs/raid56.c             |    3 +--
 include/linux/bio.h           |    7 +++++++
 11 files changed, 26 insertions(+), 40 deletions(-)

