Return-Path: <cgroups+bounces-5057-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AF8993ECB
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 08:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15EF8B22E21
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9831925B2;
	Tue,  8 Oct 2024 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qok8NLyN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DFD190463;
	Tue,  8 Oct 2024 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368530; cv=none; b=rrCuCzUTPGFJB/Bys+ryQT/WlmOWez0dg288S3Lh+bd5S5ez8btD7LgZW4t6k/duZe/RQZ3+vZQwWcCmbmJy+SZuUwONTqZXvTT7wN/iy394+LasMpgppkspVTP8aIrCvhVdYTnrotKAGxxtOkQxspV7WDTUN9ibcoetisB6Wj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368530; c=relaxed/simple;
	bh=8nSP5b1+ZNyYHlfTwMqTfnEnNvzMdDvFDsccjQpUP4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=R4nRomb0Nzz9r4Xcy6qtjlIDjPKEPfG0nkqujdS3Uk8u/SVW6zcSAp+klWcQGYm4D8B+ggrNXOnjDUkxHa9R5k894QrRfBGtID0AAZPIDZzXAAi5vAsWCVzCty1c3L4UdZKUvX6YKP1XIiEr2qXpyQ3ILVHRThzpL3Bzcli50zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qok8NLyN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e09d9f2021so3597338a91.0;
        Mon, 07 Oct 2024 23:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728368528; x=1728973328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeh0b+Dmmhzo7/tunwwSxWKU97HNxUDAlAsTauMuOFY=;
        b=Qok8NLyNQ0eqS9Ga5Rmbn2a30/MsyczsvgTNFKzKJ0uZq22GnNsaduhDlaqsNn8cwK
         xG3K63vs0LXWx9UEJpKEHE9EzJY5T/nJGDnzcJqG7ikMQ60scH8NYa9W+INIDM8F8tJn
         XOKonmpdu+fR83FCWidad61pPEZgZxJ1GnixgezJlyymtyh6oncQEisLaLtxXnGy0BO2
         qIRDwnl5uKr4lU9HF4cV3nud8e89qT9Wdm/FmmS6NMruOBNkF+KjmS1tT5ERcgbYPP2g
         EUUTDWZ70U4GIkD2uo+hJLh6HubP6j6wdJABi4CRFez+w+aa77Ukd3lAvBqdHuVQ2UFM
         kRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728368528; x=1728973328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeh0b+Dmmhzo7/tunwwSxWKU97HNxUDAlAsTauMuOFY=;
        b=rcRsbHk/IYpbfxUXQQPn6LmOJIaNF+L1ADznpYClfD5E29LC73CXRENSrhkRI3u6SM
         HkIk2zW9cm1d63r0d3GTaPFWxMSAvTPvPGmLM2nU3X9TxvKbD5l5RB0V++ieI5v5JUYQ
         LFRIjSAoeoEABAbijYdzd8J0El43+ddLXWxGY0qwv2pF4rikOi4Iy9+B9eawWuJoezb4
         wZjP+Su7pi6i1++211jrT6eZLxgRs2rgsdSCrO3E30B+cmfWkGyi5em8EUhG76fb7SKE
         YfDv5kYX3WrgvVhaCjutxi5MSDnetNevhYCOyLj7AknGQUxHQxvxA/Xzo1j2uT2Ga0Ie
         eVIw==
X-Forwarded-Encrypted: i=1; AJvYcCWZtin6YXYmsTWIgIh8j30IdBb9PdNAmZneFdRQ18Eg2jqKnxVlel2MPs3gK64olCLT1+XzN0kJViJ/cbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWe02IrrUtoGPGpVCmrgmW30RNzDunCoBfeJyv8TN/3H8nwk3
	Y3ueZt8Ce5II1T3SgYr2/X3i+54KA7Ti6v35CqvoB9AT8Q2DR0EQ
X-Google-Smtp-Source: AGHT+IGYgsYQTMreRjM6KayMBYkE0555aZfh6SRGfg+1lfxwNoGQqGSBRXYh4lHUVcLwXF26ATb2GA==
X-Received: by 2002:a17:90a:ca06:b0:2d8:7a1c:b7e2 with SMTP id 98e67ed59e1d1-2e1e636c81bmr15980677a91.35.1728368527565;
        Mon, 07 Oct 2024 23:22:07 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85c8fd1sm8357525a91.18.2024.10.07.23.21.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:22:06 -0700 (PDT)
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
Subject: [PATCH v2 0/4] sched: Fix irq accounting for CONFIG_IRQ_TIME_ACCOUNTING 
Date: Tue,  8 Oct 2024 14:19:47 +0800
Message-Id: <20241008061951.3980-1-laoar.shao@gmail.com>
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
v1->v2: 
- Fix lockdep issues reported by kernel test robot <oliver.sang@intel.com> 

v1: https://lore.kernel.org/all/20240923090028.16368-1-laoar.shao@gmail.com/

Yafang Shao (4):
  sched: Define sched_clock_irqtime as static key
  sched: Don't account irq time if sched_clock_irqtime is disabled
  sched, psi: Don't account irq time if sched_clock_irqtime is disabled
  sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING

 kernel/sched/core.c    | 83 ++++++++++++++++++++++++++++++------------
 kernel/sched/cputime.c | 16 ++++----
 kernel/sched/psi.c     | 12 +-----
 kernel/sched/sched.h   |  1 +
 kernel/sched/stats.h   |  7 ++--
 5 files changed, 74 insertions(+), 45 deletions(-)

-- 
2.43.5


