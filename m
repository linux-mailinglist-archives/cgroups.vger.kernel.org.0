Return-Path: <cgroups+bounces-7501-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF09CA86E29
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 18:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11776189AE9C
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D828720125F;
	Sat, 12 Apr 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FI7F8rwM"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255621FC7CB
	for <cgroups@vger.kernel.org>; Sat, 12 Apr 2025 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744475967; cv=none; b=bEIc6GbhZo2QPP6yks8vjfDpeHSb4/AyiJDi7M7SoySDZYPDuLizp3keGPtEdFm43/1B05MuOYKGKFdfYleSsprb1hoWRGF9EAeKKypN9RM1WxXL6S3pN4hiKTUz+rWw5EozKfAb4eg4s7oCjt47TgsMJCdAELxc9dkxsee9pko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744475967; c=relaxed/simple;
	bh=cAYjYmg/8ZZYOSl8b8gmXQEJDJBxhAHQZbq/FDisBkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXJ6UxOUKaWRGL3nMcawzt2giEH3yFLSvhsYEKzy659Ztmz0q++InmPX9QNa+cT4a2hotq/qB4ywkhatDMM+mzPCz0Nt8pfUS68N4R6jKBKLZD/p0+rwEILI3zMDytkGvxlhDz97Vzzm96MuukX2ZjGCo5V52CXReX0aAujvZug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FI7F8rwM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744475965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=thwrXWsigQIHOOK62OCYGRdqJW2zd1UKDeXMI+2fu5s=;
	b=FI7F8rwMD7akgabdpSJeW63C+jZ2sbNleXFeSihDv9G4qcfySAejG/MXHRbS8stC1cxHry
	l8WXYd3ekgjqCnxrZwpN1YO6xwTP9bfTvjUjmjVvfepzX5SdKfgtxcqhVz/SA42UT2pNB/
	6jswsGC+gZaavD4lv2XIBd/5TIunLH0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-dK-z1vZhO72GiNUCGCT7BA-1; Sat,
 12 Apr 2025 12:39:20 -0400
X-MC-Unique: dK-z1vZhO72GiNUCGCT7BA-1
X-Mimecast-MFC-AGG-ID: dK-z1vZhO72GiNUCGCT7BA_1744475959
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E88818007E1;
	Sat, 12 Apr 2025 16:39:19 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.37])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4139180174E;
	Sat, 12 Apr 2025 16:39:15 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: cgroups@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jan Kara <jack@suse.cz>,
	Rafael Aquini <aquini@redhat.com>,
	gfs2@lists.linux.dev,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Fix false warning in inode_to_wb
Date: Sat, 12 Apr 2025 18:39:10 +0200
Message-ID: <20250412163914.3773459-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Changes in v3:

- In gfs2_fill_super(), initialize sdp->sd_inode after initializing
  ->s_blocksize_bits so that ->i_blkbits will be set correctly.

- inode_to_wb(const struct inode *inode) no longer calls
  inode_cgwb_enabled(struct inode *inode), so its argument can remain
  const.

Changes in v2:

- In inode_to_wb(), only check if the SB_I_CGROUPWB flag is set so that
  the consistency checks remain active even when cgroup writeback isn't
  actively used.

- When new_inode() fails in gfs2_fill_super(), clean up correctly.

- Improve the description of "gfs2: replace sd_aspace with sd_inode".

Andreas Gruenbacher (1):
  gfs2: replace sd_aspace with sd_inode

Jan Kara (1):
  writeback: Fix false warning in inode_to_wb()

 fs/gfs2/glock.c             |  3 +--
 fs/gfs2/glops.c             |  4 ++--
 fs/gfs2/incore.h            |  9 ++++++++-
 fs/gfs2/meta_io.c           |  2 +-
 fs/gfs2/meta_io.h           |  4 +---
 fs/gfs2/ops_fstype.c        | 31 ++++++++++++++++++-------------
 fs/gfs2/super.c             |  2 +-
 include/linux/backing-dev.h |  1 +
 8 files changed, 33 insertions(+), 23 deletions(-)

-- 
2.48.1


