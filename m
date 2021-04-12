Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FDF35CFB9
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 19:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244604AbhDLRsI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 13:48:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36652 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244542AbhDLRsH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 13:48:07 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CHiOcC026832;
        Mon, 12 Apr 2021 10:47:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=uTnqZhX2kVva3m1tQe/wYtVRh1ZNi/k63IhYfRHLSzc=;
 b=Y3GIG92dasCkjq7Cjhs3skltguX6UxQq1fDv5OCQ6yJQLzP6muodGpmUXIVyDgtHYQx6
 eVEHHNN4mJ/ZkDinJM9FykXc2StBowEiXAadxqLV/nG4BjUyWBsDM+vA8CoFpZnQm7rz
 geLYFvaZdRHKvrYSrQgELJS5aKSsYPkDSiM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37vhtkjuyj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 10:47:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 10:47:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6ozHyDtTSbjhGK5LVLAH+QhZ2SeqIsIh0SkWnXNaPX8kODgzTUOI9f+DcFvU4p1fjSCcsPTf1Twt082R7lRmiKy6Xc8ilPeeGRadAd/a9ujv2LAf2OyGzs+sHomkU8ujrETo2PG8AgP+3Jk3AzuFMAZdXRiF96pFfLKfrwI+IbOQBJeESvkUZFOyiFL+JYlQ//BeJYq2YUCS6AnWMAAzqOVcmcK/Fb84sJNgL0r5DzykOEGJvZSnjTH41/xY5txJkdollneFIPU+rSi9GXFtePkclQW8awplUbfFHqPq6rEqL0MJ4vSm23orv2KBCx4yQ9guNng+6T/lQtC44za8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTnqZhX2kVva3m1tQe/wYtVRh1ZNi/k63IhYfRHLSzc=;
 b=m2wpFXz8jB6J572IgwqKjlwSDcoEkSHlSzfTOHxYEFDSMnAe5Ad901u60XsYx1Scs/cEiD80exH2o/9FUNdhBnWilKXIUxeir14nhZYjbum4bq484epVG2gSzvfjZFX9POuDxVvn2EtZgjjDkXVFPJ6debV5UYSdEvkCEQGLaGp9J3wFZ11BzqUYG/ujKxB3BIFKOnL9Bxm5npgZ6lOW9Lg3uc4WpFuE9qpP/0RiuVizkubxZ7Soks/SGcCWloKld599gBinP/wW0JxHY7eKcovGHgXYKstvDuBg+MeB96aucMuRn7uX9Ir0QRYHSDuexG4tS0sSSoiIxcRdXAsoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3160.namprd15.prod.outlook.com (2603:10b6:a03:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Mon, 12 Apr
 2021 17:47:27 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 17:47:27 +0000
Date:   Mon, 12 Apr 2021 10:47:22 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <llong@redhat.com>
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
Message-ID: <YHSHqmxyu1DkAMYR@carbon.dhcp.thefacebook.com>
References: <20210409231842.8840-1-longman@redhat.com>
 <YHEEmGSVy3nl0obM@carbon.dhcp.thefacebook.com>
 <51ea6b09-b7ee-36e9-a500-b7141bd3a42b@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <51ea6b09-b7ee-36e9-a500-b7141bd3a42b@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:ea4e]
X-ClientProxiedBy: MWHPR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:301:2::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ea4e) by MWHPR12CA0027.namprd12.prod.outlook.com (2603:10b6:301:2::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 17:47:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a30014a-d24a-4687-b679-08d8fddb0954
X-MS-TrafficTypeDiagnostic: BYAPR15MB3160:
X-Microsoft-Antispam-PRVS: <BYAPR15MB31602CC141904B87C4852853BE709@BYAPR15MB3160.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YY3F8QjhkGzSb+BVq3rJoHGFO7+LZI61+ttbi/UluD5XRKnPNkG/4tS7CUDvGH2wXlAEx+RYCWueRgsEi9UyPdZuGJoy/QT/fBb3kTbAYqWPA+2QPPWj/zHA2YuWH9gj/lxVIlNpjapyrdwUGxuYLL2yAV0Euf7Su7n61Adp5n9FNQ4u6QDlgcHMxblsaWKdH4yPoEiVo1J1EQzPdOm7yKz2wL+IuZT2JPT3/9F0kM7ArODbA1Pnk/T6O0fgotvFj1pb2Zhs/E0eR0BrAvJn402cTN1iAsuahDawEqqpv/M7Qm+jZNrKDI3TMH62wRVO3UOQsjsDTRkTyqrJVVakx3iCxwd3tyh98AGOk/F3HB0ynnlGqHhGL1r6dHzs+Mbm2HmELmFVMnWZjXMGqwTDZZuO0ZZNzOU5zNwCiSp05vfL06rrODlO3bZ6iEsMOW3Zj/FQ2C5+ITrIXpybzN9bxujCmn1L9AKuYzEXjcjDuvPPlJwJfOyBk75YOJLi574t6ILVf7zYFEl5DWfzABSdWTd0RsTwgRqWDsQJl/m9uhBcDtuZMhWcbZqS6LdEdNIxX2g+g+3QDA5sJcQ8sH3+gKcpHu5eFB2vqwrhVoVsmwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39860400002)(396003)(136003)(8936002)(6666004)(8676002)(54906003)(9686003)(7696005)(316002)(6506007)(15650500001)(52116002)(2906002)(53546011)(55016002)(83380400001)(7416002)(86362001)(66556008)(186003)(16526019)(66946007)(478600001)(6916009)(38100700002)(66476007)(5660300002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dYghE+VVEetrYSfs1S54j8RqZtJh2VO9A0K0QUNN0qgrvy1CMCHKuFlyh77M?=
 =?us-ascii?Q?VbwLbgDRdUfsCk+LzFLkhxtUBM3mg9bOkbUMKgOGInALWgc5k2SYS9SKeZQL?=
 =?us-ascii?Q?dozDYKYbr6i/rDhhy71Cb+NuwcLESJbfu5ZNp56IZqLRza26/lohYa4eqxSy?=
 =?us-ascii?Q?xGWJ9kIYtYLscRc61w6E7gJs7WUunYuUjOyL9XXdui1UybRZ1z4dKUsLXP8l?=
 =?us-ascii?Q?w08Emf/lmisjtQkttcdXTbxWc/Cygn2vhN2un3gqqguI8U3vhoAbl9JFz8UU?=
 =?us-ascii?Q?8oVZDTO4bH1S1Yv6WgVOHBAz/KdRdVZ4B1G8D+pCrDAK6igcmXf7C1XoVuXf?=
 =?us-ascii?Q?Nrh+FJCTCIjdF9j1LdDy1mGgzCZ0CVNo+Wc9XVN+vfCMBiJuX2KTJyheXGIi?=
 =?us-ascii?Q?iMHI386SB7lEUgk653XI5FDmL8u8Tu5X4LKor0GAwWI23UvpzHV14Jtf8ajV?=
 =?us-ascii?Q?tBtz7eMNYrvfkyEh9K1aymFSgtN3syugbvK4zGL4MqGPYh/s/f3kYHH1OLYl?=
 =?us-ascii?Q?rQU5DW6b1aP/tzdtT4c8/RGNjOq0kz5SP/nO0Zbjp1q1aWuqRtUel0JDrZGa?=
 =?us-ascii?Q?Xq/RFnhKwZ+mNJKlOQsSp6dYWNZwklObkTm042wZMQjZUDM1QEA1doedZbG+?=
 =?us-ascii?Q?Tn0cDaw++CxmC4TutopnnD7eL4XoJ5RRsvqwf/67n/BpTcfVrdv49m943vZR?=
 =?us-ascii?Q?tozXYl/pM/S8B/VCbGs+CvugCXrVEtjLcW24Iba8gKRmwdzKIvO5sDPCCHFD?=
 =?us-ascii?Q?PcCaMPfBCkYLfrSGI+qHLZNZICTHDPjiH8Cv9Zy0EXsvtmXG/OXCyRi50g9z?=
 =?us-ascii?Q?h4Wn4CfWTu9yziTZo4dhsicpe/2jEMhyPyy4g+r77eP5BXd/Ad8W3AE2/qTS?=
 =?us-ascii?Q?ZwJyp//xhTjnWBtCIePeq4xIBUzdB1A5QevboO0Dt1SbT3W+ZnVFIjPDeqzq?=
 =?us-ascii?Q?UNWt8RzkONN8DYFZUYrA/Nfh5vxNnX6xQ2g5f6XyhxR2KPovpLuEAKcVN6KL?=
 =?us-ascii?Q?pRwaFAn3qsF1OjsG3UeR/2OGRTQ3MVi40ovuIzZUvVBCnr1SrsLK8iLi1dYG?=
 =?us-ascii?Q?sZ8UTByjJDf1GRpRod4ixpMKuo4kYQXcvQWFvKcNrANZMiHJf0cT14Q30Wlf?=
 =?us-ascii?Q?hDREwXp0/zFNcBbRBrxMnNcMoD6p3tCNqoyj5qPxSdlXQHQy0pC6kJ2WeHxh?=
 =?us-ascii?Q?J5iHXDdDui6pFPbh4fXa0PuJ6CRhrgTxj6kIFJNW3HxhXeehEq0ckv4uNz7I?=
 =?us-ascii?Q?5mForyU+0Lf3Xnc1/EY1DhfaEczClCkcKDm6RmlCQhJbticJOWnS7frQlDRS?=
 =?us-ascii?Q?HHTS3gQpSquE2jXCaQNt65sEFD08zNbt8ikU+Ro1yNjkZg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a30014a-d24a-4687-b679-08d8fddb0954
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 17:47:27.1575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2NjktkzqWgdREERBfQJIWz8CabWKiPCw7bmbvAf8J80tZXNbqzso+zkai2QV3C7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3160
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: YeV2vai-yv5PB9kflDPqjhgdqAzV3CXM
X-Proofpoint-ORIG-GUID: YeV2vai-yv5PB9kflDPqjhgdqAzV3CXM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 spamscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 12, 2021 at 10:03:13AM -0400, Waiman Long wrote:
> On 4/9/21 9:51 PM, Roman Gushchin wrote:
> > On Fri, Apr 09, 2021 at 07:18:37PM -0400, Waiman Long wrote:
> > > With the recent introduction of the new slab memory controller, we
> > > eliminate the need for having separate kmemcaches for each memory
> > > cgroup and reduce overall kernel memory usage. However, we also add
> > > additional memory accounting overhead to each call of kmem_cache_alloc()
> > > and kmem_cache_free().
> > > 
> > > For workloads that require a lot of kmemcache allocations and
> > > de-allocations, they may experience performance regression as illustrated
> > > in [1].
> > > 
> > > With a simple kernel module that performs repeated loop of 100,000,000
> > > kmem_cache_alloc() and kmem_cache_free() of 64-byte object at module
> > > init. The execution time to load the kernel module with and without
> > > memory accounting were:
> > > 
> > >    with accounting = 6.798s
> > >    w/o  accounting = 1.758s
> > > 
> > > That is an increase of 5.04s (287%). With this patchset applied, the
> > > execution time became 4.254s. So the memory accounting overhead is now
> > > 2.496s which is a 50% reduction.
> > Hi Waiman!
> > 
> > Thank you for working on it, it's indeed very useful!
> > A couple of questions:
> > 1) did your config included lockdep or not?
> The test kernel is based on a production kernel config and so lockdep isn't
> enabled.
> > 2) do you have a (rough) estimation how much each change contributes
> >     to the overall reduction?
> 
> I should have a better breakdown of the effect of individual patches. I
> rerun the benchmarking module with turbo-boosting disabled to reduce
> run-to-run variation. The execution times were:
> 
> Before patch: time = 10.800s (with memory accounting), 2.848s (w/o
> accounting), overhead = 7.952s
> After patch 2: time = 9.140s, overhead = 6.292s
> After patch 3: time = 7.641s, overhead = 4.793s
> After patch 5: time = 6.801s, overhead = 3.953s

Thank you! If there will be v2, I'd include this information into commit logs.

> 
> Patches 1 & 4 are preparatory patches that should affect performance.
> 
> So the memory accounting overhead was reduced by about half.

This is really great!

Thanks!
