Return-Path: <cgroups+bounces-15819-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANtIIlPHAmqUwgEAu9opvQ
	(envelope-from <cgroups+bounces-15819-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:23:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CD251AE77
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6F18301B52C
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 06:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7134DBD98;
	Tue, 12 May 2026 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="HnSdxRDm"
X-Original-To: cgroups@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2001a-snip4-11.eps.apple.com [57.103.91.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930D37BE89
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566880; cv=none; b=t+EmFuQiTi1uWdLZ/sVZzMKIukCm0i9dRLZ9eE7IeDTuzK1SYyxR662fgwv0NB4u3KKvluvVbV1LpC4gRhGrH94j9bU5cfseOyK2YHWCWWF1eVrDQiz37JAJ25kPjM6PAhDZ1cvCfOTyD7lqfvEh1bEgsvsGUSrNP4onn7xdhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566880; c=relaxed/simple;
	bh=gNQt9bon6ln9TfhTZIj7An7R0o+Le3B+T4yie/Fk9ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJzmZBS/RaTOkYiUunAr+xQfWo0wC3vvivspbzH4b7TONyTxBYmyvNs3nIxxUm0tNkyJ51214+7iyv6KYFffW9ZUBl0VgojKj+52W0e213i61dUYEedncN/OJ9vs2QZnM9B/hqWZd6rxLIgLzDMSuXvOsQpB5+ak+SDPDJAfeF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=HnSdxRDm; arc=none smtp.client-ip=57.103.91.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPS id 8D51B1800169;
	Tue, 12 May 2026 06:21:00 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJB0MFXwReC0sKQw5eEhVdRV8YXApUH1oNQC1eCF4fTBwdDlgGEhZdRV8YXApUH1oNQC1eCF4fTBwdDlgGEgJaRQFbFwNXHFZFXBhDCV0FVxwdDl5FWxNVF0YJGQhdHRkIRx8KMANCDlYDQwdFAC0ZHFdQXgheH0wcHQ5YBhIdUBwOUQVbAEYJTQJfGhtBGWYRXh1FRkRBFE4eX1VcVEEJHlcLVg8HME0dXQ5SBUZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778566865; x=1781158865; bh=R7WZwsOB3CgUd4zcpnHi7ylJ/W9SAO8MOHEKfoRSL5A=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=HnSdxRDmyDHxxGcgB6hX4nuT6ZqDDeP7hvyGEfS4LRVQ9X+oHmi/ealchoyPYUmbiTKr99/CWKVv8ibjugU1jkchcuUvFj2ORzNxA+9Dq2zNcg1JzWZcWqMrzWo8eBOsbG1qFK0V17qWP3y3VdDeLmAHk+8V86eFSfSkxpSIewVlrn72BWgkIsvZUKv907ta1MmQUX+LeBwOgnhG/8mm83w4vvAhL1u10xGWfPVn8oF2kNdwM/SY65yanfJdRoksN/B3Ae3Tdxxj6SrT4oO1THdDJFIIIH1A77rAYzJCzIN0Fsfm6/FMNIrzTWbGiSDDMJtCyR5LVs9OHKJSDZMVPw==
Received: from [127.0.0.1] (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPSA id 92C81180016C;
	Tue, 12 May 2026 06:20:52 +0000 (UTC)
From: Luka Bai <lukafocus@icloud.com>
Date: Tue, 12 May 2026 14:20:02 +0800
Subject: [PATCH 6/6] psi: remove psi_bug and moves checking of NR_RUNNING
 ahead.
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-psi_impr-v1-6-2b7f10fdfad5@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778566802; l=2880;
 i=lukabai@tencent.com; s=20260501; h=from:subject:message-id;
 bh=6q4L4uq69DKt/CZJ1lu/3JvGNmB9tf3m8tlVZoTYSQg=;
 b=slephPrnVgdHjw/+xnQlaJ5+kdbd2sfsfq2sIgLIGUkwgJZ4dCV4BuiON5JrJgQGV1sEI/IsO
 dEiXPb8JBCQDoJYucm0uqyKoAMhhKAu3MZtlXNAg3A89RU8wTfqQfBV
X-Developer-Key: i=lukabai@tencent.com; a=ed25519;
 pk=KeaVteSWd00GIAjFyWZnuFsKAKixjga1ZkLMcI66nPM=
X-Authority-Info-Out: v=2.4 cv=GMUF0+NK c=1 sm=1 tr=0 ts=6a02c6cf
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=GvQkQWPkAAAA:8 a=Ee36wLBZbuEWgZn7rsAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: g4Q5OHPjTgqPAB5qPTQmBZ7cS488dJIr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2MCBTYWx0ZWRfX/akZhom3E3Mp
 ZK3GJGTPs0Dt81nwy1vbFDzb9wORUetUdzgi/h13hsgnrPxZadwvVbQe9k1gZS2uNoRh5uCbwHG
 IpoU6N9uKnSOeeL2cqA5feDS7PPT0/P1VY0A+nlayNV6c5+nShOLlVQDZSEEdqqVvGINfATawDM
 zlBZOHti0EVgG5zro2PpOvkqJjwmdqQrgyQTL0b4w7eRtdsb/YYOB9bnWWSwyvujPtjnMvqpa4m
 o0Ydn0eYnDV+3Ng+A0C6bBhg3uMK/jvdng0P2X4oakv0V2nHTGUEAZSdSdU8MMSulVVhSzpOH+M
 dqZe0HZPDGFgFgxfgKfblSR7yvzznD3RjnfH6+2keJEgDUdQTWnRNYJqQvlvnc=
X-Proofpoint-ORIG-GUID: g4Q5OHPjTgqPAB5qPTQmBZ7cS488dJIr
X-Rspamd-Queue-Id: 28CD251AE77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15819-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukafocus@icloud.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[icloud.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:dkim,tencent.com:email,tencent.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Luka Bai <lukabai@tencent.com>

During the accounting of psi states we'd like to do some bug detection
to make it more maintainable. And we use the variable psi_bug to make
it print once. We would like to use printk_deferred_once to replace the
usage of psi_bug since their effect are similar, and this can also
increase the readability.

Also, use likely and unlikely in these bug detection branches.

Signed-off-by: Luka Bai <lukabai@tencent.com>
---
 kernel/sched/psi.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 4c4bd134c785..70dd642af5e0 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -141,8 +141,6 @@
 #include <linux/psi.h>
 #include "sched.h"
 
-static int psi_bug __read_mostly;
-
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
 static DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
 
@@ -262,7 +260,7 @@ static u32 test_states(unsigned int *tasks, u32 state_mask)
 	if (tasks[NR_RUNNING] && !oncpu)
 		state_mask |= BIT(PSI_CPU_FULL);
 
-	if (tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] || tasks[NR_RUNNING])
+	if (tasks[NR_RUNNING] || tasks[NR_MEMSTALL] || tasks[NR_IOWAIT])
 		state_mask |= BIT(PSI_NONIDLE);
 
 	return state_mask;
@@ -836,14 +834,13 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
 		if (!(m & (1 << t)))
 			continue;
-		if (groupc->tasks[t]) {
+		if (likely(groupc->tasks[t])) {
 			groupc->tasks[t]--;
-		} else if (!psi_bug) {
-			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
+		} else {
+			printk_deferred_once("psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
 					cpu, t, groupc->tasks[0],
 					groupc->tasks[1], groupc->tasks[2],
 					groupc->tasks[3], clear, set);
-			psi_bug = 1;
 		}
 	}
 
@@ -908,13 +905,11 @@ static inline struct psi_group *task_psi_group(struct task_struct *task)
 
 static void psi_flags_change(struct task_struct *task, int clear, int set)
 {
-	if (((task->psi_flags & set) ||
-	     (task->psi_flags & clear) != clear) &&
-	    !psi_bug) {
-		printk_deferred(KERN_ERR "psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",
+	if (unlikely(((task->psi_flags & set) ||
+	     (task->psi_flags & clear) != clear))) {
+		printk_deferred_once("psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",
 				task->pid, task->comm, task_cpu(task),
 				task->psi_flags, clear, set);
-		psi_bug = 1;
 	}
 
 	task->psi_flags &= ~clear;
@@ -927,7 +922,7 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	u64 now;
 	bool curr_in_memstall;
 
-	if (!task->need_psi)
+	if (unlikely(!task->need_psi))
 		return;
 
 	psi_flags_change(task, clear, set);

-- 
2.52.0


