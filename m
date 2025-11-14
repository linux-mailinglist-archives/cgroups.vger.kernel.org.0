Return-Path: <cgroups+bounces-11968-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228CDC5ED51
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 19:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960E53A7465
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C526B34887B;
	Fri, 14 Nov 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bfQMXj91"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99533AD9B
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144513; cv=none; b=sdrQbtpyMWW66zcoM38DSCbuUBvuwXMt1Hs2iipvT9qvgc9aAtsCLg0CtN67SzepPsGA8d3uyM7MIp6m3MNs7zB8wKnQTHTQohMEywQaRBdc8u4DUg6S9o7N7dbir7t9y7IxA+n+2qgrdQ3XOQwHUhl+euzrO5QvizLt+HN6lSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144513; c=relaxed/simple;
	bh=08YHyxLxXktBFFkSp4yhcpSImQHSDMqN6sOacEYT/n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsRRSPqwOWFEJI6pO0b2DtUpbqC1Qche0J2nCHXg9s7opbSEzLCYFfO9gyi4pTf1VDIwNd3+R783q37+XDuE+Sxy2MvN2JcEve2tNFYGJhJxXLxtaNLtWtTPAF6i6daqUD5NemwYNVyvHjZth10b05FQjn3LjNHzbpdce69D1Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bfQMXj91; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so16877485e9.0
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 10:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763144510; x=1763749310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0Jh/y4rd6bYusl1JR/88Fg9gHoGK00Wwjf0mTqgXuY=;
        b=bfQMXj91woZAI+7gyL9UGVVG4vjjPP5XvAOicjucSdTx3nReZtFNoBPdmtQdMPs8FC
         4YeZhJdT97c6MnMZNsdUPhPXZjSLGMcIdNrWjwnT2ZE51/x6hEFtLxtGkLCNV2DXJbqI
         hZtyi98pgggdB1CkEb1WYCiqkjPyjFok8dnev0ny5H8dPhHT4qpETHSowrpR7sib/67Z
         eE8I6C20S+mQCPaxsHH1wvsHgdf8H6MeUU0fTroL+7Mfwc+afstuoAdqLHc1XR4NJX84
         LTdArOtE1VjOVOy03GY+P1GDa6HQ9Z5ZuwXj+Wn7xHQ0S9ycvZusshXc6ubmd8S+RLrz
         iHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144510; x=1763749310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c0Jh/y4rd6bYusl1JR/88Fg9gHoGK00Wwjf0mTqgXuY=;
        b=X8IVtcU5aQ6/SK7jxAj+wmXoTLC8Ndh0LI58+jL6xj6rDOgajVDjBqL3ea7bdDh1El
         vo81J8gKSLSdFow6wI5Ygw5m9Flc3WDi3dYZJz6X3DdnLb/KqVrQxBe9xzWm4LrJqnIY
         SBVwhCwMwQ+MkBXmzV313C+Ij58PlZ1TN+Z1qC4PY95NjCHQ4EKiGr3qabaIs0Y7dyGG
         TBnwaOWeZ8uEW4guq28PcOhuqBtYFOME/G3mBk43zzXm9VKSKpSwlQ379l8S9Tt6bEYS
         rjW1Cp3hNWSQ2bTQmPRYku7KBK1Mtm7sek5dS4A0PKPnV+muqZKoQaNSqjkxl9i68exM
         9W7w==
X-Gm-Message-State: AOJu0YwpEqw2UIZBG1p+7u20YkqYcFHIL9va2Q7wiacxueZ5nB15j0E9
	Zvl+YOjv+aEYWd/eSL8iE312cZBXCHAOQVeX/O3DGgL/Exc+O/fUpdzNEV+QqOllixPmhQIzlKY
	hs34Q
X-Gm-Gg: ASbGncvdmVrR0UxAautssHQ6LGHbf1YEkORuMKl7C98swiDTR+PbI0Wg6iIyegTcC39
	EgAptfYwdQkXvmRV83mPaEiJrOQyEIJF+rhgXhHVjGokIwiKXqzRgP9MDAcB7q47O64HqLP0pUO
	V3rIt+R8FrokWbxJGYQTCz9eh+xxZ0TW/kYVY0FEe7EjkTTSS/fLFBjFkDNv8tFBRhsVTZadg6r
	OcfgtyEVbL2uH1WLVjFLOJ2QW+Pw+A+NMEhO7bpZmHsoYYTIgm3dptjbcY6n2z6c1KKc/cvmCvg
	oV5bjzWH3aywyktm8cjQMGV6oNQx8BkYOF1oyAZCAcvQDE+JXquevGSdOSYteeoOLzMMt5Ec87h
	WbemDXUTbS+i1X17xo2MDHe2iC8xOf2mmQrnn7tvY1oSLsxNW0MJtNFNCq28UIqURXOVmCISRMS
	uBsjDk0YQQqR1leSjWmi0Q
X-Google-Smtp-Source: AGHT+IH4LYcmx2WzqwQB8AbvnXVanJ3gtD76gT7XHcpAH1DooanzMDiXV8K06l1AzX/FmT+O/TcBRQ==
X-Received: by 2002:a05:600c:3546:b0:477:7658:571e with SMTP id 5b1f17b1804b1-4778fea2df4mr43176505e9.23.1763144509812;
        Fri, 14 Nov 2025 10:21:49 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2bcf9sm163601805e9.3.2025.11.14.10.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:21:49 -0800 (PST)
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
Subject: [PATCH v2 2/3] docs: cgroup: Note about sibling relative reclaim protection
Date: Fri, 14 Nov 2025 19:21:26 +0100
Message-ID: <20251114182130.1549832-3-mkoutny@suse.com>
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

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 97a9f8a046c5f..e0a659474fa47 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1952,6 +1952,10 @@ When the reclaim targets ancestors of A, the effective protection of B is
 capped by the protection value configured for A (and any other intermediate
 ancestors between A and the target).
 
+To express indifference about relative sibling protection, it is suggested to
+use memory_recursiveprot. Configuring all descendants of a parent with finite
+protection to "max" works but it may unnecessarily skew memory.events:low
+field.
 
 Memory Ownership
 ~~~~~~~~~~~~~~~~
-- 
2.51.1


