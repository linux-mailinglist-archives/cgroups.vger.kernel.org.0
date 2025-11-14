Return-Path: <cgroups+bounces-11969-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57719C5EDB0
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 19:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C13A5341C41
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 18:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72F0346E69;
	Fri, 14 Nov 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q9vhOsyU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9143314DD
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144514; cv=none; b=eijqUYIr/KNukCgEthlrC++xC6QrYV7jgWCvN97/fJj//84ILO/FIOPqRybok0fmZ0E5u1MZHIbm7sxaQY87P0VWNCyw+NUkEDbmyo5jSVziNo/DB9CpuJ6criyBgcibiOxvIbl1CkI4uajn2kF79W/TcFOYAtIZBU/wIn+lrFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144514; c=relaxed/simple;
	bh=85KX9yDDVB8BnTWHIncxzE+cW+QLAcnQO6w4iKZbAzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FvQxqqLao+70wzzamPYv1y061J8uGqv/d+leYIE9+wIfigSWRQUb4PXgdKrnsKTAP+LI7n9BX2bN6mRLM3oQHpuS0rr/3dbhetCzjxyzXQ+oVkvDZwAus4a98ySARhSB14kzgOkaQrg/gVCjppwx9Cf+/6y3qdHcgONSTnHsMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q9vhOsyU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso16861115e9.0
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 10:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763144509; x=1763749309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3tD+YD9/ORK0rticjPEQ4CUY27QdrfXjzBGevzpz0k=;
        b=Q9vhOsyUpNq0mpROxcQEM5wCDWUXIJycpB6T51mhSWn7uw9UUXFNy8LjfZW4s52KHc
         a3sNYXN7+Oat0onFmHNUh2/zv3vy0UtpVLbgbD7AZAEm+J68DHwRrSOca18DsvvSGxS7
         TH3lp98BPWGEp/kFX0TAElcr2wGuCF1pFl5zmzziP8SwkWipY5r8hXXQDm07WyJwS79W
         5rYMZWM1QCNNMdLse2ZfF5PlSAMQzy9iqcNCOCUbfPy00ucXCrynd6ut13Hzfv7vbWBF
         f4qYg1iH8syi8vlXhBWMNitvhvvSDcVlx5wf2kvmRKAvANOLRD/OjuebF72XKp663hoX
         UN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144509; x=1763749309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v3tD+YD9/ORK0rticjPEQ4CUY27QdrfXjzBGevzpz0k=;
        b=E9CX/l1o3FEbxzzL9oAcWfVoQdBQo2qEC4MD4NAkvBoEJRwn6rt5YJkCr6g5Y/x8jX
         bvpHMVfhEuznnYfuRIPTSbYePwOpxFrMdlpqqImAw3ScFekvXtP+qzBWw0+ZF76g0e6L
         rWauY/dbilWzKMEX3Q8IiNHFOliuuQVIb3EmHqJdyTAZCE1qeJntJT7oYXU7ccLPTwap
         /T7Kwh3BAUfR4aitO8v150rWS7D3ujaklgvY9DmdS0ZJwN2mUB0PACrVDsDRZUGZbdi+
         Tqus9WWk5SnCMtv8lMg1jn9hBGso4j8KsohtBOx/PXDnDqBaI54KEJWl/z+RXfCGCg/J
         86Ig==
X-Gm-Message-State: AOJu0YxH7Yn/NvL5nn6cO5dHDLjGM/lOcalceXFn13Oheisvdiw/yVlE
	16H/3NY7ffmSqZ8oPi2/kADI5gQAfXXV6ZHNUpAXEDyZTiF555cH4B3+twR8YOuKPEio1Uf142F
	UAN82
X-Gm-Gg: ASbGncshWLIM6iF3QQ+ve/mqhKrGbAECg33vkMUXkf0sjL/fD1kAIkBGFzjYRoH2+UP
	vic99KL8bkVR5BQOcmG4G5PmGQd9ujK3jlziNJetYAHXj9dQXB8qk9zyFID7LJo9Yi0s6ukqLva
	Q6X571QTb6jGFxiXq4HvGzEvnJ2PkgIzTJRg0Orr3XjXP/be6fwrAv/UTwOoDPRwB9icRcrb4ED
	KRkLoSZ7Jho1nfhMzUrgrjGyosJobR3OOTGRyIFguVlxbxkJH/7g0byaaDp3ndrX75wgopSPJZO
	HKqGL6mPD/jAYM8iGNKxZZS1qmO++UD7egPeIb9VFyuuAJhfWXN8FLYgESekfAM9q3CtEC+W4BG
	LsK5nN9zqNNfk5wtSzVe0rTrh+t5TCONiXRveKJm9k4x4MYOZ+elsktecyplL/s2DV1bhMW6oME
	qNixDBQabc8+6u2wI74zw28uZP3flM0vI=
X-Google-Smtp-Source: AGHT+IH14BxpFJRrNC0c0vgpnxrKVwMjdnmZHfxSy/H6uvy0JbyViL8DLlAC5JCnJMGGUJ1o8L4QxQ==
X-Received: by 2002:a05:600c:a43:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-4778fea84e4mr40741745e9.32.1763144508727;
        Fri, 14 Nov 2025 10:21:48 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2bcf9sm163601805e9.3.2025.11.14.10.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:21:48 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Natalie Vock <natalie.vock@gmx.de>,
	Maarten Lankhorst <dev@lankhorst.se>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 1/3] docs: cgroup: Explain reclaim protection target
Date: Fri, 14 Nov 2025 19:21:25 +0100
Message-ID: <20251114182130.1549832-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114182130.1549832-1-mkoutny@suse.com>
References: <20251114182130.1549832-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The protection target is necessary to understand how effective reclaim
protection applies in the hierarchy.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0e6c67ac585a0..97a9f8a046c5f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -53,7 +53,8 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
      5-2. Memory
        5-2-1. Memory Interface Files
        5-2-2. Usage Guidelines
-       5-2-3. Memory Ownership
+       5-2-3. Reclaim Protection
+       5-2-4. Memory Ownership
      5-3. IO
        5-3-1. IO Interface Files
        5-3-2. Writeback
@@ -1317,7 +1318,7 @@ PAGE_SIZE multiple when read back.
 	smaller overages.
 
 	Effective min boundary is limited by memory.min values of
-	all ancestor cgroups. If there is memory.min overcommitment
+	ancestor cgroups. If there is memory.min overcommitment
 	(child cgroup or cgroups are requiring more protected memory
 	than parent will allow), then each child cgroup will get
 	the part of parent's protection proportional to its
@@ -1343,7 +1344,7 @@ PAGE_SIZE multiple when read back.
 	smaller overages.
 
 	Effective low boundary is limited by memory.low values of
-	all ancestor cgroups. If there is memory.low overcommitment
+	ancestor cgroups. If there is memory.low overcommitment
 	(child cgroup or cgroups are requiring more protected memory
 	than parent will allow), then each child cgroup will get
 	the part of parent's protection proportional to its
@@ -1934,6 +1935,23 @@ memory - is necessary to determine whether a workload needs more
 memory; unfortunately, memory pressure monitoring mechanism isn't
 implemented yet.
 
+Reclaim Protection
+~~~~~~~~~~~~~~~~~~
+
+The protection configured with "memory.low" or "memory.min" applies relatively
+to the target of the reclaim (i.e. any of memory cgroup limits, proactive
+memory.reclaim or global reclaim apparently located in the root cgroup).
+The protection value configured for B applies unchanged to the reclaim
+targeting A (i.e. caused by competition with the sibling E)::
+
+		root - ... - A - B - C
+		              \    ` D
+		               ` E
+
+When the reclaim targets ancestors of A, the effective protection of B is
+capped by the protection value configured for A (and any other intermediate
+ancestors between A and the target).
+
 
 Memory Ownership
 ~~~~~~~~~~~~~~~~
-- 
2.51.1


