Return-Path: <cgroups+bounces-10147-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4462EB58D67
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 06:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE364188CB1C
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 04:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A319E2E9EDD;
	Tue, 16 Sep 2025 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoJa0Qc3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EED2E9EDF
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998156; cv=none; b=uo+BT48v+Y0VX9eySa/Zd180mPDQJ7D7jYEk55WkkeA0PRJJT3c73N5VtmcioH4oKnHytGJZ11Dje/eJvAzHEf8w82MsL0hIn5w5y3a3D88tuZn+obNpwGaVeYtNTx86zGZ6c+iOg7xJ6rzX/zg3S8oyMjuiCxEAhzJfhP8p7P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998156; c=relaxed/simple;
	bh=7sG+E8vq4OG/BfLJfXnS6N7EfrLQmjqnuIf5XUjAWWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6YafJFMutxg26eKE6E+pZWrHBXoxDhzUkm/qhOGtndeUGds3wtiJBsCjeD/m1poUkf8HYTx2GBsb+/El3UQQvQzzH6RCeLGDbGfyuBu4SJANTq29bEM+PpwyTy8KuWm8dAJ+bK8Z6tG8zVACFyOX7CYjrVILSTRqharHYMnwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoJa0Qc3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso3218872a12.2
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 21:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998154; x=1758602954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNMpbtPTFBPk6JIOba7CD2qKlqPbw337arz8FniHJF8=;
        b=KoJa0Qc3lt8G1CQ5AbwOj3qvb9bu5qliDuEc4sfIPbr1BRCVYR3Bx/XN92R2rWqFFv
         nHGpulI2lx/uODqzl/0u0h/6Rd9sByZfpl3GezXb8FqkGEAdnsFhVtRYZkSK5GIUv0/U
         88Lv5WhrrzMFy50Fxe3cVARMTRYHZ/bppdUMJGJiCZEz6603dKLXzj7HX0yNRqQMWyyo
         JfK/UKwhrbZ4VNufXLGhr1uiC09OVkI4kemP0MSwbP+Qk2WkAhoNM2BA+QwLdUISw40+
         6iGnCmDltYbiDd7B2YnOenE3yDZDTJGhVOPaXTN2KCrPIOiSFy+O9HlA808tUeXmw29z
         3WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998154; x=1758602954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNMpbtPTFBPk6JIOba7CD2qKlqPbw337arz8FniHJF8=;
        b=sw4eK+E+3gvBzlLDeURBPer/5XOc5xWVAagTJiyApN3V/bZWHQstmzfJZogqaoHel9
         1Zd62RMpICksHpAe6ORJFAkFJFJoMEgF76ip3G62gsVrjvAp6s6mxyTeyClYMYhboZVb
         kR2v5j7GxaBNecjTmPjshJph9t7hKv47PZUEEnIvge3z2hrcqZyW2lMowEny5lFx+gr2
         5qqOpqJ7z2iqJMmq49NFzIFWdOcuZrouz10bkwnQdvUDfWUCYpZtv7Uj/PSrjf75N0kE
         ODmRdJwkmUZppfoP5cvFRATzoDBPSdFJ9Kkz+XSUJYReIz6u+xugRNjG1sPTg3B09r9t
         fGcA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Q89qcDIrn2v6+BFLm/CdvOMnnJR4NTFYnIN7q9Ev1HEsFq6dNdbgXXXX7Jj1kFMehdxowN/D@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2HQkV4twkldZ8q+qMU1bb4fv+uvmWGp4Lmgl7EZhuIe40D1r
	S4X08orSz2uObK05TEvSChPXyDLe0b7QsKeRhtvZrG4c0btj2LSgUyEz
X-Gm-Gg: ASbGncvhM+s2LxgN3QW3FIExTk0D9JCiXS85o7gxOtGIlqgGOsezSkLBQYOB1LOLJgw
	7oOxRZ1fRyzdu6DCeQ8HizSqbHAIrFrf13iW6uD9Q5mMKc6CKAIgPmN7SUq23T78bL9TEjcIKc7
	j112bVsCfy6IjW/wqJZEx0UG4WJ1TrHnJbV7R6zQOlOTfE3lAqBN02dT+5WKVnBVCu2YrKJmzzi
	j4Mhk4uSKmoCU/vjMpxGskY9c/MbRSfMRXfGcjcuy+WVlnFYxEfgOjNtaqT0Ux3FOkLL671GUCY
	U9E2ySSn4XV8fGaPc1ueyYxoCFOaPTmOUQotklPUm9GJ5ZfwzG0i1qg9u84P5+6Gh8Cl3G3aJMW
	B13ATmfu3Jc2wb9Ft3J+qV3fXOv3k7WcfrrnBR8k=
X-Google-Smtp-Source: AGHT+IESqtMzjXYDIyoiu7v1JuOroH/dzFervHo7F64ECeuOEjCMVsn8AAVx3YpgubRO047K2xnTHQ==
X-Received: by 2002:a17:903:3c2c:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25d26663dcamr182035635ad.29.1757998153712;
        Mon, 15 Sep 2025 21:49:13 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:13 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 09/14] cgroup/cpuset: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:30 +0800
Message-Id: <20250916044735.2316171-10-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 kernel/cgroup/cpuset.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27adb04df675..9b7e8e8e9411 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4073,7 +4073,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	struct cpuset *cs;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	rcu_read_lock();
 
 	cs = task_cs(tsk);
 	if (cs != &top_cpuset)
@@ -4095,7 +4094,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 			cpumask_copy(pmask, possible_mask);
 	}
 
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
@@ -4168,9 +4166,7 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	rcu_read_lock();
 	guarantee_online_mems(task_cs(tsk), &mask);
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&callback_lock, flags);
 
 	return mask;
@@ -4265,10 +4261,8 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
 	spin_lock_irqsave(&callback_lock, flags);
 
-	rcu_read_lock();
 	cs = nearest_hardwall_ancestor(task_cs(current));
 	allowed = node_isset(node, cs->mems_allowed);
-	rcu_read_unlock();
 
 	spin_unlock_irqrestore(&callback_lock, flags);
 	return allowed;
-- 
2.34.1


