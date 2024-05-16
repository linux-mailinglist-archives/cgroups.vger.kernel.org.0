Return-Path: <cgroups+bounces-2937-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887938C7D0A
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 21:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAED5B25821
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 19:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9FB15B127;
	Thu, 16 May 2024 19:08:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8915B122;
	Thu, 16 May 2024 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886503; cv=none; b=iuGlpkeypLCJJYbsft7SYjYqLJic3dZ5Z2tKib7CXWnlxxcxp87ytsWEtClMdc/io+KSpmrCApbnA6sI722cTL/9pGEQNQfToHke2c3RCjPCiexEx6ZwqTyRS0vTMj+ZZU24fBfk7DucCnsMhC8bilDEK/o9c54nX0Fi8Gu0n+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886503; c=relaxed/simple;
	bh=BBuLJN0RtiuFgr6SaE8THENmcUL4dkXcdDEVIERoegA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWfVEGrAx41lbmPaTRfycwnuGunBajeCjx7/n5sUaRC0XX5FCyw7/iI51jskZONUBFeMDNlgMT/rJaYBHW6d6pPjhhTDeZ/O4xZ5OHsBg8WpH0OZ4+30eOtUmty/a4p+ECSVuuhiVrMrzLedNsdVwEgr1ytyYN8ff9qkACyL3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42011507a54so35038485e9.0;
        Thu, 16 May 2024 12:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886500; x=1716491300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/chxMa/Gj7pZdtme6fcFfNNAAL7xcfxQRHCvbZqZis=;
        b=Hma7euspQapO5/MKrO/nD8tImvJPvPwg7UdoEgaLXxVIt6FWqT5QITYGRSJgeG7llL
         M8OE43C/wErfBFkDaQZ5Ebk6YWVDxtZSuw+z3h7cF/BDVxHjD19I4eK1VLx4otw0SWVB
         7+asPNzi3+L9KanaFtKAcOvm4MtIyKDHAjO0gD1qIcL1gyMwxoMTY6HMr13TT38jLyzK
         FEOIo2UJY9s7HJkLFeyYPfF2fVuUwTuuIzto90EnF9Jr4KkYFg457E4eDvfTkEqZDPLe
         c5QyGY7BnqDTVB7LDchvsVTTBNFfASO7pvfF9/whkzXSd2yllTajO13gsL1duLTenmfU
         U2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVluWRIUZNHP6+9EC4dlFDD4Ht14piODvv7epQGsJtB7pvCYawc195BrC7nd6q0ZVcwX/pq9+j4U2uIYeCwzySObnX8/9GnYBGIcY4FEJxrHgl+GgVZs3PBs5ph8kDX7lRSrPUXZw==
X-Gm-Message-State: AOJu0YyloG4LM+UkU8VfFw+j3+A8kslDSLzCKm0Ue+xA1iX/r4rC0jI4
	Z5ahjlchoXfKK/Nz8HecDsg9SX29QOWhKS3GLN/XBlPs5E2NNAnl
X-Google-Smtp-Source: AGHT+IGNLSvubANeOQQYk+X3W8EbGSGRZaIgIySYagFEURDMRefDIO8fjJUDwgdX420RuIqYEoAEwg==
X-Received: by 2002:a05:600c:474b:b0:41c:13f6:1ee1 with SMTP id 5b1f17b1804b1-41fea930c73mr192345865e9.4.1715886499933;
        Thu, 16 May 2024 12:08:19 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c059:8b18:f13e:da9b:5a8e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9335sm275834155e9.29.2024.05.16.12.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:08:19 -0700 (PDT)
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
Subject: [PATCH v1 4/7] sched/isolation: Adjust affinity of managed irqs according to change of housekeeping cpumask
Date: Thu, 16 May 2024 22:04:34 +0300
Message-ID: <20240516190437.3545310-5-costa.shul@redhat.com>
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

irq_affinity_adjust() is prototyped from irq_affinity_online_cpu()
and irq_restore_affinity_of_irq().

Core test snippets without infrastructure:

1. Create managed IRQ on specific cpu with:

static int test_set_affinity(struct irq_data *data,
			     const struct cpumask *m, bool f)
{
	irq_data_update_effective_affinity(data, m);
	return 0;
}

static int make_test_irq(void)
{
	struct irq_affinity_desc a = { mask: *cpumask_of(test_cpu),
				       is_managed: true };
	static struct irq_chip test_chip = { .irq_set_affinity = test_set_affinity };
	int test_irq = __irq_alloc_descs(-1, 1, 1, 0, THIS_MODULE, &a);

	irq_set_chip(test_irq, &test_chip);
	irq_set_status_flags(test_irq, IRQ_MOVE_PCNTXT);
	request_irq(test_irq, test_irq_cb, 0, "test_affinity", 0);

	return test_irq;
}

2. Isolate specified CPU.

3.  Assure that test_irq doesn't affine with test_cpu:

cat /proc/irq/$test_irq/smp_affinity_list

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/cgroup/cpuset.c   |  3 ++-
 kernel/sched/isolation.c | 44 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9d01e8e0a3ed9..2e59a2983eb2e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -225,7 +225,8 @@ static struct list_head remote_children;
 /*
  * The set of housekeeping flags to be updated for CPU isolation
  */
-#define	HOUSEKEEPING_FLAGS	(BIT(HK_TYPE_TIMER) | BIT(HK_TYPE_RCU))
+#define	HOUSEKEEPING_FLAGS	(BIT(HK_TYPE_TIMER) | BIT(HK_TYPE_RCU) \
+		| BIT(HK_TYPE_MANAGED_IRQ))
 
 /*
  * Partition root states:
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 85a17d39d8bb0..b0503ed362fce 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -135,6 +135,43 @@ static void resettle_all_timers(cpumask_var_t enable_mask, cpumask_var_t disable
 	}
 }
 
+static int irq_affinity_adjust(cpumask_var_t disable_mask)
+{
+	unsigned int irq;
+	cpumask_var_t mask;
+
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	irq_lock_sparse();
+	for_each_active_irq(irq) {
+		struct irq_desc *desc = irq_to_desc(irq);
+
+		raw_spin_lock_irq(&desc->lock);
+		struct irq_data *data = irq_desc_get_irq_data(desc);
+
+		if (irqd_affinity_is_managed(data) && cpumask_weight_and(disable_mask,
+			irq_data_get_affinity_mask(data))) {
+
+			cpumask_and(mask, cpu_online_mask, irq_default_affinity);
+			cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ));
+			irq_set_affinity_locked(data, mask, true);
+			WARN_ON(cpumask_weight_and(irq_data_get_effective_affinity_mask(data),
+						disable_mask));
+			WARN_ON(!cpumask_subset(irq_data_get_effective_affinity_mask(data),
+						cpu_online_mask));
+			WARN_ON(!cpumask_subset(irq_data_get_effective_affinity_mask(data),
+						housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)));
+		}
+		raw_spin_unlock_irq(&desc->lock);
+	}
+	irq_unlock_sparse();
+
+	free_cpumask_var(mask);
+
+	return 0;
+}
+
 /*
  * housekeeping_update - change housekeeping.cpumasks[type] and propagate the
  * change.
@@ -144,6 +181,8 @@ static void resettle_all_timers(cpumask_var_t enable_mask, cpumask_var_t disable
  */
 static int housekeeping_update(enum hk_type type, cpumask_var_t update)
 {
+	int err = 0;
+
 	struct {
 		struct cpumask changed;
 		struct cpumask enable;
@@ -171,11 +210,14 @@ static int housekeeping_update(enum hk_type type, cpumask_var_t update)
 		lockup_detector_reconfigure();
 #endif
 		break;
+	case HK_TYPE_MANAGED_IRQ:
+		err = irq_affinity_adjust(&masks->disable);
+		break;
 	default:
 	}
 	kfree(masks);
 
-	return 0;
+	return err;
 }
 
 static int __init housekeeping_setup(char *str, unsigned long flags)
-- 
2.45.0


