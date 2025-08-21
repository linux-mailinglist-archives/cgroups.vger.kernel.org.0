Return-Path: <cgroups+bounces-9309-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C81B30256
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 20:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957453B0175
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8741C3451A4;
	Thu, 21 Aug 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doOtMWm+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6DC157A48;
	Thu, 21 Aug 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802325; cv=none; b=T8P0quY53OOxF68No5jfL4y1VSc1dfKXFWsuDKXx83wHbSA8FYX9wuO0TtmzI40wObVgnae1epJyFguBJ7BfN+imPiQahS6dospfkFLC1gmpR8Di4JjiHn9mYegZdBbJ8MgpIgprScc/2E7ChJrMxa4F7+fajBuPPAqjkTLU62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802325; c=relaxed/simple;
	bh=rg/kDEvhXZwRvKUvqdPIc+V9sNjRhfxnVbeEH9rTFFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bGi86PTknBJALxF+4rw/327H7Fu7K/J25ycJPqgvcz6Bm+QxoprQmLIksUSz3f3rfaT72Bd41vlM+lfpQPYprncvVdLmMoUzBBN38KDGIhKMgFUQ8a75G3MNF7sRsRuj8BaZyeVpg0oJCuqJk191liBq8u93J1FGpoWLnRrNtA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doOtMWm+; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-24616482efeso4688205ad.1;
        Thu, 21 Aug 2025 11:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755802323; x=1756407123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEsDiCBMxIThKgCKK1ovgopu+gxDTLw7Ffj6tqKTBc8=;
        b=doOtMWm+aKyJl6+amTavRWHacqZNcLJt10koduKqhYxUnjb4XPlo8Kpa116+oCdWxG
         yqpNwGM7eGZ69eiZo/7fx+BQrzFFf+Spf9/0wFDc0fBVtMV3negfMiGt6l5brgIOJ5sM
         1tBPux7Trb3g8/qZ4hyroKPkKjdDQMgYqDeIzBJq8mBAIGNGFA36zh/PHms0nnjGKz7p
         e2IADwMkZ1jrNT5IYZth2Ae1b5dAnlt1uAkpT1Pt3vyvQu84sNaTvAKIxiIZOAKj7LMD
         sezuQiG5NP+MqW7GlY930Td8vfCQEwLQXl70PSLq4VBpy0O8Fa0117muHCYkkH0rPEEu
         ya1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755802323; x=1756407123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEsDiCBMxIThKgCKK1ovgopu+gxDTLw7Ffj6tqKTBc8=;
        b=UXmjSfPXpK6X2uWOdn1awJ79tsTh9HvvmfFGSU8C8D9q+p/Y+I+FC+dKWb68PkUTCP
         KcF5+5NcJDb3g8QmJpQYnaIe8DRpV7DSSvSYGKRkW//wum3Iq/vilm/QYvLdQJ6CaUos
         IFfYqOzqQJV81OulzzjRBgHWxciN3Xc627kjOXLG0LmKoT5EQaVW4N8nTJAuq2vv53kO
         Y8+bpxy87J1cyA8AVA4GURTvBcZSHRkxwygyflOfthQe7qlh5rVChTq+rMeTwuwsgZyv
         JWCf8wdNJ6/aMMGMSceWN10T/AJL8kqiFfptkR646RRgFychHZMgUBBUln1HfunYPCJF
         KYew==
X-Forwarded-Encrypted: i=1; AJvYcCUib9YoqVA04IHhS3eIneljsmlA6BZJrnagXlIrVVleE8f2vHzgcsNZjHEzEWsaT2bapRyq1MXuyDgEXDvA@vger.kernel.org, AJvYcCUra91rN6fcHFhtV0eWr9nm0xVm1KCEUBSwo64zRvH/P523mW9q8ol9rJImJQ/kouTrgxliE5cW@vger.kernel.org, AJvYcCV9WyYv7x1Qn70shocDpuNHC5PmNBGqYgrG9qeevGP8xTQOO5bXOMzPWoy8NNt7j0fxdNbBMk1OcxmO@vger.kernel.org, AJvYcCWVvkvAsmZsXG6b36f0x4dAoMouDMpgRKPvId24b5jqcAjaA/XcNTAlnuxApnVfZw0Lm/Xfgo5JrIsv@vger.kernel.org
X-Gm-Message-State: AOJu0YwRMXTjgKOF+ZMXvZk+ixj+3ajdUAa4RTIDtyNe4DoMh/aiZN0s
	6QZJ+1h4qQQBP5nn+nj/6L7xoMCzymZBQWNHaTqZnhdKKTk+wck3VFOp8BM65BeKNEU=
X-Gm-Gg: ASbGncuONBwC9BcL2iJSGDpZfrtIAof0bgnE0Fw6ZOCbiO89o58ebgyp7/ur04DdSEr
	fkX8nLTe5F5RlxlJmlm/HTzmFzTxEwpdA+aHibVUoZTh4UhZBui8sUhL96ZCFzqh7BtLg+Xhojq
	sXCP2JdWxDQKUDCB+DMrskGfB1x0W09NzPFFzXNHZHGydNKBpKi5/ZyCLwCjf23ElS4Pp2SwtgX
	xw/cKRQCUD5Kfttl7xb6vP/rHN5yrcAE5VHwPiigv+6Jb9CNuveGjoOqloNlsg6mJRT7AjtwGyx
	wumIY0IXCzOcfvd7+uwUMYIxvVgFz4eikL4qO2NMkp1wA58qgzWwt+kl0oSyHUETlL2/INIwvDV
	laItiE04FH9rjHxYMhBbPh2igT9sPyPqhDaR/FVhj9MvBrUfVKwfn+0akLNvVTk+txQ==
X-Google-Smtp-Source: AGHT+IH/aXJyxQ0KAGjciL/p9SJZ07FKZiRVvEFDDSCSKns92HHYUggbcR1QLy5gI55C4S85fXltXQ==
X-Received: by 2002:a17:902:db0c:b0:240:10dc:b7c9 with SMTP id d9443c01a7336-2462ee2ba4dmr4120325ad.9.1755802322934;
        Thu, 21 Aug 2025 11:52:02 -0700 (PDT)
Received: from chandna-HP-Laptop-15s-fq2xxx.. ([2401:4900:1cb5:9824:c72c:ee5d:1c89:315f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2462eaca84fsm2573365ad.151.2025.08.21.11.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:52:02 -0700 (PDT)
From: Sahil Chandna <chandna.linuxkernel@gmail.com>
To: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	kent.overstreet@linux.dev,
	tj@kernel.org,
	cem@kernel.org
Cc: linux-bcachefs@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	chandna.linuxkernel@gmail.com
Subject: [PATCH] Documentation: Fix documentation typos
Date: Fri, 22 Aug 2025 00:21:45 +0530
Message-Id: <20250821185145.18944-1-chandna.linuxkernel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several spelling mistakes in documentation:

- Availablity -> Availability
- heirarchy  -> hierarchy
- maping     -> mapping
Findings are based on v6.17-rc2.

Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst                  | 2 +-
 Documentation/filesystems/bcachefs/future/idle_work.rst  | 6 +++---
 Documentation/filesystems/xfs/xfs-online-fsck-design.rst | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index d9d3cc7df348..29172f03b863 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -435,7 +435,7 @@ both cgroups.
 Controlling Controllers
 -----------------------
 
-Availablity
+Availability
 ~~~~~~~~~~~
 
 A controller is available in a cgroup when it is supported by the kernel (i.e.,
diff --git a/Documentation/filesystems/bcachefs/future/idle_work.rst b/Documentation/filesystems/bcachefs/future/idle_work.rst
index 59a332509dcd..f1202113dde0 100644
--- a/Documentation/filesystems/bcachefs/future/idle_work.rst
+++ b/Documentation/filesystems/bcachefs/future/idle_work.rst
@@ -11,10 +11,10 @@ idle" so the system can go to sleep. We don't want to be dribbling out
 background work while the system should be idle.
 
 The complicating factor is that there are a number of background tasks, which
-form a heirarchy (or a digraph, depending on how you divide it up) - one
+form a hierarchy (or a digraph, depending on how you divide it up) - one
 background task may generate work for another.
 
-Thus proper idle detection needs to model this heirarchy.
+Thus proper idle detection needs to model this hierarchy.
 
 - Foreground writes
 - Page cache writeback
@@ -51,7 +51,7 @@ IDLE REGIME
 When the system becomes idle, we should start flushing our pending work
 quicker so the system can go to sleep.
 
-Note that the definition of "idle" depends on where in the heirarchy a task
+Note that the definition of "idle" depends on where in the hierarchy a task
 is - a task should start flushing work more quickly when the task above it has
 stopped generating new work.
 
diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
index e231d127cd40..e872d480691b 100644
--- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
@@ -4179,7 +4179,7 @@ When the exchange is initiated, the sequence of operations is as follows:
    This will be discussed in more detail in subsequent sections.
 
 If the filesystem goes down in the middle of an operation, log recovery will
-find the most recent unfinished maping exchange log intent item and restart
+find the most recent unfinished mapping exchange log intent item and restart
 from there.
 This is how atomic file mapping exchanges guarantees that an outside observer
 will either see the old broken structure or the new one, and never a mismash of
-- 
2.34.1


