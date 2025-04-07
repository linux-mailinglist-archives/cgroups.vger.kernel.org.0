Return-Path: <cgroups+bounces-7409-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEC4A7F157
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9031E3B468B
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85DA22E3E3;
	Mon,  7 Apr 2025 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIxznimm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705822CBE4;
	Mon,  7 Apr 2025 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069351; cv=none; b=VzBDNRaAFu6QC/zdqo5mKgirfQVNIAgOKcBV2+p2XU2Za9izALRloJlxts9nC78vhJwJp9ZDjqycqwle7UM7RZaQuT9EwvKILkw1aHIWbbSp8uHhCSA3Q7SEU6qXnRMvjnPtzlWXwhW/sNDSfM3bsUM+m5Jcq8h5jMr7V13igO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069351; c=relaxed/simple;
	bh=NKb1h0r/ekGqJhrCCk5g0MiE9b26osXSCs9ZAg+i8m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmRY51TJj7yYgxNltwWeh9x/0MWcI3I4eNY3iQDBcQvAFjoiA6fmz1i5jlG28adn+k4pJevkPlaZWSWLlkPiJi8Mfa1N6Tdv2x5UpNJVX9KzTcq5PnAV8H6MmNDmNv93COQPS6yTY+VXunkw3v+0/o0Qg/bbaGf9vt0DdcJbvPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIxznimm; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6febbd3b75cso46442477b3.0;
        Mon, 07 Apr 2025 16:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069348; x=1744674148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDaYNr62oZV/U6TDpPRjwWYHhp0Fz9Nf+NOXmppHJcs=;
        b=XIxznimmkxFN/eZOyqV2jnFcqWzY6pXQyMFreAtiFGfM4C39Q3W2nq9dzEVJgwibmc
         QdifXs7HIsjd89VFBTPchICFJZ9YdpRqAwTgi88tO59cEMDkHMSBy/EDi622xa59jkNz
         jvm/ZA35isLs55/mb8Y8rJeO0tXDhYxIA/IinO6rz/i/6gYNDMi/iunIbo+fJNtqjm+v
         6U6Yle7ReY/RAfr6T4apax+B1wEnK5uIEUk1XJPBtLHVPLBOCTNO4ioX52lgSz+1MR23
         qISPNTimUUG5wpkekyvu+odsnejNPR+RNgvRhEjq7/wGeEz2429QVMuXhQG6sQ+OxiZ2
         odjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069348; x=1744674148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDaYNr62oZV/U6TDpPRjwWYHhp0Fz9Nf+NOXmppHJcs=;
        b=TgxnO0hl277uFl+//wL8qAXCq91nYABQm5+ZhbZu6y7u2ENMrxzEOqwDlEd0KYQy6B
         +N2XTDTJDJHGTCHsiAG/LN82gNprEUc1SDtVbyXkJYKHgyN8dIddCPHY9iDeWhHFXQWF
         NCT8TiBSMM6QnmsoglfAmm2m1TBoWMUneo4FNfbrc4Uh4RSUFSzwD53gJv/zOsEXySqK
         lydVd3LgX4GC+7EDjTVzZ9MeIF0j6qvua3Z2qMQwaYTxiBjaxingL/NgF42ccQFASbPs
         wDIkZ7UiMeCE9Zr4KbHxrdIB7BPlTGdZF9aWmUCPIiXW5lh4zmy4JdLrV9XflzWHrsyE
         qQag==
X-Forwarded-Encrypted: i=1; AJvYcCUHaBP7fI5kJyLijaQAb2NjuWaqR+eXn3heo8gkyRlBXdZ0eyjdPj1Hk1Uuo0GRE2jQd2/fd8C/Sh8=@vger.kernel.org, AJvYcCUk6MwZJXmPvBofKNKfusFMxXAoOaKH4j7/G62u5VULszaltqw9ZaiL4+2lfk3yDFLvgCg2pDVK@vger.kernel.org, AJvYcCXRntvnnoipWOswWwvW5yN5afNysFe67gmswhh4ZXNkhyVWy26zqhqu3zPxtaJmDuUa5uy7shoGwYGN0h3k@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xh4gjEYbfL8JUqJzBZzqTTETONGMaaTEuNMXAoiyqZk9/tW7
	+dT7E7mUMKcyl3GgMQNf9OSR2zK0YC4Yo6rgFbKCwdskDiWlIP+t
X-Gm-Gg: ASbGncscwaFDS5GddpeGYKAVs/E5+Yj3Aw/WQkXRfzAyJvBVZ3QywpaKLiRUkkZxP7m
	5510Q1Ti3EQvLK06DBzUgDBFFZcpatL+NODVnuB4mnaodl20Wfp378VPswMFveIe3LincQHlUJW
	y4qMfUVyprf0WyLjlRKZrhDviOZ/xvzctiyfoSwHbSwm7O0eFSFXhHoBtCwZ9BIUTyf2TgbWuUk
	Ro1e9XZ5YlEYuhwVhBKx0/GABeP/5MskiNq6eA/0+Tm1seKknFSFpjDsdXr/7quBi/+/Z0QsEyj
	LtDFZJzhvfUTpjJLe2W8c6Xqn2hNnEq6Ozs=
X-Google-Smtp-Source: AGHT+IHmrBK25BV1qDKlvbY5RSNbeCthvTW9ZJSLIvxYr/6iVq0MDu+RnyoEtmVX9dC9D27ahdmdJA==
X-Received: by 2002:a05:690c:6089:b0:6ff:1c8d:fbfc with SMTP id 00721157ae682-703e16250b7mr266617397b3.31.1744069348608;
        Mon, 07 Apr 2025 16:42:28 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1fa73e9sm27925297b3.106.2025.04.07.16.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:28 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 07/14] swap: implement the swap_cgroup API using virtual swap
Date: Mon,  7 Apr 2025 16:42:08 -0700
Message-ID: <20250407234223.1059191-8-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250407234223.1059191-1-nphamcs@gmail.com>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once we decouple a swap entry from its backing store via the virtual
swap, we can no longer statically allocate an array to store the swap
entries' cgroup information. Move it to the swap descriptor.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/Makefile |  2 ++
 mm/vswap.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/mm/Makefile b/mm/Makefile
index b7216c714fa1..35f2f282c8da 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -101,8 +101,10 @@ obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
 ifdef CONFIG_SWAP
+ifndef CONFIG_VIRTUAL_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
+endif
 obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
 obj-$(CONFIG_GUP_TEST) += gup_test.o
 obj-$(CONFIG_DMAPOOL_TEST) += dmapool_test.o
diff --git a/mm/vswap.c b/mm/vswap.c
index 23a05c3393d8..3792fa7f766b 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -27,10 +27,14 @@
  *
  * @slot: The handle to the physical swap slot backing this page.
  * @rcu: The RCU head to free the descriptor with an RCU grace period.
+ * @memcgid: The memcg id of the owning memcg, if any.
  */
 struct swp_desc {
 	swp_slot_t slot;
 	struct rcu_head rcu;
+#ifdef CONFIG_MEMCG
+	atomic_t memcgid;
+#endif
 };
 
 /* Virtual swap space - swp_entry_t -> struct swp_desc */
@@ -122,8 +126,10 @@ static swp_entry_t vswap_alloc(int nr)
 		return (swp_entry_t){0};
 	}
 
-	for (i = 0; i < nr; i++)
+	for (i = 0; i < nr; i++) {
 		descs[i]->slot.val = 0;
+		atomic_set(&descs[i]->memcgid, 0);
+	}
 
 	xa_lock(&vswap_map);
 	if (nr == 1) {
@@ -352,6 +358,70 @@ swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
 	return entry ? (swp_entry_t){xa_to_value(entry)} : (swp_entry_t){0};
 }
 
+#ifdef CONFIG_MEMCG
+static unsigned short vswap_cgroup_record(swp_entry_t entry,
+				unsigned short memcgid, unsigned int nr_ents)
+{
+	struct swp_desc *desc;
+	unsigned short oldid, iter = 0;
+
+	XA_STATE(xas, &vswap_map, entry.val);
+
+	rcu_read_lock();
+	xas_for_each(&xas, desc, entry.val + nr_ents - 1) {
+		if (xas_retry(&xas, desc))
+			continue;
+
+		oldid = atomic_xchg(&desc->memcgid, memcgid);
+		if (!iter)
+			iter = oldid;
+		VM_WARN_ON(iter != oldid);
+	}
+	rcu_read_unlock();
+
+	return oldid;
+}
+
+void swap_cgroup_record(struct folio *folio, unsigned short memcgid,
+			swp_entry_t entry)
+{
+	unsigned short oldid =
+		vswap_cgroup_record(entry, memcgid, folio_nr_pages(folio));
+
+	VM_WARN_ON(oldid);
+}
+
+unsigned short swap_cgroup_clear(swp_entry_t entry, unsigned int nr_ents)
+{
+	return vswap_cgroup_record(entry, 0, nr_ents);
+}
+
+unsigned short lookup_swap_cgroup_id(swp_entry_t entry)
+{
+	struct swp_desc *desc;
+	unsigned short ret;
+
+	/*
+	 * Note that the virtual swap slot can be freed under us, for instance in
+	 * the invocation of mem_cgroup_swapin_charge_folio. We need to wrap the
+	 * entire lookup in RCU read-side critical section, and double check the
+	 * existence of the swap descriptor.
+	 */
+	rcu_read_lock();
+	desc = xa_load(&vswap_map, entry.val);
+	ret = desc ? atomic_read(&desc->memcgid) : 0;
+	rcu_read_unlock();
+	return ret;
+}
+
+int swap_cgroup_swapon(int type, unsigned long max_pages)
+{
+	return 0;
+}
+
+void swap_cgroup_swapoff(int type) {}
+#endif /* CONFIG_MEMCG */
+
 int vswap_init(void)
 {
 	swp_desc_cache = KMEM_CACHE(swp_desc, 0);
-- 
2.47.1


