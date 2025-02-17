Return-Path: <cgroups+bounces-6563-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB2AA37BEA
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 08:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9449A7A255C
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8993318DB23;
	Mon, 17 Feb 2025 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnf4uiJe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FAF1865FA;
	Mon, 17 Feb 2025 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776548; cv=none; b=gih6DxZAOjwoAqsNL6WzZKjmJQWGCRqpf4OZub3jYlO/F1yGuG1K9+SahOQF1VvExb0cFGt9cnhUzXYn2WNPmynZ5qxrvNkWLXw62rjuiUx5nPtJbNu7acWELRKElT48BMF7dku4EF4JW3cw4b2u+cpEPQK+KmifDxM54M4p3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776548; c=relaxed/simple;
	bh=ZgE03gnkiczJbSX5JfeR0QeGusyuOyF4z6jgXajSXlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CQatz/SJmHMU05oXY4oTKcqm/U8ym5XBQX5jr5O/8usrsy9Yqp7hEni0rGvfxPxUZgQY9dHWm03Ur27uWjOE3aD7bc801YZCgbW+jg1kqkAKmUIps5O8LGSELVdasKJCzYusaMVx/1qkJyybvoWZ72KZdiUrta3iiWmP51MOnCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnf4uiJe; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so7607658a91.2;
        Sun, 16 Feb 2025 23:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739776546; x=1740381346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I1KjlF9yBA1ygzJb4h7+6AMhUzVEobXGUCJMh4KgDac=;
        b=Dnf4uiJeHrb3YjFCODwTtZ/UMWxLawjSwMI1t0MqOMUlK6FARM3/dS0ftjlmWoCDI/
         KGZrCuM3EZdJJVaGv3F3B/k7mEkgHbi5WCOPWAS7NZ7IG50oJJNHVDdsaYJ2vA7KsAue
         uL7rTHnuMtEaxaniteLfSsovWYRbn3oHvZ7FaHZP/guziYxMblJW9QMFk+WeKDM7Q1tL
         Nw4B4GWvU+ksYe+cRrP0zHyKOmpFqZKFTRCuOnaVq9hv6fR8tLjWBJ/swEMy3+Y/XBms
         PS200VTO3jm60wOEVIEaW7FMXL0XipI6NYQdb7hxXvoZJcUdWJiBsF0hz5xVREcOOmfZ
         VZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739776546; x=1740381346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1KjlF9yBA1ygzJb4h7+6AMhUzVEobXGUCJMh4KgDac=;
        b=gVrx+mi35WS4LmArfFSVDNLC79C5anopC6uKLfL/5R4OAPVdC5oWzjmbK8/vXpA7Zs
         dDtSJmlImXaI898Prv6W7x+FsZ/cZv9TEvoaNaPgl9PHPqxa9BXERM1KmZBa4AaijPtD
         1gRhnNnAT0B6109i+kVZuSo2Lyxcn1aW1CDmxVAKdJ8fdlL5xbachpuqOdN9G8upDThM
         gXHloqWH2Uc8L7bFhsG/uda8CXvhF4k3tX80fYoXGXcz2/4crmuoNRWrZ7H836jVjlPs
         nln+I+Q2Z7zPzEp8KmMJ7ocEVXVBAZ2QygpuWzCO5x9PFKgUV2DJM+TogzCnUB2yH6CY
         sLDA==
X-Forwarded-Encrypted: i=1; AJvYcCXHyMD8VsUVoxVWtxqdbPDNDk7tXAKGOFoan6SnI4CxcWQs4TH8IBfkedOPqVoBPoBH7SHUTQvBw/eRYok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxucqWboZHaLwS1+NrgNgSsdclBdwHTMRDCqxP1AevaroXjMuEk
	STBuOsJea8RIqSLIJR8YKbO3v7RZNpuG0xZNVmGrz/Mvf8lYkMYNAgMglwpzapM=
X-Gm-Gg: ASbGnculmlv/vMPsrso6wOtpsQ3fVVwKlFxcWCIASjmqefrKeWQFfeNtb0Sg2qU8zA6
	JgdLbBytPDRojk5TU+TX89WUwqRTrbEP7Ol9fyOJN2y/vkA1swYsGIL7DVZdpUQcOrXxtTq1k+p
	RP/0xpupO3SRI+jQz31JTliFNHLC5pGjTHn24QwOXanduo9ISWHaCUCrZsRmYmyN/9nNK0pyTs0
	IIL5Y2INZbPManTVfp80rUqcXfaUizw6gaWg6CXyvjy1J3RkFuDIBzC9PbWOGFcL6OxkA2s9VZq
	mGQCA9Ln
X-Google-Smtp-Source: AGHT+IH3Cb6Z3kahJfQDQ99UhUK7ANVeoepfBrrvEySU91LVmHrc8SLylYOKU/WsECVsmlzTYvORuA==
X-Received: by 2002:a17:90b:54c7:b0:2ee:59af:a432 with SMTP id 98e67ed59e1d1-2fc4115049cmr11918514a91.31.1739776545853;
        Sun, 16 Feb 2025 23:15:45 -0800 (PST)
Received: from test.. ([47.246.98.206])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d7a540aasm63263875ad.245.2025.02.16.23.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 23:15:45 -0800 (PST)
From: Jin Guojie <guojie.jin@gmail.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jin Guojie <guojie.jin@gmail.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v3] cgroup/cpuset: fmeter_getrate() returns 0 when memory_pressure disabled
Date: Mon, 17 Feb 2025 07:15:00 +0000
Message-Id: <20250217071500.1947773-1-guojie.jin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When running LTP's cpuset_memory_pressure program, an error can be
reproduced by the following steps:

(1) Create a cgroup, enable cpuset subsystem, set memory limit, and
then set cpuset_memory_pressure to 1
(2) In this cgroup, create a process to allocate a large amount of
memory and generate pressure counts
(3) Set cpuset_memory_pressure to 0
(4) Check cpuset.memory_pressure: LTP thinks it should be 0, but the
kernel returns a value of 1, so LTP determines it as FAIL

In the current kernel, the variable cpuset_memory_pressure_enabled is
not actually used。

This patch modifies fmeter_getrate() to determine whether to return 0
based on cpuset_memory_pressure_enabled.

Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
Suggested-by: Michal Koutný <mkoutny@suse.com>
Suggested-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 25c1d7b77e2f..14564e91e2b3 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -108,7 +108,7 @@ static int fmeter_getrate(struct fmeter *fmp)
 	fmeter_update(fmp);
 	val = fmp->val;
 	spin_unlock(&fmp->lock);
-	return val;
+	return cpuset_memory_pressure_enabled ? val : 0;
 }
 
 /*
-- 
2.34.1


