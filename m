Return-Path: <cgroups+bounces-14041-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHzaBhqtl2nO5QIAu9opvQ
	(envelope-from <cgroups+bounces-14041-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 01:38:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C26163DF9
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 01:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D456C3018764
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBDA1EA7F4;
	Fri, 20 Feb 2026 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9hUZAP0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3914B08A;
	Fri, 20 Feb 2026 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771547923; cv=none; b=jvPlUE3RNLUJOhnfohvuSV4nlujsTvH93KvzL2faLNJtmFJVBc3Uhl+hP/uZ8qnb6M4ZJxBrTQEzoElf8LIeS9LofUV/55qttiYen0NffV7QSDk1x68DjRLZfip2Qore3yu0Qxho3XUMOxEw+02LPwyHfrQAMANQs3zG0yHslEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771547923; c=relaxed/simple;
	bh=vlTenuIT5SSnNn15C84tA21ttMtcfFEsbxxqa059xCA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KPen3sozRo79TvetFeURi89bISmXfdWW6ciQ2WpnV3eqkuiGEU8Wxcn3+y185zMfwXiU6iFho4w+Ul1HX71ucOnabWZYiJMRs0EN++K3yAksVSLaAONIRE9o5hK+hmyQWRd0QCh93Hwt19CpXQhggGR7wyodL4d+Cagela0/PxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9hUZAP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C484C4CEF7;
	Fri, 20 Feb 2026 00:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771547923;
	bh=vlTenuIT5SSnNn15C84tA21ttMtcfFEsbxxqa059xCA=;
	h=From:Subject:Date:To:Cc:From;
	b=d9hUZAP0kyh390LlYpk/oCoF9m2QeXQq4k1vJ2pAASus6W2o7EgHzYXcUG3JAcU06
	 tkHFMtiHCU73+SLGycVU7eAsCUSfw6zgCDguf9TYAfpgSA1TDp6kkFt41fOFzbYEwq
	 eQvab0+AILt1xYYdtC2geQhS07m9eTBICpPI4Gr3nwSJk4PvGMGJEvJWtu4FHDqtBK
	 kz7KWj76iHZKfzB6NgxKzO6KbC3axdT+/HKtX1UdDO82O0TNcrdINBwtl2sj982/BO
	 RaxWnNGBFCuMopAsZ+j0u+uomGPSREhwDRV3aNOdK0yWiYqRnznKME7PLSwFMlCqmX
	 7x7MvvXZjHYgg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/4] bpf: add a few hooks for sandboxing
Date: Fri, 20 Feb 2026 01:38:28 +0100
Message-Id: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAStl2kC/yWNQQ7CIBBFr9LMWsxAWgJexbgY6GDRSBuo2qTp3
 aV1NXk//79ZoXCOXODSrJD5E0scUwV5asAPlO4sYl8ZFCqNSlrxHfNTuCmIRC8uE3kWrtPWBup
 Vhwx1OGUOcTmk19ufy9s92M+7aW84KnWWKflhjw4dL/MZZWeUNtJJ1qae1vamNUGSZoXI9Zkm8
 uhh2345N4WHugAAAA==
X-Change-ID: 20260219-work-bpf-namespace-b5699fad250e
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 Lennart Poettering <lennart@poettering.net>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vlTenuIT5SSnNn15C84tA21ttMtcfFEsbxxqa059xCA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROX8uvsvaq7QmJxSaTfrI/Wlb34LJ5j5Xx253JqTO1U
 yrYYwovdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykfyEjw0cBpivNvtHhD1fe
 2z+jwrlcu1IqxHXuXKVj4fsqOsWi8hn+Rx1frBC/giurU9aP83+h0dLvroXL+F6xNZbxpS8t4ZX
 gBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14041-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76C26163DF9
X-Rspamd-Action: no action

Hey,

I'm in the process of adding "universal truths" bpf lsm programs to
systemd that implement and enforce core system assumptions.

One aspect of this will be advanced namespace management so we can have
things like systemd-nsresourced tightly manage namespaces it allocates
and implement advanced access policies for them. We already do parts of
that but it's rather limited and relies on some workarounds as well
because we don't have the infrastructure for it. We also currently need
to rely on ugly workarounds such as attaching to very arcane tracing
hooks to be notified when namespaces go away.

The second aspect is managing cgroup attaches. This is a core feature
that has been demanded for a long time in systemd. We want to be able to
ensure that some services cannot ever escape their cgroups.

The new hooks are available to bpf lsm programs. Selftests included.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (4):
      ns: add bpf hooks
      cgroup: add bpf hook for attach
      selftests/bpf: add ns hook selftest
      selftests/bpf: add cgroup attach selftests

 include/linux/bpf_lsm.h                            |  36 ++
 kernel/bpf/bpf_lsm.c                               |  37 +++
 kernel/cgroup/cgroup.c                             |  18 +-
 kernel/nscommon.c                                  |   9 +-
 kernel/nsproxy.c                                   |   7 +
 .../selftests/bpf/prog_tests/cgroup_attach.c       | 362 +++++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/ns_sandbox.c  |  99 ++++++
 .../selftests/bpf/progs/test_cgroup_attach.c       |  85 +++++
 .../testing/selftests/bpf/progs/test_ns_sandbox.c  |  91 ++++++
 9 files changed, 736 insertions(+), 8 deletions(-)
---
base-commit: 01582681b1e6881b49d848f1a6e200eace6aac0c
change-id: 20260219-work-bpf-namespace-b5699fad250e


