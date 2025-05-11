Return-Path: <cgroups+bounces-8129-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD3BAB264E
	for <lists+cgroups@lfdr.de>; Sun, 11 May 2025 05:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E209A7A4D3F
	for <lists+cgroups@lfdr.de>; Sun, 11 May 2025 03:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE98817A300;
	Sun, 11 May 2025 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeKj45kc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B63F1487D1;
	Sun, 11 May 2025 03:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746932919; cv=none; b=tYFb/KO+q9Yq2ZY7C1IBLfzunX85OgT9OekGCGt/JOy7SAIgwSTGV+Sz4mr/ZBahw8FWqYZxeNhKCztabn9ER21GVKXJuPJUP1jM3bTFq7NjEDz4tUTpGZm6tiZ8MU+Kzv6UXR/KqCVva9cfkGMOIkzVKpA/gy85RMLeeNaFbZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746932919; c=relaxed/simple;
	bh=r+vkn0eEIdcMigpTHj0eqKwWUdStj46jhNQGLfY2V9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M1nPLPi55cI37/mb7+HkF57L8QKtxrWiqVQSuCtHDcQu5td3jvxoFLhtua0xHDjP3GpylZ4CgOcszslTy/fqjOLwrpOUmhO/cNQeL5tEhsigqi76drhS0iLmMpoZrBG4QpCgH9b3+KJM5d0jGFBix+yIGaxeja0x6KWbkoqJMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeKj45kc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso4474073b3a.2;
        Sat, 10 May 2025 20:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746932917; x=1747537717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lTKKd7diRQJTYNbFHCqlVfIA24BlZl71qqXWQO/K1A=;
        b=FeKj45kcZSghynZBIji2xbK2Jjg3Q1Rs8qh/wsueYTEoM+/MTKYlE6H9406UvEws5Q
         +mdQxFshaOhMUeHZIB6j7CY7XhICYYFtW7Vqdq7IPyNr1XdqS+jeR7AtqQnMmhhOnxJJ
         GRwsNuJMdD6wRYWD0F1F7vcKOvVQ0ykE/o9ShI9y67rmKRnQiCENDw47GkdOpOemIN3k
         hC9Y9YsBvGLPsDK4aLMma9BE4iLM/yx2wMbeYZgIAo9lt+X1jsubsXQiCXMMbN/nyavq
         bgEgOCrpWqRa+NmKAq3grrforwLbLdbaH8+thAYtJ8Cd8JzIeL1rnegm2lw3rKf9NTTO
         7MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746932917; x=1747537717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lTKKd7diRQJTYNbFHCqlVfIA24BlZl71qqXWQO/K1A=;
        b=lnTqqVWFXT1d2HRhM5hZqb5IRyHGgsAaz2erMGNb9g4ViK4PxnJ4Wd3MBpY/3c37us
         BNJvc9fdq6nE1mf/GWj1ZDzY+N0WiBURpG5BmYrdhMt+7utocaf4vlku15/Ut3c6PQNk
         5ULctBy6CuOJ2JGT4HAU7Y/l3Bb+VDJDaYzZNAPRRCPo7QGs8uGGVSrmRkkT+h1LEcjg
         sOl0R1ljCdE4f8BDYCIAiUktjuKo9C9YBD8qpvDviGAlPAqKl8/Y1Vseh0NfndgVq1B7
         yhrZfJD4isPZI/2rqSCOYwjjC1brBQ6ocob/6EmM4FaM9AYHtzozlIcgg2przks2bAVp
         3BAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIGGk+Eo8fukfklvpvfb8k/HrHw8qLQDL6sQeD7ppdYSs/d0WnGmb4z+E4ugUBkgLK0e/KM9VWwRC5byV/@vger.kernel.org, AJvYcCVVDp0J8Qg9GL6KMx5U08FwZe1tUlbQcGjZbB/cWgzeiHl4F2TfYTvUiIaBrnQyeY3voSLbVcHz@vger.kernel.org
X-Gm-Message-State: AOJu0YwsGGCcGEGmD1QpzHgiY+U1tSIZyctRK6i5DFzccug19kgQFC6Q
	IPnCo4c1zUEPvZzrygkJdMNHMSls/EOZeHdTs9TdSZuNeCcfIVDd
X-Gm-Gg: ASbGncstKJMew0UxC/94xDVliwN871nA+QkosKk34k6bj1XlIFnb7Zk7YmSI32d8p7d
	wSKFTe/viih66yTltVYxeInpeU9OHnYeZFmorI43Xaa/pWf2+mzUkBb8YbF34g8Qdokn4UWBKyQ
	ZREnWAzRR6JyZwSbHYOR/QzbN0vCzqbB/KO9dt3d0q+tur9M7K/GGMgDrduPrLrZ3bKfavbUyCF
	TPu8NZaX40Q6kNvvFp7U+l1bHcgoZ5sdVRN10w2kESCHJHwVfDKvxS+nx/qOY5+GVVptN2bQSnN
	X8aZNhSBWGDm229tdiJc4Y6oSpD3QqlijqJ9Og6NKGUr0WtYAN7QVtCN62oBV/mhzH2McBPu3tf
	u
X-Google-Smtp-Source: AGHT+IFA0e+IZ50Drym0CBcMDdhFz1H3piGuyTG0prah5+c2i+dJpAsPtAP72MkkFB/AVs91R+pcPg==
X-Received: by 2002:a05:6a00:2d08:b0:740:67ce:1d8b with SMTP id d2e1a72fcca58-7423bbf68e9mr13179579b3a.7.1746932917339;
        Sat, 10 May 2025 20:08:37 -0700 (PDT)
Received: from localhost.localdomain ([39.144.107.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a105fdsm3956883b3a.100.2025.05.10.20.08.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 May 2025 20:08:36 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	surenb@google.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lkp@intel.com,
	Yafang Shao <laoar.shao@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v9 2/2] sched: Annotate sched_clock_irqtime with __read_mostly
Date: Sun, 11 May 2025 11:08:00 +0800
Message-Id: <20250511030800.1900-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250511030800.1900-1-laoar.shao@gmail.com>
References: <20250511030800.1900-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eric reported an issue [0] as follows,
: rebalance_domains() can attempt to change sched_balance_running
: more than 350,000 times per second on our servers.

: If sched_clock_irqtime and sched_balance_running share the
: same cache line, we see a very high cost on hosts with 480 threads
: dealing with many interrupts.

While the rebalance_domains() issue has been resolved [1], we should
proactively annotate sched_clock_irqtime with __read_mostly to prevent
potential cacheline false sharing. This optimization is particularly
justified since sched_clock_irqtime is only modified during TSC instability
events.

Link: https://lore.kernel.org/all/20250423174634.3009657-1-edumazet@google.com/ [0]
Link: https://lore.kernel.org/all/20250416035823.1846307-1-tim.c.chen@linux.intel.com/ [1]

Reported-by: Eric Dumazet <edumazet@google.com>
Debugged-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
---
 kernel/sched/cputime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 6dab4854c6c0..c499a42ceda4 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -22,7 +22,7 @@
  */
 DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
 
-int sched_clock_irqtime;
+int __read_mostly sched_clock_irqtime;
 
 void enable_sched_clock_irqtime(void)
 {
-- 
2.43.5


