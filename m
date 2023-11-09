Return-Path: <cgroups+bounces-259-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A47E615F
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 01:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABD61C20BFA
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 00:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249C36D;
	Thu,  9 Nov 2023 00:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thfy9YSv"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E114A3F;
	Thu,  9 Nov 2023 00:25:35 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E64269F;
	Wed,  8 Nov 2023 16:25:34 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1cc58219376so2214815ad.1;
        Wed, 08 Nov 2023 16:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699489534; x=1700094334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq98/p8Vl+k47pk7yX+yywphXxlOOyU6K07/EFvzpyI=;
        b=Thfy9YSvnxfrHn83A+EgwlnavRdmQvkKLoDawR1GFlSqwzkRSx+yE1ZJszPDTYTP9D
         6Iv7JxmHw9o0AsUwDOgxyRzsVx9SL9p1xVtmbaT2+bsSuV6FRiNIfkffTw6nA4Trndih
         btMhbHZCTrOKY26zNrzt2t7Qa8oRyU9iRqrFropDMmApdxR0MZF3ge/W103jKYkMbNKT
         HHQiXvSZXa9s9hLzH41lxclfIgzBYuOFf+Nr2A/ndidXemP8acfQEU4Tk+C/I7/T+ivg
         Xv6+7XFMkDbHXWorm3HIsrrImsSbPxebidPW871HcKSxpuQnQPaU7uY9gOGUHMEdxR99
         dRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699489534; x=1700094334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qq98/p8Vl+k47pk7yX+yywphXxlOOyU6K07/EFvzpyI=;
        b=JXN1tE24SkzZ8OD5cvpjiVcKXGileUHwy+bGiOlz6QDWCDabGiN+mzX4qgG1RiNJ5O
         bZu3Rbl8Ta13holoZ2k4YRaE/MRGkd6JsjwilSPlYASafQBsfWzdLycE2GqvgPwOiEU3
         ZETNF2lXgcb/6RVh4Dk8opKm0xHp05oaNlS/MnM+yuNg1/9CYnfe2ntV5CM5cXVWaHl8
         yRLkzo+NO0Wbhd+RlbZeloFsUYD2WpMGoPxGbi9t0xFobtsBXFBQHwDpLkWR6uO/61fn
         cxasBg1kPwnikhiCbuqfIizdAfP/crtuT3TKFBLQyhv/4l8qoY6i3Sr3Tb9G0AJh2DXt
         5a+Q==
X-Gm-Message-State: AOJu0YzULkRwmN8X8xciIxMUldttzDeaHSXKX8XKaFjsWubqbva5Iw1f
	PwjXp+Le4IaIyFyKcNqiN9IG9gjE+3SZ
X-Google-Smtp-Source: AGHT+IG33n4FpYvnXNhTgbwMQRccJmFurDlWpQj1aDFYjJh4yE47tryqcvBNYvztqjxwpVEYDqJQug==
X-Received: by 2002:a17:902:d58c:b0:1cc:50f6:7fc1 with SMTP id k12-20020a170902d58c00b001cc50f67fc1mr4371967plh.56.1699489534224;
        Wed, 08 Nov 2023 16:25:34 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902a9ca00b001bc21222e34sm2219073plr.285.2023.11.08.16.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 16:25:33 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	ying.huang@intel.com,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v4 3/3] Documentation: sysfs entries for cgroup.memory.interleave_weights
Date: Wed,  8 Nov 2023 19:25:17 -0500
Message-Id: <20231109002517.106829-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231109002517.106829-1-gregory.price@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cgroup.memory.interleave_weights is an array of numa node weights
to be used for interleaving when mempolicy utilizes MPOL_F_IL_WEIGHTING.

By default, weights are set to 1, and are only displayed for possible
numa nodes (ones which are or may become online).

Node weights are set individually, and by default are inherited from
the parent cgroup. Inherited weights may be overridden, and overridden
weights may be reverted to inherit from the parent.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 Documentation/admin-guide/cgroup-v2.rst       | 45 +++++++++++++++++++
 .../admin-guide/mm/numa_memory_policy.rst     | 11 +++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b26b5274eaaf..273dbd01a7ec 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1640,6 +1640,51 @@ PAGE_SIZE multiple when read back.
 	Shows pressure stall information for memory. See
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
 
+  memory.interleave_weights
+	An array of weights to be used for the interleave mempolicy.
+
+	By default, weights are set to 1, and are only displayed for
+	possible numa nodes (ones which are or may become online).
+
+	Example::
+
+	  cat memory.interleave_weights
+	  0:1,1:1
+
+	Here both nodes 0 and 1 are set to weight 1. Node weights are
+	set individually.
+
+	Example::
+
+	  echo "0:3" > memory.interleave_weights
+	  echo "1:1" > memory.interleave_weights
+
+	Here we set a 3:1 ratio for nodes 0 and 1. Mempolicy will
+	allocate 3 pages on node 0 before allocating 1 page on node 1.
+
+	Child cgroups inherit weights from their parent and may override
+	them or revert back to inheriting the parent weights by writing
+	-1:0 to memory.interleave_weights.
+
+	Example::
+
+	  echo "0:3" > parent/memory.interleave_weights
+	  echo "1:1" > parent/memory.interleave_weights
+
+	  # Child cgroup inherits these weights
+	  cat parent/child/memory.interleave_weights
+	  0:3,1:1
+
+	  # Override the weights
+	  echo "0:5" > parent/child/memory.interleave_weights
+	  echo "1:2" > parent/child/memory.interleave_weights
+	  cat parent/child/memory.interleave_weights
+	  0:5,1:2
+
+	  # Revert the child back to inheriting the parent weights
+	  echo "-1:0" > parent/child/memory.interleave_weights
+	  cat parent/child/memory.interleave_weights
+	  0:3,1:1
 
 Usage Guidelines
 ~~~~~~~~~~~~~~~~
diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index eca38fa81e0f..7c82e38dbd2b 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -243,6 +243,17 @@ MPOL_INTERLEAVED
 	address range or file.  During system boot up, the temporary
 	interleaved system default policy works in this mode.
 
+	The default interleave behavior is round-robin, however cgroups
+	implement an interleave_weights feature which can be used to
+	change the interleave distribution.  When weights are used,
+	the behavior above remains the same, but placement adheres to
+	weights such that multiple allocations will respected the set
+	weights.  For example, if the weights for nodes 0 and 1 are
+	3 and 1 respectively (0:3,1:1), then 3 pages will be allocated
+	on node 0 for every 1 page allocated on node 1.
+
+	For more details, see `Documentation/admin-guide/cgroup-v2.rst`
+
 MPOL_PREFERRED_MANY
 	This mode specifies that the allocation should be preferably
 	satisfied from the nodemask specified in the policy. If there is
-- 
2.39.1


