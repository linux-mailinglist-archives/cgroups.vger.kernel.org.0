Return-Path: <cgroups+bounces-7920-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E81CBAA3C8D
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878151B65A65
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4CE2E3374;
	Tue, 29 Apr 2025 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikDd6VMs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9902DFA35;
	Tue, 29 Apr 2025 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969941; cv=none; b=Ge5JvSmvZSYleupK5T6i58QLDD33c3BVyxWwOzJtQBbQ4vY2FHAmS2QZBk5sPI4DE1sTaEohZbwI4npl4CQ+NwnY7sgs2y76SxBScy8S+iLvsxucyK0ouglG+1Z5GG5w5TDEBeOevRlZmbGQFrR1Vwpyuh0u3QOrhWMMj1eMSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969941; c=relaxed/simple;
	bh=NKb1h0r/ekGqJhrCCk5g0MiE9b26osXSCs9ZAg+i8m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8ZIQpoLBrJvIeQjIvjAxvE+8EUz0EhTHij4JDp9G8C3cpw4bwePCYq44mGSEgBMyMl31RDN27b8I+qX+AAPUPtr3ZZff5pTPTTXQ6FMBvD2rIORtL2U7y0eXti/HDu0auOewSCajBdMqWmdCr83rWj61aQLIYjldSSlb3XEPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikDd6VMs; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e731a56e111so4423421276.1;
        Tue, 29 Apr 2025 16:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969938; x=1746574738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDaYNr62oZV/U6TDpPRjwWYHhp0Fz9Nf+NOXmppHJcs=;
        b=ikDd6VMsDbsy6qw2EXAtpehvoHDnE/CfJeGqOmRLK/BGgV/9fIcwlV0qODxV4mB2Dw
         PXC8/J8Q9pIipJrcyKmoS+Pf/fnrOyQQQaxiyo1coh4XLEHOTWN/iCfgDcVWFgERk5yC
         y3mtjp0h/b54dfe1M7hZwf0Nc8vqsEEVo4v8Hq8WgtLi0Onll133qALWDVSB/x1jo/8z
         MAoOiuBTAAZeb8tXykWMhTUPTMycsdY1jgU4aZrFPMeLdSUY7+cP2/E3gHbW+MF3UYPo
         ZO9xNCVPabcFez6FhD8lFxqXX9Pfl8WzAH1af78+vkxKSCLmp4t1BaZLdbZ3KYa8VAdY
         4O0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969938; x=1746574738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDaYNr62oZV/U6TDpPRjwWYHhp0Fz9Nf+NOXmppHJcs=;
        b=RYdU3SWtMuX8AmU4gvR5JRmnyzeo0b70oEiRmMatrYVFrN/b/8rKP+KdIVCDP5OIu3
         WCeiPaiZkRtuv7RCNNr4t0uvad7gksCs8IgtWtTVtTT60R3BUvcY4K0LLCAxUeCYIMtP
         o17wzm8zyCNgzhuWN3f+k60cY49P7xzyV51ptuzv1OP6BrUVWPdRxwJNg6EkKhf7Ro/g
         Voe6XZHcOLlpKCUiVmNAOn3G7O6LIJTYq8llPQt+Tg/v13YvKy1158GhuzOmNHoi5/kj
         +Wrlm16QINTUaXEnMBOYVnbiesclwDiCZ+vMZ6T4wKwyS8fsHHcD13jOen4Ic39wDYm7
         IIKA==
X-Forwarded-Encrypted: i=1; AJvYcCUovkN1ATi+OIIK1mqLFgVQNxDUPzM8g82AAVRZZwvMfvYBe9H8XvW6R84dTPiJyu3/rQIR2kF6@vger.kernel.org, AJvYcCWLjbj/2fnjPT7EVKRXBlBX7eAcGwmPEoB2wX3AjYlJgE/MIpiNXDn1J9oy2dfv06XCOLleBIDfjZk=@vger.kernel.org, AJvYcCXUyTiy2sQEkk+iFe+dx5nmX/n7/a3L+WeHGeLL5wMdPu8+h90n84bkGC0Q4EUUgJ8egnoMNBE/3+vfUyGR@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkxHkqozykdKmH5rJCU/zQSpbAn0xHqEG+bfAeg+mS4dhspRe
	06B12n3oMriog336uB6PUZrlpWm/V8ZCcQJY+3nQJ8PlKGjCQTZS
X-Gm-Gg: ASbGncsI71BgHaCFLRFnUIdJg4NyBlZlzmzXW8d+GXbZEa5nXLIDT+6uZjLoFKe2cok
	2QP2tDPJC1nsQaRvHWgdIfgOcNeGK51LDuIfDmomX0hvA9Bj+jA3pN6mWjPI4m1JXyz+lc9Uwon
	6nAYFPXLX0QEH4aHSOcvwC40+Mie7I+dJPk4A8Rtx4hi6nji/b/KQiJ23Wgtg3mKBW061wZS2sk
	KBY04TioMUTyYTf1WEaWHYrpv273kb+2D25iU3FyrJ80feJWcM3DnvnbYDwyGZILyWJopBVa4fD
	39bpAJATbvRz6z/ttpa/QYGRhg3Wei7j
X-Google-Smtp-Source: AGHT+IHn6mOAWGkqEbsXafeS7GzpaJiDdkS+3cjQx5q2B086gbKX/FA06JCBoeWXljznIEoDhpFWCg==
X-Received: by 2002:a05:6902:4607:b0:e73:3147:e7c with SMTP id 3f1490d57ef6-e73e7a5043amr1563404276.0.1745969938064;
        Tue, 29 Apr 2025 16:38:58 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7412f1386esm63843276.22.2025.04.29.16.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:38:57 -0700 (PDT)
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
	linux-pm@vger.kernel.org,
	peterx@redhat.com
Subject: [RFC PATCH v2 09/18] swap: implement the swap_cgroup API using virtual swap
Date: Tue, 29 Apr 2025 16:38:37 -0700
Message-ID: <20250429233848.3093350-10-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429233848.3093350-1-nphamcs@gmail.com>
References: <20250429233848.3093350-1-nphamcs@gmail.com>
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


