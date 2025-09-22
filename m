Return-Path: <cgroups+bounces-10331-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75179B8FCE7
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 11:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEFD2A004B
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 09:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794302F619B;
	Mon, 22 Sep 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a6MuXr9y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172427EC80
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534124; cv=none; b=LzKup35uCvAD+hEScmEteAaQKtx87t65pikfLfmf0Oi7scj1N7wPlJhWC6vhhsH8rHNiaxE1RUaatnygGNel9Y5iqhJLw9M1yW5E1BPm1VUw4BksXh1lcA+pQkZSTY4SYaYucxPzaRtWFdx1DyATjjcAQ6ZtITtfjZ61x5Nd4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534124; c=relaxed/simple;
	bh=w2CQvHkt4M2gPEgsJ1Jr/TEVOrRgfKToXeIBZjuqn4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J5CXl9W+dgPHf71RPrrBdK+mR5njYuOykuNJcH1A5jmhkeEkO9CCG1d1ZQrxthxoY2EaQjV9MqCcxHi4YW4l+lz+DwYqIDtoH3RQMVvLed3FAIaPQQt5E7On9cx3c/01DXHu4PcsbZ/6liE1JurZxv/IDClIn233J9wI+Iohj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a6MuXr9y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-278bfae33beso6599155ad.0
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758534122; x=1759138922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOurKnsAQJhq1MI/K3lsAX/7s+mLOF8dCVHDunK7rpk=;
        b=a6MuXr9ymnM1X9xenimqx6UCDnN7iJ0GDjJJaHa/S1t3Qde5Ch8jGLWhUjlqyUhOhQ
         eerJxUMerpruFgqB1JI7B2pGqCPOnlPMd77gsMe9jKEx154XpiVr7z6u73rrlHdAShbP
         aCHMPyTFHyYiqR2Wm8SyIAlLMw8oo3wLfTYmBdCKnJ6xzaNxXJq0cTgshrJI01+/46CY
         8Od4hfqX3j9FwTLVccGQt/6Wm34dGasjENc0P8yc11C8lX0v/VqYSRg7IOY9dC4lQodg
         iXYPFjHz5ub+2ZblMo9J8W9wQSZFYKtrVjRvRqNWMigcwAxpMh5r56N1V5d2h0PLTP0d
         KhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534122; x=1759138922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOurKnsAQJhq1MI/K3lsAX/7s+mLOF8dCVHDunK7rpk=;
        b=Su02WQbDc/19VKCpyvwN8LTBxmA6fT/jjyc74L3FAItg0VjK/KYVoj351Z9fB3u/sS
         NA7qmIA9cn+nukLsGMELIipeN2LWT1ZZUy/pNFHL0RV3G19cpjSGaQzIkkE6n0jk6tM9
         m07QrlOmZ7iWw8z/Yzo+ImxpxKp2zjODubW80iMgll1RyTm2abZBkladOwxZKJaN/OJp
         attyO/+E0cNeHu2++oh+WdH/a0rgoPsA9hokDEvZnBf87nhhsCkJ6c5WwXUwXMTBv8/c
         JjNiui8XWupwIUhaBib2cddGmYh37lnH3JVTeCiu8e/j5aFI39g65kiRqPVTDZxD1RB9
         zfxA==
X-Gm-Message-State: AOJu0YwfEdQhU4MGmbCYhi/Tom7Z/+Vab8qDg/rAI7X5Tw+fe0IGRooH
	D8rkCpSFVRz2DjnSQIaLUfwFXrU+KAf444pjcBTgun/vR18SV+3SrlSoluaNGu4vRGxvgQdMDZu
	MYO8Ki+w=
X-Gm-Gg: ASbGnct7NF5FnGC1/lw2aKbugAi7WRImx07MSQOCtq8V5cKUbj4mbpgFdjCicQM28co
	pFX9Y3C5x++hZnVLEYGAAUtEcnriNoreYPB9i9HfKjpsiF8fFpbU8mc54tKneXW1H3Q1/ieTDfG
	wkc2WeQDbUxYznyrTZ9tcVd4JYym0lgrJl5zTRcEHUehozaote3EENpJ04L+2OtiXgnDyxxuDMp
	7Li2ZpDJFXsVnCIqalqe8tmUBzH+/QPC1io7gM6S92cqkkEKv17/H9CD9vn/HlzQJmgY4UFkilD
	wEy0tqI0w7v+1lStZkWjzqUEweHAqX54m/2LBsmWQ3QDP/41ak9cGyzh2j/kEdHvpOwb1uajbGc
	UX00G4GSJLbhayTL+pAgGQe5gIEhf8qpoEQdv2g==
X-Google-Smtp-Source: AGHT+IEYZ/C3dL0qp2wE+58Yl2Bn+i2OwzxTRskr6Hw/lJro+/C/gVzHqm7+saAW2gcX3d53cPh8Dg==
X-Received: by 2002:a17:903:1b68:b0:266:88ae:be6d with SMTP id d9443c01a7336-269ba3c255emr167678175ad.6.1758534121484;
        Mon, 22 Sep 2025 02:42:01 -0700 (PDT)
Received: from localhost ([106.38.226.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c098sm123997705ad.33.2025.09.22.02.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:42:01 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	agruenba@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev
Subject: [PATCH 2/3] writeback: Introduce wb_wait_for_completion_no_hung().
Date: Mon, 22 Sep 2025 17:41:45 +0800
Message-Id: <20250922094146.708272-3-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922094146.708272-1-sunjunchao@bytedance.com>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces wait_event_no_hung() and
wb_wait_for_completion_no_hung() to make hung task detector
ignore the current task if it waits for a long time.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/fs-writeback.c           | 15 +++++++++++++++
 include/linux/backing-dev.h |  1 +
 include/linux/wait.h        | 15 +++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..eebb7f145734 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -216,6 +216,21 @@ void wb_wait_for_completion(struct wb_completion *done)
 	wait_event(*done->waitq, !atomic_read(&done->cnt));
 }
 
+/*
+ * Same as wb_wait_for_completion() but hung task warning will not be
+ * triggered if it wait for a long time. Use this function with caution
+ * unless you are sure that the hung task is undesirable.
+ * When is this undesirable? From the kernel code perspective, there is
+ * no misbehavior and it has no impact on user behavior. For example, a
+ * *background* kthread/kworker used to clean resources while waiting a
+ * long time for writeback to finish.
+ */
+ void wb_wait_for_completion_no_hung(struct wb_completion *done)
+ {
+	atomic_dec(&done->cnt);		/* put down the initial count */
+	wait_event_no_hung(*done->waitq, !atomic_read(&done->cnt));
+ }
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 /*
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index e721148c95d0..9d3335866f6f 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -40,6 +40,7 @@ void wb_start_background_writeback(struct bdi_writeback *wb);
 void wb_workfn(struct work_struct *work);
 
 void wb_wait_for_completion(struct wb_completion *done);
+void wb_wait_for_completion_no_hung(struct wb_completion *done);
 
 extern spinlock_t bdi_lock;
 extern struct list_head bdi_list;
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 09855d819418..8f05d0bb8db7 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -330,6 +330,21 @@ __out:	__ret;									\
 	(void)___wait_event(wq_head, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
 			    schedule())
 
+#define __wait_event_no_hung(wq_head, condition)					\
+	(void)___wait_event(wq_head, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
+			    current_set_flags(PF_DONT_HUNG);	\
+			    schedule();						\
+			    current_clear_flags(PF_DONT_HUNG))
+
+#define wait_event_no_hung(wq_head, condition)						\
+do {										\
+	might_sleep();								\
+	if (condition)								\
+		break;								\
+	__wait_event_no_hung(wq_head, condition);					\
+} while (0)
+
+
 /**
  * wait_event - sleep until a condition gets true
  * @wq_head: the waitqueue to wait on
-- 
2.39.5


