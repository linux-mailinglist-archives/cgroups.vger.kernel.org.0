Return-Path: <cgroups+bounces-10231-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7294B83604
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 09:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AF07226FD
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 07:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F282EA73C;
	Thu, 18 Sep 2025 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBgds0F/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2562EA494
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181282; cv=none; b=VsdquHW9gDtbCF0a9V4KmRikqYTB6tAFV2zBKqmIi4WGdI4LajCqpDm8NinPK1wIOqJ8WEQyYr4UGqVPpjOIxnY+qdssw2oNGZzFZ3Ka2ykKsuFUDzj1oaPa5ZrTQHBpScjxmPVtCHD836mjpq45TsP+Y+uBTDE+wv9oU/tSFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181282; c=relaxed/simple;
	bh=CYo+ThRi9YLTkaPWPwEFZLSRw7Sr+EbigfCEpDbe8Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rf5NyTe8x4+FL4wtILhDVRW1glX+f6JS2+4TMXZpV4SbTbqw2D3oo+y7DAfjHwr9zizoCHRZuW/74/pPcrYzDhwShmbimiLazV2uj8CwfKDrVxSVzBY7rIyAEgKMxx4K9WPxzvSzzg5z0y4HO7Yjt1RIU5dGaQ7+WHNAb+EfeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBgds0F/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-261682fdfceso19184765ad.1
        for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181280; x=1758786080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LP3Bd0aP9DzURHwOKIT419E9RC6+Q/KgVNOlgFr+0G0=;
        b=KBgds0F/cXRkx3KY4iMVJ4mymdq9NXiNlPyR3kUw0LWPPr2nj70JIaVQlZHbS/o+9X
         Yj8UJ6nKWKZuBYTODwMZrd9/QSqA6NuDeoWmMJzkT02tTz+FCgTZ8VNgevZYDU56PSTX
         CCAsfhk70LrSGe9Nic5GuBbqlJa/urQtWtaavSrP3aM+2uFp82CxMWEptI7D1EITR5nL
         9lLJ+2m5YAZzX46LBn4IFpLEW5NS6A1f3lg4g6QRdoZdXu51lBjxAAVHiSilNFLLx+JP
         EA3q7Tt6Ira+F0kn6s/6aoxqUse/PHGWQN0edLs8VfWdFcdJyBmaqb0fJX7RqReRFbq5
         imfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181280; x=1758786080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LP3Bd0aP9DzURHwOKIT419E9RC6+Q/KgVNOlgFr+0G0=;
        b=ALeBGN9c2hR88CpnS5FFiV911aM/CVecUQoHROPNzlNYk0el9dMhVR8H7qAGiDF+61
         QcNl458WaEg0uZeJJuWbhYgOE+KBjl5lzEopEKmx/fOjgb/RfBj3LIMuCM68XsA71hzT
         0nt3+c54YbJzdpvPOjEtiVeI0cvg4MZnNnAhEoSTzDyytBwwm01wO5Jsikp4m5UWXxqt
         heCZr9pT9MB4R4jRSbTRjWpT46iRtBD/KQso2XUXv5loaWdpV9+EcrUdda1lBUABe6FI
         ObzXemmVjMldJoV/Z8ihjnR1owdM/1qT24EeAje5Ajmc7qaB7sXsE9+UfRUyF9RARl6v
         wTWg==
X-Forwarded-Encrypted: i=1; AJvYcCUK6nW/A+5tCqOb5SAJ/hMYdDD6yw2GWd7cD5fcmogJkS9abJ1NH8tEJo8vHQ7hYCqyG0UryTyZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Nrkhuj43NEneqZcwdSfOERzKQHJ0WDstpdkqDWjyOWgWfCry
	IyQa7/sPEENpXxK+d76cue/oC9QLIscepefxg4k+8oPoh3hu8xDJYp1x
X-Gm-Gg: ASbGncuSaJG/4XxF9GkeAZmFvSAHcu5AOoyhy0/5NdWgjsBtGDpLvVaDyuZ+rANJ8dl
	dwEizxYp0pInUxcQ1YcSQPsz/NSl+D5sPQgpUqXEUvzD1p95XhXPHYaQRIXmqqRRCcdpkBgcY1q
	s6F7b8hOJ8mJDRvWJ+cV9idRpZekn1Ofy5ZDY46VyJbtHMY+NZ2LSDk0kSdUffpU+X59TuOecRR
	N292/3zxnzrrGz5rEw/BFaJKwORsRSCKD85Ulz8b98LInjr49+CZltip9/0djLNZg4ELGiJKBAl
	UIcYzGsy/zF4ZsURYno8SW7TFrDtNFfXiPYTqMfijQI5HwSQbNeBEcwpNcCVr4nSfyZomPgUxeE
	Ep4F60WRpl3k++ig1wgTbchGu4qerKoIFMXlMSKbf
X-Google-Smtp-Source: AGHT+IGi3Ysot5IFecJ/wpDgRLZt6n6fWBTeX763QBB3HvcW2dLPStQT8hc/gLqLnajn/K5Fb/M7rg==
X-Received: by 2002:a17:902:e5d2:b0:24c:ba8e:c5bc with SMTP id d9443c01a7336-2697c8166b3mr34846665ad.8.1758181280234;
        Thu, 18 Sep 2025 00:41:20 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053e77sm17158665ad.7.2025.09.18.00.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:41:19 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 037A34207D19; Thu, 18 Sep 2025 14:41:15 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3] Documentation: cgroup-v2: Replace manual table of contents with contents:: directive
Date: Thu, 18 Sep 2025 14:40:49 +0700
Message-ID: <20250918074048.18563-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3815; i=bagasdotme@gmail.com; h=from:subject; bh=CYo+ThRi9YLTkaPWPwEFZLSRw7Sr+EbigfCEpDbe8Ew=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmnt72vtGax8Xuy9de5ENNTaU3hhg/u7T53WMnw7EURz 7sy613PdZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiM2oZ/ooxfNj0NX7yjUtb TDgVdjMZtT9Tu6AWdMa1XXr701nmslGMDFPu/Fzx5U3ahCNvlh3MOce3J2uGZlq8qhXvO6ZjNwu 3iTMDAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

cgroup v2 docs is a lengthy single docs, as compared to cgroup v1 which
is split into several reST files. Meanwhile, its manually-arranged table
of contents can get (and indeed) out-of-sync with actual contents when
new sections forget to be added to it.

Replace it with automatically-generated table of contents via contents::
directive.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v2 [1]:

  * Revert back to v1 approach [2] (Michal)

[1]: https://lore.kernel.org/lkml/20250915081942.25077-1-bagasdotme@gmail.com/
[2]: https://lore.kernel.org/lkml/20250910072334.30688-3-bagasdotme@gmail.com/

 Documentation/admin-guide/cgroup-v2.rst | 79 +------------------------
 1 file changed, 1 insertion(+), 78 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index a1e3d431974c20..fdd3ee6cfe87a4 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -13,84 +13,7 @@ of cgroup including core and specific controller behaviors.  All
 future changes must be reflected in this document.  Documentation for
 v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgroup-v1>`.
 
-.. CONTENTS
-
-   1. Introduction
-     1-1. Terminology
-     1-2. What is cgroup?
-   2. Basic Operations
-     2-1. Mounting
-     2-2. Organizing Processes and Threads
-       2-2-1. Processes
-       2-2-2. Threads
-     2-3. [Un]populated Notification
-     2-4. Controlling Controllers
-       2-4-1. Enabling and Disabling
-       2-4-2. Top-down Constraint
-       2-4-3. No Internal Process Constraint
-     2-5. Delegation
-       2-5-1. Model of Delegation
-       2-5-2. Delegation Containment
-     2-6. Guidelines
-       2-6-1. Organize Once and Control
-       2-6-2. Avoid Name Collisions
-   3. Resource Distribution Models
-     3-1. Weights
-     3-2. Limits
-     3-3. Protections
-     3-4. Allocations
-   4. Interface Files
-     4-1. Format
-     4-2. Conventions
-     4-3. Core Interface Files
-   5. Controllers
-     5-1. CPU
-       5-1-1. CPU Interface Files
-     5-2. Memory
-       5-2-1. Memory Interface Files
-       5-2-2. Usage Guidelines
-       5-2-3. Memory Ownership
-     5-3. IO
-       5-3-1. IO Interface Files
-       5-3-2. Writeback
-       5-3-3. IO Latency
-         5-3-3-1. How IO Latency Throttling Works
-         5-3-3-2. IO Latency Interface Files
-       5-3-4. IO Priority
-     5-4. PID
-       5-4-1. PID Interface Files
-     5-5. Cpuset
-       5.5-1. Cpuset Interface Files
-     5-6. Device
-     5-7. RDMA
-       5-7-1. RDMA Interface Files
-     5-8. DMEM
-     5-9. HugeTLB
-       5.9-1. HugeTLB Interface Files
-     5-10. Misc
-       5.10-1 Miscellaneous cgroup Interface Files
-       5.10-2 Migration and Ownership
-     5-11. Others
-       5-11-1. perf_event
-     5-N. Non-normative information
-       5-N-1. CPU controller root cgroup process behaviour
-       5-N-2. IO controller root cgroup process behaviour
-   6. Namespace
-     6-1. Basics
-     6-2. The Root and Views
-     6-3. Migration and setns(2)
-     6-4. Interaction with Other Namespaces
-   P. Information on Kernel Programming
-     P-1. Filesystem Support for Writeback
-   D. Deprecated v1 Core Features
-   R. Issues with v1 and Rationales for v2
-     R-1. Multiple Hierarchies
-     R-2. Thread Granularity
-     R-3. Competition Between Inner Nodes and Threads
-     R-4. Other Interface Issues
-     R-5. Controller Issues and Remedies
-       R-5-1. Memory
-
+.. contents::
 
 Introduction
 ============

base-commit: 1f783f733450f72725c0040a2b3075614fa0fb5c
-- 
An old man doll... just what I always wanted! - Clara


