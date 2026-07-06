Return-Path: <cgroups+bounces-17536-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E4YXFnOeS2p/XAEAu9opvQ
	(envelope-from <cgroups+bounces-17536-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 14:24:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 272DA7107B3
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 14:24:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ex7MYkkl;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17536-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17536-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09BEC308CA04
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C272424641;
	Mon,  6 Jul 2026 12:09:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB0424640
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 12:09:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339743; cv=none; b=KagmtID2LFiDdLgj5u9Q3LhQeyBKNrrAnMvdGLDoAIjP+luK4SZx+U9QWphsIdtUSWVAXl0DZ+2vLQNsV25NLwUAi0MTOtTij7ugIGFHytUmEwMTFptk2Q8MUyPTRCcvh1w6USF8CeekzFGTBwxgmdqKGIotqtmEbmS+U2y1bX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339743; c=relaxed/simple;
	bh=VmnDr3qErC3DLN3zFRiCIeAQykb+tE5T9DfedoNui9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=keWQwUmECF+pdE9R3as9J8SA2jBSEMy4Ek9mNCvJHmaEqRFqpWRqDj/ZyYvFNEQ7zV/Ykki+3qgW+/mbtUHZ2rQcDypvPxuv5uRSKGdp1rL6hrVCxZ8eQ/OZHXwvtmV+DgG5OYHEZ6jKdaYIwk/Z+zia75l8XldZxtSU1/X+dZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ex7MYkkl; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783339741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5W8myF8gVramz/adpN83H9hljq2x0AroHhv3246gxJs=;
	b=Ex7MYkklVFFLL+aFrMrT2Hdjmzq/Q8U9G7P9sZfDm0GF2NiavD1ZX+ZgrQv2pMGQYZ9Lzl
	X73/5j2N1fnY8aXdd6zdBgTFIaI1E1F9DeKyZlOUgitHJ/PPQnn/+g2Xs7tfU4ENx9l/zn
	Z9nbx3KAdCPdxHwuo0yysE7TraWy9bo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-QvPLHbehNHeTz52IGAMong-1; Mon,
 06 Jul 2026 08:07:34 -0400
X-MC-Unique: QvPLHbehNHeTz52IGAMong-1
X-Mimecast-MFC-AGG-ID: QvPLHbehNHeTz52IGAMong_1783339653
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FF9F195FDE4;
	Mon,  6 Jul 2026 12:07:04 +0000 (UTC)
Received: from [192.168.1.153] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 719D81800591;
	Mon,  6 Jul 2026 12:07:02 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 06 Jul 2026 14:06:42 +0200
Subject: [PATCH v5 3/4] selftests: cgroup: Add vmtest-dmem runner script
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-kunit_cgroups-v5-3-6c42c8753468@redhat.com>
References: <20260706-kunit_cgroups-v5-0-6c42c8753468@redhat.com>
In-Reply-To: <20260706-kunit_cgroups-v5-0-6c42c8753468@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783339614; l=6076;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=VmnDr3qErC3DLN3zFRiCIeAQykb+tE5T9DfedoNui9s=;
 b=pn7EVPAy4wIbO+OgowDQcLrVcKVpjLtm2redIdNZs4eDUOs6Rri26b3dwDSc1FbRLM+LN9O9e
 xh69X587Pv+AxxNx7wwmhO3oEeb0tXdxoR50d806S8ZTZ/bzM+ZNSYF
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17536-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:aesteve@redhat.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,vmtest-dmem.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,test_cpuset_prs.sh:url,test_stress.sh:url,with_stress.sh:url,test_cpuset_v1_hp.sh:url,run_kselftest.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 272DA7107B3

Currently, test_dmem relies on the dmem_selftest helper module
and a VM setup that may not have the helper preinstalled.
This makes automated coverage of dmem charge paths harder in
virtme-based runs.

Add tools/testing/selftests/cgroup/vmtest-dmem.sh to provide a
repeatable VM workflow for dmem tests. The script uses vng --exec
to run the test directly inside a virtme-ng guest with minimal
setup.

The script boots a virtme-ng guest, validates dmem controller
availability, ensures the dmem helper path is present, and runs
tools/testing/selftests/cgroup/test_dmem. If the helper is not
available as a loaded module, it attempts module build/load for
the running guest kernel before executing the test binary.

The runner also supports interactive shell mode (-s) and reuses
the verbosity and KTAP exit-code conventions used by other vmtest
scripts, so it integrates with existing kselftest workflows.

vmtest-dmem.sh is placed in TEST_FILES rather than TEST_PROGS so
it is installed alongside the test suite but not invoked
automatically by run_kselftest.sh. It requires a VM-capable host
and is intended to be run manually.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 tools/testing/selftests/cgroup/Makefile       |   2 +-
 tools/testing/selftests/cgroup/vmtest-dmem.sh | 149 ++++++++++++++++++++++++++
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index e1a5e9316620e..2c407710c6e3b 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -3,7 +3,7 @@ CFLAGS += -Wall -pthread
 
 all: ${HELPER_PROGS}
 
-TEST_FILES     := with_stress.sh
+TEST_FILES     := with_stress.sh vmtest-dmem.sh
 TEST_PROGS     := test_stress.sh test_cpuset_prs.sh test_cpuset_v1_hp.sh
 TEST_GEN_FILES := wait_inotify
 # Keep the lists lexicographically sorted
diff --git a/tools/testing/selftests/cgroup/vmtest-dmem.sh b/tools/testing/selftests/cgroup/vmtest-dmem.sh
new file mode 100755
index 0000000000000..0bb6529112b54
--- /dev/null
+++ b/tools/testing/selftests/cgroup/vmtest-dmem.sh
@@ -0,0 +1,149 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2026 Red Hat, Inc.
+#
+# Run cgroup test_dmem inside a virtme-ng VM.
+# Dependencies:
+#		* virtme-ng
+#		* qemu	(used by virtme-ng)
+
+set -euo pipefail
+
+readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
+readonly KERNEL_CHECKOUT="$(realpath "${SCRIPT_DIR}"/../../../../)"
+
+source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
+
+QEMU="qemu-system-$(uname -m)"
+VERBOSE=0
+SHELL_MODE=0
+GUEST_TREE="${GUEST_TREE:-$KERNEL_CHECKOUT}"
+
+VM_SCRIPT=""
+
+function usage() {
+	cat <<EOF
+$0 [OPTIONS]
+Options:
+	-q	QEMU binary/path (default: ${QEMU})
+	-s	Start interactive shell in VM instead of running tests
+	-v	Verbose output (vng boot logs on stdout)
+	-h	Display this help
+EOF
+}
+
+function cleanup() {
+	rm -f "${VM_SCRIPT}"
+}
+trap cleanup EXIT
+
+function skip() {
+	local msg=${1:-""}
+
+	ktap_test_skip "${msg}"
+	exit "${KSFT_SKIP}"
+}
+
+function fail() {
+	local msg=${1:-""}
+
+	ktap_test_fail "${msg}"
+	exit "${KSFT_FAIL}"
+}
+
+function check_deps() {
+	for dep in vng "${QEMU}"; do
+		if ! command -v "${dep}" >/dev/null 2>&1; then
+			skip "dependency ${dep} not found"
+		fi
+	done
+}
+
+# Run vng with common flags. Extra arguments are appended by the caller:
+#   --exec <script>  for automated test runs
+#   (nothing)        for interactive shell mode
+function run_vm() {
+	local verbose_opt=""
+
+	[[ "${VERBOSE}" -eq 1 ]] && verbose_opt="--verbose"
+
+	vng \
+		--run \
+		${verbose_opt:+"${verbose_opt}"} \
+		--qemu="$(command -v "${QEMU}")" \
+		--user root \
+		--rw \
+		"$@"
+}
+
+function main() {
+	while getopts ':hvq:s' opt; do
+		case "${opt}" in
+		v) VERBOSE=1 ;;
+		q) QEMU="${OPTARG}" ;;
+		s) SHELL_MODE=1 ;;
+		h) usage; exit 0 ;;
+		*) usage; exit 1 ;;
+		esac
+	done
+
+	check_deps
+
+	if [[ "${SHELL_MODE}" -eq 1 ]]; then
+		echo "Starting interactive shell in VM. Exit to stop VM."
+		run_vm
+		exit 0
+	fi
+
+	# Write the VM-side script into the script directory so it is
+	# accessible in the guest via the --rw host filesystem mount.
+	VM_SCRIPT="$(mktemp --suffix=.sh "${SCRIPT_DIR}/.dmem_vmtest_XXXX")"
+
+	cat > "${VM_SCRIPT}" << EOF
+#!/bin/bash
+set -euo pipefail
+
+mountpoint -q /sys/kernel/debug || mount -t debugfs none /sys/kernel/debug
+
+# Verify cgroup controllers are available.
+if ! grep -q dmem /sys/fs/cgroup/cgroup.controllers || \
+   ! grep -q memory /sys/fs/cgroup/cgroup.controllers; then
+	echo "guest kernel missing CONFIG_CGROUP_DMEM or CONFIG_MEMCG" >&2
+	exit 1
+fi
+
+# Load dmem_selftest: try built-in, then modprobe, then build + insmod.
+if [[ -e /sys/kernel/debug/dmem_selftest/charge ]]; then
+	echo "dmem_selftest ready (built-in or already loaded)"
+elif modprobe -q dmem_selftest 2>/dev/null && \
+     [[ -e /sys/kernel/debug/dmem_selftest/charge ]]; then
+	echo "dmem_selftest ready (modprobe)"
+else
+	kdir="/lib/modules/\$(uname -r)/build"
+	if [[ -d "\$kdir" ]]; then
+		echo "Building dmem_selftest.ko against running guest kernel..."
+		if make -C "\$kdir" M="${GUEST_TREE}/kernel/cgroup" \
+				CONFIG_DMEM_SELFTEST=m modules; then
+			insmod "${GUEST_TREE}/kernel/cgroup/dmem_selftest.ko" \
+				2>/dev/null || modprobe -q dmem_selftest 2>/dev/null || true
+		fi
+	fi
+	if [[ ! -e /sys/kernel/debug/dmem_selftest/charge ]]; then
+		echo "dmem_selftest unavailable (modprobe/build+insmod failed)" >&2
+		exit 1
+	fi
+	echo "dmem_selftest ready (built + insmod)"
+fi
+
+echo "Running cgroup/test_dmem in VM..."
+cd "${GUEST_TREE}"
+make -C tools/testing/selftests TARGETS=cgroup
+./tools/testing/selftests/cgroup/test_dmem
+EOF
+
+	echo "Booting virtme-ng VM..."
+	run_vm --exec "bash ${VM_SCRIPT}"
+}
+
+main "$@"

-- 
2.54.0


