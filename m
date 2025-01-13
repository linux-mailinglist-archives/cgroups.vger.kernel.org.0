Return-Path: <cgroups+bounces-6114-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B612A0C11A
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 20:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B512168267
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 19:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E3F1C5F09;
	Mon, 13 Jan 2025 19:14:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5AF240243;
	Mon, 13 Jan 2025 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795653; cv=none; b=QODG0Lap4YC+kbp23IfS2fT0f5E6zoAnPShNPTChm7eMB7OSfcim998nmfW9giqP2rHmCGKzmvT3krrFYQpMBY9zPGvhITE3jmtZFTvroau85oSBIQXKVWkcraWvOEpuD0GHEpvHh7nkxAFQAYtm0qgPEnlIHJ8zs2yAjVoEseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795653; c=relaxed/simple;
	bh=EeP8z+31Ts2w6J9OfdHQfHkGQIDTQXw84L3YTnLkF1A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VSjdCft5esyhW9WyB+LOku3CYmelYQzMMrn1cmVtdbN2wuft3h5kbo0fupCJfxW+UFqkFY6WKVoSCSpklxMy+BpbY/+xOHPzP9SgrtwwA6Dm+HXvK+UjEnjV58KSa+8uwbzRWjyRJHfFH+crshg1HYscsmQxX7HbvIOclIqllws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436a03197b2so33011835e9.2;
        Mon, 13 Jan 2025 11:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736795650; x=1737400450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9Ktglav0EtH/ZrWl5Mr00RlGYkkP4qtBVylv6DuiFY=;
        b=Hs2AU0KQwnVz+X4/k8/dAGbVfgR/19Zf4SdW/KVjukl+E7I9m1yx1Jc6Ekck2OrD9b
         bJSFX2fMjct/LHHDBWHFkVSXOn2AQ5Hn9s7m4/GRUBS+27teqflN5krvKvMYGEB78zW/
         Vwq3F1oqkq33pP+pzaqw9KOzMRM15m9z9BslAxyLJi4iwV5mtIRx+hVJmVoYEuLcjLPC
         qFazETsTHRDLfEy5RVWqMtWS5fIvmjhjbGZhtEM1Um28pXDV/iLCKkOz0DfGTiKIMDWm
         1/WOly9HJ9ak214KkUXO7CDOXAgMc0ibr7mDTAd8icI8N74NJMEGuZMa6PbEQUAJzkI4
         v0tA==
X-Forwarded-Encrypted: i=1; AJvYcCWEP+cZqHBAV1xFAtuQkfLVXHyOWVw0O9eGr/E0190JGoxm+lrIS/OgxXAaPLDYLtBkaJjNWs77@vger.kernel.org, AJvYcCWP2M6S7KS8BNZ9OzbOnDhSsNx/oDG1WOULPgqSuhFuQXNs1mg7GEvgWWzlESnEJEK6/qtToHFV6LAfcn/k@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYMGA3IV521IeOiZu6c1lxGS6oLyWD60OdKUG+/kBSc08MWzI
	3gk2mK1/jNQ6HW9OTKN7lAuu47honE6hqMZuS5Q8WgWOmUwZcu9E
X-Gm-Gg: ASbGncv5BBLZVh2I2u7qEdWVk/6gaBAucd+XdWaKBesZjD1wo0QqqI3kR7xHgSPgjeH
	HD18crCNIadb7zZ3nRVYKvBYPOuWIH9k14Hma87bjBBXdHaV3Jr0S45tKJfkC85yr/9g9o8Ylje
	ngml2mg0VzDB58kmHMGHtWItMt2+GsM+tXdrFaO7PgNwMP2iL3CGjVnvigl2A0/LEgWHM9X0WRi
	cDGWipjmpaQs93MzRPhNv55f/woK03Je9HP/H2ZAvtLjNClFRdLw/xi7wz4+ElWres9J7UDzw==
X-Google-Smtp-Source: AGHT+IFaBW7ek/4eG5FiaC4wAhE53woXMym/Ae9m2poDT62mhSHOjQ0IOVZkOFo5D3ysUiLGJNRBMA==
X-Received: by 2002:a05:600c:3ca0:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-436e26f01aamr170539065e9.21.1736795649368;
        Mon, 13 Jan 2025 11:14:09 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0069sm188492025e9.11.2025.01.13.11.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:14:09 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Yu <yu.c.chen@intel.com>,
	Kees Cook <kees@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v1] Add kthreads_update_affinity()
Date: Mon, 13 Jan 2025 21:08:54 +0200
Message-ID: <20250113190911.800623-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changing and using housekeeping and isolated CPUs requires reboot.

The goal is to change CPU isolation dynamically without reboot.

This patch is based on the parent patch
cgroup/cpuset: Exclude isolated CPUs from housekeeping CPU masks
https://lore.kernel.org/lkml/20240821142312.236970-3-longman@redhat.com/
Its purpose is to update isolation cpumasks.

However, some subsystems may use outdated housekeeping CPU masks. To
prevent the use of these isolated CPUs, it is essential to explicitly
propagate updates to the housekeeping masks across all subsystems that
depend on them.

This patch is not intended to be merged and disrupt the kernel.
It is still a proof-of-concept for research purposes.

The questions are:
- Is this the right direction, or should I explore an alternative approach?
- What factors need to be considered?
- Any suggestions or advice?
- Have similar attempts been made before?

Update the affinity of kthreadd and trigger the recalculation of kthread
affinities using kthreads_online_cpu().

The argument passed to kthreads_online_cpu() is irrelevant, as the
function reassigns affinities of kthreads based on their
preferred_affinity and the updated housekeeping_cpumask(HK_TYPE_KTHREAD).

Currently only RCU uses kthread_affine_preferred().

I dare to try calling kthread_affine_preferred() from kthread_run() to
set preferred_affinity as cpu_possible_mask for kthreads without a
specific affinity, enabling their management through
kthreads_online_cpu().

Any objections?

For details about kthreads affinity patterns please see:
https://lore.kernel.org/lkml/20241211154035.75565-16-frederic@kernel.org/

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 include/linux/kthread.h | 5 ++++-
 kernel/cgroup/cpuset.c  | 1 +
 kernel/kthread.c        | 6 ++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 8d27403888ce9..b43c5aeb2cfd7 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -52,8 +52,10 @@ bool kthread_is_per_cpu(struct task_struct *k);
 ({									   \
 	struct task_struct *__k						   \
 		= kthread_create(threadfn, data, namefmt, ## __VA_ARGS__); \
-	if (!IS_ERR(__k))						   \
+	if (!IS_ERR(__k)) {						   \
+		kthread_affine_preferred(__k, cpu_possible_mask);	   \
 		wake_up_process(__k);					   \
+	}								   \
 	__k;								   \
 })
 
@@ -270,4 +272,5 @@ struct cgroup_subsys_state *kthread_blkcg(void);
 #else
 static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
 #endif
+void kthreads_update_affinity(void);
 #endif /* _LINUX_KTHREAD_H */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 65658a5c2ac81..7d71acc7f46b6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1355,6 +1355,7 @@ static void update_isolation_cpumasks(bool isolcpus_updated)
 	trl();
 	ret = housekeeping_exlude_isolcpus(isolated_cpus, HOUSEKEEPING_FLAGS);
 	WARN_ON_ONCE((ret < 0) && (ret != -EOPNOTSUPP));
+	kthreads_update_affinity();
 }
 
 /**
diff --git a/kernel/kthread.c b/kernel/kthread.c
index c4574c2d37e0d..2488cdf8aec17 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1763,3 +1763,9 @@ struct cgroup_subsys_state *kthread_blkcg(void)
 	return NULL;
 }
 #endif
+
+void kthreads_update_affinity(void)
+{
+	set_cpus_allowed_ptr(kthreadd_task, housekeeping_cpumask(HK_TYPE_KTHREAD));
+	kthreads_online_cpu(-1);
+}
-- 
2.47.0


