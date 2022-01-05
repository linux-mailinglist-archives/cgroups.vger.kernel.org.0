Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59E0484C90
	for <lists+cgroups@lfdr.de>; Wed,  5 Jan 2022 03:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiAECmE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Jan 2022 21:42:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57450 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235970AbiAECmD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Jan 2022 21:42:03 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2052GXhR009978;
        Tue, 4 Jan 2022 18:41:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=2JKALd0e4lP+WrJfsg9C4lrp3tw2nN+vlPsIuNo0Qjc=;
 b=BFWvrczTj8RzAxk7IcT7UK5swk7S78KHJFE0gvGnAI+QK1+LUNvgkqBWBR/hQJiSYaKd
 /fNtoSWtE6U5518A/iq81nBYl6DgQOc/OxNNaTU36iseI6Cr8tWkhxxRmn4R0COWSvMA
 cOA4aDaw1b+EPobAr49fg9MR1G8HlIOmJis= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dd2d4g3wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 Jan 2022 18:41:46 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 18:41:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnHkJMW3d/0mx+LsAXBsEnzCN9u0QcrhHdlB1i8AmdQextJdOvRuxtZNVvz3CH1CxGp9vK4+JplMiIVTPDrnddWGKvKAHdhrEvHU2F2lVyTkVad8baAQ+PUY1yc1v+S33ktSh4VwjQEJV3NsyHg7BglTPUkkgkRIJZiRYH48oT5CLCG98dI5WiiQdAHlWwc+xraOZEi9J/CVn9wVaa02EwsJ7lh+WjjXsxkgMHxlcdAeWmpLtGKte0+hDDwj0PQJAbZgCC3jFpSk7wIhss/XYDMIvqI2ERxhYEGP68gnTA3LRTgndwC2BB/9iMoBpuUjJLEzBkD1dYOdBgpGq9ieiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JKALd0e4lP+WrJfsg9C4lrp3tw2nN+vlPsIuNo0Qjc=;
 b=miI80Nx+1+4YxL0qcEdi2BUjcwZq06jZy4SWtw/w/QICGypa0eH8qSFRfzNCVBqUHyTNv/5AYoPbu8EBtxB94zTAhD95eymVx0naFMqrtT3IEcTBCLN45s6nrzB93cIeThyJtqrRNgloo4x/SAdwg7g1ddMQQcI1ki1V6XbTAFOJkLNmd8YxuflpzMH5LGH55QYXf7EQFEsk5KrIAG9OVpatBT7GwLRveCYY1iEBRB1+2NeepaKAg8TyV7jax4lFocWtcU1sHjNrPh6J9Fc5nGYRKXl25ek56qbjHMsbuecanAWhqZbEpg5uEIzx28J/Tcn4rwfZSDB5rPDMQHC0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4630.namprd15.prod.outlook.com (2603:10b6:a03:37b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 02:41:39 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 02:41:39 +0000
Date:   Tue, 4 Jan 2022 18:41:33 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, <patches@lists.linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH v4 23/32] mm/memcg: Convert slab objcgs from struct page
 to struct slab
Message-ID: <YdUFXUbeYGdFbVbq@carbon.dhcp.thefacebook.com>
References: <20220104001046.12263-1-vbabka@suse.cz>
 <20220104001046.12263-24-vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220104001046.12263-24-vbabka@suse.cz>
X-ClientProxiedBy: MW4PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:303:6a::8) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8547fba-425d-4b37-35a1-08d9cff4e61a
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4630:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4630C903E2BB47C2D761442CBE4B9@SJ0PR15MB4630.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bk6CelscaH4EyDGr8hUC9x2lOd92mRAcRYCMUP93EDcgwLVYQkJ16YqUksYR4klRTUM/89fasVxR7g6ogfYMt9UwaT7XP0FYQLPac8eoi/Vr0O/uK42qJVL437BjYa/H2mPFeu33FiQaSeJ2g8hzwfKG9quL3NQubs1cCSggHxQxEp677FVFJallF5PJnbPdxbCRZ26PwIZXF6WHD6N5Y4FD5cxlKpOnLsjSy9geYkq5xjAJYgZkAFyB63DThw5cqHBoAH45mg/PiUefzwIHV7xnnNO3weCk9ac8JoH6r/oZ8amhYd+nShIUIB9xw18+oHOgIX/rk6FV16G4C8aZRwZ+gHIzncfV3T4LoNIKH6dlBJEdg6yrXMIRN1qg/MfJNYwSAvzSKvEU/yHGY4yclUSmMnJxYOOTspOWUo4eGfAZwpZsckGYuDoW2oBCektn36MWKMJwVuxTKKnIjfj2S1OzF8TWyd9dJ9VQSr2kI61qUMDoUfhzgtRC8Tx7n7ejw00TeJz7WyonODe6W7uOKXmvf72WrMJT14Q93K72I7IEgbWfCU5OOgrqkHXRW5gK307VuHUZlt2vtSQ7DUThFWGZHy6s1XvxML0bl2S6qnfQ4aOcpSt64XVPJhP7+rsxbQAVqSZEQGfXo8h1TDKoTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(38100700002)(6486002)(8676002)(52116002)(54906003)(6512007)(83380400001)(8936002)(9686003)(6916009)(6506007)(7416002)(316002)(66476007)(4326008)(66946007)(6666004)(5660300002)(186003)(86362001)(2906002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WFR9pVxyaVLFn0q6yWMK+UMHu+XtLySN29pojCyY5hLc66fVcH3b0jTeSFEz?=
 =?us-ascii?Q?hKDOYI/MxJHEuklwXX6yHph40olxgsK41GeuPUGFnSDz0wbDMTKBZD1GUpXV?=
 =?us-ascii?Q?4oRaeb36H+E+e8vbtTUQ92653oL0xd6zg/NZAoUsDNJu3mgFvTrcA2PsHtGr?=
 =?us-ascii?Q?emtkbuB/k0dg1LPfhGb1bqt5HDsVWv73E8FGwAG3jV3c2FHjHOdT4a5Zm1SY?=
 =?us-ascii?Q?Ljvmhp34XbY/adqlYE49aKwfX5PmKkisZIujwjxUI3QHqqc4o85VoJGXkgg7?=
 =?us-ascii?Q?pRTsTYkAwZg3B+qMjk5oYkAJKsoyDHrk8RLXbNyfKiDh03c1QD5ifhML1Mwi?=
 =?us-ascii?Q?MLKIMS72Yu9G1CSOVJgylb4RxbuA9yvrDB6w4zrl4aW5sybfvSEieNCAmQvG?=
 =?us-ascii?Q?bluVoYSKf3p04Pn4LKfVFOI3bzqncHsDFSaQ9gwNQwmQQ1RCht0SjYyH39Ga?=
 =?us-ascii?Q?4cb/vfV/5DUxYUPpGK8Q63tHvSP5K2p7t6RgEskdUFL+fMaKa+6RnPqW38Bn?=
 =?us-ascii?Q?atRvAlU4Rp3ush1AA5GxJZSrKDUqMXjOjqI+4r/UahIICSaLQwD7XPzx9HvC?=
 =?us-ascii?Q?rpoQfPZuF5lC+zZHPZ5cJy+RTBvhKZBoOyWhWsGH6gwA2JSL8Qfujbca1okR?=
 =?us-ascii?Q?8NVh1X78atSCbGjNds2V5C+U7Erd/BKbID0Y0oUgGltYFo8k6zrtSxsGFqkX?=
 =?us-ascii?Q?Uu7NYo3e6S4loOKkBz18Zsh0qtgqBg658iPOqpOc0zWR7wVHjY2cAMEiguza?=
 =?us-ascii?Q?fDdtScxUPogeoWdgUm4SB3yLThq+gJub7buRYMaYf+GJVfSplxIQKH9AwK47?=
 =?us-ascii?Q?9P3Gdz2EC3H5T4yMjywVC0WogKgCcngNUlBpOJdLi6CWxCBfARVhsXimHP8+?=
 =?us-ascii?Q?xA6YsRS9SpkTo6rroh4z0lJj5BaFomsTf4PrqeoT4mp0unKJEVME/EsLLsbZ?=
 =?us-ascii?Q?cfZygUkmWpL7hCoqzAOOJnKIdhJI8XmNt3NbOIrpLMomIONSa34Wfrtja9KS?=
 =?us-ascii?Q?MoTC56S8grXmw3DSz47ib8FTnojZcYMo9JXIK6ZeYV9Y+eeKbz0q3mIIIHeb?=
 =?us-ascii?Q?XvcnA1yxUFyyHRl/m6JucezkCNgm0OLCtTFl/hRyF/DbjSew7nlzP890VMVi?=
 =?us-ascii?Q?mEpehvkk5mTGWaCPaTscLsMLUmG3bWHhua5oa7mgxGRqs4lnS1y4YUAFyOx8?=
 =?us-ascii?Q?Cf1MzVlT34n8rii+x1ZuCPH07UTOQ+YXfES+U82ijvhSGzCU0cwkjqfc89BT?=
 =?us-ascii?Q?NbYaqnVfwVqcdu8H3ElGlT2my3bukOJLQ4CCaHAOKoGV74VAaK8Yf7cSbWEJ?=
 =?us-ascii?Q?481HrGnJ413TvqzJvqqI2fRVZ3D7RD2vS9JbwPsWikrNdVrmxou5kbsTk4jZ?=
 =?us-ascii?Q?NyhfWmiUKVD+p5FO4D9rov7cqfoORqsRkSjC+W+OOr5NDECorVFxO4IMzCOJ?=
 =?us-ascii?Q?ueuwKWqgKA8jpLw29Qm2l7nXw/Hcu6U/pUxpy+xqT4lzhhF3czaNlv/3X+Aa?=
 =?us-ascii?Q?U3aRKzq5zFFFAAJ+3zaShiP3kOu+WoiKoiTRLpxZcc8euUbcvr+wpHfU3+4X?=
 =?us-ascii?Q?eW+aXPoYOoxvrBpekTR9gASK/lqC0MvuSXguj9LO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8547fba-425d-4b37-35a1-08d9cff4e61a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 02:41:39.0489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXZGr7S+ZIFOc0ZTFjdgyYL4NnGOlNyAZCyw/DteOHUigJBMOn6LwY9StxEAPSmz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4630
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: lE0-VqNCstkDcnG21L7ocCpaAf8YawTd
X-Proofpoint-GUID: lE0-VqNCstkDcnG21L7ocCpaAf8YawTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_01,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 04, 2022 at 01:10:37AM +0100, Vlastimil Babka wrote:
> page->memcg_data is used with MEMCG_DATA_OBJCGS flag only for slab pages
> so convert all the related infrastructure to struct slab. Also use
> struct folio instead of struct page when resolving object pointers.
> 
> This is not just mechanistic changing of types and names. Now in
> mem_cgroup_from_obj() we use folio_test_slab() to decide if we interpret
> the folio as a real slab instead of a large kmalloc, instead of relying
> on MEMCG_DATA_OBJCGS bit that used to be checked in page_objcgs_check().
> Similarly in memcg_slab_free_hook() where we can encounter
> kmalloc_large() pages (here the folio slab flag check is implied by
> virt_to_slab()). As a result, page_objcgs_check() can be dropped instead
> of converted.
> 
> To avoid include cycles, move the inline definition of slab_objcgs()
> from memcontrol.h to mm/slab.h.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: <cgroups@vger.kernel.org>
> ---
>  include/linux/memcontrol.h | 48 ------------------------
>  mm/memcontrol.c            | 47 ++++++++++++-----------
>  mm/slab.h                  | 76 ++++++++++++++++++++++++++------------
>  3 files changed, 79 insertions(+), 92 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c5c403f4be6..e34112f6a369 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -536,45 +536,6 @@ static inline bool folio_memcg_kmem(struct folio *folio)
>  	return folio->memcg_data & MEMCG_DATA_KMEM;
>  }
>  
> -/*
> - * page_objcgs - get the object cgroups vector associated with a page
> - * @page: a pointer to the page struct
> - *
> - * Returns a pointer to the object cgroups vector associated with the page,
> - * or NULL. This function assumes that the page is known to have an
> - * associated object cgroups vector. It's not safe to call this function
> - * against pages, which might have an associated memory cgroup: e.g.
> - * kernel stack pages.
> - */
> -static inline struct obj_cgroup **page_objcgs(struct page *page)
> -{
> -	unsigned long memcg_data = READ_ONCE(page->memcg_data);
> -
> -	VM_BUG_ON_PAGE(memcg_data && !(memcg_data & MEMCG_DATA_OBJCGS), page);
> -	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
> -
> -	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> -}
> -
> -/*
> - * page_objcgs_check - get the object cgroups vector associated with a page
> - * @page: a pointer to the page struct
> - *
> - * Returns a pointer to the object cgroups vector associated with the page,
> - * or NULL. This function is safe to use if the page can be directly associated
> - * with a memory cgroup.
> - */
> -static inline struct obj_cgroup **page_objcgs_check(struct page *page)
> -{
> -	unsigned long memcg_data = READ_ONCE(page->memcg_data);
> -
> -	if (!memcg_data || !(memcg_data & MEMCG_DATA_OBJCGS))
> -		return NULL;
> -
> -	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
> -
> -	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> -}
>  
>  #else
>  static inline bool folio_memcg_kmem(struct folio *folio)
> @@ -582,15 +543,6 @@ static inline bool folio_memcg_kmem(struct folio *folio)
>  	return false;
>  }
>  
> -static inline struct obj_cgroup **page_objcgs(struct page *page)
> -{
> -	return NULL;
> -}
> -
> -static inline struct obj_cgroup **page_objcgs_check(struct page *page)
> -{
> -	return NULL;
> -}
>  #endif
>  
>  static inline bool PageMemcgKmem(struct page *page)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f7b789e692a0..f4fdd5675991 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2816,31 +2816,31 @@ static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
>  	rcu_read_unlock();
>  }
>  
> -int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
> -				 gfp_t gfp, bool new_page)
> +int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
> +				 gfp_t gfp, bool new_slab)
>  {
> -	unsigned int objects = objs_per_slab(s, page_slab(page));
> +	unsigned int objects = objs_per_slab(s, slab);
>  	unsigned long memcg_data;
>  	void *vec;
>  
>  	gfp &= ~OBJCGS_CLEAR_MASK;
>  	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
> -			   page_to_nid(page));
> +			   slab_nid(slab));
>  	if (!vec)
>  		return -ENOMEM;
>  
>  	memcg_data = (unsigned long) vec | MEMCG_DATA_OBJCGS;
> -	if (new_page) {
> +	if (new_slab) {
>  		/*
> -		 * If the slab page is brand new and nobody can yet access
> -		 * it's memcg_data, no synchronization is required and
> -		 * memcg_data can be simply assigned.
> +		 * If the slab is brand new and nobody can yet access its
> +		 * memcg_data, no synchronization is required and memcg_data can
> +		 * be simply assigned.
>  		 */
> -		page->memcg_data = memcg_data;
> -	} else if (cmpxchg(&page->memcg_data, 0, memcg_data)) {
> +		slab->memcg_data = memcg_data;
> +	} else if (cmpxchg(&slab->memcg_data, 0, memcg_data)) {
>  		/*
> -		 * If the slab page is already in use, somebody can allocate
> -		 * and assign obj_cgroups in parallel. In this case the existing
> +		 * If the slab is already in use, somebody can allocate and
> +		 * assign obj_cgroups in parallel. In this case the existing
>  		 * objcg vector should be reused.
>  		 */
>  		kfree(vec);
> @@ -2865,26 +2865,31 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>   */
>  struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  
>  	if (mem_cgroup_disabled())
>  		return NULL;
>  
> -	page = virt_to_head_page(p);
> +	folio = virt_to_folio(p);
>  
>  	/*
>  	 * Slab objects are accounted individually, not per-page.
>  	 * Memcg membership data for each individual object is saved in
>  	 * the page->obj_cgroups.
               ^^^^^^^^^^^^^^^^^
	       slab->memcg_data

>  	 */
> -	if (page_objcgs_check(page)) {
> -		struct obj_cgroup *objcg;
> +	if (folio_test_slab(folio)) {
> +		struct obj_cgroup **objcgs;
> +		struct slab *slab;
>  		unsigned int off;
>  
> -		off = obj_to_index(page->slab_cache, page_slab(page), p);
> -		objcg = page_objcgs(page)[off];
> -		if (objcg)
> -			return obj_cgroup_memcg(objcg);
> +		slab = folio_slab(folio);
> +		objcgs = slab_objcgs(slab);
> +		if (!objcgs)
> +			return NULL;
> +
> +		off = obj_to_index(slab->slab_cache, slab, p);
> +		if (objcgs[off])
> +			return obj_cgroup_memcg(objcgs[off]);
>  
>  		return NULL;
>  	}

There is a comment below, which needs some changes:
	/*
	 * page_memcg_check() is used here, because page_has_obj_cgroups()
	 * check above could fail because the object cgroups vector wasn't set
	 * at that moment, but it can be set concurrently.
	 * page_memcg_check(page) will guarantee that a proper memory
	 * cgroup pointer or NULL will be returned.
	 */

In reality the folio's slab flag can be cleared before releasing the objcgs \
vector. It seems that there is no such possibility at setting the flag,
it's always set before allocating and assigning the objcg vector.

> @@ -2896,7 +2901,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  	 * page_memcg_check(page) will guarantee that a proper memory
>  	 * cgroup pointer or NULL will be returned.
>  	 */
> -	return page_memcg_check(page);
> +	return page_memcg_check(folio_page(folio, 0));
>  }
>  
>  __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> diff --git a/mm/slab.h b/mm/slab.h
> index bca9181e96d7..36e0022d8267 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -412,15 +412,36 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
>  }
>  
>  #ifdef CONFIG_MEMCG_KMEM
> -int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
> -				 gfp_t gfp, bool new_page);
> +/*
> + * slab_objcgs - get the object cgroups vector associated with a slab
> + * @slab: a pointer to the slab struct
> + *
> + * Returns a pointer to the object cgroups vector associated with the slab,
> + * or NULL. This function assumes that the slab is known to have an
> + * associated object cgroups vector. It's not safe to call this function
> + * against slabs with underlying pages, which might have an associated memory
> + * cgroup: e.g.  kernel stack pages.

Hm, is it still true? I don't think so. It must be safe to call it for any
slab now.

The rest looks good to me, please feel free to add
Reviewed-by: Roman Gushchin <guro@fb.com>
after fixing these comments.

Thanks!
