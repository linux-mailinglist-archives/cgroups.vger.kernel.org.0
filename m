Return-Path: <cgroups+bounces-6320-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73661A1C10C
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 06:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAC9188CF32
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 05:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4516207A1D;
	Sat, 25 Jan 2025 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LF4rOXnr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10822582
	for <cgroups@vger.kernel.org>; Sat, 25 Jan 2025 05:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737782748; cv=none; b=lN1UGwyOxWDO/hOqMbU7G3PgV5sK6KtDDNuHu1q7Q5Z1fs4buKITthdDOd7fajxQc9/z3JgUvuGIlarMcUdrEQ4J7mzeTIujQUmVwYl+aLLoyB/uDA5k7j1DTUMWzGIirl7O3Ij8ghQx6C25bINNhSC1o8ok6+n3Zl3o9AEtNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737782748; c=relaxed/simple;
	bh=a2EY7aaBq8HZEK3Tz53FoEOt8XTSEy5zw6G63alwJJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uHq57oR9hnCNez+60ACts3C39W3UQPT+Cr5z1sUsOfhH2TyGdegkpB2K8lcPkjq37/JwZP2697/hzMy8U4Qf+K2PjFdVIU5nh9Od7U3M1pBA164hXGRlzNt7sQvw/iBlzGKeDHaNI8q1LkdJRrHvIqtoFkD6R9mezEulnXk6DT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LF4rOXnr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee9b1a2116so610472a91.3
        for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 21:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737782745; x=1738387545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KbA5Vc/p7jG0EkRkkCEVfocE9Db6+ixW92buSIAp1vA=;
        b=LF4rOXnr93Ek7igiQ9vzfmWfO0Q7PBiSAT1bnvNOV4/858w6YW29TJbec3R1mx/4Fn
         e3r21qSJvzwHS611dWMhRxhkJ7p0VhzFfcpRwtQpB1357Dwc6Vt1JPTrdnWOGWosO2Ti
         TZp9Uuo2LfTvtcx46DNfVs7ZePB0NxOP7ZL3bKu/qJEt0MbfP9353mk0K/1ROq/6PgzZ
         jVD4P81g59lZ9MnhSIS9R5xsvCcc1hhBMzkAMrjrXqZKIXe828nQtascUXkMDQyAoPjO
         VPIOd+FFpr7SO9cjIK+4BY+GtCwTggwJ+LReyIee/oDlVDbdI5OuvP8vCs1xCncnP+Mu
         sYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737782745; x=1738387545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbA5Vc/p7jG0EkRkkCEVfocE9Db6+ixW92buSIAp1vA=;
        b=WpeHjq/boEsVOxqIDjhatjxdCQwMbtjEO8KzCv4Aj2ZUGYUU+JkRzh7ahqCjZRW8Gf
         8Z2RACHugomHUArFcmuWTpbY+qLE3h5S3mKbg9uT+ZuMQXJslVLMbCYYX8fbDFfd7IwD
         oA5QKQg2uOT6xAdaCEjalBIIZ9HuWwxLHepGYZ8bpS+1LdccHeAhq8/ONKfVk4Vt/fyK
         9hUnCT2ZdcCutYHcrxEaLjWU8YqpeP3lwqGFpuR6TOzVZZA4urnkDiTmR15Ut5uCbTuD
         /WeKAsXy54lxYkHlalOnP75Yi2s3nj59MbBtpD0jx1GD+gSc2/SNrz26iT0jfz6af8fu
         xXTQ==
X-Gm-Message-State: AOJu0Yw/UzxDapLiRgcyA0h8PLiPfuJGHF7oNB8VOi703NzHVyGk6HwZ
	ikqeFGW2ExDmeia4yYz33XBYUlJTjllxOBqbAlW7cqkfqOl4ZpuIA4cwHcVVJYg=
X-Gm-Gg: ASbGncsF/9e2zfpkm/p4xMgG+MxD2MK6LTTVtd42wlSqeu3IdRTFgfm1veqq46wh3wf
	cU32gFvbLbQ43s4UvgcWOBu9wHU21rgygxJmsSjUNMqYVHDNRB4iy8loFCn34Ql2o2/Sl1qTuEM
	qSMKTnuGOIjxVGYDCz/zxmjqNm+ckeh9YnycZNoLHieXaZiVOiTguWh0HWI/oV5hCIcedIoNNwd
	nj/3A2Bn1xyUR3nfhLpyiIqGPtNnsfRs4Wz2enYNXxJfE6126rwaacALnNe8MDLrYejrf77okSh
	LyTyOkJnfr4NChSIMbAHfg9q/AdkEgmr8/QmCWyGYjc=
X-Google-Smtp-Source: AGHT+IGPjWX4qVb5BtdEM0bm6ThIQyDK3FZpMNGfXlrJZlmK8SVr/pW7if9Daxdls5M25Y1cTIsKjg==
X-Received: by 2002:a05:6a21:3416:b0:1cf:3be6:9f89 with SMTP id adf61e73a8af0-1eb211833famr20512932637.0.1737782745130;
        Fri, 24 Jan 2025 21:25:45 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac496bbdc9esm2563856a12.63.2025.01.24.21.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 21:25:44 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/3] Fix and cleanup and extend cpu.stat
Date: Sat, 25 Jan 2025 13:25:09 +0800
Message-Id: <20250125052521.19487-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1: fixes an issue that forceidle time can be inconsistant with
other cputimes.

Patch 2: cleans up the #ifdef mess in cpu.stat.

Patch 3: extend run_delay accounting to cgroup to show how severely
a cgroup is stalled.

v2:
 - Fix internal function naming. (Michal Koutny)

Abel Wu (3):
  cgroup/rstat: Fix forceidle time in cpu.stat
  cgroup/rstat: Cleanup cpu.stat once for all
  cgroup/rstat: Add run_delay accounting for cgroups

 Documentation/admin-guide/cgroup-v2.rst |  1 +
 include/linux/cgroup-defs.h             |  3 +
 include/linux/kernel_stat.h             | 14 +++++
 kernel/cgroup/rstat.c                   | 75 ++++++++++++++++---------
 kernel/sched/cputime.c                  | 12 ++++
 kernel/sched/stats.h                    |  2 +
 6 files changed, 79 insertions(+), 28 deletions(-)

-- 
2.37.3


