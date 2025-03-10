Return-Path: <cgroups+bounces-6915-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A526BA58F48
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621AA3AB2D2
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEFC2248BB;
	Mon, 10 Mar 2025 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9PW3tVJ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24601170826
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598389; cv=none; b=tL+0uAkbEqUzBeJQFDJX0sgcyP/6Meg9JDauLSRmDaEUyoada/OZTYRs1endQ2vznav5e3AODWhIDeE3+BuXvBjcytPBPGkl15htqNtoZ96xzJ0K2t4Om2MUhAOlMVFvy8dyIvJitXJaxQ38Cn3ldREX/OeCI/dAeFW+xdoIkO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598389; c=relaxed/simple;
	bh=X2P8BmFaIfr6ljYnPxqVzE0dAYgml35bG8jKsbvO9OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1e78Fa9SgxqWjSAYARkSfq9ONN2+QilJ2eT6DDN1OPDcrMzq6vojVG/dohDQjD8ZndeVm01NTu6WJ6+x6XvRt4x3KKzAmVK3oZaSycMUnLOwhXdd58ZB9s81GuCYcfwHTPxwbkCogAd5i7oONOK6zFOICvCBv+u1UhxT/QmLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9PW3tVJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741598387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LgP9YNR9e/J52BmiorQfd082BVFSTbBL5ZmjdHK0AhI=;
	b=c9PW3tVJtzB/Wn1OX+BSpGAJEyiE+43jRLw0LBKbbTy4xQKVotYbjSPgieMfRmsm3672Bt
	BZpQ48oUiBGtsm6Mt1/juXsCc3gbtxcO4zblhGKcsvfxsFJ3W6GzScOyntXJj2Wz2VJ5iP
	/lx82SqHRyKUrbaJ0vDRspaZGZeGRAU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-yJhDhXKoPNmNFcifbmuM2g-1; Mon, 10 Mar 2025 05:19:46 -0400
X-MC-Unique: yJhDhXKoPNmNFcifbmuM2g-1
X-Mimecast-MFC-AGG-ID: yJhDhXKoPNmNFcifbmuM2g_1741598385
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so4102505e9.1
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 02:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598380; x=1742203180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgP9YNR9e/J52BmiorQfd082BVFSTbBL5ZmjdHK0AhI=;
        b=k4DP3BZQbj+hFAKDuMmTjusHzjRL+f5o511Jo7E65eAwJb/XPpj0aJNZFPegx/zr3v
         7A6QOA4adfUlv/L4KbphVrc8xWQVExnBn1UKR7WQV/HI8sxTx1Qv1oHdEAe0d90XqEFS
         8gu2r2cx5NNuwsj8jPGWumQlrkwHIMJGgnUE7lRpmUGw8LmGlZwHNEEP88PX+4kbD/5p
         fflHfzI/zF3OyA7RzGriigZkCWVu2bHFqarsHT821n2qlZA6lVryXm3WO8oA/oOe9PkT
         9RoDsgPhXkx3NzEsqZ2E0zMXIDaXep6SASUYhm0U/ZAT3zr9KMPY2YE5nn6Yd8QwhfjO
         3oXg==
X-Forwarded-Encrypted: i=1; AJvYcCV4JJ23bng4reMrwfZqo5I7HP+riAgbjcY8A2oS4rxz1Va3g7AUYuBWwoZzjvZCtapOEBm9vIBA@vger.kernel.org
X-Gm-Message-State: AOJu0YwWAHs9vcajkLU3Ij25BK2lnb1dUNFQfQqLeSKjDa61hoxJ5BlY
	NGTlGcEhtbxWJcR/nGbdFcXmo/o4UbULGiVxD82issS7ZWN8q87SJLBAE2mCtaIWvCgibWlAjdB
	Uy/zUkYQlNvrCSdxw+U6wZ0RF0khvip1thpyKQVjcV3GSMYGM0pGxH+cz83QDZGPP0A==
X-Gm-Gg: ASbGncuoqWEBr7nb3XOLG+36iv+ztytkKevq6Ox3t5jP7TF9DPUAhqtq60x+GGzmkJd
	0ZJHT7XqZ88JYeGVt2CAG8xKffjgP6miy//hCf37ecIl4Uemxan7m76qKTTd+S8TEBzluJjSSBq
	FS/xg35z4aU+Gtsu2cpfWlApaTaMM4oVt/rwOAehhqJ+YI8OlIi2L1ung6ebTltoHEBd3nBUylP
	VZcxC0ViGawfnJVd9jVCIHerK3sk1mau6xJHOWEUCekucI5z3A1ehPu8pr4ilihAh8iSRY9N9L4
	B+ksjT+kfXx+8WZNYOkF9GpUPkeRXmPvsEfxzEAGPFE=
X-Received: by 2002:a05:600c:3586:b0:43c:ec4c:25b1 with SMTP id 5b1f17b1804b1-43cec4c26d2mr35851645e9.23.1741598379861;
        Mon, 10 Mar 2025 02:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK8kDv/kIF5AujcImOZ6FzR7/lxqopu1eD3a3yfv9LuJ8Id2hPzJtux5sr6e0hwrEqeIWN8w==
X-Received: by 2002:a05:600c:3586:b0:43c:ec4c:25b1 with SMTP id 5b1f17b1804b1-43cec4c26d2mr35851415e9.23.1741598379425;
        Mon, 10 Mar 2025 02:19:39 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce8a493d0sm77462735e9.1.2025.03.10.02.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:19:38 -0700 (PDT)
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
Date: Mon, 10 Mar 2025 10:19:27 +0100
Message-ID: <20250310091935.22923-1-juri.lelli@redhat.com>
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


