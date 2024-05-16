Return-Path: <cgroups+bounces-2940-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9606D8C7D10
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 21:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD61289505
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362DA15CD56;
	Thu, 16 May 2024 19:08:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711415B99E;
	Thu, 16 May 2024 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886525; cv=none; b=Yz2di///1RJw9n57BWQWxzd1qYRObhiXJvrSX4dLCPD1QD4YOjy6D+VFi2cjOVE2lZ0h1hQoEEh1kWLVko+Pdsuhx3SP4vrLy7P3vT6KCjoLMg+Sd6LYT62PWm0Gvmi0KVs5m797DFMPdMzbUlAxKd6Uel4XlD4v5poB5ZrTB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886525; c=relaxed/simple;
	bh=mX5XKX5uGD9BuklRP06Jpi6evZ3ukENWqzfNye0bnME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNtRMvqNCR7deSi1fPSb0ApRFZZFUBvGuUh/dllE5aTCzxv/u7TIhfpWuyvM9ve8ZMnZ66c3liLkVqvCR3ZORMm2zeG/mrQ+TfnD/WXuCAFUdT22kNhC78unj64lxEzTLEov2rLpkzs9cqkqPDnnHNJGqu2JfdguzTQ+1K8XZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41dc9c83e57so54113525e9.0;
        Thu, 16 May 2024 12:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886522; x=1716491322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XotNX/kdCHfV2cFFrChZaa3s9ogxBqwq0+5YyaOb/CY=;
        b=Iqono8BOiYX4xNHN4rj0W+ofhFH48wDYCvTuX2tbZTPtCx6S/5gF+dKg/jTw1HL1lq
         9lkDOIiia9zS6uCct3F0n4/Ffx4gyNBfaXH5td0fqpPNCrkscCXA0WUkqpREKodEi8MA
         ekcLEkqGZqbdsSeS88SCDDJ6h9olqKJDzclJDrwplb3Jj84b7pBU7v5/UW4ryFeVyR5J
         1FgXh4074Bto5aBbd+iE5dkI/3MMOz7sjJK/7rohEEdlQCtdY7u/gGCMJWqycP2i222T
         v139L9bLv7kdywpcRDRHJaYLcStUuLroCplPdNkZ+zBp0klSI1TwFiglHVa5VpvWUYKK
         ye2g==
X-Forwarded-Encrypted: i=1; AJvYcCVPwadCwevZNU8dWl+s9WIDMCwnJd4pTj21TM7D5iRnR15OBRsgf/vABag8Yefz0aL3H9FG5OBjjn7jD6bn0T769HEdl4wfed+CEsVV4S38TDHVyO+4GR1vwP7wkEwiCqkyuvPWTA==
X-Gm-Message-State: AOJu0YxNwWQXzZ/GbNYHKicnkDbDAVINdtdleoeJsgZRIxPiFkbccgxw
	COZtopjf3wk3PSMzqUMNHxcrnpBZxiKsmHuvDyy1DqrHSS3jf3JT
X-Google-Smtp-Source: AGHT+IEHJzMMlARo96lIKxi6+Ewm9yu9Vst6AigtrNRq0VDU0gIcxCb3LWOI1zcmJsh+fI2VXekGug==
X-Received: by 2002:a05:600c:444e:b0:41b:4caa:554c with SMTP id 5b1f17b1804b1-41fea930c57mr184691415e9.2.1715886521791;
        Thu, 16 May 2024 12:08:41 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c059:8b18:f13e:da9b:5a8e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9335sm275834155e9.29.2024.05.16.12.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:08:41 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	prarit@redhat.com,
	vschneid@redhat.com,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH v1 6/7] [NOT-FOR-MERGE] test timers and hrtimers affinity adjustment
Date: Thu, 16 May 2024 22:04:36 +0300
Message-ID: <20240516190437.3545310-7-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516190437.3545310-1-costa.shul@redhat.com>
References: <20240516190437.3545310-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel module to generate timers and hrtimers for the test
and shell commands.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tests/timers.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 tests/timers.c

diff --git a/tests/timers.c b/tests/timers.c
new file mode 100644
index 0000000000000..bf6ef3244bc05
--- /dev/null
+++ b/tests/timers.c
@@ -0,0 +1,58 @@
+#include <linux/timer.h>
+#include <linux/hrtimer.h>
+#include <linux/module.h>
+
+/*
+ * Testing instructions:
+ *
+ * isolate=1
+ * insmod timers.ko test_cpu=$isolate
+ * cd /sys/fs/cgroup/
+ * echo +cpuset > cgroup.subtree_control
+ * mkdir test
+ * echo isolated > test/cpuset.cpus.partition
+ * echo $isolate > test/cpuset.cpus
+ *
+ * awk "/cpu:/{y=0};/cpu: $isolate\$/{y=1};/ #[0-9]/ && y;" /proc/timer_list \
+ * 	| grep -q test_hrtimer_cb && echo FAIL || echo PASS
+ *
+ * Assure that there is no timers on the isolated cpu.
+ */
+
+static void test_timer_cb(struct timer_list *unused) { }
+
+static struct timer_list test_timer;
+
+static struct hrtimer test_hrtimer;
+
+static enum hrtimer_restart test_hrtimer_cb(struct hrtimer *hr_timer)
+{
+	return HRTIMER_NORESTART;
+}
+
+static int test_cpu = 1;
+module_param(test_cpu, int, 0444);
+
+static int timers_init(void)
+{
+	set_cpus_allowed_ptr(current, cpumask_of(test_cpu));
+	timer_setup(&test_timer, test_timer_cb, TIMER_PINNED);
+	test_timer.expires = KTIME_MAX;
+	add_timer(&test_timer);
+
+	hrtimer_init(&test_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	test_hrtimer.function = test_hrtimer_cb;
+	hrtimer_start(&test_hrtimer, -1, HRTIMER_MODE_REL);
+	return 0;
+}
+
+static void timers_exit(void)
+{
+	del_timer(&test_timer);
+	hrtimer_cancel(&test_hrtimer);
+}
+
+module_init(timers_init);
+module_exit(timers_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.45.0


