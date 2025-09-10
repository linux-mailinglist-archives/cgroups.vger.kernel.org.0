Return-Path: <cgroups+bounces-9867-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE04DB50F76
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 09:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8F37BA1C6
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 07:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5378F30BF60;
	Wed, 10 Sep 2025 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeeongAW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73D305957;
	Wed, 10 Sep 2025 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489518; cv=none; b=ZYVvqLSwEe62k4MZ2nJU5OvainZ1E4CaDInxQE54kL9Nd6LMBvR6gdXl4tssrjRT58hbX2GOtjukbEgxOM30ELo3NT5gx4q/UqhpPIjgVvlWkmZnATXPt3DA1BQ/Mfs+Soptb8ulM58beJL1GjuSOqTqvCCXrDVb6v+HS9oEQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489518; c=relaxed/simple;
	bh=GCAvUEt817jE1UfrkUfHOuRjFkE/h7Ued4bNwWkeIv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6BezpUxPyPGHCnn3QQovkAcZ3SRsCuk1ZffZAg8m1s5OUyXlQxZoUuAvnygchyoXmROYdgBNDLI/dsBuf0VkhIQvK8H/Iu5QzZfAbUHwxQnyu+AdTH7bpsRZoFGWM70Aj5AibrXN/kP8FUdlKCRk9a3YmBYnVBbkQ4eNiseX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeeongAW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77460a64848so1423762b3a.1;
        Wed, 10 Sep 2025 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757489516; x=1758094316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDw9rvUm4LoCF9nUVjTsCctP6XEfIJnsd1KEfoMSp8Q=;
        b=GeeongAW1fhlckqTGUlw+taqWmr9ps3DuuOHn7EP39ErMBrPM9rcPa9LG8P1OUoOGB
         IKchtk+cswuNJiUFASE+bpbUu8WFLsB3pwx+z64/L3JWq2pVPRBEoDcIjHSVy6DFpVQ3
         NYofsHcrdDReJzci4HiXU3zp0AS0ISeUjLH60lKsTfdviHnLxRBbXBH0EORC0PIbsd+H
         MJJGe2YVQDRcI4i27Sccfk6I1N3SNiygG/ZW/bSwSuJpZRnCnaUtlDiaqYib8m/PKZGz
         zQTPhQbvEPRxMstJS9BZpjFyO6B5oc3lM3SMTtzhaeTkcswhfn0v1PtOEpRktYK10+Zx
         Y6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489516; x=1758094316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDw9rvUm4LoCF9nUVjTsCctP6XEfIJnsd1KEfoMSp8Q=;
        b=P/DLar3O1f9XgqPxr0xfFzsWk8RSlCnzrqB0eT2Gttcnj+rw8p+s/WF809i6b0RQvK
         5E0bP9OblJy0lg8AFBY8SBUeB5lHCIXtcpq3TokL3O5ZLplwGMC3HJqEuUJJOG0b1FWW
         4S6M0SoGUCEt0Hwh6EdbY2NBiPODeDa/NH36vsU8A0dQE1GlNFk5fTOIcuJGdinI38FH
         gc9Qins+FlNsakcQ1FTHWv72ogfhBPI1H6wSpV865bWuEj9PwVo6W0piP5ONnYVpCWsw
         PTaDotAZ8sX3Lk7v2hkvrmNJD1ssL70+BGFAT/UUSYdXxp/HMCKxQqI/FXYDjKGpKUVO
         k0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCW5j4SFKfD32qfJj1z1MmBjirdwnDRVY1q5/6MA/zINSIRusSiRF3CMTOmxZQccGNVfiPWx8ontBlt2@vger.kernel.org, AJvYcCXw/drVV6MZEqDWPb+2khyrcNcgpL2cC365F0JLAN0nTKu7zRZ0yP0ibdgl2coL87GuR4iuzwMF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7oi03I/CzOsu9ZK74Vv658HKHV4Hxu1OzAUr0nq6QRxmoZrf
	qPGkGoNPenpOUHtYtW7AzvcYQ/Yim+O8vtQMYfNL3HQwfgEO6PhHfpLL
X-Gm-Gg: ASbGnctCzJ9E0Brkr2whBjTjoZVPxM8RY5D880X5x38Hbr3vRERmzAUzmNRWJw0s7s4
	89nw9ne2zNh4PqnasEXl8XQ9eP7MdGZSOZaNOhtFF25zZjpKxsiXJUKCRG0u2Rnc3auButrHao/
	wnyKLc+85AlzsIb7QFysG/YtGRPmns2xoATBAgQMzrP3KvW3RWtFjSnA4YqWfyyZS4vUYci6G13
	gxMrgdWoX27Hx0RbyJMyPD83mwxftt8vSEwlkQju07SYS5C5Rt3+atlj3ACHn8FO6DUKpsLF0/T
	dGc3pI5Pi4H7x41A1jofYkgJwUfsynsJtXyJvI67e2IZ8J2MifE79An6lBB1KlqIF555Cn9SKP5
	2pKi3I6RdfHMIN/LP58s4MUtl+A==
X-Google-Smtp-Source: AGHT+IE3pEaftAQHMINkBNOZJ4EgXbJdxBxWcNKXKOENumrJ3wbdoJJJ4s4My3kWHhNRXKnlYdWVDA==
X-Received: by 2002:a05:6a20:9392:b0:24c:48f3:3fdb with SMTP id adf61e73a8af0-25344413080mr20465619637.39.1757489515665;
        Wed, 10 Sep 2025 00:31:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb31458dsm1487539a91.10.2025.09.10.00.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:31:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8D45041FA3A5; Wed, 10 Sep 2025 14:23:36 +0700 (WIB)
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
Subject: [PATCH 1/2] Documentation: cgroup-v2: Use document path for cross-references
Date: Wed, 10 Sep 2025 14:23:33 +0700
Message-ID: <20250910072334.30688-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910072334.30688-1-bagasdotme@gmail.com>
References: <20250910072334.30688-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4079; i=bagasdotme@gmail.com; h=from:subject; bh=GCAvUEt817jE1UfrkUfHOuRjFkE/h7Ued4bNwWkeIv4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkH1QVOnlU2UJJ7uvLg/zat5wdF5L3P7LLnSV1u9atUx 5rpf8P6jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEwk7ArDf481jw5OzW2X1m5k 8uGxPS1z8NC9abkPZ8hMbl3s9XaL0BqG/2Fep2+9vGG9/6Jbw6Enb0xyA8/O9zCfbJby1Uxzp08 NLxMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Cross-references in cgroup v2 docs are written using :ref: directive
with full document path as anchor text. As there is a facility on
kernel docs that allows simply cross-references with target docs path,
replace the directive.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/accounting/psi.rst              |  2 --
 Documentation/admin-guide/cgroup-v1/index.rst |  2 --
 Documentation/admin-guide/cgroup-v2.rst       | 12 ++++++------
 Documentation/scheduler/sched-ext.rst         |  2 --
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
index d455db3e580838..460e11f988fa89 100644
--- a/Documentation/accounting/psi.rst
+++ b/Documentation/accounting/psi.rst
@@ -1,5 +1,3 @@
-.. _psi:
-
 ================================
 PSI - Pressure Stall Information
 ================================
diff --git a/Documentation/admin-guide/cgroup-v1/index.rst b/Documentation/admin-guide/cgroup-v1/index.rst
index 99fbc8a64ba9e2..c0c6ac522569d4 100644
--- a/Documentation/admin-guide/cgroup-v1/index.rst
+++ b/Documentation/admin-guide/cgroup-v1/index.rst
@@ -1,5 +1,3 @@
-.. _cgroup-v1:
-
 ========================
 Control Groups version 1
 ========================
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index a1e3d431974c20..83bb69e3ab12a4 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -11,7 +11,7 @@ This is the authoritative documentation on the design, interface and
 conventions of cgroup v2.  It describes all userland-visible aspects
 of cgroup including core and specific controller behaviors.  All
 future changes must be reflected in this document.  Documentation for
-v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgroup-v1>`.
+v1 is available under Documentation/admin-guide/cgroup-v1/index.rst.
 
 .. CONTENTS
 
@@ -1081,7 +1081,7 @@ All cgroup core files are prefixed with "cgroup."
 	A read-write nested-keyed file.
 
 	Shows pressure stall information for IRQ/SOFTIRQ. See
-	:ref:`Documentation/accounting/psi.rst <psi>` for details.
+	Documentation/accounting/psi.rst for details.
 
 Controllers
 ===========
@@ -1132,7 +1132,7 @@ processes can be categorized as follows:
   without the ``cgroup_set_weight`` callback
 
 For details on when a process is under the fair-class scheduler or a BPF scheduler,
-check out :ref:`Documentation/scheduler/sched-ext.rst <sched-ext>`.
+check out Documentation/scheduler/sched-ext.rst.
 
 For each of the following interface files, the above categories
 will be referred to. All time durations are in microseconds.
@@ -1213,7 +1213,7 @@ will be referred to. All time durations are in microseconds.
 	A read-write nested-keyed file.
 
 	Shows pressure stall information for CPU. See
-	:ref:`Documentation/accounting/psi.rst <psi>` for details.
+	Documentation/accounting/psi.rst for details.
 
 	This file accounts for all the processes in the cgroup.
 
@@ -1903,7 +1903,7 @@ The following nested keys are defined.
 	A read-only nested-keyed file.
 
 	Shows pressure stall information for memory. See
-	:ref:`Documentation/accounting/psi.rst <psi>` for details.
+	Documentation/accounting/psi.rst for details.
 
 
 Usage Guidelines
@@ -2142,7 +2142,7 @@ IO Interface Files
 	A read-only nested-keyed file.
 
 	Shows pressure stall information for IO. See
-	:ref:`Documentation/accounting/psi.rst <psi>` for details.
+	Documentation/accounting/psi.rst for details.
 
 
 Writeback
diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 404fe6126a7694..1e614958dd96c3 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -1,5 +1,3 @@
-.. _sched-ext:
-
 ==========================
 Extensible Scheduler Class
 ==========================
-- 
An old man doll... just what I always wanted! - Clara


