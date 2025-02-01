Return-Path: <cgroups+bounces-6406-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B7FA247FF
	for <lists+cgroups@lfdr.de>; Sat,  1 Feb 2025 10:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E7B7A351F
	for <lists+cgroups@lfdr.de>; Sat,  1 Feb 2025 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF01474A2;
	Sat,  1 Feb 2025 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLdG0ST/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8B2B9A9;
	Sat,  1 Feb 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738403148; cv=none; b=TarQ/fOg6nMQ7TGAOALNL1xpqQ+pJfGD/k8d7eoEU0AFy/U5OtuE/2fEVTKUhulcjMeCF565LGIFBv/VWWxMRxJXQuXAiQICfjHwyCvG0Oizqy1sgFC+6XEG4Ein+hl5IwYaEE+CIuzm4n/1o3SQy7XqItRKxqn+CJxPbHO6Qvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738403148; c=relaxed/simple;
	bh=tLQ3X3o50sazcQ3riz1XRy19lYX43XwNdMTldntMfNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjXq9iiPCbnegs5bD7upL/R3Mhm1YKsh97ytuIEy7n1syQtmZucvScA3g/hVfXdxTqye8MA4JTZCEDgDLfvk83IdY6sclq+eZSZqoSKHcOXwxTeZcP/ALmSRRPwqxQ0mmr/rpDecs4LLVxH+913pQ7PAFYLRhkFN+VDZq8ePfno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLdG0ST/; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-21654fdd5daso49676515ad.1;
        Sat, 01 Feb 2025 01:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738403145; x=1739007945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AVRO+nMq3HdXxZo9GoEu318QQbe4p2iwPYY59ogFdgA=;
        b=dLdG0ST/VEv6fdGR2SdxZLPA866HZu/ogX4lUrfOLpX9yoe6hbX01NoE4+M6SEiZJj
         B8YL/WRx7zlKupLAG0e7d6hHW54hSmmb0I44zx874by8jqWOLLX7KKTBJIsUjutFKWh6
         OS16KntaEe+L0CcLp2CRkUWjeXeRA4I83JqOWPj4z48LFQHvG0gB2cppbqdR47csAsnh
         PoggsgEzk/SanCyhd0BDeiN8YAk4e49tbeSvnBHa97p9AWedODyVkYV3ZTja//Zj9dA7
         8nOCoaRPlxcqaBaDy1cbJhUwcwoyV9zZe47I20YfBNBZefquQ/l5ybsQJEOOsWWQU05l
         y41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738403145; x=1739007945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVRO+nMq3HdXxZo9GoEu318QQbe4p2iwPYY59ogFdgA=;
        b=eb9mE1NEEBxLAGc/O/Xd8cnnJeWpjcoGBqbKlng7ttNUzU31TMm47olHsfqtJ0eF/K
         K1N2RSWT5xG1izUgKCxFZATstu0INEPAngx4rlkeKI2bGbI+LBery+KW5Dx+kZ6QFeyl
         sB5py8FDvE+Q16XIBt4w3di3E1KGubw9zeN3ovOgpDOPHg21yEEsXoeZJWGv65Q9IkRe
         eEIyKAeVyHpFgt/1COuPbXP9UvNo4eGU9upfzWszfqGuizahBq8IpOrkMH5RcDoLQ84u
         rRUP2K2aGAE5fyzbkKMlRMPYEB1NDuJ2Go1VEhOyFFCOsQM7cis9abtmwb3HhdM0QuQg
         lVug==
X-Forwarded-Encrypted: i=1; AJvYcCVs26q3aMFXqtnDtGMhI1d6EGDJ4HCxqf4w0QkIqAKLwFhXxUznA8AjWHqTnT+oO6RXSmj2heC46i18/5RJ@vger.kernel.org, AJvYcCWz8WjDSat/9oL04gSNffFiIQ8Ilvw/PkmkbKzOdPWN3JGwjMserPyfzzjH99p6EgrEsX+B8Xn/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+GCRXlMvooZVy1HN3TUOKOH+IGtq7gYxlu/rnu+qFDh6CrcW2
	MnQVblUUPqBJBZvrXK196QSATlEnXOe5ByGooaAgjbLj/OxW8jM8
X-Gm-Gg: ASbGncv2wOpF4vECHuK3I1Fq1lcF0RfDS+DRSTbdxYKI7jP1YcamYKODV2J2NW0+xPI
	4ENPaLzQesw+vqwkZh5OMfJyUiqXfiEDfoL/xB8yHaXS1/Rv0Oc1LlpYKyLZ5pt2mxGQ7Y7oADC
	sXkKB6TkqGUSKpTsYaMDNq5NKU5hVDAgVs2vM5vpkbm3qHc4XXg2Pe3QXZrCx+buSuLh8rXoWVB
	nSbue+LTRIhtgAZJcNVk1PVR+3dplQJwUWtSjRl37bK8JHpkSC3FcyMurOI0QXWZ98nlxqRPmWH
	0GBZkJF1twl9NvUQzABFgD4ty0H66rB3mxZGvY1CmJj6vg2UubDx25s4eYekl1myP5zq/Q2UyDB
	fgieNiD/J4yoS
X-Google-Smtp-Source: AGHT+IE5X0DTIrkfK1LUMBwobedDoDXV1ZeOu3cfQ9HscDpKjTiSIcD035WjaH0YixcQwwFGkPBhpQ==
X-Received: by 2002:a17:90b:2c84:b0:2ee:b2e6:4275 with SMTP id 98e67ed59e1d1-2f83ac65958mr18136804a91.26.1738403145079;
        Sat, 01 Feb 2025 01:45:45 -0800 (PST)
Received: from codespaces-4a2804.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3320edfsm42597175ad.229.2025.02.01.01.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 01:45:44 -0800 (PST)
From: Umar Pathan <cynexium@gmail.com>
X-Google-Original-From: Umar Pathan <cynexium@proton.me>
To: tj@kernel.org
Cc: lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Umar Pathan <cynexium@proton.me>
Subject: [PATCH cgroup] Update freezer.c
Date: Sat,  1 Feb 2025 09:45:39 +0000
Message-ID: <20250201094539.29429-1-cynexium@proton.me>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 kernel/cgroup/freezer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index e9c15fbe5d9b..d384df2f53c2 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -304,6 +304,7 @@ void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 			 */
 			if (dsct->freezer.e_freeze > 0)
 				continue;
+			
 			WARN_ON_ONCE(dsct->freezer.e_freeze < 0);
 		}
 
-- 
2.47.1


