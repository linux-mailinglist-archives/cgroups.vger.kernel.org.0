Return-Path: <cgroups+bounces-359-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC9A7EA384
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC36EB20C04
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F34B241E6;
	Mon, 13 Nov 2023 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X1zStBcu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7Ue2H1I0"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B12375C
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:17 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7D11727;
	Mon, 13 Nov 2023 11:14:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37E401F88D;
	Mon, 13 Nov 2023 19:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Pl3hBxZTqS7t6wbtH0Om8A7aicbQgQuPXay4H9gSiM=;
	b=X1zStBcucLDp7WpLf93CvypzJkg224MuMGfGMtRudRFzgQHf18v/tbV1wyz1utEH4Kx9ur
	5teIxEU6gfdFQSp3bqY6arFrcdOdBAZsHhrOLN9IkEWofP509kx075uiTpHKfdsSP1f/ei
	OFSLSHBOTKxRVbmTKpn0mOziI7DX8vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Pl3hBxZTqS7t6wbtH0Om8A7aicbQgQuPXay4H9gSiM=;
	b=7Ue2H1I0sTX6CLyuq/0bLGA2DY+hI6S3LLF/VGrteCc7gKBnRxO0qsOahDmsdbPnwvPhcw
	zEwQvnlEhvqMysCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCED513907;
	Mon, 13 Nov 2023 19:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id OPcxNYR1UmVFOgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:12 +0000
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
Subject: [PATCH 11/20] mm/slab: consolidate includes in the internal mm/slab.h
Date: Mon, 13 Nov 2023 20:13:52 +0100
Message-ID: <20231113191340.17482-33-vbabka@suse.cz>
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

The #include's are scattered at several places of the file, but it does
not seem this is needed to prevent any include loops (anymore?) so
consolidate them at the top. Also move the misplaced kmem_cache_init()
declaration away from the top.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 6e76216ac74e..c278f8b15251 100644
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
 #define slub_percpu_partial(c)		((c)->partial)
 
@@ -346,14 +353,6 @@ static inline int objs_per_slab(const struct kmem_cache *cache,
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
@@ -404,6 +403,7 @@ gfp_t kmalloc_fix_flags(gfp_t flags);
 /* Functions provided by the slab allocators */
 int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
 
+void __init kmem_cache_init(void);
 void __init new_kmalloc_cache(int idx, enum kmalloc_cache_type type,
 			      slab_flags_t flags);
 extern void create_boot_cache(struct kmem_cache *, const char *name,
-- 
2.42.1


