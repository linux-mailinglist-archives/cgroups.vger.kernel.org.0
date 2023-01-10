Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5A166394F
	for <lists+cgroups@lfdr.de>; Tue, 10 Jan 2023 07:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjAJG0A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Jan 2023 01:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjAJGZ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Jan 2023 01:25:58 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC792FDB;
        Mon,  9 Jan 2023 22:25:56 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A5HmNF011788;
        Tue, 10 Jan 2023 06:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=8JkCv+NV6PqjEH1P0gWr8z4uuHVpN6agMR3v9eR6cvI=;
 b=kCcwpnH4+b1RbstOT3uVHLY4VspyvOm/FKnghDg7Rqzqr48xe0pGs3eMBTJtHzcdiWTR
 EbBQyv3BGiFOXSby2qPvL+O+hVLNeVQO5SA3j+p/0E1gteNizesk0omen8N4HKDCbleT
 /hHE3GiZEM+ie3k+EGqYJ+nLPDEyKnz3Hy+mZfH6zEjkMjdxzNfXJnGzzHnfnwckeXr2
 4qYFZACJNxHHyWPVI+mRrVQzMOdEbtps7/i7H9k9a8qsdgjPBMazC0kePgx6jd4G/i5f
 BKrsvHhVxtmjTc3d3LzT7GHj2t0Bh3dDGh/jDWW7Rl6sy3ziW9lWILYL4YacZ3A1dSik 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n111qt7a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 06:25:28 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30A6LxiU005977;
        Tue, 10 Jan 2023 06:25:28 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n111qt79y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 06:25:28 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30A3U4Ev007443;
        Tue, 10 Jan 2023 06:25:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3my0c7m6d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 06:25:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30A6PQnL66388314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 06:25:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06EF95805D;
        Tue, 10 Jan 2023 06:25:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 083335805C;
        Tue, 10 Jan 2023 06:25:22 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.109.205.160])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jan 2023 06:25:21 +0000 (GMT)
X-Mailer: emacs 29.0.60 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Yuanchu Xie <yuanchu@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yuanchu Xie <yuanchu@google.com>
Subject: Re: [RFC PATCH 0/2] mm: multi-gen LRU: working set extensions
In-Reply-To: <20221214225123.2770216-1-yuanchu@google.com>
References: <20221214225123.2770216-1-yuanchu@google.com>
Date:   Tue, 10 Jan 2023 11:55:18 +0530
Message-ID: <87k01ulxdd.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NbtpzACN7KtQ6ZN1evE6-1wqWOfuGVBn
X-Proofpoint-GUID: 17EcHdWVxE5URnXUJJgzbWcprYSI_xok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_01,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=506 lowpriorityscore=0
 clxscore=1011 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Yuanchu Xie <yuanchu@google.com> writes:

> Introduce a way of monitoring the working set of a workload, per page
> type and per NUMA node, with granularity in minutes. It has page-level
> granularity and minimal memory overhead by building on the
> Multi-generational LRU framework, which already has most of the
> infrastructure and is just missing a useful interface.
>
> MGLRU organizes pages in generations, where an older generation contains
> colder pages, and aging promotes the recently used pages into the young
> generation and creates a new one. The working set size is how much
> memory an application needs to keep working, the amount of "hot" memory
> that's frequently used. The only missing pieces between MGLRU
> generations and working set estimation are a consistent aging cadence
> and an interface; we introduce the two additions.

So with kold kthread do we need aging in reclaim ? Should we switch reciam
to wakeup up kold kthread to do aging instead of doing try_to_inc_max_seq?
This would also help us to try different aging mechanism which can run
better in a kthread. 


>
> Periodic aging
> ======
> MGLRU Aging is currently driven by reclaim, so the amount of time
> between generations is non-deterministic. With memcgs being aged
> regularly, MGLRU generations become time-based working set information.
>
> - memory.periodic_aging: a new root-level only file in cgroupfs
> Writing to memory.periodic_aging sets the aging interval and opts into
> periodic aging.
> - kold: a new kthread that ages memcgs based on the set aging interval.
>
> Page idle age stats
> ======
> - memory.page_idle_age: we group pages into idle age ranges, and present
>   the number of pages per node per pagetype in each range. This
>   aggregates the time information from MGLRU generations hierarchically.
>
> Use case: proactive reclaimer
> ======
> The proactive reclaimer sets the aging interval, and periodically reads
> the page idle age stats, forming a working set estimation, which it then
> calculates an amount to write to memory.reclaim.
>
> With the page idle age stats, a proactive reclaimer could calculate a
> precise amount of memory to reclaim without continuously probing and
> inducing reclaim.
>
> A proactive reclaimer that uses a similar interface is used in the
> Google data centers.
>
> Use case: workload introspection
> ======
> A workload may use the working set estimates to adjust application
> behavior as needed, e.g. preemptively killing some of its workers to
> avoid its working set thrashing, or dropping caches to fit within a
> limit.
> It can also be valuable to application developers, who can benefit from
> an out-of-the-box overview of the application's usage behaviors.
>
> TODO List
> ======
> - selftests
> - a userspace demonstrator combining periodic aging, page idle age
>   stats, memory.reclaim, and/or PSI
>
> Open questions
> ======
> - MGLRU aging mechanism has a flag called force_scan. With
>   force_scan=false, invoking MGLRU aging when an lruvec has a maximum
>   number of generations does not actually perform aging.
>   However, with force_scan=true, MGLRU moves the pages in the oldest
>   generation to the second oldest generation. The force_scan=true flag
>   also disables some optimizations in MGLRU's page table walks.
>   The current patch sets force_scan=true, so that periodic aging would
>   work without a proactive reclaimer evicting the oldest generation.
>
> - The page idle age format uses a fixed set of time ranges in seconds.
>   I have considered having it be based on the aging interval, or just
>   compiling the raw timestamps.
>   With the age ranges based on the aging interval, a memcg that's
>   undergoing memcg reclaim might have its generations in the 10
>   seconds range, and a much longer aging interval would obscure this
>   fact.
>   The raw timestamps from MGLRU could lead to a very large file when
>   aggregated hierarchically.
>
> Yuanchu Xie (2):
>   mm: multi-gen LRU: periodic aging
>   mm: multi-gen LRU: cgroup working set stats
>
>  include/linux/kold.h   |  44 ++++++++++
>  include/linux/mmzone.h |   4 +-
>  mm/Makefile            |   3 +
>  mm/kold.c              | 150 ++++++++++++++++++++++++++++++++
>  mm/memcontrol.c        | 188 +++++++++++++++++++++++++++++++++++++++++
>  mm/vmscan.c            |  35 +++++++-
>  6 files changed, 422 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/kold.h
>  create mode 100644 mm/kold.c
>
> -- 
> 2.39.0.314.g84b9a713c41-goog
