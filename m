Return-Path: <cgroups+bounces-11889-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1700CC542A0
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58ABD34C3B0
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB8354ACE;
	Wed, 12 Nov 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pOiqeYQC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2635470E
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975825; cv=none; b=cL+HDMdAXNAywM9zo/cz+xfBBGLOaQOxxDku/cjbeeOsUFxDmd98IgWO/gEZaQPJjtak1R/lUX4rcVcqa+y1zYHLYhv1xR1h70uuWs12D40BmdWcaTWTZBZn6svPHT5EfcBGc1odMpTlGfMlkFmTRJbrEKzohSGN9rvv/vAKiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975825; c=relaxed/simple;
	bh=rQ2kHp6lPREv3YxzvbPdgaiaRh8JzJ1empdCPfgiMYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6Ij13qvN4BGh5Gf4SWMgmWUFllpWkCA5ogNtcKq3fOBdNY87Z6yQoWFQCuVwzHOPywAlB2sEUXH/5rGJhEKofoXNMfjcxXgAZE7S62xYpCwEiC+uOangzJbD3rdYURvi8XmWdJWBFuzHwLlFdH7Q4Vt9OCZnKJgCxRr8EdfS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pOiqeYQC; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed946ed3cdso9768381cf.3
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 11:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975822; x=1763580622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE3olEnyRjl52kAEWnA02JLmmLDlTmwS9hIpIeJT8kY=;
        b=pOiqeYQCabQJef3Rs9wWabdkiZ771ipQtxnLdPN8Y9Io/D5tmux82CXFBxpEiwDOD3
         0HUsImdY3DffKnat2HR1WwA/P2GcwlnLE/ElaNkW+LibWaC/wOhEyfS3X3f6H9Wpebgt
         AmFZr9UQ8dGUE5gkR2dNl93p5S3mo9aNaje3hsRTg475vogLENODR6MIfAUfIcnfiRRQ
         uxfbG9o1CGd6U45pXz/Ye39X5Lq8jQeY0f1h3PQKS5hpmmSwmc6v3AYRPU945hJG7ATL
         A8Jmn6od++41aDCAYWvKcjFMxXI0rtOELJL0B8WwxGS1nxIpebr7U0zst7YWxVjs1rQv
         2WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975822; x=1763580622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EE3olEnyRjl52kAEWnA02JLmmLDlTmwS9hIpIeJT8kY=;
        b=UJvMlc8yzH957Ri+Qf8gcZOcTO8Sg9OsrAH1jz/cK54iJHT4xHLVZYOSYnH2sIop3h
         xOrsZuyrER4MP5KmhBF9+zoOSiJatCpNrgkxTUlSE0dP4Fq89LpeU5cBZdUNI8SJ3OBX
         Ognxyt3O3ZArqGwGEzEXOBYr8k9f0PnSxyJX5nk0jrq3xKuRSTIfcrOh0HAvFReAz4MX
         yNZCultEtfuQ1M21eYqu8MHvf8IoMazVceHBrjWjkBHaXRYyeVRJmDXHY4CSumX4HoBg
         h+h7e2y1TJl42wMExxGO84d758xYl57tW+Mytt5aTHXgNU2gXa6O/QBWhttqeggp70wc
         PM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7fzgtLTdZuiWdoAdJnj2wxymq+F//XEgjyCw1VxPw87QpDPpw24BaPxcD/P4Z+LrZNlbyrQ/9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2XdKZs/6ldhXBRSIsszpo/gobJy9PgBVUaKVWJFDDIIIuTSzg
	z14T2/cf7nAfnoeYF1NI62id/+fKsaUReUzxKlQ6kTv2lfvpLkR6HeIRw0ruJhuLoh8=
X-Gm-Gg: ASbGnctTh7mT+DOdEK12cSsL3pTVL8gLUv65c/VmgZ6LsxzSJ2sGWirYh+UxUfX/Jbd
	8RuObTQ5icnEIUo/DC8ZOE9dZhDyN/TMA8ZwDJeNw9JQCbr8R+GK9wQZN+dsok0ORpxrxGm5+Tp
	BWjNB/quK6y/JrdL+ncTOLQJ26DfUmOt8NHrxoo9yVJcOasHTi89yrVkune7ZtkLx4QSWbIfZ/N
	hAwQteSUCTuIx7EkAH+8difWnt9PjpgV7uuEu2R9U9YU6oo7q0gGn59gDvm4X7ayOJBuhChhfXB
	6m1Us0ZyuqbueZrz4eP+FmSOfo7MbSG9Fb6gYXRtTpUp3FfcNtHzM4v4uW5wkhI+4exI8mHZKx6
	okof8pCKBWH/dvO3sC3AWmDdRali7QuMHLpqeCxZ6VM+ou+u1sMDedOkF2oGean/alXbfKgWy9N
	kho/Ir8N2vPFpo+9lZksF/+BRsjsuslo9Q9rNC3Tl8aw+AMD8TAv7JgVQT9jtfxfTp
X-Google-Smtp-Source: AGHT+IEpkA9sHRf+vDkvWZyRaV+z+4MD09rdo9Mmp9OjAhV3qhp/e6NAADZhOGarPgun9sbSz0rc+w==
X-Received: by 2002:a05:622a:14f:b0:4e8:b980:4792 with SMTP id d75a77b69052e-4eddbcb30a2mr55332141cf.37.1762975821965;
        Wed, 12 Nov 2025 11:30:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:30:21 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH v2 11/11] [HACK] mm/zswap: compressed ram integration example
Date: Wed, 12 Nov 2025 14:29:27 -0500
Message-ID: <20251112192936.2574429-12-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>
References: <20251112192936.2574429-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is an example of how you might use a SPM memory node.

If there is compressed ram available (in this case, a bit present
in mt_spm_nodelist), we skip the entire software compression process
and memcpy directly to a compressed memory folio, and store the newly
allocated compressed memory page as the zswap entry->handle.

On decompress we do the opposite: copy directly from the stored
page to the destination, and free the compressed memory page.

Note: We do not integrate any compressed memory device checks at
this point because this is a stand-in to demonstrate how the SPM
node allocation mechanism works.

See the "TODO" comment in `zswap_compress_direct()` for more details

In reality, we would want to move this mechanism out of zswap into
its own component (cram.c?), and enable a more direct migrate_page()
call that actually re-maps the page read-only into any mappings, and
then provides a write-fault handler which promotes the page on write.

(Similar to a NUMA Hint Fault, but only on write-access)

This prevents any run-away compression ratio failures, since the
compression ratio would be checked on allocation, rather than allowed
to silently decrease on writes until the device becomes unstable.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/zswap.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index c1af782e54ec..e6f48a4e90f1 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -25,6 +25,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mempolicy.h>
 #include <linux/mempool.h>
+#include <linux/memory-tiers.h>
 #include <crypto/acompress.h>
 #include <linux/zswap.h>
 #include <linux/mm_types.h>
@@ -191,6 +192,7 @@ struct zswap_entry {
 	swp_entry_t swpentry;
 	unsigned int length;
 	bool referenced;
+	bool direct;
 	struct zswap_pool *pool;
 	unsigned long handle;
 	struct obj_cgroup *objcg;
@@ -717,7 +719,8 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 static void zswap_entry_free(struct zswap_entry *entry)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
-	zs_free(entry->pool->zs_pool, entry->handle);
+	if (!entry->direct)
+		zs_free(entry->pool->zs_pool, entry->handle);
 	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
@@ -851,6 +854,43 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
 	mutex_unlock(&acomp_ctx->mutex);
 }
 
+static struct page *zswap_compress_direct(struct page *src,
+					  struct zswap_entry *entry)
+{
+	int nid = first_node(mt_spm_nodelist);
+	struct page *dst;
+	gfp_t gfp;
+
+	if (nid == NUMA_NO_NODE)
+		return NULL;
+
+	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE |
+	      __GFP_SPM_NODE;
+	dst = __alloc_pages(gfp, 0, nid, &mt_spm_nodelist);
+	if (!dst)
+		return NULL;
+
+	/*
+	 * TODO: check that the page is safe to use
+	 *
+	 * In a real implementation, we would not be using ZSWAP to demonstrate this
+	 * and instead would implement a new component (compressed_ram, cram.c?)
+	 *
+	 * At this point we would check via some callback that the device's memory
+	 * is actually safe to use - and if not, free the page (without writing to
+	 * it), and kick off kswapd for that node to make room.
+	 *
+	 * Alternatively, if the compressed memory device(s) report a watermark
+	 * crossing via interrupt, a flag can be set that is checked here rather
+	 * that calling back into a device driver.
+	 *
+	 * In this case, we're testing with normal memory, so the memory is always
+	 * safe to use (i.e. no compression ratio to worry about).
+	 */
+	copy_mc_highpage(dst, src);
+	return dst;
+}
+
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 			   struct zswap_pool *pool)
 {
@@ -862,6 +902,19 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	gfp_t gfp;
 	u8 *dst;
 	bool mapped = false;
+	struct page *zpage;
+
+	/* Try to shunt directly to compressed ram */
+	if (!nodes_empty(mt_spm_nodelist)) {
+		zpage = zswap_compress_direct(page, entry);
+		if (zpage) {
+			entry->handle = (unsigned long)zpage;
+			entry->length = PAGE_SIZE;
+			entry->direct = true;
+			return true;
+		}
+		/* otherwise fallback to normal zswap */
+	}
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
 	dst = acomp_ctx->buffer;
@@ -939,6 +992,16 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	int decomp_ret = 0, dlen = PAGE_SIZE;
 	u8 *src, *obj;
 
+	/* compressed ram page */
+	if (entry->direct) {
+		struct page *src = (struct page *)entry->handle;
+		struct folio *zfolio = page_folio(src);
+
+		memcpy_folio(folio, 0, zfolio, 0, PAGE_SIZE);
+		__free_page(src);
+		goto direct_done;
+	}
+
 	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
 	obj = zs_obj_read_begin(pool->zs_pool, entry->handle, acomp_ctx->buffer);
 
@@ -972,6 +1035,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	zs_obj_read_end(pool->zs_pool, entry->handle, obj);
 	acomp_ctx_put_unlock(acomp_ctx);
 
+direct_done:
 	if (!decomp_ret && dlen == PAGE_SIZE)
 		return true;
 
-- 
2.51.1


