Return-Path: <cgroups+bounces-7589-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BBCA8AC54
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 01:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CC63B6CB1
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 23:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414562D8DDF;
	Tue, 15 Apr 2025 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlAkekxK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F562D8DBA
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744761202; cv=none; b=AVYxGeFiC6WOBfSnKUw0mjHH0ZyQ72UhRBtVkEOtScYC1beSFqlN87Dk1Durz05gXL2NGF7cYGZmBtPs12aTzA0Fr4QqEIL8XFK4nrl5X23KXKGTkrLQtEFNS9knwodzSIOTtijLssZ4y8XgBQB69v1Wonv2a2VYb6/ZSxWvaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744761202; c=relaxed/simple;
	bh=HXkqcx2ZNAR3MgBMkemVZlr6XaFgZx7DtM8Y81VBFzs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hCQ3R624YA6tb3zjIwLuJB2+xBbPSuuJReM+IEo6ekNPp55A+AfkL88/7kOljWkurHiOkuZeZXoizOuND7EyUdPnCFpvXyojhcMMrkKbXIow1V5oBHMrxcaNd/nvG7rU10K8BHcGioOcf/PGRSbkP+jqj9a8ouWSL1YsMfAIJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KlAkekxK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7394792f83cso4495967b3a.3
        for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744761199; x=1745365999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/YGrgTL2+oDLw5q7YMCd5Rvj3aEMaQaNt09r3bkhF+Q=;
        b=KlAkekxKtoiNjmjp8aOxbFckDoSGja0vL1MsKHleW/WJmK0Gc35pVJVkHdE9JylJjg
         +/N6whVm0Vm8R0c1dINa2x9cateI4fvUQ1S/Qw2XcxV2n+0SOR9prCGNw4C7dS7cujWT
         9VWb1yO91TyJMYTRLioIdEdr+1cHOIiiQHffS/ZPjkP44F36fE9+NR984ana8sTbzN8R
         L+E/sWVCsg44kkCDEjRr5ne+vNsaU59p/kkYUn3njxO16eBg3640eXSBAK4DTmNxIzY0
         kNGGaTZYQ2mNoME7C4P6WQu3ynRCzM82RREJ4w5KOdptSM/p9GLpy5X3CoNJuXp0xS5S
         8RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744761199; x=1745365999;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/YGrgTL2+oDLw5q7YMCd5Rvj3aEMaQaNt09r3bkhF+Q=;
        b=kx3FT8r03KqnuSSVJH8glTNDl1KtyJzU2w7tVxqNiFPFftwP7sJqXr2WnN0Bb6adbs
         tC7Sbn+1YsxN/QCIyokpPlEPde2YVyhyfuygb9KqreRalKP1o+zr7r4i+HAwIw1y5YLX
         rhKj3QwAPPLhzP1zshYDqTikt5B6seLOJQkeLTqBtStURCiKV4jJmS9WFAzgOSnuoaOi
         epMLJn/wRvwoF37mSqix57MDNEGke6zFeVEQTyj/KDnrIfMuOWOnHlPYcuhRqcAabJYx
         /us4isQAt1x+ZQ3GeXm+T6SnoMKW+udUKFfWBHoOMjEqZYUVLZbZX6VyemPYjMGmqeVx
         /5jw==
X-Forwarded-Encrypted: i=1; AJvYcCWU+g7Zubg9IF9ADZI+lvQojyPNBNSbiRwSAd3LeqOOJokTDPohcR10jRQUOyh7H8O7KD25Fh0V@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRvwpLhjTAyBW1rcSiZpBc9TG0fhMLRxhTaNLGktPZ2CzpDDF
	qvHqj74K6DWel4AGWaBRMp4vxNdPAPfdh2LQQlEu7Kivcpf9OZuhWnhOVCxTj+VdEB6R9bni0kf
	tGeRvHpyPIqX5xg==
X-Google-Smtp-Source: AGHT+IE7bA+Epf0Jw9RBloEojnGr5yL1MgbHZ3M/WXOieK8JDAU4vde/iJaqsYqpSx1NFMbLMFBdp5uyhqF4/ec=
X-Received: from pfiu22.prod.google.com ([2002:a05:6a00:1256:b0:730:8b4c:546c])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:9308:0:b0:736:ab48:5b0 with SMTP id d2e1a72fcca58-73c1f8c3c9cmr1921173b3a.2.1744761198662;
 Tue, 15 Apr 2025 16:53:18 -0700 (PDT)
Date: Tue, 15 Apr 2025 23:53:07 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250415235308.424643-1-tjmercier@google.com>
Subject: [PATCH v2] cgroup/cpuset-v1: Add missing support for cpuset_v2_mode
From: "T.J. Mercier" <tjmercier@google.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Waiman Long <longman@redhat.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Android has mounted the v1 cpuset controller using filesystem type
"cpuset" (not "cgroup") since 2015 [1], and depends on the resulting
behavior where the controller name is not added as a prefix for cgroupfs
files. [2]

Later, a problem was discovered where cpu hotplug onlining did not
affect the cpuset/cpus files, which Android carried an out-of-tree patch
to address for a while. An attempt was made to upstream this patch, but
the recommendation was to use the "cpuset_v2_mode" mount option
instead. [3]

An effort was made to do so, but this fails with "cgroup: Unknown
parameter 'cpuset_v2_mode'" because commit e1cba4b85daa ("cgroup: Add
mount flag to enable cpuset to use v2 behavior in v1 cgroup") did not
update the special cased cpuset_mount(), and only the cgroup (v1)
filesystem type was updated.

Add parameter parsing to the cpuset filesystem type so that
cpuset_v2_mode works like the cgroup filesystem type:

$ mkdir /dev/cpuset
$ mount -t cpuset -ocpuset_v2_mode none /dev/cpuset
$ mount|grep cpuset
none on /dev/cpuset type cgroup (rw,relatime,cpuset,noprefix,cpuset_v2_mode,release_agent=/sbin/cpuset_release_agent)

[1] https://cs.android.com/android/_/android/platform/system/core/+/b769c8d24fd7be96f8968aa4c80b669525b930d3
[2] https://cs.android.com/android/platform/superproject/main/+/main:system/core/libprocessgroup/setup/cgroup_map_write.cpp;drc=2dac5d89a0f024a2d0cc46a80ba4ee13472f1681;l=192
[3] https://lore.kernel.org/lkml/f795f8be-a184-408a-0b5a-553d26061385@redhat.com/T/

Fixes: e1cba4b85daa ("cgroup: Add mount flag to enable cpuset to use v2 behavior in v1 cgroup")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/cgroup/cgroup.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 27f08aa17b56..cf30ff2e7d60 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2353,9 +2353,37 @@ static struct file_system_type cgroup2_fs_type = {
 };
 
 #ifdef CONFIG_CPUSETS_V1
+enum cpuset_param {
+	Opt_cpuset_v2_mode,
+};
+
+const struct fs_parameter_spec cpuset_fs_parameters[] = {
+	fsparam_flag  ("cpuset_v2_mode", Opt_cpuset_v2_mode),
+	{}
+};
+
+static int cpuset_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, cpuset_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_cpuset_v2_mode:
+		ctx->flags |= CGRP_ROOT_CPUSET_V2_MODE;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static const struct fs_context_operations cpuset_fs_context_ops = {
 	.get_tree	= cgroup1_get_tree,
 	.free		= cgroup_fs_context_free,
+	.parse_param	= cpuset_parse_param,
 };
 
 /*
@@ -2392,6 +2420,7 @@ static int cpuset_init_fs_context(struct fs_context *fc)
 static struct file_system_type cpuset_fs_type = {
 	.name			= "cpuset",
 	.init_fs_context	= cpuset_init_fs_context,
+	.parameters		= cpuset_fs_parameters,
 	.fs_flags		= FS_USERNS_MOUNT,
 };
 #endif
-- 
2.49.0.777.g153de2bbd5-goog


