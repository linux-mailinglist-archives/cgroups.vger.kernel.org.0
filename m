Return-Path: <cgroups+bounces-6970-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DECCA5C170
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F793A7063
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876C325B68D;
	Tue, 11 Mar 2025 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GTvtN6TW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA69256C6B
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696629; cv=none; b=RY8mO+AvnfF++rwXSdB/dcTp1qLV+L6PQxVSewWzHP7LkWHFKbwtrreKmUg40Zi3oFyfTAH1A8F/866heqxFOSvctzKYtiIBQbKT9oQ09U+W2+RM8ofx9ewSCrfKDeEJ9PuBqG4/pOOnrlsPGkq7Y3wawUCV4nveT70Sf/VQvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696629; c=relaxed/simple;
	bh=lpN6C3vH3f4PCCjaCmy194/gBX6pshhqP80Aixto8yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvcdVEu5FHVctCNniZ1hlpcrnYqwlj7cmFu2TBLrh9RySJh+YV07A7eMNNYLuwvnYsA/d0TJHFGxO/VprmA+Lk9PnCyf69Z4wRzNgFEKGEz30cq8nxH19aS8Nv/ZdtCzwatGPopKeS6K93jwxoUe3UCfOQJTOJ2EzkeAiKcJYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GTvtN6TW; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3913d129c1aso1980084f8f.0
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696625; x=1742301425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzWC6pSc3pyPRb1xLnLmWP9XGPQURz0PKrv7Tm61llY=;
        b=GTvtN6TWGeCMg1TG4QtCiRJG763QZoZohxp3xAgDtPEEm2ibQro2Ud//c0TC3/Rmmw
         y+fJ9i5EjhYJiIZJYWVsgLJNK3BF5twdnYouPEyct4wuPzaTvemGmZx4mMASLlR2zsSE
         Vu128CFn/DDFb2ifF0sJc35aJ77hw4Fc431+1SyObsH9H2/JF3mm+X9DiFMh6kD/FSRz
         lGXYifBRmfAiWsvXXJEhhpIGNez1jlQuCD7KNifuTXK9LaBes5bquWgGnvRUFAUmbTeS
         magve6K3Y3yVafZvscDxUGTawbSJoMx/PR7GkcJy12RF0212YxMDcnB1d2LiueSeXhhP
         Ic6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696625; x=1742301425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzWC6pSc3pyPRb1xLnLmWP9XGPQURz0PKrv7Tm61llY=;
        b=iFDnXx0rPdHClM2vhT4fvZgPCHgLgBHQdc0OuoMwzy/FtlwXKIGCKxoW63STOoy64t
         ylOB+gtrOkElPdJ56yMLv5q5cRe1P+oYKE+Y0wq5wGncfsXqfQqtHFnakxWhyZZBkUmY
         CkAh4o0q9sfggJQaQ18QBEJvv81FmGd0uSj4mIW8H0DY9IKrpfe0D27epu6gLpHUVqJU
         OHYP74ZQkf9HUYi4JMdTpZS45xWlQReo7i4SNNmd3ENbv7AQgEVJ/Bu++GuhQJwfQsSk
         u13Gu7lzfOvh6IR5jBN3XZNufxywUNVvK94LPHmpt7GOV0iAW5bADcIS8i4Rgvfxpaz9
         eTyQ==
X-Gm-Message-State: AOJu0YwgGBzc9C9fPDRnFKxEeKdg0DGmvYhrhAV/vjH0pZnijCQaYadh
	OUpu+aX7LYiQHcl4rlyk8dP4Gb+Ff5AboGmdj5gT8Go/db0W3mD5yEk99qYlxO5y5bqx67SNumO
	zapWPAA==
X-Gm-Gg: ASbGnctug3LgbLry1tpjMdsdVqsjFPQN5izIfJw/V5AcACv/TLT0RcMd8mwleu0AOq5
	iMUt+tN8MD4TIO1JI8/BNxVk3nCWevR7l2SJZ2CxiY+iTkpvaIiCiMckLvCQ1VF65I9CR29aoUw
	690Xzh0FFAyM0N103cwamRc7M57jjcXaz6V7ibByYcYZqE0htQ8R8p82LypbaDzbS+n4Vob8XxV
	Pz+gNTOtCEzdhZ+bhdAILxx04d609TjrjT6ZqymWpd/Js9Bi4+/wef0ShxF71WZKsSTImxqULzm
	xzzdzD6m6AF0B7vCQgLZUn1B0gUEw3e+PTO17ViyOZ/JahI=
X-Google-Smtp-Source: AGHT+IHjGGtwlqaOo23AVRgIZZjsnb2eS9q9J1v0DCucwlPhaecePxi66A9LjOaMhcu9jnvCUdaHIA==
X-Received: by 2002:a5d:6487:0:b0:390:e9e0:5cc6 with SMTP id ffacd0b85a97d-3926bdf5c18mr4141501f8f.1.1741696623166;
        Tue, 11 Mar 2025 05:37:03 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:37:02 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 08/11] mm: Add transformation message for per-memcg swappiness
Date: Tue, 11 Mar 2025 13:36:25 +0100
Message-ID: <20250311123640.530377-9-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The concept of per-memcg swappiness has never landed well in memcg for
cgroup v2. Add a message to users who use it on v1 hierarchy.
Decreased swappiness transforms to memory.swap.max=0 whereas
increased swappiness transforms into active memory.reclaim operation.

Link: https://lore.kernel.org/r/1577252208-32419-1-git-send-email-teawater@gmail.com/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 1 +
 mm/memcontrol-v1.c                             | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 286d16fc22ebb..02b8206a35941 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -90,6 +90,7 @@ Brief summary of control files.
                                      used.
  memory.swappiness		     set/show swappiness parameter of vmscan
 				     (See sysctl's vm.swappiness)
+				     Per memcg knob does not exist in cgroup v2.
  memory.move_charge_at_immigrate     This knob is deprecated.
  memory.oom_control		     set/show oom controls.
                                      This knob is deprecated and shouldn't be
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 2be6b9112808c..29ca6489b4ff7 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1855,9 +1855,11 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 	if (val > MAX_SWAPPINESS)
 		return -EINVAL;
 
-	if (!mem_cgroup_is_root(memcg))
+	if (!mem_cgroup_is_root(memcg)) {
+		pr_info_once("Per memcg swappiness does not exist in cgroup v2. "
+			     "See memory.reclaim or memory.swap.max there\n ")
 		WRITE_ONCE(memcg->swappiness, val);
-	else
+	} else
 		WRITE_ONCE(vm_swappiness, val);
 
 	return 0;
-- 
2.48.1


