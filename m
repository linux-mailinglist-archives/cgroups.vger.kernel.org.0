Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C36B484C5A
	for <lists+cgroups@lfdr.de>; Wed,  5 Jan 2022 03:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbiAECN3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Jan 2022 21:13:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10714 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231898AbiAECN2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Jan 2022 21:13:28 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204KIFr7013345;
        Tue, 4 Jan 2022 18:13:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=qoFuzAoQGTty1MDmSTgR1v+HnkoMu0EvYAC9Bf/VzM4=;
 b=YcMvLxwbYcs9MbRU/sfxTEQ5YFx1m6b8fIKx4yvCnfDWazyI4+FmN0XwtwBHlH3GRnZR
 MGCzYJ6qvoC6evK/kfpwgrgXKuTdFavWx5IYZUtGLnMUa8eMmhK1Z14DPTuep2aNnd91
 KGzA7g5YqizRv6EN94b0g7hzhYzDgAO71JY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dccqry302-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 Jan 2022 18:13:05 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 18:13:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZpCIwhiS4CEQfUtmDh84biNNPcI3dy9ZFBw19xkMfjFVhcajoAJ7EPMr8c6J4mpxHpc7p/rS72Vjl7szBsxQ9v5lsVACNWZxrKbwVQQ736mX6FLWSyOtUSGiI1xIDguWGOqPTVqh7KAtkuKs/YBr3dpR9SF2429YWjKjcFQid57qk/JvMEWtO82jofRIjaILn/SL0OXrqH55lXFLxL42U0M73kSHkAczTbrbiFd5AOWo0V2XNmv38V2Fp79INadOCu7lRkyOCX/cdT130XA84VOYjQDx/1bRPpTHjWsbEBZdWSBQbkQDSP3bYvYXmtHIjdObXev65+mzBJ19zZDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoFuzAoQGTty1MDmSTgR1v+HnkoMu0EvYAC9Bf/VzM4=;
 b=ePWRjWAWASL1CFLV+Jd//4D3jWsNKRe8LU4Ic+2wyGCj+5Pv76FToHM7QN5tBboLAQCE9ZNs30hAK0nIWxIvwHOh/sC6USG57yBRSMc9vbfgdnIkDgoF8jn/GT3ivmYsMeRZ24Vl5Z+ppJ3N3kPEuA+aa3ej9zXSUhN4nT4w885fjmQWBEi4Z+sBNuJY5kZckazdBQOMSPBWqm+SqBgDrkJGoelWiIg2T7po01iPprw4uJl6rmOz3H9Y3ZIHCv16JdUTENDCs0Lhf3bv/3Ksd9NzLOLXUKikwwH+38P9RRUIh/GrQMExPwwjn3B+RZzOjsdurBizz731psaf6NKheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4133.namprd15.prod.outlook.com (2603:10b6:a03:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 02:13:02 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 02:13:02 +0000
Date:   Tue, 4 Jan 2022 18:12:57 -0800
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <kasan-dev@googlegroups.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v4 22/32] mm: Convert struct page to struct slab in
 functions used by other subsystems
Message-ID: <YdT+qU4xgQeZc/jP@carbon.dhcp.thefacebook.com>
References: <20220104001046.12263-1-vbabka@suse.cz>
 <20220104001046.12263-23-vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220104001046.12263-23-vbabka@suse.cz>
X-ClientProxiedBy: MW4PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:303:b9::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da6ac80f-e57f-4a2b-f1c4-08d9cff0e699
X-MS-TrafficTypeDiagnostic: BYAPR15MB4133:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB41338D132CB99549530445CCBE4B9@BYAPR15MB4133.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27PNHSHE+pMIre8LDti6ToDaikxaA9tw68snvoZ3BE168ecI3hdlwbCo3rThQNhSA1ueBypOoCIo7LA0IIjCjYUndphN4bMen5b+PJvlswPTibjh1iszy53MHq8zrQbCFK4KMmZWQyn/EzfRMCP5gfP7mVOiNzFDrL4j8AfnDFlofgn+dqL//JCyRgakhU78570/B+3cK6n6s77AfYdFttqACtLyrVgxPy0fepvHtLoZRezl7265DwgyCJeVkfhvQs0y9Qbx3LL2GEIpVpuGGhtzsdw780AoON769EyZaFIPeZBKYep8OUh/VtJiBrtwh9pQ1FXHCg7BMmkZbQnaBhUWSULW+Vfm6bWxNC4qDWySSiPgyEjDi3ZUASfhKAzD3DFD8Lz7Ce7g4ZPVqOS2ZQ2jnlMmcxceMbRFRErDPO2f3a88IvZL8vqxCXdrnIEpNaWX16o9DBZ+6ACUse7YZ4G6m7uS3uhHtvCHwqsb73w6BAXZMOZWuuV18yzizm83PjWymC2kfS54oPUoZvL4WtO53/ZlB1l0t+CC9lQ1mLNheLh6+EqB8Phb5mOsvEnCtWIlS881oZ/ovgwG5SPFIoab9H+4QPUEhEwHCWl22ft1+bzhKYgDHzpLgJ2tuQtDSjvQSGETKOnHWUuxABoshA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(38100700002)(83380400001)(6916009)(6512007)(86362001)(9686003)(30864003)(2906002)(8676002)(7416002)(508600001)(6506007)(52116002)(4326008)(8936002)(6666004)(66946007)(66476007)(186003)(316002)(6486002)(66556008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SvPCXEkGgQS0xnOVyQw5Bg8SrLN/qFy1hiRwcWWEm3cd24lCoFk07D9kuRor?=
 =?us-ascii?Q?d68hUa7d5nxG8bvGwgRlRi2hQpjMLm+yF4piPYDETA6PaZRG07LbriMd7ug4?=
 =?us-ascii?Q?LBxm5J38QaFIM9FGZSpRw6cy0DuOwgdXRJUQUkB20mKE6JRUR37q3B6Ayplg?=
 =?us-ascii?Q?YDDy5c9KwR9bLl/20OXU20TYBG/O0zTBi4+zZGlOme+Umn1/QFX/GfWfLId4?=
 =?us-ascii?Q?LnCNXLMTR/QRAbKQteMaEgr9Zk0pV9/kEIqx9zcDDYT9R/9fi59ZIexP+uvM?=
 =?us-ascii?Q?SoOEJyLQni7UNKNv7nOA1pdJtAHJLiqr8r/0bSVjE5eJG+SjTaexSSH5VUYH?=
 =?us-ascii?Q?J2M+xAMwEoE/fsSKwx0B8cf1WcgtCfXxamTJVj/DIthsrLMI0TjRGaMZjnrw?=
 =?us-ascii?Q?m09LQFnFrl+J5qN4/1EO1wD/Kqxc134RiostpbipszQFSpGJiK+kEoiUH9XV?=
 =?us-ascii?Q?rFv65Ib10ojlju0KW7FZX8nYqTccleMw2dc5jmFRQWLt4Htm1pRU6S2RCr/m?=
 =?us-ascii?Q?EpOnpYQmjEe3O2kfKDXYPt0N/YU1OxKO4lrqOnj28m8c82FH4w14J+eAeJ79?=
 =?us-ascii?Q?WW3bixxgcaRI4Fd/LtaIin4V27B+CEPz7rNj9Hv4z5UEy+8TnuL5d32jqlJD?=
 =?us-ascii?Q?CSGraIkMFP6mQ3G0fjIVQReyZbWQscOod5RAMOu/uVdRSsSq41hfkVMyTJI6?=
 =?us-ascii?Q?cDRjviW7xxT1rMuy0hGx+65P2vRgje001yZeFbIZQ1kHrXH8CfLKyibpzu+r?=
 =?us-ascii?Q?m/TWX+l7zQLGOtCaxlGzEYv04g2KBKH+VwG7U3s1qJwHZ/4u7CYfRsciyZoH?=
 =?us-ascii?Q?SwxCi7zga2LL6I0xcR4wbrkvghZPbBgAwa1/9UnwejgskN/lq+1x3fplGmMG?=
 =?us-ascii?Q?5Be9/NXfW/449CaC7AreF+wWRAyMaBLr5SwCikgaAF2id57K8Gt/YLZVxexC?=
 =?us-ascii?Q?2nL0YUHyyiQJYObCOfCRvMxdXtqNVLmJ9xfABgx0o9bh316ExXJG+GleiZw5?=
 =?us-ascii?Q?MjbPL8zA7Nc1N/Y8FMvudxJs5YDHVjFWrX9ApByYHTN82RK7EOr+2pM0gtg9?=
 =?us-ascii?Q?/67oHzeudVRw+kQB/RbdRUHHte7RHmGZDtz1pishl74vAVVkcaHQVEASHfAX?=
 =?us-ascii?Q?4zQ2wVKhPw2wq5adIh8Wja9nEqEHj3P/13e1kuaAa+xYwI9NIAgXGBNU+OcE?=
 =?us-ascii?Q?DXLZmJz6G6m0JOLwx1CPfFszxv44T1uYg+014tWD/AbG6TAPoHSWuJY2fIPv?=
 =?us-ascii?Q?Vv4gy5IKcpy4tSckChWqf+OJsQ1WkBw8wi7x+S+DS/dQFUuK3BmEBHLwS2JQ?=
 =?us-ascii?Q?EwYgvRmzA52czybxFDJtzEeO0POkdHu7INaj1jWzCYC0FjFOdQmFBQZQ0iFY?=
 =?us-ascii?Q?7a+GVI6CA8KE4sr8NZ8mh18eg03cIbo8gnKHcrEAYMHj111VjrlGyLATN6Nk?=
 =?us-ascii?Q?8Ud4KE5pPP06BkSx/F/yEAZxRwjYumu9w3tjujh3ugX7Xt8dNu/3jT1nNRkv?=
 =?us-ascii?Q?G9Ec85P1M+MXB/xGezHZGJgtdBztNtCxWNWPWaUzK8nbNCEnsoSq1Lg60EFO?=
 =?us-ascii?Q?Hc7lCuajN+RLH93rL4MKYIFtIZzTlWEhYIyF0M5S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da6ac80f-e57f-4a2b-f1c4-08d9cff0e699
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 02:13:01.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKKUn3j4iojoEWqGaHhhvHNkUrVjgeV+eyqWFaQx0QInfKRoK7z4U68ssbgiH2tR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4133
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: hy7N78IiI9dbsir_tw1tcMljL5GJ70A1
X-Proofpoint-ORIG-GUID: hy7N78IiI9dbsir_tw1tcMljL5GJ70A1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_11,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050013
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 04, 2022 at 01:10:36AM +0100, Vlastimil Babka wrote:
> KASAN, KFENCE and memcg interact with SLAB or SLUB internals through
> functions nearest_obj(), obj_to_index() and objs_per_slab() that use
> struct page as parameter. This patch converts it to struct slab
> including all callers, through a coccinelle semantic patch.
> 
> // Options: --include-headers --no-includes --smpl-spacing include/linux/slab_def.h include/linux/slub_def.h mm/slab.h mm/kasan/*.c mm/kfence/kfence_test.c mm/memcontrol.c mm/slab.c mm/slub.c
> // Note: needs coccinelle 1.1.1 to avoid breaking whitespace
> 
> @@
> @@
> 
> -objs_per_slab_page(
> +objs_per_slab(
>  ...
>  )
>  { ... }
> 
> @@
> @@
> 
> -objs_per_slab_page(
> +objs_per_slab(
>  ...
>  )
> 
> @@
> identifier fn =~ "obj_to_index|objs_per_slab";
> @@
> 
>  fn(...,
> -   const struct page *page
> +   const struct slab *slab
>     ,...)
>  {
> <...
> (
> - page_address(page)
> + slab_address(slab)
> |
> - page
> + slab
> )
> ...>
>  }
> 
> @@
> identifier fn =~ "nearest_obj";
> @@
> 
>  fn(...,
> -   struct page *page
> +   const struct slab *slab
>     ,...)
>  {
> <...
> (
> - page_address(page)
> + slab_address(slab)
> |
> - page
> + slab
> )
> ...>
>  }
> 
> @@
> identifier fn =~ "nearest_obj|obj_to_index|objs_per_slab";
> expression E;
> @@
> 
>  fn(...,
> (
> - slab_page(E)
> + E
> |
> - virt_to_page(E)
> + virt_to_slab(E)
> |
> - virt_to_head_page(E)
> + virt_to_slab(E)
> |
> - page
> + page_slab(page)
> )
>   ,...)
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Julia Lawall <julia.lawall@inria.fr>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: <kasan-dev@googlegroups.com>
> Cc: <cgroups@vger.kernel.org>
> ---
>  include/linux/slab_def.h | 16 ++++++++--------
>  include/linux/slub_def.h | 18 +++++++++---------
>  mm/kasan/common.c        |  4 ++--
>  mm/kasan/generic.c       |  2 +-
>  mm/kasan/report.c        |  2 +-
>  mm/kasan/report_tags.c   |  2 +-
>  mm/kfence/kfence_test.c  |  4 ++--
>  mm/memcontrol.c          |  4 ++--
>  mm/slab.c                | 10 +++++-----
>  mm/slab.h                |  4 ++--
>  mm/slub.c                |  2 +-
>  11 files changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> index 3aa5e1e73ab6..e24c9aff6fed 100644
> --- a/include/linux/slab_def.h
> +++ b/include/linux/slab_def.h
> @@ -87,11 +87,11 @@ struct kmem_cache {
>  	struct kmem_cache_node *node[MAX_NUMNODES];
>  };
>  
> -static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
> +static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
>  				void *x)
>  {
> -	void *object = x - (x - page->s_mem) % cache->size;
> -	void *last_object = page->s_mem + (cache->num - 1) * cache->size;
> +	void *object = x - (x - slab->s_mem) % cache->size;
> +	void *last_object = slab->s_mem + (cache->num - 1) * cache->size;
>  
>  	if (unlikely(object > last_object))
>  		return last_object;
> @@ -106,16 +106,16 @@ static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
>   *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
>   */
>  static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> -					const struct page *page, void *obj)
> +					const struct slab *slab, void *obj)
>  {
> -	u32 offset = (obj - page->s_mem);
> +	u32 offset = (obj - slab->s_mem);
>  	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
>  }
>  
> -static inline int objs_per_slab_page(const struct kmem_cache *cache,
> -				     const struct page *page)
> +static inline int objs_per_slab(const struct kmem_cache *cache,
> +				     const struct slab *slab)

Nice! It looks indeed better.

>  {
> -	if (is_kfence_address(page_address(page)))
> +	if (is_kfence_address(slab_address(slab)))
>  		return 1;
>  	return cache->num;
>  }
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index 8a9c2876ca89..33c5c0e3bd8d 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -158,11 +158,11 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
>  
>  void *fixup_red_left(struct kmem_cache *s, void *p);
>  
> -static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
> +static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
>  				void *x) {
> -	void *object = x - (x - page_address(page)) % cache->size;
> -	void *last_object = page_address(page) +
> -		(page->objects - 1) * cache->size;
> +	void *object = x - (x - slab_address(slab)) % cache->size;
> +	void *last_object = slab_address(slab) +
> +		(slab->objects - 1) * cache->size;
>  	void *result = (unlikely(object > last_object)) ? last_object : object;
>  
>  	result = fixup_red_left(cache, result);
> @@ -178,16 +178,16 @@ static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
>  }
>  
>  static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> -					const struct page *page, void *obj)
> +					const struct slab *slab, void *obj)
>  {
>  	if (is_kfence_address(obj))
>  		return 0;
> -	return __obj_to_index(cache, page_address(page), obj);
> +	return __obj_to_index(cache, slab_address(slab), obj);
>  }
>  
> -static inline int objs_per_slab_page(const struct kmem_cache *cache,
> -				     const struct page *page)
> +static inline int objs_per_slab(const struct kmem_cache *cache,
> +				     const struct slab *slab)
>  {
> -	return page->objects;
> +	return slab->objects;
>  }
>  #endif /* _LINUX_SLUB_DEF_H */
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 8428da2aaf17..6a1cd2d38bff 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -298,7 +298,7 @@ static inline u8 assign_tag(struct kmem_cache *cache,
>  	/* For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU: */
>  #ifdef CONFIG_SLAB
>  	/* For SLAB assign tags based on the object index in the freelist. */
> -	return (u8)obj_to_index(cache, virt_to_head_page(object), (void *)object);
> +	return (u8)obj_to_index(cache, virt_to_slab(object), (void *)object);
>  #else
>  	/*
>  	 * For SLUB assign a random tag during slab creation, otherwise reuse
> @@ -341,7 +341,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>  	if (is_kfence_address(object))
>  		return false;
>  
> -	if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
> +	if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
>  	    object)) {
>  		kasan_report_invalid_free(tagged_object, ip);
>  		return true;
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 84a038b07c6f..5d0b79416c4e 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -339,7 +339,7 @@ static void __kasan_record_aux_stack(void *addr, bool can_alloc)
>  		return;
>  
>  	cache = page->slab_cache;
> -	object = nearest_obj(cache, page, addr);
> +	object = nearest_obj(cache, page_slab(page), addr);
>  	alloc_meta = kasan_get_alloc_meta(cache, object);
>  	if (!alloc_meta)
>  		return;
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 0bc10f452f7e..e00999dc6499 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -249,7 +249,7 @@ static void print_address_description(void *addr, u8 tag)
>  
>  	if (page && PageSlab(page)) {
>  		struct kmem_cache *cache = page->slab_cache;
> -		void *object = nearest_obj(cache, page,	addr);
> +		void *object = nearest_obj(cache, page_slab(page),	addr);
                                                                  s/tab/space
>  
>  		describe_object(cache, object, addr, tag);
>  	}
> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
> index 8a319fc16dab..06c21dd77493 100644
> --- a/mm/kasan/report_tags.c
> +++ b/mm/kasan/report_tags.c
> @@ -23,7 +23,7 @@ const char *kasan_get_bug_type(struct kasan_access_info *info)
>  	page = kasan_addr_to_page(addr);
>  	if (page && PageSlab(page)) {
>  		cache = page->slab_cache;
> -		object = nearest_obj(cache, page, (void *)addr);
> +		object = nearest_obj(cache, page_slab(page), (void *)addr);
>  		alloc_meta = kasan_get_alloc_meta(cache, object);
>  
>  		if (alloc_meta) {
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 695030c1fff8..f7276711d7b9 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -291,8 +291,8 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
>  			 * even for KFENCE objects; these are required so that
>  			 * memcg accounting works correctly.
>  			 */
> -			KUNIT_EXPECT_EQ(test, obj_to_index(s, page, alloc), 0U);
> -			KUNIT_EXPECT_EQ(test, objs_per_slab_page(s, page), 1);
> +			KUNIT_EXPECT_EQ(test, obj_to_index(s, page_slab(page), alloc), 0U);
> +			KUNIT_EXPECT_EQ(test, objs_per_slab(s, page_slab(page)), 1);
>  
>  			if (policy == ALLOCATE_ANY)
>  				return alloc;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2ed5f2a0879d..f7b789e692a0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2819,7 +2819,7 @@ static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
>  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>  				 gfp_t gfp, bool new_page)
>  {
> -	unsigned int objects = objs_per_slab_page(s, page);
> +	unsigned int objects = objs_per_slab(s, page_slab(page));
>  	unsigned long memcg_data;
>  	void *vec;
>  
> @@ -2881,7 +2881,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  		struct obj_cgroup *objcg;
>  		unsigned int off;
>  
> -		off = obj_to_index(page->slab_cache, page, p);
> +		off = obj_to_index(page->slab_cache, page_slab(page), p);
>  		objcg = page_objcgs(page)[off];
>  		if (objcg)
>  			return obj_cgroup_memcg(objcg);
> diff --git a/mm/slab.c b/mm/slab.c
> index 547ed068a569..c13258116791 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1559,7 +1559,7 @@ static void check_poison_obj(struct kmem_cache *cachep, void *objp)
>  		struct slab *slab = virt_to_slab(objp);
>  		unsigned int objnr;
>  
> -		objnr = obj_to_index(cachep, slab_page(slab), objp);
> +		objnr = obj_to_index(cachep, slab, objp);
>  		if (objnr) {
>  			objp = index_to_obj(cachep, slab, objnr - 1);
>  			realobj = (char *)objp + obj_offset(cachep);
> @@ -2529,7 +2529,7 @@ static void *slab_get_obj(struct kmem_cache *cachep, struct slab *slab)
>  static void slab_put_obj(struct kmem_cache *cachep,
>  			struct slab *slab, void *objp)
>  {
> -	unsigned int objnr = obj_to_index(cachep, slab_page(slab), objp);
> +	unsigned int objnr = obj_to_index(cachep, slab, objp);
>  #if DEBUG
>  	unsigned int i;
>  
> @@ -2716,7 +2716,7 @@ static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
>  	if (cachep->flags & SLAB_STORE_USER)
>  		*dbg_userword(cachep, objp) = (void *)caller;
>  
> -	objnr = obj_to_index(cachep, slab_page(slab), objp);
> +	objnr = obj_to_index(cachep, slab, objp);
>  
>  	BUG_ON(objnr >= cachep->num);
>  	BUG_ON(objp != index_to_obj(cachep, slab, objnr));
> @@ -3662,7 +3662,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  	objp = object - obj_offset(cachep);
>  	kpp->kp_data_offset = obj_offset(cachep);
>  	slab = virt_to_slab(objp);
> -	objnr = obj_to_index(cachep, slab_page(slab), objp);
> +	objnr = obj_to_index(cachep, slab, objp);
>  	objp = index_to_obj(cachep, slab, objnr);
>  	kpp->kp_objp = objp;
>  	if (DEBUG && cachep->flags & SLAB_STORE_USER)
> @@ -4180,7 +4180,7 @@ void __check_heap_object(const void *ptr, unsigned long n,
>  
>  	/* Find and validate object. */
>  	cachep = slab->slab_cache;
> -	objnr = obj_to_index(cachep, slab_page(slab), (void *)ptr);
> +	objnr = obj_to_index(cachep, slab, (void *)ptr);
>  	BUG_ON(objnr >= cachep->num);
>  
>  	/* Find offset within object. */
> diff --git a/mm/slab.h b/mm/slab.h
> index 039babfde2fe..bca9181e96d7 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -483,7 +483,7 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  				continue;
>  			}
>  
> -			off = obj_to_index(s, page, p[i]);
> +			off = obj_to_index(s, page_slab(page), p[i]);
>  			obj_cgroup_get(objcg);
>  			page_objcgs(page)[off] = objcg;
>  			mod_objcg_state(objcg, page_pgdat(page),
> @@ -522,7 +522,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
>  		else
>  			s = s_orig;
>  
> -		off = obj_to_index(s, page, p[i]);
> +		off = obj_to_index(s, page_slab(page), p[i]);
>  		objcg = objcgs[off];
>  		if (!objcg)
>  			continue;
> diff --git a/mm/slub.c b/mm/slub.c
> index cc64ba9d9963..ddf21c7a381a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4342,7 +4342,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  #else
>  	objp = objp0;
>  #endif
> -	objnr = obj_to_index(s, slab_page(slab), objp);
> +	objnr = obj_to_index(s, slab, objp);
>  	kpp->kp_data_offset = (unsigned long)((char *)objp0 - (char *)objp);
>  	objp = base + s->size * objnr;
>  	kpp->kp_objp = objp;
> -- 
> 2.34.1
> 

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
