Return-Path: <cgroups+bounces-2317-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3418898922
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 15:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2F51C27AEF
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C088128385;
	Thu,  4 Apr 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqsADpzU"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F3128830
	for <cgroups@vger.kernel.org>; Thu,  4 Apr 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238496; cv=none; b=FpNfkMPx9dW5jyvKLS9JC8Sg83ISOU43yzHbgIhmWOLQcKZZi20AYWAdPMVqMgxaIjwxo78NYmh0cGXqifiN6YiiBHOF48YbihZ3l4nlMdxNZ5jTxSbvIW2aCgx/1wujsCkoPPDJ14/PDP2E1i0u4/F6KDXFoSuVQ+9qYmtQJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238496; c=relaxed/simple;
	bh=y6/IshHk0uv9fDFkEevt+RsUXDV7iaRgIf3llsfiB/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PEOYeyZRmkKnquBCrqfIT2iAWe8kpSQOlD6MllQwTj4fl2lFUFKKNK5hG1aNd+CZHsoaN/9ba3C8ozwze3eQ9dO4TdEsxDBb0wkC7lmYD7U1qjsrfYHZ4aJJr2qHP8T6I3dGTy75ZPXwgR1zKj+nNAnZwckb5TnhPAWB23bPC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqsADpzU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712238493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hl4pfGBrbON0r6A5JWj3i+j4YMcyleP+1dPbuGF0SPU=;
	b=QqsADpzUwHSlFrAD+T8W50vDLuYPcd320/vA/u9p7McCQXkEkWRwbdi60VlWVAJJ7bSNfw
	iZUbUNCY+Krcvz6S1CNjBgmjvbx9h6Sj//pc9EBKiu6ufudnm6hpUgXgVWUo7Uv4AO2eXE
	lhXdCjSmndtPNxYxqO0m4Dgj3vUMzE0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-zJ0kA69APuKU_kbfP0Pa-g-1; Thu,
 04 Apr 2024 09:48:09 -0400
X-MC-Unique: zJ0kA69APuKU_kbfP0Pa-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEFD228043E4;
	Thu,  4 Apr 2024 13:48:07 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8F3F13C54;
	Thu,  4 Apr 2024 13:48:06 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Alex Shi <alexs@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/2] cgroup/cpuset: Add test_cpuset_v1_hp.sh
Date: Thu,  4 Apr 2024 09:47:49 -0400
Message-Id: <20240404134749.2857852-3-longman@redhat.com>
In-Reply-To: <20240404134749.2857852-1-longman@redhat.com>
References: <20240404134749.2857852-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Add a simple test to verify that an empty v1 cpuset will force its tasks
to be moved to an ancestor node. It is based on the test case documented
in commit 76bb5ab8f6e3 ("cpuset: break kernfs active protection in
cpuset_write_resmask()").

Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/Makefile       |  2 +-
 .../selftests/cgroup/test_cpuset_v1_hp.sh     | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 00b441928909..16461dc0ffdf 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -Wall -pthread
 all: ${HELPER_PROGS}
 
 TEST_FILES     := with_stress.sh
-TEST_PROGS     := test_stress.sh test_cpuset_prs.sh
+TEST_PROGS     := test_stress.sh test_cpuset_prs.sh test_cpuset_v1_hp.sh
 TEST_GEN_FILES := wait_inotify
 TEST_GEN_PROGS = test_memcontrol
 TEST_GEN_PROGS += test_kmem
diff --git a/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh b/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
new file mode 100755
index 000000000000..3f45512fb512
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test the special cpuset v1 hotplug case where a cpuset become empty of
+# CPUs will force migration of tasks out to an ancestor.
+#
+
+skip_test() {
+	echo "$1"
+	echo "Test SKIPPED"
+	exit 4 # ksft_skip
+}
+
+[[ $(id -u) -eq 0 ]] || skip_test "Test must be run as root!"
+
+# Find cpuset v1 mount point
+CPUSET=$(mount -t cgroup | grep cpuset | head -1 | awk -e '{print $3}')
+[[ -n "$CPUSET" ]] || skip_test "cpuset v1 mount point not found!"
+
+#
+# Create a test cpuset, put a CPU and a task there and offline that CPU
+#
+TDIR=test$$
+[[ -d $CPUSET/$TDIR ]] || mkdir $CPUSET/$TDIR
+echo 1 > $CPUSET/$TDIR/cpuset.cpus
+echo 0 > $CPUSET/$TDIR/cpuset.mems
+sleep 10&
+TASK=$!
+echo $TASK > $CPUSET/$TDIR/tasks
+NEWCS=$(cat /proc/$TASK/cpuset)
+[[ $NEWCS != "/$TDIR" ]] && {
+	echo "Unexpected cpuset $NEWCS, test FAILED!"
+	exit 1
+}
+
+echo 0 > /sys/devices/system/cpu/cpu1/online
+sleep 0.5
+echo 1 > /sys/devices/system/cpu/cpu1/online
+NEWCS=$(cat /proc/$TASK/cpuset)
+rmdir $CPUSET/$TDIR
+[[ $NEWCS != "/" ]] && {
+	echo "cpuset $NEWCS, test FAILED!"
+	exit 1
+}
+echo "Test PASSED"
+exit 0
-- 
2.39.3


