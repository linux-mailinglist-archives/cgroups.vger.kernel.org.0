Return-Path: <cgroups+bounces-8097-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1819AB03B6
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 21:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115121C40CEC
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 19:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7241B28A1D7;
	Thu,  8 May 2025 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU7Hv44y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73921D581;
	Thu,  8 May 2025 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732738; cv=none; b=paCIznQ/QUVIQ50JfYD51w02U3Ik+/i8XWusiU8rdRbu1yuyIsC8h6B8sJOeK5SHgwwQe/mV0IL0zAAy1ZcjY6hGGy0jlPv4a1zkv3ypcNCSfEfC62wjfkmgY9wt/XFxQ89iRFlVr5FuzgIsU89/QUMrKLqNLprx5/n/K33B4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732738; c=relaxed/simple;
	bh=LV1oM25sHfr1IGLgdugGnJdy5/k3VJfK6VzW5usI15M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCR2sSBbirF/jMWaLD6o45t9DScnuTULO1vaNtqPxlxO8xpbp/8/EFtLxp3E3fVNhy3uG81inaVyrJ35G06aPsF6zsoGMd8yOHsbBD8tTS26INdAnLY3CWYpiZkYJ7n19rDocx1U8nFcf3qOWlVxEGMo4bdU5aLDeQ1jHkx4tGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU7Hv44y; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c277331eso2324073b3a.1;
        Thu, 08 May 2025 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746732734; x=1747337534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dOeW2IURHuKsgiuZAD4JqkGfUkGdRsmp9Oj1CNDNic=;
        b=PU7Hv44ySiL8JDGCmzgLoYVm+N3b6gwUUWn+qTGN6fKd3qQWssCjCAfWEQOfvx8btk
         sP09//MhTgywMrnl4UkHxl+jB+WTTP6a8UGBvyxT9J53okde6RNdtbFlZH0ypLZ6Te8T
         jbXT5W1PB3TuellQRGMNf3prMLWaPfTp7QAKaPUiNCHRBmdH9wAcicdQbFadqpKmrqDy
         2fAWmGceTpqeyMn51QcoKYe63/N7IA80TKaPzNSL6AiYdBVHh+kJPAvZ98faM+ZrvsCQ
         jlXrsfy8STK4P+kHjdAk3jWmKle0/i5HY9XYnDQg95F3uVm/iWb37o8bIpft1ypIiwTS
         8GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746732734; x=1747337534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dOeW2IURHuKsgiuZAD4JqkGfUkGdRsmp9Oj1CNDNic=;
        b=cEezO1vPNt+ulP+xTNkX4kgBgkNWn5Y4j3O6GxKYs657rZy9loNteSCvj+lS2i4nj7
         gFsdWBsB4veDqKP+3fw8qL4SCVIk+21EUpMztTm7uHJfkYA7gb4KR2ZW4NYeMzOhwpob
         87e4OPNx55yidEzrRInfG5bDqW7Llr831QBgnaqD1+e8miJoMTWxbkOVi9DK9JWwyLmK
         zBMwtCWPuE+JKh/cu0D1ThmPzIltZAbATUZmDxkaJm6gn8v0wW4GsDHon9t+7GLb1dN8
         xhVlQ3kpSrgm0sT+GdmJFVu0fcxCDUXZvFx9mVeT3fSUFrUilcJylflakxb/2sT3GPqp
         idlA==
X-Forwarded-Encrypted: i=1; AJvYcCVex2YY5fj4OlPwoV3mY5B63bvCvc1zzfHXEiDRMEFJDc5TkZS3IqOqVYjAlzReUHE/ctHCF824jxV+GDBk@vger.kernel.org, AJvYcCVgg10p6VKp1/3dyy9GqMqF01Yfs2Y3/RNe+GXSKZz0IkwTvRHJx7cMVl9VM7DoQ2peqI35nKwf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh81o5Iq94vhfdkOAJ4BSNLs8FO3Ecp716jLSJevaQCa+NzlS/
	Dyoht2iaVWCA1/1pnkHE84C/MoD6TuRwVfUTt7hkibrbO+NCrQkjPcP00cWs
X-Gm-Gg: ASbGnctd1mZot4vwLw1DlYC3nok0/fZ0h6qo0CFMub3ZP/duOK3BateKd3U+Z95537g
	XLYd01cgWWuhhAEdMyjBLHnavNzf5NVqvoKwSTqqfXIItMS5TTpm2tgbRe965T/SQMRL4eOV6+q
	/+6D6S2vaYem4hwC0+cyRAwqZ8+3cWIbWMgNPaTRvCDklZVettSZs0eCb0JasUIPQoVlu5mt2dK
	PQjXNEfIQ1IIQHPdtlh25h0extPhBORawLm1SlL2DhmhcOkT+WON7rnJnFah06tsIT8Y2wUDGTd
	XPG2g8Hx9Ox6KfvbTx4NMyIny8hABQOn59Ih2Tt9
X-Google-Smtp-Source: AGHT+IHinXyNOBnJU50QOSFnQfh3DksluzyXN8rhN9sQPnBHN6NS4at1rkk8bpst/cQkKwz4gFasxA==
X-Received: by 2002:a05:6a20:1586:b0:1f3:1ebc:ea4a with SMTP id adf61e73a8af0-215ab67d7c7mr737752637.20.1746732733990;
        Thu, 08 May 2025 12:32:13 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0ce5asm397498b3a.97.2025.05.08.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 12:32:13 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] cgroup/cpuset: drop useless cpumask_empty() in compute_effective_exclusive_cpumask()
Date: Thu,  8 May 2025 15:32:06 -0400
Message-ID: <20250508193207.388041-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Empty cpumasks can't intersect with any others. Therefore, testing for
non-emptyness is useless.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/cgroup/cpuset.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 306b60430091..df308072f268 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1388,14 +1388,12 @@ static int compute_effective_exclusive_cpumask(struct cpuset *cs,
 		if (sibling == cs)
 			continue;
 
-		if (!cpumask_empty(sibling->exclusive_cpus) &&
-		    cpumask_intersects(xcpus, sibling->exclusive_cpus)) {
+		if (cpumask_intersects(xcpus, sibling->exclusive_cpus)) {
 			cpumask_andnot(xcpus, xcpus, sibling->exclusive_cpus);
 			retval++;
 			continue;
 		}
-		if (!cpumask_empty(sibling->effective_xcpus) &&
-		    cpumask_intersects(xcpus, sibling->effective_xcpus)) {
+		if (cpumask_intersects(xcpus, sibling->effective_xcpus)) {
 			cpumask_andnot(xcpus, xcpus, sibling->effective_xcpus);
 			retval++;
 		}
-- 
2.43.0


