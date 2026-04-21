Return-Path: <cgroups+bounces-15422-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJiqDXEn52nV4QEAu9opvQ
	(envelope-from <cgroups+bounces-15422-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 09:29:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A24B437976
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 09:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1B8C303D7E1
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 07:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D33D38F949;
	Tue, 21 Apr 2026 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HP7V+r1+"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6C3A7F6E
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756037; cv=none; b=OVkD9AUEf2rWjoHvxnIny0fiDKXVVpzWYBaMjIKPh2Jo7I1Jhm5X6gLepmf7/izkaGlr+pdnVWY4pVrpapwlDyCrR/Ll8RGPBth5kZLoSB6hZOjm9zf48/1kIrYXW8N7JZw0YS+HViOWf2ZrUqaAolGc4KHuMrspCmOyKlCk4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756037; c=relaxed/simple;
	bh=YmsjTbTB3dEPZykTw9GY1PF0Uf4iA5Q9roEQ7DrejJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fT8PGPpAK4Gm1EJ/0P6dggTsTGPRJ+bcZhTo6HXU8EE/nb+n4rpNrEkDa5+0PAdKzpLDHL0ie+YGlrFHcFEV1xA0YxIkEQQaiD+2CEirS2ftSETYnw8GvI+3Rkd/SGG4uvZcqIy/RQYN1VoPSKdEN4lZ2e+/LNHA/Z17+BSXkmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HP7V+r1+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776756034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4HbUUgdhXDuJhFyu+qG/gCL2DJn/mDRABdKHnSI2MQ=;
	b=HP7V+r1+cFYS/POgJVxk0dW5+wKx7uBkYbY+CO+c1ueU3SBtAFrKrGoRgf1bIG3nR5Gb7s
	/jIN64dTO/K1dW0jSJQDkdfB75Oek/r1iQR0gTmnctb9YcJViDlhtRyypXMWFX2dwehhvB
	m3/x0UT+tT91tWLUlnqG7JUMfz15J2c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-eyx5MPnfPTqmp3vcOa9QDQ-1; Tue,
 21 Apr 2026 03:20:32 -0400
X-MC-Unique: eyx5MPnfPTqmp3vcOa9QDQ-1
X-Mimecast-MFC-AGG-ID: eyx5MPnfPTqmp3vcOa9QDQ_1776756031
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF2B61800451;
	Tue, 21 Apr 2026 07:20:30 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5B6E1956095;
	Tue, 21 Apr 2026 07:20:28 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 21 Apr 2026 09:19:49 +0200
Subject: [PATCH v2 3/4] selftests: cgroup: Add vmtest-dmem runner based on
 hid vmtest
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-kunit_cgroups-v2-3-bb6675d8249c@redhat.com>
References: <20260421-kunit_cgroups-v2-0-bb6675d8249c@redhat.com>
In-Reply-To: <20260421-kunit_cgroups-v2-0-bb6675d8249c@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776756020; l=6534;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=YmsjTbTB3dEPZykTw9GY1PF0Uf4iA5Q9roEQ7DrejJI=;
 b=L89sfgFBuFI/jMN9ZiPuYV/tDgyQtH8gJhERwny0zIo7TP+drQOBacN6yHGloxmoZPAfwDXUA
 CiydQ29ZgZYCl2QoOIuilHC3Vrp9GAegCxW/amR87asY2gwBCycJFYf
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15422-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A24B437976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, test_dmem relies on the dmem_selftest helper module
and a VM setup that may not have the helper preinstalled.
This makes automated coverage of dmem charge paths harder in
virtme-based runs.

Add tools/testing/selftests/cgroup/vmtest-dmem.sh, modeled
after the existing selftests vmtest runners
(notably tools/testing/selftests/hid/vmtest.sh),
to provide a repeatable VM workflow for dmem tests.

The script boots a virtme-ng guest, validates dmem
controller availability, ensures the dmem helper path is
present, and runs tools/testing/selftests/cgroup/test_dmem.
If the helper is not available as a loaded module, it
attempts module build/load for the running guest kernel
before executing the test binary.

The runner also supports interactive shell mode and
reuses the same verbosity and exit-code conventions
used by other vmtest scripts, so it integrates with existing
kselftest workflows.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 tools/testing/selftests/cgroup/vmtest-dmem.sh | 197 ++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/tools/testing/selftests/cgroup/vmtest-dmem.sh b/tools/testing/selftests/cgroup/vmtest-dmem.sh
new file mode 100755
index 0000000000000..3174f22b06361
--- /dev/null
+++ b/tools/testing/selftests/cgroup/vmtest-dmem.sh
@@ -0,0 +1,197 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2026 Red Hat, Inc.
+#
+# Run cgroup test_dmem inside a virtme-ng VM.
+# Dependencies:
+#		* virtme-ng
+#		* busybox-static (used by virtme-ng)
+#		* qemu	(used by virtme-ng)
+
+set -euo pipefail
+
+readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
+readonly KERNEL_CHECKOUT="$(realpath "${SCRIPT_DIR}"/../../../../)"
+
+source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
+
+readonly SSH_GUEST_PORT="${SSH_GUEST_PORT:-22}"
+readonly WAIT_PERIOD=3
+readonly WAIT_PERIOD_MAX=80
+readonly WAIT_TOTAL=$((WAIT_PERIOD * WAIT_PERIOD_MAX))
+readonly QEMU_PIDFILE="$(mktemp /tmp/qemu_dmem_vmtest_XXXX.pid)"
+readonly QEMU_OPTS=" --pidfile ${QEMU_PIDFILE} "
+
+QEMU="qemu-system-$(uname -m)"
+VERBOSE=0
+SHELL_MODE=0
+GUEST_TREE="${GUEST_TREE:-$KERNEL_CHECKOUT}"
+
+usage() {
+	echo
+	echo "$0 [OPTIONS]"
+	echo "  -q <qemu> QEMU binary/path (default: ${QEMU})"
+	echo "  -s        Start interactive shell in VM"
+	echo "  -v        Verbose output (use -vv for vng boot logs)"
+	echo
+
+	exit 1
+}
+
+die() {
+	echo "$*" >&2
+	exit "${KSFT_FAIL}"
+}
+
+cleanup() {
+	if [[ -s "${QEMU_PIDFILE}" ]]; then
+		pkill -SIGTERM -F "${QEMU_PIDFILE}" >/dev/null 2>&1 || true
+	fi
+
+	# If failure occurred during or before qemu start up, then we need
+	# to clean this up ourselves.
+	if [[ -e "${QEMU_PIDFILE}" ]]; then
+		rm -f "${QEMU_PIDFILE}"
+	fi
+}
+
+vm_ssh() {
+	stdbuf -oL ssh -q \
+		-F "${HOME}/.cache/virtme-ng/.ssh/virtme-ng-ssh.conf" \
+		-l root "virtme-ng%${SSH_GUEST_PORT}" \
+		"$@"
+}
+
+check_deps() {
+	for dep in vng "${QEMU}" busybox pkill ssh; do
+		if ! command -v "${dep}" >/dev/null 2>&1; then
+			echo "skip: dependency ${dep} not found"
+			exit "${KSFT_SKIP}"
+		fi
+	done
+}
+
+vm_start() {
+	local logfile=/dev/null
+	local verbose_opt=""
+
+	if [[ "${VERBOSE}" -eq 2 ]]; then
+		verbose_opt="--verbose"
+		logfile=/dev/stdout
+	fi
+
+	vng \
+		--run \
+		${verbose_opt} \
+		--qemu-opts="${QEMU_OPTS}" \
+		--qemu="$(command -v "${QEMU}")" \
+		--user root \
+		--ssh "${SSH_GUEST_PORT}" \
+		--rw &>"${logfile}" &
+
+	local vng_pid=$!
+	local elapsed=0
+
+	while [[ ! -s "${QEMU_PIDFILE}" ]]; do
+		kill -0 "${vng_pid}" 2>/dev/null || die "vng exited early; failed to boot VM"
+		[[ "${elapsed}" -ge "${WAIT_TOTAL}" ]] && die "timed out waiting for VM boot"
+		sleep 1
+		elapsed=$((elapsed + 1))
+	done
+}
+
+vm_wait_for_ssh() {
+	local i=0
+	while true; do
+		vm_ssh -- true && break
+		i=$((i + 1))
+		[[ "${i}" -gt "${WAIT_PERIOD_MAX}" ]] && die "timed out waiting for guest ssh"
+		sleep "${WAIT_PERIOD}"
+	done
+}
+
+check_guest_requirements() {
+	local cfg_ok
+	cfg_ok="$(vm_ssh -- " \
+		grep -q dmem /sys/fs/cgroup/cgroup.controllers && \
+		grep -q memory /sys/fs/cgroup/cgroup.controllers;
+		echo \$?
+	")"
+	[[ "${cfg_ok}" == "0" ]] || die "guest kernel missing CONFIG_CGROUP_DMEM"
+}
+
+setup_guest_dmem_helper() {
+	local kdir
+
+	vm_ssh -- "mountpoint -q /sys/kernel/debug || \
+		   mount -t debugfs none /sys/kernel/debug" || true
+
+	# Already available (built-in or loaded).
+	if vm_ssh -- "[[ -e /sys/kernel/debug/dmem_selftest/charge ]]"; then
+		echo "dmem_selftest ready"
+		return 0
+	fi
+
+	# Fast path: try installed module.
+	vm_ssh -- "modprobe -q dmem_selftest 2>/dev/null || true"
+	if vm_ssh -- "[[ -e /sys/kernel/debug/dmem_selftest/charge ]]"; then
+		echo "dmem_selftest ready"
+		return 0
+	fi
+
+	# Fallback: build only this module against running guest kernel,
+	# then insert it.
+	kdir="$(vm_ssh -- "echo /lib/modules/\$(uname -r)/build")"
+	if vm_ssh -- "[[ -d '${kdir}' ]]"; then
+		echo "Building dmem_selftest.ko against running guest kernel..."
+		vm_ssh -- "make -C '${kdir}' \
+			M='${GUEST_TREE}/kernel/cgroup' \
+			CONFIG_DMEM_SELFTEST=m modules"
+		vm_ssh -- "insmod '${GUEST_TREE}/kernel/cgroup/dmem_selftest.ko' \
+			2>/dev/null || modprobe -q dmem_selftest 2>/dev/null || true"
+	fi
+
+	if vm_ssh -- "[[ -e /sys/kernel/debug/dmem_selftest/charge ]]"; then
+		echo "dmem_selftest ready"
+		return 0
+	fi
+
+	die "dmem_selftest unavailable (modprobe/build+insmod failed)"
+}
+
+run_test() {
+	vm_ssh -- "cd '${GUEST_TREE}' && make -C tools/testing/selftests TARGETS=cgroup"
+	vm_ssh -- "cd '${GUEST_TREE}' && ./tools/testing/selftests/cgroup/test_dmem"
+}
+
+while getopts ":hvq:s" o; do
+	case "${o}" in
+	v) VERBOSE=$((VERBOSE + 1)) ;;
+	q) QEMU="${OPTARG}" ;;
+	s) SHELL_MODE=1 ;;
+	h|*) usage ;;
+	esac
+done
+
+trap cleanup EXIT
+
+check_deps
+echo "Booting virtme-ng VM..."
+vm_start
+vm_wait_for_ssh
+echo "VM is reachable via SSH."
+
+if [[ "${SHELL_MODE}" -eq 1 ]]; then
+	echo "Starting interactive shell in VM. Exit to stop VM."
+	vm_ssh -t -- "cd '${GUEST_TREE}' && exec bash --noprofile --norc"
+	exit "${KSFT_PASS}"
+fi
+
+check_guest_requirements
+setup_guest_dmem_helper
+
+echo "Running cgroup/test_dmem in VM..."
+run_test
+echo "PASS: test_dmem completed"
+exit "${KSFT_PASS}"

-- 
2.52.0


