Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59588485F46
	for <lists+cgroups@lfdr.de>; Thu,  6 Jan 2022 04:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiAFDgs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jan 2022 22:36:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43842 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230214AbiAFDgs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jan 2022 22:36:48 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 205N5BSb009985;
        Wed, 5 Jan 2022 19:36:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=qkz1Pv8C1y2G22lxSfzpVfLn7dnQsSOXhRwupD3WzTM=;
 b=dgLFAaQDZTMboX8tCExR/SlvVETZu7Aj07LA9RVfgXwRW8qMl6MLpZoixzjlk5lXfttU
 GNVS3ZRM7HOQnQcTLB6ZbKqXLKDBLvVu19ehCiJhLHmYjzJYkpPGS7du86oD9BwA2dT9
 EFjnvr5Ze7lTVfqTM4pFmHHXZzmNn5uAKIw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ddmpgh3fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 Jan 2022 19:36:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 19:36:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL4ehH79qWlXSWyjoSh1fLYRiRuunkp52ESISj1KAKwlMClMu2z+4BX/nKEvicsxrk9rZ/CoIOspsmVH18HU+5zZif0ip8aQ3b7AV+Gn6mP5bNrSHFu5h+E/JNcGR7kd+UVjBXL0gsumTDkqwxiNQWHDLJAOGiKu9rE6MiUrifRp3rmPjWgOKQXw/HC1MhhQ/a869lWrmLt6aLWKCsSGSEaD3h/hL/2eHIEMv727anlTqwXtjfaBohkxykcrhR4qRoP6RihkLL71xkYUeabbNXDqMIB/wMJBTDUbQi7KPupgs8gnkn2rYYgYZuCXCo+5yOf5CKTsLOegXOPgQ2yvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkz1Pv8C1y2G22lxSfzpVfLn7dnQsSOXhRwupD3WzTM=;
 b=ZrbiVFT3uMJbsaYHgCFJawOfgpYFsqmdpFU8t6vCqWDGA0oucVerjW+XitLVG60p+FKXXhq5soaD9ZZRFO6hAGKAeOLm0KdrfoleBgHiNlZDp4jd+8TsNEZmNKWIdIGvUE4mhf9LC3HMxk4ab5KAhOdB2zd3Ace3vBu/FZs3ZyRfJyoocn67eF55VxjWOivMYr97ApJZNRh3ftO83Ml02NxOKRqzOmWoUk4fTWFNn1aVpAnT6j7h3HRu64liPtohlhpzzb1eJwoKRANAqY6vDDGw4dgCGKkkXDUQ8e3+QlQuvSzeu31dAblGXHyuGFvK0rgfdV0a08v7gSGsAS/YoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4963.namprd15.prod.outlook.com (2603:10b6:a03:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 03:36:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 03:36:14 +0000
Date:   Wed, 5 Jan 2022 19:36:10 -0800
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
Message-ID: <YdZjqhGqVH38WJIw@carbon.dhcp.thefacebook.com>
References: <20220104001046.12263-1-vbabka@suse.cz>
 <20220104001046.12263-24-vbabka@suse.cz>
 <YdUFXUbeYGdFbVbq@carbon.dhcp.thefacebook.com>
 <56c7a92b-f830-93dd-3fd0-4b6f1eb723ef@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <56c7a92b-f830-93dd-3fd0-4b6f1eb723ef@suse.cz>
X-ClientProxiedBy: CO2PR18CA0057.namprd18.prod.outlook.com
 (2603:10b6:104:2::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80e06752-780a-49e3-c825-08d9d0c5b0a4
X-MS-TrafficTypeDiagnostic: BY3PR15MB4963:EE_
X-Microsoft-Antispam-PRVS: <BY3PR15MB4963065A9E9579808C8218EDBE4C9@BY3PR15MB4963.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vo9Dr8pdvY5DP6R0kaNOYkxHwi0smJRBIUzAAUN0aeYh5hpMsBvI9iAMAgL7cXGjXoQMiRTmkc+kXVC8zKgcYTrylG2ksxQdNn0TVlEOHqSdQ2hyNYNKnL7Va1ilDYecGFq5lQSOJKCGfp0iEoJav//a1YRrKSOtJbtSP07TdEDOzWFBn0CT5E5ZTZbRJUizYT3mG3ZPgkDroZOO8fT7CaDR9QjzHUE52ZympHbNX0M22SNC22t9bqjeqz/AAS5yZOf1e3iwtPaeATTOaQmvEWWBMoFXKT49QtkYwyr/bJxJx0BBhO8hnixDH+NWm9tdBTJwpcn6vkU1x4Efzq1oco6OaDfMjtkbWU9onDeYRWYjWW4NO6USffZXkn/oAgvXblnoA4qX7SS53/x5wnIZyIinqU/Jl9hJSeHrXX9hSFpiHiUGpzVoThOcex+lyL3CvoV9ykburKG/1Wy6Lxu4FGWHXAgLx4K/U1US7JC+z0xUbY7Y2pSMyacFbq/7PZpXdoMsyEyqRmtKjctsr2a95iVUvzfsiEtbuXqUtbriRsBcUR62zHFftVhVVO2dz0wMXSfiGR1Mui7KfkjBjZwwZzLAuU1i6d32iY1usYgcY7W7lKL13sINslbGaYKIfj/fU0N8sAvpF+ZN5yli9pAk0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(6916009)(6666004)(38100700002)(54906003)(508600001)(5660300002)(86362001)(52116002)(9686003)(6512007)(4326008)(7416002)(53546011)(83380400001)(8676002)(6506007)(2906002)(66476007)(66556008)(6486002)(186003)(8936002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X01/EPx43hUFRI4EbrTRCzLh6BUq58t7YBKKUxK9gQUPS10HKf/yJtxCK0/r?=
 =?us-ascii?Q?1PzgSD2nFD5B+4LguSaI14LP082SAO8ss8K89o8gcoEXC2zgX5A41AGMskXn?=
 =?us-ascii?Q?pGy/rn5xKUUYuyZRcyAwimNwLQ0gYLu9bDIU1zXexiCOmqcQmp+7c6+3kV6+?=
 =?us-ascii?Q?A1TB8M+YCrhUCCy8/9QpciEagUlkiORMdaqZkiMozOT9wme1T3Xh4iy/U0Qk?=
 =?us-ascii?Q?gNn8t4e7SgNmS6I29En2GojTrjFBF4OHbx9/FEdPaZx0FPY3UsiT1JHJoMJn?=
 =?us-ascii?Q?AdHgbMjowsGoRIIzxIWyAGvLza1HjUtvFaVs+I0nVqaX4Y9l6JWtgqaTZrr5?=
 =?us-ascii?Q?VWjB/KzC9xmgWO8R8kV1od8n0BQlE+ogjSS6kh3BZxdo7A1Qjm93mAKJofrC?=
 =?us-ascii?Q?Ryo/pDNYg5+Eg383nmHkws6LiJ0rZS0axq0pTdpvbmNi6oJyRSyzaeKcuLeA?=
 =?us-ascii?Q?1n/fRcWZPcL82DPYrIMeV1g6R9+ZmU+fLEW2cIG24RFa04cKW263BoN9ibNT?=
 =?us-ascii?Q?vvyGgSZJlBiaG2DccJB8DhLRbLvHJOT4UTNYqVSuxnS+Y9u1NpMjAXFM7LVv?=
 =?us-ascii?Q?fC7GHqjXWvYRQUUPoadf+VYABcyGdsghjeVCXzvKVuQhL6jFADWQ+rMit0UP?=
 =?us-ascii?Q?GRXnPRc2tET71LiRCDC0vo5HuUhTwiUBk/3fp1AGGXmzcJtH4Azteow6duev?=
 =?us-ascii?Q?D2wqjyWSBKNzsLWJmGqwSNGIXkZGH+PRAj2kuIx7QDuzTWk5KfI+bOSkByov?=
 =?us-ascii?Q?n8YrZ+r7y4DNfCETKoQezuAHFzdjr0KiAaArjPvdwntbjSDd1GJsmCrVpVJw?=
 =?us-ascii?Q?OkN3NUSmCILvhkQyIa1Wir2QP+WHOPCtOF+ntgnxrdneAlOQ64CAhi0ZdNrX?=
 =?us-ascii?Q?eAWe1KqozTjcyJoTqO4mopUzvuuufk+CJXc8vvqIuZphtQf5ATx6UWPSuTVI?=
 =?us-ascii?Q?Anb/vFMfKbToTRJS0BYiRp+4fM/xd44r+6GFaMGf1L/JP4zf92OognmDMkxQ?=
 =?us-ascii?Q?Tyv6iAmgpAdmZO1MEwVmFvogihwlQ93Zw3j4GY86Wj9oU/aVoqhPwISI8bzY?=
 =?us-ascii?Q?vPhtCSftpGFPU45uo7z6oa3ypNKYPwyIkEU1FPr45q55ub2kHtbr0OpqmarM?=
 =?us-ascii?Q?yqJDDO9os0JDP6pLTJs06H81QbET57tYQCJSYnVVkOBziY4cc3nE9YdKb01a?=
 =?us-ascii?Q?gYmqgvYLuwhkADKewIyV/ieL2S/mc+nqGtE24b8WR9hYqdIp3vIfxm+SP1YD?=
 =?us-ascii?Q?L5VzC4m97bo1artM4kQFc3aNnZdPOHB89Lrz8NJ+WEzFGKXSiPfVeLtBYE76?=
 =?us-ascii?Q?h94amx6OqHI34b65RFZRgiWQXa5b56df2A6zAfcax8p15bpwwLQsM5Br9xBv?=
 =?us-ascii?Q?r64wFck1+s5pjxFVhhjoh2qb294VfNRhMGYX35CvtovNzVqhogNT2GU7RZtB?=
 =?us-ascii?Q?+omXKNB1IVn7hjVIABn4YOBv94oXH9fqVDDcF5eEkACXR6rNNXuyL0CDHmbu?=
 =?us-ascii?Q?wMDqkD57lc2MLGUA2qLtDNOIlUe5jc4hVszY9HASk/hpDnBd3d+XwuRxyzeV?=
 =?us-ascii?Q?jAePtKPLcx7saj+I2t9DmQMrIZe0SvAEXyt9DUIY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e06752-780a-49e3-c825-08d9d0c5b0a4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 03:36:14.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lC0bziaL8rXGw8RJvcBj8owuR8a+fkkWznpDaBl2ZUIIJ87ASbUv4DH2572/+pAz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4963
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: nxhyhWyzGDHa5HM0YjOssDyuSeODRN9T
X-Proofpoint-GUID: nxhyhWyzGDHa5HM0YjOssDyuSeODRN9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_01,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 05, 2022 at 06:08:45PM +0100, Vlastimil Babka wrote:
> On 1/5/22 03:41, Roman Gushchin wrote:
> > On Tue, Jan 04, 2022 at 01:10:37AM +0100, Vlastimil Babka wrote:
> >> page->memcg_data is used with MEMCG_DATA_OBJCGS flag only for slab pages
> >> so convert all the related infrastructure to struct slab. Also use
> >> struct folio instead of struct page when resolving object pointers.
> >> 
> >> This is not just mechanistic changing of types and names. Now in
> >> mem_cgroup_from_obj() we use folio_test_slab() to decide if we interpret
> >> the folio as a real slab instead of a large kmalloc, instead of relying
> >> on MEMCG_DATA_OBJCGS bit that used to be checked in page_objcgs_check().
> >> Similarly in memcg_slab_free_hook() where we can encounter
> >> kmalloc_large() pages (here the folio slab flag check is implied by
> >> virt_to_slab()). As a result, page_objcgs_check() can be dropped instead
> >> of converted.
> >> 
> >> To avoid include cycles, move the inline definition of slab_objcgs()
> >> from memcontrol.h to mm/slab.h.
> >> 
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >> Cc: Michal Hocko <mhocko@kernel.org>
> >> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> >> Cc: <cgroups@vger.kernel.org>
> >>  	/*
> >>  	 * Slab objects are accounted individually, not per-page.
> >>  	 * Memcg membership data for each individual object is saved in
> >>  	 * the page->obj_cgroups.
> >                ^^^^^^^^^^^^^^^^^
> > 	       slab->memcg_data
> 
> Good catch, fixed.
>  
> >>  	 */
> >> -	if (page_objcgs_check(page)) {
> >> -		struct obj_cgroup *objcg;
> >> +	if (folio_test_slab(folio)) {
> >> +		struct obj_cgroup **objcgs;
> >> +		struct slab *slab;
> >>  		unsigned int off;
> >>  
> >> -		off = obj_to_index(page->slab_cache, page_slab(page), p);
> >> -		objcg = page_objcgs(page)[off];
> >> -		if (objcg)
> >> -			return obj_cgroup_memcg(objcg);
> >> +		slab = folio_slab(folio);
> >> +		objcgs = slab_objcgs(slab);
> >> +		if (!objcgs)
> >> +			return NULL;
> >> +
> >> +		off = obj_to_index(slab->slab_cache, slab, p);
> >> +		if (objcgs[off])
> >> +			return obj_cgroup_memcg(objcgs[off]);
> >>  
> >>  		return NULL;
> >>  	}
> > 
> > There is a comment below, which needs some changes:
> > 	/*
> > 	 * page_memcg_check() is used here, because page_has_obj_cgroups()
> > 	 * check above could fail because the object cgroups vector wasn't set
> > 	 * at that moment, but it can be set concurrently.
> > 	 * page_memcg_check(page) will guarantee that a proper memory
> > 	 * cgroup pointer or NULL will be returned.
> > 	 */
> > 
> > In reality the folio's slab flag can be cleared before releasing the objcgs \
> > vector. It seems that there is no such possibility at setting the flag,
> > it's always set before allocating and assigning the objcg vector.
> 
> You're right. I'm changing it to:
> 
>          * page_memcg_check() is used here, because in theory we can encounter
>          * a folio where the slab flag has been cleared already, but
>          * slab->memcg_data has not been freed yet
>          * page_memcg_check(page) will guarantee that a proper memory
>          * cgroup pointer or NULL will be returned.
> 
> I wrote "in theory" because AFAICS it implies a race as we would have to be
> freeing a slab and at the same time query an object address. We probably
> could have used the non-check version, but at this point I don't want to
> make any functional changes besides these comment fixes.

Sounds good to me.

> 
> I assume your patch on top would cover it?

I tried to master it and remembered why we have this bit in place: there is
a /proc/kpagecgroup interface which just scans over pages and reads their
memcg data. It has zero control over the lifetime of pages, so it's prone
to all kinds of races with setting and clearing the slab flag. So it's
probably better to leave the MEMCG_DATA_OBJCGS bit in place.

> 
> >> @@ -2896,7 +2901,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
> >>  	 * page_memcg_check(page) will guarantee that a proper memory
> >>  	 * cgroup pointer or NULL will be returned.
> >>  	 */
> >> -	return page_memcg_check(page);
> >> +	return page_memcg_check(folio_page(folio, 0));
> >>  }
> >>  
> >>  __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> >> diff --git a/mm/slab.h b/mm/slab.h
> >> index bca9181e96d7..36e0022d8267 100644
> >> --- a/mm/slab.h
> >> +++ b/mm/slab.h
> >> @@ -412,15 +412,36 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
> >>  }
> >>  
> >>  #ifdef CONFIG_MEMCG_KMEM
> >> -int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
> >> -				 gfp_t gfp, bool new_page);
> >> +/*
> >> + * slab_objcgs - get the object cgroups vector associated with a slab
> >> + * @slab: a pointer to the slab struct
> >> + *
> >> + * Returns a pointer to the object cgroups vector associated with the slab,
> >> + * or NULL. This function assumes that the slab is known to have an
> >> + * associated object cgroups vector. It's not safe to call this function
> >> + * against slabs with underlying pages, which might have an associated memory
> >> + * cgroup: e.g.  kernel stack pages.
> > 
> > Hm, is it still true? I don't think so. It must be safe to call it for any
> > slab now.
> 
> Right, forgot to update after removing the _check variant.
> Changing to:
> 
>   * Returns a pointer to the object cgroups vector associated with the slab,
>   * or NULL if no such vector has been associated yet.

Perfect!

Thanks!
