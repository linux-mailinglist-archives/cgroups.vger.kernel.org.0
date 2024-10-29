Return-Path: <cgroups+bounces-5310-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE79B491E
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 13:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F286B1F241C1
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 12:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB85205AD9;
	Tue, 29 Oct 2024 12:08:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB5204F86;
	Tue, 29 Oct 2024 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203701; cv=none; b=lANNsTg2TygYg21YyH5U1w5JH0tirwH4n/q/ZF64gz/FB1vYGZa23R8ZTHe3h4VSAxZEqPXvWJEcdnzVh37UsU9rWbNCBGSIH16E5klLkAMHq7nfrZalX7fHxjCbwT8wZroBWMV8jNVFnmKsHExoUpM/p9phZDXZpEe13UpWEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203701; c=relaxed/simple;
	bh=yhVG5qNlNEhyRuC366cKshL752zvtXuaIHp+GLquotc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADWTo5aVNmr3q54IZpLdrhHBi8sz/L2DZKKUBFBqEXjAkjCRMoOgcvcUi9c4t81GtBqCNJa/nW3OUeHTrmT/OCxkDRC6W3s/j+r6mLw5Tp7in4xwiOxvKgMhuNvcZWQi9xZGnpInFvDvTBeOYpMjDTFcoM6tL6WZK9WhICiD64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d5aedd177so3592922f8f.1;
        Tue, 29 Oct 2024 05:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730203697; x=1730808497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prK/FNQOXsCO8+FRi41kJ4Qt9n8SlNOaBxb4/L845wI=;
        b=OTlM5ffaqSdBiL4GnYrS1ZDUMcgLDoCs+Q+7NPgMdK4zrvBeQVlhs699bzccvBVUht
         5Qiod+zn7aQsJRNKXA9nrWTvyaVq++XgBliDHFKXAIFIQSydECzxFpxYJndZo8ZEmrK6
         YVtenZtTcL6u06cGounxnG+RWFdk9tFfg+BlMr7ZLZ1ZLcX9Ca6Oc8gG1+KLf+IpFYLw
         zr6jxYhTAdcRCGLyX4prV40CtNdGAghTa+qeF7g5+XNhIZr/gYyPMFUAZ4WQyI8Fqj4r
         BzXBnRw9Ma30Uy76BiZkEtM8qWe11ZbJD7YDdox2yn6yT2QtV+xuxl3TrqyhKmHMlk/Q
         Pk3g==
X-Forwarded-Encrypted: i=1; AJvYcCVUnZu0nGnjuVJmHnXXF0e/OLu7+N5T+ZbPmp3dwp1HiJhbwO57/0iIx+Wv5abmpHAmqW/nx4CdT2f0R0I=@vger.kernel.org, AJvYcCXiqMzOJ54vL+TKT61/dVvCKbJtF9oKXF38b2CClp+nYFl3S05eJX2N+DBlTzh1rXlkRqNOeEgE@vger.kernel.org, AJvYcCXjWTWLvSFJ9fAjjPt00SctFZAwKlcCE2H2raB6v5t25IrjLsfyFbfxmfHyuIiC95V9HikxSGpjji7ouGlC@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwjeKjpQ2Vc+zWHS0Tl8mokVn4i9FHWISPBjxVcgmElErprg9
	ON/GDjWG1SGshKVrKRZxafotlkGgJl/8EOBDqRcVDcor8aAOJ6lH
X-Google-Smtp-Source: AGHT+IHwsoGWZEaN44ytc/ZUqOt4oJ7DIzAf8N/MgcTN2KjnWFB44hdq8RqxlB0iW0UmlwsMQdM6mg==
X-Received: by 2002:a5d:5549:0:b0:37d:5282:1339 with SMTP id ffacd0b85a97d-38061138083mr8364744f8f.22.1730203697294;
        Tue, 29 Oct 2024 05:08:17 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b13309sm12362152f8f.3.2024.10.29.05.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 05:08:16 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v3 1/3] sched/isolation: Add infrastructure for dynamic CPU isolation
Date: Tue, 29 Oct 2024 14:05:32 +0200
Message-ID: <20241029120534.3983734-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029120534.3983734-1-costa.shul@redhat.com>
References: <20241029120534.3983734-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the infrastructure function housekeeping_update()
to modify housekeeping_cpumask at runtime and update the
configurations of dependent subsystems accordingly in
following patches.

Parent patch:
sched/isolation: Exclude dynamically isolated CPUs from housekeeping masks
https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com/

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Note: In theory, updating housekeeping.flags only once is possible.
However, this approach would make this and following code less clear
and harder to follow and review.

Changes in v3:
- Remove redundant WRITE_ONCE. The first WRITE_ONCE is located
in housekeeping_update() because this function will
update dependent subsystems with changes of the housekeeping masks.

Changes in v2:
- remove unnecessary `err` variable
- add for_each_clear_bit... to clear isolated CPUs
- Address Gleixner's comments:
- use WRITE_ONCE to change housekeeping.flags
- use `struct cpumask *update` in signature of housekeeping_update

v1:
- https://lore.kernel.org/lkml/20240516190437.3545310-2-costa.shul@redhat.com/
---
 kernel/sched/isolation.c | 43 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 2ee47bc25aea..ebbb215505e8 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -127,6 +127,40 @@ static void __init housekeeping_setup_type(enum hk_type type,
 		     housekeeping_staging);
 }
 
+/*
+ * housekeeping_update - change housekeeping.cpumasks[type] and propagate the
+ * change.
+ */
+static int housekeeping_update(enum hk_type type, const struct cpumask *update)
+{
+	struct {
+		struct cpumask changed;
+		struct cpumask enable;
+		struct cpumask disable;
+	} *masks;
+
+	masks = kmalloc(sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		return -ENOMEM;
+
+	lockdep_assert_cpus_held();
+	cpumask_xor(&masks->changed, housekeeping_cpumask(type), update);
+	cpumask_and(&masks->enable, &masks->changed, update);
+	cpumask_andnot(&masks->disable, &masks->changed, update);
+	cpumask_copy(housekeeping.cpumasks[type], update);
+	WRITE_ONCE(housekeeping.flags, housekeeping.flags | BIT(type));
+	if (!static_branch_unlikely(&housekeeping_overridden))
+		static_key_enable_cpuslocked(&housekeeping_overridden.key);
+
+	/* Add here code to update dependent subsystems with
+	 * changes of the housekeeping masks.
+	 */
+
+	kfree(masks);
+
+	return 0;
+}
+
 static int __init housekeeping_setup(char *str, unsigned long flags)
 {
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
@@ -330,10 +364,12 @@ int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus, unsigned long f
 		/*
 		 * Reset housekeeping to bootup default
 		 */
+
+		for_each_clear_bit(type, &boot_hk_flags, HK_TYPE_MAX)
+			housekeeping_update(type, cpu_possible_mask);
 		for_each_set_bit(type, &boot_hk_flags, HK_TYPE_MAX)
-			cpumask_copy(housekeeping.cpumasks[type], boot_hk_cpumask);
+			housekeeping_update(type, boot_hk_cpumask);
 
-		WRITE_ONCE(housekeeping.flags, boot_hk_flags);
 		if (!boot_hk_flags && static_key_enabled(&housekeeping_overridden))
 			static_key_disable_cpuslocked(&housekeeping_overridden.key);
 		return 0;
@@ -358,9 +394,8 @@ int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus, unsigned long f
 		cpumask_andnot(tmp_mask, src_mask, isolcpus);
 		if (!cpumask_intersects(tmp_mask, cpu_online_mask))
 			return -EINVAL;	/* Invalid isolated CPUs */
-		cpumask_copy(housekeeping.cpumasks[type], tmp_mask);
+		housekeeping_update(type, tmp_mask);
 	}
-	WRITE_ONCE(housekeeping.flags, boot_hk_flags | flags);
 	excluded = true;
 	if (!static_key_enabled(&housekeeping_overridden))
 		static_key_enable_cpuslocked(&housekeeping_overridden.key);
-- 
2.47.0


