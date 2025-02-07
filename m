Return-Path: <cgroups+bounces-6451-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46362A2BA03
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 05:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439047A31A5
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 04:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682AE23236A;
	Fri,  7 Feb 2025 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JHdE+RYu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81431DE2AE
	for <cgroups@vger.kernel.org>; Fri,  7 Feb 2025 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738901431; cv=none; b=oi/9xejl2vOl/QPZmAMAvy4DNcEPwZXljpni7EUmFb5eLL9Id08MttZZJVtaiHl4pGg5r6c8WiYUOdjj4cU1CBy1rR586kkZF2u+tOC36KTjC2DbVAcVY7UyImgiCr9Y0+G7XuKY3UtmIWzfo6BvLmnXH6n+wIX52bQ1KbLxmxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738901431; c=relaxed/simple;
	bh=4yiFfvQmf+IqEFCVbwx0Ox15H/l5qURbpxynYPs1ZIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kaQF66cREkSMrskOHptErIUQbDtsmQxxO6ZuhH6btkaeUYbttzojw0rbhzIfZ4a86YexUq5srqBx9ryN6A45KjLL5CLPJTxljHWM++CwzOtcZ/VCgZQDhH3ajHq09xLNm5T/t5v45G6CalZXxMDfOhkSS3+jNBunN2xHKYbXp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JHdE+RYu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21a0374a1fcso4042605ad.2
        for <cgroups@vger.kernel.org>; Thu, 06 Feb 2025 20:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738901428; x=1739506228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnCfLPVKO43z3ormZqP6IZKrhAgtovoHgoWJYn1S3Uw=;
        b=JHdE+RYuw4k1jMI2MxLnk+RyrXx+nvL0ZvZxMpFYiTmIkg2uLaRHvr1R8fwJVetl3W
         3Tdww4jET/pVXhvo1eAAGqmN3isgYgSv9YEIqpsvHlBvTefjTeWS9TQ9iSyxu/LD/gg2
         djoPK2PjC7BmlRL8npO3/ho1iigduxo/FO3GwWkjvA/GLwwD3XdRim4XJa2oWjpUfdmw
         nZ4EwD8fluTTyxW1ciTGc3ilLsN0KdA6JmlbeILyG3uqc7icoaRAMs1y4a+WfLHXlNVd
         K1UwlfqekVgOEv7ghTVdDBW4kh89d4yS053eaYVWLoo4etv9YIdyZbuBgL9aCOBOWrB0
         /zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738901428; x=1739506228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnCfLPVKO43z3ormZqP6IZKrhAgtovoHgoWJYn1S3Uw=;
        b=HbenCuLaL21AzQ2gTQlbOn+uw2ne31XRaxLlQysadtu00R/5tI9poMsNcFCQ0EzMID
         sfSiMcAK8c4SdRtS5Kezg0Jam9MyO15yF9u4aWqWSIJweID0vMXnDcjnsO4VwfXE1iTM
         Asa1iXEFyJ9WX1FIsGaILovfjGErHsv4Wg3JbSckgX1ijc5FN4dv+3CEw6lLPrrApFds
         6KR6UkY6IigIYZLIgN6P1Yyjzkiuvk1+xyz/lDfzHqg0VqGIcr6BRusqcm61fWODWjY+
         UtjgfGMKclOtJruAvZG/JcGJDuc7o6mj1SAQMLtHpdg4QvsXPwz/aji3AskxD10WRFTv
         VYgw==
X-Gm-Message-State: AOJu0Yx8ulWbKxM2ZlU4Q64smQ73DuZUstjPVgJvQ/wWP9RNTC2GsCxR
	vLGKgwRYtdEnuUXldA4juw9dAu8o30Xyd3M+P6JtqxyJjZ1UYcN1pHzVJERZcHM=
X-Gm-Gg: ASbGnctBCCBlJpmjyO0KTwe8FT/0FBqmnNsVzf07Dwy+aNiBKFReUoQRLl32M4pQ6jD
	EYBMRVHeQ56nibh3WpusUsv+pVfCSCKX1gNlznJtzaZb1LGHG0q3qC3VLnYtVD3lXZg2XBZTVsb
	XkKGQYthlMSbAzD+A2TOfzuE9Xuji15z0+nVq+kj5xLXmrQc57auvdvfgfyZuQVuoBt5cCbgrSi
	IvX3W1eKK30tMLU/sWHIDUyDvcvA9NRePKFEjKeQUWALGCZC6UHna7VdrutyfYLbbm0BaUxADYG
	nh2VPY1Una6LC3pYW5bj0FdEDvI6K/Awn9I0xPfPBqv7FptGtU5fjQ==
X-Google-Smtp-Source: AGHT+IEkl43185PNxeLkgg7txN9kFAf7e0wb9MU+WD/KzTlqrVTDGwET2z05wzs/5ZubIeD6pxAbRg==
X-Received: by 2002:a05:6a21:9216:b0:1cf:4dc7:e4fc with SMTP id adf61e73a8af0-1ee03a23ef4mr1504689637.2.1738901427808;
        Thu, 06 Feb 2025 20:10:27 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aee7fbasm2135485a12.46.2025.02.06.20.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 20:10:27 -0800 (PST)
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
	Thomas Gleixner <tglx@linutronix.de>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/2] Fix and extend cpu.stat
Date: Fri,  7 Feb 2025 12:09:59 +0800
Message-Id: <20250207041012.89192-1-wuyun.abel@bytedance.com>
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

v3:
 - Drop the cleanup patch. (Tejun)
 - Modified 2nd patch's commit log.
v2:
 - Fix internal function naming. (Michal Koutny)


Abel Wu (2):
  cgroup/rstat: Fix forceidle time in cpu.stat
  cgroup/rstat: Add run_delay accounting for cgroups

 include/linux/cgroup-defs.h |  3 +++
 include/linux/kernel_stat.h | 14 ++++++++++
 kernel/cgroup/rstat.c       | 54 ++++++++++++++++++++++++++-----------
 kernel/sched/cputime.c      | 12 +++++++++
 kernel/sched/stats.h        |  3 +++
 5 files changed, 70 insertions(+), 16 deletions(-)

-- 
2.37.3


