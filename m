Return-Path: <cgroups+bounces-6470-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD54A2DB44
	for <lists+cgroups@lfdr.de>; Sun,  9 Feb 2025 07:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147CA3A5F09
	for <lists+cgroups@lfdr.de>; Sun,  9 Feb 2025 06:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3A354738;
	Sun,  9 Feb 2025 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HhFD3WR+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BEC8831
	for <cgroups@vger.kernel.org>; Sun,  9 Feb 2025 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739081618; cv=none; b=jGWBPZ2CAo8T46hY4iLVNtXlhngJzF/dKdaxPxjIjD93p6WfndKULpqYEmVKJFS8tAiyPpCScstXxQR8ZGl7vYDWER4FSlBXAkiMUTf+P80q7DTtphweBhNSCV/zvCWksvbpyvPKqxUcwnlb1U7+mnDt0MFKidVzqMSOMMm15SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739081618; c=relaxed/simple;
	bh=r9l3X0h/k4HjyI4SfuRJtcppk/M3dsbr96keZORi72M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DVuxb1oHYb16lRk3GPriY89JyvKUzmxVRjoejCrPxjQXwU+19ZLGTPUaJ2Lw94MaxQALTPa0J8Jz8A3lPxq2uVvejb3haQC1bNnrX4whyKG0AlEBDyzT4y2YAYgrHqSjb7rZTfnLPP7X29+nBD6zszIcbI4NgQW892SF8K44evY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HhFD3WR+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa1c3ac70cso666176a91.0
        for <cgroups@vger.kernel.org>; Sat, 08 Feb 2025 22:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739081615; x=1739686415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YU7wRncnO8wIwaOm5iP7dvoTbcr3ycvs8QfzeTKT60Q=;
        b=HhFD3WR+QC3YLSTLKh7E0C/fm/+/FUP+rKaAu/Sy8WkICLsixX1pcA7P07nyvn1874
         6MT1ktZq2SCnyW0JtS/RMVWkxk7Krz8aodWrT9Dk6b7HTqSQ+OMmJGEwvXrIGLMVx1oL
         q5MFA7AqUyFsiOvcTOtTa2cyVezzGq9LsMwrc6Ptr3G9W715D9EXP/mwtQMEW2lm9Aq6
         62KtW88N/OWtpQ/vg09iojj2N9kXQJ3UqFcAo17JIyop1qqeQE4CHd3PGncR5s6Fyk+l
         yLuXAQbhqDgOci3rgLDggcI+FKm51RX9g0E6EhEuLkWIGwdYOnRUm8uGD8oWSK3nzNhg
         Pb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739081615; x=1739686415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YU7wRncnO8wIwaOm5iP7dvoTbcr3ycvs8QfzeTKT60Q=;
        b=t6hWzR2Jv0vWtcadqR5wzPEDcdu5/a+bEPZU7aYl8WcS7KxWhTJ3/WBUy8tvwf/nb7
         lzYg5J72K7pZ6htzVGuDonRaZHyrUsgq0GyaB5/5yrwPih8XQyDpY/C3omsKeYTtgE67
         c2FE2wiSJdHAG2T2sZMicn/ExIVGjV6WL72bpHEqts+tLgv0gISGRYTmE4CJFosYKf7X
         nc1TOgfN2FokGNP42XzlTL80HznGPCCKBGK0hDwsVkv1U5L+MfzgI7P8k9V0idF4XviW
         4tMvFAZi6jFL0f3YwfEstemoBaBCSa+7VmYc3uc4kNC9G1CJj0rEGQouiQF/BkqG30rD
         czgQ==
X-Gm-Message-State: AOJu0Yzl1JwZHPwNm8rEGxqv9HqYgD+alkH09Rl47cHUNAgoT7Jg9VtD
	Cs96IIIEZ3ros4pI4aJd56y7ggQci94iTVOSz1HX/EZ83HMiG9cTsz885AQO7L8=
X-Gm-Gg: ASbGncsLx0C0Vj/cHpDZf2zh75GT7RO1TUdS18rlC4xoTzyZsWOKKB0BW0seyMVgoKl
	oIGM4WFqnICMqHOlAsuESJvlZR8fv+ag9EJkoqxcnQTUZbxQdiIMOmR8umTIShC9hDo1/DvrYW8
	zZK3xHIRWQXzZhs+AUMTT+4cx4DAyWOzPTEVq8leBHjhFbSdgcL//rLrFukjzTyXNwLadUTecA0
	rPfvtrnj23Mtnb6tBHfRYCt3NQvPYXwkM7BuokRefWVTGy6QA3JFsyHJ72MQ/boQzZxJTlvNcQr
	1e0KrnBIghYQ4k2/kDwQelcZMcB8wug0NPSUrqvNsfGh18vhJ5/H8w==
X-Google-Smtp-Source: AGHT+IG4/B+BVSKFZSg0eLyPkjsStbggwOl3ypIeb+J8t72J6SPFnXFAvt85+GGZSh1vuPiPJlSHfA==
X-Received: by 2002:a05:6a00:1a8a:b0:725:eb85:f7fe with SMTP id d2e1a72fcca58-7305d2b2903mr5406607b3a.0.1739081614939;
        Sat, 08 Feb 2025 22:13:34 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad26b9sm5550700b3a.50.2025.02.08.22.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 22:13:34 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 0/2] Fix and extend cpu.stat
Date: Sun,  9 Feb 2025 14:13:10 +0800
Message-Id: <20250209061322.15260-1-wuyun.abel@bytedance.com>
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
Patch 2: extend run_delay accounting to cgroup to show how severely
a cgroup is stalled.

v4:
 - Fixed a Kconfig dependency issue. (0day robot)
v3:
 - Dropped the cleanup patch. (Tejun)
 - Modified 2nd patch's commit log.
v2:
 - Fixed internal function naming. (Michal Koutny)

Abel Wu (2):
  cgroup/rstat: Fix forceidle time in cpu.stat
  cgroup/rstat: Add run_delay accounting for cgroups

 include/linux/cgroup-defs.h |  3 +++
 include/linux/kernel_stat.h |  7 +++++
 kernel/cgroup/rstat.c       | 54 ++++++++++++++++++++++++++-----------
 kernel/sched/cputime.c      | 10 +++++++
 kernel/sched/stats.h        |  3 +++
 5 files changed, 61 insertions(+), 16 deletions(-)

-- 
2.37.3


