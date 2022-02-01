Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDFA4A6808
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 23:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiBAWdV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 17:33:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32098 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229507AbiBAWdU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 17:33:20 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 211MND87017299;
        Tue, 1 Feb 2022 14:33:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=facebook;
 bh=6aZYC9U4ODtPiwTZjMyiJVz7gRGBtWAnCxzLFX4gZoo=;
 b=gM3j/BmwFUGnUGLlNYhqnJV2n3H1iEvJxGVAK6Z2A9U+YVdCThO98NIOMJLZyUxdRqrl
 v9FPCpujg/rB3tPu79TnHYU1pjbIcOqe8HB+a1YFzFTOwIuGNgb7cq95RVMxdV4zUnDp
 lwTGHkxd+FUZoZcnDyleY+Qr2YcSh99KTPM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dyb3hs35e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Feb 2022 14:33:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 14:33:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccxUny3KLOmrnJpEZyelQJRWFi7Ebx3Qn7Mh9e5ZUvpqiGMd4MKnjihxal/WUEw7DOAQvY91448Kr2tl5vfFVndanvJq62SR2wxQATeOkRBFpvs+rA44KJJ38XUYLgSYdYvVK8NF8k3zw5PvOP0EdBSFF0sFqZBkzDYlcI/iAUk9IizohspsXvlDkhGZKtQj8k+mdspok6N/wc0rd3pisPR2400Ea4dyIxRFyPqLI8vWY7bNWPZR4x8BB2Y5O/pJIlC86ToYsre7LM9mvSFXNroJ9+BnVIuHCfwC55kNeE5TU/jcULEvOxlQDQynkQnv39m8conkEw66DFeo0gCSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aZYC9U4ODtPiwTZjMyiJVz7gRGBtWAnCxzLFX4gZoo=;
 b=TWrjNYxokmTVoWeNQF/w/eRexoYZ0rPWmmLjxTYXu101IUlqfXL2g32JnNYtL1nzxrYXPtkAB90Qw/VFv4stzNbHz4LVJ5ZWzu++9MBKSvqfk7yfWAbkdY450Yit8MVR+jsHh/HbKm7A7fob1WElz5C9BCxrVDuLdUvQwWWeKkyAH4HgG9Uwz8Lc/gd57ew6lolEl1vpXbYU6CVWJTOX+DRDDG91zgNk/ZilJ5pkoEtxtwZgfN81K24S7aBFGgbHMUEGxC+eDOm7ZfvyXaGSWfLGO+FgpVS04RRuxKueMhJLOZHx54QmjgIj+shMw66/qcTWOlZjtIifPcPlvrR8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by CY4PR15MB1285.namprd15.prod.outlook.com (2603:10b6:903:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Tue, 1 Feb
 2022 22:33:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 22:33:08 +0000
Date:   Tue, 1 Feb 2022 14:33:04 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        <cgroups@vger.kernel.org>
Subject: [PATCH RESEND] mm: memcg: synchronize objcg lists with a dedicated
 spinlock
Message-ID: <Yfm1IHmoGdyUR81T@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: CO2PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:104:4::12) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70569f47-cd4b-417e-e3c8-08d9e5d2d241
X-MS-TrafficTypeDiagnostic: CY4PR15MB1285:EE_
X-Microsoft-Antispam-PRVS: <CY4PR15MB1285D06101E41B73D04EFF25BE269@CY4PR15MB1285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jMbeAoaeu/gql0OmaJZCGeq1jPKNKyXnxtnXg2b6+J92LgDf+785iV2g+AETxyFCUe/FUY4UvJ4re7Ezn9hiSgp+zuNThnrdSNO+qi/1PejXbYr2BDI4jA/oxARvhJKheiT7rCKzi0xvvwjOQCWjVTenMptvn+L9gfZJNXcE4WmizN5bvkbPJMEoDEqVDwxfdqqLPf7THVxvag5/U/e5TgEdwbpbEWB5JBxQj1M/C06humJ0vBEibWJtgIFo6ugdxL9QPZZH0qp96PWZz62F1ba10oPSzJiuGq5fhqgvqnsc/FabiIOJaJOQexjtu2Vn1PpY19Rzk//BvcFzOOa/g+ZphGQaYgVxzdYYofg+Nkiodv5pbiDOnD+ftqDEifD4T3wzkgJpTt+gGJ2mPlwLcINm0ETggM3gf2vrOTyTZwaPPTLGatt1+h7hF6zgbMjl5U7au+itk6A8UO3cF/ttXTiIkY5kzOwUCQ2skbuPhiap7hy6mASn61M56qPSu3a9ON4drRRFJdet2VsCEn4Xs1jYxZLOdl9NJ0KEJdhUL+VQaxAFb0eU3cbqYCTQlUJENNUkUriASS2ZmOgA7EKZzN4Uu+/01RQdAd8Lijn3eccaV4CqvRlzfkQlhGsyqHTsjidKTUYIVJAaJhqTOQuVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66476007)(66556008)(508600001)(86362001)(9686003)(66946007)(8936002)(8676002)(6666004)(4326008)(6512007)(5660300002)(6506007)(52116002)(6916009)(316002)(54906003)(6486002)(7416002)(2906002)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ydIZzIujEaS+1IiYe0VIq0dQ1XuXNzURp8g2I4+kLNTl/bPwqUvXt0hfppsc?=
 =?us-ascii?Q?B9IRqeqyTHn+BbwQlD5WqKmmhOIZ6sIwlrj0U/iOSzZ5mv/NKcys1xVbK/Vi?=
 =?us-ascii?Q?p4lXy+j0mE7D6FxXxgkDuUUoapRQYx+M6lKDEkoa4Mj/4i1bDWb/Ug4HcpoQ?=
 =?us-ascii?Q?i2ItLfkAgvXt8nMnn5WSWbLnXTEq8FAw2N63X4qzRRJD2AAU+fK3GnmpWFEr?=
 =?us-ascii?Q?mNX/t1jUU0sLNY1E1r7srfjatZJQ6+ksNTDs46Tp7vnOPs1+6yDjO2MGqHDi?=
 =?us-ascii?Q?YG3SjGpKdCmwR26N/wW5MwkyweG7YgYdQYmY72NgXOBZ0cLfYLGdGsGwZNih?=
 =?us-ascii?Q?o1s7aCssIDbJezAbJBseBzJHeKWlt3fM7H+pHPjD7pRlXJPuzpgL13Vs2yn9?=
 =?us-ascii?Q?ASymMDCOTP0/kb0q2xR7e/NTi/mpkKvKnoCMHGXo3c7uY5GegugzSoK17fpa?=
 =?us-ascii?Q?gOcJQfIUfVDwgmx7N0AV/ULqE6HH39BJExkO6qSNQRSvH5SCvvQJhI1hsso8?=
 =?us-ascii?Q?JDxqvL8F7QHKiuQQ5S/asNX0al2lEBWiv3uvrvWLv3EFRNRLc7byXkE0vjN3?=
 =?us-ascii?Q?d/VKM42Ws+ITrCTzynLPn6K9v55QqESaSstqTASlVyt4mFXrWuYqUJ2laM+P?=
 =?us-ascii?Q?YGc954kujC2U/C6/QH6ZjCe/S3r/hMu5wEjWT1vRWLDtM9BBmDTreyyOMLjY?=
 =?us-ascii?Q?z6YAim4TdrrTZBUhhiTvZubN6pbDYxIGVDIN2aNHn12Y7+zJOD4QDOUOP95K?=
 =?us-ascii?Q?TjCs8yztbBU6FyGI1yf5IiAJwDWMcuhpUlRnCW2wD2d/lw1z8yN2Av4NF3vw?=
 =?us-ascii?Q?5Oe7FBKTkp+qkag+SFnCnrnQejkIt4xzohOcJiOiPkGoGHDhIVxILczmJVHz?=
 =?us-ascii?Q?XB4PoWepWlw6ByyAVdQVXXmVFzpISF2WgssOUMb6OpIkEZWicS5/xednjSaB?=
 =?us-ascii?Q?k3q4GmoQIQsajO8IRqc96/T4CQkkKrKn+yeKHV82M64Jxdm7PT5AOD/qoUvO?=
 =?us-ascii?Q?GqM5jNDI9a0dbaZMLzRAeyStrDXrVQKdWxWL0OtOOGpA8muhLTAllRz+GsUv?=
 =?us-ascii?Q?7sz3JlF8uCUSSE5SzcOgPi3dLEJyyHEg4uXxopxSfJbJ0NsBQKKHoh88zldB?=
 =?us-ascii?Q?2riQBINKUY3AwKJiOdJPVAvBNl972pYM8/jy/0FQhzKG0U+Ez0eTjK3EhLmJ?=
 =?us-ascii?Q?Lw7A32lQ5CCpTOW1YSRPpwH5Ov5l+3H72fi/4SZ1p0zXIqvUvy1xj8L7EpUh?=
 =?us-ascii?Q?FS4ROaq2s+VlsUdv9EWHFoNQSzuMPMk9oFq2T+V7CBFpvWzW1YH4quyCeSzR?=
 =?us-ascii?Q?fko35jq8emIHAoTlQgz8IHjOtTGtU+NxLU3ok79GAkpY1HQ4D6ZP/1pwdeb2?=
 =?us-ascii?Q?dE1KjIRO4g+dTeHlveLQ1srqmyQJfebB1/jtxq/QV58p1GiilGSVDvx+aQFK?=
 =?us-ascii?Q?aNrEU0ny2IZYmYBXzBPACzkv/z/9qP0UU22rFbz45Mdz1CcoUNpJbD2a+1e2?=
 =?us-ascii?Q?ITZOghxsashDxLK9awTSwmWi/SkTtyZ9g+GYDG0TX25fWm8OkzWaAH9xI47o?=
 =?us-ascii?Q?QEBSrpsb3jpU093W5b4j760bnCcpfrLGn+4oIqVY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70569f47-cd4b-417e-e3c8-08d9e5d2d241
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:33:08.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6qGiZsYONzNuPoCROyWISjnpRlMiSTlErgV3mfTEEppXvT5C4dl1UBoL8QCYBml
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1285
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: I3It84E2csSqSiWDhqWdnmbCoj4LZH6q
X-Proofpoint-ORIG-GUID: I3It84E2csSqSiWDhqWdnmbCoj4LZH6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_10,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=1 impostorscore=0
 suspectscore=0 mlxscore=1 malwarescore=0 adultscore=0 spamscore=1
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=226 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202010123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Alexander reported a circular lock dependency revealed by the mmap1
ltp test:
  LOCKDEP_CIRCULAR (suite: ltp, case: mtest06 (mmap1))
          WARNING: possible circular locking dependency detected
          5.17.0-20220113.rc0.git0.f2211f194038.300.fc35.s390x+debug #1 Not tainted
          ------------------------------------------------------
          mmap1/202299 is trying to acquire lock:
          00000001892c0188 (css_set_lock){..-.}-{2:2}, at: obj_cgroup_release+0x4a/0xe0
          but task is already holding lock:
          00000000ca3b3818 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x38/0x180
          which lock already depends on the new lock.
          the existing dependency chain (in reverse order) is:
          -> #1 (&sighand->siglock){-.-.}-{2:2}:
                 __lock_acquire+0x604/0xbd8
                 lock_acquire.part.0+0xe2/0x238
                 lock_acquire+0xb0/0x200
                 _raw_spin_lock_irqsave+0x6a/0xd8
                 __lock_task_sighand+0x90/0x190
                 cgroup_freeze_task+0x2e/0x90
                 cgroup_migrate_execute+0x11c/0x608
                 cgroup_update_dfl_csses+0x246/0x270
                 cgroup_subtree_control_write+0x238/0x518
                 kernfs_fop_write_iter+0x13e/0x1e0
                 new_sync_write+0x100/0x190
                 vfs_write+0x22c/0x2d8
                 ksys_write+0x6c/0xf8
                 __do_syscall+0x1da/0x208
                 system_call+0x82/0xb0
          -> #0 (css_set_lock){..-.}-{2:2}:
                 check_prev_add+0xe0/0xed8
                 validate_chain+0x736/0xb20
                 __lock_acquire+0x604/0xbd8
                 lock_acquire.part.0+0xe2/0x238
                 lock_acquire+0xb0/0x200
                 _raw_spin_lock_irqsave+0x6a/0xd8
                 obj_cgroup_release+0x4a/0xe0
                 percpu_ref_put_many.constprop.0+0x150/0x168
                 drain_obj_stock+0x94/0xe8
                 refill_obj_stock+0x94/0x278
                 obj_cgroup_charge+0x164/0x1d8
                 kmem_cache_alloc+0xac/0x528
                 __sigqueue_alloc+0x150/0x308
                 __send_signal+0x260/0x550
                 send_signal+0x7e/0x348
                 force_sig_info_to_task+0x104/0x180
                 force_sig_fault+0x48/0x58
                 __do_pgm_check+0x120/0x1f0
                 pgm_check_handler+0x11e/0x180
          other info that might help us debug this:
           Possible unsafe locking scenario:
                 CPU0                    CPU1
                 ----                    ----
            lock(&sighand->siglock);
                                         lock(css_set_lock);
                                         lock(&sighand->siglock);
            lock(css_set_lock);
           *** DEADLOCK ***
          2 locks held by mmap1/202299:
           #0: 00000000ca3b3818 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x38/0x180
           #1: 00000001892ad560 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put_many.constprop.0+0x0/0x168
          stack backtrace:
          CPU: 15 PID: 202299 Comm: mmap1 Not tainted 5.17.0-20220113.rc0.git0.f2211f194038.300.fc35.s390x+debug #1
          Hardware name: IBM 3906 M04 704 (LPAR)
          Call Trace:
           [<00000001888aacfe>] dump_stack_lvl+0x76/0x98
           [<0000000187c6d7be>] check_noncircular+0x136/0x158
           [<0000000187c6e888>] check_prev_add+0xe0/0xed8
           [<0000000187c6fdb6>] validate_chain+0x736/0xb20
           [<0000000187c71e54>] __lock_acquire+0x604/0xbd8
           [<0000000187c7301a>] lock_acquire.part.0+0xe2/0x238
           [<0000000187c73220>] lock_acquire+0xb0/0x200
           [<00000001888bf9aa>] _raw_spin_lock_irqsave+0x6a/0xd8
           [<0000000187ef6862>] obj_cgroup_release+0x4a/0xe0
           [<0000000187ef6498>] percpu_ref_put_many.constprop.0+0x150/0x168
           [<0000000187ef9674>] drain_obj_stock+0x94/0xe8
           [<0000000187efa464>] refill_obj_stock+0x94/0x278
           [<0000000187eff55c>] obj_cgroup_charge+0x164/0x1d8
           [<0000000187ed8aa4>] kmem_cache_alloc+0xac/0x528
           [<0000000187bf2eb8>] __sigqueue_alloc+0x150/0x308
           [<0000000187bf4210>] __send_signal+0x260/0x550
           [<0000000187bf5f06>] send_signal+0x7e/0x348
           [<0000000187bf7274>] force_sig_info_to_task+0x104/0x180
           [<0000000187bf7758>] force_sig_fault+0x48/0x58
           [<00000001888ae160>] __do_pgm_check+0x120/0x1f0
           [<00000001888c0cde>] pgm_check_handler+0x11e/0x180
          INFO: lockdep is turned off.

In this example a slab allocation from __send_signal() caused a
refilling and draining of a percpu objcg stock, resulted in a
releasing of another non-related objcg. Objcg release path requires
taking the css_set_lock, which is used to synchronize objcg lists.

This can create a circular dependency with the sighandler lock,
which is taken with the locked css_set_lock by the freezer code
(to freeze a task).

In general it seems that using css_set_lock to synchronize objcg lists
makes any slab allocations and deallocation with the locked
css_set_lock and any intervened locks risky.

To fix the problem and make the code more robust let's stop using
css_set_lock to synchronize objcg lists and use a new dedicated
spinlock instead.

Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Roman Gushchin <guro@fb.com>
Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: cgroups@vger.kernel.org
---
 include/linux/memcontrol.h |  5 +++--
 mm/memcontrol.c            | 10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b72d75141e12..0abbd685703b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -219,7 +219,7 @@ struct obj_cgroup {
 	struct mem_cgroup *memcg;
 	atomic_t nr_charged_bytes;
 	union {
-		struct list_head list;
+		struct list_head list; /* protected by objcg_lock */
 		struct rcu_head rcu;
 	};
 };
@@ -315,7 +315,8 @@ struct mem_cgroup {
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
 	struct obj_cgroup __rcu *objcg;
-	struct list_head objcg_list; /* list of inherited objcgs */
+	/* list of inherited objcgs, protected by objcg_lock */
+	struct list_head objcg_list;
 #endif
 
 	MEMCG_PADDING(_pad2_);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09d342c7cbd0..36e9f38c919d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -254,7 +254,7 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-extern spinlock_t css_set_lock;
+static DEFINE_SPINLOCK(objcg_lock);
 
 bool mem_cgroup_kmem_disabled(void)
 {
@@ -298,9 +298,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 
-	spin_lock_irqsave(&css_set_lock, flags);
+	spin_lock_irqsave(&objcg_lock, flags);
 	list_del(&objcg->list);
-	spin_unlock_irqrestore(&css_set_lock, flags);
+	spin_unlock_irqrestore(&objcg_lock, flags);
 
 	percpu_ref_exit(ref);
 	kfree_rcu(objcg, rcu);
@@ -332,7 +332,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 
 	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
 
-	spin_lock_irq(&css_set_lock);
+	spin_lock_irq(&objcg_lock);
 
 	/* 1) Ready to reparent active objcg. */
 	list_add(&objcg->list, &memcg->objcg_list);
@@ -342,7 +342,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 	/* 3) Move already reparented objcgs to the parent's list */
 	list_splice(&memcg->objcg_list, &parent->objcg_list);
 
-	spin_unlock_irq(&css_set_lock);
+	spin_unlock_irq(&objcg_lock);
 
 	percpu_ref_kill(&objcg->refcnt);
 }
-- 
2.34.1

