Return-Path: <cgroups+bounces-15814-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OECbHs3GAmp7wQEAu9opvQ
	(envelope-from <cgroups+bounces-15814-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:21:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB8251ADDF
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13B393028651
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B3147887B;
	Tue, 12 May 2026 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="HfaoTKTf"
X-Original-To: cgroups@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2006d-snip4-11.eps.apple.com [57.103.90.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5EF33F8C4
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.90.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566843; cv=none; b=Bp7EGbFdeebF2pPyUx+xvnrr3zI4q7gPaKbHjtmv7JdFyO5eXKOEVSvNI16cWGkm6SQqCm134K3+yvchpcHxSXXWeJV8Ugc2Q67cimwkGc7Lf5ySUIIjS0gOFZ9OSq1vB0ddwxtgUYym4inVUpi4gSPr3kfZzQwBYi/D8npwoV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566843; c=relaxed/simple;
	bh=nfyztFQ9boxz2/uQMy43oZj2XTS6W3sky0rgpJYCHFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLmLca6SoWP8qKub3+12RqzRF+VW8domAyckVGMXERynnOQRgc0pXF6sW2Mwo5moueM1Il8wTkUemorI0svjBNqWeciBaPnvQSHquEMb45lcmlnS8oKvqgixsh9Dqm9XRoXPBtFXxNVHRUSG8gBResBumCTy1FFRvZphmFxsTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=HfaoTKTf; arc=none smtp.client-ip=57.103.90.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPS id 92D92180009B;
	Tue, 12 May 2026 06:20:19 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJB0MFXwReC0sKQw5eEhVdRV8YXApUH1oNQC1eCF4fTBwdDlgGEhZdRV8YXApUH1oNQC1eCF4fTBwdDlgGEgJaRQFbFwNXHFZFXBhDCV0FVxwdDl5FWxNVF0YJGQhdHRkIRx8KMANCDlYDQwdFAC0ZHFdQXgheH0wcHQ5YBhIdUBwOUQVbAEYJTQJfGhtBGWYRXh1FRkRBFEkeX1VcVEEJHlcLVg8HME0dXQ5SBUZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778566822; x=1781158822; bh=RUEYIksx/MlqHH0kLnIe3V1vih+q7HfXEtcMMIeWBLQ=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=HfaoTKTf4WS//AWsDfHkLLUWt6/WCC8m/JNJc0O5DPd0B0E6YvGHkXfHZngCaIJL/MIGbo39qbHgzCO0byXmEMeHM1Z5Zl2mASItHJvvwhIvFWFVv07dfV3rfyMGj+X+p0YrIu3UDpRrzncSKWDPbEqbEWCQXoy0pJIGHfsTrcRzizMt+TfeIVPaTpMRhU4Q13ax8UKToX2cQkMlT7b6fjPOLpGs7Unlu9xQs/xmygN02G6gEpxoglCc6OLueLm9/E7h/UDJm8tbw2UPPehLRrU/f81Np8xaSlohHFu/E2xJ0TJo32TB/ao3HrSvlFUPjBmPmGzXypaTH28v235JCA==
Received: from [127.0.0.1] (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPSA id 37E531800145;
	Tue, 12 May 2026 06:20:10 +0000 (UTC)
From: Luka Bai <lukafocus@icloud.com>
Date: Tue, 12 May 2026 14:19:57 +0800
Subject: [PATCH 1/6] psi: move curr_in_memstall out of psi_group_change
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-psi_impr-v1-1-2b7f10fdfad5@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778566802; l=4239;
 i=lukabai@tencent.com; s=20260501; h=from:subject:message-id;
 bh=N4v4fH+hkrlYsmcPnl7s6h0mPozXQxvFn8vL46xw/7k=;
 b=+Cqj7ZBgNI/G1fXPJkGX4nB/hX2z3e7OsHKJnqqjWDms6s/Img1NG6X3IFhvCChxfTwXzVw7g
 cttC2Nf+welDlxy4aJqInL3IKbZeDZQzvz0cA1lGqA9n9dHV8YQJ5J7
X-Developer-Key: i=lukabai@tencent.com; a=ed25519;
 pk=KeaVteSWd00GIAjFyWZnuFsKAKixjga1ZkLMcI66nPM=
X-Proofpoint-GUID: Q22Xmb8so1l12T3yi4ezHpMO8PEOt5Rc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2MCBTYWx0ZWRfX0TXVU+7TkLnZ
 QcvYmzqmWJbm61P+lopHzA418qFOuOshWgjJYF5QpxPzVU6TYZMLE1ygDjtDOR2QBZ9RhhCsStT
 BCqZVnBxiA75onTrihHRg8QgxmDcVeRJ5HbQBHMykUiigsyuwLKOxrbyMJsaHsrQvxPQZE5YRcp
 +G2FS2MAy+YLY9vzEtJA0jtbFzdRIe3oePpQRegYh8Kp4zvXFIgQX0MIgxKVM78UjvdYrU8RgIB
 C/ko+TQrAZUYNkf0Si90laaVmToUH1ikjlkzUYrF6JsaohyeOpJChQx/4n/Ty1EI5qTReFYHW7y
 Ffmuf7JBYnSn9UCPcMLyXKBzEhGXGJKiItGUx5goBpPE3SJ7vp1GcsV7518p+0=
X-Proofpoint-ORIG-GUID: Q22Xmb8so1l12T3yi4ezHpMO8PEOt5Rc
X-Authority-Info-Out: v=2.4 cv=f8FFxeyM c=1 sm=1 tr=0 ts=6a02c6a5
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=GvQkQWPkAAAA:8 a=geQMgLTJ2Pn_Frh0vGQA:9 a=QEXdDO2ut3YA:10
X-Rspamd-Queue-Id: 2EB8251ADDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15814-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukafocus@icloud.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[icloud.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:dkim,tencent.com:email,tencent.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Luka Bai <lukabai@tencent.com>

Variable curr_in_memstall is currently judged by accessing the
in_memstall of cpu_curr(cpu), which contains multiple times of
memory accessing. And it is now located in psi_group_change()
that will be called for each parent cgroup and it is redundant
sometimes since its value will not change for all these parent
cgroups.

So we move the variable outside for two reasons:
1. We save the extra calling for each parent cgroup so we avoid
   these possible uncessary cacheline stall.
2. For function like psi_task_switch, we don't need to call the
   cpu_curr(cpu) to get the task that is currently running in
   the cpu runqueue. Under that context, "next" is absolutely the
   running task so we can save some costly calling.

Signed-off-by: Luka Bai <lukabai@tencent.com>
---
 kernel/sched/psi.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index d9c9d9480a45..27097cb0dc79 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -795,7 +795,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 
 static void psi_group_change(struct psi_group *group, int cpu,
 			     unsigned int clear, unsigned int set,
-			     u64 now, bool wake_clock)
+			     u64 now, bool wake_clock, bool curr_in_memstall)
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
@@ -868,7 +868,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 * task in a cgroup is in_memstall, the corresponding groupc
 	 * on that cpu is in PSI_MEM_FULL state.
 	 */
-	if (unlikely((state_mask & PSI_ONCPU) && cpu_curr(cpu)->in_memstall))
+	if (unlikely((state_mask & PSI_ONCPU) && curr_in_memstall))
 		state_mask |= (1 << PSI_MEM_FULL);
 
 	record_times(groupc, now);
@@ -910,6 +910,7 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
 	u64 now;
+	bool curr_in_memstall;
 
 	if (!task->pid)
 		return;
@@ -917,9 +918,11 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	psi_flags_change(task, clear, set);
 
 	psi_write_begin(cpu);
+	curr_in_memstall = cpu_curr(cpu)->in_memstall;
 	now = cpu_clock(cpu);
 	for_each_group(group, task_psi_group(task))
-		psi_group_change(group, cpu, clear, set, now, true);
+		psi_group_change(group, cpu, clear, set, now, true,
+			curr_in_memstall);
 	psi_write_end(cpu);
 }
 
@@ -929,11 +932,13 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	struct psi_group *common = NULL;
 	int cpu = task_cpu(prev);
 	u64 now;
+	bool curr_in_memstall = false;
 
 	psi_write_begin(cpu);
 	now = cpu_clock(cpu);
 
 	if (next->pid) {
+		curr_in_memstall = next->in_memstall;
 		psi_flags_change(next, 0, TSK_ONCPU);
 		/*
 		 * Set TSK_ONCPU on @next's cgroups. If @next shares any
@@ -947,7 +952,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 				common = group;
 				break;
 			}
-			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
+			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true,
+				curr_in_memstall);
 		}
 	}
 
@@ -984,7 +990,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		for_each_group(group, task_psi_group(prev)) {
 			if (group == common)
 				break;
-			psi_group_change(group, cpu, clear, set, now, wake_clock);
+			psi_group_change(group, cpu, clear, set, now, wake_clock,
+				curr_in_memstall);
 		}
 
 		/*
@@ -996,7 +1003,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
 			clear &= ~TSK_ONCPU;
 			for_each_group(group, common)
-				psi_group_change(group, cpu, clear, set, now, wake_clock);
+				psi_group_change(group, cpu, clear, set, now, wake_clock,
+					curr_in_memstall);
 		}
 	}
 	psi_write_end(cpu);
@@ -1236,7 +1244,8 @@ void psi_cgroup_restart(struct psi_group *group)
 
 		psi_write_begin(cpu);
 		now = cpu_clock(cpu);
-		psi_group_change(group, cpu, 0, 0, now, true);
+		psi_group_change(group, cpu, 0, 0, now, true,
+			cpu_curr(cpu)->in_memstall);
 		psi_write_end(cpu);
 	}
 }

-- 
2.52.0


