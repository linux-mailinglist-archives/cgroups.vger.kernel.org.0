Return-Path: <cgroups+bounces-5105-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54BC99BDFA
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 05:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4361F22278
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 03:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4E8481D1;
	Mon, 14 Oct 2024 03:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7PDkj8N"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C38467;
	Mon, 14 Oct 2024 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875472; cv=none; b=iEA+MGfVCtGOH8MEFqTk6hmeDdLWOCo6OY5OcQtufrp52PFRcRzFkHFQEPloLYLAz1nOgr9jDJ/mxpBgPiZP/JJhf416+D/7yCyzqOYD8vRSWaCcMv7eDjolf6J9wMmdfcE4kzOV4/cDk3aTJGifmm3l8Rl7gfMLhqkpve6gxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875472; c=relaxed/simple;
	bh=ezRnHF+hwap09liGZg22w1PqXOr8Pj038urUBteNnLU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nNgzlbFmdTF67GIZPfMHlhEivAuJmKe7iMAq8t4jy2kWwBNA6mGE6hA9LGmDW/PrA0KXAWI9dTG2qERwLCbeGvIRMsKFaTXYVpqvmfHEqDqKbC8GPz5M2K8n4LGzQ+b0EqFa7BFNM+t/ziEYGLGAEHWo2jtcXcBkjPt2fKazAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7PDkj8N; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea7d509e61so184816a12.1;
        Sun, 13 Oct 2024 20:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728875470; x=1729480270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=noHeBIJrGMZqqAZVU4OziaGfvb3jHPcwbCf2WC+Ckow=;
        b=b7PDkj8NxiYqI+NeqUuHH4IPw4MUfLrA9cJ+HjqEj/5V1pQwv8twkCi/CAEsAm480N
         bOyXgEYr+A52URC1nNtvdW4qaJFnfNWhejf7yhjQkfQ7B2gED92OA3kpvyJsG/l/gk1k
         UvGssMHoGlZGRWMNgbCgHWk+ysGSDWiMqBq5twkEUQ0sorx9tx6YmOHYk/mngLm94Luw
         Y0g7UyQ7xZcnQQjpjZtbMGLxKwdcPL8f+oxnHO8mtnyeT2mP0dh3nsW/8EK48ImJpBnI
         q/Lvmq002FpDBms47jh0AITwLVrKuEwZI6+U8E+TVKPNC7n8u6Xc1MuoIOci/kys3Q5i
         gSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728875470; x=1729480270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noHeBIJrGMZqqAZVU4OziaGfvb3jHPcwbCf2WC+Ckow=;
        b=wYvNfK3UL5BSgF/7ZmiXeTtF1ouRFGN+Q+jtv9Kiavv4vjXU3x9qByvU/uJhbL2jqD
         K6/KC1tC32QZKE35t20sEgnb7p6+G8BkE0NXNr5e+6XehRJLzfOaeKG9QJ44nOHh3Cdv
         1O/6wh8BJBwAGfM+NphPtQ1BRz0NnSIRhuZBUQWS3P1kVHHT8g5CJ4UJ6wXnYTtb79ZL
         nldg3+x/AMjuDfd9WqksLDBzLnvYdDKwLcBxVzNX7PAOfwSdZqTIfgfT3joFDxF/zAF4
         YleZ2dSMNrqifTPTezuH1+75+TVQuIT+USJKX3Jz6ZY00HyFX3pHQvr5PxUr0eHdMFoK
         pJbg==
X-Forwarded-Encrypted: i=1; AJvYcCXSe8kRFjqhPbTNOsDdr8yKCd/QbmhIKqRKVkNV9aM0AAGZJkinegVWTUCMRM98aW6kR8EdC+eYm3Sk1Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWSwHw8doXjRI+TmhTywDnSJCZVm321I1J1qI0zVKp5TXvGIjP
	zEy4T1ARFQKO2+25o0DXd9FqtbAKspsIycO5AoWbaxy08mQmZlop
X-Google-Smtp-Source: AGHT+IF0zV9T0GAKGhfOz1Lf9+GOom3DPctq/23lmccWbpqeGuIYWYctIlZaOvvj+UFk/ITcfXYYeg==
X-Received: by 2002:a05:6a20:c89c:b0:1d7:7ea:2f35 with SMTP id adf61e73a8af0-1d8bcefde00mr13807132637.5.1728875470378;
        Sun, 13 Oct 2024 20:11:10 -0700 (PDT)
Received: from localhost.localdomain ([39.144.103.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea6e396a71sm2987514a12.73.2024.10.13.20.11.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2024 20:11:09 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 0/4] sched: Fix irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
Date: Mon, 14 Oct 2024 11:10:53 +0800
Message-Id: <20241014031057.8199-1-laoar.shao@gmail.com>
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

 kernel/sched/core.c    | 78 +++++++++++++++++++++++++++++-------------
 kernel/sched/cputime.c | 16 ++++-----
 kernel/sched/psi.c     | 12 ++-----
 kernel/sched/sched.h   |  1 +
 kernel/sched/stats.h   |  7 ++--
 5 files changed, 69 insertions(+), 45 deletions(-)

-- 
2.43.5


