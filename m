Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2055A89D
	for <lists+cgroups@lfdr.de>; Sat, 25 Jun 2022 12:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiFYJoE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Jun 2022 05:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiFYJoE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Jun 2022 05:44:04 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E9E36148
        for <cgroups@vger.kernel.org>; Sat, 25 Jun 2022 02:44:02 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b21so4728679ljf.1
        for <cgroups@vger.kernel.org>; Sat, 25 Jun 2022 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=HHB0HiD0LfT4KAnBHG/5IT4f6jchD/lpeXSDdegmO/0=;
        b=4q8DDHI/VDs0sbgwpDTFVXDdLjVTFa4XUcthupWBfu+DIv8IrQecPraWwswb+CXy4/
         mFEenje9ltJ+KD3tjvrgrg2qKhDazl5wclhMg0r64nV2SrCw0M1bdY4sK8VLilTO+sNO
         bifcq3RpdEGglOrC/0GFG/iXbH6UVNay4ED88oQhaRB36A5yH1JAIN5sysGBXBkoBobI
         v6lclW8E28i79ARkqX8PvmxuPzgwnlfMvwJrtX8rZRS3PpEbkheRxfKmaqlkf5EPzhoZ
         TLBx/wQ1WZHIGC+blMtCteQHDRvfCIBWwqBsCnyzYaLH239g3Xm+ceZa88WPccp8fI2H
         C+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=HHB0HiD0LfT4KAnBHG/5IT4f6jchD/lpeXSDdegmO/0=;
        b=A5tSj9TJTxTR/GOU2+nf9FyYnHlluOfY2CGWVB0NztsKLwwuvlAkp7QN12iIJW8tNC
         ntCYLT040rb921ccrOf09OjVYJSUYPZfJ0ij2pSZCCuwPKxkF1tnxetArnZYtYhxRs5Y
         s/M/eSpRX9si3mJ6Mnx5cWJc0+acJi/DwN4ACfkrZLbRYI+XgW/WKX0viRiuUxCwF8aP
         Db1GHr036N6gJy7FKAss0H0b6z93Awr0iZSqyG+UwVjMubIi/wKfIUFgCDDzXyqCflFp
         SyRNsIRm4Jl7Te6JtO9HxaHyAQwcFUiQaivddjxWJgrNO6y8+hkvg0czZNqlXnSrB2ee
         E8FA==
X-Gm-Message-State: AJIora8hqDCY5C3sW4ctFF8HqXcKvDDfdLreijk7wTTZ3GIGakE61zNK
        f3uew8C4OkGHGHXE/+BNZEtxjw==
X-Google-Smtp-Source: AGRyM1uMGdM5bBZHwFk+X5hIbiEg//rzOGTD2ywC3iLo1e6xJ2VTK9i5Zrl4v7aFrkH9HfhbmmK5iw==
X-Received: by 2002:a05:651c:160a:b0:25a:62a4:9085 with SMTP id f10-20020a05651c160a00b0025a62a49085mr1650158ljq.214.1656150240862;
        Sat, 25 Jun 2022 02:44:00 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651203c800b0047956e49934sm787160lfp.48.2022.06.25.02.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 02:44:00 -0700 (PDT)
Message-ID: <b3225994-2a71-f38c-75b2-5366df848419@openvz.org>
Date:   Sat, 25 Jun 2022 12:43:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH RFC] memcg: avoid idr ids space depletion
To:     Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <YrXDV7uPpmDigh3G@dhcp22.suse.cz>
Content-Language: en-US
In-Reply-To: <YrXDV7uPpmDigh3G@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I tried to increase MEM_CGROUP_ID_MAX to INT_MAX and found no
significant difficulties. What do you think about following patch?
I did not tested it, just checked its compilation.
I hope it allows:
- to avoid memcg id space depletion on normal nodes
- to set up per-container cgroup limit to USHRT_MAX to prevent possible misuse
  and in general use memcg accounting for allocated resources.

Thank you,
	Vasily Averin
---

Michal Hocko pointed that memory controller depends on idr ids which
have a space that is rather limited
 #define MEM_CGROUP_ID_MAX       USHRT_MAX

The limit can be reached on nodes hosted several hundred OS containers
with new distributions running hundreds of services in their own memory
cgroups.

This patch increases the space up to INT_MAX.
---
 include/linux/memcontrol.h  | 15 +++++++++------
 include/linux/swap_cgroup.h | 14 +++++---------
 mm/memcontrol.c             |  6 +++---
 mm/swap_cgroup.c            | 10 ++++------
 4 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 744cde2b2368..e3468550ba20 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -59,10 +59,13 @@ struct mem_cgroup_reclaim_cookie {
 };
 
 #ifdef CONFIG_MEMCG
-
+#ifdef CONFIG_64BIT
+#define MEM_CGROUP_ID_SHIFT	31
+#define MEM_CGROUP_ID_MAX	INT_MAX - 1
+#else
 #define MEM_CGROUP_ID_SHIFT	16
 #define MEM_CGROUP_ID_MAX	USHRT_MAX
-
+#endif
 struct mem_cgroup_id {
 	int id;
 	refcount_t ref;
@@ -852,14 +855,14 @@ void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
 int mem_cgroup_scan_tasks(struct mem_cgroup *,
 			  int (*)(struct task_struct *, void *), void *);
 
-static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
+static inline int mem_cgroup_id(struct mem_cgroup *memcg)
 {
 	if (mem_cgroup_disabled())
 		return 0;
 
 	return memcg->id.id;
 }
-struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
+struct mem_cgroup *mem_cgroup_from_id(int id);
 
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
@@ -1374,12 +1377,12 @@ static inline int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return 0;
 }
 
-static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
+static inline int mem_cgroup_id(struct mem_cgroup *memcg)
 {
 	return 0;
 }
 
-static inline struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
+static inline struct mem_cgroup *mem_cgroup_from_id(int id)
 {
 	WARN_ON_ONCE(id);
 	/* XXX: This should always return root_mem_cgroup */
diff --git a/include/linux/swap_cgroup.h b/include/linux/swap_cgroup.h
index a12dd1c3966c..711dd18380ed 100644
--- a/include/linux/swap_cgroup.h
+++ b/include/linux/swap_cgroup.h
@@ -6,25 +6,21 @@
 
 #ifdef CONFIG_MEMCG_SWAP
 
-extern unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
-					unsigned short old, unsigned short new);
-extern unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
-					 unsigned int nr_ents);
-extern unsigned short lookup_swap_cgroup_id(swp_entry_t ent);
+extern int swap_cgroup_cmpxchg(swp_entry_t ent, int old, int new);
+extern int swap_cgroup_record(swp_entry_t ent, int id, unsigned int nr_ents);
+extern int lookup_swap_cgroup_id(swp_entry_t ent);
 extern int swap_cgroup_swapon(int type, unsigned long max_pages);
 extern void swap_cgroup_swapoff(int type);
 
 #else
 
 static inline
-unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
-				  unsigned int nr_ents)
+unsigned short swap_cgroup_record(swp_entry_t ent, int id, unsigned int nr_ents)
 {
 	return 0;
 }
 
-static inline
-unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
+static inline int lookup_swap_cgroup_id(swp_entry_t ent)
 {
 	return 0;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 275d0c847f05..d4c606a06bcd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5224,7 +5224,7 @@ static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
  *
  * Caller must hold rcu_read_lock().
  */
-struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
+struct mem_cgroup *mem_cgroup_from_id(int id)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	return idr_find(&mem_cgroup_idr, id);
@@ -7021,7 +7021,7 @@ int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 {
 	struct folio *folio = page_folio(page);
 	struct mem_cgroup *memcg;
-	unsigned short id;
+	int id;
 	int ret;
 
 	if (mem_cgroup_disabled())
@@ -7541,7 +7541,7 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 {
 	struct mem_cgroup *memcg;
-	unsigned short id;
+	int id;
 
 	id = swap_cgroup_record(entry, 0, nr_pages);
 	rcu_read_lock();
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 5a9442979a18..76fa5c42e03f 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -15,7 +15,7 @@ struct swap_cgroup_ctrl {
 static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
 
 struct swap_cgroup {
-	unsigned short		id;
+	int		id;
 };
 #define SC_PER_PAGE	(PAGE_SIZE/sizeof(struct swap_cgroup))
 
@@ -94,8 +94,7 @@ static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
  * Returns old id at success, 0 at failure.
  * (There is no mem_cgroup using 0 as its id)
  */
-unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
-					unsigned short old, unsigned short new)
+int swap_cgroup_cmpxchg(swp_entry_t ent, int old, int new)
 {
 	struct swap_cgroup_ctrl *ctrl;
 	struct swap_cgroup *sc;
@@ -123,8 +122,7 @@ unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
  * Returns old value at success, 0 at failure.
  * (Of course, old value can be 0.)
  */
-unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
-				  unsigned int nr_ents)
+int swap_cgroup_record(swp_entry_t ent, int id, unsigned int nr_ents)
 {
 	struct swap_cgroup_ctrl *ctrl;
 	struct swap_cgroup *sc;
@@ -159,7 +157,7 @@ unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
  *
  * Returns ID of mem_cgroup at success. 0 at failure. (0 is invalid ID)
  */
-unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
+int lookup_swap_cgroup_id(swp_entry_t ent)
 {
 	return lookup_swap_cgroup(ent, NULL)->id;
 }
-- 
2.36.1

