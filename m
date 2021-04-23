Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C618368B04
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 04:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbhDWC3F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 22:29:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22476 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236407AbhDWC3E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 22:29:04 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13N2PIQB023280;
        Thu, 22 Apr 2021 19:28:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=f+yG+OPHjdgN450GDRXrlRhhthAItsFQBePByq/lUsM=;
 b=kFGN5QsXVELfM06GwjBZWaKCzLgyqbtb9rV6cXJpodXZIh7GypiYWqH4AGqa5sGg57Vr
 Or/+Gpv11QXjPRyJvM7aPUAXYqRv0Ak1CxJgHXUR0A6XVuKpeOzv2JKznMtSoBX9L+oR
 bzcMkq1hvqnFR4tcqmHfzs0lZIsjXqLazM0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 383h1uhdw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Apr 2021 19:28:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Apr 2021 19:28:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xdz7emjnqYReBh9lzOlFRmtHQgFzQKzpfF/b+YCURpv4a4cZlGpPji3nhsqEqyowxQ6jig5bwVO0bobiSc+d5Sc4uFUjs1DVifo2rRs0ynztQmsMfHFhTu/RmmSl9hWH0Qq7btQnHAkVzWrI1jMykBIM/x9Z66Uxs9YMu3sqxAY8vAauPDT0hxiLOBPebN2R0bGbWhoagcyBiRCcCAdUci01SA9ak/lcTwIIfekB4PKFjdDqFjT75LM5cyizBdMPlTTTRT93E6MLqcTFeBBz8MyXpWQWP+zTmP+p+FGHgPccMu/nSZ8f7U/cPEOGNONbDZUkEBqcg40P3Vih4BNmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+yG+OPHjdgN450GDRXrlRhhthAItsFQBePByq/lUsM=;
 b=FQlW6snyi3QRc9PdNrM1u5HrCdqGnSFyvh+LPvN/jzHjuMeOabsbMlqG5UCIi5yO+aH0UhQ4+gf/iqId5tktHsSPFZbdHGhW0UvprLLm0QNQ8ezQBgkVoMx2pkbwGqAZybk6PKS186TibwVc/k4jdOB8/lNqVqwoUDr0DwFmjFOzOjl8Tti6G1DuIiISwToNC7kZplvJC1Yps02ZB6BHCUsoQHG3snnOU7xyke2AB82wUBnicev2BKPC1d8ntf77EPmEeVaeF31QASglWKjjjvn2lIKJgY5iZGltwzcG3K3CecXyja5b/2NqLnfn9MlexOc3ETKnI+ISgUDabx2XwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 23 Apr
 2021 02:28:06 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.026; Fri, 23 Apr 2021
 02:28:06 +0000
Date:   Thu, 22 Apr 2021 19:28:00 -0700
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
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH-next v5 3/4] mm/memcg: Improve refill_obj_stock()
 performance
Message-ID: <YIIwsAk4RaJw5WCL@carbon>
References: <20210420192907.30880-1-longman@redhat.com>
 <20210420192907.30880-4-longman@redhat.com>
 <YIC7dh0+nQDFmU+T@carbon.dhcp.thefacebook.com>
 <d17f1c19-fc1b-df92-8361-fa6b88170861@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d17f1c19-fc1b-df92-8361-fa6b88170861@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:5e83]
X-ClientProxiedBy: MWHPR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:301:14::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon (2620:10d:c090:400::5:5e83) by MWHPR1701CA0008.namprd17.prod.outlook.com (2603:10b6:301:14::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:28:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99dff9f8-ab22-4c0a-d3b0-08d905ff6d65
X-MS-TrafficTypeDiagnostic: BY5PR15MB3602:
X-Microsoft-Antispam-PRVS: <BY5PR15MB360280259BC19F9491EB1B1BBE459@BY5PR15MB3602.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNOccH02R94gYjHaUZ+bs4CHCXdHeMqG72fPFMuPDxQTnrqL/r76yPvuSaUMVIv1mG9bOJuhk5CMXY5odofTqCwnal2rS11jgrq9D2HbKycOoYiO6iOC69FrQjQ761Homx8eH0qHf68zU6GmbW+TvRthfn34McqiIAx+IPqrS7p8aGmEBqsairDGfUhMIBN0tcdOM+NtkcilAiRpLVy/H5310DNBR6+MmiDX8jv1Qlh9juzMnWPgoAv8kUKULI8hnpy2ofxO1GxZbhp6gRp90Ut4IGGTr473ck2Fiw/IvMQOgXCng3iq35BDCltVP0pG8D3Dk3ykwWujRRQUABpgfO+l9Kd+QynYnSN6OG4sG8mcDs2mG6bkkB0E12cRe4cAHq7YIMJ0HbTVMIZy0fYXv96Mlq+T+j47Tr9q3FuCYmlBE9KUoA50dlwgb/bm5/W0P0MrfMCOIGJil+QCa4QjPn1u7nv+4zJI2T/GCQ40slNXBcRiPtvxi3VQKtgH/AhrEi1ZSOQlPjZbnWi7XRPRLiocbm3JBjgEiGSZsuyvcVbn1NpFl80CGwiRDfQERrZW9mMw830/xooDhMhBgGIam0xUOmjpDAjLkWLJOFB2LeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(39860400002)(396003)(316002)(54906003)(33716001)(86362001)(9686003)(53546011)(66476007)(16526019)(186003)(8676002)(6916009)(8936002)(6496006)(66556008)(52116002)(2906002)(7416002)(478600001)(6666004)(66946007)(83380400001)(5660300002)(55016002)(38100700002)(9576002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mBq19nxWNpz5pKrjsFlVqfHudNZ0YiXwnjMzToSZ5FHj6iauFX3GoHmvEIDW?=
 =?us-ascii?Q?rIPLgVPyCtViybT8n81VfZVC36JDXYkpq1H27ZYGtQK9nW2/928eZBj+c+Jj?=
 =?us-ascii?Q?SU7018401V2horc0WaFQ8RfiJnEf+e/qmwWF5JZ5qyLQMl+zpnEmwBJyixw6?=
 =?us-ascii?Q?50bZ0PZfGDba0Qs9G/YV7qOIE+k3s1gA0DCpTBdU2F82FoqYX6MvvtoHLfxq?=
 =?us-ascii?Q?sKySSYhOgNPdyNow51T0q4mx0veACk/PX7/jy2kGTdXNfkoSz2aCUEhtKb+L?=
 =?us-ascii?Q?Vb/BiCDmsr8JV8yg5f/CWn4WY+BQPOtV/pwK5tmZ5NGPqeGJPwwydSpncg7K?=
 =?us-ascii?Q?jFcPP58U6PRbwaKMk+mpWg2F0QIJe3nwCce+KkJVChNbtMD4sBbqX+O0sGcd?=
 =?us-ascii?Q?uzSaBzDINLKYaXif4Hs5WI76jxutvaV9Je0+ONW+erYBo+tzA3yl13B0RVqJ?=
 =?us-ascii?Q?bEuNBELLk7h7L7B8NbASS/cdIZLZBhd6CKZkSN0spa2Sobv+8HleyeQ2ZF3D?=
 =?us-ascii?Q?8rTZbyFY60ESn0gBFkzusnhKa7j6MzKqKrmunhKLYd8GM5RG6y4IySMT/PEI?=
 =?us-ascii?Q?7dcLd6OouacBuI6KBIX2xSf+Z/18gq6P5n4xlPsJrrpOdtL0f3l35vclpSek?=
 =?us-ascii?Q?sDs6IVTPtD+Q+sUdUaHzXzjg3TmC7bBPXrPUD+uS4w5XN/Ki6Ut/xTbqK+pi?=
 =?us-ascii?Q?8q7fby6QM7VqukabVTG+En7k1Lsk/7UmGv2SMP90OuDmGF4OjbuSEZSK24Lq?=
 =?us-ascii?Q?g+B5Rapk4pA/chgyWksVKHmkhflZiv73xKFNusPxFts8lPpJTh1nfQq24i9u?=
 =?us-ascii?Q?8wmksNhnR7Rf5mYXOBmalborT3qJ4TBtvUv8GenJu9Z7m+YS+1cBabeVoOh5?=
 =?us-ascii?Q?54PFEsrpEmLC0FSk/i3WGVwDjxmvo/NFEPPexE3picCeYUsCpriDn0+aiwIx?=
 =?us-ascii?Q?rZLzW7/QpEK61rEa3IQMZhMrOnnvmFrQAJ2zXyYLwCCFzDnFnVhHueuZTQ08?=
 =?us-ascii?Q?JwurSf7FTYZdT2NbPfVqyG6xYerlHZHVpEEbOULR6q+uARJqs7pEi8neu9cp?=
 =?us-ascii?Q?MPWG6SxwTOu1hvoVm5NEZNkq+DnmMw5OR6+su/DEk36BuQz4fZTbwRV+xTDd?=
 =?us-ascii?Q?zJHfWwPY3QMgiLhOFuvZYrkeZxFhLKsOwMaCmZLXD4jyMyLyC2JUjE1l6kDe?=
 =?us-ascii?Q?bQh8B1duG+WRZOMTjacfU4k0+CEmdBAxKO10/E9gFtw6iV+VBqaHXThTkDmW?=
 =?us-ascii?Q?ENMD3Zhg0eR6PnowwPst5+RIEVErAcgIokMK52mRGyDDxlQZoR39X4fPgEsQ?=
 =?us-ascii?Q?zBkOk6Nj9JT+YaQZmlbVeljZFX5DnXk2rSBzJi0SblkBrg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dff9f8-ab22-4c0a-d3b0-08d905ff6d65
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:28:06.1783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gn6zNyY/9j98hcLt3fNR72eou2DVzAKPjB7LyIDORoeuL97+ieQy/Aq77ig6Ia5q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3602
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 8YbytuOMPpxIF3DsT1CFSqWnHyQ8It1a
X-Proofpoint-ORIG-GUID: 8YbytuOMPpxIF3DsT1CFSqWnHyQ8It1a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_15:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104230015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 22, 2021 at 01:26:08PM -0400, Waiman Long wrote:
> On 4/21/21 7:55 PM, Roman Gushchin wrote:
> > On Tue, Apr 20, 2021 at 03:29:06PM -0400, Waiman Long wrote:
> > > There are two issues with the current refill_obj_stock() code. First of
> > > all, when nr_bytes reaches over PAGE_SIZE, it calls drain_obj_stock() to
> > > atomically flush out remaining bytes to obj_cgroup, clear cached_objcg
> > > and do a obj_cgroup_put(). It is likely that the same obj_cgroup will
> > > be used again which leads to another call to drain_obj_stock() and
> > > obj_cgroup_get() as well as atomically retrieve the available byte from
> > > obj_cgroup. That is costly. Instead, we should just uncharge the excess
> > > pages, reduce the stock bytes and be done with it. The drain_obj_stock()
> > > function should only be called when obj_cgroup changes.
> > I really like this idea! Thanks!
> > 
> > However, I wonder if it can implemented simpler by splitting drain_obj_stock()
> > into two functions:
> >       empty_obj_stock() will flush cached bytes, but not reset the objcg
> >       drain_obj_stock() will call empty_obj_stock() and then reset objcg
> > 
> > Then we simple can replace the second drain_obj_stock() in
> > refill_obj_stock() with empty_obj_stock(). What do you think?
> 
> Actually the problem is the flushing cached bytes to objcg->nr_charged_bytes
> that can become a performance bottleneck in a multithreaded testing
> scenario. See my description in the latter half of my cover-letter.
> 
> For cgroup v2, update the page charge will mostly update the per-cpu page
> charge stock. Flushing the remaining byte charge, however, will cause the
> obgcg to became the single contended cacheline for all the cpus that need to
> flush the byte charge. That is why I only update the page charge and left
> the remaining byte charge stayed put in the object stock.
> 
> > 
> > > Secondly, when charging an object of size not less than a page in
> > > obj_cgroup_charge(), it is possible that the remaining bytes to be
> > > refilled to the stock will overflow a page and cause refill_obj_stock()
> > > to uncharge 1 page. To avoid the additional uncharge in this case,
> > > a new overfill flag is added to refill_obj_stock() which will be set
> > > when called from obj_cgroup_charge().
> > > 
> > > A multithreaded kmalloc+kfree microbenchmark on a 2-socket 48-core
> > > 96-thread x86-64 system with 96 testing threads were run.  Before this
> > > patch, the total number of kilo kmalloc+kfree operations done for a 4k
> > > large object by all the testing threads per second were 4,304 kops/s
> > > (cgroup v1) and 8,478 kops/s (cgroup v2). After applying this patch, the
> > > number were 4,731 (cgroup v1) and 418,142 (cgroup v2) respectively. This
> > > represents a performance improvement of 1.10X (cgroup v1) and 49.3X
> > > (cgroup v2).
> > This part looks more controversial. Basically if there are N consequent
> > allocations of size (PAGE_SIZE + x), the stock will end up with (N * x)
> > cached bytes, right? It's not the end of the world, but do we really
> > need it given that uncharging a page is also cached?
> 
> Actually the maximum charge that can be accumulated in (2*PAGE_SIZE + x - 1)
> since a following consume_obj_stock() will use those bytes once the byte
> charge is not less than (PAGE_SIZE + x).

Got it, thank you for the explanation!

Can you, please, add a comment explaining what the "overfill" parameter does
and why it has different values on charge and uncharge paths?
Personally, I'd revert it's meaning and rename it to something like "trim"
or just plain "bool charge".
I think the simple explanation is that during the charge we can't refill more
than a PAGE_SIZE - 1 and the following allocation will likely use it or
the following deallocation will trim it if necessarily.
And on the uncharge path there are no bounds and the following deallocation
can only increase the cached value.

Thanks!
