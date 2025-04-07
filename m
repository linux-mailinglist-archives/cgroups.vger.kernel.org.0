Return-Path: <cgroups+bounces-7395-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAE4A7EBD0
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 21:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCF1442001
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 18:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A325A2C4;
	Mon,  7 Apr 2025 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSgNTSwr"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30F259CAE
	for <cgroups@vger.kernel.org>; Mon,  7 Apr 2025 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050084; cv=none; b=CSRfPxYr9J+a+H2UW5fdziz/9dnOv7qTqttuqH8YwQP5d8Iqzq1cJNQg23e4anlAq4dirP/M5i9wIgWI9uWf8zgrWM2FUu1s+lIuwYi7dt4MvJOPXk/CIRcrw4Jd5l/9C2GHZVD0rt5nT89sEY8nYTYXrWGwJ2P3Bq7MynBw2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050084; c=relaxed/simple;
	bh=Yluw6WEdhGYL8V1hArIY4tYFnH2BozQJcMhs9lMKG6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhYA4mGl/5HHLROyb4/Up5buTV3MxGXyIZvqtMAA7qcZ7kdn8y8IL8PKr3oggBBCUJh7RVOtBiS8oKQhQrRs1wp5TwjGBnCFCl29TI/rZDQP6BRPiQvOTtyixAdgXXGmC+UGBU3X04sbeCtfnwm1K2cRMuPfyVNp92Cir+Ytz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSgNTSwr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744050080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q8XINgkR0EpGHnvrRPK+wYqXQDcUTHVKWdQf0hfOUpA=;
	b=XSgNTSwrpJzUYjzZrLoItwqc3v3VCKbxT4J5As0AogTSiKcsPx1i7dnlBNVxSbNtFWRNpC
	jupdYD2ck0qz0VkXK0tW2xyNfJ/8m3FmMoBxIkwi03PtCg1esTau8l9VWe9Fh1FgUxujOc
	d+D1NNA/KQqx+nRBiAeFGjIPIGxGaow=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-hgifSGuqOx2mCksrpurQvA-1; Mon,
 07 Apr 2025 14:21:11 -0400
X-MC-Unique: hgifSGuqOx2mCksrpurQvA-1
X-Mimecast-MFC-AGG-ID: hgifSGuqOx2mCksrpurQvA_1744050069
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 070CC195608A;
	Mon,  7 Apr 2025 18:21:09 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 919361828AB9;
	Mon,  7 Apr 2025 18:21:05 +0000 (UTC)
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
Subject: [RFC 0/2] Fix false warning in inode_to_wb
Date: Mon,  7 Apr 2025 20:21:00 +0200
Message-ID: <20250407182104.716631-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello,

when CONFIG_LOCKDEP is enabled, gfs2 triggers the following warning in
inode_to_wb() (include/linux/backing-dev.h) for a number of
filesystem-internal inodes:

  static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
  {
  #ifdef CONFIG_LOCKDEP
          WARN_ON_ONCE(debug_locks &&
                       (!lockdep_is_held(&inode->i_lock) &&
                        !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
                        !lockdep_is_held(&inode->i_wb->list_lock)));
  #endif
          return inode->i_wb;
  }

This unfortunately makes lockdep unusable for gfs2.

In the most recent bug report about that problem [1], Jan Kara dug into
this and he concluded that when cgroup writeback is disabled, inode->i_wb
should be stable without any additional locking and the warnings are not
justified.  So can we please add an inode_cgwb_enabled() check to
inode_to_wb() as in Jan's patch in this series?


With that, a minor problem remains at the filesystem level:

Cgroup writeback is only enabled on filesystems that enable the
SB_I_CGROUPWB super block flag.  Unfortunately, gfs2 creates a separate
address space for filesystem metadata (sd_aspace) and sets its
mapping->host to sb->s_bdev->bd_mapping->host.  That's a "bdev" inode
with a super block that has SB_I_CGROUPWB set.  I'm not aware of any
other filesystems doing that.

To fix that, the first patch in this series creates an anonymous inode
instead of an isolated address space.  In that inode, ->i_mapping->host
points back at the inode and ->i_sb points at a gfs2 super block which
and doesn't have SB_I_CGROUPWB set.


And then there is another peculiarity of gfs2: while an 'ordinary' inode
has one address space for managing the inode's page cache, a gfs2 inode
also has a second address space for managing the inode's metadata cache.
These address spaces also point at sb->s_bdev->bd_mapping->host, causing
the same problem as above.  To fix that, the first patch changes ->host
of those address spaces to point at the new anonymous inode as well.

Using address spaces in this particular way seems to be pretty unusual
and there's a real risk that it will break some day, but I haven't found
a reasonable alternative so far.


Two previous discussions about this bug can be found here:

  [1] https://lore.kernel.org/gfs2/ebfe4024-f908-458d-9979-6ff2931c460d@I-love.SAKURA.ne.jp/
  [2] https://lore.kernel.org/all/20210713180958.66995-11-rpeterso@redhat.com/


Thanks,
Andreas


Andreas Gruenbacher (1):
  gfs2: replace sd_aspace with sd_inode

Jan Kara (1):
  writeback: Fix false warning in inode_to_wb()

 fs/gfs2/glock.c             |  3 +--
 fs/gfs2/glops.c             |  4 ++--
 fs/gfs2/incore.h            |  9 ++++++++-
 fs/gfs2/meta_io.c           |  2 +-
 fs/gfs2/meta_io.h           |  4 +---
 fs/gfs2/ops_fstype.c        | 24 +++++++++++++-----------
 fs/gfs2/super.c             |  2 +-
 include/linux/backing-dev.h |  3 ++-
 8 files changed, 29 insertions(+), 22 deletions(-)

-- 
2.48.1


