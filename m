Return-Path: <cgroups+bounces-5723-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2949B9DF58C
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 13:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D0EB216D4
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1671B5827;
	Sun,  1 Dec 2024 12:43:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAE1B5337;
	Sun,  1 Dec 2024 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733057023; cv=none; b=TayZFdn55JASXRj7hfAraIVC5MAhVBeOM27tyRjk1H3TuAyCO/5uX6stOGj/A53aHfnHf41M8DgbxXWN00ohdFSVCVF+kdGLs92ZjxCyFRIX2AqaUVj5kmZMbAEblw/8KctVXpRDahqT+lSGmkdnxbbntufpdLLx2vMPEig0mhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733057023; c=relaxed/simple;
	bh=kEFz7s9cS8bt1A3BnJLkQ42vnQvrBH9vKlkQzNuay44=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVUouJJPnfwb9/5JbJfZi0tCmYRHGMRrkRfRWMxTfhsuhUoR+hpkzRqB0cp+IzFMcdgSAUwI4N2o+N6NPx22kNnWqJVeNtUSd/WYDKi62lR0KDwsGeTzSTz4Ichmn0LGc/CMIcev0UhB8bbNsuFMQTw8/QkBiFiQhaw/p3bvTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434ab938e37so20449485e9.0;
        Sun, 01 Dec 2024 04:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733057020; x=1733661820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwTgWmg6Nk+SeybaZH1G2SoKFC/4ATTBRTyPLSQfoDo=;
        b=LreNNltUWimQmBYU6YEC7xNmpJx34PjtzrFCIZLSNewW8ACsypPqNvH+x4jm4hG44S
         zkllh8CkU+zO/Wxr0tEkcDFoO6TO+s7ZupJs+dAzLF9/FpUnmTUWfxyiSpeQzDNElYCg
         Tpv+zBw8MxKowu6phELgCg6fLDYGfq6Q9sEq7PTR7DpCvuckg2YAQ4FSjICJQVPZUvcu
         Kpsf1QPNqggN4bt9OSQnJ/5YiiC3iu0K70BQBOWAgJsXltsj2ohzS3DrDzR0q+h/ovjd
         1x+HDabI/KdrN6z2xZh0SLaHgZC97q05BmmpUfmQsLbjdImA5pkGCcvl6NPDW+7H+L26
         H/dA==
X-Forwarded-Encrypted: i=1; AJvYcCUCd7JsGTxjrmQvdyM9Xyc6nr5af8MWcLMd/AZd1c+8p+JFU2lNmxujYJJxPF7n9MJU6TCGBQt6SSU/6cIw@vger.kernel.org, AJvYcCWVebBC9lKPJWS80U7rB3+LEKuKhRlwcmoa96l/MUenFt1fmB1Sup9mOl3EEHyfxjjZ7pU+8GSv@vger.kernel.org
X-Gm-Message-State: AOJu0YxFopvbOuPrWzrnEY9O0dYyRNZ+a0nI4BldwqROkLRkYwCGtJJe
	2Rf9HVL2i/54Tu7MAWEzOig1PUtayOvJnsbkRuVWPHCMZpcV7Y7caQBcuOScquc=
X-Gm-Gg: ASbGncuXcYGjDjDU6WVxwifE26l2NBxO8pUlt0pchacFlHafJcrtiTJR1Uft3IzXeWA
	i+US4gZ5XYNno8875Pi6m9g6v4lgDdZl1D8VmJ0MB27EGD/QrlUKb0DfiXyh7ZvKsFDdG6o2Yd9
	Y/XkTUZWn75AxDi9cNV/8ddb4l9AkvUPbsnIChqoNhss25xCMfiTIjYIdbRN/XnAHYYv7r35dRG
	KsufA9cB3ChIetKJKXSYJbvnHhgrkvRNAAsKzMwbXdBkU50Gid9BWRFBSbdoVIvrgI=
X-Google-Smtp-Source: AGHT+IETkNM8+r32RNP4qhV2x33uBUhpJLEx/4ptuf4OfUoRO8MHH9mqdmcgeFc1qrYk89pxaaPaFg==
X-Received: by 2002:a05:6000:1ac9:b0:382:4a7b:ba7b with SMTP id ffacd0b85a97d-385c6ee2174mr16120213f8f.48.1733057019624;
        Sun, 01 Dec 2024 04:43:39 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70d91sm114434985e9.39.2024.12.01.04.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 04:43:38 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v4 4/4] DO NOT MERGE: Test CPU isolation from managed interrupts
Date: Sun,  1 Dec 2024 14:42:44 +0200
Message-ID: <20241201124244.997754-5-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241201124244.997754-1-costa.shul@redhat.com>
References: <20241201124244.997754-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test CPU isolation to ensure it is unaffected by managed interrupts.

Target: irq_restore_affinity_of_irq()

Managed interrupts can be created in various ways. One of them:

qemu-img create -f qcow2 test.qcow2 100M
virtme-ng -v --cpus 4 --rw --user root \
	--qemu-opts '\-drive id=d1,if=none,file=test.qcow2 \
	\-device nvme,id=i1,drive=d1,serial=1,bootindex=2'

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

v4:
- Remove /sys/devices/system/cpu/cpu$isolate/online

v3:
- No changes

v2:
- use shell script only
---
 MAINTAINERS          |   2 +
 tests/managed_irq.sh | 135 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100755 tests/managed_irq.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 1240e75ecf4b..4a753c2b34c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26046,3 +26046,5 @@ S:	Buried alive in reporters
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 F:	*
 F:	*/
+
+# disable warning
diff --git a/tests/managed_irq.sh b/tests/managed_irq.sh
new file mode 100755
index 000000000000..3763183fc987
--- /dev/null
+++ b/tests/managed_irq.sh
@@ -0,0 +1,135 @@
+#!/bin/zsh
+# SPDX-License-Identifier: GPL-2.0
+
+# shell script for testing dynamic isolation of managed interrupts.
+# Target: irq_restore_affinity_of_irq()
+
+# cpu# to isolate
+
+isolate=1
+
+managed_affined=$(
+	cd /sys/kernel/debug/irq/irqs/;
+	grep -l -e "affinity: $isolate$" /dev/null $(grep -l IRQD_AFFINITY_MANAGED *) |
+		head -n1
+)
+grep -l -e "affinity: $isolate$" /dev/null \
+	$(grep -l IRQD_AFFINITY_MANAGED /sys/kernel/debug/irq/irqs/*)
+test_irq=${managed_affined%% *}
+echo test_irq=$test_irq
+
+[ -z $test_irq ] && { echo No managed IRQs found;exit 1}
+
+cp -R /sys/kernel/debug/irq/irqs 0.irqs
+
+# Restart CPUs without changing the isolated cpuset.
+# Setup a baseline (the "control group")
+# to compare against the test of isolated mask.
+
+echo 0 > /sys/devices/system/cpu/cpu$isolate/online
+echo 0 > /sys/devices/system/cpu/cpu3/online
+echo 1 > /sys/devices/system/cpu/cpu$isolate/online
+echo 1 > /sys/devices/system/cpu/cpu3/online
+
+rm -rf baseline.irqs
+cp -R /sys/kernel/debug/irq/irqs baseline.irqs
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
+		echo "FAIL #$errors:"
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
+check_shutdown
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
+sleep 1 # wait till IRQD_IRQ_INPROGRESS, IRQD_IRQ_MASKED
+
+if ! diff -r --ignore-matching-lines=Vector:: baseline.irqs final.irqs; then
+	echo diff failed;
+	let errors+=1
+fi
+
+#
+# return zero on success or number of errors
+#
+echo errors=$errors
+(return $errors)
-- 
2.47.0


