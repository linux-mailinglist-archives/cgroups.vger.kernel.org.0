Return-Path: <cgroups+bounces-17086-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rjQ+KV2yNWqE3QYAu9opvQ
	(envelope-from <cgroups+bounces-17086-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 19 Jun 2026 23:19:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF166A7CA2
	for <lists+cgroups@lfdr.de>; Fri, 19 Jun 2026 23:19:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=c7th3mrv;
	dkim=pass header.d=redhat.com header.s=google header.b=SIVO+tmI;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17086-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17086-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6654A305A8C1
	for <lists+cgroups@lfdr.de>; Fri, 19 Jun 2026 21:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10B73CFF4C;
	Fri, 19 Jun 2026 21:19:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E503379980
	for <cgroups@vger.kernel.org>; Fri, 19 Jun 2026 21:19:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781903956; cv=none; b=sN54yEJ596uDrPlu2rYQyeRNomrc5vVyqIZADW6SrbnXh7yI/NP+FBDxdPYpJFDy+ice0V5ntzqz4szUsk2VY8iOlk9j28g4htyeko8jFOE0L39rodVzbaCjQBCBiFoFL1f5GrI3BcJAKrcdqqa1Luubsc0Q/SH4TFOcq6YujGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781903956; c=relaxed/simple;
	bh=G/63HWtsPzNl8OwYXYz4ESq/2Bi7TZk4YzPIOakb9rM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqBVnAenZ6hHDA4lX5aXfxSzjmC0Co+cY7XZL/fElyVTwbkncsUjH1vd2Dhs0Mf9mHxv7YSZ2DxGZQAsJrAScotwIiKN2XxKSO0JM7H0UCz9i31stH+7WAZ2jEI18zFzwvxL2Ff3BsyUd60KvHxaWP4JIci74ndnlmXq9G8VSRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7th3mrv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SIVO+tmI; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781903954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0RLcHgtJHLdnreydzpBHm8njONwy5wHQ3yBTFU1OVEQ=;
	b=c7th3mrvvYCYSSdXCgmCcy0TOvHTzlSjAWWVMQ0J5Aprkzejzzsk+DH4UQ+/SsHb4sknH6
	UkM/ZoPffJhr9TrU3ATHtKeS4nDAoMxSgG8zWx2UHSp5Sra3rIgY9SryUG7QtNHg74zpkb
	0aaf7yTJUU7E0GkZjvenfbOon7m0LTU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-6e3mmGnsO0KgfYM7zO8Cow-1; Fri, 19 Jun 2026 17:19:11 -0400
X-MC-Unique: 6e3mmGnsO0KgfYM7zO8Cow-1
X-Mimecast-MFC-AGG-ID: 6e3mmGnsO0KgfYM7zO8Cow_1781903951
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9158f2c4b55so402145585a.0
        for <cgroups@vger.kernel.org>; Fri, 19 Jun 2026 14:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781903951; x=1782508751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0RLcHgtJHLdnreydzpBHm8njONwy5wHQ3yBTFU1OVEQ=;
        b=SIVO+tmIfOQQ4tOq3LFm/kvWNXpH3p14uZz4SJ9B4o+KDdqJc2D5u5bI7UdgOABGU8
         8VLXjVJvN8tyZKGzJPf/L/9f1HPXKyT211/71Lw+8MK9dthIsxSq/gfQDTw6kswpWn0X
         Vu+I2fPQ8/Uqf66g+64usXDzro94IXRvq4abbAvrljiIZlGmKR+LN0Elb45dua3n5gSw
         MkU3KFTiW8MHQMiME0pq9BTHePM7N2SRGj1cmIipywuvqJNye/i7vveltMxKE2rr6161
         dnzoTe3yWiAQ/XIPp+Di30FAjKJPm7mFlPso6SWI2kTGbpXoafvlRLz8Z4neSfRvbJHk
         g+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781903951; x=1782508751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RLcHgtJHLdnreydzpBHm8njONwy5wHQ3yBTFU1OVEQ=;
        b=Luam02/T0IzgontC/j5iUKvbqnvLH9rnKZMpEnSXZQMgBhzxLKIvrUS8zNLgfCak+Q
         itaCMQj60JhZyxjv+O72d2T6iIUN1UCROzlWz+X6kK+fz4Ibk5v0tIe1NFpV1PKna3PD
         PI14kh51Bg0OSgbEY9vJGXWfxhWtc3P3GlRr0ebOwt3geo4Dwua9jeLQ00aN5fgcJ3/C
         HRrhFCFLxEQn6OSGvn+9rX+V3F2MBVOCNYpahYBZ0wI3qvLkqSL3qQQMKEPKauGrkrYt
         eCTo5mRkufg5V8dtUtq4WIuMgUx4jhzIpKb1ar1LIJe17/IcyrBNHuLDuAoqzkC0KHBS
         4r0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8c/sZmUcO9fEEYslv+8YLVDItmx33p24uhM0IsBoAQYsm6X3h5OJG11v1OT0cOBxQqK/JISh9f@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqA+99WGdhXMJEUyrGTPHJC6gc8+A6UGAWz23nwd4budIydY3
	A6MBEvXXPr3nOnKZcwHRToF87R0iNwszTs4vxkbXLhLuZ1WXJ7f1MOJT56MqDnvOzZEmHLuaouc
	mOKSJNoh5dLryh9yHbPPrKTBU33TOf2AUqNRnL0psMdQio4uLEzkTo1yZHYQ=
X-Gm-Gg: AfdE7clmDaPUQFiGDe9uopFVePjUr8go5f2D5KEgzKL6jjNuggdWcF4cpya7NjI2GdV
	FRXgBivKb9bylS2is7mAhjPfwbpBFm8xEgneQ2D+5ngZLWTw7lPbyWcrtX8DeUMwlEatj1zhn8b
	hfFynR+pWeTshIAwIxBfq7uXJ44Ak6va5nJjJ7K9khGxiARydX7J08r/AnvpA3Oq8Fzsqd/aB2u
	TadcQMMqUGt6fpUV8OlvRnyYf9Uc57SUtnoX3F6njKf0lSvAL1vGnfhGo4MekLhoA8gD5q60T4X
	Z7iWpKX73Pme1zu6XZ4HpuZEH6e8cHRezIc/qVJU7L2OT27hSfpiaJBHdVjHFIVSt3FQ6poQ9W2
	tRbvorVXjAfmjZfbc3yNq9svHNwWhRO4roFPnc4of9UrsKcOl
X-Received: by 2002:a05:620a:2547:b0:915:6a2b:6265 with SMTP id af79cd13be357-921d32dbcc9mr228209985a.44.1781903950884;
        Fri, 19 Jun 2026 14:19:10 -0700 (PDT)
X-Received: by 2002:a05:620a:2547:b0:915:6a2b:6265 with SMTP id af79cd13be357-921d32dbcc9mr228203385a.44.1781903950362;
        Fri, 19 Jun 2026 14:19:10 -0700 (PDT)
Received: from oak.redhat.com (c-73-148-124-98.hsd1.va.comcast.net. [73.148.124.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921d7966812sm102562285a.8.2026.06.19.14.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 14:19:09 -0700 (PDT)
From: Joe Simmons-Talbott <joest@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Joe Simmons-Talbott <joest@redhat.com>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/cgroup: Adjust cpu.max quota based on HZ
Date: Fri, 19 Jun 2026 17:18:48 -0400
Message-ID: <20260619211849.3430645-1-joest@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17086-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AF166A7CA2

For lower HZ values a quota of 1000us is much lower than the amount
of microseconds per tick which makes the test_cpucg_max and
test_cpugc_max_nested fail. Use the amount of microseconds per tick
as the quota value.

Signed-off-by: Joe Simmons-Talbott <joest@redhat.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 7a40d76b9548..4ac5d3ecae00 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -646,7 +646,7 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
 static int test_cpucg_max(const char *root)
 {
 	int ret = KSFT_FAIL;
-	long quota_usec = 1000;
+	long quota_usec = USEC_PER_SEC / sysconf(_SC_CLK_TCK);
 	long default_period_usec = 100000; /* cpu.max's default period */
 	long duration_seconds = 1;
 
@@ -710,7 +710,7 @@ static int test_cpucg_max(const char *root)
 static int test_cpucg_max_nested(const char *root)
 {
 	int ret = KSFT_FAIL;
-	long quota_usec = 1000;
+	long quota_usec = USEC_PER_SEC / sysconf(_SC_CLK_TCK);
 	long default_period_usec = 100000; /* cpu.max's default period */
 	long duration_seconds = 1;
 
-- 
2.54.0


