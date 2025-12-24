Return-Path: <cgroups+bounces-12652-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51913CDC47D
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 13:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A14B7300F727
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A163231AAB8;
	Wed, 24 Dec 2025 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EteAKAVd"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547B313E1A
	for <cgroups@vger.kernel.org>; Wed, 24 Dec 2025 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580710; cv=none; b=Lpv7Yq1Y048WemJ7dQ9bXo+Eeu+jJRMU/UFGjyl4TvZkUS2qYRR85voMNERRZ32m19fkd8B/fpigaSkz+vylxRoJNgiYeiO8P1EDAkIGSEVElTGXsQVO3qENtTtsqXs3I5GQmIi5anyFVpYabq6HeQvDmU1S6im/6wy+YRCLgao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580710; c=relaxed/simple;
	bh=A+RzpZY8iCAN4Ula3XGmIsfdO1ecF6Y+Z3vXKFB5rTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rszfflVL9zDFfw0ADiTM3bfpCyt/c9sSfpOPfwjS86A9sg45dJO6MZn2FSPBIa8GclKErrq99KH02GD2E9sUqQZ/2Q8YHV0uPf3qAFex+uHAorzHVZtNZfPkFs5271zrsbB/Vgr73Vvv/jySkylmbbSf0UMVa1Ph+eagaLei7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EteAKAVd; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Dec 2025 20:51:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766580706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRieSzag4iGvTpHtsvUWdbRPgpJbX/fu/qtI6sKweRY=;
	b=EteAKAVdI7AaeZsXkJZGXiC3GWcpQiwTLbqswnYduANuzhfYdjxwZQKi4oP+gB4Vzitol2
	O7KMR4XxCVMZTxVGxznHE21MLxneFymlmh1m7rJjkbAK7KljziRMR7WY7Rv+DtYOsLt8e7
	fijf2EakFJ1TPwarLAZkgATZvprtb+U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@gentwo.org, dvyukov@google.com, glider@google.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, 
	surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Subject: [PATCH] slub: clarify object field layout comments
Message-ID: <z7d52kjvlzxohbly42flhtebqc7knfvilierrjr4r5776rxhgy@lcqmkcpzklse>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
 <20251222110843.980347-8-harry.yoo@oracle.com>
 <graryni6wadpi3ytfq7zimj2kbmm7dumxvhxtzmxndrv5s2y67@ju4cdnsmos6e>
 <aUq1x_BowqYpHZAQ@hyeyoo>
 <zex6wgdlxk5vgwm7ou657fdmi27xnxihdndlszfa2chghamfuz@grhtfqw7gm7o>
 <aUrCXYdziRWP9PfV@hyeyoo>
 <c6owr44jdncf7q5zqgq4wn4pm57ai4cd3upauwmwszopuddf5g@52mkqbe2m27j>
 <aUt_1uDe05diks7b@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUt_1uDe05diks7b@hyeyoo>
X-Migadu-Flow: FLOW_OUT

The comments above check_pad_bytes() document the field layout of a
single object. Rewrite them to improve clarity and precision.

Also update an outdated comment in calculate_sizes().

Suggested-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Hao Li <hao.li@linux.dev>
---
Hi Harry, this patch adds more detailed object layout documentation. Let
me know if you have any comments.

 mm/slub.c | 92 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..138e9d13540d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1211,44 +1211,58 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
 }
 
 /*
- * Object layout:
- *
- * object address
- * 	Bytes of the object to be managed.
- * 	If the freepointer may overlay the object then the free
- *	pointer is at the middle of the object.
- *
- * 	Poisoning uses 0x6b (POISON_FREE) and the last byte is
- * 	0xa5 (POISON_END)
- *
- * object + s->object_size
- * 	Padding to reach word boundary. This is also used for Redzoning.
- * 	Padding is extended by another word if Redzoning is enabled and
- * 	object_size == inuse.
- *
- * 	We fill with 0xbb (SLUB_RED_INACTIVE) for inactive objects and with
- * 	0xcc (SLUB_RED_ACTIVE) for objects in use.
- *
- * object + s->inuse
- * 	Meta data starts here.
- *
- * 	A. Free pointer (if we cannot overwrite object on free)
- * 	B. Tracking data for SLAB_STORE_USER
- *	C. Original request size for kmalloc object (SLAB_STORE_USER enabled)
- *	D. Padding to reach required alignment boundary or at minimum
- * 		one word if debugging is on to be able to detect writes
- * 		before the word boundary.
- *
- *	Padding is done using 0x5a (POISON_INUSE)
- *
- * object + s->size
- * 	Nothing is used beyond s->size.
- *
- * If slabcaches are merged then the object_size and inuse boundaries are mostly
- * ignored. And therefore no slab options that rely on these boundaries
+ * Object field layout:
+ *
+ * [Left redzone padding] (if SLAB_RED_ZONE)
+ *   - Field size: s->red_left_pad
+ *   - Filled with 0xbb (SLUB_RED_INACTIVE) for inactive objects and
+ *     0xcc (SLUB_RED_ACTIVE) for objects in use when SLAB_RED_ZONE.
+ *
+ * [Object bytes]
+ *   - Field size: s->object_size
+ *   - Object payload bytes.
+ *   - If the freepointer may overlap the object, it is stored inside
+ *     the object (typically near the middle).
+ *   - Poisoning uses 0x6b (POISON_FREE) and the last byte is
+ *     0xa5 (POISON_END) when __OBJECT_POISON is enabled.
+ *
+ * [Word-align padding] (right redzone when SLAB_RED_ZONE is set)
+ *   - Field size: s->inuse - s->object_size
+ *   - If redzoning is enabled and ALIGN(size, sizeof(void *)) adds no
+ *     padding, explicitly extend by one word so the right redzone is
+ *     non-empty.
+ *   - Filled with 0xbb (SLUB_RED_INACTIVE) for inactive objects and
+ *     0xcc (SLUB_RED_ACTIVE) for objects in use when SLAB_RED_ZONE.
+ *
+ * [Metadata starts at object + s->inuse]
+ *   - A. freelist pointer (if freeptr_outside_object)
+ *   - B. alloc tracking (SLAB_STORE_USER)
+ *   - C. free tracking (SLAB_STORE_USER)
+ *   - D. original request size (SLAB_KMALLOC && SLAB_STORE_USER)
+ *   - E. KASAN metadata (if enabled)
+ *
+ * [Mandatory padding] (if CONFIG_SLUB_DEBUG && SLAB_RED_ZONE)
+ *   - One mandatory debug word to guarantee a minimum poisoned gap
+ *     between metadata and the next object, independent of alignment.
+ *   - Filled with 0x5a (POISON_INUSE) when SLAB_POISON is set.
+ * [Final alignment padding]
+ *   - Any bytes added by ALIGN(size, s->align) to reach s->size.
+ *   - Filled with 0x5a (POISON_INUSE) when SLAB_POISON is set.
+ *
+ * Notes:
+ * - Redzones are filled by init_object() with SLUB_RED_ACTIVE/INACTIVE.
+ * - Object contents are poisoned with POISON_FREE/END when __OBJECT_POISON.
+ * - The trailing padding is pre-filled with POISON_INUSE by
+ *   setup_slab_debug() when SLAB_POISON is set, and is validated by
+ *   check_pad_bytes().
+ * - The first object pointer is slab_address(slab) +
+ *   (s->red_left_pad if redzoning); subsequent objects are reached by
+ *   adding s->size each time.
+ *
+ * If slabcaches are merged then the object_size and inuse boundaries are
+ * mostly ignored. Therefore no slab options that rely on these boundaries
  * may be used with merged slabcaches.
  */
-
 static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 {
 	unsigned long off = get_info_end(s);	/* The end of info */
@@ -7103,9 +7117,9 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 
 
 	/*
-	 * If we are Redzoning then check if there is some space between the
-	 * end of the object and the free pointer. If not then add an
-	 * additional word to have some bytes to store Redzone information.
+	 * If we are Redzoning and there is no space between the end of the
+	 * object and the following fields, add one word so the right Redzone
+	 * is non-empty.
 	 */
 	if ((flags & SLAB_RED_ZONE) && size == s->object_size)
 		size += sizeof(void *);
-- 
2.50.1


