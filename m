Return-Path: <cgroups+bounces-16103-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBTiI4ArDWo2uAUAu9opvQ
	(envelope-from <cgroups+bounces-16103-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 05:33:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D8D58747A
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 05:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DA173073740
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 03:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2851363C55;
	Wed, 20 May 2026 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA1miA+u"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE403546C2
	for <cgroups@vger.kernel.org>; Wed, 20 May 2026 03:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247869; cv=none; b=oFVXsrwTfWQsDHRcVR1WuHiK9IvfCyGKyo7y5lcVDa7tPIzVdNiBZI2v6glme9l/1Izd1lFagxsEcPG67t8YGaVc1MrGMUJ8+xoIX45v6wLnyV0bOKZgy9fQhSvuIlt0wLipZetFK5xfFCLB7efdtjjLNAjYoudeqPXCiOdznoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247869; c=relaxed/simple;
	bh=MkE9oEsiIuagC+yOi3izgicZSC9d2P9EfBhloTtkDo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GXkeW8BxMirSphH0NlOCc9XYu5+X0ebwxWN4jSuUBG7ssIM7X7jR5cn/ZlT+7Y09sV0nWb6b9fJtcNZ4ZjKegLYGKVDjsTPBPxRxfbMkGkKcI/wjEsB+6qS/2WD+bPSVnY62MW9z5xEehsegbDVn1y7cCCmwyIuEmcYCJf8YQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QA1miA+u; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c80167f5716so1873756a12.2
        for <cgroups@vger.kernel.org>; Tue, 19 May 2026 20:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779247867; x=1779852667; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WvjWlQU9BQ5vj94/ZYmURM7q11B4qLRmS+Wh+YSMHqo=;
        b=QA1miA+u6/nOvCFiOxDLPOBkZFTfutiGQpamNhH0Z9lujt2kl0cI+gWkbtNQLw/zBK
         y+3d+ERNkOD8pPTZt6wgS1oLE6piZk0CXvPylvYaHeZM33HL1VPUya5mt2hm1MDF8+mC
         CEDHJ8zHjO3fnEx7LnB5wpdUeASQIM7GotvX5584f2JV/6MryJu1Yqs5xbUJAr/d6fW3
         UZoerX+4pBHPVBvbRFjxqIDNXWcve4fyp8AX57jO6iz8XgcvXDrH/0E/5fQzcknsQEFu
         i+ae6pMkDhAwbxVBtiyN+LOTaFXlJY7otFa9hSq6HSJZOfj5ct2K4W/j1Cdw9ma7/xja
         OYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779247867; x=1779852667;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvjWlQU9BQ5vj94/ZYmURM7q11B4qLRmS+Wh+YSMHqo=;
        b=CsxfQ46yywiMvmCETTPj9vLWfJKpSsG93iwP0bpfhXOWMeyintq9qGRxcFRSt2qMC4
         3eQ2w/hfechtHcqPkKoj+Cm4F8FFRcBzqqNleN7it5Uk7GW7Nes+d81++WCPC68krZaR
         +mQNBM/viNupNLqWN4SrEvUbAn87KYH2U5tcqn2Rik5/rf4NyKdEk/AMRLMTf43mckMO
         ZIGYI93rMTGxEyimGEgY7TRdXjp9KpJ9bx9rfeU5xC0rvo4VhBZmo4PCCf4tK/X94ovn
         bkCjqj49l/v62XyVZw7QYG5qddTI6Rv7IhLQ5nzVLgViFwhnZr+qwLrm8R8pcoJ5qS9v
         oPsg==
X-Gm-Message-State: AOJu0YzfPlyfyMbMJN5+caXP4im3oetkRlvygdw+sezMgJNgSzaMhbO8
	4GUCi1nCeIcq92HicuK2YG2dIFa9LZVvpvbw5/IJnI5VtBgo1Fn1Mn0Y2UA8Cj/+
X-Gm-Gg: Acq92OESWN/SEluGbvhNihLTt1hdYEjxY6qkFGBdmxTHQqAI0VzcEkI+8W/o1HW6f/1
	PDMiJ57Bj5pqpZ0WvSZUkQfks7UYvy+KRYOtvFowU3qBxNqHHuWp+4YHlK/ogF83oBGl/PPA0qI
	02S7A2KylW2AyL4a3OPpTtUHJ8ZfUVFL27zLlDVFRKFK3A/ErqqyVEd5QyK6gyeJ19uUkD1vvYr
	fGe2BakcaAeSJVEadbrXj8q0A2uKqSrvSMksEH4THsPDdVXd8KQFs4GhsTRijA2i3D8LnE2pxa0
	j4T/2BdhCWGQRca3AHWvEipLpEQFv2lTkmocmEBcr+aUqG8wGD/BWnGwmo7tKD7If2tQrhc8Cb5
	WvQDEBOqgLQAEkX+lLLbi8DmD2mbRQQcp6Ih0woM0uTfzxkw5KLPtc/QJ1gwNQ6ixG8SIkxKNXq
	mcY5RM5AEKOmiRB7coZWLJw9g=
X-Received: by 2002:a05:6a20:a120:b0:3a2:ecb8:56d7 with SMTP id adf61e73a8af0-3b22ee96284mr24818211637.45.1779247867364;
        Tue, 19 May 2026 20:31:07 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb1231c7sm18543789a12.31.2026.05.19.20.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 20:31:06 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Wed, 20 May 2026 11:30:54 +0800
Subject: [PATCH] cgroup: rstat: relax NMI guard after switch to try_cmpxchg
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-nmi-v1-1-f2c8f08e4a2b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAO0qDWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMD3bzcTF0DE0vjRENTM0tzQzMloMqCotS0zAqwKdGxtbUARRKuylU
 AAAA=
X-Change-ID: 20260520-nmi-0493a1569716
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779247865; l=2385;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=MkE9oEsiIuagC+yOi3izgicZSC9d2P9EfBhloTtkDo8=;
 b=esOoYUDEjya6CR4hd9fysj0KPGmx7xpfnT2Gg81cU2JJJlwPlhSE0kbz5Ta13k3OPo/bvc6LO
 KKe5P7oLInwCxgJJhGdW1tBXKE2MOT/TGeb4S9OA0fGCTjQUv0nD5Bv
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16103-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shenxiaogll@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 11D8D58747A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe") used
this_cpu_cmpxchg() for the lockless insertion, and therefore required
both ARCH_HAVE_NMI_SAFE_CMPXCHG and ARCH_HAS_NMI_SAFE_THIS_CPU_OPS in
the NMI guard: on archs without the latter, this_cpu_cmpxchg() falls
back to "local_irq_save() + plain cmpxchg", and local_irq_save()
cannot mask NMIs.

Commit 3309b63a2281 ("cgroup: rstat: use LOCK CMPXCHG in
css_rstat_updated") later replaced this_cpu_cmpxchg() with plain
try_cmpxchg() to fix cross-CPU lockless-list corruption, but left the
NMI guard untouched.  After that switch, css_rstat_updated() no longer
performs any this_cpu_*() RMW operations and only relies on the arch
having NMI-safe cmpxchg, so ARCH_HAS_NMI_SAFE_THIS_CPU_OPS is no
longer required in the guard.

Relax the guard accordingly so that archs which have HAVE_NMI and
ARCH_HAVE_NMI_SAFE_CMPXCHG but not ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
(e.g. sparc, powerpc on PPC64/BOOK3S) can benefit from the existing
CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC path.  Without this, the css
is never queued in NMI on those archs, and the atomics staged by
account_{slab,kmem}_nmi_safe() are not drained by flush_nmi_stats().

Fixes: 3309b63a2281 ("cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated")
Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
---
 kernel/cgroup/rstat.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 150e5871e66f..fa46611098a5 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -83,11 +83,10 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	lockdep_assert_preemption_disabled();
 
 	/*
-	 * For archs withnot nmi safe cmpxchg or percpu ops support, ignore
-	 * the requests from nmi context.
+	 * The lockless insertion below relies on NMI-safe cmpxchg;
+	 * bail out in NMI on archs that don't provide it.
 	 */
-	if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
-	     !IS_ENABLED(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS)) && in_nmi())
+	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) && in_nmi())
 		return;
 
 	rstatc = css_rstat_cpu(css, cpu);

---
base-commit: 27fa82620cbaa89a7fc11ac3057701d598813e87
change-id: 20260520-nmi-0493a1569716

Best regards,
-- 
Cunlong Li <shenxiaogll@gmail.com>


