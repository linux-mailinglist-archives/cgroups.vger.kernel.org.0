Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79262EB277
	for <lists+cgroups@lfdr.de>; Tue,  5 Jan 2021 19:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbhAESY7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jan 2021 13:24:59 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11610 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727315AbhAESY6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jan 2021 13:24:58 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 105IDOLB026491;
        Tue, 5 Jan 2021 10:24:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=WtT29LA629qXQBw7Zvb7T9hSmf0vZGxqOAOGaSrQNjI=;
 b=mGYaZLqlcRhJu26/VIovO2ZJmzC5oGVVGS1EH+e/hGfSHvDZHpaRAc7f7G5NO66ce+b6
 6P0pXT6DNoWS/s1DH/OAMNK0pTxyQzzxzq3HuQw0Z3ZCDpwEgMlzKR0G+JPoyt5Lmwyg
 ELEG6SdwtauuCvBo5HJy67rwKmqkVnK6qZk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35vpmkt60w-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Jan 2021 10:24:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 5 Jan 2021 10:23:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oArgENm+YNsAW7urOu3z012uerGgyGjdU6hyP70rZX9pj1EvAMX4g3RfCHBfl2r71CXMIEgH5jeDwR2DPXfV6r1ZM+OfkjHeGJdonzZ5rFcbmRePC26IF6kTy3fKkJybo1rvRT8vMmxKGeHlFXsxD6GpXvXTBrXnY3v3R/DTeeUyB3Rm7twWg3YNncyo79r8kZNZRS0mZfq09RmB/V6AcSTfuL6xbwcNdd1VnRsZ/bhQT/bxAIQoHr6uO0PGwRKJu8PCJ/Ix+AlYCl1N5zPwaqzFnhk7/Cp2xRkNQ+e4AiUrM1zfbHG35dyy7z3qYAnVp7cLnPPZdmeG6zIgIXtQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtT29LA629qXQBw7Zvb7T9hSmf0vZGxqOAOGaSrQNjI=;
 b=l+olp5ytm7Alm4GkUFKzM65hvS9xadyGhEqQ3pOElQjDmp5A+LxVdRaU33E7BYbdt+/2OLs5Eic8o7f9l5uiO87DrlP9GCojlhIaYHZ7GvOw/KPCwEFb4gNPQkyLnoXkbKTvFmrCknyOKPQz0t1yCZNqoDls7Np4Z9st42W7LNTRebA8eN+6DCotyDhkSgnrjdLmRqL2keY2QeyOTnY22EeAnQcSBlymctjB2Qmfi2weZSZtw6aEpSNfUZKGUIWrltRWIrLgqubJ8XMr7mm7wTFU/64KFou+RMZ3r2wexn0K+7uSmq17mei7YzBHF3sCSRQXNSW9OgQYme5GGaHabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtT29LA629qXQBw7Zvb7T9hSmf0vZGxqOAOGaSrQNjI=;
 b=YUdIeEhjHFGtoEXNQKc3o47d+XKPYm8dZDs6Ed1XhOk521+sJ7SdtBdbv1ABWP+upfagLKjPcfkT2baiTTe1zBO6s43R8849xVonoHG3Y6bGMEfYG/n1WZrKfFYzqsste2ymc0qTi9J3AXKLd+sO3ITGaPXaTAIW1pqIJEXE4bA=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3222.namprd15.prod.outlook.com (2603:10b6:a03:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.23; Tue, 5 Jan
 2021 18:23:56 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 18:23:56 +0000
Date:   Tue, 5 Jan 2021 10:23:52 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Imran Khan <imran.f.khan@oracle.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/memcontrol: Increase threshold for draining
 per-cpu stocked bytes.
Message-ID: <20210105182352.GE371241@carbon.dhcp.thefacebook.com>
References: <1609862862-3573-1-git-send-email-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609862862-3573-1-git-send-email-imran.f.khan@oracle.com>
X-Originating-IP: [2620:10d:c090:400::5:6385]
X-ClientProxiedBy: MW4PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:303:6a::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:6385) by MW4PR04CA0057.namprd04.prod.outlook.com (2603:10b6:303:6a::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Tue, 5 Jan 2021 18:23:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5c4e342-15e0-465d-6418-08d8b1a7104b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3222:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3222F428CDE374F1F52DF5FEBED10@BYAPR15MB3222.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOFDVY+jZpOQVhd88Ms8mPQ/USrhOQIoasphp8sPfLI2ukb8p29WOH58LttJL4zm1axdWaCEvW+dY+jZIWctdi2nh3342PBEaG0UMTd3ZIov8cpMZ6Bx4Pgpab7jR01pg09gfBANJr5toAp4m71tG8Md4QKg1gcFG/FSTmsKBh3gX9NmjZc49Z9AWn3kuT/nlTUF+0VYACrDmcBcAdixS27gdPO3yg51079sLvLZY2aXUsGjBYH+CoziOJlU/eFW7dhH375QeaDkjy5wS3bgJS4m97Rw4m1Q2JualI/DKiEmFTosu6tU855SoiIOUfA6DgWe/23htcKdM6DV2gOIoN75JsSTMaxOJ8IWrtiS98WRPbhJp60UpY8j4qdYmvOrZkFm8tiwPAwjQEz9OsAWtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(346002)(136003)(396003)(83380400001)(6666004)(86362001)(33656002)(8676002)(478600001)(6916009)(4326008)(16526019)(186003)(66556008)(1076003)(316002)(7696005)(55016002)(6506007)(8936002)(66476007)(9686003)(52116002)(5660300002)(2906002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kJSZW2Vp79FCQv916NCh35zle/2IebEB1qWSkOK8yks+kOp6gRpce6Jm5UWO?=
 =?us-ascii?Q?zP4IIvfUpyRrBnTCPh3AP2ED5kqdbAgBW06u2J5BQA6M+wTjD8pNNPGIiRzU?=
 =?us-ascii?Q?VyQYnwo9CTlRInQ8mWdHCL0H3Zf2owLxC70M77GmVSuDSfjvCc1X7e/2hyiG?=
 =?us-ascii?Q?vd4ckCD+9xyiHkpM/CHBl5jGXqbjqod7jWXRZC2nM4MPRRHOsFK2ixwdrmPz?=
 =?us-ascii?Q?sbhzzw9UnLpB7Trq/GwOBsfGrkCmq9xS6nXhgR47Q0NuVRc/cCMmhGsYknWO?=
 =?us-ascii?Q?PxkcxAXplb5NIPsqxO34MYsL7WAfpeKI3qigD5iAZquMkKrEqhm8RFhl/tD5?=
 =?us-ascii?Q?BveIPigDeCcjVIJHg+9WNY1lo50kHlETc4LaIOPL1VXNx5rZH+Xq/4dZlDz8?=
 =?us-ascii?Q?jU4ioyi8PuPdegYHcBvHHBq880pBOVUwC2zEH/V1AKdOEZ6oo+G4z+dErb1V?=
 =?us-ascii?Q?fdrHPfJcXku9qEF8G3RupjmR/FPDRNTAxfiQKncUQo7yiir5pf3eXczYvG94?=
 =?us-ascii?Q?esBPc+bNH5M2RDYr9G232WyTT/xl0XnTvCtG6+cS4YgMLKCvv+RvsY7BDwVu?=
 =?us-ascii?Q?03T7FhEvUI9o0a7nSQ9Qg210W9XoB95KFcgwuo7Oj9SEHC/9Zl9kYIGZ73wi?=
 =?us-ascii?Q?h4uW8Dp/CKg0t8ZptJ1UrdBcD81lCWNnZv0HfTWNrU2qoBjzxXB6jl2V81Zw?=
 =?us-ascii?Q?jF+mA/bGVxYMO0YYNuq2hc5o0WSHw+j5g1CrLIn4DNr1aPZe3hK9t3ZNnZRe?=
 =?us-ascii?Q?0xJmCI21T3sbddi5hM37E4NZCoFOI4dIBl3WtwK2XhaP1zF/mtVoV2iXcUeR?=
 =?us-ascii?Q?2UWJ0aEDhXLt084MpmSiNvOXtjNYgldKn9RJaKqDkAMw9LnSp4XZhQ9R5y/s?=
 =?us-ascii?Q?KfZ7TI/ddDcvXzrTALb7X+MOZvKSz4WH6kd7K1C/KZEM69uYQnFsWwuWjZwW?=
 =?us-ascii?Q?9Kds97Cl/F1VdsOMeGIup1ARvserNnhsvjisEFSY0KJwuuakZIhWBzLv/Wli?=
 =?us-ascii?Q?nTr62pQHqKa0fwGJ1vLqJsEu5A=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 18:23:56.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c4e342-15e0-465d-6418-08d8b1a7104b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0V0rjRH4SprNw9UdXvuIrZfZq5Nm0bZKzVjBd6k3LtNt3i0GdcLBhKKvF89AnwU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3222
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_05:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 05, 2021 at 04:07:42PM +0000, Imran Khan wrote:
> While allocating objects whose size is multiple of PAGE_SIZE,
> say kmalloc-4K, we charge one page for extra bytes corresponding
> to the obj_cgroup membership pointer and remainder of the charged
> page gets added to per-cpu stocked bytes. If this allocation is
> followed by another allocation of the same size, the stocked bytes
> will not suffice and thus we endup charging an extra page
> again for membership pointer and remainder of this page gets added
> to per-cpu stocked bytes. This second addition will cause amount of
> stocked bytes to go beyond PAGE_SIZE and hence will result in
> invocation of drain_obj_stock.
> 
> So if we are in a scenario where we are consecutively allocating,
> several PAGE_SIZE multiple sized objects, the stocked bytes will
> never be enough to suffice a request and every second request will
> trigger draining of stocked bytes.
> 
> For example invoking __alloc_skb multiple times with
> 2K < packet size < 4K will give a call graph like:
> 
> __alloc_skb
>     |
>     |__kmalloc_reserve.isra.61
>     |    |
>     |    |__kmalloc_node_track_caller
>     |    |    |
>     |    |    |slab_pre_alloc_hook.constprop.88
>     |    |     obj_cgroup_charge
>     |    |    |    |
>     |    |    |    |__memcg_kmem_charge
>     |    |    |    |    |
>     |    |    |    |    |page_counter_try_charge
>     |    |    |    |
>     |    |    |    |refill_obj_stock
>     |    |    |    |    |
>     |    |    |    |    |drain_obj_stock.isra.68
>     |    |    |    |    |    |
>     |    |    |    |    |    |__memcg_kmem_uncharge
>     |    |    |    |    |    |    |
>     |    |    |    |    |    |    |page_counter_uncharge
>     |    |    |    |    |    |    |    |
>     |    |    |    |    |    |    |    |page_counter_cancel
>     |    |    |
>     |    |    |
>     |    |    |__slab_alloc
>     |    |    |    |
>     |    |    |    |___slab_alloc
>     |    |    |    |
>     |    |    |slab_post_alloc_hook
> 
> This frequent draining of stock bytes and resultant charging of pages
> increases the CPU load and hence deteriorates the scheduler latency.
> 
> The above mentioned scenario and it's impact can be seen by running
> hackbench with large packet size on v5.8 and subsequent kernels. The
> deterioration in hackbench number starts appearing from v5.9 kernel,
> 'commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> instead of pages")'.
> 
> Increasing the draining limit to twice of KMALLOC_MAX_CACHE_SIZE
> (a safe upper limit for size of slab cache objects), will avoid draining
> of stock, every second allocation request, for the above mentioned
> scenario and hence will reduce the CPU load for such cases. For
> allocation of smaller objects or other allocation patterns the behaviour
> will be same as before.
> 
> This change increases the draining threshold for per-cpu stocked bytes
> from PAGE_SIZE to KMALLOC_MAX_CACHE_SIZE * 2.

Hello, Imran!

Yes, it makes total sense to me.

Btw, in earlier versions of the new slab controller there was a separate stock
for byte-sized charging and it was 32 pages large. Later Johannes suggested
the current layered design and he thought that because of the layering a single
page is enough for the upper layer.

> 
> Below are the hackbench numbers with and without this change on
> v5.10.0-rc7.
> 
> Without this change:
>     # hackbench process 10 1000 -s 100000
>     Running in process mode with 10 groups using 40 file descriptors
>     each (== 400 tasks)
>     Each sender will pass 100 messages of 100000 bytes
>     Time: 4.401
> 
>     # hackbench process 10 1000 -s 100000
>     Running in process mode with 10 groups using 40 file descriptors
>     each (== 400 tasks)
>     Each sender will pass 100 messages of 100000 bytes
>     Time: 4.470
> 
> With this change:
>     # hackbench process 10 1000 -s 100000
>     Running in process mode with 10 groups using 40 file descriptors
>     each (== 400 tasks)
>     Each sender will pass 100 messages of 100000 bytes
>     Time: 3.782
> 
>     # hackbench process 10 1000 -s 100000
>     Running in process mode with 10 groups using 40 file descriptors
>     each (== 400 tasks)
>     Each sender will pass 100 messages of 100000 bytes
>     Time: 3.827
> 
> As can be seen the change gives an improvement of about 15% in hackbench
> numbers.
> Also numbers obtained with the change are inline with those obtained
> from v5.8 kernel.

The difference is quite impressive!

I wonder if you tried smaller values than KMALLOC_MAX_CACHE_SIZE * 2?
Let's say 16 and 32?

KMALLOC_MAX_CACHE_SIZE * 2 makes sense to me, but then the whole construction
with two layer caching is very questionable. Anyway, it's not a reason to not
merge your patch, just something I wanna look at later.

> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
