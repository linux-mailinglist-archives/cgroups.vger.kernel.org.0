Return-Path: <cgroups+bounces-14095-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCpbJ8v/mWliXwMAu9opvQ
	(envelope-from <cgroups+bounces-14095-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:56:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8F16D984
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09F883061BC6
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940430DD1B;
	Sat, 21 Feb 2026 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YW2ORYkQ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4B3101DB
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771700115; cv=none; b=JerggFKFgCDn/OPFs7CUdNw0Oh2EJQeMB/0ohYSgUTcZSGpubSbgXNnvsrq2fRKV5MmcChZFUyVwHb73BBQ0AKhNvw2cPYnF9veOvqbJjODTrwCbkLDOEcHOKFY1tspDrq/jYS/khJ4lNQHDLpzxRtNURKuCgMiCH4epd632VVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771700115; c=relaxed/simple;
	bh=hGuiZrF0R/c3PrznZ4YKUJ5s/LWLPK0dFCijEUtkx/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYbHRARdwjFAi4dslhMN7USL30mH79vcBNpUzVJ9NqKgEaTDxnivoeXbc4GhIknMcvXFZRfRDvVZXZDkaXL4CIoOrHe3QPpsrHvaVmgfn2qZlP2SO3RpvG7OZ9GAzT9OGXCtvt5lJ69BpbG5+z0XrL5LJVWxWR7CBCOm5dN3cUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YW2ORYkQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771700112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o28S/e1kClKuLAr8yiDPeV96fynw2TO1+E91ese5bcw=;
	b=YW2ORYkQYBdOkGHUfbPmP/8Y5Nsa12XxOCrcFC2vui4E9997V5zy4mdibXp95R5fFoUlxb
	UfYpTjLl1M5rIQOlBdwpNfF1yp+tSARjN5zepWewoOqYllKntG/VQnMAtbvqM7c9uZqb7H
	SDwT3olLkg48pgazKIZx2B+mxF6HR3k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-FcQHXs05NGKcjauKLdX8qg-1; Sat,
 21 Feb 2026 13:55:09 -0500
X-MC-Unique: FcQHXs05NGKcjauKLdX8qg-1
X-Mimecast-MFC-AGG-ID: FcQHXs05NGKcjauKLdX8qg_1771700107
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63B451956053;
	Sat, 21 Feb 2026 18:55:06 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB5201955F22;
	Sat, 21 Feb 2026 18:55:01 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v6 5/8] kselftest/cgroup: Simplify test_cpuset_prs.sh by removing "S+" command
Date: Sat, 21 Feb 2026 13:54:15 -0500
Message-ID: <20260221185418.29319-6-longman@redhat.com>
In-Reply-To: <20260221185418.29319-1-longman@redhat.com>
References: <20260221185418.29319-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14095-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21B8F16D984
X-Rspamd-Action: no action

The "S+" command is used in the test matrix to enable the cpuset
controller. However this can be done automatically and we never use the
"S-" command to disable cpuset controller. Simplify the test matrix and
reduce clutter by removing the command and doing that automatically.
There is no functional change to the test cases.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 214 +++++++++---------
 1 file changed, 105 insertions(+), 109 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 5dff3ad53867..0c5db118f2d1 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -196,7 +196,6 @@ test_add_proc()
 #  P<v> = set cpus.partition (0:member, 1:root, 2:isolated)
 #  C<l> = add cpu-list to cpuset.cpus
 #  X<l> = add cpu-list to cpuset.cpus.exclusive
-#  S<p> = use prefix in subtree_control
 #  T    = put a task into cgroup
 #  CX<l> = add cpu-list to both cpuset.cpus and cpuset.cpus.exclusive
 #  O<c>=<v> = Write <v> to CPU online file of <c>
@@ -209,44 +208,44 @@ test_add_proc()
 # sched-debug matching which includes offline CPUs and single-CPU partitions
 # while the second one is for matching cpuset.cpus.isolated.
 #
-SETUP_A123_PARTITIONS="C1-3:P1:S+ C2-3:P1:S+ C3:P1"
+SETUP_A123_PARTITIONS="C1-3:P1 C2-3:P1 C3:P1"
 TEST_MATRIX=(
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
-	"   C0-1     .      .    C2-3    S+    C4-5     .      .     0 A2:0-1"
+	"   C0-1     .      .    C2-3     .    C4-5     .      .     0 A2:0-1"
 	"   C0-1     .      .    C2-3    P1      .      .      .     0 "
-	"   C0-1     .      .    C2-3   P1:S+ C0-1:P1   .      .     0 "
-	"   C0-1     .      .    C2-3   P1:S+  C1:P1    .      .     0 "
-	"  C0-1:S+   .      .    C2-3     .      .      .     P1     0 "
-	"  C0-1:P1   .      .    C2-3    S+     C1      .      .     0 "
-	"  C0-1:P1   .      .    C2-3    S+    C1:P1    .      .     0 "
-	"  C0-1:P1   .      .    C2-3    S+    C1:P1    .     P1     0 "
+	"   C0-1     .      .    C2-3    P1   C0-1:P1   .      .     0 "
+	"   C0-1     .      .    C2-3    P1    C1:P1    .      .     0 "
+	"   C0-1     .      .    C2-3     .      .      .     P1     0 "
+	"  C0-1:P1   .      .    C2-3     .     C1      .      .     0 "
+	"  C0-1:P1   .      .    C2-3     .    C1:P1    .      .     0 "
+	"  C0-1:P1   .      .    C2-3     .    C1:P1    .     P1     0 "
+	"  C0-1:P1   .      .    C2-3   C4-5     .      .      .     0 A1:4-5"
 	"  C0-1:P1   .      .    C2-3   C4-5     .      .      .     0 A1:4-5"
-	"  C0-1:P1   .      .    C2-3  S+:C4-5   .      .      .     0 A1:4-5"
 	"   C0-1     .      .   C2-3:P1   .      .      .     C2     0 "
 	"   C0-1     .      .   C2-3:P1   .      .      .    C4-5    0 B1:4-5"
-	"C0-3:P1:S+ C2-3:P1 .      .      .      .      .      .     0 A1:0-1|A2:2-3|XA2:2-3"
-	"C0-3:P1:S+ C2-3:P1 .      .     C1-3    .      .      .     0 A1:1|A2:2-3|XA2:2-3"
-	"C2-3:P1:S+  C3:P1  .      .     C3      .      .      .     0 A1:|A2:3|XA2:3 A1:P1|A2:P1"
-	"C2-3:P1:S+  C3:P1  .      .     C3      P0     .      .     0 A1:3|A2:3 A1:P1|A2:P0"
-	"C2-3:P1:S+  C2:P1  .      .     C2-4    .      .      .     0 A1:3-4|A2:2"
-	"C2-3:P1:S+  C3:P1  .      .     C3      .      .     C0-2   0 A1:|B1:0-2 A1:P1|A2:P1"
+	"  C0-3:P1 C2-3:P1  .      .      .      .      .      .     0 A1:0-1|A2:2-3|XA2:2-3"
+	"  C0-3:P1 C2-3:P1  .      .     C1-3    .      .      .     0 A1:1|A2:2-3|XA2:2-3"
+	"  C2-3:P1  C3:P1   .      .     C3      .      .      .     0 A1:|A2:3|XA2:3 A1:P1|A2:P1"
+	"  C2-3:P1  C3:P1   .      .     C3      P0     .      .     0 A1:3|A2:3 A1:P1|A2:P0"
+	"  C2-3:P1  C2:P1   .      .     C2-4    .      .      .     0 A1:3-4|A2:2"
+	"  C2-3:P1  C3:P1   .      .     C3      .      .     C0-2   0 A1:|B1:0-2 A1:P1|A2:P1"
 	"$SETUP_A123_PARTITIONS    .     C2-3    .      .      .     0 A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
 
 	# CPU offlining cases:
-	"   C0-1     .      .    C2-3    S+    C4-5     .     O2=0   0 A1:0-1|B1:3"
-	"C0-3:P1:S+ C2-3:P1 .      .     O2=0    .      .      .     0 A1:0-1|A2:3"
-	"C0-3:P1:S+ C2-3:P1 .      .     O2=0   O2=1    .      .     0 A1:0-1|A2:2-3"
-	"C0-3:P1:S+ C2-3:P1 .      .     O1=0    .      .      .     0 A1:0|A2:2-3"
-	"C0-3:P1:S+ C2-3:P1 .      .     O1=0   O1=1    .      .     0 A1:0-1|A2:2-3"
-	"C2-3:P1:S+  C3:P1  .      .     O3=0   O3=1    .      .     0 A1:2|A2:3 A1:P1|A2:P1"
-	"C2-3:P1:S+  C3:P2  .      .     O3=0   O3=1    .      .     0 A1:2|A2:3 A1:P1|A2:P2"
-	"C2-3:P1:S+  C3:P1  .      .     O2=0   O2=1    .      .     0 A1:2|A2:3 A1:P1|A2:P1"
-	"C2-3:P1:S+  C3:P2  .      .     O2=0   O2=1    .      .     0 A1:2|A2:3 A1:P1|A2:P2"
-	"C2-3:P1:S+  C3:P1  .      .     O2=0    .      .      .     0 A1:|A2:3 A1:P1|A2:P1"
-	"C2-3:P1:S+  C3:P1  .      .     O3=0    .      .      .     0 A1:2|A2: A1:P1|A2:P1"
-	"C2-3:P1:S+  C3:P1  .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-1"
-	"C2-3:P1:S+  C3:P1  .      .      .    T:O3=0   .      .     0 A1:2|A2:2 A1:P1|A2:P-1"
+	"   C0-1     .      .    C2-3     .    C4-5     .     O2=0   0 A1:0-1|B1:3"
+	"  C0-3:P1 C2-3:P1  .      .     O2=0    .      .      .     0 A1:0-1|A2:3"
+	"  C0-3:P1 C2-3:P1  .      .     O2=0   O2=1    .      .     0 A1:0-1|A2:2-3"
+	"  C0-3:P1 C2-3:P1  .      .     O1=0    .      .      .     0 A1:0|A2:2-3"
+	"  C0-3:P1 C2-3:P1  .      .     O1=0   O1=1    .      .     0 A1:0-1|A2:2-3"
+	"  C2-3:P1  C3:P1   .      .     O3=0   O3=1    .      .     0 A1:2|A2:3 A1:P1|A2:P1"
+	"  C2-3:P1  C3:P2   .      .     O3=0   O3=1    .      .     0 A1:2|A2:3 A1:P1|A2:P2"
+	"  C2-3:P1  C3:P1   .      .     O2=0   O2=1    .      .     0 A1:2|A2:3 A1:P1|A2:P1"
+	"  C2-3:P1  C3:P2   .      .     O2=0   O2=1    .      .     0 A1:2|A2:3 A1:P1|A2:P2"
+	"  C2-3:P1  C3:P1   .      .     O2=0    .      .      .     0 A1:|A2:3 A1:P1|A2:P1"
+	"  C2-3:P1  C3:P1   .      .     O3=0    .      .      .     0 A1:2|A2: A1:P1|A2:P1"
+	"  C2-3:P1  C3:P1   .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-1"
+	"  C2-3:P1  C3:P1   .      .      .    T:O3=0   .      .     0 A1:2|A2:2 A1:P1|A2:P-1"
 	"$SETUP_A123_PARTITIONS    .     O1=0    .      .      .     0 A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
 	"$SETUP_A123_PARTITIONS    .     O2=0    .      .      .     0 A1:1|A2:|A3:3 A1:P1|A2:P1|A3:P1"
 	"$SETUP_A123_PARTITIONS    .     O3=0    .      .      .     0 A1:1|A2:2|A3: A1:P1|A2:P1|A3:P1"
@@ -264,88 +263,87 @@ TEST_MATRIX=(
 	#
 	# Remote partition and cpuset.cpus.exclusive tests
 	#
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3     .      .      .     0 A1:0-3|A2:1-3|A3:2-3|XA1:2-3"
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3  X2-3:P2   .      .     0 A1:0-1|A2:2-3|A3:2-3 A1:P0|A2:P2 2-3"
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X3:P2    .      .     0 A1:0-2|A2:3|A3:3 A1:P0|A2:P2 3"
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3  X2-3:P2   .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:C3 .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
-	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-1|A2:1|A3:1|B1:2-3 A1:P0|A3:P0|B1:P2"
-	" C0-3:S+ C1-3:S+ C2-3   C4-5     .      .      .      P2    0 B1:4-5 B1:P2 4-5"
-	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2   P2    0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
-	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3 X2-3:P2:C1-3 P2  0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
-	" C0-3:S+ C1-3:S+ C2-3    C4    X1-3  X1-3:P2   P2     .     0 A2:1|A3:2-3 A2:P2|A3:P2 1-3"
-	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2 P2:C4-5 0 A3:2-3|B1:4-5 A3:P2|B1:P2 2-5"
-	" C4:X0-3:S+ X1-3:S+ X2-3  .      .      P2     .      .     0 A1:4|A2:1-3|A3:1-3 A2:P2 1-3"
-	" C4:X0-3:S+ X1-3:S+ X2-3  .      .      .      P2     .     0 A1:4|A2:4|A3:2-3 A3:P2 2-3"
+	"   C0-3    C1-3  C2-3     .    X2-3     .      .      .     0 A1:0-3|A2:1-3|A3:2-3|XA1:2-3"
+	"   C0-3    C1-3  C2-3     .    X2-3  X2-3:P2   .      .     0 A1:0-1|A2:2-3|A3:2-3 A1:P0|A2:P2 2-3"
+	"   C0-3    C1-3  C2-3     .    X2-3   X3:P2    .      .     0 A1:0-2|A2:3|A3:3 A1:P0|A2:P2 3"
+	"   C0-3    C1-3  C2-3     .    X2-3   X2-3  X2-3:P2   .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
+	"   C0-3    C1-3  C2-3     .    X2-3   X2-3 X2-3:P2:C3 .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
+	"   C0-3    C1-3  C2-3   C2-3     .      .      .      P2    0 A1:0-1|A2:1|A3:1|B1:2-3 A1:P0|A3:P0|B1:P2"
+	"   C0-3    C1-3  C2-3   C4-5     .      .      .      P2    0 B1:4-5 B1:P2 4-5"
+	"   C0-3    C1-3  C2-3    C4    X2-3   X2-3  X2-3:P2   P2    0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
+	"   C0-3    C1-3  C2-3    C4    X2-3   X2-3 X2-3:P2:C1-3 P2  0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
+	"   C0-3    C1-3  C2-3    C4    X1-3  X1-3:P2   P2     .     0 A2:1|A3:2-3 A2:P2|A3:P2 1-3"
+	"   C0-3    C1-3  C2-3    C4    X2-3   X2-3  X2-3:P2 P2:C4-5 0 A3:2-3|B1:4-5 A3:P2|B1:P2 2-5"
+	"  C4:X0-3  X1-3  X2-3     .      .      P2     .      .     0 A1:4|A2:1-3|A3:1-3 A2:P2 1-3"
+	"  C4:X0-3  X1-3  X2-3     .      .      .      P2     .     0 A1:4|A2:4|A3:2-3 A3:P2 2-3"
 
 	# Nested remote/local partition tests
-	" C0-3:S+ C1-3:S+ C2-3   C4-5   X2-3  X2-3:P1   P2     P1    0 A1:0-1|A2:|A3:2-3|B1:4-5 \
+	"   C0-3    C1-3  C2-3   C4-5   X2-3  X2-3:P1   P2     P1    0 A1:0-1|A2:|A3:2-3|B1:4-5 \
 								       A1:P0|A2:P1|A3:P2|B1:P1 2-3"
-	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1|A2:|A3:2-3|B1:4 \
+	"   C0-3    C1-3  C2-3    C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1|A2:|A3:2-3|B1:4 \
 								       A1:P0|A2:P1|A3:P2|B1:P1 2-4|2-3"
-	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3  X2-3:P1    .     P1    0 A1:0-1|A2:2-3|A3:2-3|B1:4 \
+	"   C0-3    C1-3  C2-3    C4    X2-3  X2-3:P1    .     P1    0 A1:0-1|A2:2-3|A3:2-3|B1:4 \
 								       A1:P0|A2:P1|A3:P0|B1:P1"
-	" C0-3:S+ C1-3:S+  C3     C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1|A2:2|A3:3|B1:4 \
+	"   C0-3    C1-3   C3     C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1|A2:2|A3:3|B1:4 \
 								       A1:P0|A2:P1|A3:P2|B1:P1 2-4|3"
-	" C0-4:S+ C1-4:S+ C2-4     .    X2-4  X2-4:P2  X4:P1    .    0 A1:0-1|A2:2-3|A3:4 \
+	"   C0-4    C1-4  C2-4     .    X2-4  X2-4:P2  X4:P1    .    0 A1:0-1|A2:2-3|A3:4 \
 								       A1:P0|A2:P2|A3:P1 2-4|2-3"
-	" C0-4:S+ C1-4:S+ C2-4     .    X2-4  X2-4:P2 X3-4:P1   .    0 A1:0-1|A2:2|A3:3-4 \
+	"   C0-4    C1-4  C2-4     .    X2-4  X2-4:P2 X3-4:P1   .    0 A1:0-1|A2:2|A3:3-4 \
 								       A1:P0|A2:P2|A3:P1 2"
-	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
+	" C0-4:X2-4 C1-4:X2-4:P2 C2-4:X4:P1 \
 				   .      .      X5      .      .    0 A1:0-4|A2:1-4|A3:2-4 \
 								       A1:P0|A2:P-2|A3:P-1 ."
-	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
+	" C0-4:X2-4 C1-4:X2-4:P2 C2-4:X4:P1 \
 				   .      .      .      X1      .    0 A1:0-1|A2:2-4|A3:2-4 \
 								       A1:P0|A2:P2|A3:P-1 2-4"
 
 	# Remote partition offline tests
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0 A1:0-1|A2:1|A3:3 A1:P0|A3:P2 2-3"
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 O2=1 0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
-	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3    P2:O3=0   .   0 A1:0-2|A2:1-2|A3: A1:P0|A3:P2 3"
-	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3   T:P2:O3=0  .   0 A1:0-2|A2:1-2|A3:1-2 A1:P0|A3:P-2 3|"
+	"   C0-3    C1-3  C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0 A1:0-1|A2:1|A3:3 A1:P0|A3:P2 2-3"
+	"   C0-3    C1-3  C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 O2=1 0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
+	"   C0-3    C1-3   C3      .    X2-3   X2-3    P2:O3=0   .   0 A1:0-2|A2:1-2|A3: A1:P0|A3:P2 3"
+	"   C0-3    C1-3   C3      .    X2-3   X2-3   T:P2:O3=0  .   0 A1:0-2|A2:1-2|A3:1-2 A1:P0|A3:P-2 3|"
 
 	# An invalidated remote partition cannot self-recover from hotplug
-	" C0-3:S+ C1-3:S+  C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3|A2:1-3|A3:2 A1:P0|A3:P-2 ."
+	"   C0-3    C1-3   C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3|A2:1-3|A3:2 A1:P0|A3:P-2 ."
 
 	# cpus.exclusive.effective clearing test
-	" C0-3:S+ C1-3:S+  C2      .   X2-3:X    .      .      .     0 A1:0-3|A2:1-3|A3:2|XA1:"
+	"   C0-3    C1-3   C2      .   X2-3:X    .      .      .     0 A1:0-3|A2:1-3|A3:2|XA1:"
 
 	# Invalid to valid remote partition transition test
-	" C0-3:S+   C1-3    .      .      .    X3:P2    .      .     0 A1:0-3|A2:1-3|XA2: A2:P-2 ."
-	" C0-3:S+ C1-3:X3:P2
-			    .      .    X2-3    P2      .      .     0 A1:0-2|A2:3|XA2:3 A2:P2 3"
+	"   C0-3    C1-3    .      .      .    X3:P2    .      .     0 A1:0-3|A2:1-3|XA2: A2:P-2 ."
+	"   C0-3 C1-3:X3:P2 .      .    X2-3    P2      .      .     0 A1:0-2|A2:3|XA2:3 A2:P2 3"
 
 	# Invalid to valid local partition direct transition tests
-	" C1-3:S+:P2 X4:P2  .      .      .      .      .      .     0 A1:1-3|XA1:1-3|A2:1-3:XA2: A1:P2|A2:P-2 1-3"
-	" C1-3:S+:P2 X4:P2  .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
-	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:5-6 A1:P2|B1:P0"
-	"  C0-3:P2   .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
+	" C1-3:P2  X4:P2    .      .      .      .      .      .     0 A1:1-3|XA1:1-3|A2:1-3:XA2: A1:P2|A2:P-2 1-3"
+	" C1-3:P2  X4:P2    .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
+	" C0-3:P2    .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:5-6 A1:P2|B1:P0"
+	" C0-3:P2    .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
 
 	# Local partition invalidation tests
-	" C0-3:X1-3:S+:P2 C1-3:X2-3:S+:P2 C2-3:X3:P2 \
+	" C0-3:X1-3:P2 C1-3:X2-3:P2 C2-3:X3:P2 \
 				   .      .      .      .      .     0 A1:1|A2:2|A3:3 A1:P2|A2:P2|A3:P2 1-3"
-	" C0-3:X1-3:S+:P2 C1-3:X2-3:S+:P2 C2-3:X3:P2 \
+	" C0-3:X1-3:P2 C1-3:X2-3:P2 C2-3:X3:P2 \
 				   .      .     X4      .      .     0 A1:1-3|A2:1-3|A3:2-3|XA2:|XA3: A1:P2|A2:P-2|A3:P-2 1-3"
-	" C0-3:X1-3:S+:P2 C1-3:X2-3:S+:P2 C2-3:X3:P2 \
+	" C0-3:X1-3:P2 C1-3:X2-3:P2 C2-3:X3:P2 \
 				   .      .    C4:X     .      .     0 A1:1-3|A2:1-3|A3:2-3|XA2:|XA3: A1:P2|A2:P-2|A3:P-2 1-3"
 	# Local partition CPU change tests
-	" C0-5:S+:P2 C4-5:S+:P1 .  .      .    C3-5     .      .     0 A1:0-2|A2:3-5 A1:P2|A2:P1 0-2"
-	" C0-5:S+:P2 C4-5:S+:P1 .  .    C1-5     .      .      .     0 A1:1-3|A2:4-5 A1:P2|A2:P1 1-3"
+	" C0-5:P2  C4-5:P1  .      .      .    C3-5     .      .     0 A1:0-2|A2:3-5 A1:P2|A2:P1 0-2"
+	" C0-5:P2  C4-5:P1  .      .    C1-5     .      .      .     0 A1:1-3|A2:4-5 A1:P2|A2:P1 1-3"
 
 	# cpus_allowed/exclusive_cpus update tests
-	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
+	" C0-3:X2-3 C1-3:X2-3 C2-3:X2-3 \
 				   .    X:C4     .      P2     .     0 A1:4|A2:4|XA2:|XA3:|A3:4 \
 								       A1:P0|A3:P-2 ."
-	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
+	" C0-3:X2-3 C1-3:X2-3 C2-3:X2-3 \
 				   .     X1      .      P2     .     0 A1:0-3|A2:1-3|XA1:1|XA2:|XA3:|A3:2-3 \
 								       A1:P0|A3:P-2 ."
-	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
+	" C0-3:X2-3 C1-3:X2-3 C2-3:X2-3 \
 				   .      .     X3      P2     .     0 A1:0-2|A2:1-2|XA2:3|XA3:3|A3:3 \
 								       A1:P0|A3:P2 3"
-	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3:P2 \
+	" C0-3:X2-3 C1-3:X2-3 C2-3:X2-3:P2 \
 				   .      .     X3      .      .     0 A1:0-2|A2:1-2|XA2:3|XA3:3|A3:3|XA3:3 \
 								       A1:P0|A3:P2 3"
-	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3:P2 \
+	" C0-3:X2-3 C1-3:X2-3 C2-3:X2-3:P2 \
 				   .     X4      .      .      .     0 A1:0-3|A2:1-3|A3:2-3|XA1:4|XA2:|XA3 \
 								       A1:P0|A3:P-2"
 
@@ -356,37 +354,37 @@ TEST_MATRIX=(
 	#
 	# Adding CPUs to partition root that are not in parent's
 	# cpuset.cpus is allowed, but those extra CPUs are ignored.
-	"C2-3:P1:S+ C3:P1   .      .      .     C2-4    .      .     0 A1:|A2:2-3 A1:P1|A2:P1"
+	"  C2-3:P1   C3:P1  .      .      .     C2-4    .      .     0 A1:|A2:2-3 A1:P1|A2:P1"
 
 	# Taking away all CPUs from parent or itself if there are tasks
 	# will make the partition invalid.
-	"C2-3:P1:S+  C3:P1  .      .      T     C2-3    .      .     0 A1:2-3|A2:2-3 A1:P1|A2:P-1"
-	" C3:P1:S+    C3    .      .      T      P1     .      .     0 A1:3|A2:3 A1:P1|A2:P-1"
+	"  C2-3:P1   C3:P1  .      .      T     C2-3    .      .     0 A1:2-3|A2:2-3 A1:P1|A2:P-1"
+	"   C3:P1     C3    .      .      T      P1     .      .     0 A1:3|A2:3 A1:P1|A2:P-1"
 	"$SETUP_A123_PARTITIONS    .    T:C2-3   .      .      .     0 A1:2-3|A2:2-3|A3:3 A1:P1|A2:P-1|A3:P-1"
 	"$SETUP_A123_PARTITIONS    . T:C2-3:C1-3 .      .      .     0 A1:1|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
 
 	# Changing a partition root to member makes child partitions invalid
-	"C2-3:P1:S+  C3:P1  .      .      P0     .      .      .     0 A1:2-3|A2:3 A1:P0|A2:P-1"
+	"  C2-3:P1   C3:P1  .      .      P0     .      .      .     0 A1:2-3|A2:3 A1:P0|A2:P-1"
 	"$SETUP_A123_PARTITIONS    .     C2-3    P0     .      .     0 A1:2-3|A2:2-3|A3:3 A1:P1|A2:P0|A3:P-1"
 
 	# cpuset.cpus can contains cpus not in parent's cpuset.cpus as long
 	# as they overlap.
-	"C2-3:P1:S+  .      .      .      .   C3-4:P1   .      .     0 A1:2|A2:3 A1:P1|A2:P1"
+	"  C2-3:P1   .      .      .      .   C3-4:P1   .      .     0 A1:2|A2:3 A1:P1|A2:P1"
 
 	# Deletion of CPUs distributed to child cgroup is allowed.
-	"C0-1:P1:S+ C1      .    C2-3   C4-5     .      .      .     0 A1:4-5|A2:4-5"
+	"  C0-1:P1  C1      .    C2-3   C4-5     .      .      .     0 A1:4-5|A2:4-5"
 
 	# To become a valid partition root, cpuset.cpus must overlap parent's
 	# cpuset.cpus.
-	"  C0-1:P1   .      .    C2-3    S+   C4-5:P1   .      .     0 A1:0-1|A2:0-1 A1:P1|A2:P-1"
+	"  C0-1:P1   .      .    C2-3     .   C4-5:P1   .      .     0 A1:0-1|A2:0-1 A1:P1|A2:P-1"
 
 	# Enabling partition with child cpusets is allowed
-	"  C0-1:S+  C1      .    C2-3    P1      .      .      .     0 A1:0-1|A2:1 A1:P1"
+	"   C0-1    C1      .    C2-3    P1      .      .      .     0 A1:0-1|A2:1 A1:P1"
 
 	# A partition root with non-partition root parent is invalid| but it
 	# can be made valid if its parent becomes a partition root too.
-	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
-	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2 0-1|1"
+	"   C0-1    C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
+	"   C0-1   C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2 0-1|1"
 
 	# A non-exclusive cpuset.cpus change will not invalidate its siblings partition.
 	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:3 A1:P1|B1:P0"
@@ -398,23 +396,23 @@ TEST_MATRIX=(
 
 	# Child partition root that try to take all CPUs from parent partition
 	# with tasks will remain invalid.
-	" C1-4:P1:S+ P1     .      .       .     .      .      .     0 A1:1-4|A2:1-4 A1:P1|A2:P-1"
-	" C1-4:P1:S+ P1     .      .       .   C1-4     .      .     0 A1|A2:1-4 A1:P1|A2:P1"
-	" C1-4:P1:S+ P1     .      .       T   C1-4     .      .     0 A1:1-4|A2:1-4 A1:P1|A2:P-1"
+	"  C1-4:P1  P1      .      .       .     .      .      .     0 A1:1-4|A2:1-4 A1:P1|A2:P-1"
+	"  C1-4:P1  P1      .      .       .   C1-4     .      .     0 A1|A2:1-4 A1:P1|A2:P1"
+	"  C1-4:P1  P1      .      .       T   C1-4     .      .     0 A1:1-4|A2:1-4 A1:P1|A2:P-1"
 
 	# Clearing of cpuset.cpus with a preset cpuset.cpus.exclusive shouldn't
 	# affect cpuset.cpus.exclusive.effective.
-	" C1-4:X3:S+ C1:X3  .      .       .     C      .      .     0 A2:1-4|XA2:3"
+	"  C1-4:X3 C1:X3    .      .       .     C      .      .     0 A2:1-4|XA2:3"
 
 	# cpuset.cpus can contain CPUs that overlap a sibling cpuset with cpus.exclusive
 	# but creating a local partition out of it is not allowed. Similarly and change
 	# in cpuset.cpus of a local partition that overlaps sibling exclusive CPUs will
 	# invalidate it.
-	" CX1-4:S+ CX2-4:P2 .    C5-6      .     .      .      P1    0 A1:1|A2:2-4|B1:5-6|XB1:5-6 \
+	"  CX1-4  CX2-4:P2  .    C5-6      .     .      .      P1    0 A1:1|A2:2-4|B1:5-6|XB1:5-6 \
 								       A1:P0|A2:P2:B1:P1 2-4"
-	" CX1-4:S+ CX2-4:P2 .    C3-6      .     .      .      P1    0 A1:1|A2:2-4|B1:5-6 \
+	"  CX1-4  CX2-4:P2  .    C3-6      .     .      .      P1    0 A1:1|A2:2-4|B1:5-6 \
 								       A1:P0|A2:P2:B1:P-1 2-4"
-	" CX1-4:S+ CX2-4:P2 .    C5-6      .     .      .   P1:C3-6  0 A1:1|A2:2-4|B1:5-6 \
+	"  CX1-4  CX2-4:P2  .    C5-6      .     .      .   P1:C3-6  0 A1:1|A2:2-4|B1:5-6 \
 								       A1:P0|A2:P2:B1:P-1 2-4"
 
 	# When multiple partitions with conflicting cpuset.cpus are created, the
@@ -426,14 +424,14 @@ TEST_MATRIX=(
 	" C1-3:X1-3  .      .    C4-5      .     .      .     C1-2   0 A1:1-3|B1:1-2"
 
 	# cpuset.cpus can become empty with task in it as it inherits parent's effective CPUs
-	" C1-3:S+   C2      .      .       .    T:C     .      .     0 A1:1-3|A2:1-3"
+	"   C1-3    C2      .      .       .    T:C     .      .     0 A1:1-3|A2:1-3"
 
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
 	# Failure cases:
 
 	# A task cannot be added to a partition with no cpu
-	"C2-3:P1:S+  C3:P1  .      .    O2=0:T   .      .      .     1 A1:|A2:3 A1:P1|A2:P1"
+	"  C2-3:P1 C3:P1    .      .    O2=0:T   .      .      .     1 A1:|A2:3 A1:P1|A2:P1"
 
 	# Changes to cpuset.cpus.exclusive that violate exclusivity rule is rejected
 	"   C0-3     .      .    C4-5   X0-3     .      .     X3-5   1 A1:0-3|B1:4-5"
@@ -465,31 +463,31 @@ REMOTE_TEST_MATRIX=(
 	#  old-p1 old-p2 old-c11 old-c12 old-c21 old-c22
 	#  new-p1 new-p2 new-c11 new-c12 new-c21 new-c22 ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------- ------- ------- ------- ----- ------ --------
-	" X1-3:S+ X4-6:S+ X1-2     X3     X4-5     X6 \
+	"   X1-3   X4-6  X1-2      X3     X4-5     X6 \
 	      .      .     P2      P2      P2      P2    c11:1-2|c12:3|c21:4-5|c22:6 \
 							 c11:P2|c12:P2|c21:P2|c22:P2 1-6"
-	" CX1-4:S+   .   X1-2:P2   C3      .       .  \
+	"  CX1-4     .  X1-2:P2    C3      .       .  \
 	      .      .     .      C3-4     .       .     p1:3-4|c11:1-2|c12:3-4 \
 							 p1:P0|c11:P2|c12:P0 1-2"
-	" CX1-4:S+   .   X1-2:P2   .       .       .  \
+	"  CX1-4     .  X1-2:P2    .       .       .  \
 	    X2-4     .     .       .       .       .     p1:1,3-4|c11:2 \
 							 p1:P0|c11:P2 2"
-	" CX1-5:S+   .   X1-2:P2 X3-5:P1   .       .  \
+	"  CX1-5     .  X1-2:P2  X3-5:P1   .       .  \
 	    X2-4     .     .       .       .       .     p1:1,5|c11:2|c12:3-4 \
 							 p1:P0|c11:P2|c12:P1 2"
-	" CX1-4:S+   .   X1-2:P2 X3-4:P1   .       .  \
+	"  CX1-4     .  X1-2:P2  X3-4:P1   .       .  \
 	      .      .     X2      .       .       .     p1:1|c11:2|c12:3-4 \
 							 p1:P0|c11:P2|c12:P1 2"
 	# p1 as member, will get its effective CPUs from its parent rtest
-	" CX1-4:S+   .   X1-2:P2 X3-4:P1   .       .  \
+	"  CX1-4     .  X1-2:P2  X3-4:P1   .       .  \
 	      .      .     X1     CX2-4    .       .     p1:5-7|c11:1|c12:2-4 \
 							 p1:P0|c11:P2|c12:P1 1"
-	" CX1-4:S+ X5-6:P1:S+ .    .       .       .  \
-	      .      .   X1-2:P2  X4-5:P1  .     X1-7:P2 p1:3|c11:1-2|c12:4:c22:5-6 \
+	"  CX1-4  X5-6:P1  .       .       .       .  \
+	      .      .  X1-2:P2  X4-5:P1   .     X1-7:P2 p1:3|c11:1-2|c12:4:c22:5-6 \
 							 p1:P0|p2:P1|c11:P2|c12:P1|c22:P2 \
 							 1-2,4-6|1-2,5-6"
 	# c12 whose cpuset.cpus CPUs are all granted to c11 will become invalid partition
-	" C1-5:P1:S+ .  C1-4:P1   C2-3     .       .  \
+	"  C1-5:P1   .  C1-4:P1   C2-3     .       .  \
 	      .      .     .       P1      .       .     p1:5|c11:1-4|c12:5 \
 							 p1:P1|c11:P1|c12:P-1"
 )
@@ -530,7 +528,6 @@ set_ctrl_state()
 	CGRP=$1
 	STATE=$2
 	SHOWERR=${3}
-	CTRL=${CTRL:=$CONTROLLER}
 	HASERR=0
 	REDIRECT="2> $TMPMSG"
 	[[ -z "$STATE" || "$STATE" = '.' ]] && return 0
@@ -540,15 +537,16 @@ set_ctrl_state()
 	for CMD in $(echo $STATE | sed -e "s/:/ /g")
 	do
 		TFILE=$CGRP/cgroup.procs
-		SFILE=$CGRP/cgroup.subtree_control
 		PFILE=$CGRP/cpuset.cpus.partition
 		CFILE=$CGRP/cpuset.cpus
 		XFILE=$CGRP/cpuset.cpus.exclusive
-		case $CMD in
-		    S*) PREFIX=${CMD#?}
-			COMM="echo ${PREFIX}${CTRL} > $SFILE"
+
+		# Enable cpuset controller if not enabled yet
+		[[ -f $CFILE ]] || {
+			COMM="echo +cpuset > $CGRP/../cgroup.subtree_control"
 			eval $COMM $REDIRECT
-			;;
+		}
+		case $CMD in
 		    X*)
 			CPUS=${CMD#?}
 			COMM="echo $CPUS > $XFILE"
@@ -947,7 +945,6 @@ check_test_results()
 run_state_test()
 {
 	TEST=$1
-	CONTROLLER=cpuset
 	CGROUP_LIST=". A1 A1/A2 A1/A2/A3 B1"
 	RESET_LIST="A1/A2/A3 A1/A2 A1 B1"
 	I=0
@@ -1003,7 +1000,6 @@ run_state_test()
 run_remote_state_test()
 {
 	TEST=$1
-	CONTROLLER=cpuset
 	[[ -d rtest ]] || mkdir rtest
 	cd rtest
 	echo +cpuset > cgroup.subtree_control
-- 
2.53.0


