Return-Path: <cgroups+bounces-15817-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGkvJCLHAmp0wgEAu9opvQ
	(envelope-from <cgroups+bounces-15817-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:22:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E4D51AE2F
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A134A3034310
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 06:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3874DB56B;
	Tue, 12 May 2026 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ow4GRMhB"
X-Original-To: cgroups@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2001h-snip4-2.eps.apple.com [57.103.91.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A747887B
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566871; cv=none; b=G8W8HkTVYT8Ji+fmiQtQMuURJk+OvX0JpZdXTYI0GglHJz3jxlHxrxVjkp41JDv1CzWBGqZ8wuClZ1tWv1c6RasI8JwHQae09+alRUMfK3Fu1N4lrDnjOLLrLnVo4T+kTvOJiyX6ilFFcBIMw3GDcHQcU12mBvLuh9AznAgXQ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566871; c=relaxed/simple;
	bh=lzCq7haBc4sca2HsI7iigGUxADMapnK6Tk4EPTZmuyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oEgYF+deX0ST4w0yAK1KBETFzhSBinqmOR5FrLHlDgvdmY7jOBdpZyfJOb3ZIMaCZce6Q0t5nBChuTaTjENbbu7G1GN/VbHo3HZpdXTqjSo8wgCzZoA+m+Er4zjDvMAhAZQ+SYy6+WKvvvzByc1qbTUFMihSv2ajPNgLaxt1ckE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ow4GRMhB; arc=none smtp.client-ip=57.103.91.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPS id 9779B1800103;
	Tue, 12 May 2026 06:20:44 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJB0MFXwReC0sKQw5eEhVdRV8YXApUH1oNQC1eCF4fTBwdDlgGEhZdRV8YXApUH1oNQC1eCF4fTBwdDlgGEgJaRQFbFwNXHFZFXBhDCV0FVxwdDl5FWxNVF0YJGQhdHRkIRx8KMANCDlYDQwdFAC0ZHFdQXgheH0wcHQ5YBhIdUBwOUQVbAEYJTQJfGhtBGWYRXh1FRkRBFEweX1VcVEEJHlcLVg8HME0dXQ5SBUZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778566850; x=1781158850; bh=HFQgmeVI0oO/YyDZZt3bpmB4cnLvJvO3q2IZPwc5y8Y=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=ow4GRMhBy3HR3saemv/Dx4xL6GdvF/TMpMEdR5eY1ONuQO7wkW4Swd4qTFXa17Aias7GbIze2IUr/eRh4l32XyiUsJzHh9pLwaprqPU+8chKFycy6NCIkfpvLsWrbYMsUZdhsqiAYCGQLLqBRi1bo8Ym0+0txhw+joxzLTguTR59M6RZ+sHVPHl/Jurf1pDXaWxfhnAQO02gvLTdZrbj16BuscOwEcc4U8yTFeDIhE7W2IqtU2RSXHvvuF+L5j01s2CJHZvNwSu4gh8mqLeXWzuDy0uXxIgTC1oOh31f3tia8kCf+bTm8FMvEyMRcPE6+wO3QjerVehpAikR4AuO5g==
Received: from [127.0.0.1] (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPSA id 8424B180013B;
	Tue, 12 May 2026 06:20:35 +0000 (UTC)
From: Luka Bai <lukafocus@icloud.com>
Date: Tue, 12 May 2026 14:20:00 +0800
Subject: [PATCH 4/6] psi: do not call record_times when the state is not
 changed
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-psi_impr-v1-4-2b7f10fdfad5@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778566802; l=1376;
 i=lukabai@tencent.com; s=20260501; h=from:subject:message-id;
 bh=K3W73Ej/H0RH/u7ug92VzPA/oQvz5jykvDzJfWcXDc8=;
 b=UOPUAuG2SMAddJiUXqFia9+qZ6pYXrAI5NMq3HPcY0QsvJzfIJo2mUffCromL/WOhhHUFI1ss
 lo2PUu8RNO3C9et3pjuE+4l0GXHz36Pxes0NjKltfze7gQcrJHXY0gR
X-Developer-Key: i=lukabai@tencent.com; a=ed25519;
 pk=KeaVteSWd00GIAjFyWZnuFsKAKixjga1ZkLMcI66nPM=
X-Proofpoint-GUID: g9I8dGtUZgJhv2L6LpR1sKeFx3DMaVBn
X-Proofpoint-ORIG-GUID: g9I8dGtUZgJhv2L6LpR1sKeFx3DMaVBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2MCBTYWx0ZWRfX7NXkfgr0AzlI
 BXnEsThg68asqk8eaLufSGZHZ5yc5dwqWIlcVz4z10yrJRZ0FsAfTumvp50tBpxWYyJTF5erq8u
 yNUYifqjuq8QbLxjBK2DHJIvwXcPkca0bWhjmNWxrdLBmL3nyCnTfWJcZIvO296B61gajcwNmns
 QNNda9lnhk3nlq5c16dFjQzLdXRNiziCn0v63gTkl5gICYqz5GUAD5EDa7BTjgwYR38OFdN1NOW
 Tvfny2N7FTNLj4AQXz+UZepLPnyqIubWEmjUbwQAy2Ss+/KNYSA8ScW1PyKZR/EHRXc6qcCCGzp
 +x2lzIs9iyeaqXUDF8ZmCtH155clIcvl1GoS77f/4PRHaawJNao38qQ+HeFI2c=
X-Authority-Info-Out: v=2.4 cv=JfSxbEKV c=1 sm=1 tr=0 ts=6a02c6c0
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=jPpEGkWhOON_I5X-:21 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GvQkQWPkAAAA:8 a=wbxJtr-Xvdy7Wj_ENd8A:9
 a=QEXdDO2ut3YA:10
X-Rspamd-Queue-Id: 08E4D51AE2F
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
	TAGGED_FROM(0.00)[bounces-15817-lists,cgroups=lfdr.de];
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

In psi_group_change, record_times is always called no matter whether
the state_mask changes. Since it can cost some performance, we
choose to not to do it unconditionally. If the state has not changed,
we can keep the psi time unchanged.

This will not make any difference to the final result since when
we need to acquire the psi time, get_recent_times() will always
calculate the remaining time into the final result.

Signed-off-by: Luka Bai <lukabai@tencent.com>
---
 kernel/sched/psi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 9b7a85d1bc28..4c4bd134c785 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -880,9 +880,15 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	if (unlikely((state_mask & PSI_ONCPU) && curr_in_memstall))
 		state_mask |= (1 << PSI_MEM_FULL);
 
-	record_times(groupc, now);
-
-	groupc->state_mask = state_mask;
+	/*
+	 * We only need to record times when the state changes. Or
+	 * we can keep it unchanged and wait for get_recent_times()
+	 * to handle the remaining time.
+	 */
+	if (state_mask != groupc->state_mask) {
+		record_times(groupc, now);
+		groupc->state_mask = state_mask;
+	}
 
 	if (state_mask & group->rtpoll_states)
 		psi_schedule_rtpoll_work(group, 1, false);

-- 
2.52.0


