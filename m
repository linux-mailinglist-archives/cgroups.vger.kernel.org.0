Return-Path: <cgroups+bounces-10629-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F624BCC436
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A05406D9D
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4492638AF;
	Fri, 10 Oct 2025 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNAvdHiC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4845217723;
	Fri, 10 Oct 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087692; cv=none; b=OdiMYlOKz8XTor5+0zqqkE2Q36OwNKZD/TgAnU9lVv9oGWhT7B1FCAvi/234d5q0McTt8gFqJfSjxvFSkFeG/2jVqZriRSiTetOvb5AjyQ9Ob9SVWfThKaQbXXYyBDmi+u4g0WvZ2sgo/JlIrZ1tI8bL0P5ZtgtsRD/0byBGlfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087692; c=relaxed/simple;
	bh=vtIRyjcCc6LcebOFxaTxHL4wziQNV8zAxg2EbWDPBRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqq2AxsfFXieiJ7XXrcaVrtjwoEoS2k3Lh0ERvqn/xWiL84TgkVDd6v2FWree1Jk8GTnDygOT5ZObcn3Z1SHhStAFjofU2nh4E2RTk2A82ZCt1u0j03t7tADNSg8SPFrjia4EJRuhK8ZOJAut9OZSkOsPVJLtO3htP459BAhhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNAvdHiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1302C4CEF1;
	Fri, 10 Oct 2025 09:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087692;
	bh=vtIRyjcCc6LcebOFxaTxHL4wziQNV8zAxg2EbWDPBRA=;
	h=From:To:Cc:Subject:Date:From;
	b=SNAvdHiCggTSjzJEqcnrJ5ocnUMXSrYN7aKOTF1gzfeQD0Aw/uf9SomcdxK0r0mir
	 fJCp+rji+RsXmc4pyT+avYO+6TjVZ9ShW/vA5OdyXjQ+zAd9NVgLagM/TSEV1vpfmN
	 OPoXk9zz8b23YgY3UJeUoutkMPobo5A7q0BrvSUkt0b+GAqZTqSyIqcUbiqcV9Fr3E
	 85XCyNwIn4JIcUFFie2epDg8YXZPIa6GS82YJGPVna035eL7RCT7AFFT+I0k5L71vN
	 qroqrCpEvVZ4BHfBWBgxVj4xHIAhErYHRvKD8gIi7xawzVUCVo0afX6Da1kJsi8kKh
	 m9Zst7jfbEIvg==
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
Subject: [PATCH v2 00/19] blk-cgroup: convert to use blkcg_mutex for protection
Date: Fri, 10 Oct 2025 17:14:25 +0800
Message-ID: <20251010091446.3048529-1-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

Changes in v2:
 - add patch 2 to delay freeing policy data, otherwise patch 3 is not
   safe;
 - add patch 13-19 to cleanup blkcg configuration apis;

patch 1-8 is prep patches to make sure queue_lock is not nested under
rcu and other spinlocks in blk-cgroup;
patch 9 convert blk-cgroup to use blkcg_mutex to protect blkgs;
patch 10,11 are follow cleanups;
patch 12 fix deadlock in blk-throttle;
patch 13-19 cleanup blkcg configuration helpers;

Yu Kuai (19):
  blk-cgroup: protect iterating blkgs with blkcg->lock in
    blkcg_print_stat()
  blk-cgroup: delay freeing policy data after rcu grace period
  blk-cgroup: don't nest queue_lock under rcu in blkcg_print_blkgs()
  blk-cgroup: don't nest queue_lock under rcu in blkg_lookup_create()
  blk-cgroup: don't nest queu_lock under rcu in bio_associate_blkg()
  blk-cgroup: don't nest queue_lock under blkcg->lock in
    blkcg_destroy_blkgs()
  mm/page_io: don't nest queue_lock under rcu in
    bio_associate_blkg_from_page()
  block, bfq: don't grab queue_lock to initialize bfq
  blk-cgroup: convert to protect blkgs with blkcg_mutex
  blk-cgroup: remove radix_tree_preload()
  blk-cgroup: remove preallocate blkg for blkg_create()
  blk-throttle: fix possible deadlock due to queue_lock in timer
  blk-cgroup: add new blkg configuration helpers
  blk-cgroup: factor out a helper __blkg_activate_policy()
  blk-throttle: convert to use blkg_conf_{start, end}
  block, bfq: convert to use blkg_conf_{start, end}
  blk-iolatency: convert to use blkg_conf_{start, end}
  blk-iocost: convert to use blkg_conf_{start, end}
  blk-cgroup: remove unsed blkg configuration helpers

 block/bfq-cgroup.c        |  27 +-
 block/bfq-iosched.c       |  13 +-
 block/blk-cgroup-rwstat.c |   4 +-
 block/blk-cgroup.c        | 552 +++++++++++---------------------------
 block/blk-cgroup.h        |  51 +++-
 block/blk-iocost.c        |  61 +++--
 block/blk-iolatency.c     |  23 +-
 block/blk-throttle.c      |  73 +++--
 mm/page_io.c              |   7 +-
 9 files changed, 302 insertions(+), 509 deletions(-)

-- 
2.51.0


