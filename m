Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B40C5F0CA4
	for <lists+cgroups@lfdr.de>; Fri, 30 Sep 2022 15:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiI3NpE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Sep 2022 09:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiI3NpC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Sep 2022 09:45:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608432715D;
        Fri, 30 Sep 2022 06:44:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UAjgnD006730;
        Fri, 30 Sep 2022 13:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=KONBAx9m0CqP1zC/8vneM0xJmvBinGNKQZ5dphHO1Ng=;
 b=tiMELkw4uG0n1ek9pdLiaOq3mS96MlpguT9i3pU7wzZUH4B1dqclTmcxYr77zvHQM6dv
 szOfozlTnRlpBtrg6Ik8ge1kFnJxkWp9P7kjHkukn1AQ88vako6wTFZamz7gINm9DFWR
 89xm9/kKSN+VSx/3imZzX+y2tZH0/9hkrFnuiy6rKtr0yB+zcVWKvtM+KEcEFeFjoPu6
 vZinKUM9QxDeAcHBSuOktEEDvwY8RKVIY6O3/F0GvjLLuEUZer9ljuzQDu+Qu3OLnMaO
 nUNUbbvW2zzmoWXw1VCH5Sjl+bX7xNjncpLpN3jC8g+L/tDS7NDv3LIb8wiM1mz1a3SD zA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstpy3hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 13:44:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28UDgwFg022245;
        Fri, 30 Sep 2022 13:44:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvhvwpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 13:44:45 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28UDijdG026109;
        Fri, 30 Sep 2022 13:44:45 GMT
Received: from jarvis3.oracle.com (dhcp-10-76-56-143.vpn.oracle.com [10.76.56.143])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3jtpvhvwkf-1;
        Fri, 30 Sep 2022 13:44:44 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Kamalesh Babulal <kamalesh.babulal@oracle.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memcontrol: use mem_cgroup_is_root() helper
Date:   Fri, 30 Sep 2022 19:14:33 +0530
Message-Id: <20220930134433.338103-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300087
X-Proofpoint-ORIG-GUID: S_M1zDYLjuTCz-R8lP6bxSCON6Z7FMPo
X-Proofpoint-GUID: S_M1zDYLjuTCz-R8lP6bxSCON6Z7FMPo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Replace the checks for memcg is root memcg, with mem_cgroup_is_root()
helper.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 mm/memcontrol.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5..99b3d0cbd426 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1148,7 +1148,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 	 * cgroup root (root_mem_cgroup). So we have to handle
 	 * dead_memcg from cgroup root separately.
 	 */
-	if (last != root_mem_cgroup)
+	if (!mem_cgroup_is_root(last))
 		__invalidate_reclaim_iterators(root_mem_cgroup,
 						dead_memcg);
 }
@@ -1172,7 +1172,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	struct mem_cgroup *iter;
 	int ret = 0;
 
-	BUG_ON(memcg == root_mem_cgroup);
+	BUG_ON(mem_cgroup_is_root(memcg));
 
 	for_each_mem_cgroup_tree(iter, memcg) {
 		struct css_task_iter it;
@@ -1201,7 +1201,7 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
 	memcg = folio_memcg(folio);
 
 	if (!memcg)
-		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != root_mem_cgroup, folio);
+		VM_BUG_ON_FOLIO(!mem_cgroup_is_root(lruvec_memcg(lruvec)), folio);
 	else
 		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != memcg, folio);
 }
@@ -1982,7 +1982,7 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 	rcu_read_lock();
 
 	memcg = mem_cgroup_from_task(victim);
-	if (memcg == root_mem_cgroup)
+	if (mem_cgroup_is_root(memcg))
 		goto out;
 
 	/*
@@ -2940,7 +2940,7 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg = NULL;
 
-	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
+	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
 		objcg = rcu_dereference(memcg->objcg);
 		if (objcg && obj_cgroup_tryget(objcg))
 			break;
@@ -7073,7 +7073,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 
 	rcu_read_lock();
 	memcg = mem_cgroup_from_task(current);
-	if (memcg == root_mem_cgroup)
+	if (mem_cgroup_is_root(memcg))
 		goto out;
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
 		goto out;
@@ -7208,7 +7208,7 @@ static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
 		 * The root cgroup cannot be destroyed, so it's refcount must
 		 * always be >= 1.
 		 */
-		if (WARN_ON_ONCE(memcg == root_mem_cgroup)) {
+		if (WARN_ON_ONCE(mem_cgroup_is_root(memcg))) {
 			VM_BUG_ON(1);
 			break;
 		}
@@ -7369,7 +7369,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 
 	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return nr_swap_pages;
-	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
+	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
 		nr_swap_pages = min_t(long, nr_swap_pages,
 				      READ_ONCE(memcg->swap.max) -
 				      page_counter_read(&memcg->swap));
@@ -7391,7 +7391,7 @@ bool mem_cgroup_swap_full(struct page *page)
 	if (!memcg)
 		return false;
 
-	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
+	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
 		unsigned long usage = page_counter_read(&memcg->swap);
 
 		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
@@ -7556,7 +7556,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 		return true;
 
 	original_memcg = get_mem_cgroup_from_objcg(objcg);
-	for (memcg = original_memcg; memcg != root_mem_cgroup;
+	for (memcg = original_memcg; !mem_cgroup_is_root(memcg);
 	     memcg = parent_mem_cgroup(memcg)) {
 		unsigned long max = READ_ONCE(memcg->zswap_max);
 		unsigned long pages;

base-commit: 987a926c1d8a40e4256953b04771fbdb63bc7938
-- 
2.34.3

