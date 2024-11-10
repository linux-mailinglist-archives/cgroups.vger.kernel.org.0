Return-Path: <cgroups+bounces-5503-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3379C30A0
	for <lists+cgroups@lfdr.de>; Sun, 10 Nov 2024 03:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A6281E6E
	for <lists+cgroups@lfdr.de>; Sun, 10 Nov 2024 02:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646C13E02E;
	Sun, 10 Nov 2024 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6RAvUVe"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D98C43AA9
	for <cgroups@vger.kernel.org>; Sun, 10 Nov 2024 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731207068; cv=none; b=HDPD4bc7ENX4FGNdswqmSPdP3bSrzocNWraM1iKRjJtTKVeUPZr6ZL1FoQICyBFin7LODTEYenBMREItmjCJQSzcVAlm1PIYi6JJZNmpSgvEjd1qqfUDsXw3xEAsdH2bBuTtsNWo65oRGlcmF8UIPqDT5M632jrRdcuv+VGZRcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731207068; c=relaxed/simple;
	bh=xCHYEBLskj/H8UxrrsGFp0MCso8Nv2IDIIYyD/FAZQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+s9P5g8Am/Vb4ZzPki5D1RWaP1y4NaVSUY6vwTHMoA/Usb5xFZG9oUpHkeP5UB6oT/Cxnx7BKnADw/mSGXy6AspWouIPCLLzBJjXoMQ0Fjsx7HvIZCEEPq9F+CjVcSyKQ1SapTu5sfHUxIdbKWE+OULe6T3PwoNk1v3Zs54wfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6RAvUVe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731207064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cZkge2p7n+qtz9f3rQSaeHXWAmHbmzD/SPamdcAzZh4=;
	b=a6RAvUVeTIzU6VoDOyftt6vfchyjy9G2GLOAj7KGJXQQ0uzy2RuPc1U/yZfgf0/1uj9iRo
	2yceZ9VWxOE0kT2UlsbADr2Tvj3Krpuk8qp66DTAZsvRdi+kpeJ1MPV35/7cfUjHh6BOSm
	aKAdnSg4mqjnWImuozK5NU6/bj4CmXc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-Ya0NUqrdPpOlFVwe1wab0A-1; Sat,
 09 Nov 2024 21:51:03 -0500
X-MC-Unique: Ya0NUqrdPpOlFVwe1wab0A-1
X-Mimecast-MFC-AGG-ID: Ya0NUqrdPpOlFVwe1wab0A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 928671955F43;
	Sun, 10 Nov 2024 02:51:01 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69D2C300019E;
	Sun, 10 Nov 2024 02:50:59 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/3] cgroup/cpuset: Remove redundant rebuild_sched_domains_locked() calls
Date: Sat,  9 Nov 2024 21:50:20 -0500
Message-ID: <20241110025023.664487-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The main purpose of this series is to make sure that there will
be at most one rebuild_sched_domains_locked() call per cpuset
operation. Juri found that is still not the case. Make use of the
existing cpuset_force_rebuild() helper as a replacement for a direct
rebuild_sched_domains_locked() call and check force_sd_rebuild at the
operation end.

The last patch is for removing some unnecessary v1 specific code if
CONFIG_CPUSETS_V1 isn't set.

Waiman Long (3):
  cgroup/cpuset: Revert "Allow suppression of sched domain rebuild in
    update_cpumasks_hier()"
  cgroup/cpuset: Enforce at most one rebuild_sched_domains_locked() call
    per operation
  cgroup/cpuset: Further optimize code if CONFIG_CPUSETS_V1 not set

 kernel/cgroup/cpuset.c | 121 +++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 58 deletions(-)

-- 
2.47.0


