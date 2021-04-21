Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E623675B1
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 01:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhDUX3a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 19:29:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9310 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234681AbhDUX3a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Apr 2021 19:29:30 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13LNQ2QY002601;
        Wed, 21 Apr 2021 16:28:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=qG5Xb259e1bHsz8L6Vvb3G9GI+bwdaQKWdtR2nJOwUA=;
 b=nAN+FvZ6Huj5KXYKrH11b+in+5zKAls2gGQiJIl1UBnLOrrpzPQbWmU6QJx6BQqaTqK5
 AFN7mppo622XOteX7mF7ptS/aDrIAWLvRTbF5nVruaDbq/vu4nptpVipejX7cNeB074u
 4v80CoUCz0CJpQ3ECRo7yIO9leKOtFWL04I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 382k2uvk62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Apr 2021 16:28:35 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Apr 2021 16:28:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5VJr2d1NMhkh3r5J0aTODOglmkijMZaqbGk4Yn6Zhf6+QAXRgAsWokhwGB9R0pXg1PdpmPffVnWu0rBCsgooFcaEN5SNvqnB5PUfMaVQfIOUHLT7yo8jdD6i+H4+83ng1G/mro90squLaTOoAFkjK3Izr0AXLJj647ULkcrNZ79ZZh761RlEpig49cMuOTODrY2oqCyOfXbE1BgOr9x1/R+A84J2M8J5dRT9H56cJSsOAt773GhkuloZevuO/XDz+4fmLbHwHdI4J54OTAkUu7UM3XrOcp/4+jP8uyEmhDlYqNsektYC970T1+kal7yWanf53BQLXZkPXya/OXChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG5Xb259e1bHsz8L6Vvb3G9GI+bwdaQKWdtR2nJOwUA=;
 b=cmlNZ8s6IJXHD32JL+cwU7AecOY5ttpXeExBYT+m+XPDz01jynbPNB0oC96dTIZuLHS7HugBuM45KCGTrYjG+M5WOGtYi2t0DNwyBFeJfV6a1ui/WM6kkrl24R9y+qRsKTB4gHSCJkEZ6fvH3BpRO+lxdSQaSyOKyYQFfbC6wcndwuHoP5AAP7q0P8uhZjm6DwtPl2EfDtX58MSJ+GH3s+IP5XMmMzHQDi5U7tqiwKwMBWb1MTQ4G4lJjYE9gw4l7ovqoCIWXn/6M8YIxIJnUAJC6BACXMW7b3EBGmPwU14kS8FmFamB0uDQpcnn7TVi6BsaVk3DTaDCYP+OjZG/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4961.namprd15.prod.outlook.com (2603:10b6:a03:3c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 21 Apr
 2021 23:28:33 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 23:28:33 +0000
Date:   Wed, 21 Apr 2021 16:28:28 -0700
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
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH-next v5 2/4] mm/memcg: Cache vmstat data in percpu
 memcg_stock_pcp
Message-ID: <YIC1HEKF8SQQdnxa@carbon.dhcp.thefacebook.com>
References: <20210420192907.30880-1-longman@redhat.com>
 <20210420192907.30880-3-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210420192907.30880-3-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:4579]
X-ClientProxiedBy: MW2PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:302:1::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:4579) by MW2PR2101CA0003.namprd21.prod.outlook.com (2603:10b6:302:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.5 via Frontend Transport; Wed, 21 Apr 2021 23:28:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f53ea2cb-3d25-4a43-0eea-08d9051d2dc7
X-MS-TrafficTypeDiagnostic: BY3PR15MB4961:
X-Microsoft-Antispam-PRVS: <BY3PR15MB496140E2A2A730B276AA3245BE479@BY3PR15MB4961.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itushWobtAU10NR05s/3F5hPT0tYdK/ix7dF9P7zPh4PzdNHtfooRi63EPN1rcFTXJB/Hjo3h1D4xNxjUxwt/hYnKkJ0ZgrS5g3kHBwhQDM/uCWQFQjGVG9eOSUkrrNyV58/bbmQCRAY1tdvjYV2MwVUgfZJKYrQmtZAwNhgpgzYJ14Byq1LGovUPPlRk6Bimhxk7uRQjWWcpCpjgl9KwFjBaQBSeZHCuyTr9hZEzRmsQ2c8Swh2/xhYK4Q4R3qB3Wa4VxQkvTA4sISznvOeYXkvuEjZDP+j5Ufmep3F5tv1l73JOS/oQZeUF7WmU/HRefevLMr7spvlQV5Y7J4sIWj0f/Fu3t7RPmD+OttQyWLvqPdr5f2Mbwe5cr0jQ1ET1M3wfGzf4hZnaDbn7Obc/yYUVQaIH/Jv0TeBS51X5B+wzqPtuMQrdotH9YADZhm84FmJMmDGup8dFGwNFevte+bCRiN48WEFXP8QHRGabTqgFzUKk/aahO3mCJNm8/3w5UxwpIwXaMc1+BST3LV5A/RE7njmlj1sVl2L8Qa4tKiVgNaV2kIyjEzPYSxd46DcfqoPG+yFre0ZGrX/msYvIli4Ql/z/jJnY6Dx3hyACR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(66556008)(8676002)(498600001)(6666004)(7416002)(66946007)(66476007)(38100700002)(6506007)(8936002)(16526019)(7696005)(55016002)(9686003)(52116002)(5660300002)(83380400001)(6916009)(4326008)(2906002)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Iceueo/5VAH0ZcXEAnyf8khGGYbJvQEvYDj5OIamJdbazL+Yk0KWNLHjj8WW?=
 =?us-ascii?Q?RtZYIrQ6w5j+FlOndC0Yj+aAqXzLwOlsErQde0snaIUrCldl38VsIXG2mEab?=
 =?us-ascii?Q?CaLwa21dNtwMpuRJ8Wf/i86FDAd7Rgf2NWgWLL1gyuIx4K5Zx2qt7TTpv7P4?=
 =?us-ascii?Q?1jU8B96S1HBHiGVAKrNQ9qnenhrrfjjv8YgqS1gRCVz9iSU3i/Py0ETLIpj9?=
 =?us-ascii?Q?rLwzwFHjtg71NcFaqP8njyILfbT2EpOGFtHd0S2JjxZ0HTNnkpcSoDarsZ+D?=
 =?us-ascii?Q?wBevvfJB3Wzg2BDF5Utzef6ZywEo6yHYbVWcxnoY3cr5ga4/DkMoco/4NNuY?=
 =?us-ascii?Q?T9CCNEC9o230GrgCiNoMs9hsGCfmQ8oYO1oK270Tqek4y2DEo8hILgsT1VfX?=
 =?us-ascii?Q?+GP+TXO1F66Ar7jK0Gmx5C9YWXtKkYHJFNTqn4RQp4u3pqcConYeRnSBF9xs?=
 =?us-ascii?Q?CVpV0ZOzUVQq+bT7QXCtLZL5kCCys44evGN2EFNxkCtQ8Bq3Ir/6l98/JbFs?=
 =?us-ascii?Q?IrJ1hcuz7XjRJXN6QCeE2PQQEfN3opeFvVuWMd9eoUNBVnGRHXATtulsmII+?=
 =?us-ascii?Q?mJ6+dwc0RJBB9CViNR4cIVUSkfDP1sw/C/asyG0lzFa6/SvYf0b8qcritLPR?=
 =?us-ascii?Q?SSrExn7bEsg1skIIBqFm53HraT/JsRxbrCI8o2QArvjHLs3pAfklrf1BBUjD?=
 =?us-ascii?Q?/ViTsYEle18R5Nlrl6XvDCqjUYf9g4uYgpZfoP5GHp65CgJg1JpXxmG8h5la?=
 =?us-ascii?Q?S+UoYJ7LDDiYjYzCHF8HlV8+xJ49UwUqGlQm16ix7A3IHqsVs8Gb+xwZkBfY?=
 =?us-ascii?Q?g5b1NHPk4Oub3J3zPwL+gCq7TShhZbxHmZ7Y0sCUWh0MceTSPMDasXW8fIYt?=
 =?us-ascii?Q?e3M5gpk0K7XDiIoqU72tuyeusLXVIqH6kKXMN2Bcq8to2vu3lxxuGl35fBxl?=
 =?us-ascii?Q?32LUCvO+DM98C24kWy5ip2U8wblQSvgSpD18CBnQGarW938c4yc3CKgR+Vnd?=
 =?us-ascii?Q?JFe83mAUsRw/KaYPyd1Lmkg/JoGbkLYG3dBBC3IAz8/XT0epYIEGoVJR7S1B?=
 =?us-ascii?Q?0cWGMAoQNEU/zp9+i+W7wUQ5eVJIivS8YQ1YRQT5RD75bejFvZVn3TnXegsD?=
 =?us-ascii?Q?XPG7LtQ0KpsX1eWsyJLbl8cFcDf9HzHC7e/2yGs5vZfBoSdmdl2ePU6aPSTw?=
 =?us-ascii?Q?rJt7qM8w76dXq9ua2uzG9+PO+SYyQi94KRrfasVbKyLMIx+VS2Gab9upTtjf?=
 =?us-ascii?Q?xSb6/JqKYDTJ4yWsov8j2KkLCG8s4913MoWH6vVX+oTBk18kJyhLrtMXpxEw?=
 =?us-ascii?Q?HaOTFsEu6tRq7W+kgh42GslErNjNNzbWwupa5vdITF2VNw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f53ea2cb-3d25-4a43-0eea-08d9051d2dc7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 23:28:33.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7hdsPtMubPSof92BqnIQKN1RoZz7NyFdS3F6zD8p0agIN6PWV0WNqHOeA2RLUT6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4961
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: A4Yndv17khktB_2rHQDp6JYH1koyMAAI
X-Proofpoint-GUID: A4Yndv17khktB_2rHQDp6JYH1koyMAAI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_08:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210153
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 20, 2021 at 03:29:05PM -0400, Waiman Long wrote:
> Before the new slab memory controller with per object byte charging,
> charging and vmstat data update happen only when new slab pages are
> allocated or freed. Now they are done with every kmem_cache_alloc()
> and kmem_cache_free(). This causes additional overhead for workloads
> that generate a lot of alloc and free calls.
> 
> The memcg_stock_pcp is used to cache byte charge for a specific
> obj_cgroup to reduce that overhead. To further reducing it, this patch
> makes the vmstat data cached in the memcg_stock_pcp structure as well
> until it accumulates a page size worth of update or when other cached
> data change. Caching the vmstat data in the per-cpu stock eliminates two
> writes to non-hot cachelines for memcg specific as well as memcg-lruvecs
> specific vmstat data by a write to a hot local stock cacheline.
> 
> On a 2-socket Cascade Lake server with instrumentation enabled and this
> patch applied, it was found that about 20% (634400 out of 3243830)
> of the time when mod_objcg_state() is called leads to an actual call
> to __mod_objcg_state() after initial boot. When doing parallel kernel
> build, the figure was about 17% (24329265 out of 142512465). So caching
> the vmstat data reduces the number of calls to __mod_objcg_state()
> by more than 80%.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7cd7187a017c..292b4783b1a7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -782,8 +782,9 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
>  	rcu_read_unlock();
>  }
>  
> -void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> -		     enum node_stat_item idx, int nr)
> +static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
> +				     struct pglist_data *pgdat,
> +				     enum node_stat_item idx, int nr)
>  {
>  	struct mem_cgroup *memcg;
>  	struct lruvec *lruvec;
> @@ -791,7 +792,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  	rcu_read_lock();
>  	memcg = obj_cgroup_memcg(objcg);
>  	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -	mod_memcg_lruvec_state(lruvec, idx, nr);
> +	__mod_memcg_lruvec_state(lruvec, idx, nr);
>  	rcu_read_unlock();
>  }
>  
> @@ -2059,7 +2060,10 @@ struct memcg_stock_pcp {
>  
>  #ifdef CONFIG_MEMCG_KMEM
>  	struct obj_cgroup *cached_objcg;
> +	struct pglist_data *cached_pgdat;

I wonder if we want to have per-node counters instead?
That would complicate the initialization of pcp stocks a bit,
but might shave off some additional cpu time.
But we can do it later too.

>  	unsigned int nr_bytes;
> +	int nr_slab_reclaimable_b;
> +	int nr_slab_unreclaimable_b;
>  #endif
>  
>  	struct work_struct work;
> @@ -3008,6 +3012,63 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>  	obj_cgroup_put(objcg);
>  }
>  
> +void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> +		     enum node_stat_item idx, int nr)
> +{
> +	struct memcg_stock_pcp *stock;
> +	unsigned long flags;
> +	int *bytes;
> +
> +	local_irq_save(flags);
> +	stock = this_cpu_ptr(&memcg_stock);
> +
> +	/*
> +	 * Save vmstat data in stock and skip vmstat array update unless
> +	 * accumulating over a page of vmstat data or when pgdat or idx
> +	 * changes.
> +	 */
> +	if (stock->cached_objcg != objcg) {
> +		drain_obj_stock(stock);
> +		obj_cgroup_get(objcg);
> +		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> +				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
> +		stock->cached_objcg = objcg;
> +		stock->cached_pgdat = pgdat;
> +	} else if (stock->cached_pgdat != pgdat) {
> +		/* Flush the existing cached vmstat data */
> +		if (stock->nr_slab_reclaimable_b) {
> +			mod_objcg_mlstate(objcg, pgdat, NR_SLAB_RECLAIMABLE_B,
> +					  stock->nr_slab_reclaimable_b);
> +			stock->nr_slab_reclaimable_b = 0;
> +		}
> +		if (stock->nr_slab_unreclaimable_b) {
> +			mod_objcg_mlstate(objcg, pgdat, NR_SLAB_UNRECLAIMABLE_B,
> +					  stock->nr_slab_unreclaimable_b);
> +			stock->nr_slab_unreclaimable_b = 0;
> +		}
> +		stock->cached_pgdat = pgdat;
> +	}
> +
> +	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
> +					       : &stock->nr_slab_unreclaimable_b;
> +	if (!*bytes) {
> +		*bytes = nr;
> +		nr = 0;
> +	} else {
> +		*bytes += nr;
> +		if (abs(*bytes) > PAGE_SIZE) {
> +			nr = *bytes;
> +			*bytes = 0;
> +		} else {
> +			nr = 0;
> +		}
> +	}

This part is a little bit hard to follow, how about something like this
(completely untested):

{
	stocked = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
		: &stock->nr_slab_unreclaimable_b;
	if (abs(*stocked + nr) > PAGE_SIZE) {
		nr += *stocked;
		*stocked = 0;
	} else {
		*stocked += nr;
		nr = 0;
	}
}



> +	if (nr)
> +		mod_objcg_mlstate(objcg, pgdat, idx, nr);
> +
> +	local_irq_restore(flags);
> +}
> +
>  static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  {
>  	struct memcg_stock_pcp *stock;
> @@ -3055,6 +3116,25 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>  		stock->nr_bytes = 0;
>  	}
>  
> +	/*
> +	 * Flush the vmstat data in current stock
> +	 */
> +	if (stock->nr_slab_reclaimable_b || stock->nr_slab_unreclaimable_b) {
> +		if (stock->nr_slab_reclaimable_b) {
> +			mod_objcg_mlstate(old, stock->cached_pgdat,
> +					  NR_SLAB_RECLAIMABLE_B,
> +					  stock->nr_slab_reclaimable_b);
> +			stock->nr_slab_reclaimable_b = 0;
> +		}
> +		if (stock->nr_slab_unreclaimable_b) {
> +			mod_objcg_mlstate(old, stock->cached_pgdat,
> +					  NR_SLAB_UNRECLAIMABLE_B,
> +					  stock->nr_slab_unreclaimable_b);
> +			stock->nr_slab_unreclaimable_b = 0;
> +		}
> +		stock->cached_pgdat = NULL;
> +	}
> +
>  	obj_cgroup_put(old);
>  	stock->cached_objcg = NULL;
>  }
> -- 
> 2.18.1
> 
