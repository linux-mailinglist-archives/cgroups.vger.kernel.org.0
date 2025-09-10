Return-Path: <cgroups+bounces-9866-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C18B7B50F71
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 09:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3FC176D06
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7ED30BB81;
	Wed, 10 Sep 2025 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5FxztCV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7E6238145;
	Wed, 10 Sep 2025 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489517; cv=none; b=iQh9ay+kue/eV7dCSlm9p4ympo+W532WLZ/dJEX9xbxTauIBVkHTZGIwnfQZMtZOLj9FwseZpmaS4PIZw4lCZvAdxRh90+k+/5vJPblXaPRN+ZtWdclWzcJv7eNa2/8ulbLfggJK1gZlF8oT0hEwLYWi2mC/XzxTp4ibiZxgDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489517; c=relaxed/simple;
	bh=517lES9mNI5nQHHt62Kh9R3q1ysG2WiWVqH7C6hOTUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAVERE9OI+EuhND+wp18N6S6R8/l2jgsJ67SqaxtM8J6jq+yt5fGMW5pR3klnbLHiSAFMzDJP37q/5wAaWEhKLioM5eqxlfNTyIPDMm2o+GDh5QViLTcYSiPavFZP8Ev9pZeleHblD7IB0kP/49+g2ecmXvcvbuI8NtZEY9wC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5FxztCV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24c863e852aso58440775ad.1;
        Wed, 10 Sep 2025 00:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757489515; x=1758094315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cPDFlkA5LYY1usMEz3BdE47dhloUedaleJrVt+cZq4=;
        b=C5FxztCVOQt3nL5KkJQBzSxZ0jHdeznc+64pBMlXiF0EkdvdxHP/C46AmT8pYK3Mc8
         pMiZ5IW74nqooX9v98YCsBp0bim+b6VLqnrcTRD1k6mhV9XOYSmeJaMa4whhMKwC9jVG
         2N1UslMHWAJ2sSBC5CDKphs9sap5gFLQIrvSC3NabJiMzDAVTVGmsZnRECAe/8PTM1CQ
         ijUGvww/VqiqlyNkTqDkvVBIJpy/i6ICI4QJVuDzuFI0JW574CKEVM6ynVcxSOf86CtY
         xlfEh9zEaEaAqdWgmtWL29FvFNhC9evg+04kPTADaP4IuEdARbYytNASub4jS2JoMHHj
         w8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489515; x=1758094315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cPDFlkA5LYY1usMEz3BdE47dhloUedaleJrVt+cZq4=;
        b=s0VESCKOW/Bb/cnmS0yjma9UixLKTTk6FZ8r4NZQLFqtx8UM1SBQ3u23oAsb5d9Xnv
         uhDyeq+fUHPiO6SXGiRFMSesyJDVmN33xOBC5e8RgI06vKVtvGem8D/RNBxi6FT9MgeO
         ShEuirh9QEOey7UxK8G+olkTjUK8jy+QbmicPDu/pO7wQOT1krACfO12odv8vYpRuHjF
         FotiedRKHofyjK1+HqyrxhkaKEK/Y0HN6MA67FpV01pCwsCEvNfXzrwzYawGIEvs2bXr
         nSdIcE3rq0QBaVlRc+akV8TucV1SMhMub5nY3TF2W9/7ZE60XHeNFeloZES4yVBu1ZjS
         1gBA==
X-Forwarded-Encrypted: i=1; AJvYcCUCnDAj2I+Yl4X1UdO0mtJQCQd04RLQV3c/XlgSU4+VMg+yDbBC4P27BAKmOwl38lu0QcU6CLVSDzln@vger.kernel.org, AJvYcCUFW/61Vfzdl05Un6epdItr4GI3EAOw558vO+mVx5Elq/gnphrJ6JmxWNGqEvIKChFcnicUuokk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jEznAzZ4l41abtzi18P0OJtWDEV6Q9J4Wryv7/y9fPX0YeiP
	p8j/Vf+H3BvbLh4k8KD2tM59tVG465fjnoe/RezrdSW5IZNg05990qkV
X-Gm-Gg: ASbGncu511eUf5SU6Qel7M5epOgEQ57VqPVkKP45QL9szHpWvYDDbQWlj2Joc1iEn1B
	R1ipj60OQhXaZSFRCUb61VkSOMFdQgIsVQQ3dVurV9MLDEyReQaqY5FdEfClGIiT1omwge9F/In
	MzLS1On4T9o6WbAX98z+TX1RDIVaLjr12cyy1Zr8ycUZUy9wTurgyZ3Ez7DLzhzWg8sLWazgSjI
	RKpr0Kv8EKfkcgJuJB0nb9ewc77R5B5nnfLKHaclu6Zicsk94le8DdBA7/DEjFUFOAnujjMhILQ
	MU9V04Q21geFigPLxfXZCeiQRoNnK87sM+Broxg//plIprVbNxrcMAY3svEQU/WI6EMbuhDayJK
	fHLzaxoKm1MN9uIKoLKQZ3oIC1Q==
X-Google-Smtp-Source: AGHT+IESCpAbPX2JHt9nEk4/NQCi5snL808PmAxfO09rt3WazNRz8Vkz6Y/KQ9TvmMhlDZg242DjGQ==
X-Received: by 2002:a17:902:e541:b0:248:a406:c818 with SMTP id d9443c01a7336-25172a53eaamr199761735ad.42.1757489515267;
        Wed, 10 Sep 2025 00:31:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a343dfcsm18372195ad.83.2025.09.10.00.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:31:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9B9B941F3D85; Wed, 10 Sep 2025 14:23:36 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of contents with contents:: directive
Date: Wed, 10 Sep 2025 14:23:34 +0700
Message-ID: <20250910072334.30688-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910072334.30688-1-bagasdotme@gmail.com>
References: <20250910072334.30688-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3521; i=bagasdotme@gmail.com; h=from:subject; bh=517lES9mNI5nQHHt62Kh9R3q1ysG2WiWVqH7C6hOTUM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkH1QUOBYjZ7GwsZyp4YcYUseZaRD5vjSnPDW1mlmyLv /z7vhzvKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwEQO5TD8FawxipXXMS+zP759 2dk1OyfIzi7Z/bOIa/rytonH2G1k9jIybGw3Ojlhntbv/bf+pU1aHBb5rN/1Tbq6qE1o28+2lRV KLAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

cgroup v2 docs is a lengthy single docs as compared to cgroup v1 which
is split into several files. While new sections are continously added,
manually-arranged table of contents (as reST comments) gets out-of-sync
with actual toctree as not all of these are added to it.

Replace it with automatically-generated table of contents via contents::
directive.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 79 +------------------------
 1 file changed, 1 insertion(+), 78 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 83bb69e3ab12a4..2bf24aa6c08ebe 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -13,84 +13,7 @@ of cgroup including core and specific controller behaviors.  All
 future changes must be reflected in this document.  Documentation for
 v1 is available under Documentation/admin-guide/cgroup-v1/index.rst.
 
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
-- 
An old man doll... just what I always wanted! - Clara


