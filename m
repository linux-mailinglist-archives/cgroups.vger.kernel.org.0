Return-Path: <cgroups+bounces-17299-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2DvSKp2QPWqD4AgAu9opvQ
	(envelope-from <cgroups+bounces-17299-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 22:33:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F876C885A
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 22:33:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=dCOzdFeT;
	dkim=pass header.d=redhat.com header.s=google header.b=dxnTHald;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17299-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17299-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB0B4301DE98
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE8369D67;
	Thu, 25 Jun 2026 20:33:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351334C155
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 20:33:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419603; cv=none; b=I9c8Pb6S04p5ysaSlZ8+3uRLu+UQYsZ9kn5xB6TA//I4SplJwcFujnid4Av6LL94tnnLP13KWygjZe2hSP2Sd/ZOV7xVWARMYlraCBkB21mgssWxHnadUODIzA4Gl4Iugo1VCdnzxy39Tc5CRhlBlcsP//JEAZntD7hfwFZgzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419603; c=relaxed/simple;
	bh=Ib7zT38GwZXZa3psJDnOOJi5CQ6/V0vu2dtXG6oowj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dueUMtwIo3yx1RDus5KHbqt7ZMvRr7qgyJKc5vSvTMil4kvkGRSmaXhRze+aeMhUJLZxGeq68ArbK/gh22mlXVtIcUABc2GDFdeXaV2yQb/xxgE/7i6yqTVzR6yV2mJqPmnoqan+JxyciJSGU4XSHmXMo90T266qt1Zvmi25YY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCOzdFeT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxnTHald; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782419601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ifHti/d727ookmtUS07phWJpYrrkEhsutg001BDn0q8=;
	b=dCOzdFeT3X3YBsx0cWl53k+KKvhe1uJZa2OL6V+0yLj0pTZZpUhbVcPZj3QzBy/Z1oFBb6
	BXUUYwDeHShZm+FP6/77FIU49tiecfMsjGnH3EQ9cYaV6z3omtyESP/xRk+8mzbkFzqbOi
	s2Nusow0hbJmrrlwF36opCI7RQzcEh0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-plmd5xebNgmrmqDwVxIzfA-1; Thu, 25 Jun 2026 16:33:17 -0400
X-MC-Unique: plmd5xebNgmrmqDwVxIzfA-1
X-Mimecast-MFC-AGG-ID: plmd5xebNgmrmqDwVxIzfA_1782419597
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8dc0a6ab3bbso6473536d6.1
        for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 13:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782419597; x=1783024397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ifHti/d727ookmtUS07phWJpYrrkEhsutg001BDn0q8=;
        b=dxnTHaldAwRH3zE3IZVm4iRMDvGWeZjwmOYRSjMO3m+2xjKz7/kNCqUBnma0wj7QrH
         ISqSVJiinDeG7pxIUpYPxzTJvZqFaN4iDyXG9C+mHNuMW1pv05u7jbH34RFLg/aTOTKy
         fsS7rXgCdkiWYlDZqB1NFqQWPWAT0oZNR8gH2N6rMFGVpZcD7srVERVRizq0uu79eSCL
         DUC/1648w9qp+SJQsGV10dxgD/f9OxYnE60S9thloz4D+f9ocKQrWomvsHv+FfyhXLQe
         /qPFyrYiwiO3TYSMrNk9FjmPagEhDz89KlKTWmZnokIFoJom/PSFc9xDHHmQ4itWmP+X
         Epmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782419597; x=1783024397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifHti/d727ookmtUS07phWJpYrrkEhsutg001BDn0q8=;
        b=B26VNNVg3dx24wPWYPtIWjyJOUJbfEnV59eugAzM0Yy/SF3bHXHTQmdhckbQF8oz3g
         4mpsrn682cJKYJvqPgILnjtpSL8hIALPSJKoofkWJz4wv7vELv8sczFqgmkjx1iJ1tCZ
         SRc9AHr4ky3gpLMHYPFZwEfSwbJphkY85Xv+xAns2LttGapNUQLcr3hzm1/4Ohx5ID2i
         I2DJfpBYBf1M4pyXeFeDjM70y1A8yFaZofvKyz8ARdhOX0GRTy+TNpkchRwyVt5z0ppz
         KK4CDr77viZMbTS5oO0Mg51Ergq2cnKvXHHhK90pEPFozyXqdNDnAmQFVzhjg68gV6Vu
         Qvdw==
X-Forwarded-Encrypted: i=1; AHgh+Rq3qkFLbnmCuZN6M/O23XPiywXK6VZiePLUPrVJ9vc/pxI+KAvnK26OpH375JFL2Vec7FHlEbgn@vger.kernel.org
X-Gm-Message-State: AOJu0YxdZz3QxGN5XjGzzvoe/dao4DsgF2mhVFBXbp6NMb9FuO8TcjNU
	oNWQdSdZHeXvojm/tXauT5RtjIJoFbv9LAr++QMX17xAB8Kp1moyapWYGNRd/2++24u2Lx1ojgJ
	6j1jvFwEe9RpygeL9hltwdfkv/8wPgyz5XS7C8fOFlJDI7SLGJSNuoUrZfvA=
X-Gm-Gg: AfdE7ckj6eyg1d6/ZNzTyLy++eWryJ72R75+6KaOC2eDyA6VIy45HRlhOVTYBJLKwbg
	RHhDJr3kWeO3H7oxA6Q5k7uJp4baNn4BuPn3TGwW/8BdLb0U0/j0VOQfVmGfj/MBOALd8jmGDE5
	Z1wAKrThy/MlLLle8gd2d86XdfHrlYi5JsIFx8sDx0eyGn0lXPknqRqGn//bB2UAR3H2iOBctxG
	YnlnEs2Wfhmjco3lUnhKzu7/iqN3puwjYsaEQZwcP7G4M9g+66GQVgkdg+nMstBSmcUtr8i0yz8
	K0HcB/Z7VWmQndh2pcd9b2dl0CtxLdxfkCFwLQ2rnI6rNuy9EAq/UDEwZMVXSHBVz5gdUyMWwP2
	C/P0HUb7CFwYnLXaWFe0knzZBGRef0hrDXOWElO0YtFKaNruH
X-Received: by 2002:a05:6214:230f:b0:8ce:ba04:7bc2 with SMTP id 6a1803df08f44-8e6d6e61085mr68947936d6.38.1782419596810;
        Thu, 25 Jun 2026 13:33:16 -0700 (PDT)
X-Received: by 2002:a05:6214:230f:b0:8ce:ba04:7bc2 with SMTP id 6a1803df08f44-8e6d6e61085mr68946986d6.38.1782419596122;
        Thu, 25 Jun 2026 13:33:16 -0700 (PDT)
Received: from oak.redhat.com (c-73-148-124-98.hsd1.va.comcast.net. [73.148.124.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f5ff5e6sm188635156d6.12.2026.06.25.13.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 13:33:15 -0700 (PDT)
From: Joe Simmons-Talbott <joest@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Joe Simmons-Talbott <joest@redhat.com>,
	cui.tao@linux.dev,
	Li Wang <li.wang@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>,
	Sebastian Chlad <sebastianchlad@gmail.com>,
	cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RESEND v4] selftests/cgroup: Adjust cpu test duration based on HZ
Date: Thu, 25 Jun 2026 16:33:04 -0400
Message-ID: <20260625203307.1114538-1-joest@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-17299-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,gmail.com,kylinos.cn,vger.kernel.org];
	FORGED_SENDER(0.00)[joest@redhat.com,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:joest@redhat.com,m:cui.tao@linux.dev,m:li.wang@linux.dev,m:shakeel.butt@linux.dev,m:nphamcs@gmail.com,m:zhangguopeng@kylinos.cn,m:sebastianchlad@gmail.com,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joest@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98F876C885A

For lower HZ values a quota of 1000us is much lower than the amount
of microseconds per tick which makes the tests test_cpucg_max and
test_cpugc_max_nested fail. Increase the test duration to accommodate
for lower HZ values.

Link: https://lore.kernel.org/lkml/20260624160358.430354-1-joest@redhat.com/
Signed-off-by: Joe Simmons-Talbott <joest@redhat.com>
---
CC: cui.tao@linux.dev
v3 -> v4:
- Use usec for adjusting test duration for better accuracy.
- Remove underscore from static function
- Use 1000 as the fallback value for hz since it's the default.

v2 -> v3:
- Instead of changing cpu.max quota extend the test duration based on
  the HZ value.
- don't call pclose() if popen() fails.
- check return value of fscanf().

v1 -> v2:
- Try checking /proc/config.gz to get the actual kernel HZ value and
  fallback to 1000 if the value cannot be determined.

 .../cgroup/lib/include/cgroup_util.h          |  1 +
 tools/testing/selftests/cgroup/test_cpu.c     | 47 ++++++++++++++++---
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index febc1723d090..8ebb2b4d4ec0 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -8,6 +8,7 @@
 
 #define MB(x) (x << 20)
 
+#define NSEC_PER_USEC	1000L
 #define USEC_PER_SEC	1000000L
 #define NSEC_PER_SEC	1000000000L
 
diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 7a40d76b9548..1f280c1db68a 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -639,6 +639,31 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
 	return run_cpucg_nested_weight_test(root, false);
 }
 
+/*
+ * Best effort attempt to get the kernel's HZ value from the config.
+ * Return the HZ value if found otherwise return 1000 (the default) to
+ * indicate failure.
+ */
+static long
+get_config_hz(void)
+{
+	long hz = 1000;
+	FILE *f;
+	char cmd[256] = "zcat /proc/config.gz 2>/dev/null | grep '^CONFIG_HZ='";
+
+	f = popen(cmd, "r");
+
+	if (!f)
+		return hz;
+
+	if (fscanf(f, "CONFIG_HZ=%ld", &hz) == EOF)
+		goto out;
+
+out:
+	pclose(f);
+	return hz;
+}
+
 /*
  * This test creates a cgroup with some maximum value within a period, and
  * verifies that a process in the cgroup is not overscheduled.
@@ -646,15 +671,20 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
 static int test_cpucg_max(const char *root)
 {
 	int ret = KSFT_FAIL;
+	long hz = get_config_hz();
 	long quota_usec = 1000;
 	long default_period_usec = 100000; /* cpu.max's default period */
 	long duration_seconds = 1;
 
-	long duration_usec = duration_seconds * USEC_PER_SEC;
+	long duration_usec, duration_sec, duration_nsec;
 	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
 	char *cpucg;
 	char quota_buf[32];
 
+	duration_usec = duration_seconds * USEC_PER_SEC * 1000 / hz;
+	duration_sec = duration_usec / USEC_PER_SEC;
+	duration_nsec = duration_usec % USEC_PER_SEC * NSEC_PER_USEC;
+
 	snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
 
 	cpucg = cg_name(root, "cpucg_test");
@@ -670,8 +700,8 @@ static int test_cpucg_max(const char *root)
 	struct cpu_hog_func_param param = {
 		.nprocs = 1,
 		.ts = {
-			.tv_sec = duration_seconds,
-			.tv_nsec = 0,
+			.tv_sec = duration_sec,
+			.tv_nsec = duration_nsec,
 		},
 		.clock_type = CPU_HOG_CLOCK_WALL,
 	};
@@ -710,15 +740,20 @@ static int test_cpucg_max(const char *root)
 static int test_cpucg_max_nested(const char *root)
 {
 	int ret = KSFT_FAIL;
+	long hz = get_config_hz();
 	long quota_usec = 1000;
 	long default_period_usec = 100000; /* cpu.max's default period */
 	long duration_seconds = 1;
 
-	long duration_usec = duration_seconds * USEC_PER_SEC;
+	long duration_usec, duration_sec, duration_nsec;
 	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
 	char *parent, *child;
 	char quota_buf[32];
 
+	duration_usec = duration_seconds * USEC_PER_SEC * 1000 / hz;
+	duration_sec = duration_usec / USEC_PER_SEC;
+	duration_nsec = duration_usec % USEC_PER_SEC * NSEC_PER_USEC;
+
 	snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
 
 	parent = cg_name(root, "cpucg_parent");
@@ -741,8 +776,8 @@ static int test_cpucg_max_nested(const char *root)
 	struct cpu_hog_func_param param = {
 		.nprocs = 1,
 		.ts = {
-			.tv_sec = duration_seconds,
-			.tv_nsec = 0,
+			.tv_sec = duration_sec,
+			.tv_nsec = duration_nsec,
 		},
 		.clock_type = CPU_HOG_CLOCK_WALL,
 	};
-- 
2.54.0


