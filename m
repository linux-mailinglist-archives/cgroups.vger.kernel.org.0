Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6654D35D03E
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 20:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhDLSYd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 14:24:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7232 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229666AbhDLSYb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 14:24:31 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13CIDYKs003989;
        Mon, 12 Apr 2021 11:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=z0C2fVCoh5GAkWzMVNfetvtwqQoyVEtZ1ZOo5uVKilY=;
 b=Kf47sJln+376K4t0+Oo8rERDz1DZD5CSOEbz+4du5ctnRzUYcTtZ0ZR94RfDCRVmXU8+
 uJCMImrV8SYlh8WCd7U/UMC+yTOnmmaOo363pdqrcpFG1QRfVjb8LjeM9mkrv+ihc8Zp
 3bb85rOwZN98dIywKn2z108NEvHqebC90Zc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 37vkb2tqnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 11:22:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 11:22:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4CB0WI08hUkrFKdwtqcBz3fLt23yQcuevvyNvvikmGQ6FpYk+ojp48UZLg6OR2yNGDoRX5FK7UuhzQvf5p6nH8aEyTBbjlj+r8qTSFL/J4FtFN756C5S9AzYfsZ2oStlIS8z0rEjOQ9KrSqpHuroDM5MY3cVQN0+fWd075dnZLwDhobj3ZbhdK7G5PANjFEoi4L5g2RZDygSycOFEXFb8N8++mj8fimZ1aNJHpVamvJwww1/RlnXE4qfYumGzOU12K3fS5wy2MuJstzZ3UIYxi7WAzeBP3zuEuE2FVeu/s2BYDvNjkLlg4VnjjdCs1XKotqszPJfLgzvbO1Ff31QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0C2fVCoh5GAkWzMVNfetvtwqQoyVEtZ1ZOo5uVKilY=;
 b=XRGs1xdwXPJ9Jd4G3UAQFwiFXen04jXepdfyI5nxaLH77jshq/IMHzfPLNYFFdTSghyiWz8C1LneG2PxWLcz+go7J2pzX0WtkYO0u/MkCRz8W6xbDnz4d7ErVzTDVrkA4YFBApj18OedysL3csQYFWfWajCxgcPBWuEYzTEX4z6/XhhLmAJ5A9e5cEa5LLjXvwlklWMCxC1suUAEyrY8SCWOxVSQcuenR1RkaOheaglVZYaTEfJGf7REKPilhWFxLgzF+vXBS433vQw/QMt/vEDAg6KTzh75RBhLtaIN7UnENizCm+A4L7o+UgISvVHclmEgdx3YwwnKadGx+ZGDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3032.namprd15.prod.outlook.com (2603:10b6:a03:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 18:22:54 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:22:54 +0000
Date:   Mon, 12 Apr 2021 11:22:49 -0700
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
Subject: Re: [PATCH 3/5] mm/memcg: Cache vmstat data in percpu memcg_stock_pcp
Message-ID: <YHSP+U/I52zx/JWZ@carbon.dhcp.thefacebook.com>
References: <20210409231842.8840-1-longman@redhat.com>
 <20210409231842.8840-4-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210409231842.8840-4-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:ea4e]
X-ClientProxiedBy: MWHPR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:301:1::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ea4e) by MWHPR11CA0019.namprd11.prod.outlook.com (2603:10b6:301:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 18:22:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3bb61c6-06dc-454a-85a7-08d8fddffd88
X-MS-TrafficTypeDiagnostic: BYAPR15MB3032:
X-Microsoft-Antispam-PRVS: <BYAPR15MB30322D45A88AC483E0CEF18CBE709@BYAPR15MB3032.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uE2QFW6tSOuAy8XV9Mjo0Ai4TRpmHWaN186oe4vRHFzCmGjiEXdYKCYBWKt/exsIs8zvkNrSL2QChi5cNYEgjokUOOle4lvLoAT4U9Glk9QUnrkELIDPbkJB1PecMPUL/3nx/CT8QnmPjCZTdgnHzho/qMBbeaDpgZ0d4JGhG/PGDU5MHism4exipBiOkSPrvo4GZL4mByHF/zeDN0KvSyYAqjaXg5YKziDWu1rk+LNg5qPvIvfFrhEuJHt9BRqbNqk63uUHzE6XiFSYO1aUzZ9aF4mVv/1S4JsPYgJu8BfNy7PovP5utd++sCW+AXOsqQqDcu7Gj5YbGWfQeW3DfSq9hrt2u45c+nm9yNGxKk/OD0uzj4tuO+jq7RvZCLEkXW3KKOMftEV14MByFsJCBvjkSpjwRme4cgm/N75Ox7YKibRvbn3xCfCrE+vM9cBJUzJOPpKuT+PU0UDGrB2YxfS75DalMGhy6YYRb58urVix4YPPphoA1c8VTXkw4/5gXIcmkuHB1WcOnDvHZa9bp2YUD9wq1HXZ2HjPVUxqqHHrCarR2IKQHf9RtBuy9LM+J+n+MzjPdcaufcLr4Y68/kS02avFGIMDABZElntVSjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(346002)(39860400002)(7416002)(7696005)(5660300002)(6916009)(52116002)(4326008)(66946007)(38100700002)(9686003)(6506007)(2906002)(316002)(86362001)(83380400001)(8936002)(16526019)(186003)(66556008)(66476007)(6666004)(54906003)(478600001)(55016002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?518NSBH1kx//3c+S0qz+aXSTuRHjw3Cb/qZAqX+GAuk4RWm98bHFuuD+UtA7?=
 =?us-ascii?Q?B55BHlrrpFMt9xMSFKgUQB8/e22uPRJnOzpyYITgImHLvGR5sHqwdWmqUdGJ?=
 =?us-ascii?Q?YY2oY/2HsYXk5c1Qf4le8Uk1a7H08MI/T+L1Mw9JNoRhhsq0/J2pehjUSQY4?=
 =?us-ascii?Q?9FQKExG1/ExW+2JdHUNzV6qgegGENc2gMytrmznCgzIfWyxKBc4CHak+sa/M?=
 =?us-ascii?Q?vZXYLt8fZ0yHpPMx7DxvsZJyTR7T0YJfTXjjcz28ZW2Mezhz74mfPBNcP80r?=
 =?us-ascii?Q?HWTefQNBB9K2XcoiUrcjkUk+ujr11vAwdLGpMmzESmYEoe1noSwytvNqwG0h?=
 =?us-ascii?Q?GwfRbq9jAl9ghZ/TwBuqZz5GPJUk4I4YLbYZbFwDg4SHaw19Kx8qbk6XwK5k?=
 =?us-ascii?Q?OxLMShadprm/Ptfm/mL7eYq+0Q0OAbnEzJGG5u8yix3I0wGW4LddzKtzMGMx?=
 =?us-ascii?Q?iPlzEi0FlErGXqr/lh4gezTz37YiaBnCfhz6ALzfzskFs8dirvUI8WOFlH1e?=
 =?us-ascii?Q?f8aJlicaoyZVgvl+1/HHhyLAAArkJUKQZGxWzxK/p+WGL9DE4J+3Cued/kyn?=
 =?us-ascii?Q?0yJZlf1XW4MwkWHCtO7XgQK6Jg3zHXAaGzg585uRHVCqQV0z/kfnpqg187D5?=
 =?us-ascii?Q?IK4NTmqIo9w4EGYH54lZH1AolJ4hVj2+p/fV7Fi5VWAjvJNt0AmRdT4yj8EW?=
 =?us-ascii?Q?lLsQ4BSSS9bWqJd11KbckmKFYA/tlGq8pknLkydhZv9bnUbapmfnXyE0hvOX?=
 =?us-ascii?Q?TKjxwC0h6tvcVbF6ztroiiv9Lk1JUV8hxfOTOSdB+o8mgyUErvL5n+LprOKX?=
 =?us-ascii?Q?zgMsuJ2AKbL1KnLBTMffqkrxa6HyVjB2MjvL55pGcHBWQy+jJxpbPMPt5NGF?=
 =?us-ascii?Q?+kaB4WfPdrBWW6XfY+asXPtVHErm91L5CYJTNV3XiPPS7WbJ/Yg/EXAF9i1S?=
 =?us-ascii?Q?X1skz7t/8HuvSg363jnUVujxX+ggqbnHgWOtHAd9ql15KeZNSUbOcFOZugUm?=
 =?us-ascii?Q?M23rL7EUEE/HK+AmKlaNGc7kF4Lazj2oc5KStkfp2DbBcaoEl7VMQhIIoV0C?=
 =?us-ascii?Q?LNG5591D0My6ZtTPvtGa0T8VUNvmDpd/imNVbK4JCaI8ZtcPsf0hrRl6ZmcL?=
 =?us-ascii?Q?NhJpe3ZMEC7C5eRaobJHVDlszhw4rGVitzW7E5GjdDuErYdnGkUJY9Jq4Ipp?=
 =?us-ascii?Q?qXKvhI9yAYcxDCSPS6zPYx2Z4NqxPqI7TIi5YbrVF3wm+TUY/2lTp5PNEKyw?=
 =?us-ascii?Q?TG2oYbKG9xnwpqQzDUKsNvz0vxqGNtes5IA5hr1EoFKxrYD3FrAldiXBZgmv?=
 =?us-ascii?Q?QShjJpccu5m3A6s3jtUFcvaG1wk9kza5KYZ5X/UdlD0X5xusbbLpvV0QolQ+?=
 =?us-ascii?Q?mrlIGn4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bb61c6-06dc-454a-85a7-08d8fddffd88
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:22:54.8061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U86D+ZiTTjZKJYCCr0lXIWCN8I9LZRlkxka4/76/Sh7xJnUzC6vXfR1wqvmJvCyd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3032
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 1X0M1MPAQMfArQR8ckiyF8NgUB-lT7Xk
X-Proofpoint-GUID: 1X0M1MPAQMfArQR8ckiyF8NgUB-lT7Xk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 09, 2021 at 07:18:40PM -0400, Waiman Long wrote:
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
> data change.

The idea makes total sense to me and also gives a hope to remove
byte-sized vmstats in the long-term.

> 
> On a 2-socket Cascade Lake server with instrumentation enabled and this
> patch applied, it was found that about 17% (946796 out of 5515184) of the
> time when __mod_obj_stock_state() is called leads to an actual call to
> mod_objcg_state() after initial boot. When doing parallel kernel build,
> the figure was about 16% (21894614 out of 139780628). So caching the
> vmstat data reduces the number of calls to mod_objcg_state() by more
> than 80%.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 78 +++++++++++++++++++++++++++++++++++++++++++------
>  mm/slab.h       | 26 +++++++----------
>  2 files changed, 79 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b19100c68aa0..539c3b632e47 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2220,7 +2220,10 @@ struct memcg_stock_pcp {
>  
>  #ifdef CONFIG_MEMCG_KMEM
>  	struct obj_cgroup *cached_objcg;
> +	struct pglist_data *cached_pgdat;
>  	unsigned int nr_bytes;
> +	int vmstat_idx;
> +	int vmstat_bytes;
>  #endif

Because vmstat_idx can realistically take only 3 values (slab_reclaimable,
slab_unreclaimable and percpu), I wonder if it's better to have
vmstat_bytes[3] and save a bit more on the reduced number of flushes?
It must be an often case when a complex (reclaimable) kernel object has
non-reclaimable parts (e.g. kmallocs) or percpu counters.
If the difference will be too small, maybe the current form is better.

>  
>  	struct work_struct work;
> @@ -3157,6 +3160,21 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>  	css_put(&memcg->css);
>  }
>  
> +static inline void mod_objcg_state(struct obj_cgroup *objcg,
> +				   struct pglist_data *pgdat,
> +				   enum node_stat_item idx, int nr)
> +{
> +	struct mem_cgroup *memcg;
> +	struct lruvec *lruvec = NULL;
> +
> +	rcu_read_lock();
> +	memcg = obj_cgroup_memcg(objcg);
> +	if (pgdat)
> +		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +	__mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
> +	rcu_read_unlock();
> +}
> +
>  static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  {
>  	struct memcg_stock_pcp *stock;
> @@ -3207,6 +3225,14 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>  		stock->nr_bytes = 0;
>  	}
>  
> +	if (stock->vmstat_bytes) {
> +		mod_objcg_state(old, stock->cached_pgdat, stock->vmstat_idx,
> +				stock->vmstat_bytes);
> +		stock->vmstat_bytes = 0;
> +		stock->vmstat_idx = 0;
> +		stock->cached_pgdat = NULL;
> +	}
> +
>  	obj_cgroup_put(old);
>  	stock->cached_objcg = NULL;
>  }
> @@ -3251,6 +3277,48 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  	local_irq_restore(flags);
>  }
>  
> +static void __mod_obj_stock_state(struct obj_cgroup *objcg,
> +				  struct pglist_data *pgdat, int idx, int nr)
> +{
> +	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
> +
> +	if (stock->cached_objcg != objcg) {
> +		/* Output the current data as is */
> +	} else if (!stock->vmstat_bytes) {
> +		/* Save the current data */
> +		stock->vmstat_bytes = nr;
> +		stock->vmstat_idx = idx;
> +		stock->cached_pgdat = pgdat;
> +		nr = 0;
> +	} else if ((stock->cached_pgdat != pgdat) ||
> +		   (stock->vmstat_idx != idx)) {
> +		/* Output the cached data & save the current data */
> +		swap(nr, stock->vmstat_bytes);
> +		swap(idx, stock->vmstat_idx);
> +		swap(pgdat, stock->cached_pgdat);
> +	} else {
> +		stock->vmstat_bytes += nr;
> +		if (abs(nr) > PAGE_SIZE) {
> +			nr = stock->vmstat_bytes;
> +			stock->vmstat_bytes = 0;
> +		} else {
> +			nr = 0;
> +		}
> +	}
> +	if (nr)
> +		mod_objcg_state(objcg, pgdat, idx, nr);
> +}
> +
> +void mod_obj_stock_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> +			 int idx, int nr)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	__mod_obj_stock_state(objcg, pgdat, idx, nr);
> +	local_irq_restore(flags);
> +}
> +
>  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
>  {
>  	struct mem_cgroup *memcg;
> @@ -3300,18 +3368,10 @@ void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
>  				   struct pglist_data *pgdat, int idx)
>  {
>  	unsigned long flags;
> -	struct mem_cgroup *memcg;
> -	struct lruvec *lruvec = NULL;
>  
>  	local_irq_save(flags);
>  	__refill_obj_stock(objcg, size);
> -
> -	rcu_read_lock();
> -	memcg = obj_cgroup_memcg(objcg);
> -	if (pgdat)
> -		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -	__mod_memcg_lruvec_state(memcg, lruvec, idx, -(int)size);
> -	rcu_read_unlock();
> +	__mod_obj_stock_state(objcg, pgdat, idx, -(int)size);
>  	local_irq_restore(flags);
>  }
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index 677cdc52e641..ae971975d9fc 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -239,6 +239,8 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
>  #ifdef CONFIG_MEMCG_KMEM
>  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>  				 gfp_t gfp, bool new_page);
> +void mod_obj_stock_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> +			 int idx, int nr);
>  
>  static inline void memcg_free_page_obj_cgroups(struct page *page)
>  {
> @@ -283,20 +285,6 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
>  	return true;
>  }
>  
> -static inline void mod_objcg_state(struct obj_cgroup *objcg,
> -				   struct pglist_data *pgdat,
> -				   enum node_stat_item idx, int nr)
> -{
> -	struct mem_cgroup *memcg;
> -	struct lruvec *lruvec;
> -
> -	rcu_read_lock();
> -	memcg = obj_cgroup_memcg(objcg);
> -	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -	mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
> -	rcu_read_unlock();
> -}
> -
>  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  					      struct obj_cgroup *objcg,
>  					      gfp_t flags, size_t size,
> @@ -324,8 +312,9 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  			off = obj_to_index(s, page, p[i]);
>  			obj_cgroup_get(objcg);
>  			page_objcgs(page)[off] = objcg;
> -			mod_objcg_state(objcg, page_pgdat(page),
> -					cache_vmstat_idx(s), obj_full_size(s));
> +			mod_obj_stock_state(objcg, page_pgdat(page),
> +					    cache_vmstat_idx(s),
> +					    obj_full_size(s));
>  		} else {
>  			obj_cgroup_uncharge(objcg, obj_full_size(s));
>  		}
> @@ -408,6 +397,11 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s,
>  					void **p, int objects)
>  {
>  }
> +
> +static void mod_obj_stock_state(struct obj_cgroup *objcg,
> +				struct pglist_data *pgdat, int idx, int nr)
> +{
> +}
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  static inline struct kmem_cache *virt_to_cache(const void *obj)
> -- 
> 2.18.1
> 
