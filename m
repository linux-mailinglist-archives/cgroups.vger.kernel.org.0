Return-Path: <cgroups+bounces-3019-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D208D1131
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 02:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1EE3B20D9B
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 00:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222CF182B3;
	Tue, 28 May 2024 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzMXiKjs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8368D13FEE;
	Tue, 28 May 2024 00:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857817; cv=none; b=sgSMirTudUBxRD0Y3as0LUX98JFFEsH+lhsiEWDOHvJNuJlqz+Pw3bvvs3j3ftjAOi3+zsdSUIYqGLnlPJ8S+M5pRUiBGz4vyUwbYI6pemaTf90ddDtCohINmH76SHy3YNJnMTWke45vnKwUwkVHC+8jqYAwcp9uA7OIMKQxQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857817; c=relaxed/simple;
	bh=GtclWTy0ASRdAy3fBHQ5+Eg7GjfSLLlKIztDtP6lJnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qGhw3H2N/YCbXsjmJW8f4xlzv2Ptx+7/zcugc2YWKl9GPTOwYzdC7SHLGqjJJgtdeIBII8v0mN7d0tQC5ULiptaJ/jNFXYBSgNq9x5rtaCdUjL/KhxvJxBM1c0YBByWCzKe2H9XhfmesDKGCfZk13hOSf5lnpxn4G6wuS/qMK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzMXiKjs; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-627ebbe7720so2391647b3.0;
        Mon, 27 May 2024 17:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716857815; x=1717462615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKPhButNX8xjaR4Wjw1GyI4VB8TnS9vBdoFs31kcATQ=;
        b=XzMXiKjs/sd5joDlv+Jz2ejVs/1QPbnGCWbrUPSWnxDfZHMjqh7orYvZRVCgQOSqsn
         SrpjVdF0C5YPQ26AbuFJGn2OSrGMu3Sjuh5QbcdR+EEQTuG9PAlpKPak2PThmsiiKUkW
         cpPo275UawTg9z5IUigkk08bQyDe/vJXp7crFRZUsXaKhQTcg/XU1dClaNczPH5iJbt7
         cqPxtU0YOdIWVzyWQ+OAbu6NRPgDyW7uD2JvaxrXsRc33vl0DuYfRKHaY9BEGKYvr9YQ
         FxLJnDwJ068sAVpaGl9j0KYpgenGd1niPPyILP9zkuwUvzykvQl4aoMwEaTi1yroDQW0
         g8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716857815; x=1717462615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKPhButNX8xjaR4Wjw1GyI4VB8TnS9vBdoFs31kcATQ=;
        b=tMIjfVPC6+bBC4QSJNnuY5Fzx30m5Zo/RCdvQgiWFS3M3fGnuhBb0m0hrl6QKb/rfk
         5Jz/71kHXPnO4OqVCnnNmGemg5xqFpuNYUjAZECAgLmcS836/QJQI0mJvBvMBxZRQexb
         chpoxw9s60MRVJ2aMMXGgPvd/AsobqNuuZvHjv/Q16khfFtKxk0phQrFZjWpHbNn7f1D
         Lp93hETqYvPGB7mSQhG7Ld3dckkR16MXzZwO0fBPhOm4rQr1LNAwxJCQZmIWtu974h6K
         dSVQ0pWpx3Ua4qpFr4HtQGBi59oYQ4THvbqMab+pt+1qx+zbsnXElquDt5KjNsI1IDLz
         TNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl3unwSWP5T1KpnaytybtsKVw987TJRSPu+PeoDRo0OpNLXhGsOHgUbmVYUYZtrT5aqAJiEMJlzqKsDDJ/E7vzJRcVzjUGauqHxgJ42Bo8zKOPDVF8Z61xgkR9Y05l7UiLMLTkhJmwnrjC0PH35DcAYTPIfrBn9JH8XwdndbIEgw==
X-Gm-Message-State: AOJu0YwzppLrp2snMCZSo4adelAfgcUGK7sj+0gJ9N6SZAp7d+ag4ES5
	be/rP9+CbDeuKFdOx9Um8+c2/e8I/2km2SzWyo3YeA0/8OUveMHcCFuXlA==
X-Google-Smtp-Source: AGHT+IFe5hc0HMbIYKV8GGca2K7UFivtrv6cj+FsXeO4rccoRk4EjlKGQ1bt+Bu1VPRdc4g49tpZhw==
X-Received: by 2002:a0d:dfc9:0:b0:61b:3346:83ce with SMTP id 00721157ae682-62a08d83a1bmr114507497b3.15.1716857815579;
        Mon, 27 May 2024 17:56:55 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:35f3:16c3:302:8fdb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a534cf7sm18415697b3.115.2024.05.27.17.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:56:55 -0700 (PDT)
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
Subject: [PATCH 4/6] sched: drop sched.h dependency on cpumask
Date: Mon, 27 May 2024 17:56:46 -0700
Message-Id: <20240528005648.182376-5-yury.norov@gmail.com>
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

sched.h needs cpumask.h mostly for types declaration. Now that we have
cpumask_types.h, which is a significantly smaller header, we can rely on
it.

The only exception is UP stub for set_cpus_allowed_ptr(). The function
needs to test bit #0 in a @new_mask, which can be trivially opencoded.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/sched.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 98abb07de149..f2f907ef1389 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -13,7 +13,7 @@
 #include <asm/processor.h>
 #include <linux/thread_info.h>
 #include <linux/preempt.h>
-#include <linux/cpumask.h>
+#include <linux/cpumask_types.h>
 
 #include <linux/cache.h>
 #include <linux/irqflags_types.h>
@@ -1778,7 +1778,8 @@ static inline void do_set_cpus_allowed(struct task_struct *p, const struct cpuma
 }
 static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
-	if (!cpumask_test_cpu(0, new_mask))
+	/* Opencoded cpumask_test_cpu(0, new_mask) to avoid dependency on cpumask.h */
+	if ((*cpumask_bits(new_mask) & 1) == 0)
 		return -EINVAL;
 	return 0;
 }
-- 
2.40.1


