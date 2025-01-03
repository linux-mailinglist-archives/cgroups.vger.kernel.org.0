Return-Path: <cgroups+bounces-6033-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96451A0028A
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816B63A3B34
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 01:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8A7154BF0;
	Fri,  3 Jan 2025 01:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXey1Z0J"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B3148FE6
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869045; cv=none; b=WrO1kQFIhViv7OY4auj4KEFb8FWYNN1tTD7jUUvfJALPLyk/jVJpkv1uK6E5PFCuv/kWIN2SiQGJiC1KTBG4adLyDYmCMUif70LgFSIr7kJoXGdEY8roDGOSXSWu05HfjxfVBu2DQWf55R8cBDY1YCmr29Lnd+KamDDoALM2jdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869045; c=relaxed/simple;
	bh=Vn7b+Y0pLjinf6VkyTXTXYx3cD/eYx/5hEYE2FtMyQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZK3RYNMGRc+T73Aj6GsfP/YbUMgKI4xCH7hKB4YVSsYTFPnqbMtqhA9ASqcQDex869bHxJ5A3nz+xYLQ+4MOqsUiFmrYd96XKWk2GuE/3ao4oYcFXE3kvHVEeYebnNJbADeyo/eJkZ1CHrKOn9CdX3CbT5liXqVBIKi5Qhj1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXey1Z0J; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2163b0c09afso160420585ad.0
        for <cgroups@vger.kernel.org>; Thu, 02 Jan 2025 17:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735869043; x=1736473843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpckZ+t0825F6IGB976GW0oaJ6tqis13qibxlRS1UMw=;
        b=dXey1Z0JW+ClH3nEm+/1tWlAXSKx0rX+BU69q11ogtLvcfG3GeaIRKExKNfnwXKO2O
         akcRu8bOgSgCd3r+E0SAxAz4OE6aWwIvgQD3A17GwfzvZ6EeCrAxLBRPi06otIAxebPY
         oBtat/rqXGIii6kpFLkMJtwzyOaAGcnSC05wG0ZgdaNqBwejYNFF5BJuuOKwYxCm+4r2
         lnrS3RTHrrGDPvEPhormGrnJcWTzwPk8cT4rokDfgyRtyRQaYoRAtmF+/A9qOKFJxRgp
         7a4YAyR+lLp0zixu3bxVbvb322a5KHT6V2o+eRX+Tmpn8zt9wWIEjSVXkQ/0ITlI0V9q
         xHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869043; x=1736473843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpckZ+t0825F6IGB976GW0oaJ6tqis13qibxlRS1UMw=;
        b=Uxx/OD+UbZJ5NMbLXMQNe4LHqIa9e+rSDUEaqcvA/Og5M8rqi/xVQdVCdh3EBZTn73
         7V4Ggv8i/+hQatxkwDon2Ft66mr1HbbT4LpOIyWyQw9q6vvp3IpRZ5BJtHoah0QkUHpk
         6UEEcOO19pUt9LNStbeahanteM465UWYMkjloSOy+l77fGbWAxgkLUCXUsGLRTB+kjM5
         /tyT4Bn/y764J0kPU2AMwNobbVma+U5AvRdzRPbB87M6cIdCEXCvcap+LfS0oN55sJBI
         B+4ZAs1wNW7tDx73XlgUQk0VYBEuFwX3yClXZVNqEh8JD673RI7L44GtIpalLlpj/o9Y
         GXaw==
X-Forwarded-Encrypted: i=1; AJvYcCUg0sFOCH4K/Ni98gieWnvrpoFo3uK4c2ZmmM/+zqCUXMRKx1Q/9AtrqjTIJe/AUurgTK/19Mrf@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf7efbdWk307cOArAkaKtGeCsbKGkGI1zqtCDGPLyWDL0Wq/pb
	N/MC+Aza2aPL46op/Tpqb02Ko6lDyaz8C4PHTHB7Kon7LQvtBiW2
X-Gm-Gg: ASbGncvRshYe9tYiF86QDRdw5iT+0qyj0zm2i1BVpRXE3hqHsw2Z0ct3IN6c2NS3pyB
	/og0Gk9SzCKm/Hq3Xq4tVbIvSD/tnabAR/k2dTRc1GmCfS3OPQ0TFX+fjI5WCnKssWFN3ZBKKFw
	EO2wc4/eg5XVNBiFlXi1JCliS5gTz/9fUCif4ZHLdV9WzUBecHNqcwn3d3A13cQkgDu1HScyvO0
	xruqgp3e1VMMt2jslOVSqI3xcXc5z8Xic14mS98t64plh5+XGS0Qo56APiuYVxoIsJeL+UpChdC
	V1jiGXBcpDhb8Dh/eg==
X-Google-Smtp-Source: AGHT+IFdazoj6fte8hxpaNLnC8unSV/ywRTEJ0Kh0HqeY1Q7I7MuHrhSeeZdyfL7DZejliHH6GwWqA==
X-Received: by 2002:a17:902:c947:b0:20c:9821:6998 with SMTP id d9443c01a7336-219e6e858b4mr607012025ad.10.1735869043451;
        Thu, 02 Jan 2025 17:50:43 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca04ce7sm228851505ad.283.2025.01.02.17.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:50:42 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH 9/9 v2] cgroup: avoid allocating rstat when flush func not present
Date: Thu,  2 Jan 2025 17:50:20 -0800
Message-ID: <20250103015020.78547-10-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103015020.78547-1-inwardvessel@gmail.com>
References: <20250103015020.78547-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a given subsystem is not the base type and does not have a flush func, do
not perform any rstat allocation.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 03effaaf09a4..4feefa37fa46 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -423,6 +423,9 @@ int cgroup_rstat_init(struct cgroup_subsys_state *css)
 {
 	int cpu;
 
+	if (css->ss && !css->ss->css_rstat_flush)
+		return 0;
+
 	/* the root cgrp css has rstat_cpu preallocated */
 	if (!css->rstat_cpu) {
 		css->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
@@ -445,6 +448,9 @@ void cgroup_rstat_exit(struct cgroup_subsys_state *css)
 {
 	int cpu;
 
+	if (css->ss && !css->ss->css_rstat_flush)
+		return;
+
 	cgroup_rstat_flush(css);
 
 	/* sanity check */
-- 
2.47.1


