Return-Path: <cgroups+bounces-482-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F57F1C94
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 19:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DA01C218DD
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 18:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996830FBA;
	Mon, 20 Nov 2023 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lskh8+Nj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JQZpJQ9Q"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDC5D8;
	Mon, 20 Nov 2023 10:34:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9DB51F8A6;
	Mon, 20 Nov 2023 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700505281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nuh5DWhwaSyo20acRrWx07FPXsn5IPuIhuzYTBlJYws=;
	b=lskh8+NjK84cZG7SqKSCZ3eO/1MD4vKkfHBAshUThScOC2oN+kMYJ8x9sYozYLNmkzrd3A
	LxQPABh9kQLuS0d+9TV0Q2NyivMyMU8lu39fMN/UrdjCZBe7zgHDJuSxiIyEYpyEqEHic4
	Bw8gBimBBkAowKVXEpP+Gc+OyuPIHg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700505281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nuh5DWhwaSyo20acRrWx07FPXsn5IPuIhuzYTBlJYws=;
	b=JQZpJQ9QP2ykM79Wrgq2dvV7Adexjb5rfIKIGaG+WP3EYoAutlKPhZK2HTY7mb4eToR1YJ
	af8qGS6UtGLnEjDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B55FE13912;
	Mon, 20 Nov 2023 18:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UAbTK8CmW2UUMgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 20 Nov 2023 18:34:40 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 20 Nov 2023 19:34:17 +0100
Subject: [PATCH v2 06/21] cpu/hotplug: remove CPUHP_SLAB_PREPARE hooks
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-slab-remove-slab-v2-6-9c9c70177183@suse.cz>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
In-Reply-To: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
To: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, 
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Marco Elver <elver@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Kees Cook <keescook@chromium.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.12.4
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL563rtnmcmc9sawm86hmgtctc)];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-0.00)[15.84%];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.dev,google.com,arm.com,cmpxchg.org,kernel.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com,suse.cz];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

The CPUHP_SLAB_PREPARE hooks are only used by SLAB which is removed.
SLUB defines them as NULL, so we can remove those altogether.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/cpuhotplug.h | 1 -
 include/linux/slab.h       | 8 --------
 kernel/cpu.c               | 5 -----
 3 files changed, 14 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index d305db70674b..07cb8f7030b6 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -108,7 +108,6 @@ enum cpuhp_state {
 	CPUHP_X2APIC_PREPARE,
 	CPUHP_SMPCFD_PREPARE,
 	CPUHP_RELAY_PREPARE,
-	CPUHP_SLAB_PREPARE,
 	CPUHP_MD_RAID5_PREPARE,
 	CPUHP_RCUTREE_PREP,
 	CPUHP_CPUIDLE_COUPLED_PREPARE,
diff --git a/include/linux/slab.h b/include/linux/slab.h
index d6d6ffeeb9a2..34e43cddc520 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -788,12 +788,4 @@ size_t kmalloc_size_roundup(size_t size);
 
 void __init kmem_cache_init_late(void);
 
-#if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
-int slab_prepare_cpu(unsigned int cpu);
-int slab_dead_cpu(unsigned int cpu);
-#else
-#define slab_prepare_cpu	NULL
-#define slab_dead_cpu		NULL
-#endif
-
 #endif	/* _LINUX_SLAB_H */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9e4c6780adde..530b026d95a1 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2125,11 +2125,6 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= relay_prepare_cpu,
 		.teardown.single	= NULL,
 	},
-	[CPUHP_SLAB_PREPARE] = {
-		.name			= "slab:prepare",
-		.startup.single		= slab_prepare_cpu,
-		.teardown.single	= slab_dead_cpu,
-	},
 	[CPUHP_RCUTREE_PREP] = {
 		.name			= "RCU/tree:prepare",
 		.startup.single		= rcutree_prepare_cpu,

-- 
2.42.1


