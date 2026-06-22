Return-Path: <cgroups+bounces-17150-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EJ5zJdiQOWq3vAcAu9opvQ
	(envelope-from <cgroups+bounces-17150-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 21:45:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E071F6B221C
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 21:45:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gv0ULkR7;
	dkim=pass header.d=redhat.com header.s=google header.b=ej27qgex;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17150-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17150-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBFBF3038AD8
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 19:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF1D349CFC;
	Mon, 22 Jun 2026 19:43:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA5349CFD
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 19:43:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157409; cv=none; b=iq9apHkvNZY+bTv+zBNcbFXHy3diDJLe/vm2crwvIOObGzQMyyGqR6sDnMvAeWTETJehs8oasq7EcLwhnTGoJTGuTspALTlzG+KH0V2tgbeG8GhRVLZf68qxwJVDN8VcyuhD9PboEkHMPRpu233aH046eg+t4BmvuorXrv0/9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157409; c=relaxed/simple;
	bh=Kk3o03hgyW8kM5/HNI84/GHxr++YhhzFEuplQ1IujJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgDkem5BS4dJSZrEDadlMM9hFHz1y6Fdw9KQrmRF/R9FQ5WOynQNAvqEvvj3gG4X9sElA5mNaROXKyY36ZDFSbra/HOnadmbM9OH0mRrXGY4UMGC/4glp3YpwFZmk4EDqQ96YQ2RbJ0OBA7L4Fob1r9UhKQkcwChIRBkK0dA+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gv0ULkR7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ej27qgex; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782157407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HoMUloaAKg8ODmRbwKoyKyJ1xKK05TMqALvJhnJx1T4=;
	b=gv0ULkR7a8fs+zKK8je6CIyUbzzHyj3Mh9LdV5lqWWg7RUHgfhK4A07ElCOSHB3Ric/KY2
	h/ighOSyJvgZDJCunSMINZgPSw8IO+RGybRSM/qyyT/HZMdDtavcOBL5WhbrHOoKNazKrT
	ONfVSMXOhATkeisSUCvZjBd2Ri/WOfQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-FgdhNz-oNFqiOeUcljGXPg-1; Mon, 22 Jun 2026 15:43:25 -0400
X-MC-Unique: FgdhNz-oNFqiOeUcljGXPg-1
X-Mimecast-MFC-AGG-ID: FgdhNz-oNFqiOeUcljGXPg_1782157405
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92158791d14so341478285a.2
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782157405; x=1782762205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HoMUloaAKg8ODmRbwKoyKyJ1xKK05TMqALvJhnJx1T4=;
        b=ej27qgextzr67ahtxU+KCPt/ouirG7ZlzjFtiWyGSlr68PvdjEJtdMHOhdQE3x6vRM
         TXxSVmh9+PnPZAim8d8S08n2nqs4iRRPUr1G/wmyciy4WiwzbBQhST1rOXcxqn75y63+
         ekEwpwxJwzFk3+kR/ad2qiRLG6/jofrrywsnfrIvMvDjYhyWHL2JGGtVve89DcwX3RHo
         Swe+wtV2Ypi9VrZR4h/jm2QhYv9PRVXGbHTV5XsYBp2VmxTwCe3LRP17aydNNYUA/naH
         iZoiVxoi8NHIRZ19RfRSjO2BZDES+14SjkR4cTSN2veGAgcL5H3Ts3QOv7UXMUh7OHj6
         yh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782157405; x=1782762205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoMUloaAKg8ODmRbwKoyKyJ1xKK05TMqALvJhnJx1T4=;
        b=LX3YbDPrDVYe6E+Ry7A/UgZLU8xZeXFebkSQ+/+XkO5ZG1Q6IuVrX6V5kLf/LnQzvC
         7xuK97ULD4SzNqbb2zsJx/YCgXxWlQ+IwfWckiudKgwGgLjsNuydz8bLISeGt5QaqqWo
         BLkIEgiKt8Bc5+rvd+6m3hQ/fAyNn2uVz7u2x+9z9xAYvWeXECcReQBRMLSfjKN49vrN
         gN5Tk/OGJKO7uCwUBA9LVqsRIxHs7XD6H5pJ6Aa/13Vb/r2nfE9FrJS4MV48kXxj8zCO
         UNM4mBscEqIq+t8ud1kgLcx5L7g/eNzgJYu0DW6CLsDjnqPT1qEhB6oD6gsZb6m3uK31
         Vj8A==
X-Forwarded-Encrypted: i=1; AFNElJ8SkvttiLRtSBCaqUR2jChCL/8hR1cfxeYMjx04SBv1NBJWtylUce6U8qCvbjf0OpDE6Knz3Oji@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfu1AxlY8LcqfZ8vT3ANvy5sNu4IhZhRrrbr2UmF8XrS2Av9DU
	IC4/k8kL/PClPcs28f3seGGFGs+CCxjgU927zi2B1qU0tDem9veUgy2HtcvTl7bnrL+PwTWdeNL
	Eevj3LlL0QIq6//UzY7CI3c4Z14y4DxO9AA6+NMgLyYdj/g00pEWs31yw+wk=
X-Gm-Gg: AfdE7ck1XZy+LGdsckHNRXfV/6yoN03kMW4hJ7dumEAA6qFqg6nKs6Q4Ii/fZDUx6vS
	ug2/Nse+1A2qWdulWIIH6RAPdO6GnXrK4YId16+FlkDCvh1KnXLpwS1UjmclBso3pLoTJYQLgNc
	nMkJUH52mCAdm/WUL52TnMVLRj2Imk8VlalHfTVHmcZ1lvCEo0sqyfhK0lBX5CWpkll8R8IekAt
	xREvb/V+UURPDCofH1EHt6xO26AV7K/p8FV0nhkbpsSRXbF2GKcImWDiLNzMfDNEor5TEkCwQcg
	WYcSYjsyWexK1FzB7r2vmVHXqCBJ8peRGDuGW2+XrudaruRuygjVq8yxhlb44uPDYyvR4IqqjQg
	0+KuTKHDhOtvTTAkXVQWbZJgTAWnk4D4s/g==
X-Received: by 2002:a05:620a:2592:b0:922:92b1:9dfc with SMTP id af79cd13be357-92292b1aff4mr1606116885a.14.1782157404786;
        Mon, 22 Jun 2026 12:43:24 -0700 (PDT)
X-Received: by 2002:a05:620a:2592:b0:922:92b1:9dfc with SMTP id af79cd13be357-92292b1aff4mr1606108685a.14.1782157404145;
        Mon, 22 Jun 2026 12:43:24 -0700 (PDT)
Received: from oak (c-73-148-124-98.hsd1.va.comcast.net. [73.148.124.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c1c39sm61506485a.26.2026.06.22.12.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 12:43:23 -0700 (PDT)
From: Joe Simmons-Talbott <joest@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Joe Simmons-Talbott <joest@redhat.com>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/cgroup: Adjust cpu.max quota based on HZ
Date: Mon, 22 Jun 2026 15:43:04 -0400
Message-ID: <20260622194305.601392-1-joest@redhat.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17150-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:joest@redhat.com,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joest@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[joest@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E071F6B221C

For lower HZ values a quota of 1000us is much lower than the amount
of microseconds per tick which makes the tests test_cpucg_max and
test_cpugc_max_nested fail. Use the amount of microseconds per tick
as the quota value.

Signed-off-by: Joe Simmons-Talbott <joest@redhat.com>
---
changes since v1:
- Try checking /proc/config.gz to get the actual kernel HZ value and
  fallback to 1000 if the value cannot be determined.

 tools/testing/selftests/cgroup/test_cpu.c | 33 +++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 7a40d76b9548..65e09555309f 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -639,6 +639,29 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
 	return run_cpucg_nested_weight_test(root, false);
 }
 
+/*
+ * Best effort attempt to get the kernel's HZ value from the config.
+ * Return the HZ value if found otherwise return -1 to indicate failure.
+ */
+static long
+_get_config_hz(void)
+{
+	long hz = -1;
+	FILE *f;
+	char cmd[256] = "zcat /proc/config.gz 2>/dev/null | grep '^CONFIG_HZ='";
+
+	f = popen(cmd, "r");
+
+	if (!f)
+		goto out;
+
+	fscanf(f, "CONFIG_HZ=%ld", &hz);
+
+out:
+	pclose(f);
+	return hz;
+}
+
 /*
  * This test creates a cgroup with some maximum value within a period, and
  * verifies that a process in the cgroup is not overscheduled.
@@ -646,7 +669,8 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
 static int test_cpucg_max(const char *root)
 {
 	int ret = KSFT_FAIL;
-	long quota_usec = 1000;
+	long hz = _get_config_hz();
+	long quota_usec;
 	long default_period_usec = 100000; /* cpu.max's default period */
 	long duration_seconds = 1;
 
@@ -655,6 +679,8 @@ static int test_cpucg_max(const char *root)
 	char *cpucg;
 	char quota_buf[32];
 
+	quota_usec = hz != -1 ? USEC_PER_SEC / hz : 1000;
+
 	snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
 
 	cpucg = cg_name(root, "cpucg_test");
@@ -710,7 +736,8 @@ static int test_cpucg_max(const char *root)
 static int test_cpucg_max_nested(const char *root)
 {
 	int ret = KSFT_FAIL;
-	long quota_usec = 1000;
+	long quota_usec;
+	long hz = _get_config_hz();
 	long default_period_usec = 100000; /* cpu.max's default period */
 	long duration_seconds = 1;
 
@@ -719,6 +746,8 @@ static int test_cpucg_max_nested(const char *root)
 	char *parent, *child;
 	char quota_buf[32];
 
+	quota_usec = hz != -1 ? USEC_PER_SEC / hz : 1000;
+
 	snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
 
 	parent = cg_name(root, "cpucg_parent");
-- 
2.54.0


