Return-Path: <cgroups+bounces-17796-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sUfKNAdKVmqm2wAAu9opvQ
	(envelope-from <cgroups+bounces-17796-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:39:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BDD755F2C
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 16:39:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=pghxMhYW;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17796-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17796-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4256430D4D0A
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA36948032F;
	Tue, 14 Jul 2026 14:30:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2B3E63BF
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 14:30:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039435; cv=none; b=Zs8slsYuRp6y+1rWYnVpkvGedIKbY2sloZpUU63mE171sA93e0cjh20c7DPMtUi3DMVQTGtxBqpc77totoM2a53N6nlUVtV5oT8jlXBAz1JRoXXMqotu3MBC7Mj0ZtTA28+HcPPeWufC9OjGhqKZMVgjQQBqLcOFHLbsOxNXj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039435; c=relaxed/simple;
	bh=960S5iptwnOdh1L34bpBnIhUf77x6qeM1FXyW6xT8y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZSyQdak1Y1+fOjEF+WdCPcka5M+DAY8oSi3SfQspHxelHQogpSd1vSWvROqdpYTfef3j0PZKYs6z8SL4/+o25GUpWFda7oJ8NFJ3zSn6B7Ors/dx8/Ez/P8bHkTxs6SavAsecgRBdoQlFAbEEEbi+YFjL3UYdGJuDxH47vl7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=pghxMhYW; arc=none smtp.client-ip=209.85.167.52
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b01146b205so3189933e87.2
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039431; x=1784644231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6F7fWu7LXunT/iWIpd58af5xjBk4X++kSvjcZu1SGqU=;
        b=pghxMhYWKkt/AW9OC13IySZTe4Pn1JGsvhABMS+J/1ecRsswQhzw5eOgmARU/j9o8Z
         orYGVtFmD/zQg23G5gNf+BQ4lJI32HaTTzFea2iXy7xZYSnfJUToB1aeiPRgO2jGCfQr
         hDo6pGLr0UwG8In3X8CwgfsP6S5b3J6A8OiD8nyCpQsxG2btHiHxUx+nCEVCj5KHOjbu
         hBd/lP4/33/wHNGuNVm7gmoax5KKlURwL6vW1RMbLp4H4oSbKDh0qAgAXxdAmSHrir49
         xTjieNysNBmxm70BMcYM7UWEGqypatz5/vS5Ud2Eze7EhHEntYyotJiOmhnyN1jxsXsH
         WNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039431; x=1784644231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6F7fWu7LXunT/iWIpd58af5xjBk4X++kSvjcZu1SGqU=;
        b=WHB8nW7t/GCV7xxBjLfNtIrR3Pwh3QrHW2NCKT9yM57pWUza9E9NSb4HGJ3rVaNDch
         YdL6Zawc9Pd6jim+4+ae8vAw5q+04kaeAFNbI89Lx92lTY8bXxbCf/VOT8wjitNByrdC
         g67TWCyVQzZGes85p3EbX8bj/znxqHcyqFhIkVzK9fNMFUk/w/NfuPYVrS0lzBdib0Xc
         Bkg6xv2t1yLRVPKrArdB1HEfi4ZRQz7rMhtHmFFHCmBJEpo4iD2NkN5MZiOw2v9mAS30
         n5sp9X6XjXOjJkAQmJ4S2u8HFw5aHOlPw38S7iZPq2aM92LdPGa+XEFwpaatCUXTdLla
         OkEw==
X-Gm-Message-State: AOJu0Ywl5FkuPjjGL/pMrhBLV0O/RvzPKuZJAZDAEJm6IEuVXJO55JD/
	2QJ3b0QWLWOJSgsIvysqijGgV9cTo3mPhz9unpseiM7cSkYxw+ns0uNtfFpw85wPd2Y=
X-Gm-Gg: AfdE7clO8Td5qJq+tUiH91iO491nGT3030ZqxHmhliLLzSRFcQI7S7qOJ3xOevDM21s
	Wv2z1cAVVFu3WfnLo/AbpsusCoCVvAi2jbhaLT9DON8CAKd0+ABFuI2SjDvmCs4mLSqKgW2U35s
	cvbmeA0JdQa30WKpTLTnYTPmf+tl/QJNYjR7VON/nmfvKT0lXYK3Kk9iw3WAj5QWWzJF7MJI4lQ
	hxMGe9FjXQX0jX0raLmF8XSwV0q8I//advFoILTN8WVWZtrrC3K43jv1xfnJr3FzGSUAVHi7nDH
	HNC0DNCkznJEyC9S2CLm6790CwWcwTrgqCUMjov6Qftf3V5bMt49ZyY6eI4Ejk99KMImEFQIc8M
	rU0fEP6qRsDwDI5Xdg4kGMPNI3P7LVRT2JBp+AAlncNAlO4xIchGZmaKD7VWO7DQxfjmy9NqtdH
	MjPS4knAwuqQIxlx2CFOFU2fI=
X-Received: by 2002:ac2:51cf:0:b0:5ae:b6b1:5fcd with SMTP id 2adb3069b0e04-5b02356bc9emr2660432e87.10.1784039430809;
        Tue, 14 Jul 2026 07:30:30 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca5002fsm3579450e87.27.2026.07.14.07.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:30 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v2 14/14] RDMA/selftests: Add rxe_netns_names test
Date: Tue, 14 Jul 2026 16:29:27 +0200
Message-ID: <20260714142927.1298897-15-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714142927.1298897-1-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17796-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:yanjun.zhu@linux.dev,m:cui.tao@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,rxe_sent_rcvd_bytes.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rxe_netns_names.sh:url,rxe_rping_between_netns.sh:url,rxe_test_netdev_unregister.sh:url,resnulli.us:from_mime,resnulli.us:mid,vger.kernel.org:from_smtp,rxe_ipv6.sh:url,rxe_socket_with_netns.sh:url,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38BDD755F2C

From: Jiri Pirko <jiri@nvidia.com>

Add a kselftest script that exercises per-netns RDMA device naming
with RXE. Cover duplicate names across namespaces, move conflict
handling, move-with-rename, and same-namespace rename requests.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- fixed ktap_set_plan
- s/RXE_A/RXE_SAME/ in dup rename
---
 tools/testing/selftests/rdma/Makefile         |   3 +-
 tools/testing/selftests/rdma/config           |   2 +
 .../testing/selftests/rdma/rxe_netns_names.sh | 282 ++++++++++++++++++
 3 files changed, 286 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/rdma/rxe_netns_names.sh

diff --git a/tools/testing/selftests/rdma/Makefile b/tools/testing/selftests/rdma/Makefile
index 07af7f15c1bf..a91c14c45006 100644
--- a/tools/testing/selftests/rdma/Makefile
+++ b/tools/testing/selftests/rdma/Makefile
@@ -3,6 +3,7 @@ TEST_PROGS := rxe_rping_between_netns.sh \
 		rxe_ipv6.sh \
 		rxe_socket_with_netns.sh \
 		rxe_test_NETDEV_UNREGISTER.sh \
-		rxe_sent_rcvd_bytes.sh
+		rxe_sent_rcvd_bytes.sh \
+		rxe_netns_names.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/rdma/config b/tools/testing/selftests/rdma/config
index 4ffb814e253b..e1ff54ec0f57 100644
--- a/tools/testing/selftests/rdma/config
+++ b/tools/testing/selftests/rdma/config
@@ -1,3 +1,5 @@
 CONFIG_TUN
 CONFIG_VETH
+CONFIG_DUMMY
+CONFIG_NET_NS
 CONFIG_RDMA_RXE
diff --git a/tools/testing/selftests/rdma/rxe_netns_names.sh b/tools/testing/selftests/rdma/rxe_netns_names.sh
new file mode 100755
index 000000000000..a4fabf86bdf7
--- /dev/null
+++ b/tools/testing/selftests/rdma/rxe_netns_names.sh
@@ -0,0 +1,282 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Exercise RDMA device name handling across network namespaces.
+
+source "$(dirname "$0")/../kselftest/ktap_helpers.sh"
+
+NAME_PREFIX="rxe_netns_names_$$"
+NETDEV_PREFIX="rxn$$"
+NS1="${NAME_PREFIX}ns1"
+NS2="${NAME_PREFIX}ns2"
+RXE_A="${NAME_PREFIX}rxe_a"
+RXE_B="${NAME_PREFIX}rxe_b"
+RXE_SAME="${NAME_PREFIX}rxe_same"
+RXE_NEW="${NAME_PREFIX}rxe_new"
+DUMMY_A="${NETDEV_PREFIX}a"
+DUMMY_B="${NETDEV_PREFIX}b"
+OLD_MODE=""
+MODE_CHANGED=0
+MODS=("dummy" "rdma_rxe")
+TEST_SAME_NAMES="same RDMA device name can exist in two net namespaces"
+TEST_MOVE_CONFLICT="move without rename fails on destination name conflict"
+TEST_MOVE_RENAME="move then rename succeeds"
+TEST_COMBINED_MOVE_RENAME="move with requested destination name succeeds"
+TEST_SAME_NETNS_DUP_RENAME="same-netns rename rejects duplicate name"
+TEST_TEARDOWN_RETURN="netns delete returns device to init_net and renames on conflict"
+
+ksft_skip()
+{
+	ktap_skip_all "$*"
+	exit "$KSFT_SKIP"
+}
+
+fail()
+{
+	ktap_exit_fail_msg "$*"
+}
+
+need_cmd()
+{
+	command -v "$1" >/dev/null 2>&1 || ksft_skip "missing command: $1"
+}
+
+rdma_ns()
+{
+	local ns=$1
+
+	shift
+	ip netns exec "$ns" rdma "$@"
+}
+
+rdma_dev_exists()
+{
+	local ns=$1
+	local dev=$2
+
+	if [ -n "$ns" ]; then
+		rdma_ns "$ns" dev show "$dev" >/dev/null 2>&1
+	else
+		rdma dev show "$dev" >/dev/null 2>&1
+	fi
+}
+
+add_dummy()
+{
+	local netdev=$1
+
+	ip link add "$netdev" type dummy || return 1
+	ip link set "$netdev" up || return 1
+}
+
+add_rxe()
+{
+	local dev=$1
+	local netdev=$2
+
+	rdma link add "$dev" type rxe netdev "$netdev"
+}
+
+rdma_dev_on_netdev()
+{
+	local netdev=$1
+
+	rdma link show 2>/dev/null | awk -v want="$netdev" '
+		{
+			for (i = 1; i < NF; i++)
+				if ($i == "netdev" && $(i + 1) == want) {
+					dev = $2
+					sub(/\/.*/, "", dev)
+					print dev
+					exit
+				}
+		}'
+}
+
+wait_rdma_dev_on_netdev()
+{
+	local netdev=$1
+	local dev
+	local i
+
+	for i in $(seq 1 50); do
+		dev=$(rdma_dev_on_netdev "$netdev")
+		if [ -n "$dev" ]; then
+			echo "$dev"
+			return 0
+		fi
+		sleep 0.1
+	done
+
+	return 1
+}
+
+setup_devs()
+{
+	cleanup_devs
+
+	add_dummy "$DUMMY_A" || return 1
+	add_dummy "$DUMMY_B" || return 1
+
+	add_rxe "$RXE_A" "$DUMMY_A" || return 1
+	add_rxe "$RXE_B" "$DUMMY_B" || return 1
+}
+
+cleanup_devs()
+{
+	ip link del "$DUMMY_A" 2>/dev/null
+	ip link del "$DUMMY_B" 2>/dev/null
+}
+
+setup()
+{
+	OLD_MODE=$(rdma system show 2>/dev/null |
+		   sed -n 's/.*netns \([^ ]*\).*/\1/p')
+	[ -n "$OLD_MODE" ] || ksft_skip "failed to read RDMA netns mode"
+
+	rdma system set netns exclusive >/dev/null 2>&1 ||
+		ksft_skip "rdma netns exclusive mode is not supported"
+	MODE_CHANGED=1
+
+	ip netns add "$NS1" || return 1
+	ip netns add "$NS2" || return 1
+}
+
+cleanup()
+{
+	cleanup_devs
+
+	ip netns del "$NS1" 2>/dev/null
+	ip netns del "$NS2" 2>/dev/null
+
+	if [ "$MODE_CHANGED" -eq 1 ]; then
+		rdma system set netns "$OLD_MODE" 2>/dev/null
+	fi
+
+	for m in "${MODS[@]}"; do
+		modprobe -r "$m" 2>/dev/null
+	done
+}
+
+rdma_supports_combined_move_rename()
+{
+	rdma dev help 2>&1 | grep -Eq 'netns .*name|name .*netns'
+}
+
+[ "$(id -u)" -eq 0 ] || ksft_skip "must be run as root"
+need_cmd ip
+need_cmd rdma
+need_cmd modprobe
+
+trap cleanup EXIT
+
+for m in "${MODS[@]}"; do
+	modinfo "$m" >/dev/null 2>&1 || ksft_skip "module $m not found"
+	modprobe "$m" || fail "failed to load $m"
+done
+
+setup || fail "failed to create net namespaces"
+
+ktap_print_header
+ktap_set_plan 6
+
+if setup_devs &&
+   rdma dev set "$RXE_A" netns "$NS1" &&
+   rdma_ns "$NS1" dev set "$RXE_A" name "$RXE_SAME" &&
+   rdma dev set "$RXE_B" netns "$NS2" &&
+   rdma_ns "$NS2" dev set "$RXE_B" name "$RXE_SAME" &&
+   rdma_dev_exists "$NS1" "$RXE_SAME" &&
+   rdma_dev_exists "$NS2" "$RXE_SAME"; then
+	ktap_test_pass "$TEST_SAME_NAMES"
+else
+	ktap_test_fail "$TEST_SAME_NAMES"
+fi
+cleanup_devs
+
+if ! setup_devs ||
+   ! rdma dev set "$RXE_A" netns "$NS1" ||
+   ! rdma_ns "$NS1" dev set "$RXE_A" name "$RXE_SAME" ||
+   ! rdma dev set "$RXE_B" netns "$NS2" ||
+   ! rdma_ns "$NS2" dev set "$RXE_B" name "$RXE_SAME"; then
+	ktap_test_fail "$TEST_MOVE_CONFLICT"
+elif rdma_ns "$NS1" dev set "$RXE_SAME" netns "$NS2" >/dev/null 2>&1; then
+	ktap_test_fail "$TEST_MOVE_CONFLICT"
+elif rdma_dev_exists "$NS1" "$RXE_SAME" &&
+     rdma_dev_exists "$NS2" "$RXE_SAME"; then
+	ktap_test_pass "$TEST_MOVE_CONFLICT"
+else
+	ktap_test_fail "$TEST_MOVE_CONFLICT"
+fi
+cleanup_devs
+
+if ! setup_devs; then
+	ktap_test_fail "$TEST_MOVE_RENAME"
+elif rdma dev set "$RXE_A" netns "$NS2" &&
+     rdma_ns "$NS2" dev set "$RXE_A" name "$RXE_NEW"; then
+	if rdma_dev_exists "$NS2" "$RXE_NEW" &&
+	   ! rdma_dev_exists "" "$RXE_A"; then
+		ktap_test_pass "$TEST_MOVE_RENAME"
+	else
+		ktap_test_fail "$TEST_MOVE_RENAME"
+	fi
+else
+	ktap_test_fail "$TEST_MOVE_RENAME"
+fi
+cleanup_devs
+
+if ! rdma_supports_combined_move_rename; then
+	ktap_test_skip "$TEST_COMBINED_MOVE_RENAME"
+elif ! setup_devs; then
+	ktap_test_fail "$TEST_COMBINED_MOVE_RENAME"
+elif rdma dev set "$RXE_A" netns "$NS2" name "$RXE_NEW"; then
+	if rdma_dev_exists "$NS2" "$RXE_NEW" &&
+	   ! rdma_dev_exists "" "$RXE_A"; then
+		ktap_test_pass "$TEST_COMBINED_MOVE_RENAME"
+	else
+		ktap_test_fail "$TEST_COMBINED_MOVE_RENAME"
+	fi
+else
+	ktap_test_fail "$TEST_COMBINED_MOVE_RENAME"
+fi
+cleanup_devs
+
+if ! setup_devs; then
+	ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
+elif rdma dev set "$RXE_A" name "$RXE_SAME" &&
+     rdma dev set "$RXE_B" name "$RXE_NEW"; then
+	if rdma dev set "$RXE_SAME" name "$RXE_NEW" >/dev/null 2>&1; then
+		ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
+	elif rdma_dev_exists "" "$RXE_SAME" &&
+	     rdma_dev_exists "" "$RXE_NEW"; then
+		ktap_test_pass "$TEST_SAME_NETNS_DUP_RENAME"
+	else
+		ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
+	fi
+else
+	ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
+fi
+cleanup_devs
+
+if ! setup_devs; then
+	ktap_test_fail "$TEST_TEARDOWN_RETURN"
+elif ! rdma dev set "$RXE_A" name "$RXE_SAME" ||
+     ! rdma dev set "$RXE_B" netns "$NS2" ||
+     ! rdma_ns "$NS2" dev set "$RXE_B" name "$RXE_SAME" ||
+     ! rdma_dev_exists "$NS2" "$RXE_SAME"; then
+	ktap_test_fail "$TEST_TEARDOWN_RETURN"
+else
+	ip netns del "$NS2"
+	returned=$(wait_rdma_dev_on_netdev "$DUMMY_B")
+	ktap_print_msg "device returned to init_net as '${returned:-<missing>}'"
+	if rdma_dev_exists "" "$RXE_SAME" &&
+	   [ -n "$returned" ] &&
+	   [ "$returned" != "$RXE_SAME" ] &&
+	   [ "${returned#ibdev}" != "$returned" ]; then
+		ktap_test_pass "$TEST_TEARDOWN_RETURN"
+	else
+		ktap_test_fail "$TEST_TEARDOWN_RETURN"
+	fi
+fi
+cleanup_devs
+
+ktap_finished
-- 
2.54.0


