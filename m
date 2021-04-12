Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7CB35D0C0
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 21:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbhDLTF6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 15:05:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18736 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236876AbhDLTF6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 15:05:58 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CJ4FXo008027;
        Mon, 12 Apr 2021 12:05:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=SWQh6fOs5hf3i14BKkmI1kbUCyGj+KZOy+9MMxfVCYw=;
 b=JN4OtfAoJFVRy0U8q5kFWFjNOMmAylsGuica7k1bN2Pr4jMy0fxobs5QVLDtdT/jgjR/
 r/3ohTBml2B23pt5V6egQ6fGMQoEGAHtwyMtcsNHAWDmUHRCvgsLZf+b3TWqY/wlMzY1
 2SrNxPCeq0JQzoz1ACHtndcHNEs2OCmKlSg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37vs1ch79x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 12:05:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 12:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3sjUVdz8SUmRyf3n0NBqnwNx3ih83UNh+4NRw1vurlrG3ULfRym+cdJOdO6zfOQVsssfDY3ubcFOZw7GqzFv8TuWDLbUljnvJY60YZxnQeeg4c3A2R8o2Z8VODN4p2f021+If3CVgdAPhnjRyrAemfCLg0Zz6kt1FE2r8FSo3Cig5ywVqb47IRrJfogl7i3c4/EYjouQ7VfCnWjFKR+KCzW6lJfHneEqdk51DF0cbvFz/Aeq4wfX7e3yFzevD8hEqRBThtL7kb8HziyhbLVgS9s1Wg1qCVecjFoc7yLxWHqthofi0P3c7FgrBvXz0fScKofSwDGBYcEzVvEf2k3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWQh6fOs5hf3i14BKkmI1kbUCyGj+KZOy+9MMxfVCYw=;
 b=XOAId7sK9bIx19CPRSFMsnGrOFEYv7AXkLxQMGahJ1eC4pbIdgVDF46upo2BML0yOXJrRz/seCR502VUmlS/XXIzdp/1XK8uH9Sf/6a6Kc3Lu4l0TvA3h7y5TVzjohb7g1EOtLSY4PREQLuygad39d83SG3fCF/4w/oyyMZaBGdvOxEYCYv9sw8EnYtkM/5btqL1ZIH93/ZBC/ylot7/Zauv/uBPwhQh0T3LI0ka7fHEpIg7hDF59mY+u43NSiQtaE0/eOjIcMdVdS5SyrCLQOYXRPRS6ZHVHwunchrxZilIiIc8oiOTF9edClA+NFG36KFyaGS+vYvoyeZ5GpogBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3222.namprd15.prod.outlook.com (2603:10b6:a03:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 19:05:19 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 19:05:18 +0000
Date:   Mon, 12 Apr 2021 12:05:13 -0700
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
Message-ID: <YHSZ6X/DvgddiZBi@carbon.dhcp.thefacebook.com>
References: <20210409231842.8840-1-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210409231842.8840-1-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:f281]
X-ClientProxiedBy: MW3PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:303:2a::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f281) by MW3PR06CA0022.namprd06.prod.outlook.com (2603:10b6:303:2a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 19:05:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dca39b9d-3e74-4255-fbce-08d8fde5e9d8
X-MS-TrafficTypeDiagnostic: BYAPR15MB3222:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32228D2CE4018A20651EE56DBE709@BYAPR15MB3222.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtjdvH+/RQlScxUevV5vbs++eweJbYTMtpYZ2rU0wJg5npOlgv3W02WDexy6KBOIwNSEzlkuTFi6NMlva7szFhBxyiEscxT90wYrOF/rO5WY1znimGP+ABhqbp0F7ksah7mWM68P+t22REBBb10fmyuJpBcdUPiNpk3BZqVNhJCtutsdtvo/x4we7Ujxl09O4g7DAOKXc/4gdMbw8RT/JH1q6RYNEcv1UrbBkp2oxO3fZGy1XuPrEI/+KrWVzmYOe+EI0n+4j6vfabWtgEoS+Kvf2/LbSxK4W1Lj3agw+nf7SkK7TyvbodX9w+mYN2y092B+OcQzfUd3cBTLqma1MKaISnHFZKW/4SlQmImPkKL0LMupe5boJFbjZ5SD8ETM85msI0u8AkJViw2Im/fhiQliXd5q27hhoYjX1Ww23PXopdkyba1gHiuWqqTti5YITebSgtNhnn7FzMUJb8cG9l5VbnqSwCd6siBdOeik2dAz7fs5vNDYN6cHfvvlTYMvs91OQZkFgOjwteOwxIEEdPhVre8m/u+oaLYWfl74WglY760nCork6ANneXq4tEXaAQYioIrG1z8Gr6sOhaBU+rA8w5DWOixWZBYxr1+NjIaeA9pSVhWxkDRtpJOtvS19Hv/tp9RvFZDpnl1g9AYFpnC1oEbwYz97olYSJR/bkGWEn1wRJIatdb2IZA1Dc5sY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39860400002)(366004)(2906002)(316002)(52116002)(7696005)(54906003)(186003)(16526019)(66946007)(55016002)(66556008)(66476007)(86362001)(9686003)(6666004)(83380400001)(478600001)(8936002)(5660300002)(6916009)(966005)(38100700002)(4326008)(7416002)(8676002)(15650500001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZIK16Lls+OFqWFYtso9Tfmk1hW5XxV1vuCCQIJZQtDX4f7Idq3OUbX0CQ/Px?=
 =?us-ascii?Q?IVRn5Q4HMNMI9JT4LJFNsPSlVjWBDkGm1Cx+ohbMzVi0CRuAbzVEupyZSvs7?=
 =?us-ascii?Q?Av93Vgf+2bFkQLPc3mmEyg/ZgJlhZPT82/8qLL5rOo0n/+KW8+H5fkNnq1hf?=
 =?us-ascii?Q?5EPmBawSw85Kro14YBIFTcAZl5aptWTGioMoHqFAfLJaLrCCsypUHmK082wP?=
 =?us-ascii?Q?vVJGquRG2AHXtPc4jYXTFYiYVyQTVofv9f0ZQ58bv8g1i+8KNc34Z/pf/ciU?=
 =?us-ascii?Q?xOyTFi5ZtneimfaB4x5Ehudqc8+lTyTuBJxYjUQwaoR0LvTEmvIYpB+el3wq?=
 =?us-ascii?Q?i9zw4lBWtCYtBuUyX02EmPmK/bM7c6iFs16SM93Vwo7A/mgl6NglHm7ychAS?=
 =?us-ascii?Q?+czPlidz1cObn6JyF5vEIaxIqg63ic/fgUmzjoFNdYhAnzRTLhEUK3nguqgJ?=
 =?us-ascii?Q?0QfufwfkEXIxhZ5QBhD60HJxfu17MOe+5mJFHfAWo3YAelrxpDsrs3QnKOp1?=
 =?us-ascii?Q?r2ZjmS3tXS3LNQCLLrpYYkXFZt6w5u2LhKnGxeDGDYgLkpxuktJT70yrWA7u?=
 =?us-ascii?Q?zjXnWgeDPKwxSqzd2Wy5uUFLPSLX2UY0Qc3ELKb+We51vfyqmLJkwn1MdhDF?=
 =?us-ascii?Q?VIAvy4iZ62+7wjykfgpjAI7Ydbmz2KiZQka/IafdRnz/7/KKazHNaITlfbmR?=
 =?us-ascii?Q?uI/u1WTXqfC7aHAqrlH1kcdopXAEswjM9jQIdClypgrAO3OdgCKRyKhVfwqW?=
 =?us-ascii?Q?9nmNjRJOuE4F+syRdAU0ltR8De4kFKV9CeOkp5gik4ydZknmVvZdrFyA3jJi?=
 =?us-ascii?Q?5N4i6RGNhmSc1/K9LF3joMJTaEc0uxPCAV5LCezYmz4dgNHI4WZkagqMAQla?=
 =?us-ascii?Q?h8KkmdVkbx4//7hGq/Dx3FlvvfDmokEg0v1MFn1bOAi1MCpmSWtXQj5RdOBs?=
 =?us-ascii?Q?SNDKBQu/tcfgALqOcC9799lsL55nXO7+jw2mTpKUHe1XPKAn2jf9+4hDK6eD?=
 =?us-ascii?Q?SxIMOxMNMcbzA4oxhZE1fMprr4sX2n9rpHGcJe3A0ZmPGoM61Z5trfH2tSmq?=
 =?us-ascii?Q?cEattYmVz15OBKC04suhM6Redb52D6xowWsiD7NaCY6Lx5B3L9YgkhMu5cfz?=
 =?us-ascii?Q?YsCzqUcZb5quWb+o71/CPLTRQ5Pk9PEGVpqX7F6M56rA5R1NNYEn12649h0t?=
 =?us-ascii?Q?rmJBz3PSFf+v5gjU24hxaTBN8FW+byaSit3sk6UVSRV9K0q6X/pDD6jLdzhZ?=
 =?us-ascii?Q?j4vmbLlsbUgxwSZwi3zwVbGtYvsIOnm2Q7IAuk44g0rkT0lST2Twt+UqlcZs?=
 =?us-ascii?Q?9U9R3sUtHXx94M4UgbkXGpLGbaye8o5kpTrllIWLyV0O2gVlrCILc9q3xCV2?=
 =?us-ascii?Q?GYU1Njs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dca39b9d-3e74-4255-fbce-08d8fde5e9d8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 19:05:18.7873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXqaEDekHrxwcwQebLPh8d9d1WJCT7LMfP0O+/JtlJRgVfqOpLEqACTW7rScJbfx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3222
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: hPGKDqmNhjS2bTj7uOEK_8bQwBU4UFkl
X-Proofpoint-GUID: hPGKDqmNhjS2bTj7uOEK_8bQwBU4UFkl
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=638 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120121
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

Btw, there were two recent independent report about benchmark results
regression caused by the introduction of the per-object accounting:
1) Xing reported a hackbench regression:
https://lkml.org/lkml/2021/1/13/1277
2) Masayoshi reported a pgbench regression:
https://www.spinics.net/lists/linux-mm/msg252540.html

I wonder if you can run them (or at least one) and attach the result
to the series? It would be very helpful.

Thank you!
