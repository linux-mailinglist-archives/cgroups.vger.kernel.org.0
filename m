Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1770A2EAFB3
	for <lists+cgroups@lfdr.de>; Tue,  5 Jan 2021 17:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbhAEQJU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jan 2021 11:09:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55108 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbhAEQJT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jan 2021 11:09:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105FtgeL138082;
        Tue, 5 Jan 2021 16:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=yNni/tK57EDeoptLP5V7FbpXjviboZZ0FQ2qjDTGI0k=;
 b=BZdT1mw9MX1u0oGQ6e+ZpQc4eAG3Vtt1aCAuGVfcz2ES7ceOfYdWhsPkQCpBdIihKl3o
 vt66aqLlVEv1D/mehQfNancEmNq/jyBEEs13OyY7FziAV8kFMYxxOIH/EP4xAc2LtCOL
 LjVRi0TkSZx8K4nxFlMqtzMNYR7iNtVLZ4ldGF/vljYyPRjy6KDVExFleoRU2mpOYhK2
 UkBgX2g0zPpXVbD+jjSkbx60zTJNZVQLdccrgeDmZ3ByR/2za0pBFwNrW61w4jk+ZnDn
 phduzwwMovodnMR3rXUC0aS6SG+iRNKCTfgtzZUml3MsRExCkdBj0KlN/AN91f5J46fc YQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35tg8r1gwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 16:08:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105Fuk5u187374;
        Tue, 5 Jan 2021 16:08:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 35v1f8smts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 16:08:32 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 105G8TBS017915;
        Tue, 5 Jan 2021 16:08:29 GMT
Received: from instance-20201023-0137.osdevelopmeniad.oraclevcn.com (/100.100.231.115)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 16:08:28 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Imran Khan <imran.f.khan@oracle.com>
Subject: [RFC PATCH] mm/memcontrol: Increase threshold for draining per-cpu stocked bytes.
Date:   Tue,  5 Jan 2021 16:07:42 +0000
Message-Id: <1609862862-3573-1-git-send-email-imran.f.khan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050099
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

While allocating objects whose size is multiple of PAGE_SIZE,
say kmalloc-4K, we charge one page for extra bytes corresponding
to the obj_cgroup membership pointer and remainder of the charged
page gets added to per-cpu stocked bytes. If this allocation is
followed by another allocation of the same size, the stocked bytes
will not suffice and thus we endup charging an extra page
again for membership pointer and remainder of this page gets added
to per-cpu stocked bytes. This second addition will cause amount of
stocked bytes to go beyond PAGE_SIZE and hence will result in
invocation of drain_obj_stock.

So if we are in a scenario where we are consecutively allocating,
several PAGE_SIZE multiple sized objects, the stocked bytes will
never be enough to suffice a request and every second request will
trigger draining of stocked bytes.

For example invoking __alloc_skb multiple times with
2K < packet size < 4K will give a call graph like:

__alloc_skb
    |
    |__kmalloc_reserve.isra.61
    |    |
    |    |__kmalloc_node_track_caller
    |    |    |
    |    |    |slab_pre_alloc_hook.constprop.88
    |    |     obj_cgroup_charge
    |    |    |    |
    |    |    |    |__memcg_kmem_charge
    |    |    |    |    |
    |    |    |    |    |page_counter_try_charge
    |    |    |    |
    |    |    |    |refill_obj_stock
    |    |    |    |    |
    |    |    |    |    |drain_obj_stock.isra.68
    |    |    |    |    |    |
    |    |    |    |    |    |__memcg_kmem_uncharge
    |    |    |    |    |    |    |
    |    |    |    |    |    |    |page_counter_uncharge
    |    |    |    |    |    |    |    |
    |    |    |    |    |    |    |    |page_counter_cancel
    |    |    |
    |    |    |
    |    |    |__slab_alloc
    |    |    |    |
    |    |    |    |___slab_alloc
    |    |    |    |
    |    |    |slab_post_alloc_hook

This frequent draining of stock bytes and resultant charging of pages
increases the CPU load and hence deteriorates the scheduler latency.

The above mentioned scenario and it's impact can be seen by running
hackbench with large packet size on v5.8 and subsequent kernels. The
deterioration in hackbench number starts appearing from v5.9 kernel,
'commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
instead of pages")'.

Increasing the draining limit to twice of KMALLOC_MAX_CACHE_SIZE
(a safe upper limit for size of slab cache objects), will avoid draining
of stock, every second allocation request, for the above mentioned
scenario and hence will reduce the CPU load for such cases. For
allocation of smaller objects or other allocation patterns the behaviour
will be same as before.

This change increases the draining threshold for per-cpu stocked bytes
from PAGE_SIZE to KMALLOC_MAX_CACHE_SIZE * 2.

Below are the hackbench numbers with and without this change on
v5.10.0-rc7.

Without this change:
    # hackbench process 10 1000 -s 100000
    Running in process mode with 10 groups using 40 file descriptors
    each (== 400 tasks)
    Each sender will pass 100 messages of 100000 bytes
    Time: 4.401

    # hackbench process 10 1000 -s 100000
    Running in process mode with 10 groups using 40 file descriptors
    each (== 400 tasks)
    Each sender will pass 100 messages of 100000 bytes
    Time: 4.470

With this change:
    # hackbench process 10 1000 -s 100000
    Running in process mode with 10 groups using 40 file descriptors
    each (== 400 tasks)
    Each sender will pass 100 messages of 100000 bytes
    Time: 3.782

    # hackbench process 10 1000 -s 100000
    Running in process mode with 10 groups using 40 file descriptors
    each (== 400 tasks)
    Each sender will pass 100 messages of 100000 bytes
    Time: 3.827

As can be seen the change gives an improvement of about 15% in hackbench
numbers.
Also numbers obtained with the change are inline with those obtained
from v5.8 kernel.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0d74b80..c04633c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3256,7 +3256,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	}
 	stock->nr_bytes += nr_bytes;
 
-	if (stock->nr_bytes > PAGE_SIZE)
+	if (stock->nr_bytes > KMALLOC_MAX_CACHE_SIZE * 2)
 		drain_obj_stock(stock);
 
 	local_irq_restore(flags);
-- 
1.8.3.1

