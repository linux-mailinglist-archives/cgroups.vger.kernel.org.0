Return-Path: <cgroups+bounces-6093-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07411A0A13A
	for <lists+cgroups@lfdr.de>; Sat, 11 Jan 2025 07:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5559188BD99
	for <lists+cgroups@lfdr.de>; Sat, 11 Jan 2025 06:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC840156F3A;
	Sat, 11 Jan 2025 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TwYoa2fG"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE06129A78;
	Sat, 11 Jan 2025 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736576863; cv=none; b=CiEFgyV1avNhNqgOF+5Sg5KvHtv9Yt19sSyNw6dYH+PR2bp3AMACHFPeqV5VL+dxtkgn1Wpq8GNM1vWrY/f9Syts5wj8AJHn/zD6WrMdgJFjbDCSRgsKZTUXNPjp1m8odmLuiH3pLFRuu3tteuSYp3dUmPhBJ2F4vId6Nl5x71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736576863; c=relaxed/simple;
	bh=sY2rgjzVm2gPyKaIrUNRbeO6ismVJLrlddNs+GzQYSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSRFVd1MoSmFtg3Eg9L+Qq5mDgRN6RoCy7ja7HXgHXrTO1pnsaxxQZa+pFI9JI6UKD++qqA5Gpm8jG+rCLYoG22oxbZqlY8iPZDMoeJWfsYw0Az308qZGHUdbS8UhJltIxTTVjfMJCr2T8cTY7BbhurLyEvcHrz6jFbWcALFF30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TwYoa2fG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=u/IIvcBnkV57SLSk3JYcF+WO+sFRHt9IbN0Mu71SVWg=; b=TwYoa2fGJytfCgNq/IKMXVHGa0
	jIuElvp2vfSJPRCyM8OBfZn8YLSDaQdyr8J8E2HcuHL5a161idpL8tIMEN1ls/t2oQ8RGPv4ESf36
	4QVND0AmjDPvlE+fSi/45/MFONjOHOnIJ5VbAE6rmlhE96vUiKuMlJeYrh7T1JV0pni/ZM/1DuJL2
	vlJ9IE2Lv67xyFkHZ3emV8SY+14E8cuO3sG+r68QOfa2fWcBabYgS10CAoP0MwqDjXaYaUXIgwM4j
	7DEuKptXrIPbE3mW8WxtgyXvkt0jaAlevh4vRJLDL4ed+Q6r05xcd21yIg0d0/2tCeEMoJ035HmkP
	XE4BXeaA==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUyC-00000000H2a-2faP;
	Sat, 11 Jan 2025 06:27:40 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-block@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org
Subject: [PATCH] blk-cgroup: fix kernel-doc warnings in header file
Date: Fri, 10 Jan 2025 22:27:36 -0800
Message-ID: <20250111062736.910383-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the function parameters and function names to eliminate
kernel-doc warnings:

blk-cgroup.h:238: warning: Function parameter or struct member 'bio' not described in 'bio_issue_as_root_blkg'
blk-cgroup.h:248: warning: bad line: 
blk-cgroup.h:279: warning: expecting prototype for blkg_to_pdata(). Prototype was for blkg_to_pd() instead
blk-cgroup.h:296: warning: expecting prototype for pdata_to_blkg(). Prototype was for pd_to_blkg() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org
---
 block/blk-cgroup.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- linux-next-20250108.orig/block/blk-cgroup.h
+++ linux-next-20250108/block/blk-cgroup.h
@@ -225,7 +225,9 @@ void blkg_conf_exit(struct blkg_conf_ctx
 
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
- * @return: true if this bio needs to be submitted with the root blkg context.
+ * @bio: the target &bio
+ *
+ * Return: true if this bio needs to be submitted with the root blkg context.
  *
  * In order to avoid priority inversions we sometimes need to issue a bio as if
  * it were attached to the root blkg, and then backcharge to the actual owning
@@ -245,7 +247,7 @@ static inline bool bio_issue_as_root_blk
  * @q: request_queue of interest
  *
  * Lookup blkg for the @blkcg - @q pair.
-
+ *
  * Must be called in a RCU critical section.
  */
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
@@ -268,7 +270,7 @@ static inline struct blkcg_gq *blkg_look
 }
 
 /**
- * blkg_to_pdata - get policy private data
+ * blkg_to_pd - get policy private data
  * @blkg: blkg of interest
  * @pol: policy of interest
  *
@@ -287,7 +289,7 @@ static inline struct blkcg_policy_data *
 }
 
 /**
- * pdata_to_blkg - get blkg associated with policy private data
+ * pd_to_blkg - get blkg associated with policy private data
  * @pd: policy private data of interest
  *
  * @pd is policy private data.  Determine the blkg it's associated with.

