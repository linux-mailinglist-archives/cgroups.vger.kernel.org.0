Return-Path: <cgroups+bounces-7146-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3A6A68542
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 07:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348A2881FF4
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 06:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349524EF84;
	Wed, 19 Mar 2025 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSybLb53"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0124EF6B;
	Wed, 19 Mar 2025 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366564; cv=none; b=V2MAaJ2YqB7ONR/ADXW2ewm4f22hPIwBhoo2RURMIpjPaPP/HF9ze14b4vs86Pk3yVGR39qCod1B9hqKi5c/5FKr+LbsJ8u0lrCMCFF2SNfFJkMObGLoYIOHUi6UatK3dGsrJ3veDRiiJWg1alwTLGbNDs6z5wgvr6klQNkA/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366564; c=relaxed/simple;
	bh=yekJcRnovCpxxnQxCvankY4AaW9kF02jhHxmtnlm7Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Clm2TlUxOP8MR0S50EabHZADOFbUsn4P2BORvW1VQMLPZAEmKsdZ5A7fUBV0/tI+coEvCTAA7dq27EUSFwK7EXQvlL4ojwVIeMeDF6RXsgI+iThjSJTkRLJg7MAGyMgMkhqzxbMVKpCrswAmCYF9kc3BjhDGitymE8BHQM7vXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSybLb53; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22438c356c8so112171295ad.1;
        Tue, 18 Mar 2025 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742366562; x=1742971362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ZzC6AyENx2PETrsetwCdLxJEkubtTVJB70KlJ4iY4o=;
        b=SSybLb53VPAYuXo94t3yEntRoMzCdn+58a6aRvmt2celmuDshHCW1DySR2Fh0vR3Zw
         X10dxyMAw+qqTKZc2wEvtm0hwJIQa8UttZ3GUXdsbu/ftLsBSNpAMHDqJhVSPb0Ssc01
         PrdZD+764ykdsB9HiQFJAI14rZOcejrakfOnWChlWXE0a287n/d9V8v3qdmkiTti4vZ0
         S7BgdDvnVVLC+FrfYrwILqv6lz0k8aKiKcFgoE1Wl0v75j1zXoopUys+EJYviWxUXkVD
         1G53VcZ+z7d9o7ZNG8ilYf86oVQTdnyMfpsnfTcGPVEPESbnEcNszcn8ndLn982qqdUa
         CHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742366562; x=1742971362;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ZzC6AyENx2PETrsetwCdLxJEkubtTVJB70KlJ4iY4o=;
        b=VuvoImYlv36MKwsvuPal42IAzIsWKDO/FTlp5F+ERTScr8ekBrwwJQEudEHS3BgbKf
         JiXK2LhvncdD6zjiyEI+9IJMSYHg6AHfTkYLwKVHvOv2yI5rkrzdIQFQc4DNbWNCdMyw
         cEWPevgKGflXSXwdJQQ3mHQP3O5wLdXGYwzmLoUom+zAixLn0mkFcJ78sATY3ru7Bq1f
         bvawzZRMcO2+JGoStRTwoCUi9xUIRDGYl6x5uDJDv/So+n/oNGRgwOGruOXS+navs04I
         eicItnp+bkeOgVButk13rzh21OGZpszuAmntLiUlgR3yI+CvBmeZ9iC6nMptgUJ9LiBc
         XGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyaGpUjUN+7G3iPJDNpyAe2CUsbttRUGbUZp8Az9gPdedRYXc7akkZwyuTQZEBkoxuC7/dNJcF@vger.kernel.org, AJvYcCXQ6JJb8Wf6yRJg0jjlcXIhiQ65OnkhRo1ROeNC7XLJGsCrEw6ldhKs/97qfzs6DRdenBCsx3ylSyeYf1Qe@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqY4RmKF/35QEObKcSaN9cnlvHkvSc+8V+XNRQT/I7QnnA6eT
	JqI2tt/V50t/PBXGtZdNUDPQOY+WphODJqvpVDNNATnxy8qJ+0LK
X-Gm-Gg: ASbGncv9VJ3jlVJ3zBRGAILFOp6qlQhG90rOElWQQ3phwtBk6mw1pvGGxH3tOVozKEs
	zh0b4XUp963f36yCMwIAv6OfmICBijY2nDXrFfb9gKZqoURC5xKOyvFJNG5LgehzGzudqQ1OTbj
	hyuHMUtWDddNagPHeZHWznFv46I8ztcAdiNmr5fj5YxQYkQBsaP6l5W+qMBo32EFwSa7vppoe9U
	bl1yZHxgcVFrGjkU0znrQ71Mi4f/2hhcr2K1LHUZK+ItMyNnf4yn4XDN7KthRE38xo5N5YX7QBV
	5gLSW/QKENzoY4HSWJlRmUI12s0PVyfFpKPsIijUnBppNOyozJUNwbzJbvLTxMJlwpcku2CMLZE
	10lpY4TkCS6Fjag==
X-Google-Smtp-Source: AGHT+IGbMABhlmC/SfmCbNUIYnojPpflkLr+r17wa1mHNPi8StcJmSNkJieATMTXfn0TSct3XkdwOw==
X-Received: by 2002:a17:902:dac5:b0:226:30f6:1639 with SMTP id d9443c01a7336-22649cbf81amr20878435ad.51.1742366561776;
        Tue, 18 Mar 2025 23:42:41 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm106191835ad.70.2025.03.18.23.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:42:41 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	kasong@tencent.com,
	Zeng Jingxiang <linuszeng@tencent.com>
Subject: [RFC 5/5] Docs/cgroup-v2: add cgroup.memsw_account_on_dfl Documentation
Date: Wed, 19 Mar 2025 14:41:48 +0800
Message-ID: <20250319064148.774406-6-jingxiangzeng.cas@gmail.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
Reply-To: Jingxiang Zeng <linuszeng@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zeng Jingxiang <linuszeng@tencent.com>

Add documentation descriptions for cgroup.memsw_account_on_dfl and
CONFIG_MEMSW_ACCOUNT_ON_DFL.

Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 Documentation/admin-guide/cgroup-v2.rst       | 21 +++++++++++++++----
 .../admin-guide/kernel-parameters.txt         |  7 +++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 53ada5c2620a..58869279f0a9 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1704,8 +1704,14 @@ The following nested keys are defined.
 	A read-only single value file which exists on non-root
 	cgroups.
 
-	The total amount of swap currently being used by the cgroup
-	and its descendants.
+	If memsw_account_on_dfl and CONFIG_MEMSW_ACCOUNT_ON_DFL is not
+	enabled (the default), this interface represents the total
+	amount of swap currently being used by the cgroup and its
+	descendants.
+
+	If memsw_account_on_dfl or CONFIG_MEMSW_ACCOUNT_ON_DFL is enabled,
+	this interface represents the total amount of memory+swap
+	currently being used by the cgroup and its descendants.
 
   memory.swap.high
 	A read-write single value file which exists on non-root
@@ -1737,8 +1743,15 @@ The following nested keys are defined.
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "max".
 
-	Swap usage hard limit.  If a cgroup's swap usage reaches this
-	limit, anonymous memory of the cgroup will not be swapped out.
+	If memsw_account_on_dfl and CONFIG_MEMSW_ACCOUNT_ON_DFL is not
+	enabled (the default), this interface represents the hard limit
+	of swap usage. If a cgroup's swap usage reaches this limit,
+	anonymous memory of the cgroup will not be swapped out.
+
+	If memsw_account_on_dfl or CONFIG_MEMSW_ACCOUNT_ON_DFL is enabled,
+	this interface represents the hard limit of memory+swap usage.
+	If a cgroup's memory+swap usage reaches this limit, anonymous
+	memory of the cgroup will not be swapped out.
 
   memory.swap.max.effective
 	A read-only single value file which exists on non-root cgroups.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2758bc124f16..0aa9e4f85b51 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -644,6 +644,13 @@
 			nokmem -- Disable kernel memory accounting.
 			nobpf -- Disable BPF memory accounting.
 
+	cgroup.memsw_account_on_dfl= [KNL] Enable memory+swap account on cgroupv2.
+			Format: { "0" | "1" }
+			0 - memory.swap.current and memory.swap.max represents the
+				usage/limit of swap.
+			1 - memory.swap.current and memory.swap.max represents the
+				usage/limit of memory+swap.
+
 	checkreqprot=	[SELINUX] Set initial checkreqprot flag value.
 			Format: { "0" | "1" }
 			See security/selinux/Kconfig help text.
-- 
2.41.1


