Return-Path: <cgroups+bounces-7677-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F7A954F0
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 18:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2111721CC
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3B1E0DCB;
	Mon, 21 Apr 2025 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkZ3d9HA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650513D53B
	for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745254286; cv=none; b=AzbM3qkc4eY2xHUEd0AVWHrmESYHnN2emIS/ZVVtRotcrTD3uAxASI6A3cPUUqRLPcMmr1J5POW98DKk4G2c8+LAzhSrERh+PcgF2OlbXHk5njZhfmtznQkaLT82s4UxP1Jb+1pcbegNCSm0n8N5LQ17dpKK/cuxLVa03zt9LIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745254286; c=relaxed/simple;
	bh=MxWz+L622ED9nKOXgOXCWXyvFaWex+U69gr60KmHLGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSWa7fZvlghhU96F1ZMkZ+NTSL42n5QMI1gE/k78+sxAjJ3+zV+gd6AzWdI0VlbkS6V4gdUdnj+2IkFVe8td/L6JjvaryZZIaYE5Au4CROXNSC2Jwjn35/futu5aPvW3L0IfrDI9w86wZ9zrtYqUnuIu4Ev3Gduue/41rlV4zPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkZ3d9HA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2260c91576aso36115245ad.3
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745254284; x=1745859084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+rOR+lHDm1dZmDhSOyaB/VVBVbXjMRl4vE9TaWHktI=;
        b=HkZ3d9HAUDabIbz+K39F7NXwzzA5S34iWnCYJn7q5PHdv/45mZDVZBJjveR28kcvrR
         yDWG7FjIItrKpwVmK629qOHCkQ0KcycuryPGcr+gQf3ONtRNPi1/DooTvWWG534yOw+r
         naZq5ieO5ax19ljzmS9MBqzifGmkwgPzefFmBnnOUZN0PSzRWaADgU1R8AshQJelv9j+
         v95eBgahIsRnYSFX5a7TIcEejU9T/PynJM+3cutsHitkNwK5xIycFvAAMAboQ20rESUd
         +Mydmtr6o2Z4ttX6TCGrkqryOWK7unlSVwy5vPYXiWL4svk7aEUa3TY4n+ghw0X7gaJS
         cgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745254284; x=1745859084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+rOR+lHDm1dZmDhSOyaB/VVBVbXjMRl4vE9TaWHktI=;
        b=cTQNg7tY/LO/ZSwKY6ncw6bT8R2jYB0I8s2bK9N4gb5jgT2yGke6kOi2aWgBrdsi90
         Og1iZ/uh/a2aztN3BH+7ewEYGmY87hNEkqEn4WMCtFxo42LO09FmQGXw7TxIhWWuukXy
         +26SqoWMkP8y55mvPoKT35xOE6XeK/77wM+lVphJKy4yUcX+SqQfii0YE5xF8gWWAXb1
         xo6a8BVmND9UQNNiTT2hrgJRJNDzUg4rEZVU9iPhSpyHqDj3gtWW1YcqnCZzyX014Hek
         IBKtZr/ueSVRf55GYtW+oWCI1fqNZ8M41EQLM73S5lT6wzxupyFxN2Os06C8FU6XqyaB
         ms/A==
X-Forwarded-Encrypted: i=1; AJvYcCWSznQN0kxZQ1Ukh7PjEtbCJy50e8ZPxmjQ8hFH0cN4JTpTCZRGqSAjQW+5KpgpYIBNEnav53gE@vger.kernel.org
X-Gm-Message-State: AOJu0YzXmmKplNoCeYjlfEYtlByv2psaHEIYsQGlPKynouowzVkqj1Z3
	ICUgLckeIyuiUmJ7swf9BDJqB8A8S8ZRpRo2xAcOrFimid83Vvms
X-Gm-Gg: ASbGnctmdJ35vEZODXhKzy2YD+ow2v53eYwxDf2GN2v2sUkhtIQskgcZHfhbayYhOgb
	oRUEinEiNz+pcaHObMSmkBDdXsqZTh0108CInUUozwtg0m/3FbR1UpRRoWlzSB6FJckaKadyd09
	h0wkwVG0pPdV0aPLIozX3Y5K/8JYhmFc/loqitGoQefYWndlj5pIL2WW97K3rjDOIPu/q/jEanM
	wkqGsyhT22HmDR6mrO1HD3XNXxaTNaLV4Mlw3CsrLiXnULoE8NfhTkgX4ITbrI+e+ojyvJGzB9X
	PNbZdl1cTGuGPiSgvUQAfPXjFAAL7HzON9rG9cRcxmBA8GEzPpINLp81IO8XPnzVCduY8w2RJTi
	m/ns=
X-Google-Smtp-Source: AGHT+IGS1bc68NfnosaRr5ityJ1PmW4j2slTAsDqqojz7WBW45NP418vk0eEonKoO76I5e5kIFH2Iw==
X-Received: by 2002:a17:902:e5cf:b0:21f:2ded:76ea with SMTP id d9443c01a7336-22c5360dca6mr184886245ad.36.1745254284161;
        Mon, 21 Apr 2025 09:51:24 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::6:17e0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf1371sm67782375ad.57.2025.04.21.09.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:51:23 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH] cgroup: fix pointer check in css_rstat_init()
Date: Mon, 21 Apr 2025 09:51:17 -0700
Message-ID: <20250421165117.30975-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In css_rstat_init() allocations are done for the cgroup's pointers
rstat_cpu and rstat_base_cpu. Make sure the allocation checks are
consistent with what they are allocating.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 4a8834a70ca6..4d5fd8d12bdd 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -371,7 +371,7 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 
 	if (!cgrp->rstat_base_cpu) {
 		cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
-		if (!cgrp->rstat_cpu) {
+		if (!cgrp->rstat_base_cpu) {
 			free_percpu(cgrp->rstat_cpu);
 			return -ENOMEM;
 		}
-- 
2.47.1


