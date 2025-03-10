Return-Path: <cgroups+bounces-6916-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177D0A58F50
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91933AB2B1
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C9C2236EE;
	Mon, 10 Mar 2025 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyDD46fb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E20537F8
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598462; cv=none; b=UuyaGDsjy0OsctSPtrzv1NhS4cbMFoxKulfjDad4ZarDLQ+cgmh3FEdlx6jMipNiI0i0ime7W/RmEs85pTScyXLACGih8qpP4qiJ+BmMEwsQj91e4cwfs5IeqZKiDIJVmiXxMuR+qdIRn5NT1Fq601A/8krez5+zc5bmpRzAN5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598462; c=relaxed/simple;
	bh=X2P8BmFaIfr6ljYnPxqVzE0dAYgml35bG8jKsbvO9OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEocJBeh1xcyOPobwtDnaXeyuylKqAIOh/cXxu8uIV+OtpY8LdC0HNFo9rPX8TC+j+cCaWzF78Z4cT+s5r9coCoihs0oSFgQn0k905gFkx2K9eMH9fqwbMP0OrwOa37XHYS8sWaGmF0SuIk3yQlfmK0Z4Q6hLapx2CnV1Z9eW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyDD46fb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741598459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LgP9YNR9e/J52BmiorQfd082BVFSTbBL5ZmjdHK0AhI=;
	b=HyDD46fbXH8FnRuYzvTZ6bc8tfdjZ6YTwQbPqBucaPXXsz8iXgMWLhUVitWPSRFoVF6tq9
	Y2ctVqDbk+6kG8DcFjpfrFxqZS8UgwvvZL4474Uvna8mTZW+nuIdClmKR0avb4rFvb/OK0
	ndv18Jeqj++PLrXBrMiOjeAoOOHjN28=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-qyfXw83zNCaLdaaYrvO3VA-1; Mon, 10 Mar 2025 05:20:58 -0400
X-MC-Unique: qyfXw83zNCaLdaaYrvO3VA-1
X-Mimecast-MFC-AGG-ID: qyfXw83zNCaLdaaYrvO3VA_1741598457
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912b54611dso2411637f8f.1
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 02:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598455; x=1742203255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgP9YNR9e/J52BmiorQfd082BVFSTbBL5ZmjdHK0AhI=;
        b=I8SBxZibm75V8GWuicJxO7DQNVwKZjUnc0zpWLBMBODKyLxAr0ex7Y+mBPH/7vrj+E
         rADKETWF8tM0XCutv+n1HNs1OVclLWl2qdNuqHwvKrqtTM/mLhpPhW5zzfFcbUoBM+y/
         VKfFz5Z5a1Nlno4Jt8nMKmQnogMQxDyqZjPax8RNwM1WPzy61CLw+BwbqIXL6eyYYLea
         6ShCsMv0bU7xU0C3mqUrtICfQ/fHonF6D/Ax6zPwiqI/B7tWyYg6R9zR/CToR2xkNFpw
         l7kefEnoNLgRe+pVCwhcDteJ4OJ0n4bM9jPI94BMCsPw0SmJ6L8ac5MbkJxqsrAYStaZ
         Ki1w==
X-Forwarded-Encrypted: i=1; AJvYcCXalWSOm5zGU42XQ/268Gn1pr65B957KVTmbZM1fN2X5JLhW3IJjmQFCRFmSm/K3aoVeELr5M1x@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6hCAK++UGRAkflKOOWnYL5Yc2R/a7o2jX8YnFSM85OwF1aag
	W9lHQRT50mmiRcG45nXmlaHNOWNE3cQMbQ3d85A9SczvQEZbmCPgt271V6P6qkTFKXpPTJfLskT
	owvNIyoiCJzoDYt4+LSW5lVYXEL6kkjK8GofI7WNsiL3mg2t15rLNNZg=
X-Gm-Gg: ASbGncuq27naCBCCzX+sjHVm3QCjh8t5mjw97NrPwD0D6MhlPA/lGhkyaJxwIC35EYx
	moFWawesPcxrR61GUafDWPfkArI5tIIz8ReHDWRrjx5Zblo6xiUNizb0cYlPnSH4xZ8L2XQkPae
	iMGS6V3z2211O9tdke4CyaAP8EA1209be06KMLnhICAPDciLfDiB5loVuDFPMk3GA4jSDRcnSjb
	UrDvTzsMEqXKNo+yhNwqeUt7Ezh8nWYscWvUfYjCW0PZSeRq7Ir1IiYlL3BO0vI8H27IX1glbRI
	xp+7tCDg+HgpANmgDZzCO80YU39+81WkwOg34Sc1dQ0=
X-Received: by 2002:a5d:59ae:0:b0:391:3cb0:3d8d with SMTP id ffacd0b85a97d-3913cb045f0mr3096414f8f.19.1741598454938;
        Mon, 10 Mar 2025 02:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG77GRbumECCswGopxMwYWJkr98+oUnHKkACcHSO3X9YysXmuX/ZXJS9Id41zSkwFxD762oBw==
X-Received: by 2002:a5d:59ae:0:b0:391:3cb0:3d8d with SMTP id ffacd0b85a97d-3913cb045f0mr3096405f8f.19.1741598454605;
        Mon, 10 Mar 2025 02:20:54 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce715731csm78442415e9.2.2025.03.10.02.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:20:53 -0700 (PDT)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v3 0/8] Fix SCHED_DEADLINE bandwidth accounting during suspend
Date: Mon, 10 Mar 2025 10:20:42 +0100
Message-ID: <20250310092050.23052-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

Jon reported [1] a suspend regression on a Tegra board configured to
boot with isolcpus and bisected it to commit 53916d5fd3c0
("sched/deadline: Check bandwidth overflow earlier for hotplug").

Root cause analysis pointed out that we are currently failing to
correctly clear and restore bandwidth accounting on root domains after
changes that initiate from partition_sched_domains(), as it is the case
for suspend operations on that board.

This is v3 [2] of the proposed approach to fix the issue. With respect
to v2, the following implements the approach by:

- 01: filter out DEADLINE special tasks
- 02: preparatory wrappers to be able to grab sched_domains_mutex on
      UP (added !SMP wrappers back as sched_rt_handler() needs them)
- 03: generalize unique visiting of root domains so that we can
      re-use the mechanism elsewhere
- 04: the bulk of the approach, clean and rebuild after changes
- 05: clean up a now redundant call
- 06: remove partition_and_rebuild_sched_domains()
- 07: stop exposing partition_sched_domains_locked

I kept Jon and Waiman's Tested-by tags from v2 as there are no
functional changes in v3.

Please test and review. The set is also available at

git@github.com:jlelli/linux.git upstream/deadline/domains-suspend

Best,
Juri

1 - https://lore.kernel.org/lkml/ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com/
2 - v1 https://lore.kernel.org/lkml/20250304084045.62554-1-juri.lelli@redhat.com
    v2 https://lore.kernel.org/lkml/20250306141016.268313-1-juri.lelli@redhat.com/

Juri Lelli (8):
  sched/deadline: Ignore special tasks when rebuilding domains
  sched/topology: Wrappers for sched_domains_mutex
  sched/deadline: Generalize unique visiting of root domains
  sched/deadline: Rebuild root domain accounting after every update
  sched/topology: Remove redundant dl_clear_root_domain call
  cgroup/cpuset: Remove partition_and_rebuild_sched_domains
  sched/topology: Stop exposing partition_sched_domains_locked
  include/{topology,cpuset}: Move dl_rebuild_rd_accounting to cpuset.h

 include/linux/cpuset.h         |  5 +++++
 include/linux/sched.h          |  5 +++++
 include/linux/sched/deadline.h |  4 ++++
 include/linux/sched/topology.h | 10 ---------
 kernel/cgroup/cpuset.c         | 27 +++++++++----------------
 kernel/sched/core.c            |  4 ++--
 kernel/sched/deadline.c        | 37 ++++++++++++++++++++--------------
 kernel/sched/debug.c           |  8 ++++----
 kernel/sched/rt.c              |  2 ++
 kernel/sched/sched.h           |  2 +-
 kernel/sched/topology.c        | 32 +++++++++++++----------------
 11 files changed, 69 insertions(+), 67 deletions(-)


base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
-- 
2.48.1


