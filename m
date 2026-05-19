Return-Path: <cgroups+bounces-16081-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFmyJINFDGrQcQUAu9opvQ
	(envelope-from <cgroups+bounces-16081-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 13:12:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E6557D457
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 13:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6755E30511FF
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B434849252A;
	Tue, 19 May 2026 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYlCogF/"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93449219C
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188631; cv=none; b=EyllIFyuQ1tFGkU11498tfVWf86A/2YRoNS9RLiCAGlqxu1VrhHqb6+Bd53G2Q0ACcHM3sEpLFpZd9vjAPCmvN7gyQK4+9XoWTN5FwY6gB1pXiqdJMAaSnL47zj1yx7FWHSLFXUTzgjYWQ/xu2KSFIl3MryGG6DApmR8PHje0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188631; c=relaxed/simple;
	bh=Mpcye3kRhq+WMdLbalrx78CMcPUnzAqavHvmwN1CRiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PubV6USQiLSvkM3ZEyNPXJHpTXy3F60ABS4eI83bbSehMHT4k9i2tOvQFnVom8nbQGHuieilMWbDqgVu/eVRwSEdGALLZ4vDtBAQw7IKVl72wwIBT6jMc0OZtuquV1MuIEOx693/9Bif1mb9Qmafn40GERn+vo606XxM2NPdZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYlCogF/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779188627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+nv1tub1dRAw9uatvTRVsJrEgTvrLTIAT2v4860xNk=;
	b=JYlCogF/MVOY8g0ZRq4eCSQ27/w3oiBVY+it4cLPG0PhMlwONr6mR1ExhjAgul3gFuzdwJ
	mvY0G3SBkqLg1vN4/4gvQ4lk4+gKO4ezYKIe0SvpaS1IG2XigKXjGTi6Vm3I4oetlY9iCB
	PYKa7y01dtBKSJkVOZ8OqODM9RYGRms=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-2LJwBOu4MgKs3FJuIs4QDQ-1; Tue,
 19 May 2026 07:03:43 -0400
X-MC-Unique: 2LJwBOu4MgKs3FJuIs4QDQ-1
X-Mimecast-MFC-AGG-ID: 2LJwBOu4MgKs3FJuIs4QDQ_1779188622
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D720195609E;
	Tue, 19 May 2026 11:03:42 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CED530001A2;
	Tue, 19 May 2026 11:03:39 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 19 May 2026 13:03:13 +0200
Subject: [PATCH v4 3/4] selftests: cgroup: Add vmtest-dmem runner script
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-kunit_cgroups-v4-3-f6c2f498fae4@redhat.com>
References: <20260519-kunit_cgroups-v4-0-f6c2f498fae4@redhat.com>
In-Reply-To: <20260519-kunit_cgroups-v4-0-f6c2f498fae4@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@kernel.org, echanude@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779188611; l=5973;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=Mpcye3kRhq+WMdLbalrx78CMcPUnzAqavHvmwN1CRiE=;
 b=O+xEp6IaYYDJ9/wfyTRUh33qAvPvCjW6tVn0eFsQl4ne4wsJ170HmtHr384pfzCovV0tGLhE1
 YPe9aIwLD3dCetL0PaPksTtRr8KdHeeaTc3Wo5i0A5jcRgcB8vlZZiS
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16081-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test_stress.sh:url,test_cpuset_prs.sh:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,test_cpuset_v1_hp.sh:url,with_stress.sh:url]
X-Rspamd-Queue-Id: 33E6557D457
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 tools/testing/selftests/cgroup/Makefile       |   2 +-
 tools/testing/selftests/cgroup/vmtest-dmem.sh | 156 ++++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 1 deletion(-)

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
index 0000000000000..b395b7153f635
--- /dev/null
+++ b/tools/testing/selftests/cgroup/vmtest-dmem.sh
@@ -0,0 +1,156 @@
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
+	ktap_print_header
+	ktap_set_plan 1
+
+	# Write the VM-side script to a tempfile. Because vng mounts the host
+	# filesystem read-write via --rw, the guest can read it at the same path.
+	VM_SCRIPT="$(mktemp --suffix=.sh /tmp/dmem_vmtest_XXXX)"
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
+	if run_vm --exec "bash ${VM_SCRIPT}"; then
+		ktap_test_pass "test_dmem"
+	else
+		fail "test_dmem"
+	fi
+}
+
+main "$@"

-- 
2.53.0


