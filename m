Return-Path: <cgroups+bounces-15815-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOTEHgXHAmp7wQEAu9opvQ
	(envelope-from <cgroups+bounces-15815-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:21:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3482851AE21
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 556253022BB6
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 06:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD131715B;
	Tue, 12 May 2026 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="frWUwbFM"
X-Original-To: cgroups@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2006b-snip4-11.eps.apple.com [57.103.90.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28C48B37F
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.90.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566850; cv=none; b=ZAQQSbygPA7awbosizMI6bCD4+Tmf1YeI05nAYGV8a8xR4S+TXlgZ4dRoiCNA5uNVWCutOid9Ugqk+YiE7x6sv42+ucU4EJgq4TbCm47sBJ3G0tLKvRT2JhHUyZ32oR2mwSIIhzI11BRDQ4tUg5hYc/qMfB7D0Cniaj4/a9gu6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566850; c=relaxed/simple;
	bh=HpA0+ADhSeNav611ha+axsQYGMsF8wXTnM7S36tVEBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pGel1b9QHa8GTcPKZSlSdREfxZhPPT1YXb0W+40QxJ2M7Ox9e6FQ8QpVwYHlh5i5JPgbNEmOUMLernay7ATXdKKDKliETO4EDwZ4iKQqp//zanF+HNBZckBN2Ymy+jmXMEjm67opK3L18410ME80nWXQJP63vkiF6jSw8G842TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=frWUwbFM; arc=none smtp.client-ip=57.103.90.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPS id 64E981800162;
	Tue, 12 May 2026 06:20:27 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJB0MFXwReC0sKQw5eEhVdRV8YXApUH1oNQC1eCF4fTBwdDlgGEhZdRV8YXApUH1oNQC1eCF4fTBwdDlgGEgJaRQFbFwNXHFZFXBhDCV0FVxwdDl5FWxNVF0YJGQhdHRkIRx8KMANCDlYDQwdFAC0ZHFdQXgheH0wcHQ5YBhIdUBwOUQVbAEYJTQJfGhtBGWYRXh1FRkRBFEoeX1VcVEEJHlcLVg8HME0dXQ5SBUZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778566830; x=1781158830; bh=8h+7o8Bgk3l22j2rwVIvN8mIH1kXWOUMroNDLXzMIms=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=frWUwbFMzDRZTuvIbU+SbHHZTU0jXu8FdTinTBy3KtVQZXX37b1wxAIeIbFyx9AqFfsVO9Dti9XClU1aYkbUPZ6zcQO1IPoSyQCx4P8jnungNVWUw2KeRZzk6VN9NDGAe9Id+vbuubQ6I2gEFBo4ExmqZS/ACu0Q4NyPSnkMzo85hlSB5lPCYzfStd8zLSGUkDUP2olbRHb/F/b5g/VasMM+Ha0zwB9f9JASk+qchBq6jCOzT0GCTWOfOIvY9vgLTWF85hb5jfoaE2pFagmb5FfDPm4sUV6thxBzD8o0haWaeihiXDR2UwPFtA3yTzPXKrW8P8+53rWze4OtVvhoyg==
Received: from [127.0.0.1] (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPSA id B5847180010C;
	Tue, 12 May 2026 06:20:19 +0000 (UTC)
From: Luka Bai <lukafocus@icloud.com>
Date: Tue, 12 May 2026 14:19:58 +0800
Subject: [PATCH 2/6] psi: reorganize the psi members for cacheline benifits
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-psi_impr-v1-2-2b7f10fdfad5@tencent.com>
References: <20260512-psi_impr-v1-0-2b7f10fdfad5@tencent.com>
In-Reply-To: <20260512-psi_impr-v1-0-2b7f10fdfad5@tencent.com>
To: linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Peter Ziljstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Kees Cook <kees@kernel.org>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 Luka Bai <lukabai@tencent.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778566802; l=6142;
 i=lukabai@tencent.com; s=20260501; h=from:subject:message-id;
 bh=N5D+RIwNZxJiJH2AZyKghi8aFJucRQZRH7/vB1IusO0=;
 b=7t1U+9WAPOc6xZ2Jf+KkbhsNm38o93/Pyv5oy5BDThvnGJnPJVbvPDZyK0wSKSmmYzUWwbOhg
 XBdum8KdBkhCSyqO8oqxS6ghmUn1ubG4LxbvrSMr0zEh1mCCBvpK3bs
X-Developer-Key: i=lukabai@tencent.com; a=ed25519;
 pk=KeaVteSWd00GIAjFyWZnuFsKAKixjga1ZkLMcI66nPM=
X-Proofpoint-ORIG-GUID: 2M5e_Q70fx062IKZSDQxewmhsUgwKgQo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2MCBTYWx0ZWRfX6QSzkCjU11Mi
 51TXnSvJ/Is9C+tRSgrDz4C3LzwMi12qxThHTNNN3fS+UPt5chTyWEo3OvvEhLTIc6D0w1lsBj9
 rhazZSLaMZn8oAfQY9vh2Is36O3mW9+/R8E4PK+fuXHSSHZBOfwR7XNXk9dlbzHrznciRrp34uB
 swU3Ffiu6HnBj3hFIwhGymIq3MFGg8ABBcQvwSjSOFtTATM7ormp0ykSXl1hkmVUQY+ZoPWydSt
 CMlNEiNASWdeAt8n2YnmYdReWrsE9KzW8TuOBF3uoDwSBMq1SY+3OnDqRaBZ2Q8qTtxT4KmHcgT
 dLPh8sfw5e9Dm7dzR8hbz2nWZJ5Cc65ovsY7Gqv6eIlxM3ScxNt3coWFgUGYDs=
X-Proofpoint-GUID: 2M5e_Q70fx062IKZSDQxewmhsUgwKgQo
X-Authority-Info-Out: v=2.4 cv=fMA0HJae c=1 sm=1 tr=0 ts=6a02c6ac
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=GvQkQWPkAAAA:8 a=cUUTUCbMLiH3-CSjQHoA:9 a=QEXdDO2ut3YA:10
X-Rspamd-Queue-Id: 3482851AE21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15815-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukafocus@icloud.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[icloud.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:dkim,tencent.com:email,tencent.com:mid]
X-Rspamd-Action: no action

From: Luka Bai <lukabai@tencent.com>

Currently, we check whether the task needs to do psi accounting by
reading task->pid, which is not cacheline aligned with other psi
variables like in_memstall. This can generate some cacheline stall
from what perf-record indicates. So we would like to merge these
variables together.

However, directly switching order of pid and restart_block may cause
other cacheline problem in other scenorios which is hard to recognize
clearly. So we added need_psi bitfield variable to indicate the same psi
thing and put it together with in_memstall. The value of need_psi will
not be changed ever since the task gets created so there is no problem
about synchronization. Also, adding one bit to the bitfield variable
of unsigned int will not enlarge the size of task_struct or change the
memory pattern of task_struct at all.

Also, we put psi_flags which only has 5 bits long together with
in_memstall and need_psi too to make them all cacheline optimized.
5 extra bits can also be stuffed into one single unsigned int so it
will also not enlarge the size of task_struct, but on the contrary,
it will shrink the task_struct since we eliminate the psi_flags that
was put there independently as a unsigned int.

We also add NR_TSK_ONCPU and NR_PSI_ALL_COUNTS into the psi_task_count
enum definition to make the semantics clearer, and move the definition
from linux/psi_types.h into linux/sched.h since we need those enums in
linux/sched.h. These two revisions do not make any actual funtional
difference to the code.

Signed-off-by: Luka Bai <lukabai@tencent.com>
---
 include/linux/psi_types.h | 20 +-------------------
 include/linux/sched.h     | 29 +++++++++++++++++++++++++----
 kernel/fork.c             | 10 ++++++++++
 kernel/sched/psi.c        |  6 +++---
 4 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index dd10c22299ab..5639dcdd90af 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -10,24 +10,6 @@
 
 #ifdef CONFIG_PSI
 
-/* Tracked task states */
-enum psi_task_count {
-	NR_IOWAIT,
-	NR_MEMSTALL,
-	NR_RUNNING,
-	/*
-	 * For IO and CPU stalls the presence of running/oncpu tasks
-	 * in the domain means a partial rather than a full stall.
-	 * For memory it's not so simple because of page reclaimers:
-	 * they are running/oncpu while representing a stall. To tell
-	 * whether a domain has productivity left or not, we need to
-	 * distinguish between regular running (i.e. productive)
-	 * threads and memstall ones.
-	 */
-	NR_MEMSTALL_RUNNING,
-	NR_PSI_TASK_COUNTS = 4,
-};
-
 /* Task state bitmasks */
 #define TSK_IOWAIT	(1 << NR_IOWAIT)
 #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
@@ -35,7 +17,7 @@ enum psi_task_count {
 #define TSK_MEMSTALL_RUNNING	(1 << NR_MEMSTALL_RUNNING)
 
 /* Only one task can be scheduled, no corresponding task count */
-#define TSK_ONCPU	(1 << NR_PSI_TASK_COUNTS)
+#define TSK_ONCPU	(1 << NR_TSK_ONCPU)
 
 /* Resources that workloads could be stalled on */
 enum psi_res {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 368c7b4d7cb5..34d7f80531e7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -817,6 +817,28 @@ struct kmap_ctrl {
 #endif
 };
 
+#ifdef CONFIG_PSI
+/* Tracked task states */
+enum psi_task_count {
+	NR_IOWAIT,
+	NR_MEMSTALL,
+	NR_RUNNING,
+	/*
+	 * For IO and CPU stalls the presence of running/oncpu tasks
+	 * in the domain means a partial rather than a full stall.
+	 * For memory it's not so simple because of page reclaimers:
+	 * they are running/oncpu while representing a stall. To tell
+	 * whether a domain has productivity left or not, we need to
+	 * distinguish between regular running (i.e. productive)
+	 * threads and memstall ones.
+	 */
+	NR_MEMSTALL_RUNNING,
+	NR_PSI_TASK_COUNTS,
+	NR_TSK_ONCPU = NR_PSI_TASK_COUNTS,
+	NR_PSI_ALL_COUNTS,
+};
+#endif
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -1030,6 +1052,9 @@ struct task_struct {
 #ifdef CONFIG_PSI
 	/* Stalled due to lack of memory */
 	unsigned			in_memstall:1;
+	unsigned			need_psi:1;
+	/* Pressure stall state */
+	unsigned            psi_flags:NR_PSI_ALL_COUNTS;
 #endif
 #ifdef CONFIG_PAGE_OWNER
 	/* Used by page_owner=on to detect recursion in page tracking. */
@@ -1299,10 +1324,6 @@ struct task_struct {
 	kernel_siginfo_t		*last_siginfo;
 
 	struct task_io_accounting	ioac;
-#ifdef CONFIG_PSI
-	/* Pressure stall state */
-	unsigned int			psi_flags;
-#endif
 #ifdef CONFIG_TASK_XACCT
 	/* Accumulated RSS usage: */
 	u64				acct_rss_mem1;
diff --git a/kernel/fork.c b/kernel/fork.c
index 0d97fd71d7f6..20b47c876b27 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2177,6 +2177,16 @@ __latent_entropy struct task_struct *copy_process(
 
 #ifdef CONFIG_PSI
 	p->psi_flags = 0;
+	/*
+	 * Only setup need_psi to 1 for non-idle tasks. We
+	 * also need to reset need_psi of idle tasks to 0 since
+	 * their values are copied from the init task whose
+	 * need_psi is not 0.
+	 */
+	if (pid != &init_struct_pid)
+		p->need_psi = 1;
+	else
+		p->need_psi = 0;
 #endif
 
 	task_io_accounting_init(&p->ioac);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 27097cb0dc79..7374c05a5751 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -912,7 +912,7 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	u64 now;
 	bool curr_in_memstall;
 
-	if (!task->pid)
+	if (!task->need_psi)
 		return;
 
 	psi_flags_change(task, clear, set);
@@ -937,7 +937,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	psi_write_begin(cpu);
 	now = cpu_clock(cpu);
 
-	if (next->pid) {
+	if (next->need_psi) {
 		curr_in_memstall = next->in_memstall;
 		psi_flags_change(next, 0, TSK_ONCPU);
 		/*
@@ -957,7 +957,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		}
 	}
 
-	if (prev->pid) {
+	if (prev->need_psi) {
 		int clear = TSK_ONCPU, set = 0;
 		bool wake_clock = true;
 

-- 
2.52.0


