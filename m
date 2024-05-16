Return-Path: <cgroups+bounces-2941-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4A08C7D12
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 21:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D662897FA
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 19:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383415CD63;
	Thu, 16 May 2024 19:09:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560115B98F;
	Thu, 16 May 2024 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886544; cv=none; b=p6CViOusHAUtJIoERw3w4CDlbsWgDYnDfv8Ulj/3TglabjP2dTAkXoqKJUs5Otpfc3X82VoufzvkeZH/9EFsNS9aaX5Q27Z/OPI2dB9Q2byPi8v6zGG3HeF/+2vEa/27I63vNRmLt2jAtFbJXXDKjHn6LXJdqrl5aYqJPIDIA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886544; c=relaxed/simple;
	bh=07edSisiBn7OLTKr0n/HQrCmFHqhyjayvCzG4MBk1co=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3uXNupS305fTYTjGjE+8S5PWYh1BipS1PDApKcJcgl/3SvmtPKLFQtkXWnZ3Ut8xD23XpTN8EwGDahlNuS10gdzUdbQUneQrBkOQ9xFxnuK6r/Nr6ZxC6YLTx4nGMhD03C+sAeDEBbwHNZavT7XOZnlWHpdJMMupuoAyNf1CGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-351b683f2d8so4105982f8f.3;
        Thu, 16 May 2024 12:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886541; x=1716491341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnTr9MgTMJe8htLM4f6S5S5Y/Ex6cH3hfBLm9DbMXbA=;
        b=pomh7jhJIardVGFaumuvR+325WWYowmIV3adinsNP5tYpDnMQs4xjXOxsV3EuhjH76
         6D68X+i3cd7Z9/0MsOfjfRmKBtjum/pxPgT6T8dPbWg48FxsCwyhqGoPx81WluV6xVmn
         Urj6ER33v0jL70rdt8CB+yiSrpIXOQFuLFlhR6sqAVvaUFjqMmD3Fp9UNTk1xPRzEd2i
         Gjo1Qj9iS+YsexBcIdXbOk0nKsmkN9CrJGSpe6VenD+A1l1MadjZJba7iRnS3HQanK4G
         gPVXw1+S3p4UMuCfqMdJRVebQB1aTcHULuYSfML2MI8SE58gGSwXHoFIVQXML4S6jpKS
         yg7g==
X-Forwarded-Encrypted: i=1; AJvYcCV5tcrKmjpBXU5h0DDhONA5K9dhDSLAT7ulo5S8dPh3IvsG5f3QuDwmm7QQqCF8QmzX44s0e1Me9rl4YPGzx9MFSFahi4GEqqP+cxJdUdFLqYl5ggS/R2mzra+JzMgDYs3+L99R8Q==
X-Gm-Message-State: AOJu0YzG/QbFxZu1wPRoaE8RCVKBJghpUL86aSAHbzo9tulu2UnPVtZc
	C1k4JCp9k2bRhuJVTHjGpAXK09UGNJpOVlyjLxvjY/s27zKdAGu0
X-Google-Smtp-Source: AGHT+IFK3GSP40UD39yI3Aobu4yEnUNOsOHY60xfP7RZSLR2L9IqYRFymtYAVvWRhTk4Oo2cGl022g==
X-Received: by 2002:a05:600c:19c8:b0:41f:e2c5:6618 with SMTP id 5b1f17b1804b1-41feac5512amr145661405e9.32.1715886541644;
        Thu, 16 May 2024 12:09:01 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c059:8b18:f13e:da9b:5a8e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9335sm275834155e9.29.2024.05.16.12.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:09:01 -0700 (PDT)
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
Subject: [PATCH v1 7/7] [NOT-FOR-MERGE] test managed irqs affinity adjustment
Date: Thu, 16 May 2024 22:04:37 +0300
Message-ID: <20240516190437.3545310-8-costa.shul@redhat.com>
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

Kernel module to generatemanaged irqs for the test
and shell commands.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tests/managed_irq.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 tests/managed_irq.c

diff --git a/tests/managed_irq.c b/tests/managed_irq.c
new file mode 100644
index 0000000000000..fd4e91e44e59d
--- /dev/null
+++ b/tests/managed_irq.c
@@ -0,0 +1,71 @@
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+
+/*
+ * Testing instructions:
+ *
+ * isolate=1
+ * insmod managed_irq.ko test_cpu=$isolate
+ * cd /sys/fs/cgroup/
+ * echo +cpuset > cgroup.subtree_control
+ * mkdir test
+ * echo isolated > test/cpuset.cpus.partition
+ * echo $isolate > test/cpuset.cpus
+ * read test_irq < /sys/module/managed_irq/parameters/test_irq
+ *
+ * cat /proc/irq/$test_irq/smp_affinity_list
+ *
+ * read affinity < /proc/irq/$test_irq/smp_affinity
+ * test 0 -ne $((0x$affinity & 1 << $isolate)) && echo FAIL | PASS
+ *
+ * Assure that irq affinity doesn't contain isolated cpu.
+ */
+
+static int test_cpu = 1;
+module_param(test_cpu, int, 0444);
+
+static int test_irq;
+module_param(test_irq, int, 0444);
+
+static irqreturn_t test_irq_cb(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
+static int test_set_affinity(struct irq_data *d, const struct cpumask *m, bool f)
+{
+	irq_data_update_effective_affinity(d, m);
+	return 0;
+}
+
+static int make_test_irq(void)
+{
+	struct irq_affinity_desc a = {
+		mask: *cpumask_of(test_cpu),
+		is_managed: true
+	};
+	int test_irq = __irq_alloc_descs(-1, 1, 1, 0, THIS_MODULE, &a);
+	static struct irq_chip test_chip = { .irq_set_affinity =
+						     test_set_affinity };
+
+	irq_set_chip(test_irq, &test_chip);
+	irq_set_status_flags(test_irq, IRQ_MOVE_PCNTXT);
+	pr_debug("test_irq=%d\n", test_irq);
+	int err = request_irq(test_irq, test_irq_cb, 0, "test_affinity", 0);
+
+	if (err)
+		pr_err("%d\n", err);
+
+	return test_irq;
+}
+
+static int managed_irq_init(void)
+{
+	test_irq = make_test_irq();
+	return 0;
+}
+
+module_init(managed_irq_init);
+
+MODULE_LICENSE("GPL");
-- 
2.45.0


