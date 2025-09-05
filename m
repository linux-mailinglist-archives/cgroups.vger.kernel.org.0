Return-Path: <cgroups+bounces-9741-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1FBB45231
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 10:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59F93BF1C9
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF8E2FF17D;
	Fri,  5 Sep 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MfKvMmhr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224B23278D
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062523; cv=none; b=RCQNU/cR6uK68rL2qhyhX0N1zup9anF5xnf676DzSRT61rjlnXWRRLTSHu6jAX1e0fZLEVpmqsL11g6iZGIr4m+arc/mD5RT52whHWv/jYs1CMswAH24KdKkbGIO+S5m4mE5r4AA3wfT9WgkWOA1skcx9y190MnsonMAY/jyKXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062523; c=relaxed/simple;
	bh=W33kCBQrq1sazmSN8/SXjWeRCYxWjdmqGuSQHrjaZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVvgsq/eCN6lcTbY8EHNUf3shwueZRZj8dHabvn4Q1hXnvewwZwtbtNC4hVOXI4EPzZZtWhHWlA64Y9ZKRj491JtDi2xsnscCGlIUB4507hIKBsY7tdmTqtT5JP7luQ0fNrlpyAFLWqPLoSWjiHYBmICyOHv3WRCciqPBYrUIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MfKvMmhr; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e249a4d605so1191012f8f.3
        for <cgroups@vger.kernel.org>; Fri, 05 Sep 2025 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062519; x=1757667319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/ipke7Yn7BBLcOWQazhCZw2ILXfe7LPFnHyae+lwYk=;
        b=MfKvMmhrocqOFWzxyGPDZLFun/HKVeRgNOyc/5vtb3/jMFytRT9Myi7Eoh+ny8Syu2
         XT7rPeIvZJQapBpmQ3cxWmN+5p+mJhiSQetm56Q7vmgl2w3QJDTtUqaOINjvAeJKXzbW
         05GfCnGazWpU9BMhhEPjQ42/dTPuZCeDc5NkcXaRhltNJvHCcsmBpmXF+duZfXumjLiq
         K1NMz3Nxw1RNRSUsknd279cKZk8wpj0vZjni+zXvSf0PnIbELArGEOqrohPMGJJRkpfV
         7tznVPKi4NlmFT0KIWo+HodasA5a9+zMIEq/pQr/8VmPu7y+8HV0YEknoStQOn+s5SDh
         ph2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062519; x=1757667319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/ipke7Yn7BBLcOWQazhCZw2ILXfe7LPFnHyae+lwYk=;
        b=FT3GQKGIbMBlWqekGnvulTEya++hbRlsqai2f2OQb6EwVlErgbFYp2l2pV+badxBvr
         YEt81ipU/EzEkXgIi2Ng/XqbQ26tMD1qR1DzWgl6a2CxiOSvtyaZuTsNL/DRNUmDj6IW
         ExW+LMVMfFc3IkxxIsV4SraoAiR9njTHd9C322QsL9P9+jtiizCXF48JMDkPsk5Vmfmb
         qF6Mcvjuitv9kw/9oxgQtggGUtxc/Ls+lEevIdI3DR1LwLzlQNZ1cPFr8vWS382HTRXu
         xd55LsAarhyJx2VgVFBT3ArNt99JhElwYJCBEn7dFFbZfQ1BrCDGfx+UYB+1Mimxq9E1
         tahA==
X-Forwarded-Encrypted: i=1; AJvYcCVGMRaDA40W0TOjQSdo+wtmdLlx/xyzGjzbyi4q2qxc9SuKCg6ajsgtJ7N3vXdl/ENUYgDU9H87@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8NuavDG3cHyE/HH9WcV3ueXKiaupXcdFnZW9meW/r+1PXmKW/
	/Ujio0JlZPVKBDGGMrXf8bxQk/sY7XE4GtW/w8B3w3yILT2/Amhz6btWl3QPg/nhSD8=
X-Gm-Gg: ASbGncs+ChWO417AFY3G/mS5iwmoKLzVEVQIqESYZnYff0Wco7xrf58HOmnzM0SfMPN
	/vMhJKCn1kyJ4X5aUst9hMDAe/gu4U3o6C915Ke7zuOuRKaIVyd8FjzveqQu0b+UjHtKlK8qa03
	Dnlfil3npz2/m3+dbZ6R/rYN/a/neUtvIM17h7XRld2UvuQU8ftgQGgVONZJHqQX514S1mmH6SZ
	XCeActY9q5/fgUJHqMrCvgGuaF8D2jW3HldlmPN/CCRxgAiL6Xt1zNk6mCFUtv/Ph56EzcTXD0s
	by24nBuGVbHbESZlQTYWn/Z9S+MM24AjJ06NnDceami6x74mDA73SNoB3fiNN0s+Bf6i39fwUhm
	HtocPx2qyS6VMn0mkxPJ9nHJeRsiUeUVjs03C414KMQBGhNv8PmQJZCKyxw==
X-Google-Smtp-Source: AGHT+IH1vxXmkmQJCTds9ZYf/rs6uQBCjDIYTyd1wRbv+xHr6msO7l7HeEiqGF0FFDuaxiocSRxd/Q==
X-Received: by 2002:a05:6000:2883:b0:3e4:bec8:dcd3 with SMTP id ffacd0b85a97d-3e4bec8dd01mr369961f8f.42.1757062519375;
        Fri, 05 Sep 2025 01:55:19 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a32dbc5sm28178346f8f.11.2025.09.05.01.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:55:19 -0700 (PDT)
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
Subject: [PATCH 2/2] cgroup: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 10:54:36 +0200
Message-ID: <20250905085436.95863-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085436.95863-1-marco.crivellari@suse.com>
References: <20250905085436.95863-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/cgroup/cgroup-v1.c | 2 +-
 kernel/cgroup/cgroup.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index fa24c032ed6f..779d586e191c 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1321,7 +1321,7 @@ static int __init cgroup1_wq_init(void)
 	 * Cap @max_active to 1 too.
 	 */
 	cgroup_pidlist_destroy_wq = alloc_workqueue("cgroup_pidlist_destroy",
-						    0, 1);
+						    WQ_PERCPU, 1);
 	BUG_ON(!cgroup_pidlist_destroy_wq);
 	return 0;
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1e39355194fd..54a66cf0cef9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6281,7 +6281,7 @@ static int __init cgroup_wq_init(void)
 	 * We would prefer to do this in cgroup_init() above, but that
 	 * is called before init_workqueues(): so leave this until after.
 	 */
-	cgroup_destroy_wq = alloc_workqueue("cgroup_destroy", 0, 1);
+	cgroup_destroy_wq = alloc_workqueue("cgroup_destroy", WQ_PERCPU, 1);
 	BUG_ON(!cgroup_destroy_wq);
 	return 0;
 }
-- 
2.51.0


