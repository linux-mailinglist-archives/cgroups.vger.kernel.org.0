Return-Path: <cgroups+bounces-7257-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F024A75CCD
	for <lists+cgroups@lfdr.de>; Sun, 30 Mar 2025 23:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720303A7E5E
	for <lists+cgroups@lfdr.de>; Sun, 30 Mar 2025 21:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A11DF25A;
	Sun, 30 Mar 2025 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWg3X+ns"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92411DEFC6
	for <cgroups@vger.kernel.org>; Sun, 30 Mar 2025 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371631; cv=none; b=bkik7JXEythvA5ZPGj5WSU0tGoigal+Vjxr6no+puhGTY97898vsT8Ul2pnE82O21DEFDYBZ03OYfipelNp+PsHKqJYDC/SIVpUkAVjWNvZ5vULTa7xtAIHoCg8D7p9BmitjQkCMPTlbe61cEl4nxTez2wBnDJOBrQl4OuSLBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371631; c=relaxed/simple;
	bh=SZdMgUXbNzWIrkGHQT1Y5GbxGU727DTli16VagtZmMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=korfom+DGMkk7+r31c9QLD++2t/47TrRRNlVbZAvFK4Kj8BwhnyT/z9PA2RUJdkc7c8V1vsGpjqAqU4SwIofxtwyLLcD6mrCLWH9o0QPyLojJ71GSKUG3ZTy0B/7L7iGPw4ZfrCsQomNXVWc9Cum/AsAM1+19np81hzUQC55uZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWg3X+ns; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QWxjGxcyTTj0xgoyyQ7hbINmphGtnz7f5bPVPSEtkro=;
	b=HWg3X+nsiqRJj39YcQP+s7AGN/bi1vjGTWcJW+dVnjHZkpfkeflnYz08S1VVUFGj259f7+
	gMo680uzJm/AsXq4tOkMuLAMVe76/ZRAMDbYtoGwVgF2Adz2kAeu2Y7aFDAw7ZEjqzpjS/
	lRp8D/XGG+A4sy7dpNiq4hjLuzHWvkQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-zXGxUkmlMmqFTaLBpVs1Lg-1; Sun,
 30 Mar 2025 17:53:42 -0400
X-MC-Unique: zXGxUkmlMmqFTaLBpVs1Lg-1
X-Mimecast-MFC-AGG-ID: zXGxUkmlMmqFTaLBpVs1Lg_1743371621
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC2811945103;
	Sun, 30 Mar 2025 21:53:40 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B5BC41801747;
	Sun, 30 Mar 2025 21:53:38 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 00/10] cgroup/cpuset: Miscellaneous partition bug fixes and enhancements
Date: Sun, 30 Mar 2025 17:52:38 -0400
Message-ID: <20250330215248.3620801-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This patch series fixes a number of bugs in the cpuset partition code as
well as improvement in remote partition handling. The test_cpuset_prs.sh
is also enhanced to allow more vigorous remote partition testing.

Waiman Long (10):
  cgroup/cpuset: Fix race between newly created partition and dying one
  cgroup/cpuset: Fix incorrect isolated_cpus update in
    update_parent_effective_cpumask()
  cgroup/cpuset: Fix error handling in remote_partition_disable()
  cgroup/cpuset: Remove remote_partition_check() & make
    update_cpumasks_hier() handle remote partition
  cgroup/cpuset: Don't allow creation of local partition over a remote
    one
  cgroup/cpuset: Code cleanup and comment update
  cgroup/cpuset: Remove unneeded goto in sched_partition_write() and
    rename it
  selftest/cgroup: Update test_cpuset_prs.sh to use | as effective CPUs
    and state separator
  selftest/cgroup: Clean up and restructure test_cpuset_prs.sh
  selftest/cgroup: Add a remote partition transition test to
    test_cpuset_prs.sh

 include/linux/cgroup-defs.h                   |   1 +
 include/linux/cgroup.h                        |   2 +-
 kernel/cgroup/cgroup.c                        |   6 +
 kernel/cgroup/cpuset-internal.h               |   1 +
 kernel/cgroup/cpuset.c                        | 401 +++++++-----
 .../selftests/cgroup/test_cpuset_prs.sh       | 617 ++++++++++++------
 6 files changed, 649 insertions(+), 379 deletions(-)

-- 
2.48.1


