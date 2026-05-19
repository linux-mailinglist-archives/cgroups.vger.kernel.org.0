Return-Path: <cgroups+bounces-16080-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OjtIvpGDGp/cwUAu9opvQ
	(envelope-from <cgroups+bounces-16080-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 13:18:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8555757D605
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 13:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1219830805F8
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 11:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7120A492513;
	Tue, 19 May 2026 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrotYkdF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8F4921BA
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188630; cv=none; b=tUhcaXtVlKP5c1bab9iy2Uk6wFwDsKQ9CAUTNfxmorDCgYcM2hS9aMEqKmDPY8PKQY0uwVhxwsJPajJBTb1WlPGssuRkKoxBP5r5CtsmMCREO9OaanfOzqAUKmftJxEipQ2hhx6hG4DfSfKFhO4a5aJHHRlR3cn8ez/dqRKUFyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188630; c=relaxed/simple;
	bh=FcSAjejPxHuoxCQ/CxflnTKhs9/av/kDsn4Gbquc6C0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pAiH0F79LsWwY48kY165KLx1eHU7kskUn+ShsbsyoxoU2jKVguHQDKoyXq3/LpSmjek1e+h0I8r1U1SuADSdPfbQ9cN2uYdq5nDryKXRg5pWnyEPLjgTTFZBHn8ZFu7+KqgGNzuYQNAUwhsUJF4uo/hWiLlv766ivnRIy6JkpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrotYkdF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779188627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49QC6crLbZrOXu5S070F5olmXh1MP3UwKnlYmGn/HPU=;
	b=CrotYkdFaPKVRmV/xW73AIfqXFlEZ24ePWLNpZEuM51pumQwTfufRy4i/JsRKilbnXLvvd
	ZJcinmYmxZmrXqvMcErq7w1bZkm31f+2kvIss6bR+n/MIJwKZpbRswBcURYXWKEmcdtooc
	48jAoDqm+koCiHnOOcyD6aWTHMPSbmE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-DjnvCnx2OpWaRfMulCbizw-1; Tue,
 19 May 2026 07:03:46 -0400
X-MC-Unique: DjnvCnx2OpWaRfMulCbizw-1
X-Mimecast-MFC-AGG-ID: DjnvCnx2OpWaRfMulCbizw_1779188624
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D306018002D6;
	Tue, 19 May 2026 11:03:44 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6F3230001A2;
	Tue, 19 May 2026 11:03:42 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 19 May 2026 13:03:14 +0200
Subject: [PATCH v4 4/4] selftests: cgroup: handle vmtest-dmem -b to test
 locally built kernel
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-kunit_cgroups-v4-4-f6c2f498fae4@redhat.com>
References: <20260519-kunit_cgroups-v4-0-f6c2f498fae4@redhat.com>
In-Reply-To: <20260519-kunit_cgroups-v4-0-f6c2f498fae4@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@kernel.org, echanude@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779188611; l=3200;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=FcSAjejPxHuoxCQ/CxflnTKhs9/av/kDsn4Gbquc6C0=;
 b=50t6wVduStcbC+TAc1utwkksKyYrx+uQSlpG/QlSC3nDTExbimzX/qEMTnTK39ruTZnmEK5KA
 18ivyqewOFWCtlWJPWcd1PXiYRRwv/5f0010VV6I/CJYNWX9tQ8zyzZ
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16080-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vmtest-dmem.sh:url]
X-Rspamd-Queue-Id: 8555757D605
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently vmtest-dmem.sh relies on the host's running kernel or a
pre-built one when booting the virtme-ng VM, with no option to
configure and build a local kernel tree directly.

This adds friction to the development cycle: the user must manually
run vng --kconfig with the correct config fragment, build the kernel,
and pass the result to the script.

Add a -b flag that automates this workflow.  When set, handle_build()
configures the kernel using vng --kconfig with the selftest config
fragment, builds it with make -j$(nproc), and run_vm() passes the
local tree to vng --run so the VM boots the freshly built kernel.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 tools/testing/selftests/cgroup/vmtest-dmem.sh | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/vmtest-dmem.sh b/tools/testing/selftests/cgroup/vmtest-dmem.sh
index b395b7153f635..415c1722b08e7 100755
--- a/tools/testing/selftests/cgroup/vmtest-dmem.sh
+++ b/tools/testing/selftests/cgroup/vmtest-dmem.sh
@@ -15,6 +15,7 @@ readonly KERNEL_CHECKOUT="$(realpath "${SCRIPT_DIR}"/../../../../)"
 
 source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 VERBOSE=0
 SHELL_MODE=0
@@ -26,6 +27,7 @@ function usage() {
 	cat <<EOF
 $0 [OPTIONS]
 Options:
+	-b	Build kernel from source tree before booting
 	-q	QEMU binary/path (default: ${QEMU})
 	-s	Start interactive shell in VM instead of running tests
 	-v	Verbose output (vng boot logs on stdout)
@@ -60,16 +62,33 @@ function check_deps() {
 	done
 }
 
+function handle_build() {
+	[[ "${BUILD}" -eq 1 ]] || return 0
+
+	[[ -d "${KERNEL_CHECKOUT}" ]] || \
+		fail "-b requires vmtest-dmem.sh called from the kernel source tree"
+
+	pushd "${KERNEL_CHECKOUT}" &>/dev/null
+	vng --kconfig --config "${SCRIPT_DIR}"/config || \
+		fail "failed to generate .config for kernel source tree (${KERNEL_CHECKOUT})"
+	make O= KBUILD_OUTPUT= -j"$(nproc)" || \
+		fail "failed to build kernel from source tree (${KERNEL_CHECKOUT})"
+	popd &>/dev/null
+}
+
 # Run vng with common flags. Extra arguments are appended by the caller:
 #   --exec <script>  for automated test runs
 #   (nothing)        for interactive shell mode
 function run_vm() {
 	local verbose_opt=""
+	local kernel_opt=""
 
 	[[ "${VERBOSE}" -eq 1 ]] && verbose_opt="--verbose"
+	[[ "${BUILD}" -eq 1 ]] && kernel_opt="${KERNEL_CHECKOUT}"
 
 	vng \
 		--run \
+		${kernel_opt:+"${kernel_opt}"} \
 		${verbose_opt:+"${verbose_opt}"} \
 		--qemu="$(command -v "${QEMU}")" \
 		--user root \
@@ -78,10 +97,11 @@ function run_vm() {
 }
 
 function main() {
-	while getopts ':hvq:s' opt; do
+	while getopts ':hvq:sb' opt; do
 		case "${opt}" in
 		v) VERBOSE=1 ;;
 		q) QEMU="${OPTARG}" ;;
+		b) BUILD=1 ;;
 		s) SHELL_MODE=1 ;;
 		h) usage; exit 0 ;;
 		*) usage; exit 1 ;;
@@ -89,6 +109,7 @@ function main() {
 	done
 
 	check_deps
+	handle_build
 
 	if [[ "${SHELL_MODE}" -eq 1 ]]; then
 		echo "Starting interactive shell in VM. Exit to stop VM."

-- 
2.53.0


