Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A1341F85B
	for <lists+cgroups@lfdr.de>; Sat,  2 Oct 2021 01:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhJAXyF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Oct 2021 19:54:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42382 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230368AbhJAXyE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Oct 2021 19:54:04 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191NBNJZ009551;
        Fri, 1 Oct 2021 16:52:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zimxUHTLYmWHCBBWYTvQvrbf1s1L/Tqz+bVGN7wqUsQ=;
 b=Cvy6XzlLEMqeUrDNNIUeyd4XYJX0lvdZlG/079K1chp+2inqjK5y6hZ7L44zyegyCUr2
 DViXafMkiAW2XAa4Pp7gpFgInED5BWIjMM/oJkQnJztllKYvRFL1LshzWylzUNUrjso7
 GrErOS8JTQbDEZawGNH4xtgkRI2eK+flqJE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bebsj85vu-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 01 Oct 2021 16:52:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 1 Oct 2021 16:52:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABY2Z2WTANbbCnlYC6j4GpXZa573ChH6GlFeMorLK4e0jbW55mV6rS0/gX93eWwnFeTh7lJLchElhbW5Nn7walnDxG0NWXdHIzuDWf3caM8zR1/E9VJkTx1Y9PuEAMX/CSIQwdgWPwp9j0SjUl6fuTSAfeN7+cKqOB5j8i0lKo8ncc/ZI7vmZMAZ0uGnKRJL0uxkQw4reHhQiQGbuItIg+8pfHYJHGgO8bOqGnwKgLMU2SXbe4A1BmtWuBk5za0tTtYUmM0I/ao8ZFyPoG76f6ktbHNMRHQxzFjB5TlWzkteXZ/IZnBT0+bo8WrziUKjEpFqe07zKYJJOz1Jyp9YMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zimxUHTLYmWHCBBWYTvQvrbf1s1L/Tqz+bVGN7wqUsQ=;
 b=I4TM+QPb5dVbKTE5pp5Iu0iuzw4w48t0lRITAW95NwoSwIuq2GJWtq0Qhff1u3A+0/ejBFzgvXQwzrTVIc9rY7a/MABy4wmpL4DW+95uhpXyiuaoWp1QyELTzCr+UeYY/GIzkJN06c2V3md7CF6L1iWsDxpfLCdmtyBIme3Ncnep0zgHZXHwaA+2WMGcTIEuM/fJXGskkmIF+8ardmwklLnlUW7ihmxj1/Bu+mPudhG6TEDc0lr78tRyrmAydjezNpKn67Ig5vjITEaUySmAuPHVq0zLk30x1G8Nt6lbCIqLxm490MBwcgureR99+svB3tHxrguRTei8NfX1jbveSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB4307.namprd15.prod.outlook.com (2603:10b6:a03:1f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 23:52:00 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 23:52:00 +0000
Date:   Fri, 1 Oct 2021 16:51:56 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 1/3] mm, memcg: Don't put offlined memcg into local stock
Message-ID: <YVefHLo1+6lgw3aB@carbon.dhcp.thefacebook.com>
References: <20211001190938.14050-1-longman@redhat.com>
 <20211001190938.14050-2-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211001190938.14050-2-longman@redhat.com>
X-ClientProxiedBy: BYAPR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:a03:60::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2431) by BYAPR07CA0043.namprd07.prod.outlook.com (2603:10b6:a03:60::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Fri, 1 Oct 2021 23:51:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1aba358-0d22-4b37-ac11-08d9853675c7
X-MS-TrafficTypeDiagnostic: BY5PR15MB4307:
X-Microsoft-Antispam-PRVS: <BY5PR15MB430752D5E90DA59C4CF5BD8CBEAB9@BY5PR15MB4307.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUXdmlASDUfHJVcsohQbzO6h3W+hidXDEXZ81q19CDOjyONiYrvv38bf66TvKyJMLdP59F8Oh2XKDjxuwR+uQ7UfC77+b3oAAaebnSmVvQfOYGCQbtHoZx/qiWihSDT2puTRMcJ0OaTzCBPC+JaSj16jqUP/C0rqlWu6ggsOHe+X28A4pvUN4R/xTTTlkBa0qzl03dduBwmp4XQFGFXwSKgrw2jV62X33+h1ouRQDEUJ+Z2SzrQ4G9kqDgBN0L3HJu0WFyrPgICyvpjFHFFRfcYjtnARCgVxnPdQWOckrkXiggbeCDukjifx0V3HQGBOhiW5xf24X8J716CgKPnY49XGlUIweMwMuRrEWfRf9LeubCmlodySgIT1AnCsTIO0HGJWVBYCeISH3EEy2oRpJzgpcZ4vuBsXg66nU9eBFg5CGX3jLCswzon6bzHAGgIsBLvM4PNLH2HAa8dOe7SvROuJuittOIObVZCH/f3J8Eeg7Ei+jwR1IeN/E3Z3PPmYrwuAIS9KG+TqDasKEPOsESYsONummcAugai4YXD6dla116vWAX28FzF4/MROeH9n5Sen+PBe85lFIyP4SWREH1KnqhExpzKsxHkFRkmSblwWGEwJLeRPw3uQSPyTvQEJBe3HPHDWk4THoTqzuGZukd9+ShUSI2NiMpUNDhBTloevhExjP1WZtkFSqD2XDiZx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(2906002)(55016002)(7416002)(66476007)(66556008)(6916009)(186003)(4326008)(8676002)(316002)(83380400001)(66946007)(8936002)(86362001)(5660300002)(54906003)(6506007)(9686003)(38100700002)(7696005)(52116002)(508600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?91u9q4xcmnD1Rlnz5efOftklIrHEfQVeaiHf5ZsMNZRmLALeOp4wSgY6WtTS?=
 =?us-ascii?Q?lwh+BA38kEsADJ+7hBBvw/Nvivhlq07SjOHgVE7Tkl+QMifCwyW4zMAcT20d?=
 =?us-ascii?Q?BHoTUQbbYIaZYlJ/+VwP7+nwR5i1wad05hykSfCkmNQvAY/C1lO9mvp3hYzR?=
 =?us-ascii?Q?4GoU21HybV7+VyV4edTCy9tPe5QfYutX4gfAs7ies8PJgAsaTmT7Ms+gPClg?=
 =?us-ascii?Q?tix2/266Hk1Rap3ne1S0D5P6nETDBlzAIYqwF/EKZw0/bUPZe9Bzy9eWa35Z?=
 =?us-ascii?Q?1tTKXPrlNyX985Gna+P9vFCuMrqEAHCJMtUQmfglM+Ec5sok6JcumyrrxToO?=
 =?us-ascii?Q?9USjyOuSUw+hd5LKzX2oqwU5KY2KCKXvLuwprYbVGJFMqephd+YrlQACkpsI?=
 =?us-ascii?Q?QXB0ZsstLRfY0yvJ+evXP1QJhVR+nqb/v3D0KKFRKV+VETyGZg4idTt/0hhH?=
 =?us-ascii?Q?ZcMa/rp5PQRropGXv9cssuoAUP23hcVktfvhrgMFLsaUuOMDzw6kggqd/cdT?=
 =?us-ascii?Q?p6Lnl153nR0o1dU4ig/drPraZT9buiDqa0l1YgUPT/86flTPGxAjPtG2xI8O?=
 =?us-ascii?Q?MqFqPoWnworljrz+GX1XmaWvFnFeqbnA7FD2xEgM39qA8DSEvMzlEiw05a/R?=
 =?us-ascii?Q?ss904OZUsXlVeBmtNDwBsPy5Hf+hiMp8ekys+RJ23d7yFAgGbZwlm/O9NULf?=
 =?us-ascii?Q?XtqFTe2cYrHqvpfHIJVM7xeu+mJynCl/myfuYklpKXn9lQuwPSDHXFMmpzEu?=
 =?us-ascii?Q?r92r7PQ4BeCLo1GO3f19AZnAi9sJkJp4gPgCrJwUNc7YD05JG1LjGhrW3wok?=
 =?us-ascii?Q?2KXJEzLJC+ZFPQOdN9mHOyl7q+hZLUqa/F2y4c/lJcCuU+VvOw2TCjNfCcMy?=
 =?us-ascii?Q?WBFDhzqMd7BbzUWAoKdB4dBL5pvGLFSUoRTBV0GSW34BgYXFGZ9AymV/ijrJ?=
 =?us-ascii?Q?a4Cr9FZZhcNgtGfm5nODzlmB1bU9UjkilM0nDRJvBVC9pNUWwOxBeWPxg1dL?=
 =?us-ascii?Q?pUDHbYH96/9pMkLlsgNZNnC0C1zeMtlPupk/feiW6foSvCucTmM4RAj09zij?=
 =?us-ascii?Q?bBfor8P2VaA8jkKf2lI0DvoPVTEzxqG1F4pNsRPaE/boTUs7bib/VLbKg9u2?=
 =?us-ascii?Q?FjZf8QBnCOVDdM38tHUncT3LIrYuL3JkXA0+xRZztWTID7pU+DMJyBJrAta3?=
 =?us-ascii?Q?lJsywUzLEPWJy8DVL3zFYrnJJDlU6TcYoG38cLyPx18IWISDX+ORqUgvW04R?=
 =?us-ascii?Q?jEupt5VoRcVyYzNi272+7kUJR8RcSyrcKu0C2lsQAzmcW9hRZCs+ffhtiree?=
 =?us-ascii?Q?wH16k4eWrDIDW/fxM4gEtN8hdojjIOaWLgXWPp1hXTyj/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1aba358-0d22-4b37-ac11-08d9853675c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 23:52:00.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ALzARkBFZFIb7CE/yhGV991m/k7q0cjwlOvEmMAqIxg/rkCgTLzqv9hsJkjd6en
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4307
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: YAdVWV_TS9g3A0aVminoK_-a2XEWzoIE
X-Proofpoint-GUID: YAdVWV_TS9g3A0aVminoK_-a2XEWzoIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-01_05,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 mlxlogscore=954
 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010165
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 01, 2021 at 03:09:36PM -0400, Waiman Long wrote:
> When freeing a page associated with an offlined memcg, refill_stock()
> will put it into local stock delaying its demise until another memcg
> comes in to take its place in the stock. To avoid that, we now check
> for offlined memcg and go directly in this case to the slowpath for
> the uncharge via the repurposed cancel_charge() function.

Hi Waiman!

I'm afraid it can make a cleanup of a dying cgroup slower: for every
released page we'll potentially traverse the whole cgroup tree and
decrease atomic page counters.

I'm not sure I understand the benefits we get from this change which
do justify the slowdown on the cleanup path.

Thanks!

> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4b32896d87a2..4568363062c1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2167,6 +2167,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	return ret;
>  }
>  
> +static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages);
> +
>  /*
>   * Returns stocks cached in percpu and reset cached information.
>   */
> @@ -2178,9 +2180,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
>  		return;
>  
>  	if (stock->nr_pages) {
> -		page_counter_uncharge(&old->memory, stock->nr_pages);
> -		if (do_memsw_account())
> -			page_counter_uncharge(&old->memsw, stock->nr_pages);
> +		cancel_charge(old, stock->nr_pages);
>  		stock->nr_pages = 0;
>  	}
>  
> @@ -2219,6 +2219,14 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	struct memcg_stock_pcp *stock;
>  	unsigned long flags;
>  
> +	/*
> +	 * An offlined memcg shouldn't be put into stock.
> +	 */
> +	if (unlikely(memcg->kmem_state != KMEM_ONLINE)) {
> +		cancel_charge(memcg, nr_pages);
> +		return;
> +	}
> +
>  	local_irq_save(flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
> @@ -2732,7 +2740,6 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	return try_charge_memcg(memcg, gfp_mask, nr_pages);
>  }
>  
> -#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
>  static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	if (mem_cgroup_is_root(memcg))
> @@ -2742,7 +2749,6 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	if (do_memsw_account())
>  		page_counter_uncharge(&memcg->memsw, nr_pages);
>  }
> -#endif
>  
>  static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  {
> -- 
> 2.18.1
> 
