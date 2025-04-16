Return-Path: <cgroups+bounces-7605-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28354A90DC0
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 23:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B053BC52A
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 21:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8E214235;
	Wed, 16 Apr 2025 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="In6jFld7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810AD15F41F
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744838498; cv=none; b=GVG2L3dwOAIru5LAb2lIXGT/8/ciRpwmJy4djhH5PbKWNwqbOACBYOHOWYgnJUS3iX38U2DXdL8/7ZMVzt6wU16xHuZXdf2UOoOkugWSTgras7c4k2oZdGkbMy1N8PyP2t6RTZoO3sQJMNrIR/8IDom17ePzAAvqcNeHFkr1eMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744838498; c=relaxed/simple;
	bh=DVoqT8qsDRyJhgtJ1VvvxghcA00Ab+2wkNy3Iz+ewhs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WZmxL1F7/tta+c3V51O9IEc2lZaeOdCjVYK0auJGOW2VRDxJRnoclq/Lp+nJLZcEiIvNLLvNzjEaf7wB72L2+xH95+mJ1xrVAbtwTZWnnly7rNN+ioLZo+yxzha7OttcoPfXQmtJ8KruA3ERvGXazUn28cQqxxvN+FE+FXJlPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=In6jFld7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7370e73f690so54155b3a.3
        for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744838495; x=1745443295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkndMNdYvDec99tXS1CiK27/3EziB9EOgZrv4lFSVDA=;
        b=In6jFld7R7PJ3FEK4tqAtcw1TUHhzOW+MOrc2GwGGmO5njJXAXDSCG99jfe0XnWGPC
         Xyz5i9ZE1lwpzDGwt71cnp1VVx4WHfHKayvXEcTy5+QNog3TS651V+/OtrYJ3JdrMSg7
         Kp91LHOZhKzvLuNktbTZBqY7Nnu/6uWJCjTbnC7N8KY0426Ke+dknHXnLdm+IM/RmZrY
         O/h3iR5ldSgGpAPBJ8Pj0Hlsl/BfE+fbVSe43J1P5aKlq4raR4katRLMxmFzzrKnzmxK
         NFzfWXKHcWMVP1m6frfQGBYI3gEpfQP3/P90pnv0C9x2sxhZGpMGVomIHdBOXtUwu5d/
         yTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744838495; x=1745443295;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkndMNdYvDec99tXS1CiK27/3EziB9EOgZrv4lFSVDA=;
        b=Mhl90F+tZbu0QcPYW3RsWc+CZVjGP3IBQWW0NfYQ6BMr5jdVCYJCyo/O9KCbAL+VS+
         FBFMQRbcdlvAJmFXb4H3QHhh3D69vHZwUckkkWWv+xdqQF2w3iXb2jQWLp3x2Ae72lnN
         NynyWOHmQZOH+CDT8vOqmh/+c5of0MKfdvotzGSXUoRwTK9rHi05JUcWFr5Rdp+pasG+
         chhQbTJNNW5mMrT4e1KZnvLE1pFS/6kMPuPfquBAeGbUI4Bh7Csw5YXNCYUAWUfyb1mj
         YzCAJRPjn6E6HiHzHP6aCNz0jiVZQ1Q+7uQN1mNpb7TwNSIkxv43xxsCxTYQHOLhv4VT
         RcUw==
X-Forwarded-Encrypted: i=1; AJvYcCXnb/91dXvaAbJDjNdoxvKxbihbU/+pF/MYdLjcvCuuNW8gD0lW08SbK9phH3OsFg/PSun3kIuX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ICCpzZSOPBsXcuIMaQFnY4eqiaj/SD25lelS4FoD0gOhHkBW
	qSzkzhOhY4FDxFq+/x/qY0MfElTaQGToAd7DAGfDHVDT+8UHLQ5SWqQ0MgjSyGUApQUIkLD6sm1
	eLqutrAnpUUwPqA==
X-Google-Smtp-Source: AGHT+IGSAwE6TnAMGW+PAVbupvu/6ji9u/tyeYWJaw6uEs3vaTNPMr2u27sbf6BxGvanlfKwPdlqnvLBi1b8Yxw=
X-Received: from pfvx7.prod.google.com ([2002:a05:6a00:2707:b0:73c:25ef:3578])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2ea7:b0:73b:71a9:a5ad with SMTP id d2e1a72fcca58-73c267e1db0mr4729877b3a.16.1744838494831;
 Wed, 16 Apr 2025 14:21:34 -0700 (PDT)
Date: Wed, 16 Apr 2025 21:17:51 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416211752.945849-1-tjmercier@google.com>
Subject: [PATCH v3] cgroup/cpuset-v1: Add missing support for cpuset_v2_mode
From: "T.J. Mercier" <tjmercier@google.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Waiman Long <longman@redhat.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Kamalesh Babulal <kamalesh.babulal@oracle.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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
none on /dev/cpuset type cgroup (rw,relatime,cpuset,noprefix,cpuset_v2_mode=
,release_agent=3D/sbin/cpuset_release_agent)

[1] https://cs.android.com/android/_/android/platform/system/core/+/b769c8d=
24fd7be96f8968aa4c80b669525b930d3
[2] https://cs.android.com/android/platform/superproject/main/+/main:system=
/core/libprocessgroup/setup/cgroup_map_write.cpp;drc=3D2dac5d89a0f024a2d0cc=
46a80ba4ee13472f1681;l=3D192
[3] https://lore.kernel.org/lkml/f795f8be-a184-408a-0b5a-553d26061385@redha=
t.com/T/

Fixes: e1cba4b85daa ("cgroup: Add mount flag to enable cpuset to use v2 beh=
avior in v1 cgroup")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Waiman Long <longman@redhat.com>
Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
Acked-by: Michal Koutn=C3=BD <mkoutny@suse.com>
---
v2: Limit cpuset params to just cpuset_v2_mode instead of all of cgroup1_fs=
_parameters per Michal and Waiman
v3: Make cpuset_fs_parameters static per Kamalesh Babulal

 kernel/cgroup/cgroup.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 27f08aa17b56..0d83ac266a00 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2353,9 +2353,37 @@ static struct file_system_type cgroup2_fs_type =3D {
 };
=20
 #ifdef CONFIG_CPUSETS_V1
+enum cpuset_param {
+	Opt_cpuset_v2_mode,
+};
+
+static const struct fs_parameter_spec cpuset_fs_parameters[] =3D {
+	fsparam_flag  ("cpuset_v2_mode", Opt_cpuset_v2_mode),
+	{}
+};
+
+static int cpuset_parse_param(struct fs_context *fc, struct fs_parameter *=
param)
+{
+	struct cgroup_fs_context *ctx =3D cgroup_fc2context(fc);
+	struct fs_parse_result result;
+	int opt;
+
+	opt =3D fs_parse(fc, cpuset_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_cpuset_v2_mode:
+		ctx->flags |=3D CGRP_ROOT_CPUSET_V2_MODE;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static const struct fs_context_operations cpuset_fs_context_ops =3D {
 	.get_tree	=3D cgroup1_get_tree,
 	.free		=3D cgroup_fs_context_free,
+	.parse_param	=3D cpuset_parse_param,
 };
=20
 /*
@@ -2392,6 +2420,7 @@ static int cpuset_init_fs_context(struct fs_context *=
fc)
 static struct file_system_type cpuset_fs_type =3D {
 	.name			=3D "cpuset",
 	.init_fs_context	=3D cpuset_init_fs_context,
+	.parameters		=3D cpuset_fs_parameters,
 	.fs_flags		=3D FS_USERNS_MOUNT,
 };
 #endif

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
--=20
2.49.0.777.g153de2bbd5-goog


