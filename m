Return-Path: <cgroups+bounces-5361-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29059B89E1
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 04:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67826282E5D
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 03:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711214265F;
	Fri,  1 Nov 2024 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afPAUHNw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0983CD2;
	Fri,  1 Nov 2024 03:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730431089; cv=none; b=qsL8rYGA/dPvVq/300MAzoGosX8N+LezjRQKD4n5/M4s+VA0BK1JXTUtHAIzTxVvo5brjP8pICoQABJ6GDCW9R6D+nm56X5pGe/GqPV+6ivV8RCxpRRzItR/rSjLNoDHcj8mWUYV6zOAWYausGhhqZ10tDIi4W62N8SNG9Vp0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730431089; c=relaxed/simple;
	bh=kE0b6SqaagtclZDAvD5IA6BEvD9BDVsLYL9M/3H5k9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZJTgdqoHy0uH7pJUquaNBfjXdOPqLUV/9PlQt8AfOEMyd1CPlJVOSWmu79+Pv03Il2KWGKPZ9Jyd35IzxQo8RXZbhmqgNwjGiwB8O10Xf7tlUjVOTJ5GtHaaiZUFPJWiGd6eXJMbji+3bOqdVYfoauPtGndBOs1uI/3QKeAVEi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afPAUHNw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so1355613b3a.3;
        Thu, 31 Oct 2024 20:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730431086; x=1731035886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQpaHB9cW5qSxiTYZJ7mCfzun8xsjg3NUKsyTSEGsCE=;
        b=afPAUHNwosaXFwz0adi9oLkFNPDukAJVBMQq2g1nWy3e68bRR2AnDBV9WBziElxnKq
         pbojBtut0Vg/FwW7tJKQUUasSVuYjrSi2Xf5BhpysSxq2qKBqbxAdRPRVhEmcRSBKJ0+
         ZPMDsyuwSZkc2uw+eb8GRMWjPgl2aRHY+JaFdmoG1y9cDq1NvT5T1SPhqoKkhQaNiPZH
         XWc5pLdwthd/PPeJuO0i4gbSrWBG3xpHa69nbKn9hoFEcvXwsFUjrVIFt4A2xtiCeXKS
         uWhFsWJxMl66v80pNu4w/VD78tsz3iVQeuO7GXqrYNEC/asDna7xHjnn32RNIANyhYyC
         VRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730431086; x=1731035886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQpaHB9cW5qSxiTYZJ7mCfzun8xsjg3NUKsyTSEGsCE=;
        b=BVhlQZ/6+t6UAOlreR3MyZRhO1a9vQhhlc7PWXy9KHpw49Plnb0lA0flDJKN/jVhB+
         q/nQaCgwFOF84j6zbBalekPBRDnw9p9jVze45nJbx19G/EsjpTperUNA9yppCBg/8cPp
         kI3xGcZi0pZ2yzWPS4b1BCDkO/wGGMhUHA2szILwQFmLwOdrNaHeCxs3jAePuVePOqt/
         HoyWzK/c4na1SvPr1VleCz7YcBU14R+C7rKY1c/+CNKGJIUmKaKi2r//Iip2OzShWIxa
         RVZ+hUJpVImlegikQRcZHQDv6TJlNfogmPm8v2KjB8xsgVQFwFqqvGbh+jmln22SqIOk
         QnCA==
X-Forwarded-Encrypted: i=1; AJvYcCWWfAzwK1XTI5E2wmjQJdLqU7Q+sdcLomaurg0b8nrryjOUqrLLxaSt0bs5oCgAp+IfPJ5oCjIL9UVvRFa3@vger.kernel.org, AJvYcCX0EBZXbsZiuN25qO43yqM4uPWmgOi3+B/cW+41g4gFwpqN+My4NCQat7o1Wvq3+uVvKhbP/9go@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4JwQaKUelaw7jbNOnbxYBPLIwqbuONb50XDugRjeiO+yGC6Pp
	FXLxe/5KbZwd494eHadol5GB58CEENl4+QPT9HkdhgXibd41R79l
X-Google-Smtp-Source: AGHT+IHyuoHMjkWnhaqKRDMJ/0/qGiq0vmELtZbkjk7xCR/XlIqGXDu9PE1AiH7jKcO824hvVwz19Q==
X-Received: by 2002:a05:6a21:4610:b0:1d9:22c1:1231 with SMTP id adf61e73a8af0-1db91dec20amr6098607637.29.1730431086263;
        Thu, 31 Oct 2024 20:18:06 -0700 (PDT)
Received: from localhost.localdomain ([39.144.44.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc31af9dsm1854445b3a.217.2024.10.31.20.18.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2024 20:18:04 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 0/4] sched: Fix irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
Date: Fri,  1 Nov 2024 11:17:46 +0800
Message-Id: <20241101031750.1471-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After enabling CONFIG_IRQ_TIME_ACCOUNTING to track IRQ pressure in our
container environment, we encountered several user-visible behavioral
changes:

- Interrupted IRQ/softirq time is not accounted for in the cpuacct cgroup

  This breaks userspace applications that rely on CPU usage data from
  cgroups to monitor CPU pressure. This patchset resolves the issue by
  ensuring that IRQ/softirq time is accounted for in the cgroup of the
  interrupted tasks.

- getrusage(2) does not include time interrupted by IRQ/softirq

  Some services use getrusage(2) to check if workloads are experiencing CPU
  pressure. Since IRQ/softirq time is no longer charged to task runtime,
  getrusage(2) can no longer reflect the CPU pressure caused by heavy
  interrupts.

This patchset addresses the first issue, which is relatively
straightforward. However, the second issue remains unresolved, as there
might be debate over whether interrupted time should be considered part of
a task’s usage. Nonetheless, it is important to report interrupted time to
the user via some metric, though that is a separate discussion.

Changes:
v3->v4:
- Rebase

v2->v3:
- Add a helper account_irqtime() to avoid redundant code (Johannes)

v1->v2: https://lore.kernel.org/cgroups/20241008061951.3980-1-laoar.shao@gmail.com/
- Fix lockdep issues reported by kernel test robot <oliver.sang@intel.com>

v1: https://lore.kernel.org/all/20240923090028.16368-1-laoar.shao@gmail.com/

Yafang Shao (4):
  sched: Define sched_clock_irqtime as static key
  sched: Don't account irq time if sched_clock_irqtime is disabled
  sched, psi: Don't account irq time if sched_clock_irqtime is disabled
  sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING

 kernel/sched/core.c    | 77 +++++++++++++++++++++++++++++-------------
 kernel/sched/cputime.c | 16 ++++-----
 kernel/sched/psi.c     | 11 ++----
 kernel/sched/sched.h   |  1 +
 kernel/sched/stats.h   |  7 ++--
 5 files changed, 68 insertions(+), 44 deletions(-)

-- 
2.43.5


