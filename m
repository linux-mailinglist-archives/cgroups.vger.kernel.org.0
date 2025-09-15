Return-Path: <cgroups+bounces-10067-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275E5B572BC
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 10:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A9C17DDA1
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 08:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9142EDD7E;
	Mon, 15 Sep 2025 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXQXizLE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262922E9ED8
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924398; cv=none; b=G8X4BZHJ4Hsaxnzhasr4N75hsJynS2bMYKBdxafo36ixoAJLeFtacpiz6dMtR+d1x3Lq+2+/1Gvr845yEmKktde6j8WOwPAxWmky9JHqehL/WWGdoKW+NNC+TFXzIdO9CH8JRBxbgtUMHMYrS0B/3V+TLQcWrHEZbKuluQu2uHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924398; c=relaxed/simple;
	bh=3SLMJS/lDnJZBqMkyL8r9iFfFp+fz8sviWhPLkBSQWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv6HU2ibfiEQ1FQ6QVyAsWBqwWZWh7D8xqL+vnXU53UYYnsNsvRir8TFw1gvH9t/bZTg7iW3y93WakQNqXq56LQgV8PBdbcIsmphgFVlbKQ+9ptpVJUehObbvZPbF7i3Hw5qymUwe2NKOWX+EKFdjR3DR2gqmEzONbJy2zPWo/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXQXizLE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7723f0924a3so4785148b3a.2
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757924396; x=1758529196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tuPtQ4SxOZLNfch0+omPt2QYIaXrgoT4dbtn4I4kfs=;
        b=OXQXizLEqPXbEUEbrB3K5K/3SYl6v/Qeh+ymksuy0uIjbunKw17bOZsvFUbkQQey0L
         3021U23gHXAZ0Fg0zODCv0X+PLGdCDpYbVhXkH/YrgNyXO9egC7Vxfg00XPbgCnjwPb1
         Okm+4W0Z7DsO6/hmORvJQvUDc+JnxuToOcY1dpp/2h4jbHw8lHFet2zhi+zA9AT/XWzg
         33JLMIDo/3bPGCXB3YKueafqoSZI4P3orESgDvyPbvLsAlCdHbxM6X/87GYmbss2Y4Bu
         jp9rvHLomaMbu9miM7HGs6Go5UwocfewA0Wbh04bu9fabem9DtCkQK898nTWI3oXtCMZ
         pDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757924396; x=1758529196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tuPtQ4SxOZLNfch0+omPt2QYIaXrgoT4dbtn4I4kfs=;
        b=mBDIu7eJZ2x6trTf8eVocDT/hMxZ1UzPtfnFFn8kyN7+atWVMeihmCAntZs2sVDazl
         Yim0jLXn4njZOjV9kvT6CKmOoqRVGUinYSkHgV7OVwKSlWwtfBDkQNt18paosZf1vLqj
         HFppLmJ39JL/w0OWdrJ6NV8PSObqXhel5pwG7VnR8w2lgvim9WLxb5uNfpMAtVjtnIey
         8NirZY6ZvYxfkvvgH42b8a3kNDiqqGAwTxsQGggiwKpmHSS1CYLAYJGqfW/oNXVVVMJd
         Fkm6Mkp4iKu0F7NIrlaUro5KZ7PnHxotOraynQZLBTbSHDOHmCIdJgFPiWSX1xfv5EPh
         IxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6v7gOy5o6QS2Z7YTUWsg665D91JJx7Qy6mtwJxop7wHmE1f8SgcBCZdprGl02zwlcJpskswzE@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCJOprjx3ggdSLJJEUax3gVHq0cGUD9Z2/yZBNUQEhrjeHjmh
	0RxMdIO41LZE/MtpQdnGzEQ3P+6/ilIjLFtyautTjQNsobX8wQvFRsRn
X-Gm-Gg: ASbGncvt0JwSCNQ9BRTXfX0VE7CGdI5HeGOz4wAXOSF/SmhG+Bw9WyWi6Lq/EyL0xyj
	AkYGyfhfvpWKlPnRgdMKNKD8ghoYtz0FQEgV9YFWQpgG2FdLPyVZcZtbuZYd2Og03nqEpLcEfWS
	kn3jHZAqKRlJp1H2KCsday9SA0/QgABoBDwmAH6jZ8b51sXT8Kn+2onZ+cLWvbedYMx3KUYr+V8
	VDAYAdyEaT3zbWic3NBX3wU6C39OwwXJoOOvwF6k/yFdyFxBL1YLvZUEcwWwuMAEidQxHPY+Mms
	XuLYagmNrePQPF90pe/BeupvQUASsPKhWqK0ajVIPp4ALVti0P/3XTjvcV2O8MH4WqPg+xK7JLA
	KPmqzJtq+MNkyudPIlNSgc5x+YUDD7jYmaRvR
X-Google-Smtp-Source: AGHT+IFjAzN44hu7jSuMO7v+gYQTonWcz3leGKQXU9Bq3+D/SBABkdxu5L8wJtzhB44ovsWf3L4t7w==
X-Received: by 2002:a05:6a00:3e09:b0:774:20a0:dd65 with SMTP id d2e1a72fcca58-7761216c512mr15490380b3a.18.1757924396198;
        Mon, 15 Sep 2025 01:19:56 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b35fa2sm12379035b3a.85.2025.09.15.01.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:19:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0804F420B4E0; Mon, 15 Sep 2025 15:19:48 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Bagas Sanjaya" <bagasdotme@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>
Subject: [PATCH v2 1/4] Documentation: cgroup-v2: Use dot delimiter in manual toctree section numbers
Date: Mon, 15 Sep 2025 15:19:24 +0700
Message-ID: <20250915081942.25077-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915081942.25077-1-bagasdotme@gmail.com>
References: <20250915081942.25077-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5186; i=bagasdotme@gmail.com; h=from:subject; bh=3SLMJS/lDnJZBqMkyL8r9iFfFp+fz8sviWhPLkBSQWw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnHT+c1NB1/OvdG+O/7xn0fuR6ndmkw1V2/dYVFyYC7J +yua7t9RykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbS/4nhn+WC8isK9vuKzf9P PeH53WptTqfxl+gq617ttVdNb/rwMjEyHFr3s3bdikuP/tQ+W7PnY7fJ3M5nl85yGm0//VJA7v6 xTlYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use more common delimiter (dot) in section numbers in the manual
toctree.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 132 ++++++++++++------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index a1e3d431974c20..c3979661d95cd9 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -16,80 +16,80 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
 .. CONTENTS
 
    1. Introduction
-     1-1. Terminology
-     1-2. What is cgroup?
+     1.1. Terminology
+     1.2. What is cgroup?
    2. Basic Operations
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
+     2.1. Mounting
+     2.2. Organizing Processes and Threads
+       2.2.1. Processes
+       2.2.2. Threads
+     2.3. [Un]populated Notification
+     2.4. Controlling Controllers
+       2.4.1. Enabling and Disabling
+       2.4.2. Top-down Constraint
+       2.4.3. No Internal Process Constraint
+     2.5. Delegation
+       2.5.1. Model of Delegation
+       2.5.2. Delegation Containment
+     2.6. Guidelines
+       2.6.1. Organize Once and Control
+       2.6.2. Avoid Name Collisions
    3. Resource Distribution Models
-     3-1. Weights
-     3-2. Limits
-     3-3. Protections
-     3-4. Allocations
+     3.1. Weights
+     3.2. Limits
+     3.3. Protections
+     3.4. Allocations
    4. Interface Files
-     4-1. Format
-     4-2. Conventions
-     4-3. Core Interface Files
+     4.1. Format
+     4.2. Conventions
+     4.3. Core Interface Files
    5. Controllers
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
+     5.1. CPU
+       5.1.1. CPU Interface Files
+     5.2. Memory
+       5.2.1. Memory Interface Files
+       5.2.2. Usage Guidelines
+       5.2.3. Memory Ownership
+     5.3. IO
+       5.3.1. IO Interface Files
+       5.3.2. Writeback
+       5.3.3. IO Latency
+         5.3.3.1. How IO Latency Throttling Works
+         5.3.3.2. IO Latency Interface Files
+       5.3.4. IO Priority
+     5.4. PID
+       5.4.1. PID Interface Files
+     5.5. Cpuset
+       5.5.1. Cpuset Interface Files
+     5.6. Device
+     5.7. RDMA
+       5.7.1. RDMA Interface Files
+     5.8. DMEM
+     5.9. HugeTLB
+       5.9.1. HugeTLB Interface Files
+     5.10. Misc
+       5.10.1 Miscellaneous cgroup Interface Files
+       5.10.2 Migration and Ownership
+     5.11. Others
+       5.11.1. perf_event
+     5.N. Non-normative information
+       5.N.1. CPU controller root cgroup process behaviour
+       5.N.2. IO controller root cgroup process behaviour
    6. Namespace
-     6-1. Basics
-     6-2. The Root and Views
-     6-3. Migration and setns(2)
-     6-4. Interaction with Other Namespaces
+     6.1. Basics
+     6.2. The Root and Views
+     6.3. Migration and setns(2)
+     6.4. Interaction with Other Namespaces
    P. Information on Kernel Programming
-     P-1. Filesystem Support for Writeback
+     P.1. Filesystem Support for Writeback
    D. Deprecated v1 Core Features
    R. Issues with v1 and Rationales for v2
-     R-1. Multiple Hierarchies
-     R-2. Thread Granularity
-     R-3. Competition Between Inner Nodes and Threads
-     R-4. Other Interface Issues
-     R-5. Controller Issues and Remedies
-       R-5-1. Memory
+     R.1. Multiple Hierarchies
+     R.2. Thread Granularity
+     R.3. Competition Between Inner Nodes and Threads
+     R.4. Other Interface Issues
+     R.5. Controller Issues and Remedies
+       R.5.1. Memory
 
 
 Introduction
-- 
An old man doll... just what I always wanted! - Clara


