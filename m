Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D031F30D0FE
	for <lists+cgroups@lfdr.de>; Wed,  3 Feb 2021 02:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhBCBs3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 20:48:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229970AbhBCBs0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 20:48:26 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1131U4jm009397;
        Tue, 2 Feb 2021 17:47:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=/P4Zul9bmhfURgk7SYQDbnsToUPodTyCSCmw70UFRxQ=;
 b=nZKL4Z1QGq+t/18jzif4IFB/VTgsSMDlvrk4tymOadE0ubckptZmnrRlQ/m6VmyKcNv8
 LUT8LYj25IclUZuljr0HNYiBjZVDZdiNEI0c8kWKrbuHiFh5CBjNc3ec2uG/EUi3Hflm
 xMezd8R2XxEFZZ98sKQ15OppNICiWaMIF1I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36dw576bap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Feb 2021 17:47:35 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Feb 2021 17:47:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6geu5diVMPvZXzBzU5nERgjmduLNotr8U0VC8aCv/poKFBGzteBUI5npDTTswqP+KqWMrMPCXQ81THb/NC6ByvSufuCLMLezghTqUxUKoYH6AtEoxFzsdCho8Qz1i5c+/lvjnLKoXgHwgr36O4L24PdDquBv2TROqS+Rz/VfNXdapYlv1FRUin5WGDII88rd66KRJjuGFc2wJimoyMU5rXqRxUm/WVzs4TD5qwKFD1mL+6uKP2t95TFA/UPz00yHJ44M786qZpNCJI6o4mbYY+vZNm/2tHD9VM5JaNU7oRXG3a4mnMlkeH037TqLXwbNbzPP3kSWu8b3zehdEXvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P4Zul9bmhfURgk7SYQDbnsToUPodTyCSCmw70UFRxQ=;
 b=EAKhZJUQEwvyk+dPxEvmBleoI3yVUQPgNrrp9B1W2/SD9A++MYJi9XuoFR0kxJKEtp62M8U0RuQ/7WfCEJ9OSs6iI7rzqYKBj2wFbxdJQA47SDIgmCofGk4CBhEPyyJyOE1j2asc+G8BI8vyyX/dXFXAQG4Y6lEE2APB1nfA9qp5t8l6hcNkXsFS28SRacDsRN6ZEdtuVemsHuKfVTHZWHw5H4nTntc/cMQjwI2N4ULMOx39NQWcycEuBFhDGkz3ALHDZIHTe9wRdTdLuLGeGuL0Eu/9Smxvio1bxHvYMt4YFplG8m7VFkkT04OOclRKn1XpweS+GqPIoYorv1Qh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P4Zul9bmhfURgk7SYQDbnsToUPodTyCSCmw70UFRxQ=;
 b=Ty73sKvqpbnyJfSDMl9f1afKpIHmeR2O1TGPE+L7QYxJfBajM54dcfuwAlmpuUahIkw1Y0bIOq8UI8J3+IY/5oIo/GJV+a5L55E5TKZWbKY8iqmibuK1tR0G49mrhGlBmnl2rVuGWWyI/sWP5G3BjperMU91RST3I18dSDHThUE=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3522.namprd15.prod.outlook.com (2603:10b6:a03:1b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 01:47:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 01:47:31 +0000
Date:   Tue, 2 Feb 2021 17:47:26 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 6/7] mm: memcontrol: switch to rstat
Message-ID: <20210203014726.GE1812008@carbon.dhcp.thefacebook.com>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-7-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202184746.119084-7-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:a08f]
X-ClientProxiedBy: MW4PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:303:dd::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a08f) by MW4PR03CA0330.namprd03.prod.outlook.com (2603:10b6:303:dd::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Wed, 3 Feb 2021 01:47:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ba48cc3-e687-4cb6-f965-08d8c7e5ab3a
X-MS-TrafficTypeDiagnostic: BY5PR15MB3522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3522C2BF862AD64B411A7715BEB49@BY5PR15MB3522.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKYemLGWra/JYuylYAEYze5nHOfakjAP5r1Jxcu5XF7lHA3cmmU/ERw3kDBPGOtyDjwd2DEnLbjflOK0jQ/02td+5lvlYRx9KDGUGzLeYStKAYPRJXtp1GhDjXTKlo1H37gH2BzDOvR+nmLvBCKY+H+1wjHu33DcufF9AYRVHE/QovtFhwuNVIj0IruLWDunpMp4M0fB9ouSb4wzjlIQyApDuhvuz4E6gOhySre8wG1DnUbUO/oEL3PhPL3U24iI0/IzHWdz4SYtZKOiGY2VTaKGQykzNkERpGq2py2UJTUgRl73+rVCW0isnYna9IyvvYGZWo3J89qDeqacV1TUyJEiqjwYzos2K+xcAxfkUv0MBqAUIlLfVyqCvhfYp55isuZIhLb8t/+zn0mVB1nYtLV1tAqNlHqs9K5PyaBAJHESHNpG1e1ydKVQ9Lc5BGciBg58oXCowuyngc1AelEBiEgWoWhbfi26tlZraRHP6kF28Mi+qt2bXNX2rSkvJMdHFejIPW/pyFjy16+QHDolYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(186003)(5660300002)(1076003)(16526019)(6506007)(83380400001)(6666004)(8936002)(86362001)(54906003)(33656002)(66946007)(8676002)(2906002)(55016002)(66556008)(478600001)(66476007)(30864003)(7696005)(4326008)(52116002)(9686003)(316002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xAhuoe9fGkBjRRmYwMEDnORENAeOyl+3T3+4MGg/EydUTGUtTWWPrFxpEcNi?=
 =?us-ascii?Q?euyYWo32fh+HSxboHnrda2Z1ucvDZpZHjAT8dhUEPSV/CNcSltEQeuFcFJNf?=
 =?us-ascii?Q?bLL5IoC0QotnSzwrmvm3Ch5C6jLWTi6N+kgy0gUUxFbtG+gMe/1ciKFfVJfn?=
 =?us-ascii?Q?YtcXJC72nG9s/RCvBZCZUis64ScDDwy+ysYHbDB8NDvQrea0mg/S/ECwV3Kz?=
 =?us-ascii?Q?MwzlTe24lohKJd0Jf5GFzasa+JmCdBu+75/IcZWFgl1weebTbL6GI1o3Ms0Y?=
 =?us-ascii?Q?vV9Ya28G4X24IWDSgURrC+o2gaQXO2f8DnpobYmJBggT6PZvgvDGGkSWtO1/?=
 =?us-ascii?Q?lqsKIDhbAffEIKdnis+PaLqIyS2ryuwd32c3WOiHgsJ+QbArB59qKw7pFmPP?=
 =?us-ascii?Q?OyLFZaHRwMYFz15sIG7qpbbdHsVabJLGb7tdllAwrVWzrf72e+fbIszDyGoR?=
 =?us-ascii?Q?kRS3YWfIKhjFukGQ297xrntkskmj/5GK563M0jp5T/PnRwLcAf2qcYzRv8ke?=
 =?us-ascii?Q?S2grFbrqt98fYi3L4QxRjZNTeutCCHT6Xyp0J9CbOcVN1g7doMqeXKQuzrfY?=
 =?us-ascii?Q?UUhoqII8p45wHSpEnym8Zze628M9UNW2kOkiHm4FI1hM7xn72Pki0JhjMGHT?=
 =?us-ascii?Q?70heEGVoOkcR+ZCvHa7IvYmFY53vkXJz7UVQnx7ndmm4zimI8Slo/T+b3YEI?=
 =?us-ascii?Q?hcP/nS41bkrcfCw1t+0jhsbxALwiafjvWUUbVDqyUHlDHDjmaSp1/3sXoBwU?=
 =?us-ascii?Q?+9N5F5AVCouRD3FzU0fNEniwRwCLkPpVa8UXGrz+sC6qW2S5oaDP53w0zabs?=
 =?us-ascii?Q?qUC9eR5Dky4h6A9Hn9NFNtGy6HIV37dNrQCbVxc7NbF7A04yLU7fsBgRgeGB?=
 =?us-ascii?Q?Elc+TS+d+s0bxWhNlT+WsRMlVAs4Y/uofzlpJYry+s0aNj+PrcGCOW21neGu?=
 =?us-ascii?Q?jF/Jg2myoJChTDK8x2WmifPlwW7yxpjIbhB/c1M3YPJo/dyh1sbsBBxjQuAr?=
 =?us-ascii?Q?odv7EWuk7p/iKr1v/8550GzKyrxJZejENMDQvYs/uRN30M29t+EwsdxOh9Of?=
 =?us-ascii?Q?N4YUlJoJPHRLZVbR+91t6Hihn65rn+0tOzJkjBUtXvwiNRS5skA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba48cc3-e687-4cb6-f965-08d8c7e5ab3a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 01:47:31.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ins9UUw5pEbtpI2BnMak/yI1TWd1YPbR9G9fxj8ceVuwawhzEnPSBryDbIu77dl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3522
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_13:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 02, 2021 at 01:47:45PM -0500, Johannes Weiner wrote:
> Replace the memory controller's custom hierarchical stats code with
> the generic rstat infrastructure provided by the cgroup core.
> 
> The current implementation does batched upward propagation from the
> write side (i.e. as stats change). The per-cpu batches introduce an
> error, which is multiplied by the number of subgroups in a tree. In
> systems with many CPUs and sizable cgroup trees, the error can be
> large enough to confuse users (e.g. 32 batch pages * 32 CPUs * 32
> subgroups results in an error of up to 128M per stat item). This can
> entirely swallow allocation bursts inside a workload that the user is
> expecting to see reflected in the statistics.
> 
> In the past, we've done read-side aggregation, where a memory.stat
> read would have to walk the entire subtree and add up per-cpu
> counts. This became problematic with lazily-freed cgroups: we could
> have large subtrees where most cgroups were entirely idle. Hence the
> switch to change-driven upward propagation. Unfortunately, it needed
> to trade accuracy for speed due to the write side being so hot.
> 
> Rstat combines the best of both worlds: from the write side, it
> cheaply maintains a queue of cgroups that have pending changes, so
> that the read side can do selective tree aggregation. This way the
> reported stats will always be precise and recent as can be, while the
> aggregation can skip over potentially large numbers of idle cgroups.
> 
> This adds a second vmstats to struct mem_cgroup (MEMCG_NR_STAT +
> NR_VM_EVENT_ITEMS) to track pending subtree deltas during upward
> aggregation. It removes 3 words from the per-cpu data. It eliminates
> memcg_exact_page_state(), since memcg_page_state() is now exact.

Nice!

> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/memcontrol.h |  67 ++++++-----
>  mm/memcontrol.c            | 224 +++++++++++++++----------------------
>  2 files changed, 133 insertions(+), 158 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 20ecdfae3289..a8c7a0ccc759 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -76,10 +76,27 @@ enum mem_cgroup_events_target {
>  };
>  
>  struct memcg_vmstats_percpu {
> -	long stat[MEMCG_NR_STAT];
> -	unsigned long events[NR_VM_EVENT_ITEMS];
> -	unsigned long nr_page_events;
> -	unsigned long targets[MEM_CGROUP_NTARGETS];
> +	/* Local (CPU and cgroup) page state & events */
> +	long			state[MEMCG_NR_STAT];
> +	unsigned long		events[NR_VM_EVENT_ITEMS];
> +
> +	/* Delta calculation for lockless upward propagation */
> +	long			state_prev[MEMCG_NR_STAT];
> +	unsigned long		events_prev[NR_VM_EVENT_ITEMS];
> +
> +	/* Cgroup1: threshold notifications & softlimit tree updates */
> +	unsigned long		nr_page_events;
> +	unsigned long		targets[MEM_CGROUP_NTARGETS];
> +};
> +
> +struct memcg_vmstats {
> +	/* Aggregated (CPU and subtree) page state & events */
> +	long			state[MEMCG_NR_STAT];
> +	unsigned long		events[NR_VM_EVENT_ITEMS];
> +
> +	/* Pending child counts during tree propagation */
> +	long			state_pending[MEMCG_NR_STAT];
> +	unsigned long		events_pending[NR_VM_EVENT_ITEMS];
>  };
>  
>  struct mem_cgroup_reclaim_iter {
> @@ -287,8 +304,8 @@ struct mem_cgroup {
>  
>  	MEMCG_PADDING(_pad1_);
>  
> -	atomic_long_t		vmstats[MEMCG_NR_STAT];
> -	atomic_long_t		vmevents[NR_VM_EVENT_ITEMS];
> +	/* memory.stat */
> +	struct memcg_vmstats	vmstats;
>  
>  	/* memory.events */
>  	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
> @@ -315,10 +332,6 @@ struct mem_cgroup {
>  	atomic_t		moving_account;
>  	struct task_struct	*move_lock_task;
>  
> -	/* Legacy local VM stats and events */
> -	struct memcg_vmstats_percpu __percpu *vmstats_local;
> -
> -	/* Subtree VM stats and events (batched updates) */
>  	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> @@ -942,10 +955,6 @@ static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
>  	local_irq_restore(flags);
>  }
>  
> -unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> -						gfp_t gfp_mask,
> -						unsigned long *total_scanned);
> -
>  void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
>  			  unsigned long count);
>  
> @@ -1028,6 +1037,10 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  void mem_cgroup_split_huge_fixup(struct page *head);
>  #endif
>  
> +unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> +						gfp_t gfp_mask,
> +						unsigned long *total_scanned);
> +
>  #else /* CONFIG_MEMCG */
>  
>  #define MEM_CGROUP_ID_SHIFT	0
> @@ -1136,6 +1149,10 @@ static inline bool lruvec_holds_page_lru_lock(struct page *page,
>  	return lruvec == &pgdat->__lruvec;
>  }
>  
> +static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
> +{
> +}
> +
>  static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
>  {
>  	return NULL;
> @@ -1349,18 +1366,6 @@ static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
>  	mod_node_page_state(page_pgdat(page), idx, val);
>  }
>  
> -static inline
> -unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> -					    gfp_t gfp_mask,
> -					    unsigned long *total_scanned)
> -{
> -	return 0;
> -}
> -
> -static inline void mem_cgroup_split_huge_fixup(struct page *head)
> -{
> -}
> -
>  static inline void count_memcg_events(struct mem_cgroup *memcg,
>  				      enum vm_event_item idx,
>  				      unsigned long count)
> @@ -1383,8 +1388,16 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
>  {
>  }
>  
> -static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
> +static inline void mem_cgroup_split_huge_fixup(struct page *head)
> +{
> +}
> +
> +static inline
> +unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> +					    gfp_t gfp_mask,
> +					    unsigned long *total_scanned)
>  {
> +	return 0;
>  }
>  #endif /* CONFIG_MEMCG */
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2f97cb4cef6d..b205b2413186 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -757,6 +757,11 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>  	return mz;
>  }
>  
> +static void memcg_flush_vmstats(struct mem_cgroup *memcg)
> +{
> +	cgroup_rstat_flush(memcg->css.cgroup);
> +}
> +
>  /**
>   * __mod_memcg_state - update cgroup memory statistics
>   * @memcg: the memory cgroup
> @@ -765,37 +770,17 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>   */
>  void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
>  {
> -	long x, threshold = MEMCG_CHARGE_BATCH;
> -
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	if (memcg_stat_item_in_bytes(idx))
> -		threshold <<= PAGE_SHIFT;
> -
> -	x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
> -	if (unlikely(abs(x) > threshold)) {
> -		struct mem_cgroup *mi;
> -
> -		/*
> -		 * Batch local counters to keep them in sync with
> -		 * the hierarchical ones.
> -		 */
> -		__this_cpu_add(memcg->vmstats_local->stat[idx], x);
> -		for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
> -			atomic_long_add(x, &mi->vmstats[idx]);
> -		x = 0;
> -	}
> -	__this_cpu_write(memcg->vmstats_percpu->stat[idx], x);
> +	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
> +	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
>  }
>  
> -/*
> - * idx can be of type enum memcg_stat_item or node_stat_item.
> - * Keep in sync with memcg_exact_page_state().
> - */
> +/* idx can be of type enum memcg_stat_item or node_stat_item. */
>  static unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>  {
> -	long x = atomic_long_read(&memcg->vmstats[idx]);
> +	long x = READ_ONCE(memcg->vmstats.state[idx]);
>  #ifdef CONFIG_SMP
>  	if (x < 0)
>  		x = 0;
> @@ -803,17 +788,14 @@ static unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>  	return x;
>  }
>  
> -/*
> - * idx can be of type enum memcg_stat_item or node_stat_item.
> - * Keep in sync with memcg_exact_page_state().
> - */
> +/* idx can be of type enum memcg_stat_item or node_stat_item. */
>  static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
>  {
>  	long x = 0;
>  	int cpu;
>  
>  	for_each_possible_cpu(cpu)
> -		x += per_cpu(memcg->vmstats_local->stat[idx], cpu);
> +		x += per_cpu(memcg->vmstats_percpu->state[idx], cpu);
>  #ifdef CONFIG_SMP
>  	if (x < 0)
>  		x = 0;
> @@ -936,30 +918,16 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
>  void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
>  			  unsigned long count)
>  {
> -	unsigned long x;
> -
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	x = count + __this_cpu_read(memcg->vmstats_percpu->events[idx]);
> -	if (unlikely(x > MEMCG_CHARGE_BATCH)) {
> -		struct mem_cgroup *mi;
> -
> -		/*
> -		 * Batch local counters to keep them in sync with
> -		 * the hierarchical ones.
> -		 */
> -		__this_cpu_add(memcg->vmstats_local->events[idx], x);
> -		for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
> -			atomic_long_add(x, &mi->vmevents[idx]);
> -		x = 0;
> -	}
> -	__this_cpu_write(memcg->vmstats_percpu->events[idx], x);
> +	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
> +	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
>  }
>  
>  static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
>  {
> -	return atomic_long_read(&memcg->vmevents[event]);
> +	return READ_ONCE(memcg->vmstats.events[event]);
>  }
>  
>  static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
> @@ -968,7 +936,7 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
>  	int cpu;
>  
>  	for_each_possible_cpu(cpu)
> -		x += per_cpu(memcg->vmstats_local->events[event], cpu);
> +		x += per_cpu(memcg->vmstats_percpu->events[event], cpu);
>  	return x;
>  }
>  
> @@ -1631,6 +1599,7 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  	 *
>  	 * Current memory state:
>  	 */
> +	memcg_flush_vmstats(memcg);
>  
>  	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
>  		u64 size;
> @@ -2450,22 +2419,11 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  	drain_stock(stock);
>  
>  	for_each_mem_cgroup(memcg) {
> -		struct memcg_vmstats_percpu *statc;
>  		int i;
>  
> -		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
> -
> -		for (i = 0; i < MEMCG_NR_STAT; i++) {
> +		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
>  			int nid;
>  
> -			if (statc->stat[i]) {
> -				mod_memcg_state(memcg, i, statc->stat[i]);
> -				statc->stat[i] = 0;
> -			}
> -
> -			if (i >= NR_VM_NODE_STAT_ITEMS)
> -				continue;
> -
>  			for_each_node(nid) {
>  				struct batched_lruvec_stat *lstatc;
>  				struct mem_cgroup_per_node *pn;
> @@ -2484,13 +2442,6 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  				}
>  			}
>  		}
> -
> -		for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
> -			if (statc->events[i]) {
> -				count_memcg_events(memcg, i, statc->events[i]);
> -				statc->events[i] = 0;
> -			}
> -		}
>  	}
>  
>  	return 0;
> @@ -3618,6 +3569,8 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>  {
>  	unsigned long val;
>  
> +	memcg_flush_vmstats(memcg);
> +
>  	if (mem_cgroup_is_root(memcg)) {
>  		val = memcg_page_state(memcg, NR_FILE_PAGES) +
>  			memcg_page_state(memcg, NR_ANON_MAPPED);
> @@ -3683,26 +3636,15 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>  	}
>  }
>  
> -static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
> +static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg)
>  {
> -	unsigned long stat[MEMCG_NR_STAT] = {0};
> -	struct mem_cgroup *mi;
> -	int node, cpu, i;
> -
> -	for_each_online_cpu(cpu)
> -		for (i = 0; i < MEMCG_NR_STAT; i++)
> -			stat[i] += per_cpu(memcg->vmstats_percpu->stat[i], cpu);
> -
> -	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
> -		for (i = 0; i < MEMCG_NR_STAT; i++)
> -			atomic_long_add(stat[i], &mi->vmstats[i]);
> +	int node;
>  
>  	for_each_node(node) {
>  		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> +		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = {0, };
                                                              ^^
I'd drop the comma here. It seems that "{0}" version is way more popular
over the mm code and in the kernel in general.

>  		struct mem_cgroup_per_node *pi;
> -
> -		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> -			stat[i] = 0;
> +		int cpu, i;
>  
>  		for_each_online_cpu(cpu)
>  			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> @@ -3715,25 +3657,6 @@ static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
>  	}
>  }
>  
> -static void memcg_flush_percpu_vmevents(struct mem_cgroup *memcg)
> -{
> -	unsigned long events[NR_VM_EVENT_ITEMS];
> -	struct mem_cgroup *mi;
> -	int cpu, i;
> -
> -	for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
> -		events[i] = 0;
> -
> -	for_each_online_cpu(cpu)
> -		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
> -			events[i] += per_cpu(memcg->vmstats_percpu->events[i],
> -					     cpu);
> -
> -	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
> -		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
> -			atomic_long_add(events[i], &mi->vmevents[i]);
> -}
> -
>  #ifdef CONFIG_MEMCG_KMEM
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>  {
> @@ -4050,6 +3973,8 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
>  	int nid;
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
>  
> +	memcg_flush_vmstats(memcg);
> +
>  	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
>  		seq_printf(m, "%s=%lu", stat->name,
>  			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
> @@ -4120,6 +4045,8 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  
>  	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
>  
> +	memcg_flush_vmstats(memcg);
> +
>  	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
>  		unsigned long nr;
>  
> @@ -4596,22 +4523,6 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
>  	return &memcg->cgwb_domain;
>  }
>  
> -/*
> - * idx can be of type enum memcg_stat_item or node_stat_item.
> - * Keep in sync with memcg_exact_page().
> - */
> -static unsigned long memcg_exact_page_state(struct mem_cgroup *memcg, int idx)
> -{
> -	long x = atomic_long_read(&memcg->vmstats[idx]);
> -	int cpu;
> -
> -	for_each_online_cpu(cpu)
> -		x += per_cpu_ptr(memcg->vmstats_percpu, cpu)->stat[idx];
> -	if (x < 0)
> -		x = 0;
> -	return x;
> -}
> -
>  /**
>   * mem_cgroup_wb_stats - retrieve writeback related stats from its memcg
>   * @wb: bdi_writeback in question
> @@ -4637,13 +4548,14 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
>  	struct mem_cgroup *parent;
>  
> -	*pdirty = memcg_exact_page_state(memcg, NR_FILE_DIRTY);
> +	memcg_flush_vmstats(memcg);
>  
> -	*pwriteback = memcg_exact_page_state(memcg, NR_WRITEBACK);
> -	*pfilepages = memcg_exact_page_state(memcg, NR_INACTIVE_FILE) +
> -			memcg_exact_page_state(memcg, NR_ACTIVE_FILE);
> -	*pheadroom = PAGE_COUNTER_MAX;
> +	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
> +	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
> +	*pfilepages = memcg_page_state(memcg, NR_INACTIVE_FILE) +
> +			memcg_page_state(memcg, NR_ACTIVE_FILE);
>  
> +	*pheadroom = PAGE_COUNTER_MAX;
>  	while ((parent = parent_mem_cgroup(memcg))) {
>  		unsigned long ceiling = min(READ_ONCE(memcg->memory.max),
>  					    READ_ONCE(memcg->memory.high));
> @@ -5275,7 +5187,6 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
>  	for_each_node(node)
>  		free_mem_cgroup_per_node_info(memcg, node);
>  	free_percpu(memcg->vmstats_percpu);
> -	free_percpu(memcg->vmstats_local);
>  	kfree(memcg);
>  }
>  
> @@ -5283,11 +5194,10 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
>  {
>  	memcg_wb_domain_exit(memcg);
>  	/*
> -	 * Flush percpu vmstats and vmevents to guarantee the value correctness
> -	 * on parent's and all ancestor levels.
> +	 * Flush percpu lruvec stats to guarantee the value
> +	 * correctness on parent's and all ancestor levels.
>  	 */
> -	memcg_flush_percpu_vmstats(memcg);
> -	memcg_flush_percpu_vmevents(memcg);
> +	memcg_flush_lruvec_page_state(memcg);
>  	__mem_cgroup_free(memcg);
>  }
>  
> @@ -5314,11 +5224,6 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>  		goto fail;
>  	}
>  
> -	memcg->vmstats_local = alloc_percpu_gfp(struct memcg_vmstats_percpu,
> -						GFP_KERNEL_ACCOUNT);
> -	if (!memcg->vmstats_local)
> -		goto fail;
> -
>  	memcg->vmstats_percpu = alloc_percpu_gfp(struct memcg_vmstats_percpu,
>  						 GFP_KERNEL_ACCOUNT);
>  	if (!memcg->vmstats_percpu)
> @@ -5518,6 +5423,62 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
>  	memcg_wb_domain_size_changed(memcg);
>  }
>  
> +static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
> +	struct memcg_vmstats_percpu *statc;
> +	long delta, v;
> +	int i;
> +
> +	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
> +
> +	for (i = 0; i < MEMCG_NR_STAT; i++) {
> +		/*
> +		 * Collect the aggregated propagation counts of groups
> +		 * below us. We're in a per-cpu loop here and this is
> +		 * a global counter, so the first cycle will get them.
> +		 */
> +		delta = memcg->vmstats.state_pending[i];
> +		if (delta)
> +			memcg->vmstats.state_pending[i] = 0;
> +
> +		/* Add CPU changes on this level since the last flush */
> +		v = READ_ONCE(statc->state[i]);
> +		if (v != statc->state_prev[i]) {
> +			delta += v - statc->state_prev[i];
> +			statc->state_prev[i] = v;
> +		}
> +
> +		if (!delta)
> +			continue;
> +
> +		/* Aggregate counts on this level and propagate upwards */
> +		memcg->vmstats.state[i] += delta;
> +		if (parent)
> +			parent->vmstats.state_pending[i] += delta;
> +	}
> +
> +	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
> +		delta = memcg->vmstats.events_pending[i];
> +		if (delta)
> +			memcg->vmstats.events_pending[i] = 0;
> +
> +		v = READ_ONCE(statc->events[i]);
> +		if (v != statc->events_prev[i]) {
> +			delta += v - statc->events_prev[i];
> +			statc->events_prev[i] = v;
> +		}
> +
> +		if (!delta)
> +			continue;
> +
> +		memcg->vmstats.events[i] += delta;
> +		if (parent)
> +			parent->vmstats.events_pending[i] += delta;
> +	}
> +}
> +
>  #ifdef CONFIG_MMU
>  /* Handlers for move charge at task migration. */
>  static int mem_cgroup_do_precharge(unsigned long count)
> @@ -6571,6 +6532,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
>  	.css_released = mem_cgroup_css_released,
>  	.css_free = mem_cgroup_css_free,
>  	.css_reset = mem_cgroup_css_reset,
> +	.css_rstat_flush = mem_cgroup_css_rstat_flush,
>  	.can_attach = mem_cgroup_can_attach,
>  	.cancel_attach = mem_cgroup_cancel_attach,
>  	.post_attach = mem_cgroup_move_task,
> -- 
> 2.30.0
> 

With a tiny nit above
Reviewed-by: Roman Gushchin <guro@fb.com> .

Thanks!
