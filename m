Return-Path: <cgroups+bounces-5311-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E075F9B4924
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 13:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD3CB2238F
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0573205AAA;
	Tue, 29 Oct 2024 12:09:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877CB204081;
	Tue, 29 Oct 2024 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203746; cv=none; b=HlPLrBdjlcW3aQvsQShaiH1F81u9bXjJfNhe0bjbImNAwayW7QDTIb4zzO4leRv2vdWYYMVgoiYGht34g9L7jDosx+sWQTOOX6hg70renaaE5xMdkVjJ49XhQeHzs49FltkWpK5b7yj4MPLuZGrcaH1QRWxxLfHn61bJ24kjzFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203746; c=relaxed/simple;
	bh=j79bw2l/RWyBaQykVpAFDmJZBz9ig+N0nkspQFvtrao=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WovjOPEYQr4/cgmow2Lq8N3psOGtjvZkJ/nL0TjsolNVrJv3yREtZBQz5qOaWrGFIKqrfv6R0XkG5lJZkjLjtBTklRmACrQjmq5kvRYajpUARa+w5djoABVvi0zr4+5Ur6hkEuSz+GBJ5JPP0zFYgfeV3jd+0ZUBE3rRLyCDOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d533b5412so3801057f8f.2;
        Tue, 29 Oct 2024 05:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730203743; x=1730808543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqMogqCHlSB+L5Oy6ZFZuAxGnTRIJtpF7lZ2PQwJRT0=;
        b=s9UoFpuxtgIqOXBQNEJv+rfGB4i09FnwrWQChiKmd3TQZnP9egOQQ2lAHeN68Mw5Rz
         sKNqQGNON+vPQSFjp5YMCzlI0G+P9zyVw9U3VxgF47jUtzM2636qsetY52bVha0lisN/
         bxRjp05v1bZBmbwOSAdmSjp0a6lFXCZEPOlPwDU4QlKMC19z8KSYVq1U1qyOCvPwqv6j
         9iiuALndNWO6E/Fhi85cBbZZdUMC35C+UTrDlzQudb3PGtsJlEynpf568jrOc6DcHaTG
         0LMW/pKXm/Zzhx902Gh7CSthzqipkVDtjIe4NZsjfcPWwMphRYM18/9eUm0QPS0WOvxT
         rblg==
X-Forwarded-Encrypted: i=1; AJvYcCUG6VtqmM3vDXHCtJOI/ojD/pO1OVwaQ0AF89ztclu/cX5koLSV5oIZuuqEzJdJk5EVrGQmXuhvyPynDiPl@vger.kernel.org, AJvYcCVa4U1CpikbWLjt6SQpAxpGjE8rUHQ8ZxIfbVA3aX1ZpdyUGAM4mcGXF2gSHUwqimy8kk93byMq@vger.kernel.org, AJvYcCWG/W8QdNArYZTNI854PaKOuWHZuH4FmxyA/K9duM6PC1DDdT8hmtE9PrRDSWp64UseXbEbZHf3WUU6EsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpkvm2pW2v6lcEMbrzP2V1z/9qWfj62dtjWa6JIHFU92kBvvA
	lgnbUY2fC9sRLKlgwBDjBIUtCHgYslJVEBJ3SoXQ1U5CaFzAHw0A
X-Google-Smtp-Source: AGHT+IEZF/m2ZWDHm+VRDPNBJO+ciCivoYsSilaHhnv+srjjZLAVrZtF+6FJzV3Yfw6REKrmoTWQyw==
X-Received: by 2002:a05:6000:dcc:b0:37d:3e6d:3c2f with SMTP id ffacd0b85a97d-38061200b35mr9079468f8f.47.1730203742751;
        Tue, 29 Oct 2024 05:09:02 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b13309sm12362152f8f.3.2024.10.29.05.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 05:09:02 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v3 2/3] DO NOT MERGE: test for managed irqs adjustment
Date: Tue, 29 Oct 2024 14:05:33 +0200
Message-ID: <20241029120534.3983734-3-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029120534.3983734-1-costa.shul@redhat.com>
References: <20241029120534.3983734-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

shell script for testing managed interrupts
status adjustments.

Targets: managed_irq_affinity_adjust(),
	irq_restore_affinity_of_irq(), managed_irq_isolate()

Managed interrupts can be created in various ways. One of them:

qemu-img create -f qcow2 test.qcow2 100M
virtme-ng -v --cpus 4 --rw --user root \
	--qemu-opts '\-drive id=d1,if=none,file=test.qcow2 \
	\-device nvme,id=i1,drive=d1,serial=1,bootindex=2'

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes in v2:
- use shell script only

v1:
- https://lore.kernel.org/lkml/20240516190437.3545310-8-costa.shul@redhat.com/
---
 tests/managed_irq.sh | 116 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100755 tests/managed_irq.sh

diff --git a/tests/managed_irq.sh b/tests/managed_irq.sh
new file mode 100755
index 000000000000..14bc2f4b13c5
--- /dev/null
+++ b/tests/managed_irq.sh
@@ -0,0 +1,116 @@
+#!/bin/zsh
+
+# shell script for testing IRQ status adjustment.
+# Targets: managed_irq_affinity_adjust(),
+# 	irq_restore_affinity_of_irq(), managed_irq_isolate()
+
+# cpu# to isolate
+#
+isolate=1
+
+managed_affined=$(
+	cd /sys/kernel/debug/irq/irqs/;
+	grep -l -e "affinity: $isolate$" /dev/null $(grep -l IRQD_AFFINITY_MANAGED *) |
+		head -n1
+)
+test_irq=${managed_affined%% *}
+
+[ -z $test_irq ] && { echo No managed IRQs found;exit 1}
+
+rm -rf 0.irqs
+cp -R /sys/kernel/debug/irq/irqs 0.irqs
+
+cd /sys/fs/cgroup/
+echo +cpuset > cgroup.subtree_control
+mkdir -p test
+echo isolated > test/cpuset.cpus.partition
+
+effective_affinity=/proc/irq/$test_irq/effective_affinity
+test_irq_debug=/sys/kernel/debug/irq/irqs/$test_irq
+
+errors=0
+
+check()
+{
+	local _status=$?
+	if [[ $_status == 0 ]]
+	then
+		echo PASS
+	else
+		let errors+=1
+		echo FAIL:
+		cat $test_irq_debug
+	fi
+	return $_status
+}
+
+check_activated()
+{
+	echo "Check normal irq affinity"
+	test 0 -ne $((0x$(cat $effective_affinity) & 1 << $isolate))
+	check
+	grep -q IRQD_ACTIVATED $test_irq_debug
+	check
+	grep -q IRQD_IRQ_STARTED $test_irq_debug
+	check
+	! grep -q IRQD_IRQ_DISABLED $test_irq_debug
+	check
+	! grep -q IRQD_IRQ_MASKED $test_irq_debug
+	check
+	! grep -q IRQD_MANAGED_SHUTDOWN $test_irq_debug
+	check
+}
+
+check_shutdown()
+{
+	echo "Check that irq affinity doesn't contain isolated cpu."
+	test 0 -eq $((0x$(cat $effective_affinity) & 1 << $isolate))
+	check
+	! grep -q IRQD_ACTIVATED $test_irq_debug
+	check
+	! grep -q IRQD_IRQ_STARTED $test_irq_debug
+	check
+	grep -q IRQD_IRQ_DISABLED $test_irq_debug
+	check
+	grep -q IRQD_IRQ_MASKED $test_irq_debug
+	check
+	grep -q IRQD_MANAGED_SHUTDOWN $test_irq_debug
+	check
+}
+
+echo "Isolating CPU #$isolate"
+echo $isolate > test/cpuset.cpus
+
+check_shutdown
+
+echo Reset cpuset
+echo "" > test/cpuset.cpus
+
+check_activated
+
+echo "Isolating CPU #$isolate again"
+echo $isolate > test/cpuset.cpus
+
+check_shutdown()
+
+echo "Isolating CPU #3 and restore CPU #$isolate"
+echo 3 > test/cpuset.cpus
+
+check_activated
+
+echo Reset cpuset
+echo "" > test/cpuset.cpus
+
+rmdir test
+cd -
+
+rm -rf final.irqs
+cp -R /sys/kernel/debug/irq/irqs final.irqs
+
+if ! diff -r --ignore-matching-lines=Vector: 0.irqs final.irqs; then
+	echo diff failed;
+	let errors+=1
+fi
+
+echo errors=$errors
+(return $errors)
-- 
2.47.0


