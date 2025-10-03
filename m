Return-Path: <cgroups+bounces-10529-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EBCBB68EA
	for <lists+cgroups@lfdr.de>; Fri, 03 Oct 2025 13:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DE7480733
	for <lists+cgroups@lfdr.de>; Fri,  3 Oct 2025 11:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4882868BD;
	Fri,  3 Oct 2025 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiOAqlmt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB5192B66
	for <cgroups@vger.kernel.org>; Fri,  3 Oct 2025 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759491985; cv=none; b=rL20vjH0xUN7rDnMttcC7e6bvrNFK67gXqtzw3phNwEJqv76vh4liyOHe8WrUodl0GhJcfc153M34Hlhs19oz4zjeMOEyoqEmq7qP/oSnEp4CM7mvc38K2uHEQagLytE2dIZ1BiPX62m8HD1/SU1C8b2XcOSGS8/qvnLf5pycW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759491985; c=relaxed/simple;
	bh=PqpCO1hZ5AzWg8lpqzlwYEmvVQBm7UKwvlNkj9beh4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2+zr5ptfsjTDz6ihhS1ESG5VBlzk4EY3mnSfBeYoFe81rLQE3DOcobP0eGGmzveQptNHFOoZsLcs5bf3PzSSzo96EMwWoEN7Vq3Jc1mUYwlOiqn68LVf3ZLWPtoJ2fg9BpPQcc3xTcLLrOrELdsKNpWpkOFfa283WBPHTMVXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiOAqlmt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3322e63602eso3081030a91.0
        for <cgroups@vger.kernel.org>; Fri, 03 Oct 2025 04:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759491982; x=1760096782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kr5m4Q2MhDO3zmxeDrZVa1hCLYfkmOsaOLffDymj6ak=;
        b=SiOAqlmt27ePeqSJ7T9RG26dcd3D+41sWqvR9rcByKf0jjvhuH/XHHU4HuF8JWaY1x
         R5zg3ZnEYeCn5NurdA5kkVKb9gHaeGpiwsQpnBdik5S1PhjSxI6nwJYLydfGX3So3Anv
         2nA5M/b9c8IcQgGhTSXy74xJNTbBOS8a+fhpeeWae5FV4cX3bqyD4NDOQXUP1TB7DsPt
         P6HbDPmYr34hVmbWazIOpeshhMnpR8QaH9yL3JRv/tzRsbd5HmgtQzrsVDkoMeX7Za0t
         eglA/n3RekNe4qgACJ9ZBAKTqfBhjvpI6/aV1lf9AtlRPoCiUYEvB8MG4kn1ODUA5doa
         +8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759491982; x=1760096782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kr5m4Q2MhDO3zmxeDrZVa1hCLYfkmOsaOLffDymj6ak=;
        b=BKPeEeEuBLjDlDqm14xxI94w9SsgH6CoZJaMacW7QkKh8oPKce9wrL/C/uh/PcNzqL
         hg3ItKVc6fn4h5WCljDbUSfjYIysw2djjUIUTGMal684HGH8AbaOxJqUyYDme3k5tEbU
         ZbB1FIkpbt+hre0A+v/msPQlI3QP2IUh31yjO5J5dfa++gTku6pi0TJcKwtcwh1kQdFS
         PADz6YSHGhqy32NGeJLvago0Khow9kwi6cMCqgrMe/G/66KLeJwvSVRTCKPozKQDMyN6
         9VGnppk3vneau8KKlHjMNomi5ZwWLd5zWJmcwEfm0Kgg0t9t13p33p3AQPJJJ3UC0iDt
         lMVw==
X-Forwarded-Encrypted: i=1; AJvYcCXk9AThHbK1gmt5iJIXisZ+zncNYh9ZyQO5h/cHmW6I0o49iNjbdBdHvJOpyeukc37XYjCTBzIx@vger.kernel.org
X-Gm-Message-State: AOJu0YxovtnxkYZc2eoH6FsLAmbyBA0gY6lIoxQhenSZ4Ct53KKMYKfu
	TW4N5c2mqzMViIXt5AcU1paRmSMgzON5QSz8pmv93Hi7txBZ0/uLx1Vi
X-Gm-Gg: ASbGncu7KDPGyxb4U8dDwDcBPYZ1dfr96gK4Yzvjyf0RsoLbQ/FYu6ZJCaA6aytNsAl
	Zb1g3KyauFAu6X1arxDHJ7c4b8VrUiRSn8Ep+HpSU31pK0wxi0MwNs8BDTeotnV1ozSVG7YOb31
	++iMmc0ebflUFEsw3+CBYEs9kMTXdZYlQfYnD6qJK2EU9VKqK8NQ8njyLOBHxlKBCs/WDqpTFFb
	Xe0dM3fnEoGL9GaIIRtfS0DoMVSvD8krFuqk0644bQiG/bVqLZ9qSBY6MmOQs3dDbcPLo007mNo
	H5FdT/SS9u0JWj6FT5novTf2SFawY1ApJB/E0FPN3Lv+bbNbhSzHuykjNiRuX8qnPZ3fkVhskxK
	FDBP0ZPaaqFrbOIlG+kRwPDeZIcQZ7Yz2gNazVduxNg==
X-Google-Smtp-Source: AGHT+IE+B+A6PY10FHNa/K7kwAlpZK7Yj3hJ8GaSS7FT2H3r5Hjjq9oeSORJAi5t9tZGsLPWJ2J+ng==
X-Received: by 2002:a17:90b:4a50:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-339c2724834mr2844413a91.7.1759491982024;
        Fri, 03 Oct 2025 04:46:22 -0700 (PDT)
Received: from fedora ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm7825727a91.23.2025.10.03.04.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 04:46:20 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tiffany Yang <ynaffit@google.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
Date: Fri,  3 Oct 2025 17:15:55 +0530
Message-ID: <20251003114555.413804-1-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
introduced a seqcount to track freeze timing but initialized it as a
plain seqcount_t using seqcount_init().

However, the write-side critical section in cgroup_do_freeze() holds
the css_set_lock spinlock while calling write_seqcount_begin(). On
PREEMPT_RT kernels, spinlocks do not disable preemption, causing the
lockdep assertion for a plain seqcount_t, which checks for preemption
being disabled, to fail.

This triggers the following warning:
  WARNING: CPU: 0 PID: 9692 at include/linux/seqlock.h:221

Fix this by changing the type to seqcount_spinlock_t and initializing
it with seqcount_spinlock_init() to associate css_set_lock with the
seqcount. This allows lockdep to correctly validate that the spinlock
is held during write operations, resolving the assertion failure on all
kernel configurations.

Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=27a2519eb4dad86d0156
Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 include/linux/cgroup-defs.h | 2 +-
 kernel/cgroup/cgroup.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 539c64eeef38..933c4487a846 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -435,7 +435,7 @@ struct cgroup_freezer_state {
 	int nr_frozen_tasks;
 
 	/* Freeze time data consistency protection */
-	seqcount_t freeze_seq;
+	seqcount_spinlock_t freeze_seq;
 
 	/*
 	 * Most recent time the cgroup was requested to freeze.
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ab096b884bbc..fe175326b155 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5789,7 +5789,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	 * if the parent has to be frozen, the child has too.
 	 */
 	cgrp->freezer.e_freeze = parent->freezer.e_freeze;
-	seqcount_init(&cgrp->freezer.freeze_seq);
+	seqcount_spinlock_init(&cgrp->freezer.freeze_seq, &css_set_lock);
 	if (cgrp->freezer.e_freeze) {
 		/*
 		 * Set the CGRP_FREEZE flag, so when a process will be
-- 
2.51.0


