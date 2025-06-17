Return-Path: <cgroups+bounces-8564-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68852ADCD91
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772091778FE
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8A52E3B12;
	Tue, 17 Jun 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZcK8urI6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB12E3AE2
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167442; cv=none; b=DSwgzVLnpCM+OILVa1rWr8E3/ztK28J4vERrxWS1N7jAnalv0OApIi9JQttioZMrn+eZhbxLC95Wn9RKYELyIHdDf/MVYVrpt1SCL9w2dav7pPMSwBC01OmfRZ2oE27osK8NFVOrLouKY4yP7oOGoy6bR2z8m0eGZbgnBHny2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167442; c=relaxed/simple;
	bh=xtt2rNThOOd0Ch0ay5t/SRPt0e7QyIQa+1AuoLWf+2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1FIURvZrfBcBPMPpbyopsEL6KE8VTF9WDflmrxpHnob0jswIRr5SVlnVQB5tyj+GcbR4Llj7vrAque2erc1PPjuKD82BjYWugwrnQTS2/BQcqU2JKZb8a8s24YRpXluohOPfAIouoT2C0qbGx6UBx59a9773ojNG/PKgfaLta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZcK8urI6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so45648915e9.0
        for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 06:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750167438; x=1750772238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IirAviWa54+DB/4fGXki7ILuYvAogeRyMVXvAl7uRo=;
        b=ZcK8urI6w0HZat+W0ETrhst7YwkcpUv2RNrOMD4e51q9NcdtuCa8LB1WZylPwpgd2B
         bSpseIJDU1r2cJ2GlZ0j4MjwBa7n6sDdDoKxrAu7Tq4dC+0vYIAFLrkeznw/hQXHPrTh
         KBtGAwMekGhwBmCPEKW4sZ1W7hN7/D/4ZmndrmXvsfnhOLhOAr5YcRAtMOUzooPLAifJ
         TD6gI1ImQ381LaXyPLL87o04QrQWuTiRKqvQctth9IJB+zM/LNUlYScY/xolpjhGWJEZ
         BB5iaONU6ouovoVBnR0PGzVU7u+ADE2Hj7uQ3GzgmVskyDdD+EXzqnfkt8xkwPpxpjIV
         mgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750167438; x=1750772238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IirAviWa54+DB/4fGXki7ILuYvAogeRyMVXvAl7uRo=;
        b=XeP22jKjslDkHfwp76R6nMu1/YA9wg0hggB3BuNvkSGRm5ypU+MCCqQ1uK5h1e8aob
         DBT0i5w+paroNn8XjJ9RPKlmhcWlxJfA4oG4nz1qHNwzpX157hROPAf9v91cPpZekxLt
         iWj124MjWGsnFsICUzyrahCKpQpQmkuyyk08t7pn2Svxm7/Skx0XOE3VaPaFpixWb6SB
         RxpKIRf4Q/hMjPrK9cXliJuCmwtjQhitiks/0HVtr46PXqBII3P7mAz/xus5VYnKKTi2
         jp0SKaE8AEzvwk6/j4voB0kWtOXTvy1zl4HmtcOIgVSexsRwNkZvCXx4ifLmczb9QyBf
         A2CA==
X-Gm-Message-State: AOJu0YwVtOzoDNZG772EMiUYHtDsMsYH4LG6Vo+HIOG1owrYBtzUeSXS
	CjIs+8QscevoOesg1SffL/xFnPwOHqilpUGYI4fuC/2ZRQ3kIdc8KuroK9Bd3rOommIgc5PSrSB
	8NGqMsSM=
X-Gm-Gg: ASbGncuyyzZx8ymoX8zFRRPNWEVSverT4F+URK3xZvRPXDQkau+82cu+cE80hiwVs6U
	lxOSh/mcpUr212R0+2Dg1B84QHiw00DSUMWmNKP9ELw3Y2XZZeEqnfMEmFtTkyE0Vp1qj+hMha4
	VQuUpFPXp9OwO47SiDxuGqJtDCkhlQ+pUHP9d0O0ENKSn0zop1LzX7WPSads8FhjU+Iq3e45G1D
	ZYPbIp4Mh/uKe39JD077reK5IJxgv29pshoWpVUfQxS4+yy/SNHPDz+B1/bTz+sWMUXgSkPT7jC
	wjRwh+KzRZVquvYaacfY0W+5vCziZu3/RpugnGJZJBZtEP0xCMxJfeCcSfPG3Zi+g5nCM00zXxs
	=
X-Google-Smtp-Source: AGHT+IGrwE0n8xObbXy+xwulox5ORPMmG9dF8KEQ/VAwCkDtHw6tIijP1d7NSitWFCIxbglfxPVesg==
X-Received: by 2002:a05:600c:5908:b0:453:827:d0b1 with SMTP id 5b1f17b1804b1-4533b235e16mr90149065e9.2.1750167437646;
        Tue, 17 Jun 2025 06:37:17 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224888sm179494365e9.1.2025.06.17.06.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:37:17 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 4/4] selftests: cgroup: Fix compilation on pre-cgroupns kernels
Date: Tue, 17 Jun 2025 15:36:56 +0200
Message-ID: <20250617133701.400095-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617133701.400095-1-mkoutny@suse.com>
References: <20250617133701.400095-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The test would be skipped because of nsdelegate, so the defined value is
not used (0 is always acceptable).

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/test_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index 452c2abf9794e..a360e2eb2eefd 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -21,6 +21,9 @@
 #include "cgroup_util.h"
 
 static bool nsdelegate;
+#ifndef CLONE_NEWCGROUP
+#define CLONE_NEWCGROUP 0
+#endif
 
 static int touch_anon(char *buf, size_t size)
 {
-- 
2.49.0


