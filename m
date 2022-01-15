Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BDE48F48A
	for <lists+cgroups@lfdr.de>; Sat, 15 Jan 2022 04:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiAODOC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 22:14:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19152 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232283AbiAODOC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 22:14:02 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20F1bfsi015643;
        Fri, 14 Jan 2022 19:14:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=T/PGvIy/Oab9op+wfEJ/+5uRZE2PPNhbKsvxjnIw2/M=;
 b=HVRc/S3PXnl7WBH+HNSJP1q1f5Kcy4S63SsoPNOZ22DIjwspsPaTFgsspZocr+8m9lt7
 F+FymwEiK3VYTgTkV2zlmfEwnYvrBknNjixrZBKBooL9pnGS7U5WHgRkYGdynbrKB+YM
 oJLOWeo7GHc6wfG/qJz8UVvH5V/sKAnTO1Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3djp90264f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 Jan 2022 19:14:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 19:13:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgB6bswceypj5ZbZK5ooOUhYNjFI2vSevP3V+pFKJN/i/FqK8IX9vdmeKqPpbTZmHjcXQ2tO/8WCnmYQ2/DP0fiqAanV3R8IiFsAr+WK7jYbbTUWLus1yX+jmv9jdKFpctvl13XMIk2uQRYEwVl6qQKoX+VPuD9Kn52w+f/W+eMSDIpapQdnTZ+4SgzR+mcrsFy36F9Bb8h/MZq5LREefblr1zHqss9J7MPgXowP17XIqDduAdL278rs/mGelRRbxW4dyHc9s1wgQN+hYZkO9O/Hh4dABcDx/iZ8GNlQLqCJ0Jh38GRFV3ryX5CoKg/7+muOHPjKFZBHFPwqH+hTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/PGvIy/Oab9op+wfEJ/+5uRZE2PPNhbKsvxjnIw2/M=;
 b=DLYLOLq8nGEVXuJxHYjw2d/MGJ3PsNO9THmurmzb+12SUbGu9EMrsCzgWkNEXLDaPqLz2WtdZZyk1Aw4ixTiNdu4iFX9j4XvkxioANUG/SWGgBOr45u5cOhCFImSXOfTuoPp1N5FFlnJ4COVuphFtNpzKF18YWnbhWxL9XVECh/Efp9LamS0aOu1NRBqgvy4euWTptjangwKlrobevBQEUGnn1cxGpjyTrtWkF9MD2rUMQVf1bEurmkI9zqvXqWw2kklfV/SUYjqluVO4WwDg0cfQRPCi5h+Nx4/quFHUzbJla2LRl39b7ylfuL90Whps22rUR+9cPswByzdJuvZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MWHPR15MB1198.namprd15.prod.outlook.com (2603:10b6:320:24::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sat, 15 Jan
 2022 03:13:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 03:13:58 +0000
Date:   Fri, 14 Jan 2022 19:13:53 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
CC:     <cgroups@vger.kernel.org>
Subject: Re: LTP test suite triggers LOCKDEP_CIRCULAR on linux-next
Message-ID: <YeI78TMjU12qRmQ8@carbon.dhcp.thefacebook.com>
References: <87mtjzslv7.fsf@oc8242746057.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87mtjzslv7.fsf@oc8242746057.ibm.com>
X-ClientProxiedBy: MWHPR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:300:ed::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b941a00a-464f-448a-1ea7-08d9d7d511f6
X-MS-TrafficTypeDiagnostic: MWHPR15MB1198:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB11981ABC7B64330D2FD8B89EBE559@MWHPR15MB1198.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3AbgJGjokkZfxuC+5u9dYtODvPTvYJDAEmUY1p0GqGRp5Wy6s+OwVDf5eykpWa7jY1HiORq7tsvoKNKOYu+aGpD2RTDdj6nOw4N1ojvcQaoXImRayvc9Wf/3Ved+hicCh4VK9YiHrYeAmoK8m3pRUdaiWY3QN/oSZWlCgPG4PY+jWcYdrTjedbchR+Vc9alelfvrzuHSDcbG3ZRQq/Keys4QpVyJwTUtQUFsZqoujeeX4P+/KZ+HLZ8GkK2gtUXzUK34oV6LnT/LtIJPlcEBj9wBaB16m6yFqxMe4g4CL9vxs5/xboowVipf2KSIsNlUCVIZAh8g7MV4oJdPMb9pxXpN6JdciYTk9mLVgOF62j5ugiBTdbjTqxsHN40/ge8cEMUQLUTFJK9iJ8PoxXX1FoLchZrcBLs2lCt7gM3KNwBXKxGZvc8fsYtbysvJZad+ED4ejdTpXWdWK1IinSeQ8i167LxFsM9Y6VTw0cw4EzMwfdrjgJJb0wCMFxnL7LUXw4uvhjZNrF1xTrae+HZRhLG3alcHI9jO703pBFt74TkQH4rZUnIrCpczLbm028zTSFUpSVKmvjrVvNJxAMvXEaDU1oGeX4FaqMoaHdOC7vuMRNQidh58LIuIDNlb1mDEAJLuMvfzRLeyVH8BBT4V2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(66476007)(66556008)(66946007)(5660300002)(38100700002)(316002)(6512007)(9686003)(186003)(86362001)(52116002)(508600001)(2906002)(53546011)(6506007)(6486002)(8936002)(83380400001)(6666004)(6916009)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n5r3HqQ0iGfqdMTew0npqD2nmMpN7Yh4g/b3mNvAATMiYlPHEJcqS2GgGk8H?=
 =?us-ascii?Q?xclBQa6wf8x+bovYFUL11044HqQPRhmUGOGRD2M5BiKXl8gdgEfTlBLP8H6q?=
 =?us-ascii?Q?Xa0RJIFnEp6BhCJzxiIBtlXxt8052wBfJ5rwRvUa1VFrUwiW7JY3y2ASPz9q?=
 =?us-ascii?Q?Dn3m4/jDevLRjFxLnjvd1HtgjMOCJwHflA/9t8HsOOhqvN5MCH9yjToYqFg9?=
 =?us-ascii?Q?XwBNhgA6Lu/Bey8Txw97u4drEfe6U6oo/2u7OsdH9/JmkOplYKHfwKyfkI8H?=
 =?us-ascii?Q?cWyI1NAaAMUhb/mFzOn1qvevrD7biNLcSNHZCjw3MQP8/SGI3H90m9BYLMHD?=
 =?us-ascii?Q?/+9UP+IMxxCyeYEqsc1mZ/ku+aYlqG2mlYWGmx823bvqmU7sTG7XcQlsAxA9?=
 =?us-ascii?Q?lMw4OgXTD9f2bvgS2GlgkNeZvABNsKAmY6eHiRrBC7EoQwrTOn7Stvaxja24?=
 =?us-ascii?Q?0SwnqBaxCFADjUGJetuT2uW0QgHOw9gIIRIxgdrfrKVd/D9rA7nK3oMD/Y0V?=
 =?us-ascii?Q?agt8r/kzSFo67euoYTamI6NbV2zQxpfk1S//RqSMPnAQ41YJsF5KBVjvMEl+?=
 =?us-ascii?Q?06GZIbk+HXmVDqszvpegJueCNFb7XTmarfIHKHeuQBWsGRnx7M39Qi7A/lcR?=
 =?us-ascii?Q?GHWadEIBuEmV0Kt8gwJJ3p6ESqe/+njB4PmShaEjwzw/KalfOlfTqFOEYw8q?=
 =?us-ascii?Q?p/BLZZ6ifAI8jCV6VjNPkwK7YKF21XN+2uQ1a8wEFiLbgrm8DVXKHIb26ufV?=
 =?us-ascii?Q?KJjxs3jQHoPXg/s3SdUKXpCzvudAgCaB1bl/T4e50pCkMBnlV7p1gCF3eDkB?=
 =?us-ascii?Q?eXbn0Dxzu5ly95lBwDV0H7hHb8v5JNq/eY2qQibynWPY2VKAl9ahSRtgEdE/?=
 =?us-ascii?Q?yNilIK3W4FjDvGgzIIsb3EcJicOTxDvSOehQtbSExOgW7nUcrIB0gHXY4Sw0?=
 =?us-ascii?Q?g4TmoH3VJQcaUXACOkzb1kECGHz2RSXeJ6wzgM8E/QLkQ/671IInEWh69FYk?=
 =?us-ascii?Q?7AtEFuM8cci858h0jdN1uU39B5nOW+AhM5XuJRydCMf9GBrUf9BtSAcr2kEd?=
 =?us-ascii?Q?MfxU+jF5zW25hDS/TfpnLCVB7HVfwVCVhUhdayUOEMsrkKkTWpdv0H2KGOU/?=
 =?us-ascii?Q?it5uWv04jOwDFZbCvQYECy6x17WrtQDpAoqVu6vDjP3LSipEvdnaViCx9BTn?=
 =?us-ascii?Q?jubFbDKdJbvBIUZnImF77ac7KR2ROqijiPNu6VTkel9CTzzX4881XsqQ2OSS?=
 =?us-ascii?Q?GolhkLXs3BHMs62tXRL/x5x7kC9DTe0cfC21q88cSBDYVK5cQXV40ZdjRlwj?=
 =?us-ascii?Q?BKAymKbM+xigyJXf34CvDn9GDPPtk6F09T85GiAB1RNLPQ5mEpRFZ1lBKNxh?=
 =?us-ascii?Q?8VEcPfdyn7+lP7fn2FHOBLw7xABhsaoQmUZDG4ZozTVkl5S8AqRMszbVYB5+?=
 =?us-ascii?Q?bb1WUsHF3qaIU6GwRK8kp1TCvKDbjP2oHhjhmn8NIGIUZuQI6VevhNFH/bei?=
 =?us-ascii?Q?pebl0sShPuW5bOTw5CJGmqbrjixQ+b0QbXT+7zB+JIeYVJsp+pFhhNkfe/T3?=
 =?us-ascii?Q?m8qnVfAu7B4MyUz/H1Si1K9fAow27CMO7UEBanmS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b941a00a-464f-448a-1ea7-08d9d7d511f6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2022 03:13:58.1640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyS5sb1h/zHrzpwbg65cTXGc0fIYfL2oTsgzqK2Q8mKIKEKZ9ddIa8pvTzajqimM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1198
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: M63uanne8Zgz2OXZn6C_ffX88_Yju2uX
X-Proofpoint-ORIG-GUID: M63uanne8Zgz2OXZn6C_ffX88_Yju2uX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-15_01,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxlogscore=862 suspectscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201150015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 13, 2022 at 04:20:44PM +0100, Alexander Egorenkov wrote:

Hi Alexander!

Can you, please, check if the following patch is fixing the problem for you?

Thanks a lot in advance!

--------------------------------------------------------------------------------

From a3b61581014409c1f916c449d1cbf2745adde03d Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Fri, 14 Jan 2022 10:47:53 -0800
Subject: [PATCH] mm: memcg: synchronize objcg lists with a dedicated spinlock

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

Signed-off-by: Roman Gushchin <guro@fb.com>
Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: cgroups@vger.kernel.org
---
 include/linux/memcontrol.h |  5 +++--
 mm/memcontrol.c            | 10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c5c403f4be6..5c59d045359b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -217,7 +217,7 @@ struct obj_cgroup {
 	struct mem_cgroup *memcg;
 	atomic_t nr_charged_bytes;
 	union {
-		struct list_head list;
+		struct list_head list; /* protected by objcg_lock */
 		struct rcu_head rcu;
 	};
 };
@@ -313,7 +313,8 @@ struct mem_cgroup {
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
 	struct obj_cgroup __rcu *objcg;
-	struct list_head objcg_list; /* list of inherited objcgs */
+	/* list of inherited objcgs, protected by objcg_lock */
+	struct list_head objcg_list;
 #endif
 
 	MEMCG_PADDING(_pad2_);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 781605e92015..d4d1fb58e7a0 100644
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

