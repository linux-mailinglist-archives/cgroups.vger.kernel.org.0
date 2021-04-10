Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB2235AA03
	for <lists+cgroups@lfdr.de>; Sat, 10 Apr 2021 03:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDJBwD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Apr 2021 21:52:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59192 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229665AbhDJBwC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Apr 2021 21:52:02 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13A1nqDP008497;
        Fri, 9 Apr 2021 18:51:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=VohXgyTubbH1Px/q87HiemKrrAlwObQnOXkba6IiUtU=;
 b=CLxfce8vVIZ2kXgOQl+pOXWVfntDxU7r7Yw74ommWKk+CArXVlisK7TLyROWsWuKZa0k
 v1yt8Lt7XnMbAk4NqHNZmsSjx+LWmimUiZrsmaswDzPbaY8RlFuHPCxwO9pCnhd+2oa7
 Z/raLGLDoYB27bwQrHUnZ5HDxHtjNvhFvdc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37tcgbfc9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 09 Apr 2021 18:51:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 18:51:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6XOhXvsUsjoU/JtmfvkP/XjpVg20j4g96fVydD8VWUNHO+S8RY29YU4OCV/cA6GV8ImaQ5xdjoamj4/HZ1yiMF3AdG86xzj+NfYT1uc9cd8REu3RC/mtGWqSfKb1B8P4WaPTX75xvDPtr1nT7d76739xHOJQTOk4p000pDAbgC7ZJpRRLhyLeogk9SYUh+d9ja3r+qaaBipH88xszQMD2Af6jOPJrELLdH9tBq2hCF0AFhd21BUAGD/HG8LyyqgZ2NzQnKVyFytyy7jdtQmSM4Xt6OlIfh/20B2xNRrrIZX5vOv6FvCu2uS2i8P1sMXlSotmZIktL9V3X7sdhoipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VohXgyTubbH1Px/q87HiemKrrAlwObQnOXkba6IiUtU=;
 b=d7gnrexdqYKdjl35C8zBXwHFTKiu2rUXgq+mn287oDgAEMky9GiJiUVns5XbtGC+PKv6AxT68cElA2mPhqjg2Mv4V1ZAQhu74Htwrjvmdotix+FsOGOc21MtH9qi0KsYL9aV+BsOPHS7Ejcw1acd11+QfMmPL1Yy6B/sDUCCBoHWzP6SLKNMLQO9OA5ejvyHfvz9MXs76meER15uafu5HVLkjPs27IBuc96NnOhxBMVuENDkhrtlWaSfLW7r2ToHpn3j0m7k1A7haMjQNb2Kg2lx9Ni34mJEagXNYIj5hI//KekZlmd+S9HR1BPQVqmzak9Ix+ykmI4SfUPoad6g9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB4306.namprd15.prod.outlook.com (2603:10b6:a03:1b6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Sat, 10 Apr
 2021 01:51:26 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 01:51:26 +0000
Date:   Fri, 9 Apr 2021 18:51:20 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH 0/5] mm/memcg: Reduce kmemcache memory accounting overhead
Message-ID: <YHEEmGSVy3nl0obM@carbon.dhcp.thefacebook.com>
References: <20210409231842.8840-1-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210409231842.8840-1-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:29d8]
X-ClientProxiedBy: MW4PR04CA0253.namprd04.prod.outlook.com
 (2603:10b6:303:88::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:29d8) by MW4PR04CA0253.namprd04.prod.outlook.com (2603:10b6:303:88::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Sat, 10 Apr 2021 01:51:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9e5e453-9cfc-4e0d-5d24-08d8fbc326d7
X-MS-TrafficTypeDiagnostic: BY5PR15MB4306:
X-Microsoft-Antispam-PRVS: <BY5PR15MB430656B6AC0A837A2BCE61B8BE729@BY5PR15MB4306.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzOuRJGuWIx2xHce3POleges4zYJ0ddcHlsH+r02ahjSyxCLX6Xdq2t3AEs1B4wbMF6uXEsGTm5UhS5ImLY5GV6jY9pp2AgFaSXHTEZ4zQ+LEEQWU/BY5Um3Hvrkomv686Ew1uqaVeP1Y7L+25o+fAq7+lmTQh87S3YsSY1o3qU5in2j9Ievbs30C9CK7OPlSkwro2c+EcdO64F95xz69KH1gpChSHoOtTOsyObR+gv/CduXqOVbRvysBIWd42VrnUnhx+V9EnCNUd/C99YLvCE+FHRYXzUIwDJI6jcjoE772Ns/u4/8jHvX4yYwUhP10FbXfsQ4b+feD/fUboGov4kxxdFXCC5M1gtxvvyrOs8GWv1o47wdgLoF8o7yWx3606d+OmaaE3biez8FUv+X3C3VNbGAxolRoZskWUaHmJ+2nUDV80ttRzm9dl/4FiiYElLZ1mm1CrukQt2DNpEqaSlbjqlQG0g2KZcfQE4J3mgh5G01w1ojoSCA/2Z9gPfHSuKNaZshO1e7oDRGC12RmCgX0hifKzEqfv+zuO299gEe6UHHsJ/YueL+byyexvHi3drbufOnkKLL/D5N5AN1SlTuaDIOObOxABd7GbjXENmPdxvvuJW/E1pa9ChF4KENJL9Rq3CNL9JF5BPMcLhed3E6KomDBoLYwDNy3oMaemr+OpQ7nW3mFKZYtGA269CO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(396003)(366004)(478600001)(66946007)(16526019)(9686003)(966005)(86362001)(8676002)(8936002)(186003)(38100700002)(316002)(7696005)(4326008)(5660300002)(52116002)(55016002)(2906002)(15650500001)(66556008)(6916009)(7416002)(6506007)(66476007)(83380400001)(54906003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?T6aAvmBusZVq9w5QxeEijzcvEDvKBYCSVx5zZPkxVXQDbwuPH5aOp8SCas6d?=
 =?us-ascii?Q?OHyPChGuwU7vwFLlG3hbuLogtFebeTgnq2j8WwHV0ZnCXubZUSFZl1wkydW1?=
 =?us-ascii?Q?rzH4aPAlwRwn/EvI9I/pzZjmVoB7JIoo3Z3nbCvq5EeF7McV91U4r8HntZxO?=
 =?us-ascii?Q?nSl2jZb0CzFE1sa/XyoLef/PLqVII29Q5v/VuLs/HDyVQHsPvHV892ygzhEh?=
 =?us-ascii?Q?VhbSEY/a8Tz5j9Oq6+jSZMfbqDNjX+WInikISCS3Oetddy9YamPChjVsrLHK?=
 =?us-ascii?Q?55EM8zrXZKbMQ/1vvbdIvcXm5t2BTGaNzXxOUjvmPZgREE3rhUu8l0D8GJzS?=
 =?us-ascii?Q?k1/gNBJekd9PQKMFVNtuQHj8FEJgq/onWPpewHNGeR2zBt4pbjnrulbqg3uf?=
 =?us-ascii?Q?RuWEZGkk4iReTcQITV5EMQreqVH7AdsgbFyzcbMOt/UcJbJlBhJkeCo48Q4x?=
 =?us-ascii?Q?L5Zn/jKj0IwtGdedo66VvInrxGAiQ095AuQql/3182XSmzW3W6gjuLsDGTpP?=
 =?us-ascii?Q?w9TuxhBxZ9zXRpj4OwHpe6iluAxTjYOosZ6omCzpG6d+U30wstAr5Qv7yaqu?=
 =?us-ascii?Q?KtoyhqXJZ+eXePMOeiXm7Xm4S6nTo2wKdLQt2i4vgELR+j1HmyMgabK20yO+?=
 =?us-ascii?Q?slDC2RP7CkGAxbT74QevvFMQ/ec2on4xZPyPsxTZaVwWPj5T+kDpEFd2ysMf?=
 =?us-ascii?Q?AvyZp29bHbgLs37ahk+LWCa4v71JksGQw6H/qbAGVQijtoEjYuRWFXq6vjX1?=
 =?us-ascii?Q?jOdMx44JCwg3fu4I34bvzESmGtdOo1iIuVXbl6IE90at1jjNQHbIPjmL3MYW?=
 =?us-ascii?Q?Bn4NBmK0Ydbm8nOOGbk2qVScnXh7QjRZVZ8/dyPdlXxydH1r/eZVdec3ogWP?=
 =?us-ascii?Q?otgj5+g9nHUjrRI+p/RnW2c3WdZ62/+3OG+45ZtKII1g6RVfxfmimVhdIp3I?=
 =?us-ascii?Q?zPvvgv1hB5L28hK5w5NgdWt8DKv5zrKHRUM28vFbECY4PgxXesKxlZ6twH/N?=
 =?us-ascii?Q?UVtNNv0XYkBJZILUfHNeo3zWQmmwF0scb+PxBOJ5Zb9vvTXcG6QadDnycvNB?=
 =?us-ascii?Q?Q7aqH7MSR58WpwQRi7k4qkwp3lK8NKVCkiyLjYBgINmz5IptBE2cfCDSqr4h?=
 =?us-ascii?Q?DiJzUdOiz87WE9MujeXCuQpISw4ekaQTvcNdmLZ0n8q13cByBu1a/mUC4raV?=
 =?us-ascii?Q?TyUM66EX2XrnjqzQWJGPu5BQ62tndh9kB0e6SDbmaOYPU4AVeb/TMgNGmbSf?=
 =?us-ascii?Q?R1BNxx3LIOBBCBGzgyF8I0froopgd8+R0XUPXgCd0mFGoVsXfnR9EWvg2Cym?=
 =?us-ascii?Q?TB6LulP7iptgiX+4pZ1O07f08+sOlWAVZbD0LzEJRxXXlg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e5e453-9cfc-4e0d-5d24-08d8fbc326d7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 01:51:26.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Y9t6pxv5MJuUsnUHxJa7iX8s0W6GOYYqcZTkvDtzjgTpd9rJkcxPSKdyiL2ddNt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4306
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: LlgN-gfBGqaJ2CndYtavZgS_gONvq0Pc
X-Proofpoint-ORIG-GUID: LlgN-gfBGqaJ2CndYtavZgS_gONvq0Pc
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_08:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=807 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104100010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 09, 2021 at 07:18:37PM -0400, Waiman Long wrote:
> With the recent introduction of the new slab memory controller, we
> eliminate the need for having separate kmemcaches for each memory
> cgroup and reduce overall kernel memory usage. However, we also add
> additional memory accounting overhead to each call of kmem_cache_alloc()
> and kmem_cache_free().
> 
> For workloads that require a lot of kmemcache allocations and
> de-allocations, they may experience performance regression as illustrated
> in [1].
> 
> With a simple kernel module that performs repeated loop of 100,000,000
> kmem_cache_alloc() and kmem_cache_free() of 64-byte object at module
> init. The execution time to load the kernel module with and without
> memory accounting were:
> 
>   with accounting = 6.798s
>   w/o  accounting = 1.758s
> 
> That is an increase of 5.04s (287%). With this patchset applied, the
> execution time became 4.254s. So the memory accounting overhead is now
> 2.496s which is a 50% reduction.

Hi Waiman!

Thank you for working on it, it's indeed very useful!
A couple of questions:
1) did your config included lockdep or not?
2) do you have a (rough) estimation how much each change contributes
   to the overall reduction?

Thanks!

> 
> It was found that a major part of the memory accounting overhead
> is caused by the local_irq_save()/local_irq_restore() sequences in
> updating local stock charge bytes and vmstat array, at least in x86
> systems. There are two such sequences in kmem_cache_alloc() and two
> in kmem_cache_free(). This patchset tries to reduce the use of such
> sequences as much as possible. In fact, it eliminates them in the common
> case. Another part of this patchset to cache the vmstat data update in
> the local stock as well which also helps.
> 
> [1] https://lore.kernel.org/linux-mm/20210408193948.vfktg3azh2wrt56t@gabell/T/#u
> 
> Waiman Long (5):
>   mm/memcg: Pass both memcg and lruvec to mod_memcg_lruvec_state()
>   mm/memcg: Introduce obj_cgroup_uncharge_mod_state()
>   mm/memcg: Cache vmstat data in percpu memcg_stock_pcp
>   mm/memcg: Separate out object stock data into its own struct
>   mm/memcg: Optimize user context object stock access
> 
>  include/linux/memcontrol.h |  14 ++-
>  mm/memcontrol.c            | 198 ++++++++++++++++++++++++++++++++-----
>  mm/percpu.c                |   9 +-
>  mm/slab.h                  |  32 +++---
>  4 files changed, 195 insertions(+), 58 deletions(-)
> 
> -- 
> 2.18.1
> 
