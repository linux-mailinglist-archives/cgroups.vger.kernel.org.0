Return-Path: <cgroups+bounces-6572-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ABEA39021
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 02:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF68E7A214F
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 01:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360091DFF0;
	Tue, 18 Feb 2025 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyop8Ast"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4E182CD;
	Tue, 18 Feb 2025 01:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739840854; cv=none; b=B4Zz4wGi0jki5wtGB9crr9OlGJP8MhGDeErU7zgRTeHXeubZ7uIFIalFbHi6gFnBHaUWZ3N8Cf2pWbQqtoAro2uKHwOC9+Q+ED8Pie4xcBxMEq0dqfRtn4P+r+vG5sswcOnqmjfsLRlSJ8tznNjqEi6I5jMnrRLympEWubXwDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739840854; c=relaxed/simple;
	bh=DjZbwtUu4qc5qmET7mQWy/0oHXhFFINUI5DZ7Y9r+3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UlEMX5pCwRSoa4ho4bHjlS6ZZcVkjO/+TM9212NXiF1dy5tG3dki0C86mm109oFzzt6ligrNI/WzUe2mqqPWz66qByMrMbk+yEbo2IDfmX6j9TWtn/mdrngnDEnOV65qqYVG5DLxI/iG5iwcXTr9WLzaG/kL6LaJPt9SLzYD4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyop8Ast; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so7089842a91.2;
        Mon, 17 Feb 2025 17:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739840851; x=1740445651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iLt+zHrqCVEKW2UCu+GntMnRPnZVGS1Cdi5ly3ppDJo=;
        b=Gyop8Asth0QT12uco12vYf8AlP53COy5auXpeD4f31OG0YQ6dpzQIJegvP9JLsYm8L
         A4bpnYlK+Ekbckk1PZy9DHSWhRnriumC7DGEBF1xXlA7wEsgbF6Guj1jd2czpACqeOU+
         hnSai9qriAxw42be5XkK5GJWwoWQwQ9pxgwLXkeKho3Rzqw5OJtfcwnCb7kjTnAGdhsG
         S+Dl0WKdLkt0WkpayBykGbCy2w3ybMdDXtLnxF3iy/oQ0rWT7zLJshAgyl4AJN45Owd2
         hVg2S0hYvLrD9mvCTLrxgz7+hW6N+Z7xNeP1jy4AKIMAk3gsJ21b94I45QViGgcp126a
         tHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739840851; x=1740445651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLt+zHrqCVEKW2UCu+GntMnRPnZVGS1Cdi5ly3ppDJo=;
        b=ja+y8z5nv/FGWUs9tubmRDZufxadaPxvUtlfbgjEZ44WTSckoHTtvzsYjUZMaR03oQ
         1HfRhnOKg7O+DVgg68/3X0QY1ZwXV+9jztIkD5d2ReALAN/AedDnet1Je26ebEucEB7l
         8W/8nhjlwb/jp/v4ZQ2eG5Sv1VScKsDufOZ93UeSxTRjrUqNHV3zi+THOnpfQHnLsNp0
         evVaWldJdeIdYT0L1u2aTxqWQ4tyaWj5pcHlPbApukf2UTWesusLnpzVSC4M+8DGSiNq
         /BLZ+l+rXX/Dwx28cXOIuXc2+MHRFvR4/AhxQ8Xk4xCiiAuVohuAYgoZ6f5KQYaJU9jY
         +N0A==
X-Forwarded-Encrypted: i=1; AJvYcCUzzNrWp2vECheIaRW0SfTfYkNlOWWFm7xP218VpNKOksb6NXpDWB4H9Xa8pcgFzaKBlcdvnC7R12NS+eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqoPv4jjfunUU1Rw9xdFuYh7xoutWU8SG3lHcpwagKToG7bfb
	I6CuXh9jjZIE2hURZxKVmIAFYEUDxbn/yJ2Uu54IfCQXysXmBMOyF223J7+UBqM=
X-Gm-Gg: ASbGncv6UNhljNo2+nnrMnGg2Y7bwQRSVcI57s6tPu9sjJD5uG9b6k5YrMV/8G2MgLA
	yYdLAHM6gft29ey6JLdx7HR+uuBJzBJQEXTbQenMKWH8bdn2f+yvVHmLTtc7ye2OGsLuAYs/ExS
	An0C2k48UcvFrN4drxW5GaHr8xBpb3vE5ap4JVcI4VZZMaT8m8Jsrn7R047uTLUQSdUeLbJr7Dv
	Wrn/8DR1TR5KG3GiFTT7oo++1I0UInL/Uu0p84ZscwrTC+4cfpBn4PE2HRPVhnjZ1MAHbh70jwA
	PY+bVuVz
X-Google-Smtp-Source: AGHT+IH4OoVAMaTevbSOD4NAnydCBLKXfYO6Y/ztVCktUzZz3JGCobsK7cQQj7+kj/OqnerR0+uXMA==
X-Received: by 2002:a17:90b:54c7:b0:2ee:693e:ed7c with SMTP id 98e67ed59e1d1-2fc4115400fmr19719010a91.33.1739840851433;
        Mon, 17 Feb 2025 17:07:31 -0800 (PST)
Received: from test.. ([47.246.98.206])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fc13ad2d00sm8747614a91.21.2025.02.17.17.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:07:31 -0800 (PST)
From: Jin Guojie <guojie.jin@gmail.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jin Guojie <guojie.jin@gmail.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] [PATCH v4] cgroup/cpuset: fmeter_getrate() returns 0 when memory_pressure disabled
Date: Tue, 18 Feb 2025 01:03:16 +0000
Message-Id: <20250218010316.1950017-1-guojie.jin@gmail.com>
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

This patch modifies fmeter_getrate() to determine whether to return 0
based on cpuset_memory_pressure_enabled.

Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
Acked-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Waiman Long <longman@redhat.com>
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


