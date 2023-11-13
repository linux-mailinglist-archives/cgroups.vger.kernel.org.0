Return-Path: <cgroups+bounces-354-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905A07EA379
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1C5280F14
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C169B23759;
	Mon, 13 Nov 2023 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aPJLjdUI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cs8sRMut"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936AF23752
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:14 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965BF171A;
	Mon, 13 Nov 2023 11:14:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 116C31F85D;
	Mon, 13 Nov 2023 19:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZpP3yTw5ZZBFa2ECQqDZfpxxgpcXUank5jkC+X3eYo=;
	b=aPJLjdUI8hKVcvhpJwk5gEbY624MQiQFCDOYdgBwSCjd41pCB1KETdbV2uRpmIDNKx233o
	0mqz3dSDh0+f1jgHWQFD/k9MWDWW6jJ1beMZl5N0JzcgmTTx1yOFBC1QJ+Vjea6Yfgc6Th
	45+Vv1z+SdDlZ/rbg37SCItabUbCC1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZpP3yTw5ZZBFa2ECQqDZfpxxgpcXUank5jkC+X3eYo=;
	b=Cs8sRMut++fgm4qFb0T1IW1oy5KIMJWGr5+E9MhgTZbWKEv7hsN8c7F9GoQrGWIhgi9Yw8
	6/UkVL069in7bCAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B52FB13907;
	Mon, 13 Nov 2023 19:14:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cOyQK4J1UmVFOgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 05/20] cpu/hotplug: remove CPUHP_SLAB_PREPARE hooks
Date: Mon, 13 Nov 2023 20:13:46 +0100
Message-ID: <20231113191340.17482-27-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113191340.17482-22-vbabka@suse.cz>
References: <20231113191340.17482-22-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPUHP_SLAB_PREPARE hooks are only used by SLAB which is removed.
SLUB defines them as NULL, so we can remove those altogether.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 8 --------
 kernel/cpu.c         | 5 -----
 2 files changed, 13 deletions(-)

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


