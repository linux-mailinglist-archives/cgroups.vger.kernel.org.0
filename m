Return-Path: <cgroups+bounces-5918-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F979F3A8B
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 21:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF57162C40
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 20:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2371D1E74;
	Mon, 16 Dec 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WIXvbwSc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785F1CEACD
	for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379996; cv=none; b=Fv2PAwUoQFjR7ijcVz4nf8oxOOkdXcSe0dtKeYjPAdHuzhmQL8ZVk1hYUtXABEGPdnqyjcelGeZ648XcUMGPOnngA8Hmmav0oy+ZOSaFlRjNjqiTPQdfJVqpqlsT8U+wX82sH4LpCLhBewlTcFAF5henbobx4AJE8rE9aUmvok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379996; c=relaxed/simple;
	bh=VfpY1lg8qWPOYs5ZW5US/FQs4Br4rivYPKMDP5CQmDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HLVY5YAL8b9jUoFOaZkCWMj+DrlXiARUssDIXZ+oxhnoSay/OwUXtmhHjL0og4wtubzGa7SXrkwDrGKATF1B4fG5SDT8F7tCy/Wi5TR7/tA4ksPnAE/YvsXePd3z+m1coIJXaaywgTNmhKidypEeHmcwc8ySz0cHyGzzCEOCHQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WIXvbwSc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3863494591bso2460439f8f.1
        for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 12:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734379992; x=1734984792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OouNaFJeHy2yhHYnIMJU99W1TZZG/yZaUEHixebISWQ=;
        b=WIXvbwScwGXK+Gcx0udttbyG0vXrp3dmHkuIJlhXe2UHnt2hK4LJarrnxdPvwM6ffc
         bZYMJn5chkzdM1G3zrLjHIv4OK05LM8rriMD8aM2+tWuBA3GKEuzOAiICN+jOE+1WGOX
         baacZqNZRJwsAjZMDDDbmttulm7frWz8sWFvHMbbuH/6/oDY7/MrCV8dGI7qii2q+ZQP
         gfZ8HHlL0VHDx08sRiLegDs5Y1Ir7iTIrrmkWu2+Yy2SDo4A6Sx3ovV1FKodTSx0gO9M
         VHxORZXqVU751mDa7R/nph6X72SOegholHn1V5oLk81AoN6EWYmafy+eRn6ygVUyX6jS
         x/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379992; x=1734984792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OouNaFJeHy2yhHYnIMJU99W1TZZG/yZaUEHixebISWQ=;
        b=O1eqxJ9D5amFrGqiDtWOMiccIxOaJbpQnIyma7FHBXZrxAHsZVUvMXwU3BuMF8N/Ke
         Om9OvaXouywBqgE567qu3rVJZwjYEfEEtCsXdiUk3fnmIcLg8ugAd33O5xmFf0Nf1yN9
         WV/uDKxjnTalwF4Bpdzg9XtW/VKJ1w6ZUizhKFLFiViLco4s6nKWKmwZk1leZl0+MsCY
         0NQniceiX5q6cZyBGun3MsifMYmXEqZ1Rcgr/W/+lnWuNZ2kR96WbdNe/fz/U1id2sSo
         XM9X64TvkGFLbj0b/73MX5kFGaV7aBncSOKtnuScwZb2AdDGeidInc4OkUDkEWovD94P
         f/dQ==
X-Gm-Message-State: AOJu0YwwBowqP2yINURdMg/nKuPKf91h4yPh51DIJn25kcqE99o91cjP
	sXRuGX4uMhFWHFqG2byauo4B+uCjGLhtU6H2tjlVJaasaGYGx0ou53CBuW/QqgxU7yEjbBqnVU7
	c
X-Gm-Gg: ASbGnctfhC8Ow+d64Gafpiz6QmeiaXO5QOM666kSnrdbTOM1cd4qFtYhPcvGswXjYqD
	jE9nkjcZxLxmCk/+lYkvmlLk1X9yT+4/U/nWbzRsBAxVd3DrHUbzuqLVIlWvQ4Lthf+rdl7OYiE
	IJnILNlLW9mXYlF6YeTsnaXRLGos9+dZUhBs4geJ8jf3sJMjAJNY2HbQNExzDPwTSBXLEJMqc0m
	pwOdgpjzdv5SWYnnwESDbsrSY/oy7XAAuOa3GYaqFiAV19bu08pn6AhgQ==
X-Google-Smtp-Source: AGHT+IEIUFLN9n45JOH81LShJBKwC14f2uH+CTq68rpTvTCILKElT7nttz3ugXiO4LYUXbaKUjTQ8Q==
X-Received: by 2002:a5d:47a9:0:b0:386:3328:6106 with SMTP id ffacd0b85a97d-38880ad9aaamr11953075f8f.35.1734379992428;
        Mon, 16 Dec 2024 12:13:12 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:12 -0800 (PST)
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
Subject: [RFC PATCH 0/9] Add kernel cmdline option for rt_group_sched
Date: Mon, 16 Dec 2024 21:12:56 +0100
Message-ID: <20241216201305.19761-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Despite RT_GROUP_SCHED is only available on cgroup v1, there are still
some users of this feature. General purpose distros (e.g. [1][2][3][4])
cannot enable CONFIG_RT_GROUP_SCHED easily:
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

Futher notes:
- it is not sched_feat() flag because that can be flipped any time
- runtime disablement is not implemented as infinite per-cgroup RT limit
  since that'd still employ group scheduling which is unlike
  !CONFIG_RT_GROUP_SCHED

RFC notes:
- there remain two variants of various functions for
  CONFIG_RT_GROUP_SCHED and !CONFIG_RT_GROUP_SCHED, those could be
  folded into one and runtime evaluated guards in the folded functions
  could be used (I haven't posted it yet due to unclear performance
  benefit)
- I noticed some lockdep issues over rt_runtime_lock but those are also
  in an unpatched kernel (and they seem to have been present since a
  long time without complications)

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


base-commit: f92f4749861b06fed908d336b4dee1326003291b
-- 
2.47.1


