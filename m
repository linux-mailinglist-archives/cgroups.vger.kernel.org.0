Return-Path: <cgroups+bounces-15590-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNB5CMNb+GnqtQIAu9opvQ
	(envelope-from <cgroups+bounces-15590-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 10:41:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFCD4BA61D
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 10:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66840302FA31
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2026 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F33D344DB4;
	Mon,  4 May 2026 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyIFs/7W"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C6342523
	for <cgroups@vger.kernel.org>; Mon,  4 May 2026 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883990; cv=none; b=GfaZzhJK2tGvhzIrJXrwPKDkhMlMRL1v+/2Lf06JvM5Dq19dVpXG/KDBIXZqlZwySAqgExKwvzpl6TiVXZnEpk0fDE+nFnfiKpIsdMyzRi/HiLmK0xnClwidmFFFk/2tmzfQxGCsL1i8LZPxiuWtjuLlFpFrQ3yWTQTLq+bBXkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883990; c=relaxed/simple;
	bh=2RTP13Nu7Z4tEtxogQgWd3CW8wKZRNhB047xK4y1OSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZG1ltrSC0wnWRMODicvXzehDphHcM8TYZeDwQdEfAZW4HPnZKF7a5myDyLNClcUX79XrxmDjFdTfeaVF87PFAB7exXMphGO38rXAaxCtF5uujAQUAj7UcanyWWEeLbDUaNYp/5Eh9cyMFXn3vcPDfmH9SWkSudKZvVhBqGfGSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyIFs/7W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777883987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FCmw5PTtSXzNIV6yVE0OtGGUXuOUm+K8ky9wYITGY8=;
	b=HyIFs/7WXkYRrlc7mzm8gdiWjYGPmBs1eRNp2+bQc/rLeyQ7mRPxV5MTyfilOnUQLsyH51
	NoLx5y4groYFFtc83nvUcQnXByZnu9bMEhBQZpjgTuw7YhSRwS/tRXfuaCCSz06GB62Q0Z
	iCzLp/xCDLfKLxhOmWRbOoIhFj+E5lo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-IuvFYTI_OCaecIwOPj80oQ-1; Mon,
 04 May 2026 04:39:43 -0400
X-MC-Unique: IuvFYTI_OCaecIwOPj80oQ-1
X-Mimecast-MFC-AGG-ID: IuvFYTI_OCaecIwOPj80oQ_1777883981
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62DA6195608C;
	Mon,  4 May 2026 08:39:41 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 259E21800347;
	Mon,  4 May 2026 08:39:38 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 04 May 2026 10:39:26 +0200
Subject: [PATCH v3 4/4] selftests: cgroup: handle vmtest-dmem -b to test
 locally built kernel
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-kunit_cgroups-v3-4-4eac90b76f91@redhat.com>
References: <20260504-kunit_cgroups-v3-0-4eac90b76f91@redhat.com>
In-Reply-To: <20260504-kunit_cgroups-v3-0-4eac90b76f91@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@redhat.com, Eric Chanudet <echanude@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777883968; l=3222;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=5hsHacvz/JuYV7yLWF/sNuSW9yMcwd+DRLDYe4UgWBM=;
 b=v3BtPSCdpKlecFOBGNnBJRWFTR7dDWB4TkXbPzSuXKpw1MxZctKXcdTgQgKZegLjznHx9K8HQ
 Q8XxjB+ed+7BTynlEn+JXGVup51q1PfE+zsXrIUKZIhSpRauDEWtsJY
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 8DFCD4BA61D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15590-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmtest-dmem.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Eric Chanudet <echanude@redhat.com>

Currently vmtest-dmem.sh relies on the host's running kernel or a
pre-built one when booting the virtme-ng VM, with no option to
configure and build a local kernel tree directly.

This adds friction to the development cycle: the user must manually
run vng --kconfig with the correct config fragment, build the kernel,
and pass the result to the script.

Add a -b flag that automates this workflow.  When set, handle_build()
configures the kernel using vng --kconfig with the selftest config
fragment, builds it with make -j$(nproc), and vm_start() passes the
local tree to vng --run so the VM boots the freshly built kernel.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 tools/testing/selftests/cgroup/vmtest-dmem.sh | 35 ++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/vmtest-dmem.sh b/tools/testing/selftests/cgroup/vmtest-dmem.sh
index 9524dbddb06b7..b6e4777285c1b 100755
--- a/tools/testing/selftests/cgroup/vmtest-dmem.sh
+++ b/tools/testing/selftests/cgroup/vmtest-dmem.sh
@@ -23,6 +23,7 @@ readonly WAIT_TOTAL=$((WAIT_PERIOD * WAIT_PERIOD_MAX))
 readonly QEMU_PIDFILE="$(mktemp /tmp/qemu_dmem_vmtest_XXXX.pid)"
 readonly QEMU_OPTS=" --pidfile ${QEMU_PIDFILE} "
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 VERBOSE=0
 SHELL_MODE=0
@@ -31,6 +32,7 @@ GUEST_TREE="${GUEST_TREE:-$KERNEL_CHECKOUT}"
 usage() {
 	echo
 	echo "$0 [OPTIONS]"
+	echo "  -b        Build kernel from source tree before booting"
 	echo "  -q <qemu> QEMU binary/path (default: ${QEMU})"
 	echo "  -s        Start interactive shell in VM"
 	echo "  -v        Verbose output (vng boot logs on stdout)"
@@ -72,17 +74,46 @@ check_deps() {
 	done
 }
 
+handle_build() {
+	if [[ ! "${BUILD}" -eq 1 ]]; then
+		return
+	fi
+
+	if [[ ! -d "${KERNEL_CHECKOUT}" ]]; then
+		echo "-b requires vmtest-dmem.sh called from the kernel source tree" >&2
+		exit 1
+	fi
+
+	pushd "${KERNEL_CHECKOUT}" &>/dev/null
+
+	if ! vng --kconfig --config "${SCRIPT_DIR}"/config; then
+		die "failed to generate .config for kernel source tree (${KERNEL_CHECKOUT})"
+	fi
+
+	if ! make -j"$(nproc)"; then
+		die "failed to build kernel from source tree (${KERNEL_CHECKOUT})"
+	fi
+
+	popd &>/dev/null
+}
+
 vm_start() {
 	local logfile=/dev/null
 	local verbose_opt=""
+	local kernel_opt=""
 
 	if [[ "${VERBOSE}" -eq 1 ]]; then
 		verbose_opt="--verbose"
 		logfile=/dev/stdout
 	fi
 
+	if [[ "${BUILD}" -eq 1 ]]; then
+		kernel_opt="${KERNEL_CHECKOUT}"
+	fi
+
 	vng \
 		--run \
+		${kernel_opt} \
 		${verbose_opt} \
 		--qemu-opts="${QEMU_OPTS}" \
 		--qemu="$(command -v "${QEMU}")" \
@@ -165,10 +196,11 @@ run_test() {
 	vm_ssh -- "cd '${GUEST_TREE}' && ./tools/testing/selftests/cgroup/test_dmem"
 }
 
-while getopts ":hvq:s" o; do
+while getopts ":hvq:sb" o; do
 	case "${o}" in
 	v) VERBOSE=1 ;;
 	q) QEMU="${OPTARG}" ;;
+	b) BUILD=1 ;;
 	s) SHELL_MODE=1 ;;
 	h|*) usage ;;
 	esac
@@ -177,6 +209,7 @@ done
 trap cleanup EXIT
 
 check_deps
+handle_build
 echo "Booting virtme-ng VM..."
 vm_start
 vm_wait_for_ssh

-- 
2.53.0


