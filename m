Return-Path: <cgroups+bounces-10409-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AB9B98265
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 05:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96C62E5212
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 03:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2B323908B;
	Wed, 24 Sep 2025 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MHtIr+he"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636F2367DC
	for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758685271; cv=none; b=G8yl1cBi5XQxm5rgrrdscCNoTN/eOZzJxP0WjNfnM2AZPEhwXqrvKtw+nlXB5CWvNhl6uptC4Ao2YFeUEYTINSiA8n2wQStqQs5FK9cYXfjUbQw8cCCvOOvmK1sWh9dAh8jukfCr+Y/XvcmIyttb3XAsHadv11Ut+ikOlmZ8mb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758685271; c=relaxed/simple;
	bh=spqI6rzBALnpSMNsrDVeCcve/oeu3eO31tW3HIY0PFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VCpP8/5502YTfIz8HjSo/dQ//Efsj6l3YiICrSO4cRkXFv+bVvdY02TiCm8i8Bwy8xim5wO8a+l0Axg0K9rGPS/6dSXoRoldSjJ8uyP7KN7/ArPO39vml+JUv1fshWNCaPDaWDBZBDzpad0SSysFNxyMDxea5J+FzK+ELN8xGOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MHtIr+he; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-267facf9b58so46320595ad.2
        for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 20:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758685269; x=1759290069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHQ+DdEo33vc4KCDGuMUNzkfwefcdJo6mPASmdDLS5Q=;
        b=MHtIr+he5Duynx5X1HvjwOokS1IiiunLkGznIbqK3hfMULQsThQDbFodYmm0osKe05
         kyN0+UHk/6t6a5g8udpExpraPYl3wSQ+jXLGvv/7njZfTgp7u6jVPpeVdHhJjicsAuam
         pOM0BafW8Lntvo/ZuX7EOKOLQiC7B6BMFpmoCtauaEOeuvfb41csG0211e6gRWh2QRKn
         1B8lxpLYqqkVonRPXRnrr6L1o0T/NollK3YBGgeS4kcKvB47bV+6/Xe2RefAx5JlYg5M
         +dRXd727aSPhSqADHSA8a6D8lGfbep/dOoGCk3lAC7Vu7beNnbDZr7hNtsXydgnY/ljh
         6yfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758685269; x=1759290069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHQ+DdEo33vc4KCDGuMUNzkfwefcdJo6mPASmdDLS5Q=;
        b=nmF6k0qunZXFP7FzMIsYOqDpoByS3VO3bTugJRz5kX9cbFirnDeFOvM7LjDcgz/w+N
         WqxlfzFAJvMbbm6f2TB6pHoR6p/fdcOQmt1w+eRK3CfqKzEI2FETdMyDdUUDCWZ3mo5K
         1tL6tJwMqqfx9b/DgPxj5YiMA8oKLCGBDtYk3hAoocgs0TSD2srNq72dMANXGDVm2DWb
         S/ADbAotfcuWwDUGYSF715QARgAkgfeGNnGqVhF2cwg+XxPOei4WhUwuIdzgmuKTYrEN
         ZdYWhz7EI1T16gTKNtJ/I5hTMsMWK8PYAkhdnkWIN2fWOxDj63DCpCu0qu5HGb7eLcyb
         GXeQ==
X-Gm-Message-State: AOJu0YziWPfrbTMfbSINnQ1z5VOYe5mK1SVJugS563GhzxbOW7jnNcUB
	XTjRlKxdzttfKqtuwAeQ/q8opUeJltD7v1mi8bdMxTXP/rzAX9DJoCK0xuyqscLz/1SjHpb3lyA
	xyQ3pyxhd6A==
X-Gm-Gg: ASbGncusVu3gk3mF6jINkewqzCrzlpcTBZXxnltb3xeqhmBrWPsPD8ddbcJxqYZn2at
	TZMu/5aGtBOu4hNoDq15o6EgDa2xYxvbnAz4sM/7Z7/zqtsjN2jIvm141pxELl4gBashS2xbeaA
	mku4JQAxWBHc0NFKTawH8ZItsodpmvJoWrm81bfm75cNo76O/dPagjAE+7FkksrxJQlCqVADWEy
	/IlOikJkVlN1zFywlK2SOnDjmqjH5Y0RXnnQFSxuRX/L3XfIBJSsOyfmGtYfre1qFr9JSLSyg2q
	C0RSTYaFM2r37yIdP7WGyuHGixY8IUlAq2AmhzigQl+RZ4eeU/2erVjaVPeGYy4OXyuqyuWCM2E
	X0XnqmZNAxk2/3n098e376fKji/bX91Xt
X-Google-Smtp-Source: AGHT+IE01vH1dOq4gN0RxZiU2IARw6GpSu64vihveNRXf2jRo5uHOkH57XR3v8v0OkH3XlAZ1ejViQ==
X-Received: by 2002:a17:902:e84f:b0:26a:589b:cf11 with SMTP id d9443c01a7336-27cc678387amr68942965ad.43.1758685269114;
        Tue, 23 Sep 2025 20:41:09 -0700 (PDT)
Received: from localhost ([106.38.226.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df76dsm172166575ad.74.2025.09.23.20.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 20:41:08 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	yangyicong@hisilicon.com,
	will@kernel.org,
	dianders@chromium.org,
	mingo@kernel.org,
	lihuafei1@huawei.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	peterz@infradead.org
Subject: [PATCH v2 1/2] hung_task: Introduce touch_hung_task_detector().
Date: Wed, 24 Sep 2025 11:40:59 +0800
Message-Id: <20250924034100.3701520-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924034100.3701520-1-sunjunchao@bytedance.com>
References: <20250924034100.3701520-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kernel, long waits can trigger hung task warnings. However, some
warnings are undesirable and unnecessary - for example, a hung task
warning triggered when a background kworker waits for writeback
completion during resource cleanup(like the context of
mem_cgroup_css_free()). This kworker does not affect any user behavior
and there is no erroneous behavior at the kernel code level, yet it
triggers an annoying hung task warning.

To eliminate such warnings, this patch introduces
touch_hung_task_detector() to allow some tasks ignored by hung task
detector.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Lance Yang <lance.yang@linux.dev>
---
 include/linux/nmi.h |  2 ++
 kernel/hung_task.c  | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index cf3c6ab408aa..61fc2ad234de 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -59,8 +59,10 @@ static inline void touch_all_softlockup_watchdogs(void) { }
 
 #ifdef CONFIG_DETECT_HUNG_TASK
 void reset_hung_task_detector(void);
+void touch_hung_task_detector(struct task_struct *t);
 #else
 static inline void reset_hung_task_detector(void) { }
+static inline void touch_hung_task_detector(struct task_struct *t) { }
 #endif
 
 /*
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a1205f82..6409d3d4bd36 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -184,6 +184,11 @@ static inline void debug_show_blocker(struct task_struct *task)
 }
 #endif
 
+void touch_hung_task_detector(struct task_struct *t)
+{
+	t->last_switch_count = ULONG_MAX;
+}
+
 static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
 	unsigned long switch_count = t->nvcsw + t->nivcsw;
@@ -203,6 +208,10 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	if (unlikely(!switch_count))
 		return;
 
+	/* The task doesn't want to trigger the hung task warning. */
+	if (unlikely(t->last_switch_count == ULONG_MAX))
+		return;
+
 	if (switch_count != t->last_switch_count) {
 		t->last_switch_count = switch_count;
 		t->last_switch_time = jiffies;
@@ -317,6 +326,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 		    !(state & TASK_WAKEKILL) &&
 		    !(state & TASK_NOLOAD))
 			check_hung_task(t, timeout);
+		else if (unlikely(t->last_switch_count == ULONG_MAX)) {
+			t->last_switch_count = t->nvcsw + t->nivcsw;
+			t->last_switch_time = jiffies;
+		}
 	}
  unlock:
 	rcu_read_unlock();
-- 
2.39.5


