Return-Path: <cgroups+bounces-17533-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KtOkHrOdS2o5XAEAu9opvQ
	(envelope-from <cgroups+bounces-17533-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 14:21:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C1871073A
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 14:21:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Cr2OF1YO;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17533-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17533-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB9FF304D688
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7659D42464E;
	Mon,  6 Jul 2026 12:07:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0642378D
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 12:07:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339652; cv=none; b=MSwx7HnnxF/E/lkg/jXk9PhxzFIOR16Bx6OH+bN3fuo0wBwauLY33QWW3AXW0mJePhsbhN+WUUFFR0IQql7eMJyFNpA14RzjSNuFuNgurukMF8zJhtEfUU1qQ+oUJ23UQw5TkBxyddE1LlqwBWbCYhBtQB8/qoPxYFm7nQS+zmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339652; c=relaxed/simple;
	bh=eavUpsZxei5UtAZevT1ijzwKnp6hdPdATdDPDVBgwss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kj3vk4/6dsHqgQ+SNk7DA5031R0ptX0HIQBnhoO6wAiEiq7gqllu6nV+HV+gI0kOHBXiWu5KSpVLChC44ujjyt3aVsKWrBp3R3UShrrATXMSqQxqKRz5MnxHQzzOo7rPNf3oBWIT3ft8f/uu3kMwkj5tvfFiFx3RMK7WsCijkoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cr2OF1YO; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783339649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYc4YxXkMADptX22VOsP9bchD2b9RbGYp9Ru3MzZ4oY=;
	b=Cr2OF1YOJOJHWixRaPAtpGSPD+Pn4hdPY0dI/NUxtepeRkfF7RTwvw8xde27rQw4/tFNJG
	8mXKSnx3CRxBTUQr9ATZfAUEkwlcMf2T+TV9oFplw8oVvUMF8rT68OjPTtR2lJAi7XnrLY
	3VMqRr9SqA3V73GO6yMTLnxr6HyL+9A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-XCFaqTxaOBuOoyEENnVGTA-1; Mon,
 06 Jul 2026 08:07:26 -0400
X-MC-Unique: XCFaqTxaOBuOoyEENnVGTA-1
X-Mimecast-MFC-AGG-ID: XCFaqTxaOBuOoyEENnVGTA_1783339644
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 570EB180AC4F;
	Mon,  6 Jul 2026 12:07:07 +0000 (UTC)
Received: from [192.168.1.153] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA75418005B5;
	Mon,  6 Jul 2026 12:07:04 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 06 Jul 2026 14:06:43 +0200
Subject: [PATCH v5 4/4] selftests: cgroup: handle vmtest-dmem -b to test
 locally built kernel
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-kunit_cgroups-v5-4-6c42c8753468@redhat.com>
References: <20260706-kunit_cgroups-v5-0-6c42c8753468@redhat.com>
In-Reply-To: <20260706-kunit_cgroups-v5-0-6c42c8753468@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 Eric Chanudet <echanude@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783339614; l=3899;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=eavUpsZxei5UtAZevT1ijzwKnp6hdPdATdDPDVBgwss=;
 b=AbCyhwt+t21HQ5QLdnZrJSOifdRH4CW6kSPFNO1vmqGvbeFe5p02I69VqqDxq1FGC15h7T6dY
 UlIWl+1NetYBL9VLgLdI2uAIHZvej77n4Q8tH4rcTO5hhfLx3rJTxo7
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
	TAGGED_FROM(0.00)[bounces-17533-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:aesteve@redhat.com,m:echanude@redhat.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,vmtest-dmem.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64C1871073A

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
 tools/testing/selftests/cgroup/vmtest-dmem.sh | 47 ++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/vmtest-dmem.sh b/tools/testing/selftests/cgroup/vmtest-dmem.sh
index 0bb6529112b54..4d0e2c0511e5b 100755
--- a/tools/testing/selftests/cgroup/vmtest-dmem.sh
+++ b/tools/testing/selftests/cgroup/vmtest-dmem.sh
@@ -15,6 +15,7 @@ readonly KERNEL_CHECKOUT="$(realpath "${SCRIPT_DIR}"/../../../../)"
 
 source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 VERBOSE=0
 SHELL_MODE=0
@@ -26,10 +27,22 @@ function usage() {
 	cat <<EOF
 $0 [OPTIONS]
 Options:
+	-b	Build kernel from source tree before booting
 	-q	QEMU binary/path (default: ${QEMU})
 	-s	Start interactive shell in VM instead of running tests
 	-v	Verbose output (vng boot logs on stdout)
 	-h	Display this help
+
+If you build your kernel using KBUILD_OUTPUT= or O= options, these
+can be passed as environment variables to the script:
+
+  O=<build_path> $0 -b
+
+or
+
+  KBUILD_OUTPUT=<build_path> $0 -b
+
+O= takes precedence over KBUILD_OUTPUT= if both are set.
 EOF
 }
 
@@ -60,17 +73,41 @@ function check_deps() {
 	done
 }
 
+function handle_build() {
+	[[ "${BUILD}" -eq 1 ]] || return 0
+
+	[[ -f "${KERNEL_CHECKOUT}/kernel/cgroup/dmem_selftest.c" ]] || \
+		fail "-b requires vmtest-dmem.sh called from the kernel source tree"
+
+	# Figure out where the kernel is being built.
+	# O takes precedence over KBUILD_OUTPUT.
+	local out_args=()
+	if [[ -n "${O:-}" ]]; then
+		out_args=(O="${O}")
+	elif [[ -n "${KBUILD_OUTPUT:-}" ]]; then
+		out_args=(KBUILD_OUTPUT="${KBUILD_OUTPUT}")
+	fi
+
+	pushd "${KERNEL_CHECKOUT}" &>/dev/null
+	vng --kconfig --config "${SCRIPT_DIR}"/config "${out_args[@]}" || \
+		fail "failed to generate .config for kernel source tree (${KERNEL_CHECKOUT})"
+	make "${out_args[@]}" -j"$(nproc 2>/dev/null || echo 1)" || \
+		fail "failed to build kernel from source tree (${KERNEL_CHECKOUT})"
+	popd &>/dev/null
+}
+
 # Run vng with common flags. Extra arguments are appended by the caller:
 #   --exec <script>  for automated test runs
 #   (nothing)        for interactive shell mode
 function run_vm() {
-	local verbose_opt=""
+	local vng_args=()
 
-	[[ "${VERBOSE}" -eq 1 ]] && verbose_opt="--verbose"
+	[[ "${BUILD}" -eq 1 ]] && vng_args+=("${KERNEL_CHECKOUT}")
+	[[ "${VERBOSE}" -eq 1 ]] && vng_args+=("--verbose")
 
 	vng \
 		--run \
-		${verbose_opt:+"${verbose_opt}"} \
+		"${vng_args[@]}" \
 		--qemu="$(command -v "${QEMU}")" \
 		--user root \
 		--rw \
@@ -78,10 +115,11 @@ function run_vm() {
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
@@ -89,6 +127,7 @@ function main() {
 	done
 
 	check_deps
+	handle_build
 
 	if [[ "${SHELL_MODE}" -eq 1 ]]; then
 		echo "Starting interactive shell in VM. Exit to stop VM."

-- 
2.54.0


