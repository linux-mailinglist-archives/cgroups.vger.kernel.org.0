Return-Path: <cgroups+bounces-16721-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PEMAHp20JmocbgIAu9opvQ
	(envelope-from <cgroups+bounces-16721-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:25:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CED0656211
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:25:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="HqfLFeT/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16721-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16721-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF9313050F39
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A5378D92;
	Mon,  8 Jun 2026 12:16:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417A3B83EE
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920970; cv=none; b=SQ6fkD9PdmnkYNoVPs70xlrDSJmJRG2iHmm8gnYUf4SDvxdIvyX+jLSvtMayaZnozZo0/fkPcLgrhYZbF2uWFNj+HA2XWkM4NWAAKpn/Cj2vihOi3fzA49pXw95QA/UMLcEWJNl3YIdc0D1pqAV0E4wDt+qcwVVfKN/5vW2LL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920970; c=relaxed/simple;
	bh=O4QRi/1KDDjUv1bgVSbxKdT6dZaaPpKxQaswvFSPefI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sECOnnio1ZGC0fpgn/e2tWjKTHqVQHmRBQ5gxLQLOAmp+UKvV2qzoxUGGSKkIE4alhxErFHyu6S9qBS9SWWj0RXXtU+kd+zvE7vFJT255UVAR1k86GuaApYLxY0TD0kJxGzZ5XZcsSdnMmoThffjUiOVCE0f2OJFULlM8uwrMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqfLFeT/; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so2797723f8f.0
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920966; x=1781525766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LCDTuPozw1aQu15eNY968u+ZsEnLeyKTwQrNnXXOZ8=;
        b=HqfLFeT/8mmXrvMf6CjqBXyRt8Tjf6F6X6mBlpO+Sk8VPQcIpSJ2DrGow6KcglQJBr
         WYIEP/EtzAhz8z7J13hHWQZF0n9uCC1QIs/Uf0R2YA1lboQrJrW0AD/ZtYbKwT2yc0rR
         pVuTC9TtEFCRSNyh1tOWdkyFaNTNg1h5oXW9vmhzaROxiRhCminuRUFk5yf8d+woSooU
         2dnOrUcQn019Alc3u/oMrKZJ5KvFxe+SoUTLvxvxhS5vUkLxIDceH0TGTDotlTIQrEgq
         LwLxL52QF7g9Wou7rSrd0b49sItQxEe3i7HBYQqeq8Di2neVLEWVk2U7MOQDESE7G0Bu
         yXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920966; x=1781525766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6LCDTuPozw1aQu15eNY968u+ZsEnLeyKTwQrNnXXOZ8=;
        b=AQsrRWqIQEzdvj2G71R9y0XSRG+vtXnVbE7XqtKVo83ZP9j1mabh5LSIy9V401fyCM
         Z0D9v58sUnmkTqbvgOijcCMTJkIUTv2/ha9nbnAfTJ2CLGhHlw3dItulOm/TF8cVgMOi
         UR5w66pxkJzpcaTkWyGyy7k2X9qYM8gXrGw6F5msgSvadggu6CVObpndZ7XxoEgNW24o
         dgBRqTFm2/fEKeSSUvScwu+NgjVywpacUGVBVxNPdjavA5PjmVguKWZza+dn5U8ACwyX
         Ahb2U7rjOkvuXPoveEgBwhHJ7UwmR4h7cVtzV2/8dDd7T66SmMhd/0ATz7BstTUKh7Xz
         0w2g==
X-Gm-Message-State: AOJu0Yy/NC7pElTJFL8foT9OtQDys2VQwknpTL1GkIPEfZa4NNDdtTs9
	2O7lonukpsV3bYQYqrHHHPf7OJ7wYId3MEk9phzXsmZbgldfl2v4WqYZ
X-Gm-Gg: Acq92OEKUZwdrOhXZq+51WY+G4Zq6Ts3V9Q1eSAdI8G2lC42WT0KqbGczCaE8Zi/Uay
	zqwV1rVYL41ZfPcRCvp/2kRoPnR3BHbPx/7tXbstNxELZ+OxT/E8+gIw+tD/UN3wkjLY39gO+ce
	9XK/j/P1V8YVUff2efs1CqaDq4nw8TVyrzP0Zsgezl8U82Q5ScqYwuUv91KGkyjAIDQ33fgvPgm
	XqYIcS3uNHIZtrvzleuE9wrnz4dkpeTGEKdRXSnD86E3hXMakWkCqqQPvArIhpeVPdY6ov4Cpw7
	6CIO/j7Q02hP3Dk6AuRR+r8VZIoH14kBI7cF8/yfCs4l9lecImT3577KHnDww9XDqw1wf9qbPNY
	cB0rFfdMP2LcLAOgaIz+4MqQqq/z+2tlYsSYk6CpYAZbHHdYPjWFumx+w3R9khmWNcyQjPoEh4/
	vdUpWUvJjhB1amVPYOhDt4DceeWWj6aLQ=
X-Received: by 2002:a05:6000:46cd:b0:460:1492:4f0d with SMTP id ffacd0b85a97d-4603063c591mr15526771f8f.34.1780920965986;
        Mon, 08 Jun 2026 05:16:05 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:05 -0700 (PDT)
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
Subject: [RFC PATCH v6 19/25] sched/rt: Remove old RT_GROUP_SCHED data structures
Date: Mon,  8 Jun 2026 14:15:38 +0200
Message-ID: <20260608121546.69910-20-yurand2000@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16721-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,santannapisa.it:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CED0656211

From: luca abeni <luca.abeni@santannapisa.it>

Completely remove the old RT_GROUP_SCHED's functions and data structures:

- Remove the fields back and my_q from sched_rt_entity.
- Remove the rt_bandwidth data structure.
- Remove the field rt_bandwidth from task_group.
- Remove the rt_bandwidth_enabled function.
- Remove the fields rt_queued, rt_throttled, rt_time, rt_runtime,
  rt_runtime_lock and rt_nr_boosted from rt_rq.

All of the removed fields and data are similarly represented in previously
added fields in rq, rt_rq, dl_bandwidth and in the dl server themselves.

Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 include/linux/sched.h |  3 ---
 kernel/sched/sched.h  | 33 ---------------------------------
 2 files changed, 36 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0021069581c2..e934ec9fc3a9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -628,12 +628,9 @@ struct sched_rt_entity {
 	unsigned short			on_rq;
 	unsigned short			on_list;

-	struct sched_rt_entity		*back;
 #ifdef CONFIG_RT_GROUP_SCHED
 	/* rq on which this entity is (to be) queued: */
 	struct rt_rq			*rt_rq;
-	/* rq "owned" by this entity/group: */
-	struct rt_rq			*my_q;
 #endif
 } __randomize_layout;

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 394f40dc26db..53248cbbeaf8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -313,15 +313,6 @@ struct rt_prio_array {
 	struct list_head queue[MAX_RT_PRIO];
 };

-struct rt_bandwidth {
-	/* nests inside the rq lock: */
-	raw_spinlock_t		rt_runtime_lock;
-	ktime_t			rt_period;
-	u64			rt_runtime;
-	struct hrtimer		rt_period_timer;
-	unsigned int		rt_period_active;
-};
-
 struct dl_bandwidth {
 	raw_spinlock_t		dl_runtime_lock;
 	u64			dl_runtime;
@@ -343,12 +334,6 @@ static inline int dl_bandwidth_enabled(void)
  *  - cache the fraction of bandwidth that is currently allocated in
  *    each root domain;
  *
- * This is all done in the data structure below. It is similar to the
- * one used for RT-throttling (rt_bandwidth), with the main difference
- * that, since here we are only interested in admission control, we
- * do not decrease any runtime while the group "executes", neither we
- * need a timer to replenish it.
- *
  * With respect to SMP, bandwidth is given on a per root domain basis,
  * meaning that:
  *  - bw (< 100%) is the deadline bandwidth of each CPU;
@@ -511,11 +496,9 @@ struct task_group {
 	 * different deadline server, and a runqueue per CPU. All the dl-servers
 	 * share the same dl_bandwidth object.
 	 */
-	struct sched_rt_entity	**rt_se;
 	struct sched_dl_entity	**dl_se;
 	struct rt_rq		**rt_rq;

-	struct rt_bandwidth	rt_bandwidth;
 	struct dl_bandwidth	dl_bandwidth;
 #endif

@@ -842,11 +825,6 @@ struct scx_rq {
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */

-static inline int rt_bandwidth_enabled(void)
-{
-	return 0;
-}
-
 /* RT IPI pull logic requires IRQ_WORK */
 #if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP)
 # define HAVE_RT_PUSH_IPI
@@ -864,17 +842,6 @@ struct rt_rq {
 	bool			overloaded;
 	struct plist_head	pushable_tasks;

-	int			rt_queued;
-
-#ifdef CONFIG_RT_GROUP_SCHED
-	int			rt_throttled;
-	u64			rt_time; /* consumed RT time, goes up in update_curr_rt */
-	u64			rt_runtime; /* allotted RT time, "slice" from rt_bandwidth, RT sharing/balancing */
-	/* Nests inside the rq lock: */
-	raw_spinlock_t		rt_runtime_lock;
-
-	unsigned int		rt_nr_boosted;
-#endif
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group	*tg; /* this tg has "this" rt_rq on given CPU for runnable entities */
 #endif
--
2.54.0


