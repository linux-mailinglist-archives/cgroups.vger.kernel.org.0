Return-Path: <cgroups+bounces-17248-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6NzRIYUAPGrriAgAu9opvQ
	(envelope-from <cgroups+bounces-17248-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 18:06:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F37EF6BFE5F
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 18:06:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KRKK5RQa;
	dkim=pass header.d=redhat.com header.s=google header.b=Ncwze8Vk;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17248-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17248-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5B2830128C7
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 16:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9914738BF8D;
	Wed, 24 Jun 2026 16:04:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFE3BC668
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 16:04:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317062; cv=none; b=ULSLctcts1NxUiWtN9PDWELBBQqS3v2jA2e2CmNFo036pDnYkfV6hxK3lJsNH5wkutvO0ykOBtKE6dnsYSIVJJfNjD2yBqUH5ZqeHf1zxe1kQsdnmhgtj0apdO/pIOUF5YiRBffP9CqCw5NoVeTbxcavnUF54HOyyS/sS3tXqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317062; c=relaxed/simple;
	bh=P7p7FAcln0ct9nNUJa2Ctd2eiERl+AOGFhIrcJgzXAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKlZ0Bfznhf+gGABs+5bLJdLkUGeepNgZmUFbzsfJ75WFswYglqjlIeVz8MPVmOlSsluNSy+NLdvB6ZNPIEBIqXJMtwpLohA5DkmkYJumFkr+8WZfUAsgy7yec7WQTiTBplcjoCPuudGZ1MoGMxQ/R6OntfhgPoqP3U3z8R6Ov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRKK5RQa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ncwze8Vk; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782317060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xip2bYaGq+4ASYS6Hehw4QNPCcstYUL5jPvaPb6o9/E=;
	b=KRKK5RQaOF5Fw1FMIT4KbmNpDnZPcselIBnpVG1u+0US6Nqcru4MWwdN32AeF9HQMtyKFk
	wV47MLoXwrELs/LOjR+nGp0503ulj5Rj/FWlPfFSs8rKaad4URMYMlk7MN96H+P6bKW3fH
	ukXPMiYzWqy6RIhdN8u8uJxRAdUQgZI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-1McEvkJkNiepD1bAZ4wTYA-1; Wed, 24 Jun 2026 12:04:18 -0400
X-MC-Unique: 1McEvkJkNiepD1bAZ4wTYA-1
X-Mimecast-MFC-AGG-ID: 1McEvkJkNiepD1bAZ4wTYA_1782317058
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92045e86763so19385a.1
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782317058; x=1782921858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xip2bYaGq+4ASYS6Hehw4QNPCcstYUL5jPvaPb6o9/E=;
        b=Ncwze8Vk+6liBNGoKAUu3D0k60b+knTlodf1Wu2O4f+cCwgZD6d0yCwPI8Q2P/DsIt
         Q8eMmBV/5uBY+kw3Yg5gsTlK/laKsvRqfSy9Fr5VazJRKs6o8zJcXn7V0Jx6dk5C+q5f
         VyJjCdHOQJNCreCQz1lTIijP0tmFHfO3LEodrFNM+m6imtvexSjUEvIirEigNUeiGG33
         ePNUMEyzgQb2PEmtZ7Huvs7LrCT4QiwxKctO/uiapHP7IYA8acb1JxDBRqQWVJ/CWh5Z
         KaqWOsIyaz9itgxZUzE+aZondCZ0t4rEMJbvHOlHwlDFQ3s75mTWaboQG+y5azrSyzr1
         qLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782317058; x=1782921858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xip2bYaGq+4ASYS6Hehw4QNPCcstYUL5jPvaPb6o9/E=;
        b=n2gBqRyYiJKgqpSNDl2M5f45ZvLZLbBP37argRqqn7Ni7jojaw4ixaiPxo2gq1P2Dg
         3/4vxp2qCztEZV0KdZh0Hg5HZ0aUC+n6nWA0iLi2sId3tRKq162egJC26fCsc5YGXy2d
         SALakz91zUW9yhlVxNNw/338CsbzwdxEGXXEahZFRVdKkQ3qiLi+1gHmTYPZ7FW9/AbS
         OYkgSGgyMrxD/c0+Ch63MqP73QUvvoCR19bKZRCmNtXnNjHINxnDImixf33FSZZT6yOh
         w05SEhK704LYljQotXuMm09igFXFXHlDuIvl6SQA87jHSPMyb6/JjIXso6Fd9iLsrh5I
         UJZA==
X-Forwarded-Encrypted: i=1; AFNElJ+hgEi/ME/FWxvXD6HqcH1tiWvtUsKHyTfsqmkk9a5AbyKEBsdssKge1qnNX1p6V7yJwrH/4fwg@vger.kernel.org
X-Gm-Message-State: AOJu0YwjDa/HofefBRLC+bHkumrAXQAE+R2SLhnSElHESYYCt1keMue5
	d4jgcS+iVI+x6lzA2CUR8B5Ak05tXq5+zOt0GAsh9jytI0XORZC/2R5+1vY4HGD2VqraMY//QBM
	8K7AIAtcgEQrPdk1czIPBQXG44XO76NtXN6j7NmupOen4rN90nK2knu9Powy/Fz+RaSU0Nw==
X-Gm-Gg: AfdE7clFXwpg48S2zsTS/06xLULz2gUhIbGb3n+MBH2vXmsxsFj5bigHhuyD559NHiH
	+FQExejJwRQpIiieLOpV4SX7glBNcAte0sjiCOARVDUL8peWa5lQBXMLSs2oaYsqqK57hu9opwx
	PQ+s8Cuxb8OMoYNtzguCs0SMLXoOuRiA6CMs9vkCL+/oIEtT01hdZEmOF7s40a0uAiXZv9vOKaU
	vKuAda5GzQUDQqXkQEx/EsgGAevKG+8fe5QupSBaZr87n6dp1gkdjC8k+TxtMVXPhTnswCD2PYf
	247FwwJwF1U5Tgjtw8SjEjL2Mgq0R9Yq136iN40cAd7G1OFpho9hDVpeot6eC6il0mMH6Wtf3Af
	j6rWeao6KdzPAXyKYKnz51utk9EHDtiMgZw==
X-Received: by 2002:a05:620a:4052:b0:912:671b:d0b1 with SMTP id af79cd13be357-92882e6d436mr156030485a.2.1782317057962;
        Wed, 24 Jun 2026 09:04:17 -0700 (PDT)
X-Received: by 2002:a05:620a:4052:b0:912:671b:d0b1 with SMTP id af79cd13be357-92882e6d436mr156021185a.2.1782317057358;
        Wed, 24 Jun 2026 09:04:17 -0700 (PDT)
Received: from oak (c-73-148-124-98.hsd1.va.comcast.net. [73.148.124.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c343bsm594979085a.28.2026.06.24.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 09:04:16 -0700 (PDT)
From: Joe Simmons-Talbott <joest@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Joe Simmons-Talbott <joest@redhat.com>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] selftests/cgroup: Adjust cpu test duration based on HZ
Date: Wed, 24 Jun 2026 12:03:57 -0400
Message-ID: <20260624160358.430354-1-joest@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17248-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F37EF6BFE5F

For lower HZ values a quota of 1000us is much lower than the amount
of microseconds per tick which makes the tests test_cpucg_max and
test_cpugc_max_nested fail. Increase the test duration to accommodate
for lower HZ values.

Link: https://lore.kernel.org/lkml/20260623194239.GA899029@oak/
Signed-off-by: Joe Simmons-Talbott <joest@redhat.com>
---
v2 -> v3:
- Instead of changing cpu.max quota extend the test duration based on
  the HZ value.
- don't call pclose() if popen() fails.
- check return value of fscanf().

v1 -> v2:
- Try checking /proc/config.gz to get the actual kernel HZ value and
  fallback to 1000 if the value cannot be determined.
 tools/testing/selftests/cgroup/test_cpu.c | 44 ++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 7a40d76b9548..feb7eb6a875c 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -639,6 +639,30 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
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
@@ -646,15 +670,21 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
 static int test_cpucg_max(const char *root)
 {
 	int ret = KSFT_FAIL;
+	long hz = _get_config_hz();
 	long quota_usec = 1000;
 	long default_period_usec = 100000; /* cpu.max's default period */
-	long duration_seconds = 1;
+	long duration_seconds;
 
-	long duration_usec = duration_seconds * USEC_PER_SEC;
+	long duration_usec;
 	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
 	char *cpucg;
 	char quota_buf[32];
 
+	if (hz == -1)
+		hz = 1000;
+	duration_seconds = 1000 / hz;
+	duration_usec = duration_seconds * USEC_PER_SEC;
+
 	snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
 
 	cpucg = cg_name(root, "cpucg_test");
@@ -710,15 +740,21 @@ static int test_cpucg_max(const char *root)
 static int test_cpucg_max_nested(const char *root)
 {
 	int ret = KSFT_FAIL;
+	long hz = _get_config_hz();
 	long quota_usec = 1000;
 	long default_period_usec = 100000; /* cpu.max's default period */
-	long duration_seconds = 1;
+	long duration_seconds;
 
-	long duration_usec = duration_seconds * USEC_PER_SEC;
+	long duration_usec;
 	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
 	char *parent, *child;
 	char quota_buf[32];
 
+	if (hz == -1)
+		hz = 1000;
+	duration_seconds = 1000 / hz;
+	duration_usec = duration_seconds * USEC_PER_SEC;
+
 	snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
 
 	parent = cg_name(root, "cpucg_parent");
-- 
2.54.0


