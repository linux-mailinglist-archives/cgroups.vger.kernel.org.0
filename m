Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D615B35CFF6
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbhDLSFK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 14:05:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42546 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240038AbhDLSFJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 14:05:09 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CHtX99021452;
        Mon, 12 Apr 2021 11:04:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=qqI7N24HUX5ohgKmw7HhuJ5MNrTolSVeGjFK5bsYqPA=;
 b=RUj2lalByc3R/1uL4Woo8LRKGLvztrS6dOfywzAtCDMltu7yvIVVT6dwUyrmj6KfDO4y
 eV+iDlv5dO4+15tWPf+e2GdyJ8v+0yhrFSbljVU/LDBmbZ221X9UsrBP2N762wrrH+O+
 RLLP2+I/MDmDGlhgiKd70OTfuOOdtVrRGxI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37vtxx02sv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 11:04:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 11:04:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4P+H8Duaoozj6J1cf4JcEvGyYl1o2d+bDg7LlMd9lOTZgUgqx+b8iRVpfwwbKNtsPv3GD39J1uz2bu2CfaE21A7fJTzQCYzpGO5x2gPz3TgK+Ds67TkSHp5wdJn+H787vOLne4upkI6Bv9cz+5ZPWj4nqHgffpMkv4T8gE1Ni+7gdfvzAtcUfayFjLIa6AMCFt22IhafwOgTbfr+3kYU+K9KAGCqHlRqUorPOHZi62keKbvSJLSsMum0HPfh5y/7ynTcQerptcMryhIfKVLJ6XD3TA/fhb0jtxIdhohVWoRerxkpPbfPf17V3PTvKAygwVQTEiKAPoNVi3Zo7bAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqI7N24HUX5ohgKmw7HhuJ5MNrTolSVeGjFK5bsYqPA=;
 b=lm+OU8Zc4gnHB1tB+8L5mBo0nPkN+GHmedXY4eU64D6prE+b1XGt45jEpR0k/97ED/ZkdrDGycKJOUKS8+SCeEJ5saqru5lTC9corOGQKba7khg2YA+XSNlwt0Pz9dlt+Dle9ykihISSCC0Gy6/4CpOzL6oPOjO1yUZL2xK3lNJdjETXRqEzQrgsrqmPKbyBNGc0M3owImilwx3uZWnaIuCjO4bCHFLujMY3+zti9FoXP4dM/hXBW5zn3Dy+Csi3J44QG0g+Bf3FMgo1OJVh94LoQH6hpqNRpfHy3QgkUpP4iRqsxh7Le18uidPeClCLrwigjmok70kITkFNj0j2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3652.namprd15.prod.outlook.com (2603:10b6:a03:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 18:04:29 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:04:29 +0000
Date:   Mon, 12 Apr 2021 11:04:23 -0700
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
Subject: Re: [PATCH 1/5] mm/memcg: Pass both memcg and lruvec to
 mod_memcg_lruvec_state()
Message-ID: <YHSLp8bTQGovNLTu@carbon.dhcp.thefacebook.com>
References: <20210409231842.8840-1-longman@redhat.com>
 <20210409231842.8840-2-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210409231842.8840-2-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:ea4e]
X-ClientProxiedBy: MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ea4e) by MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 18:04:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ec191be-01af-4d76-8bce-08d8fddd6ac6
X-MS-TrafficTypeDiagnostic: BY5PR15MB3652:
X-Microsoft-Antispam-PRVS: <BY5PR15MB36528E6A88562C173415CBB3BE709@BY5PR15MB3652.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4rDX2HH2Lc4GpW/h/rP2c2/CJdTbKl5bTWn4fu9mEg33rRot41DajoLM4WR5y3jeLfvw5nyr8faAb1rkXtmD3c+qyR8nzFNrq3RzaeWsJebpqmyryuYvY6srATfOU+3ZMd9CgKD2ChGewvm1j5Y243XGQPjpavz4fH76TKRMFSqJCSiJ3ecCx/6zTzs98ANDarrnwCzrnTGrv8SF05wxQxSr5IP9nXwJd468ruIgZ3BzvvCFwK2StuhriKADgzkeKXUHlQYubgOM9QGG9rXdAsuEROg7blwuf2Zv8s1LE6vqwgvKg3GFPNmJawyNpRmBKB9d13Fu998fl37F58swL8nznueSxGngGK3ue32nusETkMRXvUoQOv0KXtseVbFeGvOGvs/gya5N5l0R8Qog1k8Vw3PM6cdu3dzdbTrsMBFvRy/Iib2iz4hDXg8I2NTXe7rsy3QigERLSb+t80o55P5eSACeSoQ7knvk8WJSEC8z3l6O1Sca/VD5H5FDBEQC84/T7XcVXOFbulA0ejWUtoN0Qyy7YXRdZd0vonC/6wAs2OYRGtaFqOjdY8x0brhaSw9ZJr12xS756GGy6ECO9XVeKk8shxX5pTBu4ifaLy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(39860400002)(366004)(376002)(6506007)(8936002)(316002)(66946007)(66476007)(83380400001)(186003)(2906002)(38100700002)(7416002)(55016002)(7696005)(66556008)(4326008)(478600001)(9686003)(6666004)(86362001)(6916009)(16526019)(54906003)(8676002)(52116002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iIKkw9aMGqiSiI+nnCOumIlgnJNZaPHkRjM1vv8+k1oBGSOy8xLTJporGZWC?=
 =?us-ascii?Q?qFAG1VSOezgCjBwCXIGg75yYTrcsAe1RideeZO9hcURsHaNhRDMUcIQzvoeB?=
 =?us-ascii?Q?y4gFvjTd3jnidsv/tMFHb1ufsiR6eEZIsV094iy4zvWUZ70oKgddmtKlJiiN?=
 =?us-ascii?Q?joeMc/SzoYBT/Ea53rr2Ays0MZj9O4CYpOvc2QhhJT8qpKanSDZgQouAuPi2?=
 =?us-ascii?Q?UtFoYubt8ahDxh11De5wLE97cLspOBOFGzDLROFWNu6IktMPre/ZKMePyCIK?=
 =?us-ascii?Q?F9aj7XTl0azibNXy/rIDqUtO12JT0I781gO4ewlvFhGQkw1tuTLxdiVEXrjm?=
 =?us-ascii?Q?82whXa16QaNx776u0DlWinY5tku/HyEhwz6tvRhftlfLPFPBHtDBVRVhbstV?=
 =?us-ascii?Q?q8fLIJDxUcRFmJvQs/fr7cYU0VKXeC44zzBYuSndprgfmeOrBXpyiQi51vk7?=
 =?us-ascii?Q?YqmnQgoQaMmuThUtiit1VF+xnD6x/50KN0fIa/0wgbd6gi/sqLfyXfzNBJB7?=
 =?us-ascii?Q?f4Kt/ImsFQsAX5jRG6UJdSr3R5KqGnwgTTl3dR9pfJweUixM0M+EFJStWchq?=
 =?us-ascii?Q?khegHO8Qrf0jhthEgzVrRn+snZOEc3De5D1RubTKGkabfvqBzesHLx/K/yzz?=
 =?us-ascii?Q?nZRrO5WQBqq/iElsLIyjVNmxuuUYemPOCFow7r8IZNpFkBTipQHEQTEkcWBV?=
 =?us-ascii?Q?89i1UO56mkRvIjtyz7nmpOL6bfBHSLr8KjiQ8o9Gi9mWIoP6QGhiRLwJP2x9?=
 =?us-ascii?Q?8LNFObCHOilkJ4xr7VY8fkD8MxzD8zMcaNLxhK+zk5jPPWnI35vwRLQhBIXS?=
 =?us-ascii?Q?zgXPPo9p8YpX+KQZUUL/npo+pGNUGxIqXdv8XKASluKUnhfzA0eskfRKztKY?=
 =?us-ascii?Q?NJGE9j44u4EkLFLpd0anbdkZidsVsuduaRNVrust8ZkVA7iSvcy+88Jo4AhI?=
 =?us-ascii?Q?k7jDo4uEOWlE6QXoH1Rc2gZ3EBbDF7RDc31f6NbAnjlqBjqfpwzHcb2Xt8t2?=
 =?us-ascii?Q?anLcKri/dzf9ovvzVdimFy2bQl9bE7LFmQ0H7M4CHyOGdVaDSPhSbkHhWi27?=
 =?us-ascii?Q?nJm1wMwonQ6EbuM40Rydwb4196w1TNxk+EOa9cy0oR+4tKkhskRFBxlZ6LeU?=
 =?us-ascii?Q?m1P0LbhQx3xYwRX4XUFsmlUncSMb3n7Q0bAP0e9BrKRVyrQvI3kWBen6bz1R?=
 =?us-ascii?Q?rYgMbXo5eHrhYoiPdm/slwE/wZcpqI1AAgKmZ/syapFHRvi5dfqU7KFTB9bi?=
 =?us-ascii?Q?E1ah0rwuFPUFkT45iCnlHhfWQrd2S0G3RjJnYb4rgxQa+PdMASsizKmhl7EZ?=
 =?us-ascii?Q?JAScKXOEaMClxA/2nxXDUCpSvU7RoXyx0epR6EfkzehOqQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec191be-01af-4d76-8bce-08d8fddd6ac6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:04:29.6550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7CNYftwt2rn7Ii1U4/KqZKngTeDLbJuE2a7Ti2ojTQPlQnvF/yBu2ZC5S5sN1Fs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3652
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: vdIs-iDkXsT5mRt56kVboF6DBRe3tBGw
X-Proofpoint-ORIG-GUID: vdIs-iDkXsT5mRt56kVboF6DBRe3tBGw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 09, 2021 at 07:18:38PM -0400, Waiman Long wrote:
> The caller of mod_memcg_lruvec_state() has both memcg and lruvec readily
> available. So both of them are now passed to mod_memcg_lruvec_state()
> and __mod_memcg_lruvec_state(). The __mod_memcg_lruvec_state() is
> updated to allow either of the two parameters to be set to null. This
> makes mod_memcg_lruvec_state() equivalent to mod_memcg_state() if lruvec
> is null.

This patch seems to be correct, but it's a bit hard to understand why
it's required without looking into the rest of the series. Can you, please,
add a couple of words about it? E.g. we need it to handle stats which do not
exist on the lruvec level...

Otherwise,
Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/memcontrol.h | 12 +++++++-----
>  mm/memcontrol.c            | 19 +++++++++++++------
>  mm/slab.h                  |  2 +-
>  3 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c04d39a7967..95f12996e66c 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -955,8 +955,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  	return x;
>  }
>  
> -void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> -			      int val);
> +void __mod_memcg_lruvec_state(struct mem_cgroup *memcg, struct lruvec *lruvec,
> +			      enum node_stat_item idx, int val);
>  void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
>  
>  static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
> @@ -969,13 +969,14 @@ static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
>  	local_irq_restore(flags);
>  }
>  
> -static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
> +static inline void mod_memcg_lruvec_state(struct mem_cgroup *memcg,
> +					  struct lruvec *lruvec,
>  					  enum node_stat_item idx, int val)
>  {
>  	unsigned long flags;
>  
>  	local_irq_save(flags);
> -	__mod_memcg_lruvec_state(lruvec, idx, val);
> +	__mod_memcg_lruvec_state(memcg, lruvec, idx, val);
>  	local_irq_restore(flags);
>  }
>  
> @@ -1369,7 +1370,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  	return node_page_state(lruvec_pgdat(lruvec), idx);
>  }
>  
> -static inline void __mod_memcg_lruvec_state(struct lruvec *lruvec,
> +static inline void __mod_memcg_lruvec_state(struct mem_cgroup *memcg,
> +					    struct lruvec *lruvec,
>  					    enum node_stat_item idx, int val)
>  {
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e064ac0d850a..d66e1e38f8ac 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -799,20 +799,27 @@ parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
>  	return mem_cgroup_nodeinfo(parent, nid);
>  }
>  
> -void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> -			      int val)
> +/*
> + * Either one of memcg or lruvec can be NULL, but not both.
> + */
> +void __mod_memcg_lruvec_state(struct mem_cgroup *memcg, struct lruvec *lruvec,
> +			      enum node_stat_item idx, int val)
>  {
>  	struct mem_cgroup_per_node *pn;
> -	struct mem_cgroup *memcg;
>  	long x, threshold = MEMCG_CHARGE_BATCH;
>  
> +	/* Update lruvec */
>  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	memcg = pn->memcg;
> +
> +	if (!memcg)
> +		memcg = pn->memcg;
>  
>  	/* Update memcg */
>  	__mod_memcg_state(memcg, idx, val);
>  
> -	/* Update lruvec */
> +	if (!lruvec)
> +		return;
> +
>  	__this_cpu_add(pn->lruvec_stat_local->count[idx], val);
>  
>  	if (vmstat_item_in_bytes(idx))
> @@ -848,7 +855,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  
>  	/* Update memcg and lruvec */
>  	if (!mem_cgroup_disabled())
> -		__mod_memcg_lruvec_state(lruvec, idx, val);
> +		__mod_memcg_lruvec_state(NULL, lruvec, idx, val);
>  }
>  
>  void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
> diff --git a/mm/slab.h b/mm/slab.h
> index 076582f58f68..bc6c7545e487 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -293,7 +293,7 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
>  	rcu_read_lock();
>  	memcg = obj_cgroup_memcg(objcg);
>  	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -	mod_memcg_lruvec_state(lruvec, idx, nr);
> +	mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
>  	rcu_read_unlock();
>  }
>  
> -- 
> 2.18.1
> 
