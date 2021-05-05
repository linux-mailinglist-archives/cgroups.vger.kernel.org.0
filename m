Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148B03746FB
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 19:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhEERgS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 13:36:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1434 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240394AbhEERbq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 13:31:46 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145HTdbH023742;
        Wed, 5 May 2021 10:30:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=lCKnktCkBi4YxBOjzx3vBVE/A4hxadBhCdQSILNLPkY=;
 b=BoDBdWeSaDRfE7VaSoCaajcvBTr6CbVPITLc25mqL8rZKcwjMhfXmCKSjPEIPbshsDGp
 TkfCbwSbGlAqJdTDykdrCXdDnMKhSj1xmkwVh3HCroA3YiKxW4AiQEdlZKPUm5u6/Kk3
 aCxWMdsxrgoL6p1w+vMFzJ9LcfNYh8U6bKA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38bed2vrjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 10:30:38 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 10:30:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y142VYfmiFzDNyGeqcnq9x0dbhOgqE340+QBn/RwSQO/pmS9rkq3OOSCgNeQ9KX9uX/1VRA+Z2kqJZ6YrpSxSUy6rcQycI8ZLq42RTZuw/QXBn70xLN0czY7HC+Qp71z6LRtQfSJdg5qijpvpvotlkU9zw7HCgA1FpqWB2uTplZug3PyXxiNxq/yyTQhaarjl/Beucdc2sEkvVwP09lncE/t+Zf6N4lsSA0z094PJAiGucDRu2AuoxvZY7U/S1WnfN6oFMWdnmboMKNgw5Ppu6Pkmgf4x8yEnrnPehgCQKLNEIjzbMBi3P8iGN5TRgWFpyBpNksrAOWLDllBPZZQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCKnktCkBi4YxBOjzx3vBVE/A4hxadBhCdQSILNLPkY=;
 b=QNtiGcaWGYHEquzoUBLu/ajyYrAbI7vf/ZRmBjFMoA3MmnxuWauxTOzNgU2KaycvZQMDHwiYGHmafFxTDm80xwbSlqNN4ecqtOqYLebSBi+DkB1iBqlq6jHH7CLYeqFRLf+le3rLZ7a+ZXdUouGkUTk/1rcM8VTBSTdIuUT2yvc+336LCOTahYntUpliNlGdtUEuDKFx0ENo3srbhhJZdX5TdeCfnNVTR/yCO+rHnG1/TUwGxJC+6jAq2/z76fRty87fZHF0iFI5KUlY1cZpTdz72xNP7X6pmS6CcwgF3qmlcgHFwIc4WdRFtfkzqTILEoQPWMGbc8ONiNkhBBa+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3128.namprd15.prod.outlook.com (2603:10b6:a03:b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 17:30:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 17:30:36 +0000
Date:   Wed, 5 May 2021 10:30:31 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of
 kmalloc-cg-<n> caches
Message-ID: <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210505154613.17214-3-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:1dc0]
X-ClientProxiedBy: MW2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:907::40)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:1dc0) by MW2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:907::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Wed, 5 May 2021 17:30:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4183ab9d-e925-45a5-a95f-08d90feb7e34
X-MS-TrafficTypeDiagnostic: BYAPR15MB3128:
X-Microsoft-Antispam-PRVS: <BYAPR15MB312844F0EA4E9EFB1ACC4AE6BE599@BYAPR15MB3128.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTmg0iVFEQnrpJ+JQ0LeIgpZRq48k0p1Q0wq7gRjQRpVfd/b6w602RlW2zLgiTl55VdO6hrx8c8swsHVRpWgWJJtCAmfkaGxWiP9LyGO5BIIL0/AwjnwSNMuca383uBfkeqL26dyN3XD6R9PhRvoPhwKyuxs3t/sFBCOJWaSFepXf3jRK0p8Qdriq9/KD3NnPK08Yh+ZyE2oUH4QALzIbcRo0xhVUm3v3PiloGnjge+fqwXUvjdf9u2ZWDkMi7TFwExPGdwlDuAwkbk3M4LiTF8q51tEjE9mYuAJQnvIOG+wNKXfduKqAT6f/b8oMIAhJV+44DiOSQ/KtBdkwAHXnwhs0TRc61QrGFtbF/CkesfXEmCNvKEbzW6nyY64yUMP4s3HHlu99ndiVNfrkyE3fXrNCmGy9pRz/rf9z9+fGU1g6HNrNEOPRUrIJ1puIQ7XvKn/L8E+/Ms5ymcSDp8isN4qOJbHQMfNW1dm1Ql9cvl9ZgJ7MHrnKG+MKwIJ5RBrRmPmU+xMbQLnIJzd9h40z6nq7fs9CIJ04zvopd5VtDCysnZP8b2IkUO21jtk/YrYrwYEPivbGrPF4yotjFQbqvWhABIaw1W4/DRC30gS3tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(2906002)(66556008)(66476007)(66946007)(478600001)(8936002)(4326008)(52116002)(7696005)(316002)(38100700002)(8676002)(186003)(54906003)(86362001)(7416002)(6916009)(55016002)(83380400001)(16526019)(9686003)(6666004)(5660300002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YrXluDe6cOyYqk8BE+0fTJ76mwZQHEmQutFmTqleBFkaX0/6JaUlenwBygUH?=
 =?us-ascii?Q?YT5BvUTHUchyuVRD4Zey87X8IUu28YIrGDghda6X/T76u52XrdUrPzPeTQEj?=
 =?us-ascii?Q?l7ubuDWMK8stzXocI3VD/SYrHy16wlhS5bBz0ErpelRszSL2AI/ZoXrK52a+?=
 =?us-ascii?Q?zU+EqVMj1XogFclf43JegL+EbZBqCtFT1T792LHozRdBlZ+JB5Y2SwADo2a3?=
 =?us-ascii?Q?6HWP4plY/tNm2yS6dsmxfFnwQ3SLBVeWNagj43O+qQSoODAnq+9uHzkKBy8S?=
 =?us-ascii?Q?HQf1Vh6vPhauTxVQsjpu07IB8Zxb0g6gzqinPF0yUxZ4N+9gNp3fbkQ8smKB?=
 =?us-ascii?Q?WRfftv7MPeHsVlyRWKO2sJxJpo5jCMaSyMX00YGseCgRv8FOINq/X9u8XmHJ?=
 =?us-ascii?Q?nD42DOMMyZAilSJPVCaGOr+BP0xJxOZ8Kulp4iXX+hAcssoaxRMxEfsr64vd?=
 =?us-ascii?Q?W7yjBQz/XpdQs6erCv0mWX1XXn4znJk4B3ZB+eQUPby//Dx1FqZpiIcfOTUk?=
 =?us-ascii?Q?AVAl0DjIDpyerJa1IiCHYK2fG92nn/LJZhYltWZGv9ulgIpFyQHJyz3GGfTs?=
 =?us-ascii?Q?Td0A+uV7Nms0Q2GMHuGjLOePdy7j4ysYzOlWVHB9jyaMZ8/96GY2/BkxCxGS?=
 =?us-ascii?Q?VxMFHg58aNvAI289yLu6Pha7fzND5gWUg5CLlmIncrFYZ+Jqt8cnSxuzEuEi?=
 =?us-ascii?Q?GAogga+noHfTKwzb3Eoql5MmEBvCX2o9k2HwgR/Lpi/qtYwKEx5CQEdq4AO2?=
 =?us-ascii?Q?LZ9+eni3gJ3RVjLN1CPvzOFxQsp7ZA0dJo5YGruziJYKQVkK7TSrfbwisJsn?=
 =?us-ascii?Q?93XmRsMYntrpmSwGe0GWyh+405TAAxl1QjX4Qt3iCLFfipXKju2JLK5DUDbZ?=
 =?us-ascii?Q?Uj88zP6aqRJfdmd5BRup61tZjHHTc9mQr9YjmvIAGe433aBRf26HgQzo39MR?=
 =?us-ascii?Q?9yn9e3nZ6zqOxBvIHqnN+MW+1iaN/kZCptZaikUYukgk/M88WneKzqym1Yb6?=
 =?us-ascii?Q?ye6BrgatoTTlB91k98HDbSaUJKQmDUOGwXhiUdfIxyQX0dEqt8ogNhR+pVGp?=
 =?us-ascii?Q?kGBS8ZmxG+ir127yXLj1MQxFLmuARuRU+h7c5JXPiuBp6rcoE2xznMdp/woN?=
 =?us-ascii?Q?gA324Zi3Rsj7ckvA8Jzlaecd8zrhxSm0qRPQALycgSSjY+kxqgzIPPAAK566?=
 =?us-ascii?Q?POpr6ZOzaRrxKIh5qiySK1Sut3ZpSVallNQYZfoX2gUumWDj3gXJoEq9x/dB?=
 =?us-ascii?Q?cdX5DNVQZLIuL/qsRBAjWUL/lTZsKcUuyz1baE6bgR3qc8SKYGxha8+S055N?=
 =?us-ascii?Q?EqgWBALaU6e8b8fBV73+AAj+/ZN//0vJC4WEcrj8vYyENQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4183ab9d-e925-45a5-a95f-08d90feb7e34
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 17:30:36.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7K1ZNRvanRqf3hhSbBAHr7wdPiotvMzCMzeHTChs/i3qov6jhcSkJyOHtEd2N6Sp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3128
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: hA40WLY-1MQCZX4Rh-yahQnkyAD3thxL
X-Proofpoint-GUID: hA40WLY-1MQCZX4Rh-yahQnkyAD3thxL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105050121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 11:46:13AM -0400, Waiman Long wrote:
> There are currently two problems in the way the objcg pointer array
> (memcg_data) in the page structure is being allocated and freed.
> 
> On its allocation, it is possible that the allocated objcg pointer
> array comes from the same slab that requires memory accounting. If this
> happens, the slab will never become empty again as there is at least
> one object left (the obj_cgroup array) in the slab.
> 
> When it is freed, the objcg pointer array object may be the last one
> in its slab and hence causes kfree() to be called again. With the
> right workload, the slab cache may be set up in a way that allows the
> recursive kfree() calling loop to nest deep enough to cause a kernel
> stack overflow and panic the system.
> 
> One way to solve this problem is to split the kmalloc-<n> caches
> (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
> (KMALLOC_NORMAL) caches for non-accounted objects only and a new set of
> kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
> the other caches can still allow a mix of accounted and non-accounted
> objects.

I agree that it's likely the best approach here. Thanks for discovering
and fixing the problem!

> 
> With this change, all the objcg pointer array objects will come from
> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> both the recursive kfree() problem and non-freeable slab problem are
> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
> have mixed accounted and unaccounted objects, this will slightly reduce
> the number of objcg pointer arrays that need to be allocated and save
> a bit of memory.

Unfortunately the positive effect of this change will be likely
reversed by a lower utilization due to a larger number of caches.

Btw, I wonder if we also need a change in the slab caches merging procedure?
KMALLOC_NORMAL caches should not be merged with caches which can potentially
include accounted objects.

> 
> The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
> KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
> will include the newly added caches without change.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/slab.h | 42 ++++++++++++++++++++++++++++++++++--------
>  mm/slab_common.c     | 23 +++++++++++++++--------
>  2 files changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0c97d788762c..f2d9ebc34f5c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -305,9 +305,16 @@ static inline void __check_heap_object(const void *ptr, unsigned long n,
>  /*
>   * Whenever changing this, take care of that kmalloc_type() and
>   * create_kmalloc_caches() still work as intended.
> + *
> + * KMALLOC_NORMAL is for non-accounted objects only whereas KMALLOC_CGROUP
> + * is for accounted objects only. All the other kmem caches can have both
> + * accounted and non-accounted objects.
>   */
>  enum kmalloc_cache_type {
>  	KMALLOC_NORMAL = 0,
> +#ifdef CONFIG_MEMCG_KMEM
> +	KMALLOC_CGROUP,
> +#endif
>  	KMALLOC_RECLAIM,
>  #ifdef CONFIG_ZONE_DMA
>  	KMALLOC_DMA,
> @@ -315,28 +322,47 @@ enum kmalloc_cache_type {
>  	NR_KMALLOC_TYPES
>  };
>  
> +#ifndef CONFIG_MEMCG_KMEM
> +#define KMALLOC_CGROUP	KMALLOC_NORMAL
> +#endif
> +#ifndef CONFIG_ZONE_DMA
> +#define KMALLOC_DMA	KMALLOC_NORMAL
> +#endif
> +
>  #ifndef CONFIG_SLOB
>  extern struct kmem_cache *
>  kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
>  
> +/*
> + * Define gfp bits that should not be set for KMALLOC_NORMAL.
> + */
> +#define KMALLOC_NOT_NORMAL_BITS					\
> +	(__GFP_RECLAIMABLE |					\
> +	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
> +	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
> +
>  static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>  {
> -#ifdef CONFIG_ZONE_DMA
>  	/*
>  	 * The most common case is KMALLOC_NORMAL, so test for it
>  	 * with a single branch for both flags.
>  	 */
> -	if (likely((flags & (__GFP_DMA | __GFP_RECLAIMABLE)) == 0))
> +	if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
>  		return KMALLOC_NORMAL;

Likely KMALLOC_CGROUP is also very popular, so maybe we want to change the
optimization here a bit.

>  
>  	/*
> -	 * At least one of the flags has to be set. If both are, __GFP_DMA
> -	 * is more important.
> +	 * At least one of the flags has to be set. Their priorities in
> +	 * decreasing order are:
> +	 *  1) __GFP_DMA
> +	 *  2) __GFP_RECLAIMABLE
> +	 *  3) __GFP_ACCOUNT
>  	 */
> -	return flags & __GFP_DMA ? KMALLOC_DMA : KMALLOC_RECLAIM;
> -#else
> -	return flags & __GFP_RECLAIMABLE ? KMALLOC_RECLAIM : KMALLOC_NORMAL;
> -#endif
> +	if (IS_ENABLED(CONFIG_ZONE_DMA) && (flags & __GFP_DMA))
> +		return KMALLOC_DMA;
> +	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || (flags & __GFP_RECLAIMABLE))
> +		return KMALLOC_RECLAIM;
> +	else
> +		return KMALLOC_CGROUP;
>  }
>  
>  /*
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f8833d3e5d47..d750e3ba7af5 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -727,21 +727,25 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
>  }
>  
>  #ifdef CONFIG_ZONE_DMA
> -#define INIT_KMALLOC_INFO(__size, __short_size)			\
> -{								\
> -	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
> -	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #__short_size,	\
> -	.name[KMALLOC_DMA]     = "dma-kmalloc-" #__short_size,	\
> -	.size = __size,						\
> -}
> +#define KMALLOC_DMA_NAME(sz)	.name[KMALLOC_DMA] = "dma-kmalloc-" #sz,
> +#else
> +#define KMALLOC_DMA_NAME(sz)
> +#endif
> +
> +#ifdef CONFIG_MEMCG_KMEM
> +#define KMALLOC_CGROUP_NAME(sz)	.name[KMALLOC_CGROUP] = "kmalloc-cg-" #sz,
>  #else
> +#define KMALLOC_CGROUP_NAME(sz)
> +#endif
> +
>  #define INIT_KMALLOC_INFO(__size, __short_size)			\
>  {								\
>  	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
>  	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #__short_size,	\
> +	KMALLOC_CGROUP_NAME(__short_size)			\
> +	KMALLOC_DMA_NAME(__short_size)				\
>  	.size = __size,						\
>  }
> -#endif
>  
>  /*
>   * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
> @@ -847,6 +851,9 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  	int i;
>  	enum kmalloc_cache_type type;
>  
> +	/*
> +	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
> +	 */
>  	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
>  		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
>  			if (!kmalloc_caches[type][i])
> -- 
> 2.18.1
> 
