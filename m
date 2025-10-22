Return-Path: <cgroups+bounces-10979-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 910D7BFA4AE
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 08:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 094AC352F27
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 06:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CCA2F1FF3;
	Wed, 22 Oct 2025 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haALLcUn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9B221F26
	for <cgroups@vger.kernel.org>; Wed, 22 Oct 2025 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115595; cv=none; b=kXlCJqtWpK6IVJaQDzXOfs7ZnTcynoOwGF0cTIBzbNucB2qPWgKvKRNWYFeBxWtWHn2xbZoj75IvTi2Ks14ZnOO3nyiMMNVju8AZEItWnN2uX84cTUrtKP7TbfC6NLd0VS5ux8QbvwTvgxuWZXHjTYLkBZ+1bAVJGxDFoAmzDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115595; c=relaxed/simple;
	bh=1UulElBHKfxxScK8wn2BLyKt1aRcTD3/+SRbq88LCiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOaTgU1D/YflbxOxEWehSJseViuUH00/v2TXBja1mMyaA60uLDk09fsxEwRjaG75PFR7ahz7zfsdkOwdUmT5bPzxIgeDj/qr58IB2kj/fAz4WzzaEsvheRU9sEj5jFPFuUzZQGl+D1lB5Gmi3GGXjIOJI1iFTp7Bckq/hlD6c/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haALLcUn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso58645085e9.2
        for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 23:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761115592; x=1761720392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTKkh8s/918YhmgJv5HjtOWHvqmqP6XRaxeaftvWp5o=;
        b=haALLcUnPUql9oZDlFmS8wiGjR3idRllOKbeMzDDrfVtypCRkl1oKTEpAuZD0AhHKU
         qJdou6E3s9BU0AMNmUear095iFJTduhJ0OyT6EStWlUKsRXwD1xlU4cleUWmjkxgrEQH
         JSFCnVhBe1hNWwecYOAOUJeZDAte/Th4V+dPPUieXx7ML+vNAM7Y+r+/gu1eOk0u5ap/
         DvGvoJWMubgC6Roq7ZbcfWOj7VZE7oWpQj9FLDwjCVdheDz/q48cNBMBbgF/3aJFJQlO
         sk8Lb63XGmy49rUeLq1+L/3ezHtD6pvXxzMB3rj6jP8sOYSOiY4pNbv/RHMm/3Z2OmQz
         V3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115592; x=1761720392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTKkh8s/918YhmgJv5HjtOWHvqmqP6XRaxeaftvWp5o=;
        b=jg/j6zA00K4UiGwsXA/UCzCq/YV7QQkUcon9KFBY1Vq5S6Ca7XLmZnQYPv+rJ4+24s
         3F2FqRiROmOhIVWqY7iIPCPypm2Ehcp+/VMHv084VrlhYESd99Mwsl+mZr2QrkeZBE75
         9/EbgDIgRwdOLF3t1xL4YNjLPP+9kjh/zUbOvZ3rKuZJ1oEiod5HR5Clyzu73Qawq4MC
         zXej0CDzRsjDLxyWsOEVSIb9c88JslQS80+rq9N9szvKja2CwcAL2hmxjVy8KZyj2Qec
         wAN7KbT70EUAYtThUaYDrBgfrjQuGys2U/JGiOCAvR2qnV+rTUCludWT7fZFtDiwp4Ai
         Oh8w==
X-Gm-Message-State: AOJu0YyKgfje079gRFY69PY2XdqckZ/lON4RKGkIhRYrv4wy43jPS8cJ
	QnbmCLTjxn/WdF4VqZPdidYVYQ3LyYiRKK3YaXS+Q93Xv0aXRY92NmDZf0IaoA==
X-Gm-Gg: ASbGncuZtM2kJSUe0MqNmi1v2foiddMeFCvrGAY0jcIF/hxQYEm4xm+P7fHfDnBkkoZ
	coz7hr4RH927kG1/5T9Yakwnkxi/JauGW9TI5HtXMFadg8a5h67Ob6euH+/48Ck9Z3jxP7XsJqO
	50bCYTdo43nfupsYyGdOt0xKHkKYy3VOcgkZXAi3Y+b+PbWW+g5jZ8mBYSJ9Sq3zDZzTySqKXGz
	keyovv+jznXU/FJf6pM5Zjh2TJwWnl9MJbq2T2x/KkHeJmLAe0f3lyg7wNGq8schs7xDHBQ/LIK
	V/ygr0QFCr1TdX+NaPNBH0lZgKKTTVlsgrFjDsknw1brN5i4guuJVIidpX/NVXVLnjng9CwI11+
	TfgpiQhBZQqoGZE4ALAUkBvGJP0pnH160WGZKE7XEyWFlUUNrbdJmCkfZIL9o9qy0HaRKKX19V5
	WQ69TAvlM2rh2d4ThBZfvU+RuCOC9iXxT/IrbOipnpMhZIvle+YX4xfgeadPSa
X-Google-Smtp-Source: AGHT+IF4aa51mbYAuiM6BIKzeXDl8fdB3pCpMYL7ygEC1zUvWy5AoZXaViU3O96dypGfOzPCZxEQrg==
X-Received: by 2002:a05:600c:3e07:b0:46f:b32e:5292 with SMTP id 5b1f17b1804b1-47117872663mr157254775e9.8.1761115591730;
        Tue, 21 Oct 2025 23:46:31 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b5esm29931785e9.15.2025.10.21.23.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:46:31 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 1/5] selftests/cgroup: move utils functions to .c file
Date: Wed, 22 Oct 2025 08:45:57 +0200
Message-ID: <20251022064601.15945-2-sebastian.chlad@suse.com>
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
 .../selftests/cgroup/lib/cgroup_util.c        | 28 ++++++++++++++++++
 .../cgroup/lib/include/cgroup_util.h          | 29 ++-----------------
 2 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
index 44c52f620fda..a8fe54eb38d1 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -21,6 +21,34 @@
 
 bool cg_test_v1_named;
 
+/*
+ * Checks if two given values differ by less than err% of their sum.
+ */
+int values_close(long a, long b, int err)
+{
+	return labs(a - b) <= (a + b) / 100 * err;
+}
+
+/*
+ * Checks if two given values differ by less than err% of their sum and assert
+ * with detailed debug info if not.
+ */
+int values_close_report(long a, long b, int err)
+{
+	long diff  = labs(a - b);
+	long limit = (a + b) / 100 * err;
+	double actual_err = (a + b) ? (100.0 * diff / (a + b)) : 0.0;
+	int close = diff <= limit;
+
+	if (!close)
+		fprintf(stderr,
+			"[FAIL] actual=%ld expected=%ld | diff=%ld | limit=%ld | "
+			"tolerance=%d%% | actual_error=%.2f%%\n",
+			a, b, diff, limit, err, actual_err);
+
+	return close;
+}
+
 /* Returns read len on success, or -errno on failure. */
 ssize_t read_text(const char *path, char *buf, size_t max_len)
 {
diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index 7ab2824ed7b5..d0e8cfbc3a4b 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -17,33 +17,8 @@
 #define CG_NAMED_NAME "selftest"
 #define CG_PATH_FORMAT (!cg_test_v1_named ? "0::%s" : (":name=" CG_NAMED_NAME ":%s"))
 
-/*
- * Checks if two given values differ by less than err% of their sum.
- */
-static inline int values_close(long a, long b, int err)
-{
-	return labs(a - b) <= (a + b) / 100 * err;
-}
-
-/*
- * Checks if two given values differ by less than err% of their sum and assert
- * with detailed debug info if not.
- */
-static inline int values_close_report(long a, long b, int err)
-{
-	long diff  = labs(a - b);
-	long limit = (a + b) / 100 * err;
-	double actual_err = (a + b) ? (100.0 * diff / (a + b)) : 0.0;
-	int close = diff <= limit;
-
-	if (!close)
-		fprintf(stderr,
-			"[FAIL] actual=%ld expected=%ld | diff=%ld | limit=%ld | "
-			"tolerance=%d%% | actual_error=%.2f%%\n",
-			a, b, diff, limit, err, actual_err);
-
-	return close;
-}
+int values_close(long a, long b, int err);
+int values_close_report(long a, long b, int err);
 
 extern ssize_t read_text(const char *path, char *buf, size_t max_len);
 extern ssize_t write_text(const char *path, char *buf, ssize_t len);
-- 
2.51.0


