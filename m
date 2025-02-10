Return-Path: <cgroups+bounces-6477-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8574FA2F10A
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 16:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556E93A50B3
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B9E223310;
	Mon, 10 Feb 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PQtmH1nF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54047204861
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200378; cv=none; b=U0Y1hR5P8IMbEXuI3a4C7a7xJqiWMsq0f50L3K+6SVg9pzuaII0XCnYm2Kf7wV+lEg8p6h6m9BJoacN1rMGpDtzHTqgvkYKMawDPhufyGFzfgOHdjIIoFpbMl6uIrNSbLXevdirWsaXJl3Ou5fo/4X7Uhj8wmmlf1o6sg1F0XbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200378; c=relaxed/simple;
	bh=Do0H0cxpcbgv7snc7/zxpc0UAqgTdXWl2YEFyV50OgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VsVRkKHY2Z0xbSzqSOyGb9FI8GnqrYMLRtdPQekjA7Q/1WLfWgipf/8QC4oc948m/9v3aWt7bUxS/j5IY0k6T/E1MTjsjGU/oG/Q2X/2JY6dcUPF98Fu9bxfcjqH8A4n9IKpPQIUQx+iop2j2KQJMjUOZ3qLlImmCy4f0qLy42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PQtmH1nF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7a342ef4eso431377866b.0
        for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 07:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739200374; x=1739805174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4wKGfGTnsXTtvaKeBweQpHfiqMKnwO7EBbd/dYuuZM=;
        b=PQtmH1nF2F08/w2ZLHSoGYGPY3frlPkStJNcHSHt8g032kQCLcjRJd+htXyocC7QSW
         Ib0QKkf2CRDcc0DQRSsvZYnsxolgjSESnnVnb3Fvm8/8zqQzixFP30RgCL6VdevW5ioX
         Bdc2RruROcRWqqzidT3dzFuvxiDsyTfTsY7kS2aG4dJtASX5dxgV34HfTHye3cLKktNH
         5LF1qhBO1leJ/c3G4ls01HL70c6xxYoukjdMPgJz9ZdVAp0y1S7Rq3nXToX2klNqc9X1
         My3qIbI4hLwzD/1yshcl1/YHOoZ2VfCkZOGjp4BwoO5PRiqZ7l00pHWwyf366y06l2P9
         ruRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200374; x=1739805174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4wKGfGTnsXTtvaKeBweQpHfiqMKnwO7EBbd/dYuuZM=;
        b=gYO61WGae+evM+GfskYAe90t160VshH/QacnHTz04rdwxoiIcH+Y2hg5LJ0GrLpVU1
         a3cDOscspC6bAc2con5UZwT1lp2KG4aIXZkb2Sjshg5Au1oYWPzu18aCdJt164fF8nym
         /zKEmFOw1SqzJTMFh4cmhnvP0muPN+Yuf9nGAhEjuvavjwpMEA0srh5EW3B7tlfOEN2g
         TNYNvm7FaiTTPdDXMmAdc5YWc8ldwFDsaAt+KTWCJLwld5Esx0NLVNGngD1bObt0NwiN
         3VakJWpi1YQAvZXKGvBJImvHf9B3+cjs/i5ViXxge1entwpYI9R8qR2BcahWGR/FA9gb
         qNrg==
X-Gm-Message-State: AOJu0YxBzgAgZTowYIVgGkVgmM1Mtuhn+CD8RdYJ3Ju0gv+2yUgRoTi7
	MfatJog6s1fcLUKDl2oDJnzI+XBLikHA4mCxi3V6DcMlc3zW6bFkQv5acDJS+bl/8nStsRHIN2d
	Y
X-Gm-Gg: ASbGncu/HknU99LdcKK+sFPIApvcTP5U3saClagVUF8bhiWw77sUXut65W40Y6qKhcL
	c7Rp0oYNx2b+ETUyzLopABb/P3GCrg5wtX84pULKvra3jeJY5CSbz+rrY7YJq7AIudjqFDoMWMU
	r41IQTpxVBwwlni2n5IWH0+kEXRYz/hnGO1xGEu3OS4eyhzacMMTm6kt4jz49n84zAsxixt1aJ/
	F2ZyJPV7dI+9Jcw0BWgJ36IObBpiymOjNJs9Y32qQ2w4l5S62bspEdTaPO7xdjVzbPpJ3qY1ZFZ
	1PzVc+KNxe9q+Vnflw==
X-Google-Smtp-Source: AGHT+IEK70Eq5qB/82U2DF9U8xS5b4ZB61X1lgZd7HvA4AyJf7apGUEqkW/Plc8FI5WzSe9hQgSQUQ==
X-Received: by 2002:a17:906:9c8d:b0:ab3:9923:ef46 with SMTP id a640c23a62f3a-ab789aa088bmr1590639766b.11.1739200374380;
        Mon, 10 Feb 2025 07:12:54 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773339e82sm895192866b.143.2025.02.10.07.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:12:54 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: [PATCH 0/9] Add kernel cmdline option for rt_group_sched
Date: Mon, 10 Feb 2025 16:12:30 +0100
Message-ID: <20250210151239.50055-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Despite RT_GROUP_SCHED is only available on cgroup v1, there are still
some (v1-bound) users of this feature. General purpose distros (e.g.
[1][2][3][4]) cannot enable CONFIG_RT_GROUP_SCHED easily:
- since it prevents creation of RT tasks unless RT runtime is determined
  and distributed into cgroup tree,
- grouping of RT threads is not what is desired by default on such
  systems,
- it prevents use of cgroup v2 with RT tasks.

This changeset aims at deferring the decision whether to have
CONFIG_RT_GROUP_SCHED or not up until the boot time.
By default RT groups are available as originally but the user can
pass rt_group_sched=0 kernel cmdline parameter that disables the
grouping and behavior is like with !CONFIG_RT_GROUP_SCHED (with certain
runtime overhead).

The series is organized as follows:

1) generic ifdefs cleanup, no functional changes,
2) preparing root_task_group to be used in places that take shortcuts in
   the case of !CONFIG_RT_GROUP_SCHED,
3) boot cmdline option that controls cgroup (v1) attributes,
4) conditional bypass of non-root task groups,
5) checks and comments refresh.

The crux are patches:
  sched: Skip non-root task_groups with disabled RT_GROUP
  sched: Bypass bandwitdh checks with runtime disabled RT_GROUP_SCHED

Further notes:
- it is not sched_feat() flag because that can be flipped any time
- runtime disablement is not implemented as infinite per-cgroup RT limit
  since that'd still employ group scheduling which is unlike
  !CONFIG_RT_GROUP_SCHED
- there remain two variants of various functions for
  CONFIG_RT_GROUP_SCHED and !CONFIG_RT_GROUP_SCHED, those could be
  folded into one and runtime evaluated guards in the folded functions
  could be used (I haven't posted it yet due to unclear performance
  benefit)
- I noticed some lockdep issues over rt_runtime_lock but those are also
  in an unpatched kernel (and they seem to have been present since a
  long time with CONFIG_RT_GROUP_SCHED)

Changes from RFC (https://lore.kernel.org/r/20241216201305.19761-1-mkoutny@suse.com/):
- fix macro CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED invocation
- rebase on torvalds/master

[1] Debian (https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/config/kernelarch-x86/config),
[2] ArchLinux (https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/blob/main/config),
[3] Fedora (https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-fedora.config)
[4] openSUSE TW (https://github.com/SUSE/kernel-source/blob/stable/config/x86_64/default)

Michal Koutný (9):
  sched: Convert CONFIG_RT_GROUP_SCHED macros to code conditions
  sched: Remove unneeed macro wrap
  sched: Always initialize rt_rq's task_group
  sched: Add commadline option for RT_GROUP_SCHED toggling
  sched: Skip non-root task_groups with disabled RT_GROUP_SCHED
  sched: Bypass bandwitdh checks with runtime disabled RT_GROUP_SCHED
  sched: Do not construct nor expose RT_GROUP_SCHED structures if
    disabled
  sched: Add RT_GROUP WARN checks for non-root task_groups
  sched: Add annotations to RT_GROUP_SCHED fields

 .../admin-guide/kernel-parameters.txt         |  5 ++
 init/Kconfig                                  | 11 +++
 kernel/sched/core.c                           | 69 +++++++++++++++----
 kernel/sched/rt.c                             | 51 +++++++++-----
 kernel/sched/sched.h                          | 34 +++++++--
 kernel/sched/syscalls.c                       |  5 +-
 6 files changed, 137 insertions(+), 38 deletions(-)


base-commit: 69e858e0b8b2ea07759e995aa383e8780d9d140c
-- 
2.48.1


