Return-Path: <cgroups+bounces-4897-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892A797A22E
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 14:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C213AB250F7
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613D0156F42;
	Mon, 16 Sep 2024 12:24:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2A154BEB;
	Mon, 16 Sep 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489456; cv=none; b=MYapoJrLxCTEAVEEUlROxDxq+PEYpCGwLTRWdabnOQ0MDdQmtwQicLexTsa5T8Ri8RPwFE9FCAYX/BptuHnIgBpoivSCvxQgjQ8u253BteUxZk0WoPiAfFQzZ8ZQxy74I6Jv+QFi0i10wfhPyJjHUgQ41fR0MXH0Kjq4leto4Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489456; c=relaxed/simple;
	bh=MpCSgizxeCsUjdDKdGBrpG5aByiQairA6fYbS2P/elU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJ1mEGgt9cAKtajLVkXTij2pzZwD34MEGNpqP76FZ+zcmjjesQWEMohvSq0nO4l809CUje5j3JTB3lQXiJV/3+rO8gzJjgN5ZlDIgZ3JJ636A3KyHSih4P4gAO759pcFBJp8Hq7Sgij7jFyVraWcKuH4JoZomeKRDwkXbUfVvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so37266585e9.3;
        Mon, 16 Sep 2024 05:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726489453; x=1727094253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIQVZrqwrUMgVJOuTjxMJrg0tEe4W9lzFWo0vuBjDGA=;
        b=IOcjupPtp7pdRqbGrxbCDUTDF3d3gopD4q7mrlQgOnNulf+TaCr6QKsY4/hO3u9zoH
         tt0+AaeT0GuBg8f2Q944dlv3Ir9UQu83yUiqenR6JIiv7uR/gW5cSuUrW+9wjh552LqF
         KmnN/wpREs8aWbkJFphhj8jh4GmEFBRefvqNwVYn+KYx04dbewGssbncm/PpNN5Nu3yG
         XFk8Vz8ye/vNArBZN2+SpabpUD3kymto66W4poalG6qRjvBTmDdIVVLbZCYTq06SyF5k
         /IlQbMI6Mcx9mHffeFXQP7Y74Zy/EzeE5ZVessBD2/C0BKjjiK3SgYNDrzPo8/EJHsNn
         dzTg==
X-Forwarded-Encrypted: i=1; AJvYcCVWYnWWAMV1b4rKFgKr+btXQZbtXH3vHwDtK/9K2U5toOGILF/3dyZ12Npga1qfXM0bqX1sYG3d@vger.kernel.org, AJvYcCWzJROgsOAw+MRUoPTIqLOkILUM7J+ZmZSTVxfi0VawNH0aE8A6IRg4m+6wfHBi3EMLiDA1oqu0MEIMeRpV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LDllsDE4ZSQHc5MhrzPE42HCOVbFqX1NMeiWa47C9cR823+B
	HgtNUir+iHUTVJwMOFSNf41diYOtumPfG0FMzkUvelaLpRwSD3qB
X-Google-Smtp-Source: AGHT+IE0DmenEPK9NwFC2424pKeGC0BWrR50LQs1egXEXs39Z4HiNTrZQssjk5k4Z07jJC9ekhD5yg==
X-Received: by 2002:a05:600c:2058:b0:42c:de9b:a1b5 with SMTP id 5b1f17b1804b1-42cde9ba226mr106150255e9.32.1726489452681;
        Mon, 16 Sep 2024 05:24:12 -0700 (PDT)
Received: from costa-tp.. ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800243sm7117272f8f.86.2024.09.16.05.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:24:12 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v3 3/3] DO NOT MERGE: test for managed irqs adjustment
Date: Mon, 16 Sep 2024 15:20:44 +0300
Message-ID: <20240916122044.3056787-4-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240916122044.3056787-1-costa.shul@redhat.com>
References: <20240916122044.3056787-1-costa.shul@redhat.com>
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

1. create qcow2 image
2. run
   virtme-ng -v --cpus 4 --rw --user root \
     --qemu-opts '\-drive id=d1,if=none,file=image.qcow2 \
     	\-device nvme,id=i1,drive=d1,serial=1,bootindex=2'

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes in v2:
- use shell script only

v1:
- https://lore.kernel.org/lkml/20240516190437.3545310-8-costa.shul@redhat.com/
---
 tests/managed_irq.sh | 113 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100755 tests/managed_irq.sh

diff --git a/tests/managed_irq.sh b/tests/managed_irq.sh
new file mode 100755
index 0000000000000..bd97f47991a0b
--- /dev/null
+++ b/tests/managed_irq.sh
@@ -0,0 +1,113 @@
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
+	grep -l -e "affinity: $isolate$" /dev/null $(grep -l IRQD_AFFINITY_MANAGED *)
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
+echo Expected to be without major differences:
+diff -r 0.irqs final.irqs && echo No differences
+
+echo errors=$errors
+(return $errors)
-- 
2.45.0


