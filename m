Return-Path: <cgroups+bounces-15424-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HeZOawn52kf4wEAu9opvQ
	(envelope-from <cgroups+bounces-15424-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 09:30:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E745D4379BA
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 09:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07D303009E0E
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 07:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2673ACA51;
	Tue, 21 Apr 2026 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZ+HMq1R"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515339A818
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756040; cv=none; b=gtl78Ih9pcPr6blIReviOG3jpBnX5FKHMQBS1/OgmM5mNpf3m5q4klAso/YpH8iiBYMqtdF26nAvRG4gCnToWXbsAkIGoHGCMHXdX0RfZGT2Ybj3DfZUTia2nfYI3VL+mm3ucczew1Y7uynfUFbVwo46XETV3mvLIl/sVbsFGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756040; c=relaxed/simple;
	bh=r3oDADiv+N0A8T7lQH96TM08ffovG+vlf4ODJIsA3Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z8bbcQDW7g/tydnVSpDsU32QmDzjHYJ/F413/HxL3xmuOeLCHC9oFC7S0dkpxOXLyq1jqTMeqFMwkEcZGr0RBfhaxiwNxXWVgMbtzYoW8LTGvEonLlAYDWawKND9Fia3E+kmn9cAbJ+5PohYPGOvzbqQx1epRCcfPzuxjI1NyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZ+HMq1R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776756038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAEpDAchAD1vBPaag8bT1as/DxfEf/i9ISWEXwjmEg4=;
	b=hZ+HMq1RbnQ5dSi+udhu36OSPF5xUjSLS88e9Z/UHWghnMbp4y+nvuoCluj3RtmSeVNudE
	6dvbbiztwf8xO/yJHju3GBZ7EXuVPKENVJpA9le2aVMnFWHlfp+Y08vLQIgA8Ctq8IPosH
	7X+19OzMEYhcjg2vxrvH0HnQGUx7qhY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-iW5YCpy7Pqeb_aiSM6uFmQ-1; Tue,
 21 Apr 2026 03:20:35 -0400
X-MC-Unique: iW5YCpy7Pqeb_aiSM6uFmQ-1
X-Mimecast-MFC-AGG-ID: iW5YCpy7Pqeb_aiSM6uFmQ_1776756033
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D47661800464;
	Tue, 21 Apr 2026 07:20:33 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4552A195608E;
	Tue, 21 Apr 2026 07:20:31 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 21 Apr 2026 09:19:50 +0200
Subject: [PATCH v2 4/4] selftests: cgroup: handle vmtest-dmem -b to test
 locally built kernel
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-kunit_cgroups-v2-4-bb6675d8249c@redhat.com>
References: <20260421-kunit_cgroups-v2-0-bb6675d8249c@redhat.com>
In-Reply-To: <20260421-kunit_cgroups-v2-0-bb6675d8249c@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@redhat.com, Eric Chanudet <echanude@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776756020; l=2885;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=VyPxWSFvU4OcET+PkfTmCG2H+xrQkI2juMymHBuFUyY=;
 b=VWGhi3RDtL9AdYDYlykueSsNZ4apNw6iwuzCH91Angksv5T6oALG7Twi0URclS4Sr5UKKJW2v
 L4CyOIojxzSA3a+FS4h1pDmAa/K2i5ahPPmccPbJKAQmoYG0DhI/NxX
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
	TAGGED_FROM(0.00)[bounces-15424-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmtest.sh:url,vmtest-dmem.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E745D4379BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 tools/testing/selftests/cgroup/vmtest-dmem.sh | 34 ++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/vmtest-dmem.sh b/tools/testing/selftests/cgroup/vmtest-dmem.sh
index 3174f22b06361..a5f1e529e1aa0 100755
--- a/tools/testing/selftests/cgroup/vmtest-dmem.sh
+++ b/tools/testing/selftests/cgroup/vmtest-dmem.sh
@@ -23,6 +23,7 @@ readonly WAIT_TOTAL=$((WAIT_PERIOD * WAIT_PERIOD_MAX))
 readonly QEMU_PIDFILE="$(mktemp /tmp/qemu_dmem_vmtest_XXXX.pid)"
 readonly QEMU_OPTS=" --pidfile ${QEMU_PIDFILE} "
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 VERBOSE=0
 SHELL_MODE=0
@@ -72,17 +73,46 @@ check_deps() {
 	done
 }
 
+handle_build() {
+	if [[ ! "${BUILD}" -eq 1 ]]; then
+		return
+	fi
+
+	if [[ ! -d "${KERNEL_CHECKOUT}" ]]; then
+		echo "-b requires vmtest.sh called from the kernel source tree" >&2
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
 
 	if [[ "${VERBOSE}" -eq 2 ]]; then
 		verbose_opt="--verbose"
 		logfile=/dev/stdout
 	fi
 
+	if [[ "${BUILD}" -eq 1 ]]; then
+		kernel_opt="${KERNEL_CHECKOUT}"
+	fi
+
 	vng \
 		--run \
+		"$kernel_opt" \
 		${verbose_opt} \
 		--qemu-opts="${QEMU_OPTS}" \
 		--qemu="$(command -v "${QEMU}")" \
@@ -165,10 +195,11 @@ run_test() {
 	vm_ssh -- "cd '${GUEST_TREE}' && ./tools/testing/selftests/cgroup/test_dmem"
 }
 
-while getopts ":hvq:s" o; do
+while getopts ":hvq:sb" o; do
 	case "${o}" in
 	v) VERBOSE=$((VERBOSE + 1)) ;;
 	q) QEMU="${OPTARG}" ;;
+	b) BUILD=1 ;;
 	s) SHELL_MODE=1 ;;
 	h|*) usage ;;
 	esac
@@ -177,6 +208,7 @@ done
 trap cleanup EXIT
 
 check_deps
+handle_build
 echo "Booting virtme-ng VM..."
 vm_start
 vm_wait_for_ssh

-- 
2.52.0


