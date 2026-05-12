Return-Path: <cgroups+bounces-15816-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMDxGu7GAmp7wQEAu9opvQ
	(envelope-from <cgroups+bounces-15816-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:21:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 770FA51AE0A
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0775D30200A5
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 06:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CE9472786;
	Tue, 12 May 2026 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="nqSKptPk"
X-Original-To: cgroups@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2006h-snip4-11.eps.apple.com [57.103.90.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D150D42B747
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.90.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566861; cv=none; b=nersPApErpC7pOgfDNbGSLQyygzf9WYb20LS02XD1lzU1ADPWXvyorZm31J4vtBf/rQSRAR4zTVwsxrD94C70qQw2D1sXoVl4+dWi8pHDIzRG/nwqi3fausgAB+9CqCd5oIt4BwjunFlgfTTl1lC5ujLZ0gkshE4BIAGkcIi20U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566861; c=relaxed/simple;
	bh=zqVzAXMYu63ffGko9nKPICpveunF3RAWx1YTFHVCO6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kNbGNAX4osV1yJQgB7juMjbnNZ2BpY4Bi3T+JvmkdmukT+acnbQDaECOuOudlt371ZrshYsLs/T5FMVMVoVLXlW+fTA0mI12Jdj3v5yIEF4FJlEic9SaUKXbvKhMosOtJvLPHPnejkFStEFpVxZcgM9J5L3Buji07MFxxnFxdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=nqSKptPk; arc=none smtp.client-ip=57.103.90.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPS id C971E1800145;
	Tue, 12 May 2026 06:20:35 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJB0MFXwReC0sKQw5eEhVdRV8YXApUH1oNQC1eCF4fTBwdDlgGEhZdRV8YXApUH1oNQC1eCF4fTBwdDlgGEgJaRQFbFwNXHFZFXBhDCV0FVxwdDl5FWxNVF0YJGQhdHRkIRx8KMANCDlYDQwdFAC0ZHFdQXgheH0wcHQ5YBhIdUBwOUQVbAEYJTQJfGhtBGWYRXh1FRkRBFEseX1VcVEEJHlcLVg8HME0dXQ5SBUZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778566840; x=1781158840; bh=jBrMrf8hMktELWdbsosIy/gP1NfZvzoho6CS5ELcmAA=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=nqSKptPkZhXlFKhIXZUyEIegTK+C2OsHiT/+GTkHpNcv5W6BCkv+iQ/zGkQOWt4RCZVJk+Orx4uETUusdtVi7IPGfvVcB9hEgH/O4P5GeaqfavSAN7Ze5/FGJMccDYXDBHP1C5t5muzPLcu5UC93BhZRgTrbfHBLJ3gMN4rKIMZgvJM8aU6RvDeLqC8xs9zl0l+Kvyu6+SuXmkplw0Ys3BmXcDxshqffezgjiZteKVpilLJ+wmJqJwcFqwCChOcwoFLKJXmDdCM1HkKxV/aEPrf3TJSt6Ee1Xhn3knKZz4NQrtG3PXi7mhvnIHhlG3lDMfQlfCwKjO/2ywYIneOJRA==
Received: from [127.0.0.1] (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPSA id 823941800163;
	Tue, 12 May 2026 06:20:27 +0000 (UTC)
From: Luka Bai <lukafocus@icloud.com>
Date: Tue, 12 May 2026 14:19:59 +0800
Subject: [PATCH 3/6] psi: use prefetch to preread the parent groupc
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-psi_impr-v1-3-2b7f10fdfad5@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778566802; l=1563;
 i=lukabai@tencent.com; s=20260501; h=from:subject:message-id;
 bh=+JcKsdtCurE9VHRwxuJWG/dD3Hek1DjyyYdhbiDrT/g=;
 b=1kCJZGZ3wESDhZA3qYvhWlcaaEd8GY1Dqwzu5eDcX3sjMZmjp9vbuShOztlWnK6SiqPpyK+ox
 BE2osQ8fjgaAhGJcOhyngFdGGntxSRkArR1ugoO+3+/29y75WgKbhLy
X-Developer-Key: i=lukabai@tencent.com; a=ed25519;
 pk=KeaVteSWd00GIAjFyWZnuFsKAKixjga1ZkLMcI66nPM=
X-Proofpoint-ORIG-GUID: TAXgD_ERG73VAJ-rZk6gIBJZTM7Spttj
X-Authority-Info-Out: v=2.4 cv=U6mfzOru c=1 sm=1 tr=0 ts=6a02c6b6
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=GvQkQWPkAAAA:8 a=Pzb0aO4xvM8uoPzCJ9cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2MCBTYWx0ZWRfXxa7iA0pwiHf6
 cecYf2NWLuZ4bTxf3ydbN4Nes77CXyip6yklmRkmDJhHA3x+Vmgkq/VJJ//pbUq8WPwfz3VFsxn
 grYkb+mM9ebDv7n/jMfYfrWD6+YCbBNJlvPUOOmqlC3gKnvA0cPJKYFnj5/4Uj8eitZhlCIlzrb
 YlNoksKPiVZJgT/hYCD0iKpcpoTvMj4yfUJjDYQx5fwD/W8OYm++M9FhaVcvPp1DYT600vsjCAB
 jqaZr2Wa+npjxAO4yI6NRFfO/WHehzNOe3wDC6JX2YVdYaUlV+aW6vlGNGKddZWnd8Ff2CCtxpJ
 q22Cn+obpwVbcGJNxnEnc0/BhaGz12efhrsuaa6ubyIyZS48riR49cPNE1OsCk=
X-Proofpoint-GUID: TAXgD_ERG73VAJ-rZk6gIBJZTM7Spttj
X-Rspamd-Queue-Id: 770FA51AE0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15816-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukafocus@icloud.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[icloud.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tencent.com:email,tencent.com:mid]
X-Rspamd-Action: no action

From: Luka Bai <lukabai@tencent.com>

When doing psi_group_change, we always iterate all the cgroups from
the child all the way up to the root cgroup. They are all double link
list connected so it's hard for the CPU to prefetch this parent. So
we tried to add a prefetch for the parent groupc, and it has quite some
benefits for the final result.

Signed-off-by: Luka Bai <lukabai@tencent.com>
---
 kernel/sched/psi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7374c05a5751..9b7a85d1bc28 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -793,6 +793,15 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 #define for_each_group(iter, group) \
 	for (typeof(group) iter = group; iter; iter = iter->parent)
 
+static inline struct psi_group_cpu *prefetch_and_get_groupc(struct psi_group *group, int cpu)
+{
+	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+
+	if (group->parent)
+		prefetchw(per_cpu_ptr(group->parent->pcpu, cpu));
+	return groupc;
+}
+
 static void psi_group_change(struct psi_group *group, int cpu,
 			     unsigned int clear, unsigned int set,
 			     u64 now, bool wake_clock, bool curr_in_memstall)
@@ -802,7 +811,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	u32 state_mask;
 
 	lockdep_assert_rq_held(cpu_rq(cpu));
-	groupc = per_cpu_ptr(group->pcpu, cpu);
+	groupc = prefetch_and_get_groupc(group, cpu);
 
 	/*
 	 * Start with TSK_ONCPU, which doesn't have a corresponding

-- 
2.52.0


