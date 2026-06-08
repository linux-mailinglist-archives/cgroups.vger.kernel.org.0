Return-Path: <cgroups+bounces-16720-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lyKFG7SzJmrbbQIAu9opvQ
	(envelope-from <cgroups+bounces-16720-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:21:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 080E665617F
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:21:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LeNc0ZWT;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16720-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16720-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E88E30407FD
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8637C0F7;
	Mon,  8 Jun 2026 12:16:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3E3803F9
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920970; cv=none; b=fhBhrsPu2SN2chuQeuuaMiVV3bX2avabEa4/RHpaY+DWqyF/20SJwp7dmTX/fdTS6RzGkaNct2ZPhq6qbw8c8+EgXeZbaCL7k1GyfCTeU0jNwhBIuyCRwXjosQ1fMRVvqvfkYv/JmeYo340JJnj4mxCb6FzfXZ62eLgzkHG6+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920970; c=relaxed/simple;
	bh=x+kQMSJL0HaKNgdoHL5nXTs5650NkXHU/v/ZcKQFyWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ55558CfW4cvQf+EWu0hwkLB3U04kZtMzvFJ+tZgu2EBAIITWpkh3db6OXsRs1BR4JxPhwhZa9Gl/H31jPZrWyqftHTHd2P9JtbF15N+bM7jCN2VV2lrhAZSZYPaDcWFDL0hyFehl46zIeshBWLKug20XRRpDH+5iv196a6EY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeNc0ZWT; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef29c5561so2178892f8f.0
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920964; x=1781525764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zu6ynVRY/qI7FjTBOrlhoMJpQptnT/GTnRCT/yRZp9g=;
        b=LeNc0ZWTCoCJUdXWFq3yaaluHbrRsri5KVfWHV0W2jtXZsjQrgx4fDaHJhYRs9nVuL
         xPi10nyU4VkrDu8ISKGHIPrS40kg3g5k9Z98MBPpt4ZYwuPinXVqcDYhSqgI/HaL+pdQ
         Y//R+w0XvpcIF+ShdOXVBCergyhVA0txhlieJIbhU7sy1haaULzKIZMLAYQg5zE0FRGA
         udJR1zImr+1tHuRugY+OTKTH/cTArS4fRcmt2RVrxGmqys3Q5j6rTN3SgHU41U9hzIfT
         7B6aQ9tLL8QTF5ULPq9kSo5yCngySg/BW4jPm68eDyynVlIw4oHnnqEupGBxG/UgPwo/
         CNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920964; x=1781525764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zu6ynVRY/qI7FjTBOrlhoMJpQptnT/GTnRCT/yRZp9g=;
        b=SRwAn5Taar+Z0g2nYi3n+4RbFj5capKZBQ93a/YGLQ54DXHPLDX1sMjgQS7b/+6iRM
         8rlQfckdhFK1gkfBfePCUMBFUfyeEHbaEMWLJ0GsV8A6SRyqx2ibQXm7X1YX8yQWHSfT
         dKkPabfW6t29FquhPUEeYexcj6XWDZ5YFBIh0fEawKxzmZ9ZwhJ7ZUmYoQ4EYRB2YITh
         Ud59jAAj+rbfwoDtob1IZWfwvTG7S3iUrXea2GN/rkkkEwi/jrW8QPncgOmBpUR34xoo
         eLVXIP1u8F+ZwIdMtbPtneo0bbt+q8YGS9S+aH2xGP0nsquizsEFhs7TnA+jjsRCoVIE
         5zeg==
X-Gm-Message-State: AOJu0YyrLPGegxWkhbQNNXnaIxkhimdwlUBorrtqwmPpA66QJgC66s4g
	Pcn7ILQipI/aLqk4LTAOZLGstFb0CAkWXUYKjLFp2RoBbxVx9dJArtoR
X-Gm-Gg: Acq92OEwx3fnOyDEpMQyqQ0SX611sQZ8jggByxx+iN62Vp6Ij1pRO7v2lsdiPuRVGx+
	l1N+mdNGZ7m2JX/0Xq8IPi0NXJz0hi2R/4zm/8EiOTslLuOlF/l1chyI2wIjc2+k/9cmQPb5LrI
	PEQydAIZ1MSdAafJHNJUj8KhQ66bEbpTYSYVmSgd44EX5Obci2T6g6DAB/quSB0BmGOgSvM9Qjt
	DhLk86FZpUep3aIDWPdBBNPFk3RElJTOsBizMMuXz2QCXwPQCv4K8s/wuwfh7rzPARx2pBGOJA0
	YyD7v6eaVgkn0HKM5J+DE4/BgxMxBNj290p0rp5jArGADQLodF3Fb6KJTh+u1S/2f0CCxEfHAjd
	m2yfULblaUu3qezs1F1/APSeyjRP3zCxNSozuhQZBRMx3CpedgnsdawgzzFKtkx0byZ9sdnaXl8
	ubzoZ26Jc6edkGmv6FxNQNzQQieGZyQpg=
X-Received: by 2002:adf:d02f:0:b0:460:f36:79b0 with SMTP id ffacd0b85a97d-460304fda0amr17777567f8f.19.1780920964257;
        Mon, 08 Jun 2026 05:16:04 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:03 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v6 17/25] sched/rt: Update rt-cgroup schedulability checks
Date: Mon,  8 Jun 2026 14:15:36 +0200
Message-ID: <20260608121546.69910-18-yurand2000@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608121546.69910-1-yurand2000@gmail.com>
References: <20260608121546.69910-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16720-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sssup.it:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,santannapisa.it:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 080E665617F

From: luca abeni <luca.abeni@santannapisa.it>

Introduce cgroup-v2 control files:
- cpu.rt.max:
  Get/set the bandwidth of the given cgroup, or inherith from parent.
- cpu.rt.internal:
  Get the actual remaning bandwidth for the group, removing the bw of the
  group's children.

Introduce a number of functions to update the cgroup settings across the
whole hierarchy:
- tg_subtree_has_rt_tasks()
  Checks if the active context rooted at tg is running rt workload.
    Child groups which do not share the same active context are ignored.
- tg_compute_children_bw()
  Computes the total bandwidth of the active context rooted at tg minux
  the root of the context itself.
- tg_rt_schedulable()
  Runs admission tests for the current cgroup tree and the given
  bandwidth update.
- tg_update_active_context()
  Updates the active context of a given subtree with a new one.
- tg_rt_bandwidth() / tg_rt_internal_bandwidth()
  Read the max (internal) bandwidth set to the cgroup.
- tg_set_rt_bandwidth()
  Set the bandwidth of the group.

Update sched_rt_can_attach to run only tasks in the root cgroup or HCBS
cgroups which have non-zero runtime.

Update and reuse __checkparam_dl to check for numerical issues regarding
the dl_server's parameters.

Add from_ratio function to convert from period and bw to runtime, inverse
of the to_ratio function.

Add dl_check_tg(), which performs an admission control test similar to
__dl_overflow, but this time we are updating the cgroup's total bandwidth
rather than scheduling a new DEADLINE task or updating a non-cgroup
deadline server.

Add rcu_sched lock guard for rcu_read_{lock/unlock}_sched.
Add sched_domains lock guard for sched_domains_mutex_{lock/unlock}.
Add lock/unlock methods for sched_rt_handler_mutex and its lock guard.

Add asserts for held sched_domains_mutex and sched_rt_handler_mutex.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 include/linux/rcupdate.h |   1 +
 include/linux/sched.h    |   2 +
 kernel/sched/core.c      |  55 ++++++
 kernel/sched/deadline.c  |  60 ++++--
 kernel/sched/rt.c        | 393 +++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h     |  18 +-
 kernel/sched/syscalls.c  |   2 +-
 7 files changed, 445 insertions(+), 86 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bfa765132de8..70432ca3dbb9 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1179,6 +1179,7 @@ extern int rcu_expedited;
 extern int rcu_normal;
 
 DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
+DEFINE_LOCK_GUARD_0(rcu_sched, rcu_read_lock_sched(), rcu_read_unlock_sched())
 DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), __releases_shared(RCU))
 
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b20451fcda55..0021069581c2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2522,4 +2522,6 @@ extern void migrate_enable(void);
 
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
+DEFINE_LOCK_GUARD_0(sched_domains, sched_domains_mutex_lock(), sched_domains_mutex_unlock())
+
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a8a81c69b3d3..1ad1efe1dca7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4815,6 +4815,14 @@ u64 to_ratio(u64 period, u64 runtime)
 	return div64_u64(runtime << BW_SHIFT, period);
 }
 
+u64 from_ratio(u64 period, u64 bw)
+{
+	if (bw == BW_UNIT)
+		return RUNTIME_INF;
+
+	return (bw * period) >> BW_SHIFT;
+}
+
 /*
  * wake_up_new_task - wake up a newly created task for the first time.
  *
@@ -10415,6 +10423,41 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
 
+#ifdef CONFIG_RT_GROUP_SCHED
+static int cpu_rt_max_show(struct seq_file *sf, void *v)
+{
+	struct task_group *tg = css_tg(seq_css(sf));
+	long period_us, runtime_us;
+
+	tg_rt_bandwidth(tg, &period_us, &runtime_us);
+	cpu_period_quota_print(sf, period_us, runtime_us);
+	return 0;
+}
+
+static int cpu_rt_internal_show(struct seq_file *sf, void *v)
+{
+	struct task_group *tg = css_tg(seq_css(sf));
+	long period_us, runtime_us;
+
+	tg_rt_internal_bandwidth(tg, &period_us, &runtime_us);
+	cpu_period_quota_print(sf, period_us, runtime_us);
+	return 0;
+}
+
+static ssize_t cpu_rt_max_write(struct kernfs_open_file *of,
+			        char *buf, size_t nbytes, loff_t off)
+{
+	struct task_group *tg = css_tg(of_css(of));
+	u64 period_us, runtime_us;
+	int ret;
+
+	ret = cpu_period_quota_parse(buf, &period_us, &runtime_us);
+	if (!ret)
+		ret = tg_set_rt_bandwidth(tg, period_us, runtime_us);
+	return ret ?: nbytes;
+}
+#endif /* CONFIG_RT_GROUP_SCHED */
+
 static struct cftype cpu_files[] = {
 #ifdef CONFIG_GROUP_SCHED_WEIGHT
 	{
@@ -10450,6 +10493,18 @@ static struct cftype cpu_files[] = {
 		.write_u64 = cpu_burst_write_u64,
 	},
 #endif /* CONFIG_CFS_BANDWIDTH */
+#ifdef CONFIG_RT_GROUP_SCHED
+	{
+		.name = "rt.max",
+		.seq_show = cpu_rt_max_show,
+		.write = cpu_rt_max_write,
+	},
+	{
+		.name = "rt.internal",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_rt_internal_show,
+	},
+#endif /* CONFIG_RT_GROUP_SCHED */
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
 		.name = "uclamp.min",
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a63253ec6441..b7102f643171 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -346,10 +346,45 @@ void cancel_inactive_timer(struct sched_dl_entity *dl_se)
 	cancel_dl_timer(dl_se, &dl_se->inactive_timer);
 }
 
+/*
+ * Used for dl_bw check and update, used under sched_rt_handler()::mutex and
+ * sched_domains_mutex.
+ */
+u64 dl_cookie;
+
 #ifdef CONFIG_RT_GROUP_SCHED
+int dl_check_tg(unsigned long total)
+{
+	int which_cpu;
+	int cap;
+	struct dl_bw *dl_b;
+	u64 gen = ++dl_cookie;
+
+	lockdep_assert_held(&sched_domains_mutex);
+	lockdep_assert_held(&sched_rt_handler_mutex);
+
+	for_each_possible_cpu(which_cpu) {
+		guard(rcu_sched)();
+
+		if (!dl_bw_visited(which_cpu, gen)) {
+			cap = dl_bw_capacity(which_cpu);
+			dl_b = dl_bw_of(which_cpu);
+
+			guard(raw_spinlock_irqsave)(&dl_b->lock);
+
+			if (dl_b->bw != -1 &&
+			    cap_scale(dl_b->bw, cap) < dl_b->total_bw + cap_scale(total, cap))
+				return 0;
+		}
+
+	}
+
+	return 1;
+}
+
 void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
 {
-	struct rq *rq = container_of_const(dl_se->dl_rq, struct rq, dl);
+	struct rq *rq = rq_of_dl_se(dl_se);
 	int is_active;
 	u64 new_bw;
 
@@ -3497,12 +3532,6 @@ DEFINE_SCHED_CLASS(dl) = {
 #endif
 };
 
-/*
- * Used for dl_bw check and update, used under sched_rt_handler()::mutex and
- * sched_domains_mutex.
- */
-u64 dl_cookie;
-
 int sched_dl_global_validate(void)
 {
 	u64 runtime = global_rt_runtime();
@@ -3514,6 +3543,9 @@ int sched_dl_global_validate(void)
 	int cpu, cap, cpus, ret = 0;
 	unsigned long flags;
 
+	lockdep_assert_held(&sched_domains_mutex);
+	lockdep_assert_held(&sched_rt_handler_mutex);
+
 	/*
 	 * Here we want to check the bandwidth not being set to some
 	 * value smaller than the currently allocated bandwidth in
@@ -3566,6 +3598,9 @@ void sched_dl_do_global(void)
 	int cpu;
 	unsigned long flags;
 
+	lockdep_assert_held(&sched_domains_mutex);
+	lockdep_assert_held(&sched_rt_handler_mutex);
+
 	if (global_rt_runtime() != RUNTIME_INF)
 		new_bw = to_ratio(global_rt_period(), global_rt_runtime());
 
@@ -3711,7 +3746,7 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr, unsigned int
  * below 2^63 ns (we have to check both sched_deadline and
  * sched_period, as the latter can be zero).
  */
-bool __checkparam_dl(const struct sched_attr *attr)
+bool __checkparam_dl(const struct sched_attr *attr, bool allow_zero_runtime)
 {
 	u64 period, max, min;
 
@@ -3720,14 +3755,16 @@ bool __checkparam_dl(const struct sched_attr *attr)
 		return true;
 
 	/* deadline != 0 */
-	if (attr->sched_deadline == 0)
+	if ((!allow_zero_runtime || attr->sched_runtime != 0) &&
+	    attr->sched_deadline == 0)
 		return false;
 
 	/*
 	 * Since we truncate DL_SCALE bits, make sure we're at least
 	 * that big.
 	 */
-	if (attr->sched_runtime < (1ULL << DL_SCALE))
+	if ((!allow_zero_runtime || attr->sched_runtime != 0) &&
+	    attr->sched_runtime < (1ULL << DL_SCALE))
 		return false;
 
 	/*
@@ -3750,7 +3787,8 @@ bool __checkparam_dl(const struct sched_attr *attr)
 	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
 	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;
 
-	if (period < min || period > max)
+	if ((!allow_zero_runtime || period != 0) &&
+	    (period < min || period > max))
 		return false;
 
 	return true;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4f1e7af2e88d..a32b1f68e645 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1,4 +1,3 @@
-#pragma GCC diagnostic ignored "-Wunused-function"
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Real-Time Scheduling Class (mapped to the SCHED_FIFO and SCHED_RR
@@ -2111,9 +2110,6 @@ DEFINE_SCHED_CLASS(rt) = {
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
-/*
- * Ensure that the real time constraints are schedulable.
- */
 static inline int tg_has_rt_tasks(struct task_group *tg)
 {
 	struct task_struct *task;
@@ -2134,38 +2130,114 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
 	return ret;
 }
 
-struct rt_schedulable_data {
+static int __tg_subtree_has_rt_tasks(struct task_group *tg, void *data) {
+	struct task_group *ctx = data;
+
+	if (dl_bandwidth_read(tg)->active_context == ctx && tg_has_rt_tasks(tg))
+		return 1;
+	else
+		return 0;
+}
+
+static int tg_subtree_has_rt_tasks(struct task_group *tg) {
+	lockdep_assert(rcu_read_lock_held());
+	return walk_tg_tree_from(tg, __tg_subtree_has_rt_tasks, tg_nop,
+			         dl_bandwidth_read(tg)->active_context);
+}
+
+struct tg_update_data {
 	struct task_group *tg;
 	u64 rt_period;
 	u64 rt_runtime;
 };
 
-static int tg_rt_schedulable(struct task_group *tg, void *data)
+struct tg_compute_children_bw_data {
+	struct tg_update_data update;
+	struct task_group *active_context;
+	u64 bw_sum;
+};
+
+static int __tg_compute_children_bw(struct task_group *tg, void *data) {
+	struct tg_compute_children_bw_data *d = data;
+	const struct dl_bandwidth *dl_b = dl_bandwidth_read(tg);
+	u64 period, runtime;
+
+	/* Skip the current task group from the sum. */
+	if (tg == d->active_context)
+		return 0;
+
+	period = dl_b->dl_period;
+	runtime = dl_b->dl_runtime;
+	if (tg == d->update.tg) {
+		period = d->update.rt_period;
+		runtime = d->update.rt_runtime;
+	}
+
+	if (runtime == RUNTIME_INF ||
+	    dl_bandwidth_read(tg->parent)->active_context != d->active_context)
+		return 0;
+
+	d->bw_sum += to_ratio(period, runtime);
+	return 0;
+}
+
+static unsigned long tg_compute_children_bw(struct task_group *tg,
+					    struct tg_update_data *data)
+{
+	struct tg_compute_children_bw_data sum_data = {
+		.active_context = tg,
+		.bw_sum = 0,
+		.update = (struct tg_update_data) {
+			.tg = data->tg,
+			.rt_period  = data->rt_period,
+			.rt_runtime = data->rt_runtime,
+		}
+	};
+
+	lockdep_assert(rcu_read_lock_held());
+	walk_tg_tree_from(tg, __tg_compute_children_bw, tg_nop, &sum_data);
+	return sum_data.bw_sum;
+}
+
+struct rt_schedulable_data {
+	struct tg_update_data update;
+	u64 rt_runtime_remainder;
+};
+
+static int __tg_rt_schedulable(struct task_group *tg, void *data)
 {
 	struct rt_schedulable_data *d = data;
-	struct task_group *child;
+	const struct dl_bandwidth *dl_b;
 	u64 total, sum = 0;
 	u64 period, runtime;
 
-	period = ktime_to_ns(tg->rt_bandwidth.rt_period);
-	runtime = tg->rt_bandwidth.rt_runtime;
+	dl_b = dl_bandwidth_read(tg);
+	period = dl_b->dl_period;
+	runtime = dl_b->dl_runtime;
 
-	if (tg == d->tg) {
-		period = d->rt_period;
-		runtime = d->rt_runtime;
+	if (tg == d->update.tg) {
+		period = d->update.rt_period;
+		runtime = d->update.rt_runtime;
 	}
 
+	/*
+	 * "max" groups are always schedulable, as they defer their access
+	 * control to their first non-max parent.
+	 */
+	if (runtime == RUNTIME_INF)
+		return 0;
+
 	/*
 	 * Cannot have more runtime than the period.
 	 */
-	if (runtime > period && runtime != RUNTIME_INF)
+	if (runtime > period)
 		return -EINVAL;
 
 	/*
 	 * Ensure we don't starve existing RT tasks if runtime turns zero.
 	 */
-	if (rt_bandwidth_enabled() && !runtime &&
-	    tg->rt_bandwidth.rt_runtime && tg_has_rt_tasks(tg))
+	if (dl_bandwidth_enabled() && !runtime && tg != &root_task_group &&
+	    tg_subtree_has_rt_tasks(tg))
 		return -EBUSY;
 
 	total = to_ratio(period, runtime);
@@ -2176,58 +2248,146 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 	if (total > to_ratio(global_rt_period(), global_rt_runtime()))
 		return -EINVAL;
 
+	if (tg == &root_task_group) {
+		if (!dl_check_tg(total))
+			return -EBUSY;
+	}
+
 	/*
-	 * The sum of our children's runtime should not exceed our own.
+	 * The sum of our children's runtime, plus our own bw, should not
+	 * exceed our own max.
 	 */
-	list_for_each_entry_rcu(child, &tg->children, siblings) {
-		period = ktime_to_ns(child->rt_bandwidth.rt_period);
-		runtime = child->rt_bandwidth.rt_runtime;
+	sum = tg_compute_children_bw(tg, &d->update);
+	if (sum > total)
+		return -EINVAL;
 
-		if (child == d->tg) {
-			period = d->rt_period;
-			runtime = d->rt_runtime;
-		}
+	/*
+	 * Compute remaining runtime
+	 */
+	if (tg == d->update.tg)
+		d->rt_runtime_remainder = from_ratio(period, total - sum);
+
+	return 0;
+}
 
-		sum += to_ratio(period, runtime);
+static int tg_rt_schedulable(struct tg_update_data *data, u64 *remainder_runtime)
+{
+	int err;
+	struct rt_schedulable_data d = {
+		.update = (struct tg_update_data) {
+			.tg = data->tg,
+			.rt_period = data->rt_period,
+			.rt_runtime = data->rt_runtime,
+		},
+		.rt_runtime_remainder = 0,
+	};
+
+	/*
+	 * Walk the cgroup tree and check schedulability constraints.
+	 */
+	lockdep_assert(rcu_read_lock_held());
+	err = walk_tg_tree(__tg_rt_schedulable, tg_nop, &d);
+	if (err)
+		return err;
+
+	*remainder_runtime = d.rt_runtime_remainder;
+	return 0;
+}
+
+struct tg_update_active_context_data {
+	struct task_group *new_active_context;
+	struct task_group *old_active_context;
+};
+
+static int __tg_update_active_context(struct task_group *tg, void *data) {
+	struct tg_update_active_context_data *d = data;
+
+	if (dl_bandwidth_read(tg)->active_context == d->old_active_context) {
+		guard(raw_spinlock_irq)(dl_bw_lock_of_tg(tg));
+		dl_bandwidth_write(tg)->active_context = d->new_active_context;
 	}
 
-	if (sum > total)
-		return -EINVAL;
+	return 0;
+}
+
+static void tg_update_active_context(struct task_group *tg,
+				     struct task_group *old_context,
+				     struct task_group *new_context)
+{
+	struct tg_update_active_context_data data = {
+		.new_active_context = new_context,
+		.old_active_context = old_context,
+	};
+	lockdep_assert(rcu_read_lock_held());
+	walk_tg_tree_from(tg, __tg_update_active_context, tg_nop, &data);
+}
+
+int tg_rt_bandwidth(struct task_group *tg,
+		    long *rt_period_us, long *rt_runtime_us)
+{
+	const struct dl_bandwidth *dl_b;
+
+	guard(raw_spinlock_irq)(dl_bw_lock_of_tg(tg));
+	dl_b = dl_bandwidth_read(tg);
+
+	*rt_runtime_us = -1;
+	if (dl_b->dl_runtime != RUNTIME_INF) {
+		*rt_runtime_us = dl_b->dl_runtime;
+		do_div(*rt_runtime_us, NSEC_PER_USEC);
+	}
+
+	*rt_period_us = dl_b->dl_period;
+	do_div(*rt_period_us, NSEC_PER_USEC);
 
 	return 0;
 }
 
-static int __rt_schedulable(struct task_group *tg, u64 period, u64 runtime)
+int tg_rt_internal_bandwidth(struct task_group *tg,
+			     long *rt_period_us, long *rt_runtime_us)
 {
-	int ret;
+	const struct dl_bandwidth *dl_b;
 
-	struct rt_schedulable_data data = {
-		.tg = tg,
-		.rt_period = period,
-		.rt_runtime = runtime,
-	};
+	guard(raw_spinlock_irq)(dl_bw_lock_of_tg(tg));
+	dl_b = dl_bandwidth_read(tg);
 
-	rcu_read_lock();
-	ret = walk_tg_tree(tg_rt_schedulable, tg_nop, &data);
-	rcu_read_unlock();
+	*rt_runtime_us = dl_b->dl_internal_runtime;
+	do_div(*rt_runtime_us, NSEC_PER_USEC);
 
-	return ret;
+	*rt_period_us = dl_b->dl_period;
+	do_div(*rt_period_us, NSEC_PER_USEC);
+
+	return 0;
 }
 
-static int tg_set_rt_bandwidth(struct task_group *tg,
-		u64 rt_period, u64 rt_runtime)
+int tg_set_rt_bandwidth(struct task_group *tg,
+			u64 rt_period_us, u64 rt_runtime_us)
 {
-	int i, err = 0;
+	struct tg_update_data update;
+	struct task_group *parent_ctx;
+	struct dl_bandwidth *dl_b;
+	u64 rt_period, rt_runtime, old_rt_runtime;
+	u64 rt_actual_runtime = 0;
+	u64 bw, children_bw;
+	struct sched_attr attr;
+	int err, i;
 
-	/*
-	 * Disallowing the root group RT runtime is BAD, it would disallow the
-	 * kernel creating (and or operating) RT threads.
-	 */
-	if (tg == &root_task_group && rt_runtime == 0)
+	if (rt_runtime_us == RUNTIME_INF)
+		rt_runtime = RUNTIME_INF;
+	else if ((u64)rt_runtime_us > U64_MAX / NSEC_PER_USEC)
 		return -EINVAL;
+	else
+		rt_runtime = (u64)rt_runtime_us * NSEC_PER_USEC;
 
-	/* No period doesn't make any sense. */
-	if (rt_period == 0)
+	if ((u64)rt_period_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+	else
+		rt_period = (u64)rt_period_us * NSEC_PER_USEC;
+
+	/*
+	 * The root_task_group bandwidth settings are only used to reserve bw
+	 * for HCBS cgroups; runtime == "max" has no meaning there.
+	 */
+	if (rt_runtime == RUNTIME_INF && tg == &root_task_group)
 		return -EINVAL;
 
 	/*
@@ -2236,34 +2396,119 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	if (rt_runtime != RUNTIME_INF && rt_runtime > max_rt_runtime)
 		return -EINVAL;
 
-	mutex_lock(&rt_constraints_mutex);
-	err = __rt_schedulable(tg, rt_period, rt_runtime);
+	/*
+	 * Check if the runtime and period min and max values are admissible.
+	 */
+	attr = (struct sched_attr){
+		.sched_flags = 0,
+		.sched_runtime = rt_runtime,
+		.sched_deadline = rt_period,
+		.sched_period = rt_period,
+	};
+
+	if (rt_runtime != RUNTIME_INF && !__checkparam_dl(&attr, true))
+		return -EINVAL;
+
+	update = (struct tg_update_data) {
+		.tg = tg,
+		.rt_period  = rt_period,
+		.rt_runtime = rt_runtime,
+	};
+
+	guard(mutex)(&rt_constraints_mutex);
+	old_rt_runtime = dl_bandwidth_read(tg)->dl_runtime;
+
+	/*
+	 * Disallow changing from/to "max" and a HCBS reservation if the group
+	 * and all of its "max" children have active tasks.
+	 */
+	guard(sched_rt_handler)();
+	guard(sched_domains)();
+	guard(rcu)();
+	if (((rt_runtime == RUNTIME_INF && old_rt_runtime != RUNTIME_INF) ||
+	     (rt_runtime != RUNTIME_INF && old_rt_runtime == RUNTIME_INF)) &&
+	     tg_subtree_has_rt_tasks(tg))
+		return -EINVAL;
+
+	err = tg_rt_schedulable(&update, &rt_actual_runtime);
 	if (err)
-		goto unlock;
+		return err;
 
-	raw_spin_lock_irq(&tg->rt_bandwidth.rt_runtime_lock);
-	tg->rt_bandwidth.rt_period = ns_to_ktime(rt_period);
-	tg->rt_bandwidth.rt_runtime = rt_runtime;
+	scoped_guard(raw_spinlock_irq, dl_bw_lock_of_tg(tg)) {
+		dl_b = dl_bandwidth_write(tg);
+		dl_b->dl_period  = rt_period;
+		dl_b->dl_runtime = rt_runtime;
+		dl_b->dl_internal_runtime = rt_actual_runtime;
+	}
+
+	if (tg == &root_task_group)
+		return 0;
 
+	parent_ctx = dl_bandwidth_read(tg->parent)->active_context;
+
+	/*
+	* If changing from/to "max" and a HCBS reservation, must update the
+	* active_context of self and all of its subtree.
+	*/
+	if ((rt_runtime == RUNTIME_INF && old_rt_runtime != RUNTIME_INF) ||
+	    (rt_runtime != RUNTIME_INF && old_rt_runtime == RUNTIME_INF))
+	{
+		if (rt_runtime == RUNTIME_INF)
+			tg_update_active_context(tg, dl_b->active_context, parent_ctx);
+		else
+			tg_update_active_context(tg, dl_b->active_context, tg);
+
+	}
+
+	WARN_ON(rt_runtime == RUNTIME_INF && rt_actual_runtime != 0);
 	for_each_possible_cpu(i) {
-		struct rt_rq *rt_rq = tg->rt_rq[i];
+		dl_init_tg(tg->dl_se[i], rt_actual_runtime, rt_period);
+	}
+
+	/*
+	 * Update the dl_servers of the parent's active context
+	 */
+	if (parent_ctx == &root_task_group)
+		return 0;
+
+	scoped_guard(raw_spinlock_irq, dl_bw_lock_of_tg(parent_ctx)) {
+		dl_b = dl_bandwidth_write(parent_ctx);
 
-		raw_spin_lock(&rt_rq->rt_runtime_lock);
-		rt_rq->rt_runtime = rt_runtime;
-		raw_spin_unlock(&rt_rq->rt_runtime_lock);
+		bw = to_ratio(dl_b->dl_period, dl_b->dl_runtime);
+		children_bw = tg_compute_children_bw(parent_ctx, &update);
+
+		rt_period = dl_b->dl_period;
+		rt_actual_runtime = from_ratio(rt_period, bw - children_bw);
+		dl_b->dl_internal_runtime = rt_actual_runtime;
 	}
-	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
-unlock:
-	mutex_unlock(&rt_constraints_mutex);
 
-	return err;
+	for_each_possible_cpu(i) {
+		dl_init_tg(parent_ctx->dl_se[i], rt_actual_runtime, rt_period);
+	}
+
+	return 0;
 }
 
 int sched_rt_can_attach(struct task_group *tg)
 {
+	struct task_group *ctx;
+
+	/* If rt group sched is disabled, tasks are always run in the root rq */
+	if (!rt_group_sched_enabled())
+		return 1;
+
+	/* Can always run on the root task group */
+	scoped_guard(raw_spinlock_irqsave, dl_bw_lock_of_tg(tg)) {
+		ctx = dl_bandwidth_read(tg)->active_context;
+		if (ctx == &root_task_group)
+			return 1;
+	}
+
 	/* Don't accept real-time tasks when there is no way for them to run */
-	if (rt_group_sched_enabled() && tg->dl_bandwidth.dl_runtime == 0)
-		return 0;
+	scoped_guard(raw_spinlock_irqsave, dl_bw_lock_of_tg(ctx)) {
+		if (dl_bandwidth_read(ctx)->dl_runtime == 0)
+			return 0;
+	}
 
 	return 1;
 }
@@ -2279,24 +2524,26 @@ static int sched_rt_global_validate(void)
 			NSEC_PER_USEC > max_rt_runtime)))
 		return -EINVAL;
 
-#ifdef CONFIG_RT_GROUP_SCHED
-	if (!rt_group_sched_enabled())
-		return 0;
-
-	scoped_guard(mutex, &rt_constraints_mutex)
-		return __rt_schedulable(NULL, 0, 0);
-#endif
 	return 0;
 }
 
+DEFINE_MUTEX(sched_rt_handler_mutex);
+
+void sched_rt_handler_mutex_lock() {
+	mutex_lock(&sched_rt_handler_mutex);
+}
+
+void sched_rt_handler_mutex_unlock() {
+	mutex_unlock(&sched_rt_handler_mutex);
+}
+
 static int sched_rt_handler(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	int old_period, old_runtime;
-	static DEFINE_MUTEX(mutex);
 	int ret;
 
-	mutex_lock(&mutex);
+	sched_rt_handler_mutex_lock();
 	sched_domains_mutex_lock();
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
@@ -2320,7 +2567,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
 		sysctl_sched_rt_runtime = old_runtime;
 	}
 	sched_domains_mutex_unlock();
-	mutex_unlock(&mutex);
+	sched_rt_handler_mutex_unlock();
 
 	/*
 	 * After changing maximum available bandwidth for DEADLINE, we need to
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index efe52e162ba5..394f40dc26db 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -366,7 +366,7 @@ extern void sched_dl_do_global(void);
 extern int  sched_dl_overflow(struct task_struct *p, int policy, const struct sched_attr *attr);
 extern void __setparam_dl(struct task_struct *p, const struct sched_attr *attr);
 extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr, unsigned int flags);
-extern bool __checkparam_dl(const struct sched_attr *attr);
+extern bool __checkparam_dl(const struct sched_attr *attr, bool allow_zero_runtime);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int  dl_bw_deactivate(int cpu);
@@ -425,6 +425,7 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq,
 		    struct rq *served_rq,
 		    dl_server_pick_f pick_task);
 extern void sched_init_dl_servers(void);
+extern int dl_check_tg(unsigned long total);
 extern void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period);
 
 extern void fair_server_init(struct rq *rq);
@@ -607,6 +608,12 @@ extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
 extern bool cfs_task_bw_constrained(struct task_struct *p);
 
+extern int tg_rt_bandwidth(struct task_group *tg,
+			   long *rt_period_us, long *rt_runtime_us);
+extern int tg_rt_internal_bandwidth(struct task_group *tg,
+				    long *rt_period_us, long *rt_runtime_us);
+extern int tg_set_rt_bandwidth(struct task_group *tg,
+			       u64 rt_period_us, u64 rt_runtime_us);
 extern int sched_rt_can_attach(struct task_group *tg);
 
 extern struct task_group *sched_create_group(struct task_group *parent);
@@ -2045,6 +2052,14 @@ DEFINE_LOCK_GUARD_1(raw_spin_rq_lock_irq, struct rq,
 		    raw_spin_rq_lock_irq(_T->lock),
 		    raw_spin_rq_unlock_irq(_T->lock))
 
+extern struct mutex sched_rt_handler_mutex;
+extern void sched_rt_handler_mutex_lock(void);
+extern void sched_rt_handler_mutex_unlock(void);
+
+DEFINE_LOCK_GUARD_0(sched_rt_handler,
+		    sched_rt_handler_mutex_lock(),
+		    sched_rt_handler_mutex_unlock())
+
 #ifdef CONFIG_NUMA
 
 enum numa_topology_type {
@@ -2938,6 +2953,7 @@ extern void init_cfs_throttle_work(struct task_struct *p);
 #define MAX_BW			((1ULL << MAX_BW_BITS) - 1)
 
 extern u64 to_ratio(u64 period, u64 runtime);
+extern u64 from_ratio(u64 period, u64 bw);
 
 extern void init_entity_runnable_average(struct sched_entity *se);
 extern void post_init_entity_util_avg(struct task_struct *p);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 773f744c0460..e5b8d2f42ea8 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -528,7 +528,7 @@ int __sched_setscheduler(struct task_struct *p,
 	 */
 	if (attr->sched_priority > MAX_RT_PRIO-1)
 		return -EINVAL;
-	if ((dl_policy(policy) && !__checkparam_dl(attr)) ||
+	if ((dl_policy(policy) && !__checkparam_dl(attr, false)) ||
 	    (rt_policy(policy) != (attr->sched_priority != 0)))
 		return -EINVAL;
 
-- 
2.54.0


