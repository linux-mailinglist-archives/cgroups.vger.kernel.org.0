Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47A33747EF
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhEESXw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 14:23:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5060 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229901AbhEESXw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 14:23:52 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145IEN1v003942;
        Wed, 5 May 2021 11:22:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=x0KVY3LSR7YAj1OJ/vMTfakBFG5tqAwbgxoSe8TIswE=;
 b=fNCL/cda76FY2jqchuarI2YpcQXQtruRBgDmHa5k+V9YsVdO4RJ8C4egYw/2Y4+XlIT6
 aRVy6P0sk+QwF6cca7mqEuC00giU1LX430sBKgQ4JfAZ1/v7bKvDYfeYfriIFy47M0/J
 vXNtA/7aKX/+ikZn5NEM37AoSfgvsC+3iNs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38beb554fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 11:22:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 11:22:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnJRKtju74REOnl1YMuPwc79Twgz8DHE5b2bUOQeQrWRKed3ux4194vs2kpwAHD6wnCabxCPdYxMerUB7rnQpd8Br23SeamQqDlNnHYsghA4TcS+GRZpRBmSr6U9AjiEInENObu0ReQVwV8rSCmg1Sy0D2zDIm8lnjS1tV6oiOz5zhbxcIzktGC8o0IrESGHBTMk29m+85FslxcC2ay+SOHjNm5EP+T4mpGpQVmXnMLKBDP3hIiFJzsnu63HMhi0d3Q0e/08YWpSa0/lmHJH1Pfo3JNbohwUbCEaGQWmw+PIoZOHkROsfOpiNSB55+VaFMJ7rjdP1IpWYSXwxgnk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0KVY3LSR7YAj1OJ/vMTfakBFG5tqAwbgxoSe8TIswE=;
 b=QpGSHswvcUoQ2sumhPDjjK5awPAFx6LZAGL1ECZP43nPcbt9oPsZpk0uwpxnOaPMtfuRsIpIAL7jDj/pmw1LEGrLN4s6EfDKLvu26FYOQPRGOWRD7/+QlSdZN7XljSL269eaM5atYy03P+6Q5Mldm9FeRHQvyZ4NO6IbIx8QgtpNrJrl0jf7+7Kjj97KX+Fcc/WTsAHa1U1texcowQerK5OrfjC2bauttXS8vNM0B/JpVQKYH0XgOnMhQAAehgmdNHEGtBSH3bnx/1d/7gLByBwfjQbxxbXIrc2d1EYmWmin1Oy80YEqWudmMXshDs2XB8BuQYTK6sCURpE6tyBUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3079.namprd15.prod.outlook.com (2603:10b6:a03:f5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Wed, 5 May
 2021 18:22:39 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 18:22:39 +0000
Date:   Wed, 5 May 2021 11:22:34 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <llong@redhat.com>
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
Message-ID: <YJLiaixn6Zi82cKh@carbon.dhcp.thefacebook.com>
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
 <f14a263b-10ea-ef2b-eefa-066591a4b637@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f14a263b-10ea-ef2b-eefa-066591a4b637@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:682d]
X-ClientProxiedBy: MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:682d) by MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Wed, 5 May 2021 18:22:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b926a4e-6c7b-4695-4c68-08d90ff2c412
X-MS-TrafficTypeDiagnostic: BYAPR15MB3079:
X-Microsoft-Antispam-PRVS: <BYAPR15MB307998535BC4EDD02BF9D1FCBE599@BYAPR15MB3079.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlFxClxWSYJWVPYtsQLFVovhBys57oVavHSxz6m6mRHxmcVALz1e/btbV0xQ6fF1jlJ7bN9S1ECXAnnmD1I5QEUHP8DXh7UBnnfLiH9YJHefPVRnzFqwjVNIPSYnGGYGEh/Wtucesotq6gs+XThz9vqxwBs2XNaB61PK5LFcDR9REImSPoxFLmcGFCe17TxwuOQY6+jTBfRA761bC2hDNwmsU+2X+xhH8qiVA6SZA4rDhVLi6/xdgVKPDiyNv8M8/RwDshTlYc15XELvyqDpAWgyKB4Oq7cYDvZyh9hxsLIUmiNHelrZk/ggecxqPI6xYKnL7Ah6gfFq/e5rbN7ZQeceya7wdFhGbJHDRr9soKAVpBIgfiBJwiOEV41VIRkHCX0ZNZhXv4piuln8JqA+UhjLoS2QA4RbBYOiir4tnRN/hHkdjwJ8JYLmkHJ5So5P3w4USAhhUryIziFiS8hP/WtYB7Apv+AikxP14OVy4a47pyCRraCaceVE3ruiM4+pgixP8jRc0Qhd2YDofP7QgAzjfi0M8c9mJF7m4/r2QfXFXvKS54n1EsLN95Zyk6hKi8ESy8M87EyxXpxosRieo4zZnJlrREBG+Fg2IRSVqQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(6666004)(2906002)(6916009)(53546011)(83380400001)(7416002)(66476007)(66946007)(186003)(86362001)(66556008)(9686003)(55016002)(316002)(52116002)(8936002)(7696005)(8676002)(478600001)(16526019)(4326008)(38100700002)(54906003)(5660300002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FI/Ac3rNe1dwcl760jccR9b2ZCFeCB+Yx8HKSm2w0V+AKTu5UeU30feuywHR?=
 =?us-ascii?Q?yEzkloXj2p+v4aZYa7cILkweDjDAZeFWVSvBNbHVZ7i49P7yCn97wbORWj7v?=
 =?us-ascii?Q?tx/qSLRWlV129DjfqCodDa29Jj1UZxvn/BkQvMls/l5qKa1uRLbNHBBRtIBj?=
 =?us-ascii?Q?mBIrpNz+ZJFA/NeYq5cSDjhRUakYuLwCjWm+8wu/bnVw9+sfJrv9Bk3KaEDp?=
 =?us-ascii?Q?aGuC/Asdy+ymigCU9xxgoVQ9ekrZviwBBGJfcgitmg/kY7JgpjOg/UTVZnkf?=
 =?us-ascii?Q?MjM8IswmcplpLL17Odq38t8eD6/bNHIyGDdNmkVOA8OqZfWWGANQ57LASx0s?=
 =?us-ascii?Q?g+mjCPIiI4Pd8CoDzGVshn+yukvxkj72AyKHRqKDRfL+u4ecg2AewpElu5NW?=
 =?us-ascii?Q?i0veB+aP+mmH36RvP/dGi6mvPk97bGcUFGVwfFfnzLSn2vqAsGE0Q32SKnh6?=
 =?us-ascii?Q?K7BNBRxkpXwRMSWK9MJGtocihwZfXRcQ13/zd1UlA76HsNqO9lTaEM0azlli?=
 =?us-ascii?Q?iSLC5SyxaMDwCgoegleAPTA1OZWHIkkepzCXWsz8+9bgNm4V0unMmDJL1sm6?=
 =?us-ascii?Q?Bbtco5LbOjDOyHEByVxJsdo7pYkAJlFesrNAlq1HgvBmzqeTV0jQJwJiJxje?=
 =?us-ascii?Q?2brbNE3l9QBPy+c5UIU0/VFLb69fIrh4S0dH64+9CMm/UklJIWCaItklxWWF?=
 =?us-ascii?Q?mgpOTWnwMAJPQvdXGA73abo61/p7kgfGQN57PjJqy7Re/sSiM65UfkEEhEJa?=
 =?us-ascii?Q?k6kn9d+tRbJQmzLy+OT55fu8qoSZuHofyXbp+L0t1CMzUkySjAEoIM2Wpxm7?=
 =?us-ascii?Q?iuq6hFFNPB9q1KtFX0esvtuiUJ/Wofq+y6yYEggr1FaP4XZQ3GPK1SG7R9SI?=
 =?us-ascii?Q?Kl6nFFZ2Soa+xEsC6zYdRyq2KUuubrhphyW5ubLEnLrlUQWHOtIOqzompwmX?=
 =?us-ascii?Q?jgUj4RrjGfR01AsmUcL/WwZbk2hEY4ikTT/Mpxne5HFWz5bf07HYwrBRtYBB?=
 =?us-ascii?Q?RyhYHrkgwqR+aKZRqzAIbbZRFJtqlf6JFANGNqMoBJ3No/3Nc0PaGtwE0wFd?=
 =?us-ascii?Q?4pu5+TsnJbfYDGiTDDFR9TVju0tFKOGi4HCm7LCHdtNUWi+6VFfpY/MvdaMR?=
 =?us-ascii?Q?+utmCO8PROWB2bMIYPIMLd28lKRs9Vi+fABc7f2lIACkuMuj0fAtGJfiLdsI?=
 =?us-ascii?Q?NJ8qMLpX5+TjnYlX1Ed8O5t3S2/4Rl/H3rAi9YZXu5cYa1y6kmBZ2HJc3Yz9?=
 =?us-ascii?Q?TXmuiJl0EAmQL8LZ5KvBVH6cj+TfVU/c/oZDeozo9Cz66UFCPDxvRZ/cAEOK?=
 =?us-ascii?Q?IigVq/mpiHp2nbCuunLNGgeDKx/eE/m3t2J6kV4wveXp2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b926a4e-6c7b-4695-4c68-08d90ff2c412
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 18:22:39.6974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOOundYAw9uJUUif3CPbHEm+Y7ca1OZVHEI2OqTATOFA7cQ9uUubdPQiaHUzw1UN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3079
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 008xgj2CO2ARgav_rAENDNmHiVRp6i_S
X-Proofpoint-GUID: 008xgj2CO2ARgav_rAENDNmHiVRp6i_S
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 02:11:52PM -0400, Waiman Long wrote:
> On 5/5/21 1:30 PM, Roman Gushchin wrote:
> > On Wed, May 05, 2021 at 11:46:13AM -0400, Waiman Long wrote:
> > > There are currently two problems in the way the objcg pointer array
> > > (memcg_data) in the page structure is being allocated and freed.
> > > 
> > > On its allocation, it is possible that the allocated objcg pointer
> > > array comes from the same slab that requires memory accounting. If this
> > > happens, the slab will never become empty again as there is at least
> > > one object left (the obj_cgroup array) in the slab.
> > > 
> > > When it is freed, the objcg pointer array object may be the last one
> > > in its slab and hence causes kfree() to be called again. With the
> > > right workload, the slab cache may be set up in a way that allows the
> > > recursive kfree() calling loop to nest deep enough to cause a kernel
> > > stack overflow and panic the system.
> > > 
> > > One way to solve this problem is to split the kmalloc-<n> caches
> > > (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
> > > (KMALLOC_NORMAL) caches for non-accounted objects only and a new set of
> > > kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
> > > the other caches can still allow a mix of accounted and non-accounted
> > > objects.
> > I agree that it's likely the best approach here. Thanks for discovering
> > and fixing the problem!
> > 
> > > With this change, all the objcg pointer array objects will come from
> > > KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> > > both the recursive kfree() problem and non-freeable slab problem are
> > > gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
> > > have mixed accounted and unaccounted objects, this will slightly reduce
> > > the number of objcg pointer arrays that need to be allocated and save
> > > a bit of memory.
> > Unfortunately the positive effect of this change will be likely
> > reversed by a lower utilization due to a larger number of caches.
> 
> That is also true, will mention that.

Thanks!

> 
> > 
> > Btw, I wonder if we also need a change in the slab caches merging procedure?
> > KMALLOC_NORMAL caches should not be merged with caches which can potentially
> > include accounted objects.
> 
> Thank for catching this omission.
> 
> I will take a look and modify the merging procedure in a new patch.
> Accounting is usually specified at kmem_cache_create() time. Though, I did
> find one instance of setting ACCOUNT flag in kmem_cache_alloc(), I will
> ignore this case and merge accounted, but unreclaimable caches to
> KMALLOC_CGROUP.

Vlastimil pointed out that it's not an actual problem, because kmalloc
caches are exempt from the merging. Please, add a comment about it into
the commit log/code. We might wanna relax this rule for kmalloc-cg-*, but
we can do it later.

> 
> > 
> > > The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
> > > KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
> > > will include the newly added caches without change.
> > > 
> > > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > ---
> > >   include/linux/slab.h | 42 ++++++++++++++++++++++++++++++++++--------
> > >   mm/slab_common.c     | 23 +++++++++++++++--------
> > >   2 files changed, 49 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > > index 0c97d788762c..f2d9ebc34f5c 100644
> > > --- a/include/linux/slab.h
> > > +++ b/include/linux/slab.h
> > > @@ -305,9 +305,16 @@ static inline void __check_heap_object(const void *ptr, unsigned long n,
> > >   /*
> > >    * Whenever changing this, take care of that kmalloc_type() and
> > >    * create_kmalloc_caches() still work as intended.
> > > + *
> > > + * KMALLOC_NORMAL is for non-accounted objects only whereas KMALLOC_CGROUP
> > > + * is for accounted objects only. All the other kmem caches can have both
> > > + * accounted and non-accounted objects.
> > >    */
> > >   enum kmalloc_cache_type {
> > >   	KMALLOC_NORMAL = 0,
> > > +#ifdef CONFIG_MEMCG_KMEM
> > > +	KMALLOC_CGROUP,
> > > +#endif
> > >   	KMALLOC_RECLAIM,
> > >   #ifdef CONFIG_ZONE_DMA
> > >   	KMALLOC_DMA,
> > > @@ -315,28 +322,47 @@ enum kmalloc_cache_type {
> > >   	NR_KMALLOC_TYPES
> > >   };
> > > +#ifndef CONFIG_MEMCG_KMEM
> > > +#define KMALLOC_CGROUP	KMALLOC_NORMAL
> > > +#endif
> > > +#ifndef CONFIG_ZONE_DMA
> > > +#define KMALLOC_DMA	KMALLOC_NORMAL
> > > +#endif
> > > +
> > >   #ifndef CONFIG_SLOB
> > >   extern struct kmem_cache *
> > >   kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
> > > +/*
> > > + * Define gfp bits that should not be set for KMALLOC_NORMAL.
> > > + */
> > > +#define KMALLOC_NOT_NORMAL_BITS					\
> > > +	(__GFP_RECLAIMABLE |					\
> > > +	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
> > > +	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
> > > +
> > >   static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
> > >   {
> > > -#ifdef CONFIG_ZONE_DMA
> > >   	/*
> > >   	 * The most common case is KMALLOC_NORMAL, so test for it
> > >   	 * with a single branch for both flags.
> > >   	 */
> > > -	if (likely((flags & (__GFP_DMA | __GFP_RECLAIMABLE)) == 0))
> > > +	if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
> > >   		return KMALLOC_NORMAL;
> > Likely KMALLOC_CGROUP is also very popular, so maybe we want to change the
> > optimization here a bit.
> 
> I doubt this optimization is really noticeable and whether KMALLOC_CGROUP is
> really popular will depend on the workloads. I am not planning to spend
> additional time to micro-optimize this part of the code.

Ok.

Thanks!
