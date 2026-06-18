Return-Path: <cgroups+bounces-17068-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P/DVC3RiM2oQAAYAu9opvQ
	(envelope-from <cgroups+bounces-17068-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:13:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD2569D41E
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:13:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=crKDOiIJ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17068-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17068-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEDC230608C0
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5882933D6E3;
	Thu, 18 Jun 2026 03:12:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8A336882
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 03:12:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752369; cv=none; b=lQNgww8j+fhCLJ/nbKlNKLMYRiDKOnMmNGD6akyUeWPNvZvYLyC6Lyqrr4XAUCXMibam+/zIirLJoUh4LOHF5jT2KgwGpH/nAE+q5yBigVeLbZQqeaKCnPc3EOwEx37cGZ7o/Yu3enC89ft5uqR+Ue27F7UizS9t6XswhKofgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752369; c=relaxed/simple;
	bh=sFs7mynJbe12HuAxVNUwUdIyzOYLmiTuiC6AfxKdZXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nk+KFtqj6HfaYveDrvbpgtQo+WWeSvKNcbFYgaHocFOOnF3Coh2OoP6JzSwiwuazWFh99sHZYsxERTFDt6sker+dTP7/vmdIt09RSd2Y+XKZv5ao45Hu+jc+chaHXu12WnNIPcb05H9msE56PnlsjvxOj/O/kZwc69DJrnDU7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crKDOiIJ; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so4058215ad.2
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 20:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752367; x=1782357167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAMlJUtgJr93wlY4Vrgrp/rfGIjYwybe1wRU3OQLFss=;
        b=crKDOiIJ+3vKsFMXjsHxDDuyInXKr6ZbM7f5q1ZDmMeA6uRS3Bb2BYhuZtS6wEynNi
         p1MB8ok+AB3CbvCM9bMLeecS0eJn7UAXcOzltlfGri40RG0E3iwubEoJTpKrsH1HcV6a
         m4tq3a8sD3czy2PCM4HyXTvbHBRiuLgP+ULmQsllwKBsSC8SVnlfVjX5zvSATwHqECmv
         bEGMhjQAT+xeerFrgznm3954Yj/Nb7mA9htAztoGDf6j2xOYdAfi8sCBG27zeSpCGrq/
         7F4V87e4yZp+qpHQ57Am52AXBzh03xYxbNAWOXv0Y1xI+FO/0AA+Fjz4S5xvFusCHjOB
         kxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752367; x=1782357167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EAMlJUtgJr93wlY4Vrgrp/rfGIjYwybe1wRU3OQLFss=;
        b=EhrK47s862YxteHjkNrS2Dm+AlJWWyX66e1qm9KfNLGEhgY1Mwi6cIFyCRNZ7LrNVo
         O15Zc5ZJLpiQLUrGFYWCAIW2sHZIvQ0f3Q6S+AC+8EZXQLoeO5KTJbT0HDBXF3JEvIST
         Z6ucdePMRcAaXCoPjmOFGeXK1Eu6rd6xr3EYH5l1mTtZBc2wwrQ0KWOQzum3/PMcdpmm
         qR3UVqbo22IawZcgiUfBwhp5iCkPFzBVZqKp3Mi/+/4XCanQlMTnXCsVDUCXqP57QA6l
         +c7bTjGnphEEe0cmKa9EiziJG1TgzZ7nSj2PMJTQzoq/A8wF/arclHpLrTSm9EKQ5Hpq
         Zlnw==
X-Forwarded-Encrypted: i=1; AFNElJ/2rkBS6CycT9+XttjbPpUbGDugunJRUETmIywpsyc2h1GNuKatAP69WLWYRrRXa95FK5YPlcos@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQKa/y+E7nLdYKW3slbvP1aiwtQjRHWgqgJYQNZxqexXhXAbc
	NLe41JJfwfvwilCP/GrTS2LQaAStyglo664WvBB/PPtAur+FHDcmw+Qv
X-Gm-Gg: AfdE7cmGuvWJ7155JG0Khyappg0CGW6xx3N8bc3VqcOjpAqlAzpUjynDwFAGfSjH2e5
	Sl9sKB+UBTnr4Ve9Am7k/fchkvq0pYWlEgZ7YdXulyQaoO2shz1zqVpqDzyBd9RE9Am+EQA/qVm
	DeU72nrJkiV7CxMrFokUpG4vCQuO0Q0vEmBazz6ExtN9uPba8BScQzUPjbOC51h90J9yFx71b5H
	b6kLOO1jThP5yiryhfz4s25zhzbTe0aDyIDAsQpOLzQ40eGAD051Q3cHs450Neh7x37L8P6S4YL
	BGDF6cxfpu8GpGrQMGxUaG2ZqiMqgL0n5Mg5Xl4lgIoJrro7q2jXomZb7aBeiAY74kkeJ0MdSeu
	kI3sVQ4uv1e8rddg7CpiBDtboZLV4oFPpVirZIJTGUMflP7xJYU/cW22JqkTsc81anbb7tDdSQH
	pfl7wncaQRZN4=
X-Received: by 2002:a17:902:f547:b0:2c2:bd0d:3cfa with SMTP id d9443c01a7336-2c6bc0c6684mr67014325ad.11.1781752366951;
        Wed, 17 Jun 2026 20:12:46 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:12:46 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:24 +0800
Subject: [PATCH v3 13/13] selftests/cgroup: Add kernel-noise isolation test
 to cpuset selftest
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260618-wujing-dhm-v3-13-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
In-Reply-To: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17068-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,chinatelecom.cn];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,test_cpuset_prs.sh:url,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CD2569D41E

Add test_hk_noise_isolated() to test_cpuset_prs.sh to verify that
creating and destroying an isolated cpuset partition updates both the
domain isolation state and the kernel-noise (nohz_full) state.

For domain isolation, the test checks cpuset.cpus.isolated before and
after the partition create/destroy cycle.

For kernel-noise isolation, the test reads
/sys/devices/system/cpu/nohz_full to confirm that the CPUs placed in
an isolated partition appear in the nohz_full mask while the partition
is active, and are removed from it once the partition is destroyed.
This sysfs attribute only exists when CONFIG_NO_HZ_FULL is enabled;
the nohz_full checks are skipped when it is absent so the test remains
usable on kernels without NO_HZ_FULL.

Add cpu_in_cpulist() to correctly determine whether a CPU number falls
within a kernel cpulist string (e.g. "4-7").  A plain grep cannot
detect membership in the interior of a range; cpu_in_cpulist() walks
each comma-separated element and handles both single values and
lo-hi ranges explicitly.

The test also covers: rejection of all-CPU isolation, the SMT sibling
constraint, nested partition inheritance, and a 100-cycle pressure test.
nohz_full is verified to be restored to its pre-test value after each
create/destroy cycle and after the pressure test.

Fix awk invocation to drop the spurious -e flag.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 204 +++++++++++++++++++++-
 1 file changed, 203 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index a56f4153c64df..047db14953fac 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -20,7 +20,7 @@ skip_test() {
 WAIT_INOTIFY=$(cd $(dirname $0); pwd)/wait_inotify
 
 # Find cgroup v2 mount point
-CGROUP2=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
+CGROUP2=$(mount -t cgroup2 | head -1 | awk '{print $3}')
 [[ -n "$CGROUP2" ]] || skip_test "Cgroup v2 mount point not found!"
 SUBPARTS_CPUS=$CGROUP2/.__DEBUG__.cpuset.cpus.subpartitions
 CPULIST=$(cat $CGROUP2/cpuset.cpus.effective)
@@ -1204,9 +1204,211 @@ test_inotify()
 	echo "" > cpuset.cpus
 }
 
+#
+# cpu_in_cpulist <cpu> <cpulist>
+#
+# Return 0 if <cpu> appears in <cpulist> (a kernel cpumask list such as
+# "0-3,8-31"), non-zero otherwise.  The kernel cpulist format uses ranges
+# ("lo-hi") and comma-separated items; a simple grep cannot detect that a
+# number falls in the middle of a range, so walk each element explicitly.
+#
+cpu_in_cpulist()
+{
+	local cpu=$1 list=$2 range lo hi
+	for range in $(echo "$list" | tr ',' ' '); do
+		if [[ "$range" == *-* ]]; then
+			lo=${range%-*}
+			hi=${range#*-}
+			[[ $cpu -ge $lo && $cpu -le $hi ]] && return 0
+		else
+			[[ $cpu -eq $range ]] && return 0
+		fi
+	done
+	return 1
+}
+
+#
+# Test that isolated partition creation/destruction drives kernel-noise
+# housekeeping mask updates and remains correct under pressure.
+#
+# Requires: >=8 CPUs, no isolcpus= boot conflict, root
+#
+test_hk_noise_isolated()
+{
+	local ISOL_BEFORE TEST_CPUS i PART ISOL_AFTER ISOL_RESTORE
+	local NOHZ_FILE NOHZ_BEFORE NOHZ_AFTER NOHZ_RESTORE
+	local HK_NOHZ_CHECK=0
+	local LOOPS=100
+
+	[[ $NR_CPUS -ge 8 ]] || {
+		echo "HK-noise test skipped: need >=8 CPUs, have $NR_CPUS"
+		return 0
+	}
+
+	# Detect whether CONFIG_NO_HZ_FULL is active: the sysfs attribute
+	# /sys/devices/system/cpu/nohz_full exposes the current nohz_full
+	# cpumask and is only present when NO_HZ_FULL is enabled.
+	NOHZ_FILE=/sys/devices/system/cpu/nohz_full
+	[[ -r "$NOHZ_FILE" ]] && HK_NOHZ_CHECK=1
+
+	cd $CGROUP2/test
+	echo member > cpuset.cpus.partition 2>/dev/null
+	echo "" > cpuset.cpus 2>/dev/null
+
+	ISOL_BEFORE=$(cat $CGROUP2/cpuset.cpus.isolated)
+	[[ $HK_NOHZ_CHECK -eq 1 ]] && NOHZ_BEFORE=$(cat $NOHZ_FILE)
+	TEST_CPUS="4-7"
+	echo $TEST_CPUS > cpuset.cpus
+
+	#
+	# Basic create/destroy cycle — verify domain isolation and
+	# kernel-noise (nohz_full) changes together.
+	#
+	console_msg "HK-noise: basic create/destroy cycle"
+	echo isolated > cpuset.cpus.partition
+
+	ISOL_AFTER=$(cat $CGROUP2/cpuset.cpus.isolated)
+	[[ $ISOL_AFTER != "$ISOL_BEFORE" ]] || {
+		echo "FAIL: isolated set unchanged after partition create"
+		exit 1
+	}
+
+	if [[ $HK_NOHZ_CHECK -eq 1 ]]; then
+		NOHZ_AFTER=$(cat $NOHZ_FILE)
+		# Verify that the newly isolated CPUs (4-7) appear in nohz_full.
+		# nohz_full = inverse of housekeeping, so isolating 4-7 should
+		# add them to nohz_full.
+		for cpu in 4 5 6 7; do
+			if ! cpu_in_cpulist $cpu "$NOHZ_AFTER"; then
+				echo "FAIL: cpu${cpu} not in nohz_full after isolation" \
+				     "(got: '$NOHZ_AFTER')"
+				exit 1
+			fi
+		done
+		console_msg "HK-noise: nohz_full after isolation: $NOHZ_AFTER"
+	fi
+
+	echo member > cpuset.cpus.partition
+
+	ISOL_RESTORE=$(cat $CGROUP2/cpuset.cpus.isolated)
+	[[ $ISOL_RESTORE = "$ISOL_BEFORE" ]] || {
+		echo "FAIL: expected '$ISOL_BEFORE' after destroy, got '$ISOL_RESTORE'"
+		exit 1
+	}
+
+	if [[ $HK_NOHZ_CHECK -eq 1 ]]; then
+		NOHZ_RESTORE=$(cat $NOHZ_FILE)
+		[[ "$NOHZ_RESTORE" = "$NOHZ_BEFORE" ]] || {
+			echo "FAIL: nohz_full not restored: expected '$NOHZ_BEFORE'," \
+			     "got '$NOHZ_RESTORE'"
+			exit 1
+		}
+	fi
+
+	#
+	# Reject all-CPU isolation (must leave at least one housekeeping CPU)
+	#
+	console_msg "HK-noise: reject all-CPU isolation"
+	echo 0-$((NR_CPUS - 1)) > cpuset.cpus
+	echo isolated > cpuset.cpus.partition
+	PART=$(cat cpuset.cpus.partition)
+	[[ $PART = *invalid* || $PART = member ]] || {
+		echo "FAIL: all-CPU isolation was not rejected, got '$PART'"
+		exit 1
+	}
+
+	#
+	# SMT safety: partial sibling isolation
+	#
+	console_msg "HK-noise: SMT sibling constraint"
+	echo $TEST_CPUS > cpuset.cpus
+	echo isolated > cpuset.cpus.partition
+	PART=$(cat cpuset.cpus.partition)
+	[[ $PART = isolated ]] || {
+		echo "FAIL: could not create isolated partition, got '$PART'"
+		exit 1
+	}
+	echo member > cpuset.cpus.partition
+
+	#
+	# Nested partition: parent root → child isolated
+	#
+	console_msg "HK-noise: nested partition inheritance"
+	echo $TEST_CPUS > cpuset.cpus
+	test_partition root
+	mkdir -p HK_SUB
+	cd HK_SUB
+	echo 4-5 > cpuset.cpus
+	echo isolated > cpuset.cpus.partition
+	ISOL_AFTER=$(cat $CGROUP2/cpuset.cpus.isolated)
+	[[ -n $ISOL_AFTER ]] || {
+		echo "FAIL: nested isolated partition not reflected in cpuset.cpus.isolated"
+		exit 1
+	}
+	echo member > cpuset.cpus.partition
+	cd $CGROUP2/test
+	echo member > cpuset.cpus.partition
+	rmdir HK_SUB 2>/dev/null
+
+	#
+	# Pressure test: 100 create/destroy cycles
+	#
+	console_msg "HK-noise: pressure test ($LOOPS cycles)"
+	echo $TEST_CPUS > cpuset.cpus
+	for i in $(seq 1 $LOOPS); do
+		echo isolated > cpuset.cpus.partition
+		PART=$(cat cpuset.cpus.partition)
+		[[ $PART = isolated ]] || {
+			echo "FAIL: cycle $i create failed, got '$PART'"
+			exit 1
+		}
+		echo member > cpuset.cpus.partition
+		PART=$(cat cpuset.cpus.partition)
+		[[ $PART = member ]] || {
+			echo "FAIL: cycle $i destroy failed, got '$PART'"
+			exit 1
+		}
+	done
+
+	#
+	# Stability: after pressure test, verify final state
+	#
+	console_msg "HK-noise: post-pressure cleanup"
+	echo isolated > cpuset.cpus.partition
+	ISOL_AFTER=$(cat $CGROUP2/cpuset.cpus.isolated)
+	[[ -n $ISOL_AFTER ]] || {
+		echo "FAIL: isolated set empty after pressure test"
+		exit 1
+	}
+	echo member > cpuset.cpus.partition
+	echo "" > cpuset.cpus
+	ISOL_RESTORE=$(cat $CGROUP2/cpuset.cpus.isolated)
+	[[ $ISOL_RESTORE = "$ISOL_BEFORE" ]] || {
+		echo "FAIL: final isolated '$ISOL_RESTORE' != '$ISOL_BEFORE'"
+		exit 1
+	}
+
+	if [[ $HK_NOHZ_CHECK -eq 1 ]]; then
+		NOHZ_RESTORE=$(cat $NOHZ_FILE)
+		[[ "$NOHZ_RESTORE" = "$NOHZ_BEFORE" ]] || {
+			echo "FAIL: nohz_full not restored after pressure test:" \
+			     "expected '$NOHZ_BEFORE', got '$NOHZ_RESTORE'"
+			exit 1
+		}
+	fi
+
+	cd $CGROUP2
+	if [[ $HK_NOHZ_CHECK -eq 1 ]]; then
+		console_msg "HK-noise: PASSED (with nohz_full verification)"
+	else
+		console_msg "HK-noise: PASSED (nohz_full skipped: CONFIG_NO_HZ_FULL not active)"
+	fi
+}
+
 trap cleanup 0 2 3 6
 run_state_test TEST_MATRIX
 run_remote_state_test REMOTE_TEST_MATRIX
 test_isolated
 test_inotify
+test_hk_noise_isolated
 echo "All tests PASSED."

-- 
2.43.0


