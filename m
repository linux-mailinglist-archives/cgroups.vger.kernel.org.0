Return-Path: <cgroups+bounces-3020-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A098D1134
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 02:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9DDB2119C
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 00:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5001CA94;
	Tue, 28 May 2024 00:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBtBabPw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012B17C6A;
	Tue, 28 May 2024 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857819; cv=none; b=uR+OG2xJWrYiB9qPfy0qk+mXHuU3j4I9hAgt3NjZgyTMAzHzpauZXONImIoPeCPbmSRWSY8st/Tjk9QINUc6YvPk8x6qI3efbM9eKBtiJi+BZ4LVIimMyJfcCLF0/m8KQAl4d551D+9HU7BhUlxVhDVUaL1uoDfUhMTkSDmY33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857819; c=relaxed/simple;
	bh=XviXIO66hJ4gYGo+wTqmxQ6eYLtqNAT+9ea+NoAhLJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEgcHXvBID6LkGETY4wei+56AGbB5nlH7XqfJPN7Y55gts9pjC+0x11e+9PhijTlFvr1y5IXCThxgKxZkPj5+7J1y1fMOMFmKA6GulUauBjjbhI1DEM/zSnPhsGZ+On8EieJ8DHNeUu9T+Jk1XTOWJy73xW6sO4a7S3YWcjSpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBtBabPw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62a0849f5a8so2825347b3.2;
        Mon, 27 May 2024 17:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716857817; x=1717462617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHGYk8qXYj5JTpHSzZERaVZ+nE3cg/cmKUns2Hgwu4w=;
        b=mBtBabPwcHHow5qM7+rnmnXOuGMct9bPRB7oHcQwn6bkhKR8cQYZkLRbRAASSdAdIp
         LDn6eE0fmtU7Xpbhk01KfObx+NNOnMMIa9f50AFdU5qGq8IztjdzzKI4FTCjaXYbXbDH
         new4zXe1p/FRUML1Hu77YsONaBlCNEWueSvOeu0QafxuRb/g8z7g10/kF7C831hC6P/V
         BI9476ZmNLrT0ifMrNtP5Ut0oVxhqo9oHcdhP0S808Cp9dyRRNVKHf74VDWT7Ys+CRfW
         FCA9hiPbyiiLcM9os1z140eeJNacfSMi7LVrmUebkrbAw3aERV170an6+dTedjFe2urX
         V67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716857817; x=1717462617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHGYk8qXYj5JTpHSzZERaVZ+nE3cg/cmKUns2Hgwu4w=;
        b=pDQ4VLf7Zf2VReTBj6q73lWSKtL6g8KRCAsgicjWSJvJcxJGwdp/py2onbrvxXcdj3
         xn4na4Cp4ez1i8GGzCrwwyS9fC4nXvF1gdghyv8yOX3QAM3DhKBuFVfYli0Amm9cU5fc
         vj+HK6ftvAyxIeX86VnQB2IF0modVAxTIu7F/6EBOrs6ZoBlDzYF1hRrjMHSju14bmt5
         DM4mWRHycI7VZYfgM5eC6y46dThK5aSiucDb7vAc0hf8siT+xktmqxUzS2OW5fgr74tx
         vqHNE37XZcIsZCrnLfOOyVdCcoE322V6a+z43wASypneTz9YEHdBP+BSSwBw4Jng/yoE
         LgMA==
X-Forwarded-Encrypted: i=1; AJvYcCUqBgd7m1RQlRMiUU2K6cQntA+F1ofruY7LRotfZOn61nn6+KVsozmQRqj3YeTbF78aaY/xMl0IsN9wix/OOcumvz4V5m25lMqKo9GJhDNPZbaB3ChqBM60DyyLYbJoWv4NvQBIF8ugIy7xFW1c7Ia2LrTIueau1czAZykDJDIV/A==
X-Gm-Message-State: AOJu0YyJMuxevMiJZ2zFrqW3WMjhKcWxsGNOniXUrx8GS0WCMPlxuGNk
	1I5HLkQJofUSjmhnOA/UI7E2KmoLebOuuokkj0fzt+f7hOLcNR5zLxhUMQ==
X-Google-Smtp-Source: AGHT+IFQ1Cdt/C4ONuJ8/TbLF7uijtI1itlxg7F6r+jPWRUhsZaJ+tjQCHNvVKklYdjZsrys0pVIkA==
X-Received: by 2002:a81:a052:0:b0:627:dfbd:89f with SMTP id 00721157ae682-62a08d291b9mr102632737b3.6.1716857816951;
        Mon, 27 May 2024 17:56:56 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:35f3:16c3:302:8fdb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a4f0205sm18118607b3.84.2024.05.27.17.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:56:56 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Christoph Lameter <cl@linux.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Dennis Zhou <dennis@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH 5/6] cpumask: cleanup core headers inclusion
Date: Mon, 27 May 2024 17:56:47 -0700
Message-Id: <20240528005648.182376-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240528005648.182376-1-yury.norov@gmail.com>
References: <20240528005648.182376-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many core headers include cpumask.h for nothing. Drop it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cgroup.h      | 1 -
 include/linux/cpu.h         | 1 -
 include/linux/cpu_cooling.h | 1 -
 include/linux/kernel_stat.h | 1 -
 include/linux/node.h        | 1 -
 include/linux/percpu.h      | 1 -
 include/linux/profile.h     | 1 -
 include/linux/rcupdate.h    | 1 -
 include/linux/seq_file.h    | 1 -
 include/linux/tracepoint.h  | 1 -
 10 files changed, 10 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 2150ca60394b..c60ba0ab1462 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -10,7 +10,6 @@
  */
 
 #include <linux/sched.h>
-#include <linux/cpumask.h>
 #include <linux/nodemask.h>
 #include <linux/rculist.h>
 #include <linux/cgroupstats.h>
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 861c3bfc5f17..ea6ac8f98e4a 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -16,7 +16,6 @@
 
 #include <linux/node.h>
 #include <linux/compiler.h>
-#include <linux/cpumask.h>
 #include <linux/cpuhotplug.h>
 #include <linux/cpu_smt.h>
 
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index a3bdc8a98f2c..2c774fb3c091 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -15,7 +15,6 @@
 
 #include <linux/of.h>
 #include <linux/thermal.h>
-#include <linux/cpumask.h>
 
 struct cpufreq_policy;
 
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 9c042c6384bb..b97ce2df376f 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -5,7 +5,6 @@
 #include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
-#include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/vtime.h>
diff --git a/include/linux/node.h b/include/linux/node.h
index dfc004e4bee7..9a881c2208b3 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -16,7 +16,6 @@
 #define _LINUX_NODE_H_
 
 #include <linux/device.h>
-#include <linux/cpumask.h>
 #include <linux/list.h>
 
 /**
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 03053de557cf..4b2047b78b67 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -6,7 +6,6 @@
 #include <linux/mmdebug.h>
 #include <linux/preempt.h>
 #include <linux/smp.h>
-#include <linux/cpumask.h>
 #include <linux/pfn.h>
 #include <linux/init.h>
 #include <linux/cleanup.h>
diff --git a/include/linux/profile.h b/include/linux/profile.h
index 04ae5ebcb637..2fb487f61d12 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -4,7 +4,6 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/cpumask.h>
 #include <linux/cache.h>
 
 #include <asm/errno.h>
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index dfd2399f2cde..fb8ab4618d63 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -29,7 +29,6 @@
 #include <linux/lockdep.h>
 #include <linux/cleanup.h>
 #include <asm/processor.h>
-#include <linux/cpumask.h>
 #include <linux/context_tracking_irq.h>
 
 #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 8bd4fda6e027..2fb266ea69fa 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -7,7 +7,6 @@
 #include <linux/string_helpers.h>
 #include <linux/bug.h>
 #include <linux/mutex.h>
-#include <linux/cpumask.h>
 #include <linux/nodemask.h>
 #include <linux/fs.h>
 #include <linux/cred.h>
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 689b6d71590e..6be396bb4297 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -16,7 +16,6 @@
 #include <linux/srcu.h>
 #include <linux/errno.h>
 #include <linux/types.h>
-#include <linux/cpumask.h>
 #include <linux/rcupdate.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
-- 
2.40.1


