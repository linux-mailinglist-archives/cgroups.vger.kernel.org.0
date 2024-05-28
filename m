Return-Path: <cgroups+bounces-3021-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B098D1136
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 02:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7D91C21152
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 00:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AD3224D5;
	Tue, 28 May 2024 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8g0INEd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0651BC4B;
	Tue, 28 May 2024 00:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857820; cv=none; b=heOylbyrfzD+cZIyHV6LJQJq945vax/Q1QZFz2/5nwhGSwBPTHh5Oia6D+I0k1/dICBEbAA3A4K/OuL4flwZlt3awJgRIjOKFlRV9D71M2/mBEIm8yx6HeHnjCJZwnCvA/lonCTcjKEBnt7MKgtN3WanlaVecSmU9w2JyAOpALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857820; c=relaxed/simple;
	bh=sWIoYtsUMpM3ixzhSRVT07SQRSC0eL+p3JdrB0m3TyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MqaD0oOj6LJkhvDHgADvqbjxPgi3LLUjmYlrsYU5CMoB8DZhJu9WLpgAvo2ydejBzg+vemLxCtKWFApYfaK4+97xSTWRaFpIYES0MfTEj2jahERyH1sBEq0x96oFd+rAjspHhOCxBzdt9NsG6I4OeF6gQddOrJATYwwr2hiixd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8g0INEd; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62a0894f1d3so23278277b3.1;
        Mon, 27 May 2024 17:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716857818; x=1717462618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UsAL9kPP63kEGxLShGtp1xElrDmM28x7Y9xy2z/xj0=;
        b=S8g0INEdyz0scI3ChWNsSue2p/ArUZgMDOfvBUrPlcGjyR7Vs2oQST6BgylQ+BSfff
         qnil1lZcG5J4jo51nU9aNP2mlvXJeRNvBEKSV7vYIxZfRHkHAVVKLnll4QY5w0P4iAit
         FSANcbxqVrKUo1W/eV6NZG+3qV0pLGCtzozS+salCb6DiDYAdugT/Wxg6udu48nWWqHM
         izLL0wC3OIW8kXVVIr/xQHHuQyczz/v1TKA2rcn0DLfWeKb+e4W2ov39994+RRnP8S41
         cS4uLsrKZ/j5uCsmm8+WcSOvchqgWeG4YWO4TpKsuIhDnDTSshpSsAeASl6UQQjdXUUI
         kSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716857818; x=1717462618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UsAL9kPP63kEGxLShGtp1xElrDmM28x7Y9xy2z/xj0=;
        b=sslYdfc5IbRJzSSxK1A61BbmU6Pwe8bcQa0Mal1uJnRYH/pc7+bV1AB0f1op2IKjcK
         G8i1RZoeiUlc8xnqd8PcvaNtwy9DBkr3utzY6Sl6TrMtsAjRhBjPq2yOgkVbbzoDJbya
         B8z5IthoAcI577FQNBHpiKWdhVqico8fC06ihDY5Fyk+4vA47FdvuSkrgOnTx/INJlsK
         M4DttMs7Y0rzJY3jh6AGuuHU46GFl0xCrI28VYCWK3eC1PVKRhXCM76efY8TSIc9k4rs
         fFp/wtf2JH3jGSBPUuju7DUsV2w1zXjRHr1VZR2iTRZ8+UKMUeTCIMA5hk26SREPbnhr
         IH/w==
X-Forwarded-Encrypted: i=1; AJvYcCVvFbqaT2fyAnG084G2aji+fAjaOByyktf1AcD5G2UXezjb7W2v/SqPdFtZKepRNw9vPNoAbyOaQh9Bh+5HmPnRjcorTynycY0ZX29oVN8VyvDyrAe/TUsPkUWcuBH1bFjeRCv7HIJ3NP/oBB4OWgUl/0NGPf/ORByX3rHZIZlYZw==
X-Gm-Message-State: AOJu0YwMlk5ozH0FlTQu5vY5ZSRgiU1obKUAmHKMC8MhXhfERhDR15io
	5KLQoYUYVKxX/LIwUvb/zjW+JWIungfm7TrYEWC5+6sOYLogiViPXwLZ0w==
X-Google-Smtp-Source: AGHT+IGmR0W63RWXP7J3rcUruY8CccOWbM2LLUmmQW5FfR5dztBstUyu6LsVEmByl5i5yf2pTBs2EQ==
X-Received: by 2002:a05:690c:c99:b0:618:88d1:f15f with SMTP id 00721157ae682-627fb1ca4c5mr105219357b3.0.1716857818158;
        Mon, 27 May 2024 17:56:58 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:35f3:16c3:302:8fdb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a3bf743sm18246387b3.40.2024.05.27.17.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:56:57 -0700 (PDT)
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
Subject: [PATCH 6/6] cpumask: make core headers including cpumask_types.h where possible
Date: Mon, 27 May 2024 17:56:48 -0700
Message-Id: <20240528005648.182376-7-yury.norov@gmail.com>
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

Now that cpumask types are split out to a separate smaller header, many
frequently included core headers may switch to using it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cacheinfo.h                    | 2 +-
 include/linux/clockchips.h                   | 2 +-
 include/linux/cpu_rmap.h                     | 2 +-
 include/linux/interrupt.h                    | 2 +-
 include/linux/irqchip/irq-partition-percpu.h | 2 +-
 include/linux/msi.h                          | 2 +-
 include/linux/pm_domain.h                    | 2 +-
 include/linux/stop_machine.h                 | 2 +-
 include/linux/torture.h                      | 2 +-
 include/linux/workqueue.h                    | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 2cb15fe4fe12..286db104e054 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -3,7 +3,7 @@
 #define _LINUX_CACHEINFO_H
 
 #include <linux/bitops.h>
-#include <linux/cpumask.h>
+#include <linux/cpumask_types.h>
 #include <linux/smp.h>
 
 struct device_node;
diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 9aac31d856f3..b0df28ddd394 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -12,7 +12,7 @@
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 # include <linux/clocksource.h>
-# include <linux/cpumask.h>
+# include <linux/cpumask_types.h>
 # include <linux/ktime.h>
 # include <linux/notifier.h>
 
diff --git a/include/linux/cpu_rmap.h b/include/linux/cpu_rmap.h
index cae324d10965..20b5729903d7 100644
--- a/include/linux/cpu_rmap.h
+++ b/include/linux/cpu_rmap.h
@@ -7,7 +7,7 @@
  * Copyright 2011 Solarflare Communications Inc.
  */
 
-#include <linux/cpumask.h>
+#include <linux/cpumask_types.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/kref.h>
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5c9bdd3ffccc..da88261f4748 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -5,7 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/bitops.h>
-#include <linux/cpumask.h>
+#include <linux/cpumask_types.h>
 #include <linux/irqreturn.h>
 #include <linux/irqnr.h>
 #include <linux/hardirq.h>
diff --git a/include/linux/irqchip/irq-partition-percpu.h b/include/linux/irqchip/irq-partition-percpu.h
index 2f6ae7551748..b35ee22c278f 100644
--- a/include/linux/irqchip/irq-partition-percpu.h
+++ b/include/linux/irqchip/irq-partition-percpu.h
@@ -8,7 +8,7 @@
 #define __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H
 
 #include <linux/fwnode.h>
-#include <linux/cpumask.h>
+#include <linux/cpumask_types.h>
 #include <linux/irqdomain.h>
 
 struct partition_affinity {
diff --git a/include/linux/msi.h b/include/linux/msi.h
index dc27cf3903d5..26588da88bdd 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -19,7 +19,7 @@
  */
 
 #include <linux/irqdomain_defs.h>
-#include <linux/cpumask.h>
+#include <linux/cpumask_types.h>
 #include <linux/msi_api.h>
 #include <linux/xarray.h>
 #include <linux/mutex.h>
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f24546a3d3db..71e4f0fb8867 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -16,7 +16,7 @@
 #include <linux/of.h>
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
-#include <linux/cpumask.h>
+#include <linux/cpumask_types.h>
 #include <linux/time64.h>
 
 /*
diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index ea7a74ea7389..3132262a404d 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -3,7 +3,7 @@
 #define _LINUX_STOP_MACHINE
 
 #include <linux/cpu.h>
-#include <linux/cpumask.h>
+#include <linux/cpumask_types.h>
 #include <linux/smp.h>
 #include <linux/list.h>
 
diff --git a/include/linux/torture.h b/include/linux/torture.h
index 1541454da03e..c2e979f82f8d 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -14,7 +14,7 @@
 #include <linux/cache.h>
 #include <linux/spinlock.h>
 #include <linux/threads.h>
-#include <linux/cpumask.h>
+#include <linux/cpumask_types.h>
 #include <linux/seqlock.h>
 #include <linux/lockdep.h>
 #include <linux/completion.h>
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index fb3993894536..52496f07fba5 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -12,7 +12,7 @@
 #include <linux/lockdep.h>
 #include <linux/threads.h>
 #include <linux/atomic.h>
-#include <linux/cpumask.h>
+#include <linux/cpumask_types.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue_types.h>
 
-- 
2.40.1


