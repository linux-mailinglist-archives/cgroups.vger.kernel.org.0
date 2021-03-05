Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647E832F686
	for <lists+cgroups@lfdr.de>; Sat,  6 Mar 2021 00:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCEXUu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Mar 2021 18:20:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53046 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229709AbhCEXUh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Mar 2021 18:20:37 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 125NHZQU003724;
        Fri, 5 Mar 2021 15:20:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=f32fyFzwjaU0mA2f3MrVKPDbjM5W6NBbQk7qWSHPiAo=;
 b=Bg83jKphk4KObye9bvQS6A5b1qf3eUwlhxCXxr/dc2gYYELm+QTFiD4xAQCDxIxDCS2/
 w4ErftuouY3uJlWcNGEdrhEQ9giOBh5OUj3pwt+OWf84BO8OpHIhJsjA5S7kPhE3yp98
 H3/pPFQBfYeoA0DG6XMExNAAadNiZecx2iw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 373ff34yct-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Mar 2021 15:20:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Mar 2021 15:20:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHDErMOUDRUfDThb0833rHXlcWLbX0iYSh5jhgFRFwLwCj6jwc3dpQuuRILOmm9x9V0uOVWi4ZQbAQQkuqTQXOQaYKBZf/rJQrIYN/k1gTLTdzbMfV60jvfLucUYG6FEIURvuFcTw2950Jtg+CoRuxxF4stDc2JloES0QuEJ0E7A0zGu1lwYBWQEOm/zndCeYbV8ioxlOgBExh5gRDyyDTQUL4DBD692b1T3H1a8s0ftO7U0T+soesamaS7M3DcjVia5HXDMds2v53c2GXGYR6X0HtALOG7S1dS0+p0PbmnjB9srd1QIOWTv5fk4JScVi9BJPSFOXQ8GNdzjalbRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f32fyFzwjaU0mA2f3MrVKPDbjM5W6NBbQk7qWSHPiAo=;
 b=kdWM31/BkJCSGV6bMolFN1eMdBMv885TM21+Lo0x4r8dn5+GYgOIrgUkkTimqb0K6490X3YNpdQf1v/ovGzUPav9kExxJ0XmErbWzQKkMbFG95UfUIO+m1YJGqNPuXdqn+LABkgdkgMT3wcU9B4rn+GY04Mt6aFstFvatojJ5jN4xJf6cCRF9I/xcUY7Z/w3wb9SlGUrjEex1YGACaJB91iuBtWJdNenw6YwJJ1INe2a9kxEHwkunJxSBopahwtISXcd39bXj/85u1XSDl3CaeL3ZeL9jff/oav/wb0tYWYArU34S3CAsEIjhmsBrE//M14Xa5ojHzxJ+/GBLKpRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4140.namprd15.prod.outlook.com (2603:10b6:5:32::18) by
 DM6PR15MB3643.namprd15.prod.outlook.com (2603:10b6:5:1f7::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Fri, 5 Mar 2021 23:20:23 +0000
Received: from DM6PR15MB4140.namprd15.prod.outlook.com
 ([fe80::cc33:f02c:46ba:f434]) by DM6PR15MB4140.namprd15.prod.outlook.com
 ([fe80::cc33:f02c:46ba:f434%5]) with mapi id 15.20.3912.025; Fri, 5 Mar 2021
 23:20:23 +0000
Date:   Fri, 5 Mar 2021 15:20:18 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] memcg: charge before adding to swapcache on swapin
Message-ID: <YEK8stUpyrOEuIp/@carbon.DHCP.thefacebook.com>
References: <20210305212639.775498-1-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210305212639.775498-1-shakeelb@google.com>
X-Originating-IP: [2620:10d:c090:400::5:6f6c]
X-ClientProxiedBy: MW4PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:303:b4::9) To DM6PR15MB4140.namprd15.prod.outlook.com
 (2603:10b6:5:32::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:6f6c) by MW4PR03CA0244.namprd03.prod.outlook.com (2603:10b6:303:b4::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 23:20:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be633e91-8919-4754-1985-08d8e02d401e
X-MS-TrafficTypeDiagnostic: DM6PR15MB3643:
X-Microsoft-Antispam-PRVS: <DM6PR15MB36436BA21D4013C518091221BE969@DM6PR15MB3643.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ghj3eWVFLx0qv/JNWbp/TGUA3ULahLypfpGL/TB/Ysh5wTemThgw2IS6zn6jnuVVxmRLa+rDRV2QF2/g7ZrqD8Xh/4E/eD2W+mDtcqeOP8TSjvrSxSqpJG/EdPeGEnEQk35RSc/5lbOvI85wMzqZi6apiFVRMennXLF5yoAwBpUNI6CXHFYqKjcjfaJ2LUggllXLYTNM2/OhZSJY5gue1AkjR9wQLl9hghs0bHmUXWvPeYX8qgNz3JXlK/MnsvYws/zmaaIA1Av1gESQ2Aw3LNe6q3oVt9v0seK7k8ihI2emzOogYYE3yI7ecTXbuZpDQ0kTW4zDUE0eXaZwDLgfUmP+MbrDe4MpDd4GHSbVXA6NVJozgINSl1g8uxZClWlvF14vSrYsQnhEZ8ZsLH/kKdCRJNg/ei2ucQaoCmAeZrbpGQoXtaiY9pqml5b+Yfbc9EXThyN+jM3COaEWRro6JpSk2NMmwyFj+7UPpkD6sUWzTtjmIcAj0Hq8kNnglHPajiFAh6qBi/R+H3Dr9PRqdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4140.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(366004)(346002)(7696005)(316002)(52116002)(6916009)(186003)(8936002)(54906003)(30864003)(16526019)(8676002)(66946007)(55016002)(478600001)(4326008)(66556008)(6506007)(9686003)(66476007)(2906002)(5660300002)(6666004)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ibshtWbiP6kUGwR0sVeOBGpA6zTubLGhruIiQAPzeUBm4gazQBDeErvNwDNm?=
 =?us-ascii?Q?lZzdIIBxNmCdhNRUMtBA14DzDgcMp6YmTH6tBC+yeKvDJUWhdnkayK3yKaPu?=
 =?us-ascii?Q?KpoPwP3MHDKuEIdqf8yy+bORiwzf+9CgTSTYm1iMlP6VIDe68iZ84Kp7oXOA?=
 =?us-ascii?Q?d4J+tQ0/M2xKIpEm207HM/CodNZs6gadWAosoReQUCEAr/Mcd3Z9pX9Lpxh2?=
 =?us-ascii?Q?RUQoQkmqT7b9gdqBlqiQ6J2HJOmOwvuVFHgzTVTaiDt6b2tHFGQ1Ibjsc9Vt?=
 =?us-ascii?Q?NqusKK+jFoxWdwm3uVzGF/S/7UiNaP9RiV9T1JYOu4nmM0rRPIlfdLUj6nIm?=
 =?us-ascii?Q?F+/P6WpC6MaeQ6DZmLp09070FRwoI90/VEPgXFuSne5BQ94lxXRFLlOSwmBd?=
 =?us-ascii?Q?DgSyRVMQAULU/YUyAjCBCzPfeVz++IMFN8QhCpAJ7WDiL42gPuklXScXw+6W?=
 =?us-ascii?Q?/y+lCHuOi/MgDVjZv+Jikj1gznoxwvXDbGBiph5Bsaa2VQ6HiH3jBGntaCha?=
 =?us-ascii?Q?Fq8DSJlaVqpeJYQNFg2iBjfAcZz2/k36u7aCr7IxRhfr1zbxDwajebgqBGyW?=
 =?us-ascii?Q?zN2I4a/tdm4HjM7PLQPH5LuZGMEhqyXZAIZW8Yr7c5UX8VPqbb3i4anipTSj?=
 =?us-ascii?Q?LNa6WZvc2kvM5UyTU3L4GrxmgcmgyU1UU7j5Idk+QyGxfcgGyKV/18gUPhxg?=
 =?us-ascii?Q?9n6YRihZJ7RNvEMhCH8k4+kjXqvqgE1JXhvzafti7BVMwHeewSyeGjPrsIJI?=
 =?us-ascii?Q?wMoo8aina/gDLM1dvfNrDqcpKMZEqTpioJynwc46h4agcBnxEZsdRU0W8daK?=
 =?us-ascii?Q?dTaJq2lLJr6twPKAFKLaazIOHEr3e4Xe1mls0Y16WkmGPDWefsmypvhQE8Ij?=
 =?us-ascii?Q?YYUOLGz0uJKNrgiB5ZV6+E2R2MyE9QyzGRc8ws+lOP9RruC/E5Y3mtoA3+Tr?=
 =?us-ascii?Q?POqdSBU/48LG+idbCMFH4n+lZUqd3dR4wVlY/Lq+9iBO1prZ1TJSROrUOr+3?=
 =?us-ascii?Q?3NgPs+7cUcySot1ypwzDVwPnpBEBsUBqgDW5cYTkH0lyVKDELLB8k4me1AEM?=
 =?us-ascii?Q?jVcUihvJZw7hLx53BACazpC8MB4UcPDm1ZbmrgbQiKB2YvcslkOKQC8lDrqQ?=
 =?us-ascii?Q?yrgKLqFhGDVy6djl2BvvLRhNN1FEITv9h8hGyxss52ROdiFisVpResJIEaVl?=
 =?us-ascii?Q?6uqE0HTQJg62E1fjyZbDXGfJO6OqVhLvwgyw0Bu+wE/moRN7DrFFsS9nyFLx?=
 =?us-ascii?Q?OFD/qhA9KAnr8jHMQIsE7drs0pYTjyF9htEC8mHAidPN1ucMIoxx5ncI2wfx?=
 =?us-ascii?Q?4+pyevMTRyr2diz0+6hXuer2jpiDnMnI4hE/slYn/NYKuQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be633e91-8919-4754-1985-08d8e02d401e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4140.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 23:20:23.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggPSgfdPL4srqRwXQQ5AaAVcHTfz5CNia2U01ET8AryK/POzGf4upIJXNXTCOK2U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3643
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_16:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 05, 2021 at 01:26:39PM -0800, Shakeel Butt wrote:
> Currently the kernel adds the page, allocated for swapin, to the
> swapcache before charging the page. This is fine but now we want a
> per-memcg swapcache stat which is essential for folks who wants to
> transparently migrate from cgroup v1's memsw to cgroup v2's memory and
> swap counters. In addition charging a page before exposing it to other
> parts of the kernel is a step in the right direction.
> 
> To correctly maintain the per-memcg swapcache stat, this patch has
> adopted to charge the page before adding it to swapcache. One
> challenge in this option is the failure case of add_to_swap_cache() on
> which we need to undo the mem_cgroup_charge(). Specifically undoing
> mem_cgroup_uncharge_swap() is not simple.
> 
> To resolve the issue, this patch introduces transaction like interface
> to charge a page for swapin. The function mem_cgroup_charge_swapin_page()
> initiates the charging of the page and mem_cgroup_finish_swapin_page()
> completes the charging process. So, the kernel starts the charging
> process of the page for swapin with mem_cgroup_charge_swapin_page(),
> adds the page to the swapcache and on success completes the charging
> process with mem_cgroup_finish_swapin_page().
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Hugh Dickins <hughd@google.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
> Changes since v3:
> - Updated the comments on introduced functions (Johannes)
> - Rename the funcations to be more clear (Hugh & Johannes)
> 
> Changes since v2:
> - fixed build for !CONFIG_MEMCG
> - simplified failure path from add_to_swap_cache()
> 
> Changes since v1:
> - Removes __GFP_NOFAIL and introduced transaction interface for charging
>   (suggested by Johannes)
> - Updated the commit message
> 
>  include/linux/memcontrol.h |  13 +++++
>  mm/memcontrol.c            | 117 +++++++++++++++++++++++--------------
>  mm/memory.c                |  14 ++---
>  mm/swap_state.c            |  13 ++---
>  4 files changed, 97 insertions(+), 60 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e6dc793d587d..f522b09f2df7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -596,6 +596,9 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
>  }
>  
>  int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
> +int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
> +				  gfp_t gfp, swp_entry_t entry);
> +void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
>  
>  void mem_cgroup_uncharge(struct page *page);
>  void mem_cgroup_uncharge_list(struct list_head *page_list);
> @@ -1141,6 +1144,16 @@ static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
>  	return 0;
>  }
>  
> +static inline int mem_cgroup_swapin_charge_page(struct page *page,
> +			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
> +{
> +	return 0;
> +}
> +
> +static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
> +{
> +}
> +
>  static inline void mem_cgroup_uncharge(struct page *page)
>  {
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2db2aeac8a9e..21c38c0b6e5a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6690,6 +6690,27 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  			atomic_long_read(&parent->memory.children_low_usage)));
>  }
>  
> +static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> +			       gfp_t gfp)
> +{
> +	unsigned int nr_pages = thp_nr_pages(page);
> +	int ret;
> +
> +	ret = try_charge(memcg, gfp, nr_pages);
> +	if (ret)
> +		goto out;
> +
> +	css_get(&memcg->css);
> +	commit_charge(page, memcg);
> +
> +	local_irq_disable();
> +	mem_cgroup_charge_statistics(memcg, page, nr_pages);
> +	memcg_check_events(memcg, page);
> +	local_irq_enable();
> +out:
> +	return ret;
> +}
> +
>  /**
>   * mem_cgroup_charge - charge a newly allocated page to a cgroup
>   * @page: page to charge
> @@ -6699,55 +6720,71 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>   * Try to charge @page to the memcg that @mm belongs to, reclaiming
>   * pages according to @gfp_mask if necessary.
>   *
> + * Do not use this for pages allocated for swapin.
> + *
>   * Returns 0 on success. Otherwise, an error code is returned.
>   */
>  int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
>  {
> -	unsigned int nr_pages = thp_nr_pages(page);
> -	struct mem_cgroup *memcg = NULL;
> -	int ret = 0;
> +	struct mem_cgroup *memcg;
> +	int ret;
>  
>  	if (mem_cgroup_disabled())
> -		goto out;
> +		return 0;
>  
> -	if (PageSwapCache(page)) {
> -		swp_entry_t ent = { .val = page_private(page), };
> -		unsigned short id;
> +	memcg = get_mem_cgroup_from_mm(mm);
> +	ret = __mem_cgroup_charge(page, memcg, gfp_mask);
> +	css_put(&memcg->css);
>  
> -		/*
> -		 * Every swap fault against a single page tries to charge the
> -		 * page, bail as early as possible.  shmem_unuse() encounters
> -		 * already charged pages, too.  page and memcg binding is
> -		 * protected by the page lock, which serializes swap cache
> -		 * removal, which in turn serializes uncharging.
> -		 */
> -		VM_BUG_ON_PAGE(!PageLocked(page), page);
> -		if (page_memcg(compound_head(page)))
> -			goto out;
> +	return ret;
> +}
>  
> -		id = lookup_swap_cgroup_id(ent);
> -		rcu_read_lock();
> -		memcg = mem_cgroup_from_id(id);
> -		if (memcg && !css_tryget_online(&memcg->css))
> -			memcg = NULL;
> -		rcu_read_unlock();
> -	}
> +/**
> + * mem_cgroup_swapin_charge_page - charge a newly allocated page for swapin
> + * @page: page to charge
> + * @mm: mm context of the victim
> + * @gfp: reclaim mode
> + * @entry: swap entry for which the page is allocated
> + *
> + * This function charges a page allocated for swapin. Please call this before
> + * adding the page to the swapcache.
> + *
> + * Returns 0 on success. Otherwise, an error code is returned.
> + */
> +int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
> +				  gfp_t gfp, swp_entry_t entry)
> +{
> +	struct mem_cgroup *memcg;
> +	unsigned short id;
> +	int ret;
>  
> -	if (!memcg)
> +	if (mem_cgroup_disabled())
> +		return 0;
> +
> +	id = lookup_swap_cgroup_id(entry);
> +	rcu_read_lock();
> +	memcg = mem_cgroup_from_id(id);
> +	if (!memcg || !css_tryget_online(&memcg->css))
>  		memcg = get_mem_cgroup_from_mm(mm);
> +	rcu_read_unlock();
>  
> -	ret = try_charge(memcg, gfp_mask, nr_pages);
> -	if (ret)
> -		goto out_put;
> +	ret = __mem_cgroup_charge(page, memcg, gfp);
>  
> -	css_get(&memcg->css);
> -	commit_charge(page, memcg);
> -
> -	local_irq_disable();
> -	mem_cgroup_charge_statistics(memcg, page, nr_pages);
> -	memcg_check_events(memcg, page);
> -	local_irq_enable();
> +	css_put(&memcg->css);
> +	return ret;
> +}
>  
> +/*
> + * mem_cgroup_swapin_uncharge_swap - uncharge swap slot
> + * @entry: swap entry for which the page is charged
> + *
> + * Call this function after successfully adding the charged page to swapcache.
> + *
> + * Note: This function assumes the page for which swap slot is being uncharged
> + * is order 0 page.
> + */
> +void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
> +{
>  	/*
>  	 * Cgroup1's unified memory+swap counter has been charged with the
>  	 * new swapcache page, finish the transfer by uncharging the swap
> @@ -6760,20 +6797,14 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
>  	 * correspond 1:1 to page and swap slot lifetimes: we charge the
>  	 * page to memory here, and uncharge swap when the slot is freed.
>  	 */
> -	if (do_memsw_account() && PageSwapCache(page)) {
> -		swp_entry_t entry = { .val = page_private(page) };
> +	if (!mem_cgroup_disabled() && do_memsw_account()) {
>  		/*
>  		 * The swap entry might not get freed for a long time,
>  		 * let's not wait for it.  The page already received a
>  		 * memory+swap charge, drop the swap entry duplicate.
>  		 */
> -		mem_cgroup_uncharge_swap(entry, nr_pages);
> +		mem_cgroup_uncharge_swap(entry, 1);
>  	}
> -
> -out_put:
> -	css_put(&memcg->css);
> -out:
> -	return ret;
>  }
>  
>  struct uncharge_gather {
> diff --git a/mm/memory.c b/mm/memory.c
> index c8e357627318..5ddc133d0038 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3307,21 +3307,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
>  							vmf->address);
>  			if (page) {
> -				int err;
> -
>  				__SetPageLocked(page);
>  				__SetPageSwapBacked(page);
> -				set_page_private(page, entry.val);
> -
> -				/* Tell memcg to use swap ownership records */
> -				SetPageSwapCache(page);
> -				err = mem_cgroup_charge(page, vma->vm_mm,
> -							GFP_KERNEL);
> -				ClearPageSwapCache(page);
> -				if (err) {
> +
> +				if (mem_cgroup_swapin_charge_page(page,
> +					vma->vm_mm, GFP_KERNEL, entry)) {
>  					ret = VM_FAULT_OOM;
>  					goto out_page;
>  				}
> +				mem_cgroup_swapin_uncharge_swap(entry);
>  
>  				shadow = get_shadow_from_swap_cache(entry);
>  				if (shadow)
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 3cdee7b11da9..fb7efa08fe57 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -497,16 +497,14 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  	__SetPageLocked(page);
>  	__SetPageSwapBacked(page);
>  
> -	/* May fail (-ENOMEM) if XArray node allocation failed. */
> -	if (add_to_swap_cache(page, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow)) {
> -		put_swap_page(page, entry);
> +	if (mem_cgroup_swapin_charge_page(page, NULL, gfp_mask, entry))
>  		goto fail_unlock;
> -	}
>  
> -	if (mem_cgroup_charge(page, NULL, gfp_mask)) {
> -		delete_from_swap_cache(page);
> +	/* May fail (-ENOMEM) if XArray node allocation failed. */
> +	if (add_to_swap_cache(page, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
>  		goto fail_unlock;
> -	}
> +
> +	mem_cgroup_swapin_uncharge_swap(entry);
>  
>  	if (shadow)
>  		workingset_refault(page, shadow);
> @@ -517,6 +515,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  	return page;
>  
>  fail_unlock:
> +	put_swap_page(page, entry);
>  	unlock_page(page);
>  	put_page(page);
>  	return NULL;
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 
