Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3124730D17E
	for <lists+cgroups@lfdr.de>; Wed,  3 Feb 2021 03:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhBCC0a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 21:26:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47916 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230484AbhBCC01 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 21:26:27 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1132P49m009288;
        Tue, 2 Feb 2021 18:25:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Wywg4SVL/d6GoJyrC1vns89GaLMAxht6Ij5veCNe9v8=;
 b=o9XoFrO27+jQrMZ7kIwQDSfcWhEGaGJeJYIW0zDbBfcP4XKLuipNF6zzMApK8XQ/xAQJ
 bcy1VBl+aX8X5iES/Ub3xcPgf9XLfYBXF6oH60DMhWYXrQ/Ne3BeMuYInR6oRdeT5o8E
 rl+CSllfelOcTWIlCeLokFYrAsDqWFhyIEM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36drcuq5s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Feb 2021 18:25:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Feb 2021 18:25:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exXh1NI8R1CxEVEwPOZAk+3cNnUEkHgNNEqdQkwicV7Hsixl7Zh5g5M4yZluaaVOWmAiYeA/mdn93hWHAsyN4m6NU3XPLqHt15Ok8RilBLduBsXTcIWc/S7JdrfSTULMeMDicNcCz6FXw8qxuGuomT12YlH0riTsshtg22Vd28TSSdV/VqiBHGcGmfBoYqtd5h/bouWdjX5dHmZr4muL+Aejv23hNCcHRYMPMT+0EXyakC9s87WXOP+IWmCwOuNd3/SWQr+eGiglhgpxvIp0EqOgdiK91JR7mp9i3L0WqkiFaxQtp7DSl+z6t+dlQ+VvQMrXRWQj8FAJZddAttX3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wywg4SVL/d6GoJyrC1vns89GaLMAxht6Ij5veCNe9v8=;
 b=eg3obl/VtraaEWYa/PM2wNIvXUNqpRtT/xf9HiIfHDilcM6HwndLoY7bLo4CkmnBSDq6Q8MjmzjEiiABZL56A8W+f8fEH2ZEDYNSBzcuub9zjB1RBB6QtSXOECIwo3lLWxLTCJWfREKJFJlKhp9lX0tc9bAF6fY3ST7VA4+JCoY05334VmuDCrHhM8jxK1S5jGTf0bcznHmHXkBh71hd4Dq/0HM5HAX/4cYZYvI4ozaQKCcRYBZskQGeZUx1zrRmpgBLbMFcuUEj3NKuNkvKTI+/z+O7NImt35vPJiqoOW0RjzEbyk5m+reb9NGTX0XlckKBv4Tw2FtWrlFiMJYifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wywg4SVL/d6GoJyrC1vns89GaLMAxht6Ij5veCNe9v8=;
 b=FrLVfpJQx2MMY0W/Ofs4I+/WFAK0P5XjEh9G2Y9R9o3IfGiSdrXYIkf4/pjYpkWPnCgIz0QO2JwPOqtLGpWv9xXrg4Wvh8nsMs0OAgHOawifdOBoS8VP5181e4zdLiuckSFJT0t4khzZM9UwBcMl6lIuilpbIiksgnCqza8IwzY=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3143.namprd15.prod.outlook.com (2603:10b6:a03:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Wed, 3 Feb
 2021 02:25:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 02:25:36 +0000
Date:   Tue, 2 Feb 2021 18:25:30 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 7/7] mm: memcontrol: consolidate lruvec stat flushing
Message-ID: <20210203022530.GF1812008@carbon.dhcp.thefacebook.com>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-8-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202184746.119084-8-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:60a7]
X-ClientProxiedBy: MW4PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:303:8d::12) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:60a7) by MW4PR03CA0157.namprd03.prod.outlook.com (2603:10b6:303:8d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Wed, 3 Feb 2021 02:25:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1435aafe-83bf-4d1a-1803-08d8c7eafd46
X-MS-TrafficTypeDiagnostic: BYAPR15MB3143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3143FC9562050E3F1746C542BEB49@BYAPR15MB3143.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4ktB8uI2rc4Az43toeyEj9pDoJzHF2Um5t3Kw+Cee7n4iz18v5sddEJTVTF2DKY+ajOz4oyMmEt8Ge0k4P++5TW20kq7WVo5I0yuyMY9552NrKeUDdNNvBSPSewAZ/vz1aKZcKaaaxs01guzp64NNSs3Bykg5FCB9rYCpFPYbOKsA3XVFA3/giqbqolRVInglMXSEYWT5bhf8N7mO0uR+3v9BMKmt6e2p7f2BjyUpkEWKsII7oxSJaOOK06ICR8owWXanrXGJcKaEKoGJXraxGI2X2woxGCM7QxnqAekFMhndt4sjg1rXRpBlroqk1Y3hskhU9shvsRQ5WkjRVX8QRhp5VY491kxs3IYe26NYwuuRQjIzHKAUJxyCTbrA8wwdK5TOghmIPs6abj3fGqKsQNtlXI9J0Q+4pK3FcSENznnO7cO4ZljGjh2XB6uxSNwp+t9VelFwL0Y8JHiKGGM/wUHD/h8MuMn4uhh0BBhvh3txOnKqSEeSqnj2nAYRl65tnziYMYkgBtxEko6PFINw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(396003)(376002)(4326008)(66556008)(316002)(66476007)(6666004)(86362001)(5660300002)(83380400001)(6916009)(8676002)(186003)(16526019)(8936002)(7696005)(52116002)(55016002)(66946007)(6506007)(54906003)(478600001)(1076003)(2906002)(9686003)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FLWjy5jN2LVDoBiP+FmOF6iSjTd/XFMH544Uzn3RIBZbI0Xcty/ybSSSCx49?=
 =?us-ascii?Q?xvSedVIjR3cklI2Wd65jv48W1uCuS78ZDNWiOzk3jAclVStGd3VI6dhWviJQ?=
 =?us-ascii?Q?vu1CjwHXV27pnOStzvN+YmaJHgunuk86LXr+s15dk8I8roqXR66AYyioc0dU?=
 =?us-ascii?Q?LBNmCF3ybP3Bdx4+IYV6QTT1ECn5E+ZQh3Wo+28VGuYB0Xg3HbVmllbPeM//?=
 =?us-ascii?Q?OmRouopzjbHtuk/alo0D+9woWSz1atXt5+U+bPbXTQFoa7P6LbyiHPrbUG/C?=
 =?us-ascii?Q?R0ftvlJgGijKIAYsWZae2yx0fKBdgjfWYamkRSFHe49Gv32vZgn2fssTPX1/?=
 =?us-ascii?Q?DKQo4nt2Iha89DJXHeZ+EJ0JAxB31IdxkEUbLT/Du3KxJUDV03uhXvpoQmGH?=
 =?us-ascii?Q?r7IE+V3QMIoySmncAKL2RUC78uo8Iq5FibBxj6P6ppMNjrUkk2dMFlRPpL07?=
 =?us-ascii?Q?v06lnfNdX5ZqOXomysz/cHhd/gfdtFhE/HfIefJ8jtC3iZCbA97V97V426xg?=
 =?us-ascii?Q?cmwUiRt048fGQiGAXEp9cvo4xg4Zo/mVm5cDQ2P5GIplANfeIr8Ls43VgrZR?=
 =?us-ascii?Q?ivilb8NyiJKDMAvz3yfV3rQ7JQZ3KkxQVNWAZ3mxQxQtBsUq7AaJbpSAy2Ex?=
 =?us-ascii?Q?flr1H06K27MYn3Wi48UF4JPS/fXV7RlCp5OXgvdf7I33/PBpBwPaM5m7y/+4?=
 =?us-ascii?Q?yOiVbqsHFHYngTMmWduHLGMroO6Ydc2bQ+C0Bjl0DjvqTkuwHM0ZcaKgjW3V?=
 =?us-ascii?Q?xnNfYeYeG6Z0PnX6uBHqH2xLy3pdtn/Aub1OJA22Rer2WdT4Dukezb5pkyCI?=
 =?us-ascii?Q?UbyYlgFYL8goeruyy6SmjqASIzueaRZtznffUvq7nM9BOeGHj3ja92UrHyMg?=
 =?us-ascii?Q?/O4vDtC9KlxpeoXHaUZKxeBcEEjGs05sD0RA53ywwkDcSqbtDWyPLMNX4Mil?=
 =?us-ascii?Q?1PYC2BZbXAFilcesTsw1fbTLnySbK9TNihuFDa6NmvEO/j43XydK1Q/j1h3N?=
 =?us-ascii?Q?qoGQTm48cKe8K3IAw3qsLd2tZvHl5NkPXnJGDhCHkNtgy87WSlLZjCQMpq12?=
 =?us-ascii?Q?i7ByHqTh9v3jSxHI9wAA4RNreX3pSYrAEClPX93lJPKntw11h9k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1435aafe-83bf-4d1a-1803-08d8c7eafd46
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 02:25:36.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVxrnj4KXRKYY/vIes0DEzPBSc8Dj52JQ94umA3k1nXk248LM3/dsWgrSKl8k69O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3143
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_13:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102030009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 02, 2021 at 01:47:46PM -0500, Johannes Weiner wrote:
> There are two functions to flush the per-cpu data of an lruvec into
> the rest of the cgroup tree: when the cgroup is being freed, and when
> a CPU disappears during hotplug. The difference is whether all CPUs or
> just one is being collected, but the rest of the flushing code is the
> same. Merge them into one function and share the common code.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memcontrol.c | 88 +++++++++++++++++++++++--------------------------
>  1 file changed, 42 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b205b2413186..88e8afc49a46 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2410,39 +2410,56 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  	mutex_unlock(&percpu_charge_mutex);
>  }
>  
> -static int memcg_hotplug_cpu_dead(unsigned int cpu)
> +static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg, int cpu)
>  {
> -	struct memcg_stock_pcp *stock;
> -	struct mem_cgroup *memcg;
> -
> -	stock = &per_cpu(memcg_stock, cpu);
> -	drain_stock(stock);
> +	int nid;
>  
> -	for_each_mem_cgroup(memcg) {
> +	for_each_node(nid) {
> +		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
> +		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = { 0, };
  			      				      ^^^^
							   Same here.

> +		struct batched_lruvec_stat *lstatc;
>  		int i;
>  
> -		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> -			int nid;
> -
> -			for_each_node(nid) {
> -				struct batched_lruvec_stat *lstatc;
> -				struct mem_cgroup_per_node *pn;
> -				long x;
> -
> -				pn = memcg->nodeinfo[nid];
> +		if (cpu == -1) {
> +			int cpui;
> +			/*
> +			 * The memcg is about to be freed, collect all
> +			 * CPUs, no need to zero anything out.
> +			 */
> +			for_each_online_cpu(cpui) {
> +				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpui);
> +				for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> +					stat[i] += lstatc->count[i];
> +			}
> +		} else {
> +			/*
> +			 * The CPU has gone away, collect and zero out
> +			 * its stats, it may come back later.
> +			 */
> +			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
>  				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
> -
> -				x = lstatc->count[i];
> +				stat[i] = lstatc->count[i];
>  				lstatc->count[i] = 0;
> -
> -				if (x) {
> -					do {
> -						atomic_long_add(x, &pn->lruvec_stat[i]);
> -					} while ((pn = parent_nodeinfo(pn, nid)));
> -				}
>  			}
>  		}
> +
> +		do {
> +			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> +				atomic_long_add(stat[i], &pn->lruvec_stat[i]);
> +		} while ((pn = parent_nodeinfo(pn, nid)));
>  	}
> +}
> +
> +static int memcg_hotplug_cpu_dead(unsigned int cpu)
> +{
> +	struct memcg_stock_pcp *stock;
> +	struct mem_cgroup *memcg;
> +
> +	stock = &per_cpu(memcg_stock, cpu);
> +	drain_stock(stock);
> +
> +	for_each_mem_cgroup(memcg)
> +		memcg_flush_lruvec_page_state(memcg, cpu);
>  
>  	return 0;
>  }
> @@ -3636,27 +3653,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>  	}
>  }
>  
> -static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg)
> -{
> -	int node;
> -
> -	for_each_node(node) {
> -		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> -		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = {0, };
> -		struct mem_cgroup_per_node *pi;
> -		int cpu, i;
> -
> -		for_each_online_cpu(cpu)
> -			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> -				stat[i] += per_cpu(
> -					pn->lruvec_stat_cpu->count[i], cpu);
> -
> -		for (pi = pn; pi; pi = parent_nodeinfo(pi, node))
> -			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> -				atomic_long_add(stat[i], &pi->lruvec_stat[i]);
> -	}
> -}
> -
>  #ifdef CONFIG_MEMCG_KMEM
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>  {
> @@ -5197,7 +5193,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
>  	 * Flush percpu lruvec stats to guarantee the value
>  	 * correctness on parent's and all ancestor levels.
>  	 */
> -	memcg_flush_lruvec_page_state(memcg);
> +	memcg_flush_lruvec_page_state(memcg, -1);

I wonder if adding "cpu" or "percpu" into the function name will make clearer what -1 means?
E.g. memcg_flush_(per)cpu_lruvec_stats(memcg, -1).

Reviewed-by: Roman Gushchin <guro@fb.com>
