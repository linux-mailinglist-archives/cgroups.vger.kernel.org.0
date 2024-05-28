Return-Path: <cgroups+bounces-3018-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503728D1130
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 02:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D4A281DF5
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 00:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB9F17BCE;
	Tue, 28 May 2024 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9xJIXQY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7173F9DA;
	Tue, 28 May 2024 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857817; cv=none; b=ks/13UClbELNVDAT7v0k/CRcdbSGBJgzPm1xShf1nWy49qeMez1pZryLEGfhrBZhLswy7t82u4Qsq+lPSNbKwfskVP5Eq9iE/RCsvmCA8uQbKKNklfjfyk9jOmbRBgKRXETEJUClcCO/+OElpokHJGR/MvK30HDUorJaAsYOpCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857817; c=relaxed/simple;
	bh=7qVS8UMxVpau1VYoGwb9XSPupJnuEqyN9rb8Est3678=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9GfUjKnd1aB9eI1sh216fEIvfey3l0YfLmAZ0ryAWLZeG9KwP9R6zJ7mNXEMlmOUA5lfe4FuKPx9/Nlacj4MgmAQy6n6lDfDnH6lP7t1HtQPUjz4QpJCkOCB5NIYn+AGqGAbyK6xsREY+0TAacv1t1J5RbhDu4ubh3uUtFbj5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9xJIXQY; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a0894f1d3so23278077b3.1;
        Mon, 27 May 2024 17:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716857815; x=1717462615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnYdPTK2hjdSIrEV7sBehdeTDvZ879lf0pp/n//Br14=;
        b=H9xJIXQYrS4535eHlqyht8GiXHWGuIwjWTFnKps2FS2fnYoaSMteRIwXUkVe3/upIp
         Kxw1ua11A7KgJ5cAX42yIXarjYDL8yb28XlAI/MqVZqKGJM5mOMsVxWqkrE4vBy8KJiK
         ijbddo3sNRSH0+ZM6UFRQ5yXO4h+VXWdkhozC9mL0TDVlwxTYmNfIs9TM3gth82FHMKk
         W9wwjKGv1uLoEuVbEPT7dDHFLAuIm6PaLlmSQkCy0oK7MndwOhN5CNsnfw6QGMPYY6op
         uoaudecc/9ESZAXoIQgwF7vlPU/Xj1KzXfvcMnrmtpB1Y1aFrVPDEOGKCiDTR7uLcxzc
         Z/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716857815; x=1717462615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnYdPTK2hjdSIrEV7sBehdeTDvZ879lf0pp/n//Br14=;
        b=UtyL6l/SuKCYunCFSfpeZW610E5UTJpf8CCbMfAeY3lT72Hv27kbepb5knlCwB4N4p
         0g8bXcdMD/GrRgE5S730Zl++ZF6vubtRyA+z1kZikfKwTyqHpS6uv/2i0bfqIwUY0+A2
         UmdRhjPcD8Z0bkJLsg4eQn7s3thN/kOyTf+Y7dxJkGC/X82i3Xqa/EIlTKJATRB4XFbj
         Pd8Kn9fYDdmtYSSszFuJVIyF1RkQ5RIMVKnrASrEdRmcWrE1DNvI63EkoBnl9OLfNkIB
         Zh5TFtt10gJfZlCiYYd3RqM4dT59F28oSW6y5jwscCMx1bR7mhhBr/QLeUqCn/3W5sq9
         HwJg==
X-Forwarded-Encrypted: i=1; AJvYcCXOkYEkakeG6Fo/WpS7sOpznOPc2x3se9gK8WbKcuqfhsH1UlTYfGw3hK0Z+04FTSFv757ZImpaP/SyN5EsiEPYW87K2omYRZwVlSocZdv4NGBtLYkMBMFa5lNU8YrESVCoJBTnqtMrMyOzNI2Nvax18DS2GZCC5kxzMy5n2DUQJQ==
X-Gm-Message-State: AOJu0YwzVDuKsZeU0yWe1bjgrVdgaKmIg4grzdh4JkcpSJ2lOkIW5Pew
	l70SEqTmnXuvjXP46u5GckEm35PyTSRL3bFBV9ff7P1drrR3ufPYvrz0uw==
X-Google-Smtp-Source: AGHT+IGFLMTRC6NGdZAsWBDoDAamZt9sH7ju82xLanpo1xta++q9GRm1I/nDECPhqHpvKBSqNyQYiA==
X-Received: by 2002:a05:690c:c99:b0:618:88d1:f15f with SMTP id 00721157ae682-627fb1ca4c5mr105218897b3.0.1716857814398;
        Mon, 27 May 2024 17:56:54 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:35f3:16c3:302:8fdb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a52eb60sm18506167b3.112.2024.05.27.17.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:56:54 -0700 (PDT)
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
	Zefan Li <lizefan.x@bytedance.com>,
	Yury Norov <yury.norov@nvidia.com>
Subject: [PATCH 3/6] cpumask: split out include/linux/cpumask_types.h
Date: Mon, 27 May 2024 17:56:45 -0700
Message-Id: <20240528005648.182376-4-yury.norov@gmail.com>
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

From: Yury Norov <yury.norov@nvidia.com>

Many core headers, like sched.h, include cpumask.h mostly for struct cpumask
and cpumask_var_t. Those are frequently used headers and shouldn't pull more
than the bare minimum.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS                   |  1 +
 include/linux/cpumask.h       | 56 +----------------------------
 include/linux/cpumask_types.h | 66 +++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 55 deletions(-)
 create mode 100644 include/linux/cpumask_types.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ae73aaee305..c4fa8f264156 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3731,6 +3731,7 @@ F:	include/linux/bitmap-str.h
 F:	include/linux/bitmap.h
 F:	include/linux/bits.h
 F:	include/linux/cpumask.h
+F:	include/linux/cpumask_types.h
 F:	include/linux/find.h
 F:	include/linux/nodemask.h
 F:	include/linux/nodemask_types.h
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 18410acdbc9e..79262a9ef03b 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -9,25 +9,13 @@
  */
 #include <linux/cleanup.h>
 #include <linux/kernel.h>
-#include <linux/threads.h>
 #include <linux/bitmap.h>
+#include <linux/cpumask_types.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/gfp_types.h>
 #include <linux/numa.h>
 
-/* Don't assign or return these: may not be this big! */
-typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
-
-/**
- * cpumask_bits - get the bits in a cpumask
- * @maskp: the struct cpumask *
- *
- * You should only assume nr_cpu_ids bits of this mask are valid.  This is
- * a macro so it's const-correct.
- */
-#define cpumask_bits(maskp) ((maskp)->bits)
-
 /**
  * cpumask_pr_args - printf args to output a cpumask
  * @maskp: cpumask to be printed
@@ -922,48 +910,7 @@ static inline unsigned int cpumask_size(void)
 	return bitmap_size(large_cpumask_bits);
 }
 
-/*
- * cpumask_var_t: struct cpumask for stack usage.
- *
- * Oh, the wicked games we play!  In order to make kernel coding a
- * little more difficult, we typedef cpumask_var_t to an array or a
- * pointer: doing &mask on an array is a noop, so it still works.
- *
- * i.e.
- *	cpumask_var_t tmpmask;
- *	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
- *		return -ENOMEM;
- *
- *	  ... use 'tmpmask' like a normal struct cpumask * ...
- *
- *	free_cpumask_var(tmpmask);
- *
- *
- * However, one notable exception is there. alloc_cpumask_var() allocates
- * only nr_cpumask_bits bits (in the other hand, real cpumask_t always has
- * NR_CPUS bits). Therefore you don't have to dereference cpumask_var_t.
- *
- *	cpumask_var_t tmpmask;
- *	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
- *		return -ENOMEM;
- *
- *	var = *tmpmask;
- *
- * This code makes NR_CPUS length memcopy and brings to a memory corruption.
- * cpumask_copy() provide safe copy functionality.
- *
- * Note that there is another evil here: If you define a cpumask_var_t
- * as a percpu variable then the way to obtain the address of the cpumask
- * structure differently influences what this_cpu_* operation needs to be
- * used. Please use this_cpu_cpumask_var_t in those cases. The direct use
- * of this_cpu_ptr() or this_cpu_read() will lead to failures when the
- * other type of cpumask_var_t implementation is configured.
- *
- * Please also note that __cpumask_var_read_mostly can be used to declare
- * a cpumask_var_t variable itself (not its content) as read mostly.
- */
 #ifdef CONFIG_CPUMASK_OFFSTACK
-typedef struct cpumask *cpumask_var_t;
 
 #define this_cpu_cpumask_var_ptr(x)	this_cpu_read(x)
 #define __cpumask_var_read_mostly	__read_mostly
@@ -1010,7 +957,6 @@ static inline bool cpumask_available(cpumask_var_t mask)
 }
 
 #else
-typedef struct cpumask cpumask_var_t[1];
 
 #define this_cpu_cpumask_var_ptr(x) this_cpu_ptr(x)
 #define __cpumask_var_read_mostly
diff --git a/include/linux/cpumask_types.h b/include/linux/cpumask_types.h
new file mode 100644
index 000000000000..461ed1b6bcdb
--- /dev/null
+++ b/include/linux/cpumask_types.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_CPUMASK_TYPES_H
+#define __LINUX_CPUMASK_TYPES_H
+
+#include <linux/bitops.h>
+#include <linux/threads.h>
+
+/* Don't assign or return these: may not be this big! */
+typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
+
+/**
+ * cpumask_bits - get the bits in a cpumask
+ * @maskp: the struct cpumask *
+ *
+ * You should only assume nr_cpu_ids bits of this mask are valid.  This is
+ * a macro so it's const-correct.
+ */
+#define cpumask_bits(maskp) ((maskp)->bits)
+
+/*
+ * cpumask_var_t: struct cpumask for stack usage.
+ *
+ * Oh, the wicked games we play!  In order to make kernel coding a
+ * little more difficult, we typedef cpumask_var_t to an array or a
+ * pointer: doing &mask on an array is a noop, so it still works.
+ *
+ * i.e.
+ *	cpumask_var_t tmpmask;
+ *	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
+ *		return -ENOMEM;
+ *
+ *	  ... use 'tmpmask' like a normal struct cpumask * ...
+ *
+ *	free_cpumask_var(tmpmask);
+ *
+ *
+ * However, one notable exception is there. alloc_cpumask_var() allocates
+ * only nr_cpumask_bits bits (in the other hand, real cpumask_t always has
+ * NR_CPUS bits). Therefore you don't have to dereference cpumask_var_t.
+ *
+ *	cpumask_var_t tmpmask;
+ *	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
+ *		return -ENOMEM;
+ *
+ *	var = *tmpmask;
+ *
+ * This code makes NR_CPUS length memcopy and brings to a memory corruption.
+ * cpumask_copy() provide safe copy functionality.
+ *
+ * Note that there is another evil here: If you define a cpumask_var_t
+ * as a percpu variable then the way to obtain the address of the cpumask
+ * structure differently influences what this_cpu_* operation needs to be
+ * used. Please use this_cpu_cpumask_var_t in those cases. The direct use
+ * of this_cpu_ptr() or this_cpu_read() will lead to failures when the
+ * other type of cpumask_var_t implementation is configured.
+ *
+ * Please also note that __cpumask_var_read_mostly can be used to declare
+ * a cpumask_var_t variable itself (not its content) as read mostly.
+ */
+#ifdef CONFIG_CPUMASK_OFFSTACK
+typedef struct cpumask *cpumask_var_t;
+#else
+typedef struct cpumask cpumask_var_t[1];
+#endif /* CONFIG_CPUMASK_OFFSTACK */
+
+#endif /* __LINUX_CPUMASK_TYPES_H */
-- 
2.40.1


