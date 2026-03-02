Return-Path: <cgroups+bounces-14531-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFf4FrzrpWlLHwAAu9opvQ
	(envelope-from <cgroups+bounces-14531-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:57:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B01C71DF061
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A03E5310E1BB
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 19:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3F0383C8F;
	Mon,  2 Mar 2026 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="OPvJFXz4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59597383C87
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481207; cv=none; b=e4wOwJAiGLZX9TPKb7+aP3N5tQMStpGtg6OtTeDGhekK/q+hlSOsvDNZFW/I/yZiODg8wEB12MGaNIO2thb2v2Wja17LFoELuNdOWxVcyq9furFffSHNxWeK6B4Kb+faZ4Shc15C9OQHl99ulXrNo3WtU+KEbShkrgJooRI361c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481207; c=relaxed/simple;
	bh=HEeg9n9CQQLgAaFgl++GPRpIQzNa5AIDCSTnURtsnD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpOBGERXz3VknIgu3YyVMP1KX2WSodqdmzQ8Mg4YZ2IYUWX0mgXkWxtjMoLE9wCebqsc1j4VccrvwJjxAtXBmdrP0JobHun+NuF5B8hduJzoRD0wfJ1bCBAO/96uoLWmyJFMYDe0/sBRASgKRg2RlPQxQyKCkDP4uP53SLqfESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=OPvJFXz4; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-896fb37d1f0so80045836d6.2
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2026 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772481200; x=1773086000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7vZGkE+1JaDLDSfa23XDw27l8nhvvwnMmFZbgJqVLA=;
        b=OPvJFXz4MGknnu7B55WQ/LCFfJdk8PdeRLmB19v+PwYpxz2tbjrjqnWcD9ryAm3GJ8
         btLD+CUSXx6kKCpUqbcCSqhhiWHhDXzcjlvHp3nAjictLPvRdg3SXKKF9rTllbEqybbU
         Hk9HU9fFSIeH6BsvCvzhQTi9gD0bj3q2qWDkVAJJwlH0CcA2kTi7vNS9F3YfbZBPBXdu
         6sFgct7wiD1XxWF9ARxVs4g70GpMoLDtTOewr2dNUbDi1NFC3fFaiMkyVj1mfW+NvJ4K
         VrhugsDdmcLP1DsbS/UvFa53W2OeiRjTT5uNfU+Jf7chmxmobbqkbGvPlh6trNNVfQrn
         GC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481200; x=1773086000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g7vZGkE+1JaDLDSfa23XDw27l8nhvvwnMmFZbgJqVLA=;
        b=FHXLIK/A851zgYg3zZ3Zj3gpWQPGYfV3NbEzlIwSWdpqgsvRvjbW6c7/Liauxheb+/
         RQJgJgRnXIy4jTu+APmzRPlipQ7AoW21/1fKBv7vaYi6tEIq4pFZm1Y1sy263nvoFZ7P
         OFygvLmkrusVPUwpL8DR5SZrP8nbMS3YKbqaNAFBRcDvLwStFeHCvzcWKz/a42wUCaUx
         R2f1Xyum4nRNeDb42yJhjFFajJwjwiBMNqKq3y/1NOrQdq6BgiYmzTuDZNK3B5FeBhTs
         6ETAXVBN02zJJS9lWgc+9P8ZmrUP2F01Dcn3gWjLINGdiOSRCPVRpgFhhgH6osfHHjoE
         jaQg==
X-Forwarded-Encrypted: i=1; AJvYcCUKY1jlR+ZWjb28TxpjpP24kYbuPnA1PSbZAJOB+gpDbkd9nJrE39fuPHlN91cE+Phyw80BsZOk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpz1Lj6wiCqpwsMqI/NiRasbuiY5DleVemM41YAIkavZTmHfzp
	5QdUh4+aB4f9WNMOiFgoy+5+hX0AY6Ly5JBQlTsEJLmyBhn1fwxuGnCOsOq+5AmZOhI=
X-Gm-Gg: ATEYQzzM0OczL03IOoIrjYeff3hNHUOSzoCDpcFn5Lt76XH89TDaPFzLh/1DKEdLiEp
	iYqoYQsbyi+sDpgg2gr2uT+JnGyOIMEU3rheqUfzfes/HDDItt5oEdGy//msaj9NmmaA72c3Hbd
	cwn7I0P3vkPrnGbEf7JgyTG8w24bIVR1PFKO2ux5OKHFJO47CKlWqsiltauIr/yzBJd4KxOYWsm
	BI+H2chIfl37tEes2Z7194IsoW3ic33v38r5AauFpZ0zXZhbCjgo/wuJ9OrW+EjW1s/gBbcyrtF
	P6/Ahv+m/P1wi78gsBYf53issoIVYr72nERd2ATi7GU970tlLr6l+FxsJhF7KiilfzCQDlrU9FY
	9XWfNYZxCl+wGwXBOjq7hBm5l9VlOUnYhtna3747Xx4SwUpkuQs/Nbtjpbs90mBqrROPW62qLSz
	t5QalfrlK+JMRIDR3KsvFPY7fiZ1W1rp3F
X-Received: by 2002:a05:6214:d4a:b0:899:fd80:f79c with SMTP id 6a1803df08f44-899fd8106b5mr59620616d6.22.1772481200266;
        Mon, 02 Mar 2026 11:53:20 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f4fb208dsm44179416d6.28.2026.03.02.11.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:53:19 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mm: memcg: separate slab stat accounting from objcg charge cache
Date: Mon,  2 Mar 2026 14:50:18 -0500
Message-ID: <20260302195305.620713-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302195305.620713-1-hannes@cmpxchg.org>
References: <20260302195305.620713-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B01C71DF061
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14531-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Cgroup slab metrics are cached per-cpu the same way as the sub-page
charge cache. However, the intertwined code to manage those dependent
caches right now is quite difficult to follow.

Specifically, cached slab stat updates occur in consume() if there was
enough charge cache to satisfy the new object. If that fails, whole
pages are reserved, and slab stats are updated when the remainder of
those pages, after subtracting the size of the new slab object, are
put into the charge cache. This already juggles a delicate mix of the
object size, the page charge size, and the remainder to put into the
byte cache. Doing slab accounting in this path as well is fragile, and
has recently caused a bug where the input parameters between the two
caches were mixed up.

Refactor the consume() and refill() paths into unlocked and locked
variants that only do charge caching. Then let the slab path manage
its own lock section and open-code charging and accounting.

This makes the slab stat cache subordinate to the charge cache:
__refill_obj_stock() is called first to prepare it;
__account_obj_stock() follows to hitch a ride.

This results in a minor behavioral change: previously, a mismatching
percpu stock would always be drained for the purpose of setting up
slab account caching, even if there was no byte remainder to put into
the charge cache. Now, the stock is left alone, and slab accounting
takes the uncached path if there is a mismatch. This is exceedingly
rare, and it was probably never worth draining the whole stock just to
cache the slab stat update.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 100 +++++++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 39 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4f12b75743d4..9c6f9849b717 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3218,16 +3218,18 @@ static struct obj_stock_pcp *trylock_stock(void)
 
 static void unlock_stock(struct obj_stock_pcp *stock)
 {
-	local_unlock(&obj_stock.lock);
+	if (stock)
+		local_unlock(&obj_stock.lock);
 }
 
+/* Call after __refill_obj_stock() to ensure stock->cached_objg == objcg */
 static void __account_obj_stock(struct obj_cgroup *objcg,
 				struct obj_stock_pcp *stock, int nr,
 				struct pglist_data *pgdat, enum node_stat_item idx)
 {
 	int *bytes;
 
-	if (!stock)
+	if (!stock || READ_ONCE(stock->cached_objcg) != objcg)
 		goto direct;
 
 	/*
@@ -3274,8 +3276,20 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 }
 
-static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
-			      struct pglist_data *pgdat, enum node_stat_item idx)
+static bool __consume_obj_stock(struct obj_cgroup *objcg,
+				struct obj_stock_pcp *stock,
+				unsigned int nr_bytes)
+{
+	if (objcg == READ_ONCE(stock->cached_objcg) &&
+	    stock->nr_bytes >= nr_bytes) {
+		stock->nr_bytes -= nr_bytes;
+		return true;
+	}
+
+	return false;
+}
+
+static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
 	struct obj_stock_pcp *stock;
 	bool ret = false;
@@ -3284,14 +3298,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	if (!stock)
 		return ret;
 
-	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
-		stock->nr_bytes -= nr_bytes;
-		ret = true;
-
-		if (pgdat)
-			__account_obj_stock(objcg, stock, nr_bytes, pgdat, idx);
-	}
-
+	ret = __consume_obj_stock(objcg, stock, nr_bytes);
 	unlock_stock(stock);
 
 	return ret;
@@ -3376,17 +3383,14 @@ static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
 	return flush;
 }
 
-static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
-		bool allow_uncharge, int nr_acct, struct pglist_data *pgdat,
-		enum node_stat_item idx)
+static void __refill_obj_stock(struct obj_cgroup *objcg,
+			       struct obj_stock_pcp *stock,
+			       unsigned int nr_bytes,
+			       bool allow_uncharge)
 {
-	struct obj_stock_pcp *stock;
 	unsigned int nr_pages = 0;
 
-	stock = trylock_stock();
 	if (!stock) {
-		if (pgdat)
-			__account_obj_stock(objcg, NULL, nr_acct, pgdat, idx);
 		nr_pages = nr_bytes >> PAGE_SHIFT;
 		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
 		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
@@ -3404,20 +3408,25 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	}
 	stock->nr_bytes += nr_bytes;
 
-	if (pgdat)
-		__account_obj_stock(objcg, stock, nr_acct, pgdat, idx);
-
 	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
 		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	unlock_stock(stock);
 out:
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 }
 
+static void refill_obj_stock(struct obj_cgroup *objcg,
+			     unsigned int nr_bytes,
+			     bool allow_uncharge)
+{
+	struct obj_stock_pcp *stock = trylock_stock();
+	__refill_obj_stock(objcg, stock, nr_bytes, allow_uncharge);
+	unlock_stock(stock);
+}
+
 static int __obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp,
 			       size_t size, size_t *remainder)
 {
@@ -3432,13 +3441,12 @@ static int __obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp,
 	return ret;
 }
 
-static int obj_cgroup_charge_account(struct obj_cgroup *objcg, gfp_t gfp, size_t size,
-				     struct pglist_data *pgdat, enum node_stat_item idx)
+int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 {
 	size_t remainder;
 	int ret;
 
-	if (likely(consume_obj_stock(objcg, size, pgdat, idx)))
+	if (likely(consume_obj_stock(objcg, size)))
 		return 0;
 
 	/*
@@ -3465,20 +3473,15 @@ static int obj_cgroup_charge_account(struct obj_cgroup *objcg, gfp_t gfp, size_t
 	 * race.
 	 */
 	ret = __obj_cgroup_charge(objcg, gfp, size, &remainder);
-	if (!ret && (remainder || pgdat))
-		refill_obj_stock(objcg, remainder, false, size, pgdat, idx);
+	if (!ret && remainder)
+		refill_obj_stock(objcg, remainder, false);
 
 	return ret;
 }
 
-int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
-{
-	return obj_cgroup_charge_account(objcg, gfp, size, NULL, 0);
-}
-
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 {
-	refill_obj_stock(objcg, size, true, 0, NULL, 0);
+	refill_obj_stock(objcg, size, true);
 }
 
 static inline size_t obj_full_size(struct kmem_cache *s)
@@ -3493,6 +3496,7 @@ static inline size_t obj_full_size(struct kmem_cache *s)
 bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				  gfp_t flags, size_t size, void **p)
 {
+	size_t obj_size = obj_full_size(s);
 	struct obj_cgroup *objcg;
 	struct slab *slab;
 	unsigned long off;
@@ -3533,6 +3537,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	for (i = 0; i < size; i++) {
 		unsigned long obj_exts;
 		struct slabobj_ext *obj_ext;
+		struct obj_stock_pcp *stock;
 
 		slab = virt_to_slab(p[i]);
 
@@ -3552,9 +3557,20 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		 * TODO: we could batch this until slab_pgdat(slab) changes
 		 * between iterations, with a more complicated undo
 		 */
-		if (obj_cgroup_charge_account(objcg, flags, obj_full_size(s),
-					slab_pgdat(slab), cache_vmstat_idx(s)))
-			return false;
+		stock = trylock_stock();
+		if (!stock || !__consume_obj_stock(objcg, stock, obj_size)) {
+			size_t remainder;
+
+			unlock_stock(stock);
+			if (__obj_cgroup_charge(objcg, flags, obj_size, &remainder))
+				return false;
+			stock = trylock_stock();
+			if (remainder)
+				__refill_obj_stock(objcg, stock, remainder, false);
+		}
+		__account_obj_stock(objcg, stock, obj_size,
+				    slab_pgdat(slab), cache_vmstat_idx(s));
+		unlock_stock(stock);
 
 		obj_exts = slab_obj_exts(slab);
 		get_slab_obj_exts(obj_exts);
@@ -3576,6 +3592,7 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
 		struct slabobj_ext *obj_ext;
+		struct obj_stock_pcp *stock;
 		unsigned int off;
 
 		off = obj_to_index(s, slab, p[i]);
@@ -3585,8 +3602,13 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			continue;
 
 		obj_ext->objcg = NULL;
-		refill_obj_stock(objcg, obj_size, true, -obj_size,
-				 slab_pgdat(slab), cache_vmstat_idx(s));
+
+		stock = trylock_stock();
+		__refill_obj_stock(objcg, stock, obj_size, true);
+		__account_obj_stock(objcg, stock, -obj_size,
+				    slab_pgdat(slab), cache_vmstat_idx(s));
+		unlock_stock(stock);
+
 		obj_cgroup_put(objcg);
 	}
 }
-- 
2.53.0


