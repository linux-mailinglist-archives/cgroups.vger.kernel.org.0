Return-Path: <cgroups+bounces-9739-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30EBB4522F
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 10:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B843B66A9
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 08:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650DE281356;
	Fri,  5 Sep 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M/0j53tF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CF27E05B
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062522; cv=none; b=YAd/9iDDvGMhklumOG+yBjTPIE2cj9S9mHq48igk+izXVWTQbQZ1j3oK71gxdYqv3KEe9zioBPwpAn8hqltKyIbrMxGGfpUI19WvDaJlw+S72F9uNy97iewcS/ZGPo1kDgXldY3H/lDZDL6vLetcyzOjQUfTTLc7WVjnkM1iAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062522; c=relaxed/simple;
	bh=rPqk/i8FHiso17+h8HR95Fljzg9ubNSYBKvqESikwFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwHmi7ywXA6p7hmhRyp/dphz/XHZC36Kr3toBjBqTPv6hvrnGd8vYyqeZFeBM5H2DjXUfpw4vAKMcR0wObCfCFCgTsRZZcCeGeLHbNxDksRBxKZuy0Ge1/NWjw2w+8YzA8DZBLmtZoMQilRm7++tN01EzLzbWwSh17j52Qb16pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M/0j53tF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3df3be0e098so1016441f8f.1
        for <cgroups@vger.kernel.org>; Fri, 05 Sep 2025 01:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062518; x=1757667318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAGsQ/32s/KKYkZau8Rby6xoFYH4N+/s1hCU9vRuvK8=;
        b=M/0j53tF/wAPQ7/tLbaOR8uKHqPRRnpGXcmgg8wiOT3BrO++pDCR0ZW5Yujlt3JFMb
         E0StLcNHgxYol00GNOAQIjBKEyFah2rMs4usckGCya87qHhR4DnKYID0KpPo1sTN6lkB
         bSRF1CjjW+qBeelfXySXMGjybezase9/H+w4j+JtIElR93L7nqZVoXLKpURsu9vlxu8j
         wXKZ8FjN8/6kNjTDzB9isn6P0SEfXnrtQMDtO1kw8nhVxKQKEW9x9JsIxNKfOAOSdo3r
         VFlEccQ5zqWkwk0HlPyuQpS7qNGIT3II4oHU3nJ4PTQ2Ofs5WN2KBjlvRjmcq2KFltD7
         0JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062518; x=1757667318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAGsQ/32s/KKYkZau8Rby6xoFYH4N+/s1hCU9vRuvK8=;
        b=Bry+V/HBmIzFxRO0GGJ5s2b0Xv6R+ENmOjSGyhaJEZEqvRDWRIRXnc05Lxrt1aKv2U
         19W6yg/V3U6xsZAt26xfxsVZsCfdeMhJeibIilUUuyvs/CPtcuKF90YTB39HGJqdij/g
         WqD2k6TWSs8HuuaHwaj4N0R5mF5WgCjL2YMxLX9KxTPqXDVx3USOaiWax3FSD3XzUKnH
         tSDLg7qBfIYrzVuFXEs+X1xxMqOR3H3jAo8PGL7u7J84YyF5HRkkwQy5KFe+IxrwIIIO
         Bb44d+PYr52njDITlmkTlizcilSeYUfov/UWXQdodP3FdZ0za0KJwahsaJJGpMiQaQIG
         cA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6NJj/C4G21s/5bQa3G6cQk49qQRSt/LfZXosO/IyyTxFHhjzy3fKXmDfM9Bk3PZiteinQPDb4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2Pi3qujGIizcr2yzlX32587G4fVnCrKlA6w9jVjgTmAjLKLl
	0/vSi1/tb9qrvLG8WdAcVYUIeld6ZyD0hhvwK+G4nMiiKfrXPwAXqVLeEL3mPhmqkl8=
X-Gm-Gg: ASbGnctyX1X3L7491t2XN4ysFe8L3RfHuz8ba1eB5wB4Cx7nmunYHgCDWCVzgjT4eTB
	KDZlSiEJh/GuunM/6EkiIEUN8WXq2aDkQY5tgsyLX3GwspZ9Q2RfZGq0EqLCeXBUWMEJoieCgFa
	D5hnik8WI2CxXGLLGRZ+F4qnT0U3/MLn9yv8fHL+YeAeXzsMAHa2HMsi1aWOyEWOiWfJadNLLq6
	mg9Wc5h9Pl0T7by7lLmINPuvnmUWjboZZW5DyjxmpIazHYY3PlmNTEoY4xHTF/F3lWougSjFX2J
	EKkErY+8FdO4n8YnLL+XcAwCHRxy/vEv+XGtfyH3ZXOb2OEPe2VDL0yh+NZYR+WNwgaBBTeTgbV
	bac8wWdPVWPd9K1LCwEzT86agtPYtH7YyJr/ij3vi7znW5go3EGwbMGI5QA==
X-Google-Smtp-Source: AGHT+IEIeeWlv5Y1zYgVrT7F52IJeE+DGSxWfwj/+Ab75L8oWqb439G29fc+gz412+/+BrWVo8S3uQ==
X-Received: by 2002:a05:6000:3111:b0:3dd:6101:4efb with SMTP id ffacd0b85a97d-3dd61015026mr8283880f8f.11.1757062518456;
        Fri, 05 Sep 2025 01:55:18 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a32dbc5sm28178346f8f.11.2025.09.05.01.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:55:18 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>
Subject: [PATCH 1/2] cgroup: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 10:54:35 +0200
Message-ID: <20250905085436.95863-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085436.95863-1-marco.crivellari@suse.com>
References: <20250905085436.95863-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3caf2cd86e65..1e39355194fd 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -121,7 +121,7 @@ DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
 /*
  * cgroup destruction makes heavy use of work items and there can be a lot
  * of concurrent destructions.  Use a separate workqueue so that cgroup
- * destruction work items don't end up filling up max_active of system_wq
+ * destruction work items don't end up filling up max_active of system_percpu_wq
  * which may lead to deadlock.
  */
 static struct workqueue_struct *cgroup_destroy_wq;
-- 
2.51.0


