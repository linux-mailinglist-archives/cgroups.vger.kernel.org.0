Return-Path: <cgroups+bounces-15144-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA1QFq/+zGnRYgYAu9opvQ
	(envelope-from <cgroups+bounces-15144-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 13:17:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B985037939C
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A657E3067F84
	for <lists+cgroups@lfdr.de>; Wed,  1 Apr 2026 11:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C599406267;
	Wed,  1 Apr 2026 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXQLeJrf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12322364EBA;
	Wed,  1 Apr 2026 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041178; cv=none; b=LyO32HettfJRBAVaj7B/KMpRrkxEGUxh7T6f/dbBtDi1yAGsZAGlfjOG1acX9Joi8Q9dKzI707Rfw3779kRGUo1KGeMbXqEPiutQxnRW0qHjxCUu+JS+wiqmZkqT7DFGAvT+8hmCDTO9Z4k13wXDjp3BGW4srI5jhIZEgqnwAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041178; c=relaxed/simple;
	bh=V3NiXFa+DcKU6FeTJQXPryQ0JM5sL8MdAtGm+sxtMqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mxxVO2szf9jTg/ziovXtJ7UERbm+nzVx3Y0q0wrUNvIKOgSommCvDjewSa4nDoJzIpF+FtcMMJIsj8q91qQAOn8uNxMw4o0cfo8ELl3gJHzVV/0Mm83MBtyFKyEFZpvQKF9GkOhQvBkVAVyrJdIZR+/JCXdIyL2U0kV7GnOMTgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXQLeJrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5B7C4CEF7;
	Wed,  1 Apr 2026 10:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775041177;
	bh=V3NiXFa+DcKU6FeTJQXPryQ0JM5sL8MdAtGm+sxtMqk=;
	h=From:Date:Subject:To:Cc:From;
	b=DXQLeJrfRHtdM3Pq8pLxg09G+DoV/o+HMYzzo8gseVm/Er7qdI4w3l9bfj/qGz6Js
	 JZ8cr0JtjHv64wlsDBy4527/wIUzG8MW2kcDEOn3KXQ0WsklclbEIf2FEAPbDxIOlX
	 cuuM3kOhiegzgRxSLGYX4o4AtPfxjoyBWSm6lMswaWUTJG/mFCHCRP/8hztIMCaalI
	 Z/AH6QiJBLOxdin602Wxq/Y/ZY/pwN+woCww2vUYQtd22XPJ+IqZ5xXpaLvwa08YtM
	 ihGf8m/UKV4JSV13EsvLrC9AQViHKOpFFkn/0SF5I2H3OnoKN03mpj35+vdj8DYM3I
	 aCEFUgzGvQ72g==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 01 Apr 2026 12:59:29 +0200
Subject: [PATCH] slab: remove the SLUB_DEBUG functionality and config
 option
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-b4-are-you-serious-v1-1-dcacda70647d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJD6zGkC/yXMQQ6DIBBA0auYWXcSBKKtV2lcoB3sdCGGEaMx3
 L3YLt/i/xOEIpNAV50QaWPhMBfUtwrGt5snQn4Vg1a6UVbVOFh0kfAICa80JMHGPIy+W2+pVVD
 CJZLn/Td99n9LGj40rtcJcv4CAvrNHHYAAAA=
X-Change-ID: 20260401-b4-are-you-serious-6393284f4e70
To: Andrew Morton <akpm@linux-foundation.org>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 David Hildenbrand <david@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Harry Yoo <harry@kernel.org>
Cc: Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Jann Horn <jannh@google.com>, 
 Matthew Wilcox <willy@infradead.org>, Petr Tesarik <ptesarik@suse.com>, 
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, cgroups@vger.kernel.org, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15144-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,gmail.com,kernel.org,cmpxchg.org,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,arm.com,kernel.org,oracle.com,linux.dev,gentwo.org,suse.de,infradead.org,suse.com,vger.kernel.org,googlegroups.com,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.722];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B985037939C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The boot-time enabled per-cache debugging has served us well in the
past, but it's time for it to go, for the following reasons.

- It's a debugging feature. However, thanks to the advent of LLM-based
  reviews, we are not adding bugs to the kernel anymore, so it's
  unnecessary now.

- KASAN is more powerful anyway for the classes of bugs that SLUB_DEBUG
  can catch. But I suspect KASAN is likely to be removed soon too, see
  above.

- SLAB never had no such dynamic debugging functionality. With the
  introduction of sheaves percpu caching, we have turned SLUB back into
  SLAB partially, so this just follows that direction.

- It's removing ~2500 lines of code and I want to keep my overal
  diffstats negative. This adds a nice margin.

Since the slub kunit test depends on SLUB_DEBUG, remove it too. It's not
a big loss, see the first point above.

Singed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 lib/Kconfig.debug      |   12 -
 lib/Kconfig.kasan      |    2 -
 lib/tests/Makefile     |    1 -
 lib/tests/slub_kunit.c |  329 --------
 mm/Kconfig.debug       |   60 --
 mm/dmapool.c           |    4 -
 mm/memcontrol-v1.c     |   17 -
 mm/mempool.c           |  105 ---
 mm/slab.h              |   34 -
 mm/slub.c              | 2074 +-----------------------------------------------
 10 files changed, 43 insertions(+), 2595 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 93f356d2b3d9..f522f55d229f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2942,18 +2942,6 @@ config BITS_TEST
 
 	  If unsure, say N.
 
-config SLUB_KUNIT_TEST
-	tristate "KUnit test for SLUB cache error detection" if !KUNIT_ALL_TESTS
-	depends on SLUB_DEBUG && KUNIT
-	default KUNIT_ALL_TESTS
-	help
-	  This builds SLUB allocator unit test.
-	  Tests SLUB cache debugging functionality.
-	  For more information on KUnit and unit tests in general please refer
-	  to the KUnit documentation in Documentation/dev-tools/kunit/.
-
-	  If unsure, say N.
-
 config RATIONAL_KUNIT_TEST
 	tristate "KUnit test for rational.c" if !KUNIT_ALL_TESTS
 	depends on KUNIT && RATIONAL
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index a4bb610a7a6f..62fae96db1b1 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -90,7 +90,6 @@ config KASAN_GENERIC
 	bool "Generic KASAN"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
-	select SLUB_DEBUG
 	select CONSTRUCTORS
 	help
 	  Enables Generic KASAN.
@@ -105,7 +104,6 @@ config KASAN_SW_TAGS
 	bool "Software Tag-Based KASAN"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
-	select SLUB_DEBUG
 	select CONSTRUCTORS
 	help
 	  Enables Software Tag-Based KASAN.
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 05f74edbc62b..459b675b3c68 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_RANDSTRUCT_KUNIT_TEST) += randstruct_kunit.o
 obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
 obj-$(CONFIG_SEQ_BUF_KUNIT_TEST) += seq_buf_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
-obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
 obj-$(CONFIG_TEST_SORT) += test_sort.o
 CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
 obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
deleted file mode 100644
index 848b682a2d70..000000000000
--- a/lib/tests/slub_kunit.c
+++ /dev/null
@@ -1,329 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <kunit/test.h>
-#include <kunit/test-bug.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/rcupdate.h>
-#include <linux/delay.h>
-#include "../mm/slab.h"
-
-static struct kunit_resource resource;
-static int slab_errors;
-
-/*
- * Wrapper function for kmem_cache_create(), which reduces 2 parameters:
- * 'align' and 'ctor', and sets SLAB_SKIP_KFENCE flag to avoid getting an
- * object from kfence pool, where the operation could be caught by both
- * our test and kfence sanity check.
- */
-static struct kmem_cache *test_kmem_cache_create(const char *name,
-				unsigned int size, slab_flags_t flags)
-{
-	struct kmem_cache *s = kmem_cache_create(name, size, 0,
-					(flags | SLAB_NO_USER_FLAGS), NULL);
-	s->flags |= SLAB_SKIP_KFENCE;
-	return s;
-}
-
-static void test_clobber_zone(struct kunit *test)
-{
-	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_alloc", 64,
-							SLAB_RED_ZONE);
-	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
-
-	kasan_disable_current();
-	p[64] = 0x12;
-
-	validate_slab_cache(s);
-	KUNIT_EXPECT_EQ(test, 2, slab_errors);
-
-	kasan_enable_current();
-	kmem_cache_free(s, p);
-	kmem_cache_destroy(s);
-}
-
-#ifndef CONFIG_KASAN
-static void test_next_pointer(struct kunit *test)
-{
-	struct kmem_cache *s = test_kmem_cache_create("TestSlub_next_ptr_free",
-							64, SLAB_POISON);
-	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
-	unsigned long tmp;
-	unsigned long *ptr_addr;
-
-	kmem_cache_free(s, p);
-
-	ptr_addr = (unsigned long *)(p + s->offset);
-	tmp = *ptr_addr;
-	p[s->offset] = ~p[s->offset];
-
-	/*
-	 * Expecting three errors.
-	 * One for the corrupted freechain and the other one for the wrong
-	 * count of objects in use. The third error is fixing broken cache.
-	 */
-	validate_slab_cache(s);
-	KUNIT_EXPECT_EQ(test, 3, slab_errors);
-
-	/*
-	 * Try to repair corrupted freepointer.
-	 * Still expecting two errors. The first for the wrong count
-	 * of objects in use.
-	 * The second error is for fixing broken cache.
-	 */
-	*ptr_addr = tmp;
-	slab_errors = 0;
-
-	validate_slab_cache(s);
-	KUNIT_EXPECT_EQ(test, 2, slab_errors);
-
-	/*
-	 * Previous validation repaired the count of objects in use.
-	 * Now expecting no error.
-	 */
-	slab_errors = 0;
-	validate_slab_cache(s);
-	KUNIT_EXPECT_EQ(test, 0, slab_errors);
-
-	kmem_cache_destroy(s);
-}
-
-static void test_first_word(struct kunit *test)
-{
-	struct kmem_cache *s = test_kmem_cache_create("TestSlub_1th_word_free",
-							64, SLAB_POISON);
-	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
-
-	kmem_cache_free(s, p);
-	*p = 0x78;
-
-	validate_slab_cache(s);
-	KUNIT_EXPECT_EQ(test, 2, slab_errors);
-
-	kmem_cache_destroy(s);
-}
-
-static void test_clobber_50th_byte(struct kunit *test)
-{
-	struct kmem_cache *s = test_kmem_cache_create("TestSlub_50th_word_free",
-							64, SLAB_POISON);
-	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
-
-	kmem_cache_free(s, p);
-	p[50] = 0x9a;
-
-	validate_slab_cache(s);
-	KUNIT_EXPECT_EQ(test, 2, slab_errors);
-
-	kmem_cache_destroy(s);
-}
-#endif
-
-static void test_clobber_redzone_free(struct kunit *test)
-{
-	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_free", 64,
-							SLAB_RED_ZONE);
-	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
-
-	kasan_disable_current();
-	kmem_cache_free(s, p);
-	p[64] = 0xab;
-
-	validate_slab_cache(s);
-	KUNIT_EXPECT_EQ(test, 2, slab_errors);
-
-	kasan_enable_current();
-	kmem_cache_destroy(s);
-}
-
-static void test_kmalloc_redzone_access(struct kunit *test)
-{
-	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
-				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
-	u8 *p = alloc_hooks(__kmalloc_cache_noprof(s, GFP_KERNEL, 18));
-
-	kasan_disable_current();
-
-	/* Suppress the -Warray-bounds warning */
-	OPTIMIZER_HIDE_VAR(p);
-	p[18] = 0xab;
-	p[19] = 0xab;
-
-	validate_slab_cache(s);
-	KUNIT_EXPECT_EQ(test, 2, slab_errors);
-
-	kasan_enable_current();
-	kmem_cache_free(s, p);
-	kmem_cache_destroy(s);
-}
-
-struct test_kfree_rcu_struct {
-	struct rcu_head rcu;
-};
-
-static void test_kfree_rcu(struct kunit *test)
-{
-	struct kmem_cache *s;
-	struct test_kfree_rcu_struct *p;
-
-	if (IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST))
-		kunit_skip(test, "can't do kfree_rcu() when test is built-in");
-
-	s = test_kmem_cache_create("TestSlub_kfree_rcu",
-				   sizeof(struct test_kfree_rcu_struct),
-				   SLAB_NO_MERGE);
-	p = kmem_cache_alloc(s, GFP_KERNEL);
-
-	kfree_rcu(p, rcu);
-	kmem_cache_destroy(s);
-
-	KUNIT_EXPECT_EQ(test, 0, slab_errors);
-}
-
-struct cache_destroy_work {
-	struct work_struct work;
-	struct kmem_cache *s;
-};
-
-static void cache_destroy_workfn(struct work_struct *w)
-{
-	struct cache_destroy_work *cdw;
-
-	cdw = container_of(w, struct cache_destroy_work, work);
-	kmem_cache_destroy(cdw->s);
-}
-
-#define KMEM_CACHE_DESTROY_NR 10
-
-static void test_kfree_rcu_wq_destroy(struct kunit *test)
-{
-	struct test_kfree_rcu_struct *p;
-	struct cache_destroy_work cdw;
-	struct workqueue_struct *wq;
-	struct kmem_cache *s;
-	unsigned int delay;
-	int i;
-
-	if (IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST))
-		kunit_skip(test, "can't do kfree_rcu() when test is built-in");
-
-	INIT_WORK_ONSTACK(&cdw.work, cache_destroy_workfn);
-	wq = alloc_workqueue("test_kfree_rcu_destroy_wq",
-			WQ_HIGHPRI | WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
-
-	if (!wq)
-		kunit_skip(test, "failed to alloc wq");
-
-	for (i = 0; i < KMEM_CACHE_DESTROY_NR; i++) {
-		s = test_kmem_cache_create("TestSlub_kfree_rcu_wq_destroy",
-				sizeof(struct test_kfree_rcu_struct),
-				SLAB_NO_MERGE);
-
-		if (!s)
-			kunit_skip(test, "failed to create cache");
-
-		delay = get_random_u8();
-		p = kmem_cache_alloc(s, GFP_KERNEL);
-		kfree_rcu(p, rcu);
-
-		cdw.s = s;
-
-		msleep(delay);
-		queue_work(wq, &cdw.work);
-		flush_work(&cdw.work);
-	}
-
-	destroy_workqueue(wq);
-	KUNIT_EXPECT_EQ(test, 0, slab_errors);
-}
-
-static void test_leak_destroy(struct kunit *test)
-{
-	struct kmem_cache *s = test_kmem_cache_create("TestSlub_leak_destroy",
-							64, SLAB_NO_MERGE);
-	kmem_cache_alloc(s, GFP_KERNEL);
-
-	kmem_cache_destroy(s);
-
-	KUNIT_EXPECT_EQ(test, 2, slab_errors);
-}
-
-static void test_krealloc_redzone_zeroing(struct kunit *test)
-{
-	u8 *p;
-	int i;
-	struct kmem_cache *s = test_kmem_cache_create("TestSlub_krealloc", 64,
-				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
-
-	p = alloc_hooks(__kmalloc_cache_noprof(s, GFP_KERNEL, 48));
-	memset(p, 0xff, 48);
-
-	kasan_disable_current();
-	OPTIMIZER_HIDE_VAR(p);
-
-	/* Test shrink */
-	p = krealloc(p, 40, GFP_KERNEL | __GFP_ZERO);
-	for (i = 40; i < 64; i++)
-		KUNIT_EXPECT_EQ(test, p[i], SLUB_RED_ACTIVE);
-
-	/* Test grow within the same 64B kmalloc object */
-	p = krealloc(p, 56, GFP_KERNEL | __GFP_ZERO);
-	for (i = 40; i < 56; i++)
-		KUNIT_EXPECT_EQ(test, p[i], 0);
-	for (i = 56; i < 64; i++)
-		KUNIT_EXPECT_EQ(test, p[i], SLUB_RED_ACTIVE);
-
-	validate_slab_cache(s);
-	KUNIT_EXPECT_EQ(test, 0, slab_errors);
-
-	memset(p, 0xff, 56);
-	/* Test grow with allocating a bigger 128B object */
-	p = krealloc(p, 112, GFP_KERNEL | __GFP_ZERO);
-	for (i = 0; i < 56; i++)
-		KUNIT_EXPECT_EQ(test, p[i], 0xff);
-	for (i = 56; i < 112; i++)
-		KUNIT_EXPECT_EQ(test, p[i], 0);
-
-	kfree(p);
-	kasan_enable_current();
-	kmem_cache_destroy(s);
-}
-
-static int test_init(struct kunit *test)
-{
-	slab_errors = 0;
-
-	kunit_add_named_resource(test, NULL, NULL, &resource,
-					"slab_errors", &slab_errors);
-	return 0;
-}
-
-static struct kunit_case test_cases[] = {
-	KUNIT_CASE(test_clobber_zone),
-
-#ifndef CONFIG_KASAN
-	KUNIT_CASE(test_next_pointer),
-	KUNIT_CASE(test_first_word),
-	KUNIT_CASE(test_clobber_50th_byte),
-#endif
-
-	KUNIT_CASE(test_clobber_redzone_free),
-	KUNIT_CASE(test_kmalloc_redzone_access),
-	KUNIT_CASE(test_kfree_rcu),
-	KUNIT_CASE(test_kfree_rcu_wq_destroy),
-	KUNIT_CASE(test_leak_destroy),
-	KUNIT_CASE(test_krealloc_redzone_zeroing),
-	{}
-};
-
-static struct kunit_suite test_suite = {
-	.name = "slub_test",
-	.init = test_init,
-	.test_cases = test_cases,
-};
-kunit_test_suite(test_suite);
-
-MODULE_DESCRIPTION("Kunit tests for slub allocator");
-MODULE_LICENSE("GPL");
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 7638d75b27db..2ab091043775 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -45,63 +45,6 @@ config DEBUG_PAGEALLOC_ENABLE_DEFAULT
 	  Enable debug page memory allocations by default? This value
 	  can be overridden by debug_pagealloc=off|on.
 
-config SLUB_DEBUG
-	default y
-	bool "Enable SLUB debugging support" if EXPERT
-	depends on SYSFS && !SLUB_TINY
-	select STACKDEPOT if STACKTRACE_SUPPORT
-	help
-	  SLUB has extensive debug support features. Disabling these can
-	  result in significant savings in code size. While /sys/kernel/slab
-	  will still exist (with SYSFS enabled), it will not provide e.g. cache
-	  validation.
-
-config SLUB_DEBUG_ON
-	bool "SLUB debugging on by default"
-	depends on SLUB_DEBUG
-	select STACKDEPOT_ALWAYS_INIT if STACKTRACE_SUPPORT
-	default n
-	help
-	  Boot with debugging on by default. SLUB boots by default with
-	  the runtime debug capabilities switched off. Enabling this is
-	  equivalent to specifying the "slab_debug" parameter on boot.
-	  There is no support for more fine grained debug control like
-	  possible with slab_debug=xxx. SLUB debugging may be switched
-	  off in a kernel built with CONFIG_SLUB_DEBUG_ON by specifying
-	  "slab_debug=-".
-
-config SLUB_RCU_DEBUG
-	bool "Enable UAF detection in TYPESAFE_BY_RCU caches (for KASAN)"
-	depends on SLUB_DEBUG
-	# SLUB_RCU_DEBUG should build fine without KASAN, but is currently useless
-	# without KASAN, so mark it as a dependency of KASAN for now.
-	depends on KASAN
-	default KASAN_GENERIC || KASAN_SW_TAGS
-	help
-	  Make SLAB_TYPESAFE_BY_RCU caches behave approximately as if the cache
-	  was not marked as SLAB_TYPESAFE_BY_RCU and every caller used
-	  kfree_rcu() instead.
-
-	  This is intended for use in combination with KASAN, to enable KASAN to
-	  detect use-after-free accesses in such caches.
-	  (KFENCE is able to do that independent of this flag.)
-
-	  This might degrade performance.
-	  Unfortunately this also prevents a very specific bug pattern from
-	  triggering (insufficient checks against an object being recycled
-	  within the RCU grace period); so this option can be turned off even on
-	  KASAN builds, in case you want to test for such a bug.
-
-	  If you're using this for testing bugs / fuzzing and care about
-	  catching all the bugs WAY more than performance, you might want to
-	  also turn on CONFIG_RCU_STRICT_GRACE_PERIOD.
-
-	  WARNING:
-	  This is designed as a debugging feature, not a security feature.
-	  Objects are sometimes recycled without RCU delay under memory pressure.
-
-	  If unsure, say N.
-
 config PAGE_OWNER
 	bool "Track page owner"
 	depends on DEBUG_KERNEL && STACKTRACE_SUPPORT
@@ -256,9 +199,6 @@ config DEBUG_KMEMLEAK
 	  allocations. See Documentation/dev-tools/kmemleak.rst for more
 	  details.
 
-	  Enabling SLUB_DEBUG may increase the chances of finding leaks
-	  due to the slab objects poisoning.
-
 	  In order to access the kmemleak file, debugfs needs to be
 	  mounted (usually at /sys/kernel/debug).
 
diff --git a/mm/dmapool.c b/mm/dmapool.c
index 5d8af6e29127..53c3039c2645 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -36,10 +36,6 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 
-#ifdef CONFIG_SLUB_DEBUG_ON
-#define DMAPOOL_DEBUG 1
-#endif
-
 struct dma_block {
 	struct dma_block *next_block;
 	dma_addr_t dma;
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 597af8a80163..534b891d2540 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2018,17 +2018,6 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 	return 0;
 }
 
-#ifdef CONFIG_SLUB_DEBUG
-static int mem_cgroup_slab_show(struct seq_file *m, void *p)
-{
-	/*
-	 * Deprecated.
-	 * Please, take a look at tools/cgroup/memcg_slabinfo.py .
-	 */
-	return 0;
-}
-#endif
-
 struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "usage_in_bytes",
@@ -2125,12 +2114,6 @@ struct cftype mem_cgroup_legacy_files[] = {
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
-#ifdef CONFIG_SLUB_DEBUG
-	{
-		.name = "kmem.slabinfo",
-		.seq_show = mem_cgroup_slab_show,
-	},
-#endif
 	{
 		.name = "kmem.tcp.limit_in_bytes",
 		.private = MEMFILE_PRIVATE(_TCP, RES_LIMIT),
diff --git a/mm/mempool.c b/mm/mempool.c
index db23e0eef652..ca9554d64c61 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -37,117 +37,12 @@ static int __init mempool_faul_inject_init(void)
 }
 late_initcall(mempool_faul_inject_init);
 
-#ifdef CONFIG_SLUB_DEBUG_ON
-static void poison_error(struct mempool *pool, void *element, size_t size,
-			 size_t byte)
-{
-	const int nr = pool->curr_nr;
-	const int start = max_t(int, byte - (BITS_PER_LONG / 8), 0);
-	const int end = min_t(int, byte + (BITS_PER_LONG / 8), size);
-	int i;
-
-	pr_err("BUG: mempool element poison mismatch\n");
-	pr_err("Mempool %p size %zu\n", pool, size);
-	pr_err(" nr=%d @ %p: %s0x", nr, element, start > 0 ? "... " : "");
-	for (i = start; i < end; i++)
-		pr_cont("%x ", *(u8 *)(element + i));
-	pr_cont("%s\n", end < size ? "..." : "");
-	dump_stack();
-}
-
-static void __check_element(struct mempool *pool, void *element, size_t size)
-{
-	u8 *obj = element;
-	size_t i;
-
-	for (i = 0; i < size; i++) {
-		u8 exp = (i < size - 1) ? POISON_FREE : POISON_END;
-
-		if (obj[i] != exp) {
-			poison_error(pool, element, size, i);
-			return;
-		}
-	}
-	memset(obj, POISON_INUSE, size);
-}
-
-static void check_element(struct mempool *pool, void *element)
-{
-	/* Skip checking: KASAN might save its metadata in the element. */
-	if (kasan_enabled())
-		return;
-
-	/* Mempools backed by slab allocator */
-	if (pool->free == mempool_kfree) {
-		__check_element(pool, element, (size_t)pool->pool_data);
-	} else if (pool->free == mempool_free_slab) {
-		__check_element(pool, element, kmem_cache_size(pool->pool_data));
-	} else if (pool->free == mempool_free_pages) {
-		/* Mempools backed by page allocator */
-		int order = (int)(long)pool->pool_data;
-
-#ifdef CONFIG_HIGHMEM
-		for (int i = 0; i < (1 << order); i++) {
-			struct page *page = (struct page *)element;
-			void *addr = kmap_local_page(page + i);
-
-			__check_element(pool, addr, PAGE_SIZE);
-			kunmap_local(addr);
-		}
-#else
-		void *addr = page_address((struct page *)element);
-
-		__check_element(pool, addr, PAGE_SIZE << order);
-#endif
-	}
-}
-
-static void __poison_element(void *element, size_t size)
-{
-	u8 *obj = element;
-
-	memset(obj, POISON_FREE, size - 1);
-	obj[size - 1] = POISON_END;
-}
-
-static void poison_element(struct mempool *pool, void *element)
-{
-	/* Skip poisoning: KASAN might save its metadata in the element. */
-	if (kasan_enabled())
-		return;
-
-	/* Mempools backed by slab allocator */
-	if (pool->alloc == mempool_kmalloc) {
-		__poison_element(element, (size_t)pool->pool_data);
-	} else if (pool->alloc == mempool_alloc_slab) {
-		__poison_element(element, kmem_cache_size(pool->pool_data));
-	} else if (pool->alloc == mempool_alloc_pages) {
-		/* Mempools backed by page allocator */
-		int order = (int)(long)pool->pool_data;
-
-#ifdef CONFIG_HIGHMEM
-		for (int i = 0; i < (1 << order); i++) {
-			struct page *page = (struct page *)element;
-			void *addr = kmap_local_page(page + i);
-
-			__poison_element(addr, PAGE_SIZE);
-			kunmap_local(addr);
-		}
-#else
-		void *addr = page_address((struct page *)element);
-
-		__poison_element(addr, PAGE_SIZE << order);
-#endif
-	}
-}
-#else /* CONFIG_SLUB_DEBUG_ON */
 static inline void check_element(struct mempool *pool, void *element)
 {
 }
 static inline void poison_element(struct mempool *pool, void *element)
 {
 }
-#endif /* CONFIG_SLUB_DEBUG_ON */
 
 static __always_inline bool kasan_poison_element(struct mempool *pool,
 		void *element)
diff --git a/mm/slab.h b/mm/slab.h
index e9ab292acd22..c190720d144f 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -444,19 +444,6 @@ struct slabinfo {
 
 void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo);
 
-#ifdef CONFIG_SLUB_DEBUG
-#ifdef CONFIG_SLUB_DEBUG_ON
-DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
-#else
-DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
-#endif
-extern void print_tracking(struct kmem_cache *s, void *object);
-long validate_slab_cache(struct kmem_cache *s);
-static inline bool __slub_debug_enabled(void)
-{
-	return static_branch_unlikely(&slub_debug_enabled);
-}
-#else
 static inline void print_tracking(struct kmem_cache *s, void *object)
 {
 }
@@ -464,7 +451,6 @@ static inline bool __slub_debug_enabled(void)
 {
 	return false;
 }
-#endif
 
 /*
  * Returns true if any of the specified slab_debug flags is enabled for the
@@ -473,18 +459,10 @@ static inline bool __slub_debug_enabled(void)
  */
 static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
 {
-	if (IS_ENABLED(CONFIG_SLUB_DEBUG))
-		VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
-	if (__slub_debug_enabled())
-		return s->flags & flags;
 	return false;
 }
 
-#if IS_ENABLED(CONFIG_SLUB_DEBUG) && IS_ENABLED(CONFIG_KUNIT)
-bool slab_in_kunit_test(void);
-#else
 static inline bool slab_in_kunit_test(void) { return false; }
-#endif
 
 /*
  * slub is about to manipulate internal object metadata.  This memory lies
@@ -649,13 +627,9 @@ static inline size_t large_kmalloc_size(const struct page *page)
 	return PAGE_SIZE << large_kmalloc_order(page);
 }
 
-#ifdef CONFIG_SLUB_DEBUG
-void dump_unreclaimable_slab(void);
-#else
 static inline void dump_unreclaimable_slab(void)
 {
 }
-#endif
 
 void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr);
 
@@ -694,11 +668,7 @@ static inline bool slab_want_init_on_free(struct kmem_cache *c)
 	return false;
 }
 
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
-void debugfs_slab_release(struct kmem_cache *);
-#else
 static inline void debugfs_slab_release(struct kmem_cache *s) { }
-#endif
 
 #ifdef CONFIG_PRINTK
 #define KS_ADDRS_COUNT 16
@@ -726,8 +696,4 @@ static inline bool slub_debug_orig_size(struct kmem_cache *s)
 			(s->flags & SLAB_KMALLOC));
 }
 
-#ifdef CONFIG_SLUB_DEBUG
-void skip_orig_size_check(struct kmem_cache *s, const void *object);
-#endif
-
 #endif /* MM_SLAB_H */
diff --git a/mm/slub.c b/mm/slub.c
index 2b2d33cc735c..26b2d9e1434b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -201,14 +201,6 @@ enum slab_flags {
 #define __fastpath_inline
 #endif
 
-#ifdef CONFIG_SLUB_DEBUG
-#ifdef CONFIG_SLUB_DEBUG_ON
-DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
-#else
-DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
-#endif
-#endif		/* CONFIG_SLUB_DEBUG */
-
 #ifdef CONFIG_NUMA
 static DEFINE_STATIC_KEY_FALSE(strict_numa);
 #endif
@@ -324,11 +316,7 @@ static int sysfs_slab_add(struct kmem_cache *);
 static inline int sysfs_slab_add(struct kmem_cache *s) { return 0; }
 #endif
 
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
-static void debugfs_slab_add(struct kmem_cache *);
-#else
 static inline void debugfs_slab_add(struct kmem_cache *s) { }
-#endif
 
 enum add_mode {
 	ADD_TO_HEAD,
@@ -431,11 +419,6 @@ struct kmem_cache_node {
 	spinlock_t list_lock;
 	unsigned long nr_partial;
 	struct list_head partial;
-#ifdef CONFIG_SLUB_DEBUG
-	atomic_long_t nr_slabs;
-	atomic_long_t total_objects;
-	struct list_head full;
-#endif
 	struct node_barn *barn;
 };
 
@@ -825,1173 +808,73 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
 #else
 static inline bool need_slab_obj_exts(struct kmem_cache *s)
 {
-	return false;
-}
-
-static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
-{
-	return 0;
-}
-
-static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
-						    struct slab *slab)
-{
-	return 0;
-}
-
-static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
-						     struct slab *slab)
-{
-	return false;
-}
-
-static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
-{
-	return false;
-}
-
-#endif
-
-#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
-static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
-{
-	/*
-	 * Note we cannot rely on the SLAB_OBJ_EXT_IN_OBJ flag here and need to
-	 * check the stride. A cache can have SLAB_OBJ_EXT_IN_OBJ set, but
-	 * allocations within_slab_leftover are preferred. And those may be
-	 * possible or not depending on the particular slab's size.
-	 */
-	return obj_exts_in_slab(s, slab) &&
-	       (slab_get_stride(slab) == s->size);
-}
-
-static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
-{
-	unsigned int offset = get_info_end(s);
-
-	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
-		offset += sizeof(struct track) * 2;
-
-	if (slub_debug_orig_size(s))
-		offset += sizeof(unsigned long);
-
-	offset += kasan_metadata_size(s, false);
-
-	return offset;
-}
-#else
-static inline bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
-{
-	return false;
-}
-
-static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
-{
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_SLUB_DEBUG
-
-/*
- * For debugging context when we want to check if the struct slab pointer
- * appears to be valid.
- */
-static inline bool validate_slab_ptr(struct slab *slab)
-{
-	return PageSlab(slab_page(slab));
-}
-
-static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
-static DEFINE_SPINLOCK(object_map_lock);
-
-static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
-		       struct slab *slab)
-{
-	void *addr = slab_address(slab);
-	void *p;
-
-	bitmap_zero(obj_map, slab->objects);
-
-	for (p = slab->freelist; p; p = get_freepointer(s, p))
-		set_bit(__obj_to_index(s, addr, p), obj_map);
-}
-
-#if IS_ENABLED(CONFIG_KUNIT)
-static bool slab_add_kunit_errors(void)
-{
-	struct kunit_resource *resource;
-
-	if (!kunit_get_current_test())
-		return false;
-
-	resource = kunit_find_named_resource(current->kunit_test, "slab_errors");
-	if (!resource)
-		return false;
-
-	(*(int *)resource->data)++;
-	kunit_put_resource(resource);
-	return true;
-}
-
-bool slab_in_kunit_test(void)
-{
-	struct kunit_resource *resource;
-
-	if (!kunit_get_current_test())
-		return false;
-
-	resource = kunit_find_named_resource(current->kunit_test, "slab_errors");
-	if (!resource)
-		return false;
-
-	kunit_put_resource(resource);
-	return true;
-}
-#else
-static inline bool slab_add_kunit_errors(void) { return false; }
-#endif
-
-static inline unsigned int size_from_object(struct kmem_cache *s)
-{
-	if (s->flags & SLAB_RED_ZONE)
-		return s->size - s->red_left_pad;
-
-	return s->size;
-}
-
-static inline void *restore_red_left(struct kmem_cache *s, void *p)
-{
-	if (s->flags & SLAB_RED_ZONE)
-		p -= s->red_left_pad;
-
-	return p;
-}
-
-/*
- * Debug settings:
- */
-#if defined(CONFIG_SLUB_DEBUG_ON)
-static slab_flags_t slub_debug = DEBUG_DEFAULT_FLAGS;
-#else
-static slab_flags_t slub_debug;
-#endif
-
-static const char *slub_debug_string __ro_after_init;
-static int disable_higher_order_debug;
-
-/*
- * Object debugging
- */
-
-/* Verify that a pointer has an address that is valid within a slab page */
-static inline int check_valid_pointer(struct kmem_cache *s,
-				struct slab *slab, void *object)
-{
-	void *base;
-
-	if (!object)
-		return 1;
-
-	base = slab_address(slab);
-	object = kasan_reset_tag(object);
-	object = restore_red_left(s, object);
-	if (object < base || object >= base + slab->objects * s->size ||
-		(object - base) % s->size) {
-		return 0;
-	}
-
-	return 1;
-}
-
-static void print_section(char *level, char *text, u8 *addr,
-			  unsigned int length)
-{
-	metadata_access_enable();
-	print_hex_dump(level, text, DUMP_PREFIX_ADDRESS,
-			16, 1, kasan_reset_tag((void *)addr), length, 1);
-	metadata_access_disable();
-}
-
-static struct track *get_track(struct kmem_cache *s, void *object,
-	enum track_item alloc)
-{
-	struct track *p;
-
-	p = object + get_info_end(s);
-
-	return kasan_reset_tag(p + alloc);
-}
-
-#ifdef CONFIG_STACKDEPOT
-static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
-{
-	depot_stack_handle_t handle;
-	unsigned long entries[TRACK_ADDRS_COUNT];
-	unsigned int nr_entries;
-
-	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
-	handle = stack_depot_save(entries, nr_entries, gfp_flags);
-
-	return handle;
-}
-#else
-static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
-{
-	return 0;
-}
-#endif
-
-static void set_track_update(struct kmem_cache *s, void *object,
-			     enum track_item alloc, unsigned long addr,
-			     depot_stack_handle_t handle)
-{
-	struct track *p = get_track(s, object, alloc);
-
-#ifdef CONFIG_STACKDEPOT
-	p->handle = handle;
-#endif
-	p->addr = addr;
-	p->cpu = raw_smp_processor_id();
-	p->pid = current->pid;
-	p->when = jiffies;
-}
-
-static __always_inline void set_track(struct kmem_cache *s, void *object,
-				      enum track_item alloc, unsigned long addr, gfp_t gfp_flags)
-{
-	depot_stack_handle_t handle = set_track_prepare(gfp_flags);
-
-	set_track_update(s, object, alloc, addr, handle);
-}
-
-static void init_tracking(struct kmem_cache *s, void *object)
-{
-	struct track *p;
-
-	if (!(s->flags & SLAB_STORE_USER))
-		return;
-
-	p = get_track(s, object, TRACK_ALLOC);
-	memset(p, 0, 2*sizeof(struct track));
-}
-
-static void print_track(const char *s, struct track *t, unsigned long pr_time)
-{
-	depot_stack_handle_t handle __maybe_unused;
-
-	if (!t->addr)
-		return;
-
-	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
-	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
-#ifdef CONFIG_STACKDEPOT
-	handle = READ_ONCE(t->handle);
-	if (handle)
-		stack_depot_print(handle);
-	else
-		pr_err("object allocation/free stack trace missing\n");
-#endif
-}
-
-void print_tracking(struct kmem_cache *s, void *object)
-{
-	unsigned long pr_time = jiffies;
-	if (!(s->flags & SLAB_STORE_USER))
-		return;
-
-	print_track("Allocated", get_track(s, object, TRACK_ALLOC), pr_time);
-	print_track("Freed", get_track(s, object, TRACK_FREE), pr_time);
-}
-
-static void print_slab_info(const struct slab *slab)
-{
-	pr_err("Slab 0x%p objects=%u used=%u fp=0x%p flags=%pGp\n",
-	       slab, slab->objects, slab->inuse, slab->freelist,
-	       &slab->flags.f);
-}
-
-void skip_orig_size_check(struct kmem_cache *s, const void *object)
-{
-	set_orig_size(s, (void *)object, s->object_size);
-}
-
-static void __slab_bug(struct kmem_cache *s, const char *fmt, va_list argsp)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_copy(args, argsp);
-	vaf.fmt = fmt;
-	vaf.va = &args;
-	pr_err("=============================================================================\n");
-	pr_err("BUG %s (%s): %pV\n", s ? s->name : "<unknown>", print_tainted(), &vaf);
-	pr_err("-----------------------------------------------------------------------------\n\n");
-	va_end(args);
-}
-
-static void slab_bug(struct kmem_cache *s, const char *fmt, ...)
-{
-	va_list args;
-
-	va_start(args, fmt);
-	__slab_bug(s, fmt, args);
-	va_end(args);
-}
-
-__printf(2, 3)
-static void slab_fix(struct kmem_cache *s, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	if (slab_add_kunit_errors())
-		return;
-
-	va_start(args, fmt);
-	vaf.fmt = fmt;
-	vaf.va = &args;
-	pr_err("FIX %s: %pV\n", s->name, &vaf);
-	va_end(args);
-}
-
-static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
-{
-	unsigned int off;	/* Offset of last byte */
-	u8 *addr = slab_address(slab);
-
-	print_tracking(s, p);
-
-	print_slab_info(slab);
-
-	pr_err("Object 0x%p @offset=%tu fp=0x%p\n\n",
-	       p, p - addr, get_freepointer(s, p));
-
-	if (s->flags & SLAB_RED_ZONE)
-		print_section(KERN_ERR, "Redzone  ", p - s->red_left_pad,
-			      s->red_left_pad);
-	else if (p > addr + 16)
-		print_section(KERN_ERR, "Bytes b4 ", p - 16, 16);
-
-	print_section(KERN_ERR,         "Object   ", p,
-		      min_t(unsigned int, s->object_size, PAGE_SIZE));
-	if (s->flags & SLAB_RED_ZONE)
-		print_section(KERN_ERR, "Redzone  ", p + s->object_size,
-			s->inuse - s->object_size);
-
-	off = get_info_end(s);
-
-	if (s->flags & SLAB_STORE_USER)
-		off += 2 * sizeof(struct track);
-
-	if (slub_debug_orig_size(s))
-		off += sizeof(unsigned long);
-
-	off += kasan_metadata_size(s, false);
-
-	if (obj_exts_in_object(s, slab))
-		off += sizeof(struct slabobj_ext);
-
-	if (off != size_from_object(s))
-		/* Beginning of the filler is the free pointer */
-		print_section(KERN_ERR, "Padding  ", p + off,
-			      size_from_object(s) - off);
-}
-
-static void object_err(struct kmem_cache *s, struct slab *slab,
-			u8 *object, const char *reason)
-{
-	if (slab_add_kunit_errors())
-		return;
-
-	slab_bug(s, reason);
-	if (!object || !check_valid_pointer(s, slab, object)) {
-		print_slab_info(slab);
-		pr_err("Invalid pointer 0x%p\n", object);
-	} else {
-		print_trailer(s, slab, object);
-	}
-	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
-
-	WARN_ON(1);
-}
-
-static void __slab_err(struct slab *slab)
-{
-	if (slab_in_kunit_test())
-		return;
-
-	print_slab_info(slab);
-	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
-
-	WARN_ON(1);
-}
-
-static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
-			const char *fmt, ...)
-{
-	va_list args;
-
-	if (slab_add_kunit_errors())
-		return;
-
-	va_start(args, fmt);
-	__slab_bug(s, fmt, args);
-	va_end(args);
-
-	__slab_err(slab);
-}
-
-static void init_object(struct kmem_cache *s, void *object, u8 val)
-{
-	u8 *p = kasan_reset_tag(object);
-	unsigned int poison_size = s->object_size;
-
-	if (s->flags & SLAB_RED_ZONE) {
-		/*
-		 * Here and below, avoid overwriting the KMSAN shadow. Keeping
-		 * the shadow makes it possible to distinguish uninit-value
-		 * from use-after-free.
-		 */
-		memset_no_sanitize_memory(p - s->red_left_pad, val,
-					  s->red_left_pad);
-
-		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
-			/*
-			 * Redzone the extra allocated space by kmalloc than
-			 * requested, and the poison size will be limited to
-			 * the original request size accordingly.
-			 */
-			poison_size = get_orig_size(s, object);
-		}
-	}
-
-	if (s->flags & __OBJECT_POISON) {
-		memset_no_sanitize_memory(p, POISON_FREE, poison_size - 1);
-		memset_no_sanitize_memory(p + poison_size - 1, POISON_END, 1);
-	}
-
-	if (s->flags & SLAB_RED_ZONE)
-		memset_no_sanitize_memory(p + poison_size, val,
-					  s->inuse - poison_size);
-}
-
-static void restore_bytes(struct kmem_cache *s, const char *message, u8 data,
-						void *from, void *to)
-{
-	slab_fix(s, "Restoring %s 0x%p-0x%p=0x%x", message, from, to - 1, data);
-	memset(from, data, to - from);
-}
-
-#ifdef CONFIG_KMSAN
-#define pad_check_attributes noinline __no_kmsan_checks
-#else
-#define pad_check_attributes
-#endif
-
-static pad_check_attributes int
-check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
-		       u8 *object, const char *what, u8 *start, unsigned int value,
-		       unsigned int bytes, bool slab_obj_print)
-{
-	u8 *fault;
-	u8 *end;
-	u8 *addr = slab_address(slab);
-
-	metadata_access_enable();
-	fault = memchr_inv(kasan_reset_tag(start), value, bytes);
-	metadata_access_disable();
-	if (!fault)
-		return 1;
-
-	end = start + bytes;
-	while (end > fault && end[-1] == value)
-		end--;
-
-	if (slab_add_kunit_errors())
-		goto skip_bug_print;
-
-	pr_err("[%s overwritten] 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
-	       what, fault, end - 1, fault - addr, fault[0], value);
-
-	if (slab_obj_print)
-		object_err(s, slab, object, "Object corrupt");
-
-skip_bug_print:
-	restore_bytes(s, what, value, fault, end);
-	return 0;
-}
-
-/*
- * Object field layout:
- *
- * [Left redzone padding] (if SLAB_RED_ZONE)
- *   - Field size: s->red_left_pad
- *   - Immediately precedes each object when SLAB_RED_ZONE is set.
- *   - Filled with 0xbb (SLUB_RED_INACTIVE) for inactive objects and
- *     0xcc (SLUB_RED_ACTIVE) for objects in use when SLAB_RED_ZONE.
- *
- * [Object bytes] (object address starts here)
- *   - Field size: s->object_size
- *   - Object payload bytes.
- *   - If the freepointer may overlap the object, it is stored inside
- *     the object (typically near the middle).
- *   - Poisoning uses 0x6b (POISON_FREE) and the last byte is
- *     0xa5 (POISON_END) when __OBJECT_POISON is enabled.
- *
- * [Word-align padding] (right redzone when SLAB_RED_ZONE is set)
- *   - Field size: s->inuse - s->object_size
- *   - If redzoning is enabled and ALIGN(size, sizeof(void *)) adds no
- *     padding, explicitly extend by one word so the right redzone is
- *     non-empty.
- *   - Filled with 0xbb (SLUB_RED_INACTIVE) for inactive objects and
- *     0xcc (SLUB_RED_ACTIVE) for objects in use when SLAB_RED_ZONE.
- *
- * [Metadata starts at object + s->inuse]
- *   - A. freelist pointer (if freeptr_outside_object)
- *   - B. alloc tracking (SLAB_STORE_USER)
- *   - C. free tracking (SLAB_STORE_USER)
- *   - D. original request size (SLAB_KMALLOC && SLAB_STORE_USER)
- *   - E. KASAN metadata (if enabled)
- *
- * [Mandatory padding] (if CONFIG_SLUB_DEBUG && SLAB_RED_ZONE)
- *   - One mandatory debug word to guarantee a minimum poisoned gap
- *     between metadata and the next object, independent of alignment.
- *   - Filled with 0x5a (POISON_INUSE) when SLAB_POISON is set.
- * [Final alignment padding]
- *   - Bytes added by ALIGN(size, s->align) to reach s->size.
- *   - When the padding is large enough, it can be used to store
- *     struct slabobj_ext for accounting metadata (obj_exts_in_object()).
- *   - The remaining bytes (if any) are filled with 0x5a (POISON_INUSE)
- *     when SLAB_POISON is set.
- *
- * Notes:
- * - Redzones are filled by init_object() with SLUB_RED_ACTIVE/INACTIVE.
- * - Object contents are poisoned with POISON_FREE/END when __OBJECT_POISON.
- * - The trailing padding is pre-filled with POISON_INUSE by
- *   setup_slab_debug() when SLAB_POISON is set, and is validated by
- *   check_pad_bytes().
- * - The first object pointer is slab_address(slab) +
- *   (s->red_left_pad if redzoning); subsequent objects are reached by
- *   adding s->size each time.
- *
- * If a slab cache flag relies on specific metadata to exist at a fixed
- * offset, the flag must be included in SLAB_NEVER_MERGE to prevent merging.
- * Otherwise, the cache would misbehave as s->object_size and s->inuse are
- * adjusted during cache merging (see __kmem_cache_alias()).
- */
-static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
-{
-	unsigned long off = get_info_end(s);	/* The end of info */
-
-	if (s->flags & SLAB_STORE_USER) {
-		/* We also have user information there */
-		off += 2 * sizeof(struct track);
-
-		if (s->flags & SLAB_KMALLOC)
-			off += sizeof(unsigned long);
-	}
-
-	off += kasan_metadata_size(s, false);
-
-	if (obj_exts_in_object(s, slab))
-		off += sizeof(struct slabobj_ext);
-
-	if (size_from_object(s) == off)
-		return 1;
-
-	return check_bytes_and_report(s, slab, p, "Object padding",
-			p + off, POISON_INUSE, size_from_object(s) - off, true);
-}
-
-/* Check the pad bytes at the end of a slab page */
-static pad_check_attributes void
-slab_pad_check(struct kmem_cache *s, struct slab *slab)
-{
-	u8 *start;
-	u8 *fault;
-	u8 *end;
-	u8 *pad;
-	int length;
-	int remainder;
-
-	if (!(s->flags & SLAB_POISON))
-		return;
-
-	start = slab_address(slab);
-	length = slab_size(slab);
-	end = start + length;
-
-	if (obj_exts_in_slab(s, slab) && !obj_exts_in_object(s, slab)) {
-		remainder = length;
-		remainder -= obj_exts_offset_in_slab(s, slab);
-		remainder -= obj_exts_size_in_slab(slab);
-	} else {
-		remainder = length % s->size;
-	}
-
-	if (!remainder)
-		return;
-
-	pad = end - remainder;
-	metadata_access_enable();
-	fault = memchr_inv(kasan_reset_tag(pad), POISON_INUSE, remainder);
-	metadata_access_disable();
-	if (!fault)
-		return;
-	while (end > fault && end[-1] == POISON_INUSE)
-		end--;
-
-	slab_bug(s, "Padding overwritten. 0x%p-0x%p @offset=%tu",
-		 fault, end - 1, fault - start);
-	print_section(KERN_ERR, "Padding ", pad, remainder);
-	__slab_err(slab);
-
-	restore_bytes(s, "slab padding", POISON_INUSE, fault, end);
-}
-
-static int check_object(struct kmem_cache *s, struct slab *slab,
-					void *object, u8 val)
-{
-	u8 *p = object;
-	u8 *endobject = object + s->object_size;
-	unsigned int orig_size, kasan_meta_size;
-	int ret = 1;
-
-	if (s->flags & SLAB_RED_ZONE) {
-		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
-			object - s->red_left_pad, val, s->red_left_pad, ret))
-			ret = 0;
-
-		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
-			endobject, val, s->inuse - s->object_size, ret))
-			ret = 0;
-
-		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
-			orig_size = get_orig_size(s, object);
-
-			if (s->object_size > orig_size  &&
-				!check_bytes_and_report(s, slab, object,
-					"kmalloc Redzone", p + orig_size,
-					val, s->object_size - orig_size, ret)) {
-				ret = 0;
-			}
-		}
-	} else {
-		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
-			if (!check_bytes_and_report(s, slab, p, "Alignment padding",
-				endobject, POISON_INUSE,
-				s->inuse - s->object_size, ret))
-				ret = 0;
-		}
-	}
-
-	if (s->flags & SLAB_POISON) {
-		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON)) {
-			/*
-			 * KASAN can save its free meta data inside of the
-			 * object at offset 0. Thus, skip checking the part of
-			 * the redzone that overlaps with the meta data.
-			 */
-			kasan_meta_size = kasan_metadata_size(s, true);
-			if (kasan_meta_size < s->object_size - 1 &&
-			    !check_bytes_and_report(s, slab, p, "Poison",
-					p + kasan_meta_size, POISON_FREE,
-					s->object_size - kasan_meta_size - 1, ret))
-				ret = 0;
-			if (kasan_meta_size < s->object_size &&
-			    !check_bytes_and_report(s, slab, p, "End Poison",
-					p + s->object_size - 1, POISON_END, 1, ret))
-				ret = 0;
-		}
-		/*
-		 * check_pad_bytes cleans up on its own.
-		 */
-		if (!check_pad_bytes(s, slab, p))
-			ret = 0;
-	}
-
-	/*
-	 * Cannot check freepointer while object is allocated if
-	 * object and freepointer overlap.
-	 */
-	if ((freeptr_outside_object(s) || val != SLUB_RED_ACTIVE) &&
-	    !check_valid_pointer(s, slab, get_freepointer(s, p))) {
-		object_err(s, slab, p, "Freepointer corrupt");
-		/*
-		 * No choice but to zap it and thus lose the remainder
-		 * of the free objects in this slab. May cause
-		 * another error because the object count is now wrong.
-		 */
-		set_freepointer(s, p, NULL);
-		ret = 0;
-	}
-
-	return ret;
-}
-
-/*
- * Checks if the slab state looks sane. Assumes the struct slab pointer
- * was either obtained in a way that ensures it's valid, or validated
- * by validate_slab_ptr()
- */
-static int check_slab(struct kmem_cache *s, struct slab *slab)
-{
-	int maxobj;
-
-	maxobj = order_objects(slab_order(slab), s->size);
-	if (slab->objects > maxobj) {
-		slab_err(s, slab, "objects %u > max %u",
-			slab->objects, maxobj);
-		return 0;
-	}
-	if (slab->inuse > slab->objects) {
-		slab_err(s, slab, "inuse %u > max %u",
-			slab->inuse, slab->objects);
-		return 0;
-	}
-	if (slab->frozen) {
-		slab_err(s, slab, "Slab disabled since SLUB metadata consistency check failed");
-		return 0;
-	}
-
-	/* Slab_pad_check fixes things up after itself */
-	slab_pad_check(s, slab);
-	return 1;
-}
-
-/*
- * Determine if a certain object in a slab is on the freelist. Must hold the
- * slab lock to guarantee that the chains are in a consistent state.
- */
-static bool on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
-{
-	int nr = 0;
-	void *fp;
-	void *object = NULL;
-	int max_objects;
-
-	fp = slab->freelist;
-	while (fp && nr <= slab->objects) {
-		if (fp == search)
-			return true;
-		if (!check_valid_pointer(s, slab, fp)) {
-			if (object) {
-				object_err(s, slab, object,
-					"Freechain corrupt");
-				set_freepointer(s, object, NULL);
-				break;
-			} else {
-				slab_err(s, slab, "Freepointer corrupt");
-				slab->freelist = NULL;
-				slab->inuse = slab->objects;
-				slab_fix(s, "Freelist cleared");
-				return false;
-			}
-		}
-		object = fp;
-		fp = get_freepointer(s, object);
-		nr++;
-	}
-
-	if (nr > slab->objects) {
-		slab_err(s, slab, "Freelist cycle detected");
-		slab->freelist = NULL;
-		slab->inuse = slab->objects;
-		slab_fix(s, "Freelist cleared");
-		return false;
-	}
-
-	max_objects = order_objects(slab_order(slab), s->size);
-	if (max_objects > MAX_OBJS_PER_PAGE)
-		max_objects = MAX_OBJS_PER_PAGE;
-
-	if (slab->objects != max_objects) {
-		slab_err(s, slab, "Wrong number of objects. Found %d but should be %d",
-			 slab->objects, max_objects);
-		slab->objects = max_objects;
-		slab_fix(s, "Number of objects adjusted");
-	}
-	if (slab->inuse != slab->objects - nr) {
-		slab_err(s, slab, "Wrong object count. Counter is %d but counted were %d",
-			 slab->inuse, slab->objects - nr);
-		slab->inuse = slab->objects - nr;
-		slab_fix(s, "Object count adjusted");
-	}
-	return search == NULL;
-}
-
-static void trace(struct kmem_cache *s, struct slab *slab, void *object,
-								int alloc)
-{
-	if (s->flags & SLAB_TRACE) {
-		pr_info("TRACE %s %s 0x%p inuse=%d fp=0x%p\n",
-			s->name,
-			alloc ? "alloc" : "free",
-			object, slab->inuse,
-			slab->freelist);
-
-		if (!alloc)
-			print_section(KERN_INFO, "Object ", (void *)object,
-					s->object_size);
-
-		dump_stack();
-	}
-}
-
-/*
- * Tracking of fully allocated slabs for debugging purposes.
- */
-static void add_full(struct kmem_cache *s,
-	struct kmem_cache_node *n, struct slab *slab)
-{
-	if (!(s->flags & SLAB_STORE_USER))
-		return;
-
-	lockdep_assert_held(&n->list_lock);
-	list_add(&slab->slab_list, &n->full);
-}
-
-static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct slab *slab)
-{
-	if (!(s->flags & SLAB_STORE_USER))
-		return;
-
-	lockdep_assert_held(&n->list_lock);
-	list_del(&slab->slab_list);
-}
-
-static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
-{
-	return atomic_long_read(&n->nr_slabs);
-}
-
-static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
-{
-	struct kmem_cache_node *n = get_node(s, node);
-
-	atomic_long_inc(&n->nr_slabs);
-	atomic_long_add(objects, &n->total_objects);
-}
-static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
-{
-	struct kmem_cache_node *n = get_node(s, node);
-
-	atomic_long_dec(&n->nr_slabs);
-	atomic_long_sub(objects, &n->total_objects);
+	return false;
 }
 
-/* Object debug checks for alloc/free paths */
-static void setup_object_debug(struct kmem_cache *s, void *object)
+static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
 {
-	if (!kmem_cache_debug_flags(s, SLAB_STORE_USER|SLAB_RED_ZONE|__OBJECT_POISON))
-		return;
-
-	init_object(s, object, SLUB_RED_INACTIVE);
-	init_tracking(s, object);
+	return 0;
 }
 
-static
-void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr)
+static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
+						    struct slab *slab)
 {
-	if (!kmem_cache_debug_flags(s, SLAB_POISON))
-		return;
-
-	metadata_access_enable();
-	memset(kasan_reset_tag(addr), POISON_INUSE, slab_size(slab));
-	metadata_access_disable();
+	return 0;
 }
 
-static inline int alloc_consistency_checks(struct kmem_cache *s,
-					struct slab *slab, void *object)
+static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
+						     struct slab *slab)
 {
-	if (!check_slab(s, slab))
-		return 0;
-
-	if (!check_valid_pointer(s, slab, object)) {
-		object_err(s, slab, object, "Freelist Pointer check fails");
-		return 0;
-	}
-
-	if (!check_object(s, slab, object, SLUB_RED_INACTIVE))
-		return 0;
-
-	return 1;
+	return false;
 }
 
-static noinline bool alloc_debug_processing(struct kmem_cache *s,
-			struct slab *slab, void *object, int orig_size)
+static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
 {
-	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
-		if (!alloc_consistency_checks(s, slab, object))
-			goto bad;
-	}
+	return false;
+}
 
-	/* Success. Perform special debug activities for allocs */
-	trace(s, slab, object, 1);
-	set_orig_size(s, object, orig_size);
-	init_object(s, object, SLUB_RED_ACTIVE);
-	return true;
+#endif
 
-bad:
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
+{
 	/*
-	 * Let's do the best we can to avoid issues in the future. Marking all
-	 * objects as used avoids touching the remaining objects.
+	 * Note we cannot rely on the SLAB_OBJ_EXT_IN_OBJ flag here and need to
+	 * check the stride. A cache can have SLAB_OBJ_EXT_IN_OBJ set, but
+	 * allocations within_slab_leftover are preferred. And those may be
+	 * possible or not depending on the particular slab's size.
 	 */
-	slab_fix(s, "Marking all objects used");
-	slab->inuse = slab->objects;
-	slab->freelist = NULL;
-	slab->frozen = 1; /* mark consistency-failed slab as frozen */
-
-	return false;
+	return obj_exts_in_slab(s, slab) &&
+	       (slab_get_stride(slab) == s->size);
 }
 
-static inline int free_consistency_checks(struct kmem_cache *s,
-		struct slab *slab, void *object, unsigned long addr)
+static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
 {
-	if (!check_valid_pointer(s, slab, object)) {
-		slab_err(s, slab, "Invalid object pointer 0x%p", object);
-		return 0;
-	}
+	unsigned int offset = get_info_end(s);
 
-	if (on_freelist(s, slab, object)) {
-		object_err(s, slab, object, "Object already free");
-		return 0;
-	}
+	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
+		offset += sizeof(struct track) * 2;
 
-	if (!check_object(s, slab, object, SLUB_RED_ACTIVE))
-		return 0;
+	if (slub_debug_orig_size(s))
+		offset += sizeof(unsigned long);
 
-	if (unlikely(s != slab->slab_cache)) {
-		if (!slab->slab_cache) {
-			slab_err(NULL, slab, "No slab cache for object 0x%p",
-				 object);
-		} else {
-			object_err(s, slab, object,
-				   "page slab pointer corrupt.");
-		}
-		return 0;
-	}
-	return 1;
-}
+	offset += kasan_metadata_size(s, false);
 
-/*
- * Parse a block of slab_debug options. Blocks are delimited by ';'
- *
- * @str:    start of block
- * @flags:  returns parsed flags, or DEBUG_DEFAULT_FLAGS if none specified
- * @slabs:  return start of list of slabs, or NULL when there's no list
- * @init:   assume this is initial parsing and not per-kmem-create parsing
- *
- * returns the start of next block if there's any, or NULL
- */
-static const char *
-parse_slub_debug_flags(const char *str, slab_flags_t *flags, const char **slabs, bool init)
+	return offset;
+}
+#else
+static inline bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
 {
-	bool higher_order_disable = false;
-
-	/* Skip any completely empty blocks */
-	while (*str && *str == ';')
-		str++;
-
-	if (*str == ',') {
-		/*
-		 * No options but restriction on slabs. This means full
-		 * debugging for slabs matching a pattern.
-		 */
-		*flags = DEBUG_DEFAULT_FLAGS;
-		goto check_slabs;
-	}
-	*flags = 0;
-
-	/* Determine which debug features should be switched on */
-	for (; *str && *str != ',' && *str != ';'; str++) {
-		switch (tolower(*str)) {
-		case '-':
-			*flags = 0;
-			break;
-		case 'f':
-			*flags |= SLAB_CONSISTENCY_CHECKS;
-			break;
-		case 'z':
-			*flags |= SLAB_RED_ZONE;
-			break;
-		case 'p':
-			*flags |= SLAB_POISON;
-			break;
-		case 'u':
-			*flags |= SLAB_STORE_USER;
-			break;
-		case 't':
-			*flags |= SLAB_TRACE;
-			break;
-		case 'a':
-			*flags |= SLAB_FAILSLAB;
-			break;
-		case 'o':
-			/*
-			 * Avoid enabling debugging on caches if its minimum
-			 * order would increase as a result.
-			 */
-			higher_order_disable = true;
-			break;
-		default:
-			if (init)
-				pr_err("slab_debug option '%c' unknown. skipped\n", *str);
-		}
-	}
-check_slabs:
-	if (*str == ',')
-		*slabs = ++str;
-	else
-		*slabs = NULL;
-
-	/* Skip over the slab list */
-	while (*str && *str != ';')
-		str++;
-
-	/* Skip any completely empty blocks */
-	while (*str && *str == ';')
-		str++;
-
-	if (init && higher_order_disable)
-		disable_higher_order_debug = 1;
-
-	if (*str)
-		return str;
-	else
-		return NULL;
+	return false;
 }
 
-static int __init setup_slub_debug(const char *str, const struct kernel_param *kp)
+static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
 {
-	slab_flags_t flags;
-	slab_flags_t global_flags;
-	const char *saved_str;
-	const char *slab_list;
-	bool global_slub_debug_changed = false;
-	bool slab_list_specified = false;
-
-	global_flags = DEBUG_DEFAULT_FLAGS;
-	if (!str || !*str)
-		/*
-		 * No options specified. Switch on full debugging.
-		 */
-		goto out;
-
-	saved_str = str;
-	while (str) {
-		str = parse_slub_debug_flags(str, &flags, &slab_list, true);
-
-		if (!slab_list) {
-			global_flags = flags;
-			global_slub_debug_changed = true;
-		} else {
-			slab_list_specified = true;
-			if (flags & SLAB_STORE_USER)
-				stack_depot_request_early_init();
-		}
-	}
-
-	/*
-	 * For backwards compatibility, a single list of flags with list of
-	 * slabs means debugging is only changed for those slabs, so the global
-	 * slab_debug should be unchanged (0 or DEBUG_DEFAULT_FLAGS, depending
-	 * on CONFIG_SLUB_DEBUG_ON). We can extended that to multiple lists as
-	 * long as there is no option specifying flags without a slab list.
-	 */
-	if (slab_list_specified) {
-		if (!global_slub_debug_changed)
-			global_flags = slub_debug;
-		slub_debug_string = saved_str;
-	}
-out:
-	slub_debug = global_flags;
-	if (slub_debug & SLAB_STORE_USER)
-		stack_depot_request_early_init();
-	if (slub_debug != 0 || slub_debug_string)
-		static_branch_enable(&slub_debug_enabled);
-	else
-		static_branch_disable(&slub_debug_enabled);
-	if ((static_branch_unlikely(&init_on_alloc) ||
-	     static_branch_unlikely(&init_on_free)) &&
-	    (slub_debug & SLAB_POISON))
-		pr_info("mem auto-init: SLAB_POISON will take precedence over init_on_alloc/init_on_free\n");
 	return 0;
 }
+#endif
 
-static const struct kernel_param_ops param_ops_slab_debug __initconst = {
-	.flags = KERNEL_PARAM_OPS_FL_NOARG,
-	.set = setup_slub_debug,
-};
-__core_param_cb(slab_debug, &param_ops_slab_debug, NULL, 0);
-__core_param_cb(slub_debug, &param_ops_slab_debug, NULL, 0);
-
-/*
- * kmem_cache_flags - apply debugging options to the cache
- * @flags:		flags to set
- * @name:		name of the cache
- *
- * Debug option(s) are applied to @flags. In addition to the debug
- * option(s), if a slab name (or multiple) is specified i.e.
- * slab_debug=<Debug-Options>,<slab name1>,<slab name2> ...
- * then only the select slabs will receive the debug option(s).
- */
-slab_flags_t kmem_cache_flags(slab_flags_t flags, const char *name)
-{
-	const char *iter;
-	size_t len;
-	const char *next_block;
-	slab_flags_t block_flags;
-	slab_flags_t slub_debug_local = slub_debug;
-
-	if (flags & SLAB_NO_USER_FLAGS)
-		return flags;
-
-	/*
-	 * If the slab cache is for debugging (e.g. kmemleak) then
-	 * don't store user (stack trace) information by default,
-	 * but let the user enable it via the command line below.
-	 */
-	if (flags & SLAB_NOLEAKTRACE)
-		slub_debug_local &= ~SLAB_STORE_USER;
-
-	len = strlen(name);
-	next_block = slub_debug_string;
-	/* Go through all blocks of debug options, see if any matches our slab's name */
-	while (next_block) {
-		next_block = parse_slub_debug_flags(next_block, &block_flags, &iter, false);
-		if (!iter)
-			continue;
-		/* Found a block that has a slab list, search it */
-		while (*iter) {
-			const char *end, *glob;
-			size_t cmplen;
-
-			end = strchrnul(iter, ',');
-			if (next_block && next_block < end)
-				end = next_block - 1;
-
-			glob = strnchr(iter, end - iter, '*');
-			if (glob)
-				cmplen = glob - iter;
-			else
-				cmplen = max_t(size_t, len, (end - iter));
-
-			if (!strncmp(name, iter, cmplen)) {
-				flags |= block_flags;
-				return flags;
-			}
-
-			if (!*end || *end == ';')
-				break;
-			iter = end + 1;
-		}
-	}
-
-	return flags | slub_debug_local;
-}
-#else /* !CONFIG_SLUB_DEBUG */
+/* !CONFIG_SLUB_DEBUG */
 static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
 static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
@@ -2027,7 +910,7 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
 static inline void dec_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
-#endif /* CONFIG_SLUB_DEBUG */
+/* CONFIG_SLUB_DEBUG */
 
 /*
  * The allocated objcg pointers array is not accounted directly.
@@ -3653,15 +2536,6 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 
 	lockdep_assert_held(&n->list_lock);
 
-#ifdef CONFIG_SLUB_DEBUG
-	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
-		if (!validate_slab_ptr(slab)) {
-			slab_err(s, slab, "Not a valid slab page");
-			return NULL;
-		}
-	}
-#endif
-
 	object = slab->freelist;
 	slab->freelist = get_freepointer(s, object);
 	slab->inuse++;
@@ -4099,77 +2973,7 @@ static int slub_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
-#ifdef CONFIG_SLUB_DEBUG
-static int count_free(struct slab *slab)
-{
-	return slab->objects - slab->inuse;
-}
-
-static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
-{
-	return atomic_long_read(&n->total_objects);
-}
-
-/* Supports checking bulk free of a constructed freelist */
-static inline bool free_debug_processing(struct kmem_cache *s,
-	struct slab *slab, void *head, void *tail, int *bulk_cnt,
-	unsigned long addr, depot_stack_handle_t handle)
-{
-	bool checks_ok = false;
-	void *object = head;
-	int cnt = 0;
-
-	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
-		if (!check_slab(s, slab))
-			goto out;
-	}
-
-	if (slab->inuse < *bulk_cnt) {
-		slab_err(s, slab, "Slab has %d allocated objects but %d are to be freed\n",
-			 slab->inuse, *bulk_cnt);
-		goto out;
-	}
-
-next_object:
-
-	if (++cnt > *bulk_cnt)
-		goto out_cnt;
-
-	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
-		if (!free_consistency_checks(s, slab, object, addr))
-			goto out;
-	}
-
-	if (s->flags & SLAB_STORE_USER)
-		set_track_update(s, object, TRACK_FREE, addr, handle);
-	trace(s, slab, object, 0);
-	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
-	init_object(s, object, SLUB_RED_INACTIVE);
-
-	/* Reached end of constructed freelist yet? */
-	if (object != tail) {
-		object = get_freepointer(s, object);
-		goto next_object;
-	}
-	checks_ok = true;
-
-out_cnt:
-	if (cnt != *bulk_cnt) {
-		slab_err(s, slab, "Bulk free expected %d objects but found %d\n",
-			 *bulk_cnt, cnt);
-		*bulk_cnt = cnt;
-	}
-
-out:
-
-	if (!checks_ok)
-		slab_fix(s, "Object at 0x%p not freed", object);
-
-	return checks_ok;
-}
-#endif /* CONFIG_SLUB_DEBUG */
-
-#if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
+#if defined(SLAB_SUPPORTS_SYSFS)
 static unsigned long count_partial(struct kmem_cache_node *n,
 					int (*get_count)(struct slab *))
 {
@@ -4183,85 +2987,10 @@ static unsigned long count_partial(struct kmem_cache_node *n,
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return x;
 }
-#endif /* CONFIG_SLUB_DEBUG || SLAB_SUPPORTS_SYSFS */
-
-#ifdef CONFIG_SLUB_DEBUG
-#define MAX_PARTIAL_TO_SCAN 10000
-
-static unsigned long count_partial_free_approx(struct kmem_cache_node *n)
-{
-	unsigned long flags;
-	unsigned long x = 0;
-	struct slab *slab;
-
-	spin_lock_irqsave(&n->list_lock, flags);
-	if (n->nr_partial <= MAX_PARTIAL_TO_SCAN) {
-		list_for_each_entry(slab, &n->partial, slab_list)
-			x += slab->objects - slab->inuse;
-	} else {
-		/*
-		 * For a long list, approximate the total count of objects in
-		 * it to meet the limit on the number of slabs to scan.
-		 * Scan from both the list's head and tail for better accuracy.
-		 */
-		unsigned long scanned = 0;
-
-		list_for_each_entry(slab, &n->partial, slab_list) {
-			x += slab->objects - slab->inuse;
-			if (++scanned == MAX_PARTIAL_TO_SCAN / 2)
-				break;
-		}
-		list_for_each_entry_reverse(slab, &n->partial, slab_list) {
-			x += slab->objects - slab->inuse;
-			if (++scanned == MAX_PARTIAL_TO_SCAN)
-				break;
-		}
-		x = mult_frac(x, n->nr_partial, scanned);
-		x = min(x, node_nr_objs(n));
-	}
-	spin_unlock_irqrestore(&n->list_lock, flags);
-	return x;
-}
-
-static noinline void
-slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
-{
-	static DEFINE_RATELIMIT_STATE(slub_oom_rs, DEFAULT_RATELIMIT_INTERVAL,
-				      DEFAULT_RATELIMIT_BURST);
-	int cpu = raw_smp_processor_id();
-	int node;
-	struct kmem_cache_node *n;
-
-	if ((gfpflags & __GFP_NOWARN) || !__ratelimit(&slub_oom_rs))
-		return;
-
-	pr_warn("SLUB: Unable to allocate memory on CPU %u (of node %d) on node %d, gfp=%#x(%pGg)\n",
-		cpu, cpu_to_node(cpu), nid, gfpflags, &gfpflags);
-	pr_warn("  cache: %s, object size: %u, buffer size: %u, default order: %u, min order: %u\n",
-		s->name, s->object_size, s->size, oo_order(s->oo),
-		oo_order(s->min));
-
-	if (oo_order(s->min) > get_order(s->object_size))
-		pr_warn("  %s debugging increased min order, use slab_debug=O to disable.\n",
-			s->name);
-
-	for_each_kmem_cache_node(s, node, n) {
-		unsigned long nr_slabs;
-		unsigned long nr_objs;
-		unsigned long nr_free;
-
-		nr_free  = count_partial_free_approx(n);
-		nr_slabs = node_nr_slabs(n);
-		nr_objs  = node_nr_objs(n);
+#endif /* SLAB_SUPPORTS_SYSFS */
 
-		pr_warn("  node %d: slabs: %ld, objs: %ld, free: %ld\n",
-			node, nr_slabs, nr_objs, nr_free);
-	}
-}
-#else /* CONFIG_SLUB_DEBUG */
 static inline void
 slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid) { }
-#endif
 
 static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags)
 {
@@ -6300,14 +5029,6 @@ static inline size_t slab_ksize(struct slab *slab)
 {
 	struct kmem_cache *s = slab->slab_cache;
 
-#ifdef CONFIG_SLUB_DEBUG
-	/*
-	 * Debugging requires use of the padding between object
-	 * and whatever may come after it.
-	 */
-	if (s->flags & (SLAB_RED_ZONE | SLAB_POISON))
-		return s->object_size;
-#endif
 	if (s->flags & SLAB_KASAN)
 		return s->object_size;
 	/*
@@ -6343,10 +5064,6 @@ static size_t __ksize(const void *object)
 	if (WARN_ON(!slab))
 		return page_size(page);
 
-#ifdef CONFIG_SLUB_DEBUG
-	skip_orig_size_check(slab->slab_cache, object);
-#endif
-
 	return slab_ksize(slab);
 }
 
@@ -7432,11 +6149,6 @@ init_kmem_cache_node(struct kmem_cache_node *n, struct node_barn *barn)
 	n->nr_partial = 0;
 	spin_lock_init(&n->list_lock);
 	INIT_LIST_HEAD(&n->partial);
-#ifdef CONFIG_SLUB_DEBUG
-	atomic_long_set(&n->nr_slabs, 0);
-	atomic_long_set(&n->total_objects, 0);
-	INIT_LIST_HEAD(&n->full);
-#endif
 	n->barn = barn;
 	if (barn)
 		barn_init(barn);
@@ -7528,9 +6240,6 @@ static void early_kmem_cache_node_alloc(int node)
 
 	n = slab->freelist;
 	BUG_ON(!n);
-#ifdef CONFIG_SLUB_DEBUG
-	init_object(kmem_cache_node, n, SLUB_RED_ACTIVE);
-#endif
 	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL, false);
 	slab->freelist = get_freepointer(kmem_cache_node, n);
 	slab->inuse = 1;
@@ -7672,28 +6381,6 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	 */
 	size = ALIGN(size, sizeof(void *));
 
-#ifdef CONFIG_SLUB_DEBUG
-	/*
-	 * Determine if we can poison the object itself. If the user of
-	 * the slab may touch the object after free or before allocation
-	 * then we should never poison the object itself.
-	 */
-	if ((flags & SLAB_POISON) && !(flags & SLAB_TYPESAFE_BY_RCU) &&
-			!s->ctor)
-		s->flags |= __OBJECT_POISON;
-	else
-		s->flags &= ~__OBJECT_POISON;
-
-
-	/*
-	 * If we are Redzoning and there is no space between the end of the
-	 * object and the following fields, add one word so the right Redzone
-	 * is non-empty.
-	 */
-	if ((flags & SLAB_RED_ZONE) && size == s->object_size)
-		size += sizeof(void *);
-#endif
-
 	/*
 	 * With that we have determined the number of bytes in actual use
 	 * by the object and redzoning.
@@ -7735,37 +6422,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 		s->offset = ALIGN_DOWN(s->object_size / 2, sizeof(void *));
 	}
 
-#ifdef CONFIG_SLUB_DEBUG
-	if (flags & SLAB_STORE_USER) {
-		/*
-		 * Need to store information about allocs and frees after
-		 * the object.
-		 */
-		size += 2 * sizeof(struct track);
-
-		/* Save the original kmalloc request size */
-		if (flags & SLAB_KMALLOC)
-			size += sizeof(unsigned long);
-	}
-#endif
-
 	kasan_cache_create(s, &size, &s->flags);
-#ifdef CONFIG_SLUB_DEBUG
-	if (flags & SLAB_RED_ZONE) {
-		/*
-		 * Add some empty padding so that we can catch
-		 * overwrites from earlier objects rather than let
-		 * tracking information or the free pointer be
-		 * corrupted if a user writes before the start
-		 * of the object.
-		 */
-		size += sizeof(void *);
-
-		s->red_left_pad = sizeof(void *);
-		s->red_left_pad = ALIGN(s->red_left_pad, s->align);
-		size += s->red_left_pad;
-	}
-#endif
 
 	/*
 	 * SLUB stores one object immediately after another beginning from
@@ -7816,29 +6473,6 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 
 static void list_slab_objects(struct kmem_cache *s, struct slab *slab)
 {
-#ifdef CONFIG_SLUB_DEBUG
-	void *addr = slab_address(slab);
-	void *p;
-
-	if (!slab_add_kunit_errors())
-		slab_bug(s, "Objects remaining on __kmem_cache_shutdown()");
-
-	spin_lock(&object_map_lock);
-	__fill_map(object_map, s, slab);
-
-	for_each_object(p, s, addr, slab->objects) {
-
-		if (!test_bit(__obj_to_index(s, addr, p), object_map)) {
-			if (slab_add_kunit_errors())
-				continue;
-			pr_err("Object 0x%p @offset=%tu\n", p, p - addr);
-			print_tracking(s, p);
-		}
-	}
-	spin_unlock(&object_map_lock);
-
-	__slab_err(slab);
-#endif
 }
 
 /*
@@ -7919,46 +6553,15 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 	kpp->kp_slab_cache = s;
 	base = slab_address(slab);
 	objp0 = kasan_reset_tag(object);
-#ifdef CONFIG_SLUB_DEBUG
-	objp = restore_red_left(s, objp0);
-#else
 	objp = objp0;
-#endif
 	objnr = obj_to_index(s, slab, objp);
 	kpp->kp_data_offset = (unsigned long)((char *)objp0 - (char *)objp);
 	objp = base + s->size * objnr;
 	kpp->kp_objp = objp;
 	if (WARN_ON_ONCE(objp < base || objp >= base + slab->objects * s->size
-			 || (objp - base) % s->size) ||
-	    !(s->flags & SLAB_STORE_USER))
-		return;
-#ifdef CONFIG_SLUB_DEBUG
-	objp = fixup_red_left(s, objp);
-	trackp = get_track(s, objp, TRACK_ALLOC);
-	kpp->kp_ret = (void *)trackp->addr;
-#ifdef CONFIG_STACKDEPOT
-	{
-		depot_stack_handle_t handle;
-		unsigned long *entries;
-		unsigned int nr_entries;
-
-		handle = READ_ONCE(trackp->handle);
-		if (handle) {
-			nr_entries = stack_depot_fetch(handle, &entries);
-			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
-				kpp->kp_stack[i] = (void *)entries[i];
-		}
-
-		trackp = get_track(s, objp, TRACK_FREE);
-		handle = READ_ONCE(trackp->handle);
-		if (handle) {
-			nr_entries = stack_depot_fetch(handle, &entries);
-			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
-				kpp->kp_free_stack[i] = (void *)entries[i];
-		}
-	}
-#endif
-#endif
+			 || (objp - base) % s->size) ||
+	    !(s->flags & SLAB_STORE_USER))
+		return;
 }
 #endif
 
@@ -8282,10 +6885,6 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 		list_for_each_entry(p, &n->partial, slab_list)
 			p->slab_cache = s;
 
-#ifdef CONFIG_SLUB_DEBUG
-		list_for_each_entry(p, &n->full, slab_list)
-			p->slab_cache = s;
-#endif
 	}
 	list_add(&s->list, &slab_caches);
 	return s;
@@ -8537,257 +7136,6 @@ static int count_total(struct slab *slab)
 }
 #endif
 
-#ifdef CONFIG_SLUB_DEBUG
-static void validate_slab(struct kmem_cache *s, struct slab *slab,
-			  unsigned long *obj_map)
-{
-	void *p;
-	void *addr = slab_address(slab);
-
-	if (!validate_slab_ptr(slab)) {
-		slab_err(s, slab, "Not a valid slab page");
-		return;
-	}
-
-	if (!check_slab(s, slab) || !on_freelist(s, slab, NULL))
-		return;
-
-	/* Now we know that a valid freelist exists */
-	__fill_map(obj_map, s, slab);
-	for_each_object(p, s, addr, slab->objects) {
-		u8 val = test_bit(__obj_to_index(s, addr, p), obj_map) ?
-			 SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;
-
-		if (!check_object(s, slab, p, val))
-			break;
-	}
-}
-
-static int validate_slab_node(struct kmem_cache *s,
-		struct kmem_cache_node *n, unsigned long *obj_map)
-{
-	unsigned long count = 0;
-	struct slab *slab;
-	unsigned long flags;
-
-	spin_lock_irqsave(&n->list_lock, flags);
-
-	list_for_each_entry(slab, &n->partial, slab_list) {
-		validate_slab(s, slab, obj_map);
-		count++;
-	}
-	if (count != n->nr_partial) {
-		pr_err("SLUB %s: %ld partial slabs counted but counter=%ld\n",
-		       s->name, count, n->nr_partial);
-		slab_add_kunit_errors();
-	}
-
-	if (!(s->flags & SLAB_STORE_USER))
-		goto out;
-
-	list_for_each_entry(slab, &n->full, slab_list) {
-		validate_slab(s, slab, obj_map);
-		count++;
-	}
-	if (count != node_nr_slabs(n)) {
-		pr_err("SLUB: %s %ld slabs counted but counter=%ld\n",
-		       s->name, count, node_nr_slabs(n));
-		slab_add_kunit_errors();
-	}
-
-out:
-	spin_unlock_irqrestore(&n->list_lock, flags);
-	return count;
-}
-
-long validate_slab_cache(struct kmem_cache *s)
-{
-	int node;
-	unsigned long count = 0;
-	struct kmem_cache_node *n;
-	unsigned long *obj_map;
-
-	obj_map = bitmap_alloc(oo_objects(s->oo), GFP_KERNEL);
-	if (!obj_map)
-		return -ENOMEM;
-
-	flush_all(s);
-	for_each_kmem_cache_node(s, node, n)
-		count += validate_slab_node(s, n, obj_map);
-
-	bitmap_free(obj_map);
-
-	return count;
-}
-EXPORT_SYMBOL(validate_slab_cache);
-
-#ifdef CONFIG_DEBUG_FS
-/*
- * Generate lists of code addresses where slabcache objects are allocated
- * and freed.
- */
-
-struct location {
-	depot_stack_handle_t handle;
-	unsigned long count;
-	unsigned long addr;
-	unsigned long waste;
-	long long sum_time;
-	long min_time;
-	long max_time;
-	long min_pid;
-	long max_pid;
-	DECLARE_BITMAP(cpus, NR_CPUS);
-	nodemask_t nodes;
-};
-
-struct loc_track {
-	unsigned long max;
-	unsigned long count;
-	struct location *loc;
-	loff_t idx;
-};
-
-static struct dentry *slab_debugfs_root;
-
-static void free_loc_track(struct loc_track *t)
-{
-	if (t->max)
-		free_pages((unsigned long)t->loc,
-			get_order(sizeof(struct location) * t->max));
-}
-
-static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
-{
-	struct location *l;
-	int order;
-
-	order = get_order(sizeof(struct location) * max);
-
-	l = (void *)__get_free_pages(flags, order);
-	if (!l)
-		return 0;
-
-	if (t->count) {
-		memcpy(l, t->loc, sizeof(struct location) * t->count);
-		free_loc_track(t);
-	}
-	t->max = max;
-	t->loc = l;
-	return 1;
-}
-
-static int add_location(struct loc_track *t, struct kmem_cache *s,
-				const struct track *track,
-				unsigned int orig_size)
-{
-	long start, end, pos;
-	struct location *l;
-	unsigned long caddr, chandle, cwaste;
-	unsigned long age = jiffies - track->when;
-	depot_stack_handle_t handle = 0;
-	unsigned int waste = s->object_size - orig_size;
-
-#ifdef CONFIG_STACKDEPOT
-	handle = READ_ONCE(track->handle);
-#endif
-	start = -1;
-	end = t->count;
-
-	for ( ; ; ) {
-		pos = start + (end - start + 1) / 2;
-
-		/*
-		 * There is nothing at "end". If we end up there
-		 * we need to add something to before end.
-		 */
-		if (pos == end)
-			break;
-
-		l = &t->loc[pos];
-		caddr = l->addr;
-		chandle = l->handle;
-		cwaste = l->waste;
-		if ((track->addr == caddr) && (handle == chandle) &&
-			(waste == cwaste)) {
-
-			l->count++;
-			if (track->when) {
-				l->sum_time += age;
-				if (age < l->min_time)
-					l->min_time = age;
-				if (age > l->max_time)
-					l->max_time = age;
-
-				if (track->pid < l->min_pid)
-					l->min_pid = track->pid;
-				if (track->pid > l->max_pid)
-					l->max_pid = track->pid;
-
-				cpumask_set_cpu(track->cpu,
-						to_cpumask(l->cpus));
-			}
-			node_set(page_to_nid(virt_to_page(track)), l->nodes);
-			return 1;
-		}
-
-		if (track->addr < caddr)
-			end = pos;
-		else if (track->addr == caddr && handle < chandle)
-			end = pos;
-		else if (track->addr == caddr && handle == chandle &&
-				waste < cwaste)
-			end = pos;
-		else
-			start = pos;
-	}
-
-	/*
-	 * Not found. Insert new tracking element.
-	 */
-	if (t->count >= t->max && !alloc_loc_track(t, 2 * t->max, GFP_ATOMIC))
-		return 0;
-
-	l = t->loc + pos;
-	if (pos < t->count)
-		memmove(l + 1, l,
-			(t->count - pos) * sizeof(struct location));
-	t->count++;
-	l->count = 1;
-	l->addr = track->addr;
-	l->sum_time = age;
-	l->min_time = age;
-	l->max_time = age;
-	l->min_pid = track->pid;
-	l->max_pid = track->pid;
-	l->handle = handle;
-	l->waste = waste;
-	cpumask_clear(to_cpumask(l->cpus));
-	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
-	nodes_clear(l->nodes);
-	node_set(page_to_nid(virt_to_page(track)), l->nodes);
-	return 1;
-}
-
-static void process_slab(struct loc_track *t, struct kmem_cache *s,
-		struct slab *slab, enum track_item alloc,
-		unsigned long *obj_map)
-{
-	void *addr = slab_address(slab);
-	bool is_alloc = (alloc == TRACK_ALLOC);
-	void *p;
-
-	__fill_map(obj_map, s, slab);
-
-	for_each_object(p, s, addr, slab->objects)
-		if (!test_bit(__obj_to_index(s, addr, p), obj_map))
-			add_location(t, s, get_track(s, p, alloc),
-				     is_alloc ? get_orig_size(s, p) :
-						s->object_size);
-}
-#endif  /* CONFIG_DEBUG_FS   */
-#endif	/* CONFIG_SLUB_DEBUG */
-
 #ifdef SLAB_SUPPORTS_SYSFS
 enum slab_stat_type {
 	SL_ALL,			/* All slabs */
@@ -8827,24 +7175,6 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 	 * unplug code doesn't destroy the kmem_cache->node[] data.
 	 */
 
-#ifdef CONFIG_SLUB_DEBUG
-	if (flags & SO_ALL) {
-		struct kmem_cache_node *n;
-
-		for_each_kmem_cache_node(s, node, n) {
-
-			if (flags & SO_TOTAL)
-				x = node_nr_objs(n);
-			else if (flags & SO_OBJECTS)
-				x = node_nr_objs(n) - count_partial(n, count_free);
-			else
-				x = node_nr_slabs(n);
-			total += x;
-			nodes[node] += x;
-		}
-
-	} else
-#endif
 	if (flags & SO_PARTIAL) {
 		struct kmem_cache_node *n;
 
@@ -9038,79 +7368,6 @@ static ssize_t destroy_by_rcu_show(struct kmem_cache *s, char *buf)
 }
 SLAB_ATTR_RO(destroy_by_rcu);
 
-#ifdef CONFIG_SLUB_DEBUG
-static ssize_t slabs_show(struct kmem_cache *s, char *buf)
-{
-	return show_slab_objects(s, buf, SO_ALL);
-}
-SLAB_ATTR_RO(slabs);
-
-static ssize_t total_objects_show(struct kmem_cache *s, char *buf)
-{
-	return show_slab_objects(s, buf, SO_ALL|SO_TOTAL);
-}
-SLAB_ATTR_RO(total_objects);
-
-static ssize_t objects_show(struct kmem_cache *s, char *buf)
-{
-	return show_slab_objects(s, buf, SO_ALL|SO_OBJECTS);
-}
-SLAB_ATTR_RO(objects);
-
-static ssize_t sanity_checks_show(struct kmem_cache *s, char *buf)
-{
-	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_CONSISTENCY_CHECKS));
-}
-SLAB_ATTR_RO(sanity_checks);
-
-static ssize_t trace_show(struct kmem_cache *s, char *buf)
-{
-	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_TRACE));
-}
-SLAB_ATTR_RO(trace);
-
-static ssize_t red_zone_show(struct kmem_cache *s, char *buf)
-{
-	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_RED_ZONE));
-}
-
-SLAB_ATTR_RO(red_zone);
-
-static ssize_t poison_show(struct kmem_cache *s, char *buf)
-{
-	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_POISON));
-}
-
-SLAB_ATTR_RO(poison);
-
-static ssize_t store_user_show(struct kmem_cache *s, char *buf)
-{
-	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_STORE_USER));
-}
-
-SLAB_ATTR_RO(store_user);
-
-static ssize_t validate_show(struct kmem_cache *s, char *buf)
-{
-	return 0;
-}
-
-static ssize_t validate_store(struct kmem_cache *s,
-			const char *buf, size_t length)
-{
-	int ret = -EINVAL;
-
-	if (buf[0] == '1' && kmem_cache_debug(s)) {
-		ret = validate_slab_cache(s);
-		if (ret >= 0)
-			ret = length;
-	}
-	return ret;
-}
-SLAB_ATTR(validate);
-
-#endif /* CONFIG_SLUB_DEBUG */
-
 #ifdef CONFIG_FAILSLAB
 static ssize_t failslab_show(struct kmem_cache *s, char *buf)
 {
@@ -9300,17 +7557,6 @@ static struct attribute *slab_attrs[] = {
 	&destroy_by_rcu_attr.attr,
 	&shrink_attr.attr,
 	&slabs_cpu_partial_attr.attr,
-#ifdef CONFIG_SLUB_DEBUG
-	&total_objects_attr.attr,
-	&objects_attr.attr,
-	&slabs_attr.attr,
-	&sanity_checks_attr.attr,
-	&trace_attr.attr,
-	&red_zone_attr.attr,
-	&poison_attr.attr,
-	&store_user_attr.attr,
-	&validate_attr.attr,
-#endif
 #ifdef CONFIG_ZONE_DMA
 	&cache_dma_attr.attr,
 #endif
@@ -9603,237 +7849,3 @@ static int __init slab_sysfs_init(void)
 late_initcall(slab_sysfs_init);
 #endif /* SLAB_SUPPORTS_SYSFS */
 
-#if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
-static int slab_debugfs_show(struct seq_file *seq, void *v)
-{
-	struct loc_track *t = seq->private;
-	struct location *l;
-	unsigned long idx;
-
-	idx = (unsigned long) t->idx;
-	if (idx < t->count) {
-		l = &t->loc[idx];
-
-		seq_printf(seq, "%7ld ", l->count);
-
-		if (l->addr)
-			seq_printf(seq, "%pS", (void *)l->addr);
-		else
-			seq_puts(seq, "<not-available>");
-
-		if (l->waste)
-			seq_printf(seq, " waste=%lu/%lu",
-				l->count * l->waste, l->waste);
-
-		if (l->sum_time != l->min_time) {
-			seq_printf(seq, " age=%ld/%llu/%ld",
-				l->min_time, div_u64(l->sum_time, l->count),
-				l->max_time);
-		} else
-			seq_printf(seq, " age=%ld", l->min_time);
-
-		if (l->min_pid != l->max_pid)
-			seq_printf(seq, " pid=%ld-%ld", l->min_pid, l->max_pid);
-		else
-			seq_printf(seq, " pid=%ld",
-				l->min_pid);
-
-		if (num_online_cpus() > 1 && !cpumask_empty(to_cpumask(l->cpus)))
-			seq_printf(seq, " cpus=%*pbl",
-				 cpumask_pr_args(to_cpumask(l->cpus)));
-
-		if (nr_online_nodes > 1 && !nodes_empty(l->nodes))
-			seq_printf(seq, " nodes=%*pbl",
-				 nodemask_pr_args(&l->nodes));
-
-#ifdef CONFIG_STACKDEPOT
-		{
-			depot_stack_handle_t handle;
-			unsigned long *entries;
-			unsigned int nr_entries, j;
-
-			handle = READ_ONCE(l->handle);
-			if (handle) {
-				nr_entries = stack_depot_fetch(handle, &entries);
-				seq_puts(seq, "\n");
-				for (j = 0; j < nr_entries; j++)
-					seq_printf(seq, "        %pS\n", (void *)entries[j]);
-			}
-		}
-#endif
-		seq_puts(seq, "\n");
-	}
-
-	if (!idx && !t->count)
-		seq_puts(seq, "No data\n");
-
-	return 0;
-}
-
-static void slab_debugfs_stop(struct seq_file *seq, void *v)
-{
-}
-
-static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
-{
-	struct loc_track *t = seq->private;
-
-	t->idx = ++(*ppos);
-	if (*ppos <= t->count)
-		return ppos;
-
-	return NULL;
-}
-
-static int cmp_loc_by_count(const void *a, const void *b)
-{
-	struct location *loc1 = (struct location *)a;
-	struct location *loc2 = (struct location *)b;
-
-	return cmp_int(loc2->count, loc1->count);
-}
-
-static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
-{
-	struct loc_track *t = seq->private;
-
-	t->idx = *ppos;
-	return ppos;
-}
-
-static const struct seq_operations slab_debugfs_sops = {
-	.start  = slab_debugfs_start,
-	.next   = slab_debugfs_next,
-	.stop   = slab_debugfs_stop,
-	.show   = slab_debugfs_show,
-};
-
-static int slab_debug_trace_open(struct inode *inode, struct file *filep)
-{
-
-	struct kmem_cache_node *n;
-	enum track_item alloc;
-	int node;
-	struct loc_track *t = __seq_open_private(filep, &slab_debugfs_sops,
-						sizeof(struct loc_track));
-	struct kmem_cache *s = file_inode(filep)->i_private;
-	unsigned long *obj_map;
-
-	if (!t)
-		return -ENOMEM;
-
-	obj_map = bitmap_alloc(oo_objects(s->oo), GFP_KERNEL);
-	if (!obj_map) {
-		seq_release_private(inode, filep);
-		return -ENOMEM;
-	}
-
-	alloc = debugfs_get_aux_num(filep);
-
-	if (!alloc_loc_track(t, PAGE_SIZE / sizeof(struct location), GFP_KERNEL)) {
-		bitmap_free(obj_map);
-		seq_release_private(inode, filep);
-		return -ENOMEM;
-	}
-
-	for_each_kmem_cache_node(s, node, n) {
-		unsigned long flags;
-		struct slab *slab;
-
-		if (!node_nr_slabs(n))
-			continue;
-
-		spin_lock_irqsave(&n->list_lock, flags);
-		list_for_each_entry(slab, &n->partial, slab_list)
-			process_slab(t, s, slab, alloc, obj_map);
-		list_for_each_entry(slab, &n->full, slab_list)
-			process_slab(t, s, slab, alloc, obj_map);
-		spin_unlock_irqrestore(&n->list_lock, flags);
-	}
-
-	/* Sort locations by count */
-	sort(t->loc, t->count, sizeof(struct location),
-	     cmp_loc_by_count, NULL);
-
-	bitmap_free(obj_map);
-	return 0;
-}
-
-static int slab_debug_trace_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq = file->private_data;
-	struct loc_track *t = seq->private;
-
-	free_loc_track(t);
-	return seq_release_private(inode, file);
-}
-
-static const struct file_operations slab_debugfs_fops = {
-	.open    = slab_debug_trace_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = slab_debug_trace_release,
-};
-
-static void debugfs_slab_add(struct kmem_cache *s)
-{
-	struct dentry *slab_cache_dir;
-
-	if (unlikely(!slab_debugfs_root))
-		return;
-
-	slab_cache_dir = debugfs_create_dir(s->name, slab_debugfs_root);
-
-	debugfs_create_file_aux_num("alloc_traces", 0400, slab_cache_dir, s,
-					TRACK_ALLOC, &slab_debugfs_fops);
-
-	debugfs_create_file_aux_num("free_traces", 0400, slab_cache_dir, s,
-					TRACK_FREE, &slab_debugfs_fops);
-}
-
-void debugfs_slab_release(struct kmem_cache *s)
-{
-	debugfs_lookup_and_remove(s->name, slab_debugfs_root);
-}
-
-static int __init slab_debugfs_init(void)
-{
-	struct kmem_cache *s;
-
-	slab_debugfs_root = debugfs_create_dir("slab", NULL);
-
-	list_for_each_entry(s, &slab_caches, list)
-		if (s->flags & SLAB_STORE_USER)
-			debugfs_slab_add(s);
-
-	return 0;
-
-}
-__initcall(slab_debugfs_init);
-#endif
-/*
- * The /proc/slabinfo ABI
- */
-#ifdef CONFIG_SLUB_DEBUG
-void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
-{
-	unsigned long nr_slabs = 0;
-	unsigned long nr_objs = 0;
-	unsigned long nr_free = 0;
-	int node;
-	struct kmem_cache_node *n;
-
-	for_each_kmem_cache_node(s, node, n) {
-		nr_slabs += node_nr_slabs(n);
-		nr_objs += node_nr_objs(n);
-		nr_free += count_partial_free_approx(n);
-	}
-
-	sinfo->active_objs = nr_objs - nr_free;
-	sinfo->num_objs = nr_objs;
-	sinfo->active_slabs = nr_slabs;
-	sinfo->num_slabs = nr_slabs;
-	sinfo->objects_per_slab = oo_objects(s->oo);
-	sinfo->cache_order = oo_order(s->oo);
-}
-#endif /* CONFIG_SLUB_DEBUG */

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260401-b4-are-you-serious-6393284f4e70

Best regards,
--  
Vlastimil Babka (SUSE) <vbabka@kernel.org>


