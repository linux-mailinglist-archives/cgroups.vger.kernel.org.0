Return-Path: <cgroups+bounces-17358-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kKfkJzjhPmofMgkAu9opvQ
	(envelope-from <cgroups+bounces-17358-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 22:29:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE616CFFF1
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 22:29:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DhqEy0Mt;
	dkim=pass header.d=redhat.com header.s=google header.b="Li9p2/dV";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17358-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17358-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F10423024503
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C53BED1E;
	Fri, 26 Jun 2026 20:29:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1332D5C7A
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 20:29:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782505780; cv=none; b=eWJuPMD9N6yPmYDUxvNmglJFHk9h0CjhBNFsntS/JseejH9ZX8WnfsjuK4syAFVEoWsKbXiLQqUCk1fZgA2SfZ58rZzm/ICUqNVh4aEezn4Zvk0Isrz4ZX47UKvpBMdDj1ICIvNV3OuCw9ruu2a78V1KElW82diIZAw/xijgrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782505780; c=relaxed/simple;
	bh=NQjGG4zXSYU53w2K7bTqHGdIct742qU3+RBPftHQRyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCVHZijpzEdMArf9aQLkwP18Iky2lj2eN0US5ryv21ExnlJ2TWCcYvxDGVWW6ZH24IXqFdCE9txA3ILaII7bbbm1BFRK78V9qRmUGyWTfTYD7JufSQWmpP33676SsTVTvLeckkKj4Kt1VPYKmGBd/Js2SRMCMTLmJR3G5cJ6OhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhqEy0Mt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Li9p2/dV; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782505777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5fmmows0Hr70L00v6YhaNR6PFpVRD5asct1gUksFqE8=;
	b=DhqEy0MtmuPsHkJLwTa3eHCnqHJvybCKMX7mQDhv7Z+58WrGOOcwIlORBjAPow1rRdkjBf
	nCDwelFWZNGa3lYMrmp1ntN8aYb+ME8rt/GDwcH+J4zzEs0Ht/M42Xlb8cE0BZS6leTBsh
	Pb/PDPnK46obzecwA5PeFuz/aFbdEeU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-0lSgZfx8OxiJ4yLQcpalgQ-1; Fri, 26 Jun 2026 16:29:36 -0400
X-MC-Unique: 0lSgZfx8OxiJ4yLQcpalgQ-1
X-Mimecast-MFC-AGG-ID: 0lSgZfx8OxiJ4yLQcpalgQ_1782505775
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92b4b575561so112869685a.1
        for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782505775; x=1783110575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fmmows0Hr70L00v6YhaNR6PFpVRD5asct1gUksFqE8=;
        b=Li9p2/dVoVB1H5/bS2fM/7OdJHJR2PpYJg6d+tWOywJE5iL70CvG+A4gNtcAohlfHy
         17GZNC1I/wUZxXeMBbOx3sFSvO1R5D45th6WdMAvzXQaA0rxgsiVpGXRdhIDNl/n8g6t
         EOmZmxCWgJ2CvSv0Mf4fZnhFb8mx4OyYM+oxShPrvuJre8lwHuVavlRq3OzbNaBvNF8k
         CNqFfgxcthXOBIYMgcRiZj6ysbGcmeaX04x59ndEURIRLebcS/aiFUUwWT0yIMrE7m9f
         ZKaeQz30HoIb++zXzttol7c9ZelOhKyVzkRJDkKgnquoWRd1c7KN9FqBsQbiU1NGtbjO
         SDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782505775; x=1783110575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fmmows0Hr70L00v6YhaNR6PFpVRD5asct1gUksFqE8=;
        b=py6XHGIBzOVJFxjrHiwGC7w8lGVp+0p1x4nOrfV2vtvUJ4XleDH4/zuBS5/RcsyP+F
         5qDKKeDmqr9hX9f2cqKrYxnydGNVzHgHld35P91P7Y81AxR6N2izaTE+9vxd2EDV12qR
         fC8QDZcmzQwuRHBLMaYbgDy0AtNoYrfWfWMIsvgCVTxm37VnGdZ7QRQ5B4YTg5gAbek2
         hd4SfFLV8M7/WFWd/7IO0gvvh35OuA4TmbtX0WXj0TsRXVZPYn/+z5ikAn1Z6PAd31Ae
         +JWDfycB75iH8pQUr3z0QRVJbVM5WomXrAG/bktKZZHbV0EP8vysu2hl83cxUj2hDp+6
         ih7w==
X-Forwarded-Encrypted: i=1; AFNElJ/85/OdTtr+L1KUanu5Rr41WRcPnKnHZ1OxCHRr2V8cIsVgR4wNOi8uCVvLrrrycA6AiITvbwaC@vger.kernel.org
X-Gm-Message-State: AOJu0YxdHtDqBB36x1HIUL4bIKVdfdSsAr5e60peStersLN5s6f325jC
	YYfyQY+qi2w+eOZN81c+hWGVRePlR16mDbg9b0UP2FDtdrY+G5RCEQLJc3N5QJh/iMmS6rWZPQK
	V+blQvEkxJyNp0ZmAzY+dtqcN/IyeM8IlwVwCdYBDwhtgjZfOmUP0qEI9qFk=
X-Gm-Gg: AfdE7ck4VEiJd/fmhGMT0MzWenjkBT86U+DvRdZPTQMVQcMoUaEwbjJw7I5hr0sxVd3
	S+PfooUHS2UXt+4SIIR/D82wXz8LtQoirRKRobsPqDClJTn5uxS9xuz5qFYGP8veh+2eUDv3r5G
	/M4A6mAUOuC8Lw785ROfsxKMnyIndx/swoah8M/QZNU1rsu726KD652FveAvdvE0ZyR6stq2XwQ
	4mRc+qrDwgqUXMO9bNwrkBmQLrIgG4D52uGYhJPPa2rrMuTZFV3RxyGTG0Wde4JchqQEu+3GwBh
	lrzTWizWqrb5THBJeHanhliPmzvIFkOrFfeAbod1HSAwYXNDUxIZpWnKeKae3LJacOqcZXFymCm
	9M0SSWq5XaY4H76mUI5VX+LJ/s7435cB+YBsiINvkZcWJbABn
X-Received: by 2002:a05:620a:1a20:b0:8cf:bad7:20c5 with SMTP id af79cd13be357-92927db2b88mr1121091685a.25.1782505775429;
        Fri, 26 Jun 2026 13:29:35 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:8cf:bad7:20c5 with SMTP id af79cd13be357-92927db2b88mr1121087185a.25.1782505774892;
        Fri, 26 Jun 2026 13:29:34 -0700 (PDT)
Received: from oak.redhat.com (c-73-148-124-98.hsd1.va.comcast.net. [73.148.124.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004ab49csm1239563785a.34.2026.06.26.13.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 13:29:34 -0700 (PDT)
From: Joe Simmons-Talbott <joest@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Joe Simmons-Talbott <joest@redhat.com>,
	cui.tao@linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Li Wang <li.wang@linux.dev>,
	Sebastian Chlad <sebastianchlad@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>,
	cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5] selftests/cgroup: Adjust cpu test duration based on HZ
Date: Fri, 26 Jun 2026 16:29:22 -0400
Message-ID: <20260626202925.1527524-1-joest@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17358-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,linux-foundation.org,gmail.com,kylinos.cn,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[joest@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:joest@redhat.com,m:cui.tao@linux.dev,m:akpm@linux-foundation.org,m:nphamcs@gmail.com,m:longman@redhat.com,m:li.wang@linux.dev,m:sebastianchlad@gmail.com,m:zhangguopeng@kylinos.cn,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joest@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECE616CFFF1

For lower HZ values a quota of 1000us is much lower than the amount
of microseconds per tick which makes the tests test_cpucg_max and
test_cpugc_max_nested fail. Increase the test duration to accommodate
for lower HZ values.

Link: https://lore.kernel.org/lkml/20260625203307.1114538-1-joest@redhat.com/
Signed-off-by: Joe Simmons-Talbott <joest@redhat.com>
---
CC: cui.tao@linux.dev
v4 -> v5:
- Get rid of added duration_XXX variables

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
 tools/testing/selftests/cgroup/test_cpu.c     | 43 ++++++++++++++++---
 2 files changed, 38 insertions(+), 6 deletions(-)

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
index 7a40d76b9548..a5eccfcabef5 100644
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
@@ -646,15 +671,18 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
 static int test_cpucg_max(const char *root)
 {
 	int ret = KSFT_FAIL;
+	long hz = get_config_hz();
 	long quota_usec = 1000;
 	long default_period_usec = 100000; /* cpu.max's default period */
 	long duration_seconds = 1;
 
-	long duration_usec = duration_seconds * USEC_PER_SEC;
+	long duration_usec;
 	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
 	char *cpucg;
 	char quota_buf[32];
 
+	duration_usec = duration_seconds * USEC_PER_SEC * 1000 / hz;
+
 	snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
 
 	cpucg = cg_name(root, "cpucg_test");
@@ -670,8 +698,8 @@ static int test_cpucg_max(const char *root)
 	struct cpu_hog_func_param param = {
 		.nprocs = 1,
 		.ts = {
-			.tv_sec = duration_seconds,
-			.tv_nsec = 0,
+			.tv_sec = duration_usec / USEC_PER_SEC,
+			.tv_nsec = duration_usec % USEC_PER_SEC * NSEC_PER_USEC,
 		},
 		.clock_type = CPU_HOG_CLOCK_WALL,
 	};
@@ -710,15 +738,18 @@ static int test_cpucg_max(const char *root)
 static int test_cpucg_max_nested(const char *root)
 {
 	int ret = KSFT_FAIL;
+	long hz = get_config_hz();
 	long quota_usec = 1000;
 	long default_period_usec = 100000; /* cpu.max's default period */
 	long duration_seconds = 1;
 
-	long duration_usec = duration_seconds * USEC_PER_SEC;
+	long duration_usec;
 	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
 	char *parent, *child;
 	char quota_buf[32];
 
+	duration_usec = duration_seconds * USEC_PER_SEC * 1000 / hz;
+
 	snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
 
 	parent = cg_name(root, "cpucg_parent");
@@ -741,8 +772,8 @@ static int test_cpucg_max_nested(const char *root)
 	struct cpu_hog_func_param param = {
 		.nprocs = 1,
 		.ts = {
-			.tv_sec = duration_seconds,
-			.tv_nsec = 0,
+			.tv_sec = duration_usec / USEC_PER_SEC,
+			.tv_nsec = duration_usec % USEC_PER_SEC * NSEC_PER_USEC,
 		},
 		.clock_type = CPU_HOG_CLOCK_WALL,
 	};
-- 
2.54.0


