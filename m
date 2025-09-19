Return-Path: <cgroups+bounces-10285-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8784B883E8
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 09:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2C616D6F8
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5F62D3752;
	Fri, 19 Sep 2025 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5HjLSNh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1E2D3728
	for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267866; cv=none; b=IAuJyHQ9LPZXwkToWwG0P/EvOlEz95lfyUXYeVPd0MJfAjDhmmrojMHuBLoT/Ua5n/8HBU3NcNGJANzDGOd/hmrQ+F6kbezuive6+jA2jjPp53NK4z0dmIwhkzxTEyVAGQDI63zZ760pHLwt6FCxJgTtHo+GPqbRflJxxADLb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267866; c=relaxed/simple;
	bh=IhMTJiJ4XXzfEup7tgi8CaAZbkD8B3NYlGyzeBPgaEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hu35UItSu8Eyiw/RVRP0WObNIHUUhkP5GGuovlum4+WUngGYW1RsJpgTczbm8eg/8+Dz15MWGl8j0emehPtZ0xHo+rLaz5kHMupMkOnGEDAZGrZNIRSnGHTUk886MZC367Vgb9gGEPlNxsr+q5+2E5Xf/G1rWzCJL2ASCSVmiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5HjLSNh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f0e9bd80fso7171b3a.2
        for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758267863; x=1758872663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vG6qO1K3AuWLLhPwZRw6q+QLLXM0+ngTx3cqIJZ5HaU=;
        b=c5HjLSNh2+8ayP5RUxN6bbgwDydzJ6Zcw5KHojtOiCpL8qdE2/4vo48tbCA5nV3pVa
         UqTmBYZ1jm/XagRwKex1MZjyPc7Oh4tZOhFlNhhQNd3Slo8WoHJp6CCSlrRbFCn+Z8M7
         d1juCVnKzlHXl1Pou8pqUabvIbMGvE7DWCF+rM9ODC6VHBVuX1pqBFRzh5Wps3dVmQOd
         Q/NLSMAeHehNtcnK0rR49a+DZTOeJK78jPZ7hxmrO85Hf7PKsDwRsh6GPo4Q7n3kXEa9
         PteNRR+TlbydXcjk4XNBVOL+ls2zVh9yl+SW7SR4K6v47cBz62VSSJGvTxfjJT+34tpO
         KMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267863; x=1758872663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vG6qO1K3AuWLLhPwZRw6q+QLLXM0+ngTx3cqIJZ5HaU=;
        b=L3frldI4ZwghXpEfHf4RWnOJaH8B5goHpexhMXFBq+uYZan1+6HWeyKTce01DLDdqa
         bJRcPovfMNXha8Q4nqlHhfIGd1u88Axrim/R0CB3YHVC4pl+WvtMoxeoj1K1MNC2uBiN
         JJ4EqRlbTFSlYRZ+9UTWVCgh6zERLU7IdRz8Jl7rytpsrCqWShvxqWTztjIORPkv5NZ+
         m6jV6tkjGQXKc68LUH7UtTsQ0faLwkMNLvrzaC12EAHYhDavyH3f/RtcP556Hic+BEYd
         3eqq5uT5lvzik/rNZg4x3XuaziWKlk+55vxSdoo8jKhNdL6OSbZHGvkqA2gLQDWcDtG9
         dEww==
X-Forwarded-Encrypted: i=1; AJvYcCUIR3SxveWIDdi2y1p7WR325r0r0l8MORJ2V3qW6BapA/2vYYjdyktm/1CWg2jMOK8t+4f7ohwz@vger.kernel.org
X-Gm-Message-State: AOJu0YzQSfO7uDiIZiFNepJ+8oAUjkbCZH0hMIzr3hy+Y/xNclqjOfsC
	JK/k0mmA5XGD57M3EAgwJ9FrdS998MGD8PiZEhI+har5PMCQAybJuZc6
X-Gm-Gg: ASbGncufxOlYKYLfs4Pv4IOGozndZ2B1BdB9ERspvbel3u+FuFFt1tcujVV70SUcYnz
	Xt2F7VI1JDCiwhQ3AoVXO//voH4nvb6htcm9TTd7ulqGmgaYZVDJ2Hbf+jhCGb6+W0cOPYMULjh
	ARrTvgQV+ys/4HTZL4yoN0d7wgjQA7qr1FRbpYlxc8a97j6LGS5BlxlEpD6vTKXvOcQdE7ssHHs
	75mGuUzF767ptfn5t70EL/XbY/k4itIG41Jp6fc/Euhuo7whiVzNZA79Fy6Fycp9r69gEyHnhs6
	RdYZsjKGAHRYZKLp7GAe04LEI5WXCcEz898AkidBxZW0uOoNuVHW6Q1cjHJ8ew2ogO2oL2HFMnV
	Wl+t4qxtfHRUiOVieFx5zXQ==
X-Google-Smtp-Source: AGHT+IG7//NOvD5yGr1fblFVOLOt+MkTcSVkQIY/16xdMDZU5QmWOY3ASNrTOB7GIZkvpjGRj4IkTQ==
X-Received: by 2002:a05:6a20:1593:b0:262:9451:c648 with SMTP id adf61e73a8af0-2926f1d63camr4103807637.37.1758267863350;
        Fri, 19 Sep 2025 00:44:23 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff42f744sm4212333a12.45.2025.09.19.00.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 00:44:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C7CB24227235; Fri, 19 Sep 2025 14:44:15 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v4] Documentation: cgroup-v2: Sync manual toctree
Date: Fri, 19 Sep 2025 14:43:48 +0700
Message-ID: <20250919074347.33465-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475; i=bagasdotme@gmail.com; h=from:subject; bh=IhMTJiJ4XXzfEup7tgi8CaAZbkD8B3NYlGyzeBPgaEQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlnOdOC1jzMNv5z5HL9wX9v3RU+dT7Z7sDLkrawUp/Bw laygW9DRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACay1oiRYX9Lw/dd0T8texvz gh/NeKyQrsSoYvMweIb5MYOis9/3FzAyfInRFQ8OdZlSJ3KYpc7FeO1Gm4ynC7b2lhiEhd5ZWHC GDQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Manually-arranged toctree comment in cgroup v2 documentation is a rather
out-of-sync with actual contents: a few sections are missing and/or
named differently.

Sync the toctree.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v3 [1]:

  * Keep the manual toctree and sync it instead (the same approach in v2 [2])
    (Tejun)

[1]: https://lore.kernel.org/linux-doc/20250918074048.18563-2-bagasdotme@gmail.com/
[2]: https://lore.kernel.org/linux-doc/20250915081942.25077-5-bagasdotme@gmail.com/

 Documentation/admin-guide/cgroup-v2.rst | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index a1e3d431974c20..0e6c67ac585a08 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -15,6 +15,9 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
 
 .. CONTENTS
 
+   [Whenever any new section is added to this document, please also add
+    an entry here.]
+
    1. Introduction
      1-1. Terminology
      1-2. What is cgroup?
@@ -25,9 +28,10 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
        2-2-2. Threads
      2-3. [Un]populated Notification
      2-4. Controlling Controllers
-       2-4-1. Enabling and Disabling
-       2-4-2. Top-down Constraint
-       2-4-3. No Internal Process Constraint
+       2-4-1. Availability
+       2-4-2. Enabling and Disabling
+       2-4-3. Top-down Constraint
+       2-4-4. No Internal Process Constraint
      2-5. Delegation
        2-5-1. Model of Delegation
        2-5-2. Delegation Containment
@@ -61,14 +65,15 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
        5-4-1. PID Interface Files
      5-5. Cpuset
        5.5-1. Cpuset Interface Files
-     5-6. Device
+     5-6. Device controller
      5-7. RDMA
        5-7-1. RDMA Interface Files
      5-8. DMEM
+       5-8-1. DMEM Interface Files
      5-9. HugeTLB
        5.9-1. HugeTLB Interface Files
      5-10. Misc
-       5.10-1 Miscellaneous cgroup Interface Files
+       5.10-1 Misc Interface Files
        5.10-2 Migration and Ownership
      5-11. Others
        5-11-1. perf_event

base-commit: 1f783f733450f72725c0040a2b3075614fa0fb5c
-- 
An old man doll... just what I always wanted! - Clara


