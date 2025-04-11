Return-Path: <cgroups+bounces-7474-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D2BA864E5
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 19:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B713D19E0BE1
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 17:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F44239567;
	Fri, 11 Apr 2025 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kg0ZYt4E"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C65E238D3A
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393141; cv=none; b=WqnUVNxGzxaz0Akkw81zOXdz4YuqFrjc4mq1YKnzbL8CxeWbedVoFUYqBm3Es8J1Iw0QYmz5a3qXdgP/HXicrHKniwqe/a1XHKztpUr0NqYCg0hAJzRO5cLqkVnPWEDN/huH0dCNzUwxO7aXTA8ZIATLwtxe7xuWAGQZe4IYhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393141; c=relaxed/simple;
	bh=GOlVp08bXmKVBx3YUV1fH6I+z4IKqeEdBOELTybEv9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkQnkFhWV3pdiKRLlR3dYPKa0sERLBHc4u/KOp3xeiFNW0ju6yjd2LUJKpjYn9XCtDxceWb1ILR3hMMRSOsIaY4klzZGncvuoIWakpUlc6OpEIubju7VjkOmjZumCc5OoLLEDb0oXdJGTZ1UQcvP4VusQEtjppWdVQb0DhXpYew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kg0ZYt4E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744393139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wj9g/MvqOqnG1Im7Sfez5hSiWdX4peMgJU0W+a1b3DU=;
	b=Kg0ZYt4E+eAupazZqE3WqJ+Cc30yqfn4W8nOPnOEPA2qS7U5mrlJveRXEM1U5ybTTxb/2X
	S44trz46FuFKdahYX4LwrQz/m7YODPnNd9roTnPBSi49ttcmPvijG2A3rNzLAXwAm3sl18
	FpIOV218vKJpcmHvwt9cSaNF4q5MZEY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-hkI7LEvWPs2E3MsmacqIKQ-1; Fri,
 11 Apr 2025 13:38:55 -0400
X-MC-Unique: hkI7LEvWPs2E3MsmacqIKQ-1
X-Mimecast-MFC-AGG-ID: hkI7LEvWPs2E3MsmacqIKQ_1744393134
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50F6119560AB;
	Fri, 11 Apr 2025 17:38:54 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.37])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59BDE1956094;
	Fri, 11 Apr 2025 17:38:50 +0000 (UTC)
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
Subject: [PATCH v2 0/2] Fix false warning in inode_to_wb
Date: Fri, 11 Apr 2025 19:38:45 +0200
Message-ID: <20250411173848.3755912-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Changes in v2:

- In inode_to_wb(), only check if the SB_I_CGROUPWB flag is set so that
  the consistency checks remain active even when cgroup writeback isn't
  actively used.

- Improve the description of "gfs2: replace sd_aspace with sd_inode".

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
 fs/gfs2/ops_fstype.c        | 31 ++++++++++++++++++-------------
 fs/gfs2/super.c             |  2 +-
 include/linux/backing-dev.h |  3 ++-
 8 files changed, 34 insertions(+), 24 deletions(-)

-- 
2.48.1


