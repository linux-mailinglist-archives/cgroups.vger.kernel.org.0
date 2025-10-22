Return-Path: <cgroups+bounces-10983-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E49BFA4CC
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 08:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78E23B6D54
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 06:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C6248F77;
	Wed, 22 Oct 2025 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAJI0Q1p"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DBA2F25EF
	for <cgroups@vger.kernel.org>; Wed, 22 Oct 2025 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115601; cv=none; b=f3JoBQ4D2XyCDcQP6uSA6+gdWIdHseaIjmhAGV2oNy9jEGjPBVHPft8yvlZKvoDyCmuysQvNFwZPIJhRxBFX9vtDjcjgwMbD/dI4r8AEIUT1b5kDM5V99uGzx4JNC+xFmfQ9/GSlF+hO/LH7WoGYESkbeGL7JYntN+OHJZZo6eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115601; c=relaxed/simple;
	bh=cEF06Zy+jE2GjXupjO/sgss12vT6pOCvFj3vYB+YnlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O02/tmiI/1DE2uUw5DLRS3HUTWSpC/t9uGAlykl5Cdfk4G3ILlKX1KFXXYKRdp+rhm2jOpOlB8UUB8DSrgbGqOFz6LsptPf36Np7LJFsm9v3vlomDCRpTc+NZYBWF6OTveOUkqZ+sUlo+x8T5+aR00q8qGIyFJ3blv/OsCfRmx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAJI0Q1p; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e542196c7so3288745e9.0
        for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 23:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761115598; x=1761720398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MErNoE3Oc8KtB2KbTBJw3y3ELC1cuN6Tv2tQSpO+Rvc=;
        b=iAJI0Q1p512xDLCivfREjddK//r/bFniHTLSKcfA71whL0C3ZPzmkGo1E/vB6VYs6r
         Xqgdhxr6sMfG0wYJPgmZ05jfS0BY9BRCCwqJBhdipSnihfJY5ZgCpWkzVO3z4eqRiN3h
         Ry3UzoSfGSyiHZeG+AFEyIeux1Z6Q69geR+nD3fqb6ZqUBFAc2Jxzm/zDiL2OY6kfVWD
         0GYGsvWZY65O/lukUeTH4McRvrfcUiQFusJhvVq4xJmiKyHcFl/D82USK3Y4+c/AwCe4
         3sIjGrl7yIe4DMuHo5y+56sqLYyIxAjHQxoNt6Ch4xzEH9lfMB7MO2PNWdJ48/cclNk9
         WptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115598; x=1761720398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MErNoE3Oc8KtB2KbTBJw3y3ELC1cuN6Tv2tQSpO+Rvc=;
        b=IpPwCu4hDiiAIgwozMzJI2eKlmKUe/qCLobEJvGA9MlmRkcalTNPSZLqTaeVo/fbn0
         b9SgAfAk4zkK4sobJ0oIJlbSvRd70yhe2f/4KkC1nrFKMY4I+QvqoSYHtAs9ZWrBZieL
         MFFV6abTO8Vvodlxj7FTQ+pOHRRTuKe8IBUDW+4ZwsqcDdukfYu0iU6o9zuIw0OdMDkI
         t6rnHhVC/UxLl9L23N+hdBvaKD3ExpnbUFj6Sb3TooEiXJ/al8IJrPwvM76HW5W77kdW
         Xg/UHm0CdVwrciMgs3lmqZbDiXAgEwMUiL5xhbcj59Y/huh/NoTGlkigh6qVqLY03qW0
         bqVQ==
X-Gm-Message-State: AOJu0YwnnhiwYpvPbJVntAElz9iQ3BJuWxNPL5Ifk2aslqD91MWET2M7
	ft0+yk22oGFeATHZbyUp6WXp95rF86WDyE8/Wskm+vtwAqwJ4PuHJfoblTUzJQ==
X-Gm-Gg: ASbGncs+owfEMU1Ew9rChrjH0wnbmrq7FO3OIWakfi7UlMSDWs+yKKanuRlXrTdYg0t
	cUaSrMTnDt7+hRSeSj6mRf35haLGPfEfJ9ZIdzLeUYRy5B/ZEonouwhVxUFpFPFwPTWAdh2LYCe
	YeAtke5T0VZJ8zM3xziyfH1Hz3Ix8GyxvlMIr8P93qFQLobtOGGyJDeu6cPwTy3JMOz06ND2AQP
	xd4/O1v1U5LXEDx9R+5/D+3NlKbfoUjD1mYNKqYfY/3p9nyGlXw3ZUadn/q+IfO/9Xm1lKUnehe
	KmkGY6Hbq/PBKoAoakoQYkTf8s3IHjXWf+WjoHQAzLWYpBjqiVBSNTxeq3S9DgZNgO29702jm54
	uUyoQGE7fAK02rLqrPDdCZXdegnC3CK4zJ9NS2+4F6duHkAxVYhjRmkt6fgeIMIoc4Ey7UEwVfM
	xrGdQD2gpK0Bmus3qkaxRWscszZsHBWmndx3GGsZc+errdeLBjmg==
X-Google-Smtp-Source: AGHT+IHZLRlsWwSuiFdqwvMg+By3QgpbEVHv4v+lvfticys6hhlpkBT1TKawan+bOiWtEx14ibRoyw==
X-Received: by 2002:a05:600c:638f:b0:46e:1a60:c995 with SMTP id 5b1f17b1804b1-475c3f97a6cmr16292265e9.2.1761115598036;
        Tue, 21 Oct 2025 23:46:38 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b5esm29931785e9.15.2025.10.21.23.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:46:37 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 5/5] selftests/cgroup: add aggregated CPU test metrics report
Date: Wed, 22 Oct 2025 08:46:01 +0200
Message-ID: <20251022064601.15945-6-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022064601.15945-1-sebastian.chlad@suse.com>
References: <20251022064601.15945-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 .../selftests/cgroup/metrics_report.txt       | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/metrics_report.txt

diff --git a/tools/testing/selftests/cgroup/metrics_report.txt b/tools/testing/selftests/cgroup/metrics_report.txt
new file mode 100644
index 000000000000..7bc1b428d2fd
--- /dev/null
+++ b/tools/testing/selftests/cgroup/metrics_report.txt
@@ -0,0 +1,20 @@
+21.10.2025
+kernel: 6.17
+Test run: test_cpu
+Env: VM
+    Architecture: x86_64
+    CPU(s): 4
+    Thread(s) per core: 1
+    Core(s) per socket: 1
+    Socket(s): 4
+
+| test                                      | tolerance | avg_error_%   | min_error_%   | max_error_%   | pass_rate_%  |
+| ----------------------------------------- |---------- | ------------- | ------------- | ------------- | -------------|
+| test_cpucg_stats                          |    1      |     0.016     |    0.01       |     0.03      |     100      |
+| test_cpucg_nice                           |    1      |     0.067     |    0.02       |     0.27      |     100      |
+| test_cpucg_weight_overprovisioned         |    35     |     1.023     |    0.06       |     3.10      |     100      |
+| test_cpucg_weight_underprovisioned        |    15     |     0.010     |    0.00       |     0.03      |     100      |
+| test_cpucg_nested_weight_overprovisioned  |    15     |     0.923     |    0.18       |     2.21      |     100      |
+| test_cpucg_nested_weight_underprovisioned |    15     |     0.008     |    0.00       |     0.02      |     100      |
+| test_cpucg_max                            |    10     |     5.886     |    3.06       |     8.35      |     100      |
+| test_cpucg_max_nested                     |    10     |     7.065     |    4.37       |     13.39     |     90       |
-- 
2.51.0


