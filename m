Return-Path: <cgroups+bounces-15818-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BKHMjjHAmp7wQEAu9opvQ
	(envelope-from <cgroups+bounces-15818-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:22:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C6B51AE45
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB73D306509F
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 06:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEB444CADC;
	Tue, 12 May 2026 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WfXdgDmA"
X-Original-To: cgroups@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2001d-snip4-11.eps.apple.com [57.103.91.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980D3264FD
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566874; cv=none; b=Rj6r6mmM9AEsrvlxcZmGJ1phayQuntNTU0QhrqSUQ8OZPKtT8GJ3BB+hfy55VEIzyHEXlM1Z6eaD5CysOfiI6+PugVUjIyzinVT3UowmyKhdl3jI6dkKH5+zp9meOxOdcaRdsB6+wifRALY0Ny6bhdaoKIEfPUpOQB8+b886HQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566874; c=relaxed/simple;
	bh=9FP8n6XGR1QceBaNZQHKC7yOvhgDJhFZnp5vXDSzB/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HcIz2cE19UiYBtygogvC33Y55V5H5R2IqsHZ64ii3hB1R6q3RBTDhSdXF2Gxmh9kD6lBQGYnIwLJ1YRNm3SshSDDEu91WHVSvUS6F85K2ip7hDpXurHSefAUcFRAUTJ6pS5I3ySedTdqGTGPvjZ0f9f5IaOOYRZzCfI/xjcz7jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WfXdgDmA; arc=none smtp.client-ip=57.103.91.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPS id C11F2180011C;
	Tue, 12 May 2026 06:20:52 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJB0MFXwReC0sKQw5eEhVdRV8YXApUH1oNQC1eCF4fTBwdDlgGEhZdRV8YXApUH1oNQC1eCF4fTBwdDlgGEgJaRQFbFwNXHFZFXBhDCV0FVxwdDl5FWxNVF0YJGQhdHRkIRx8KMANCDlYDQwdFAC0ZHFdQXgheH0wcHQ5YBhIdUBwOUQVbAEYJTQJfGhtBGWYRXh1FRkRBFE0eX1VcVEEJHlcLVg8HME0dXQ5SBUZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778566856; x=1781158856; bh=mKgIAnZB5fUXzrw1IdBcNeVNTkRS5dYeFy3GvsnLKiY=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=WfXdgDmAI2tBeLM82M0xxxdMvosHkKR1IXKAu/jjSOrU8tQl/ZxyO3RH/ha7K4L+3NlLDISMcPN0ZrGkBDF8WI30KLA9MLcBFBHGNQ4cVOim34Ff5eJ4TX5DdPwpNpwjXprDJ4PQQg+6WG5wq7ByFoDCk+J0CHB2hV6WWpxIa1I3v8FY7lyYBaIQSc6NEz3T8+Zk1NdwdYvvpAAv3Zp0J4Hg923FmcjQ38IwOgk6RGi6iwCeiqyxvsuxYgmg7E+CQLTr0tYRxTfYQN/+rf5N7v2QSN3rcxkNF+sD/HTl/mG2NhRRgPTPJnSGAwUmpovYqVgjulEgfPivLYsRlYTnNw==
Received: from [127.0.0.1] (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPSA id 5BCAF18000B9;
	Tue, 12 May 2026 06:20:44 +0000 (UTC)
From: Luka Bai <lukafocus@icloud.com>
Date: Tue, 12 May 2026 14:20:01 +0800
Subject: [PATCH 5/6] psi: add psi group for the root cgroup
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-psi_impr-v1-5-2b7f10fdfad5@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778566802; l=1490;
 i=lukabai@tencent.com; s=20260501; h=from:subject:message-id;
 bh=hegqJxsefRUo0IZb6av0loX0beqXtKAilCIuw9AGMOg=;
 b=PpQmxUSe15FVJGWEVgQ54mSJ/1lP1TFKzTir1B2BYtnj3SMHDa69594F8Hmf2TlrNR0dmx2qS
 Q4m22WKPwWwD4F4CLCngciseUZUM95VA5i6FGqMEAV4qErxozcS0EKq
X-Developer-Key: i=lukabai@tencent.com; a=ed25519;
 pk=KeaVteSWd00GIAjFyWZnuFsKAKixjga1ZkLMcI66nPM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2MCBTYWx0ZWRfX0EYYtqAKu+rD
 yhcbvq0Iuaphbygoj5MTpyMOFj/S9zSD7ipPt2xh10r7q6GLMgeWnDOIcMhwQwafZcILtGCijJe
 SbmPA0Gnc+rUuIib7XjHzO1JEq98Obm3T6djFk6ub0sPso4NIRLwYp5OFingNelgizgGP+jvgXl
 NQvcUDByWZO1dEFVDB1k38KRMLLNd1u/0vYTQilKG9sz45w0VRy1Ut869gv1hWFslAeF9AyAYSK
 e69KW+mGRkPOAtA641O+e4T52Zl2XC+afS/pYAmNvMitoPMaa704jw6L7J8HjhHQ9caTLdEgtNp
 Ds/YlM6zgzuj6xvEB1Ig8gEm52uHMjGdswtA6sHjNq7abTSQiYRzmJOAaVtIn4=
X-Authority-Info-Out: v=2.4 cv=BryQAIX5 c=1 sm=1 tr=0 ts=6a02c6c7
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=GvQkQWPkAAAA:8 a=PktQUFpngk8bp4KwMBsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: B6dnkmnWxy2EQg2uAF8glNidlGTVlMce
X-Proofpoint-ORIG-GUID: B6dnkmnWxy2EQg2uAF8glNidlGTVlMce
X-Rspamd-Queue-Id: 56C6B51AE45
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
	TAGGED_FROM(0.00)[bounces-15818-lists,cgroups=lfdr.de];
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

Cgroup_psi() now includes a condition, and checks against whether
the cgroup is the root cgroup to decide whether to use psi_system
instead of cgrp->psi. This is mostly because the default hierarchy
does not have any psi group attached. So we make psi_system as
its psi group, and remove the if condition in cgroup_psi().

Signed-off-by: Luka Bai <lukabai@tencent.com>
---
 include/linux/psi.h    | 2 +-
 kernel/cgroup/cgroup.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index e0745873e3f2..8f2db511d051 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -34,7 +34,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 #ifdef CONFIG_CGROUPS
 static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
 {
-	return cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
+	return cgrp->psi;
 }
 
 int psi_cgroup_alloc(struct cgroup *cgrp);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 43adc96c7f1a..357c68662d18 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -178,6 +178,9 @@ static DEFINE_PER_CPU(struct cgroup_rstat_base_cpu, root_rstat_base_cpu);
 /* the default hierarchy */
 struct cgroup_root cgrp_dfl_root = {
 	.cgrp.self.rstat_cpu = &root_rstat_cpu,
+#ifdef CONFIG_PSI
+	.cgrp.psi = &psi_system,
+#endif
 	.cgrp.rstat_base_cpu = &root_rstat_base_cpu,
 };
 EXPORT_SYMBOL_GPL(cgrp_dfl_root);

-- 
2.52.0


