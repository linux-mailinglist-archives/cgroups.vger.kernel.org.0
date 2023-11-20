Return-Path: <cgroups+bounces-490-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D317F1CA1
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 19:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7B52816F2
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 18:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A3D32182;
	Mon, 20 Nov 2023 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dMBs6gEI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dYagauic"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A567DF9;
	Mon, 20 Nov 2023 10:34:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 453B31F8AF;
	Mon, 20 Nov 2023 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700505282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OA8hmbuH8MxWfLH+c2HkYn0Z7Eu4RuF14fgas75tZs=;
	b=dMBs6gEI5Ex4jL6H129zRPTwlSNnJ1qC8oVF5wBujjyOkDMCeCG9OYEJj8x8abL8uJN/1j
	3ZsKxuxyBTo1FBvzQTZKbSx6bfKtSEqolZGVksbl+7ENXSk2UXedzeobvBoh1iaHgfDyD7
	H4UhCy8bCZZNTZB0BsOg/4oBmwpstnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700505282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OA8hmbuH8MxWfLH+c2HkYn0Z7Eu4RuF14fgas75tZs=;
	b=dYagauickYxH+NAtnsoubj/I4t2hRXY+jEoJ04i+dfBEY9kZnPN+7H+HkIhfKp/ZC2orGs
	EYCkAZqEh2MwR6CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 166FF13499;
	Mon, 20 Nov 2023 18:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iLgFBcKmW2UUMgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 20 Nov 2023 18:34:42 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 20 Nov 2023 19:34:23 +0100
Subject: [PATCH v2 12/21] mm/slab: consolidate includes in the internal
 mm/slab.h
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-slab-remove-slab-v2-12-9c9c70177183@suse.cz>
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
X-Spam-Score: 1.30
X-Spamd-Result: default: False [1.30 / 50.00];
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
	 BAYES_SPAM(5.10)[99.99%];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.dev,google.com,arm.com,cmpxchg.org,kernel.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com,suse.cz];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

The #include's are scattered at several places of the file, but it does
not seem this is needed to prevent any include loops (anymore?) so
consolidate them at the top. Also move the misplaced kmem_cache_init()
declaration away from the top.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 3a8d13c099fa..1ac3a2f8d4c0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -1,10 +1,22 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef MM_SLAB_H
 #define MM_SLAB_H
+
+#include <linux/reciprocal_div.h>
+#include <linux/list_lru.h>
+#include <linux/local_lock.h>
+#include <linux/random.h>
+#include <linux/kobject.h>
+#include <linux/sched/mm.h>
+#include <linux/memcontrol.h>
+#include <linux/fault-inject.h>
+#include <linux/kmemleak.h>
+#include <linux/kfence.h>
+#include <linux/kasan.h>
+
 /*
  * Internal slab definitions
  */
-void __init kmem_cache_init(void);
 
 #ifdef CONFIG_64BIT
 # ifdef system_has_cmpxchg128
@@ -209,11 +221,6 @@ static inline size_t slab_size(const struct slab *slab)
 	return PAGE_SIZE << slab_order(slab);
 }
 
-#include <linux/kfence.h>
-#include <linux/kobject.h>
-#include <linux/reciprocal_div.h>
-#include <linux/local_lock.h>
-
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 #define slub_percpu_partial(c)			((c)->partial)
 
@@ -347,14 +354,6 @@ static inline int objs_per_slab(const struct kmem_cache *cache,
 	return slab->objects;
 }
 
-#include <linux/memcontrol.h>
-#include <linux/fault-inject.h>
-#include <linux/kasan.h>
-#include <linux/kmemleak.h>
-#include <linux/random.h>
-#include <linux/sched/mm.h>
-#include <linux/list_lru.h>
-
 /*
  * State of the slab allocator.
  *
@@ -405,6 +404,7 @@ gfp_t kmalloc_fix_flags(gfp_t flags);
 /* Functions provided by the slab allocators */
 int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
 
+void __init kmem_cache_init(void);
 void __init new_kmalloc_cache(int idx, enum kmalloc_cache_type type,
 			      slab_flags_t flags);
 extern void create_boot_cache(struct kmem_cache *, const char *name,

-- 
2.42.1


