Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64441368AD2
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 04:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhDWB55 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 21:57:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8990 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237088AbhDWB54 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 21:57:56 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13N1m6TF015454;
        Thu, 22 Apr 2021 18:56:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=4XHr0zD6cArN5l8J0lV8Oq2yK8tUh6/HTXH2emLrluk=;
 b=SpgfHJ8QkBkbiyUPA6CYz28gvOGDxHoCyK3QVmZgqZs0wwh/8owmUiTiMXdHzxEPlvqu
 3BIFVWNCeFj5dZZTHz4OmrmRPXJipnYht7VStKvWaKy98eVEO5kvZBt5gCF+gUSnl7rt
 bEVnvRR++aWoxuNZN2O1hH13J3pWM53cqYc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 383kvngc8d-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Apr 2021 18:56:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Apr 2021 18:56:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eModfoyNZIzq2mU8TpRJe3L1rtq9CRTBd3NKtiIA2YeNSsXwjPnTEyZFo4G+lwI39fQ5UmcZhLBobh2NR/lycG7uBU7I2NNmbUbAXkC4+3JJiSOGOTrZTa9fasriIZFj00gtZyKjV9FjAXBVDiGxym5BmucF5VpXBWBX+ZCU3cf79SNoEeiYI4trUIMthp+YTp0bTGE2yvvMqD/f4oTkyeqfkc3Z4O+5ot/FIywXnR+z0SWwJkTL367UdGG7oo5+qB96aaXZJswOhd3cCnmKLxO+pJEVhCWBfDCcyhbvnrcRNIQC1LgGay7fTd/mZ3ilxJRiSFfZ+Sl27Wc/ld+/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XHr0zD6cArN5l8J0lV8Oq2yK8tUh6/HTXH2emLrluk=;
 b=f66GnS+6tpOZANbWtc3Bxa5ts8JlqILw1e3fvELggyKPrLyOtCW1vp/MmYRRp/7lM8htLX5cCjOeL0smr99pFK58fVIXEJM0/6jl9CPVTDoG4ZJreItpGlLuqkT2qWivdx45N5S728uIrsadhz+xwaKv0qIhovJVpHvkcWD8cqhcSBJ9sL7/peeE6Bm0Ah+2ZGvusrPwQc+5ejH1b4Rytjc98cssCq7J+bxgmI66LC4pjK9CL6zuffDU81UUd+GPvtmfnkIuQF0oXENEgRCsm0zJFrRc4RlnAwfWqI2n++w0T9M6x2vCY/mb22ioC9eNICqSjnbeoq/KWQ3DqnAFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3222.namprd15.prod.outlook.com (2603:10b6:a03:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 23 Apr
 2021 01:56:37 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.026; Fri, 23 Apr 2021
 01:56:31 +0000
Date:   Thu, 22 Apr 2021 18:56:26 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <llong@redhat.com>
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
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH-next v5 2/4] mm/memcg: Cache vmstat data in percpu
 memcg_stock_pcp
Message-ID: <YIIpSvs09GhDN+gb@carbon>
References: <20210420192907.30880-1-longman@redhat.com>
 <20210420192907.30880-3-longman@redhat.com>
 <YIC1HEKF8SQQdnxa@carbon.dhcp.thefacebook.com>
 <ded96eba-8c0c-1822-61b5-de0577b7ebab@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ded96eba-8c0c-1822-61b5-de0577b7ebab@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:1afb]
X-ClientProxiedBy: MW3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:303:2b::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon (2620:10d:c090:400::5:1afb) by MW3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:303:2b::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Fri, 23 Apr 2021 01:56:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8f1d26c-0e60-4df5-39bc-08d905fb03f9
X-MS-TrafficTypeDiagnostic: BYAPR15MB3222:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3222FC1C0D33AF0CCD5A1E00BE459@BYAPR15MB3222.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bK+sM6YvfsNhENS4r3vZngNqs9Ay6glrP3t6Beb/O12fJJBCfg6OnOOzQixLavLg98H4M2bN9i9sgXEqhA723D8eml+++OA1Mh+vxMVAaSUHDWuMW/xAlbIwv3zEXPba9Gf7timKKAwmNRmbDyU1a6o6pz3Sui0/bRx7MtpAQolAEwwvS8fNvq/ipA66GJIllUc7RirqFpjkqSWhGspEAkmi+EbgEeLWZp7kRx0d/PhwIsVNneftcPapsO2MYqxyAlvZG4agx7m7aJQbnmyI0muDb9jQcoK9YfES8+m8OH3WFBd9xjra8LqzDFKiY0yTcNYLkvL+Eo0aBqaO61BcOsI9gfMrm6WI3CshG+JblMgDABqWdTdsN6uCr1iaQ6FIKf9xBCgfsxnPFQTMfk9XgkWOcqO/7JSzj271v1rKCNFY3EcvkpASZ45XshfPK/c+ULFOuRh+pE18e9j8+u17Gp1LaN+QS0KPom6MAQRpGquzCxYfTJQPvCBL1Bp59Iu6/gqL3Enk6LLpbADHWiyWencZ7QhJeDZ8h3ouqbV1C8v+bU4m1j4drfdgs3iwZK5Yikq4j0AM3lyADJY7sgAiXOno1W7vU3bz0asLMV3eLjfVlyoFp5yNbRJXzcXsXuHXrlDpMfKY5buU8img6IlEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(39860400002)(366004)(376002)(7416002)(52116002)(86362001)(16526019)(8676002)(6916009)(33716001)(83380400001)(9576002)(8936002)(478600001)(54906003)(53546011)(2906002)(4326008)(6666004)(316002)(6496006)(66556008)(38100700002)(66476007)(9686003)(66946007)(186003)(5660300002)(55016002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+28tsc+3716cszXW0WtBpwlh4Abwl0dHcx18o1avU662PhEUiVVYHrKGhJIq?=
 =?us-ascii?Q?uJl+WC81rtmhK5TEqQlmfc5rgiMj+TMEZt29g3qK/ZOhMnJtuxZ+nTFR8GKO?=
 =?us-ascii?Q?iNGBDOuv6t7W6YhpSj/j85H21lmA/3lO6orcuxa9yROq087YKu4tyN0d1I8J?=
 =?us-ascii?Q?+9JdU2StHQsUe8r7Hu3dueHyjPBzCdJFORi1rzNCZ3O3WdU529xom4RexBlQ?=
 =?us-ascii?Q?rRwjpFNeBVnEy8VHQWxPcdXoN9BAWz2s5HAmki8QBUZ9dDw/8Jos7VJeKl5l?=
 =?us-ascii?Q?5lpU+dPETfHVN+Ytf2RpATZfc5DqQH+tY4Xz8jR+nB7VzODn/z9uZKf88Lzg?=
 =?us-ascii?Q?OPYp7dvQO+C1cQF/SmZ+BLlIZpRgxKiHBztOBPA2gCJBTC1iU8bytqhXaIrF?=
 =?us-ascii?Q?v5Vq4ERbX48j6RU/Ws3k06OJeX7vZsSOmmAtqsUDBrkX5KLr4aWBqhGeTPAG?=
 =?us-ascii?Q?+TVzSbTK/Nm6XSzTkpt+AqATDnZb7gOPValBxb6+0fmAGxYs9rS2aqMKYLX6?=
 =?us-ascii?Q?0S4foeLrlpW8CUmJmY2iMU+zDf9SO3g9oJvAOm3qXED6jMUe/8lRE+DZkgcT?=
 =?us-ascii?Q?oUrLEjgWNdot81dXtqcj66EdRlnRI/jbUCOUzdbfTMIAwIIAgQ6qu5tPDmmH?=
 =?us-ascii?Q?6kLQvvejv6uaoSREWO20+VYz/GdRRtt2Zk9d4QBNd0h+ESf8Y/IzkCMLN2EC?=
 =?us-ascii?Q?OX1pLWN520t9Jf5Rd4yDqke8kH0QZMbWcg0UsEskHG6UQy/zHDqzcGP6hiX0?=
 =?us-ascii?Q?3hf1g0DCRWVXAIvJW/XHrUDiQLt9emJKg7KrxJW4qXXPSHFHC2oTJyp3rZAA?=
 =?us-ascii?Q?AYY/aRx7VYmYh4M0CvrRH30A6ZSN5ESbdSlLPkGxLRwuUwLU7Vcc5ShanVtc?=
 =?us-ascii?Q?uOmnOgepWSgKpsdGyBM9mOBRlino0spJYPgin8s42UBqUzDncQzAT/8BEg33?=
 =?us-ascii?Q?GF+iw9cSZ8xtXguPgRevv5+jukj+5Ei6PQxBKVMXnv+Uo0KuSHrsSSzRLEwP?=
 =?us-ascii?Q?c1Y88Avvr9DYHF+JbOT0potzR6Cp+Q0yzUNR2ZAlXKXcwIFxVUZpR2QNCqux?=
 =?us-ascii?Q?aD1uyqyfM7wJ9UZpESXaHejCEk2gotfmX3AJxLz0pt2BzfFEeN/p19CDAA/b?=
 =?us-ascii?Q?SJLmZiCRCMna5msswveGT7zFZXfLupTiOauTYzj4MiU9CdIv++J5JmM7dKqN?=
 =?us-ascii?Q?a46P//r4Jkn9nzGT3g36+u/u+L6FKttTndeMAz6fnGm6qAi5rHxwVKyICLBe?=
 =?us-ascii?Q?hLdlNZM5DRPmsTzLxd337v5mzxAhalRJ+mYKf/Eg5tHNdfzXuG3gBcKw4XlE?=
 =?us-ascii?Q?4kOZuXs+i5dV2AE6d9TX5HxZGCxzTKoj28XOV0+nnjSKOw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f1d26c-0e60-4df5-39bc-08d905fb03f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 01:56:31.5098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOcVA13F3juESP9odTDNwRwYFUQbW5GmN6ilhOQ8ynmn+1N8R1ISKnnUksw0k1eT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3222
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 999hxS18wyE7uny_I6IqlKM83lYP9QaL
X-Proofpoint-ORIG-GUID: 999hxS18wyE7uny_I6IqlKM83lYP9QaL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_15:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104230010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 22, 2021 at 12:58:52PM -0400, Waiman Long wrote:
> On 4/21/21 7:28 PM, Roman Gushchin wrote:
> > On Tue, Apr 20, 2021 at 03:29:05PM -0400, Waiman Long wrote:
> > > Before the new slab memory controller with per object byte charging,
> > > charging and vmstat data update happen only when new slab pages are
> > > allocated or freed. Now they are done with every kmem_cache_alloc()
> > > and kmem_cache_free(). This causes additional overhead for workloads
> > > that generate a lot of alloc and free calls.
> > > 
> > > The memcg_stock_pcp is used to cache byte charge for a specific
> > > obj_cgroup to reduce that overhead. To further reducing it, this patch
> > > makes the vmstat data cached in the memcg_stock_pcp structure as well
> > > until it accumulates a page size worth of update or when other cached
> > > data change. Caching the vmstat data in the per-cpu stock eliminates two
> > > writes to non-hot cachelines for memcg specific as well as memcg-lruvecs
> > > specific vmstat data by a write to a hot local stock cacheline.
> > > 
> > > On a 2-socket Cascade Lake server with instrumentation enabled and this
> > > patch applied, it was found that about 20% (634400 out of 3243830)
> > > of the time when mod_objcg_state() is called leads to an actual call
> > > to __mod_objcg_state() after initial boot. When doing parallel kernel
> > > build, the figure was about 17% (24329265 out of 142512465). So caching
> > > the vmstat data reduces the number of calls to __mod_objcg_state()
> > > by more than 80%.
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > > ---
> > >   mm/memcontrol.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 83 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 7cd7187a017c..292b4783b1a7 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -782,8 +782,9 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
> > >   	rcu_read_unlock();
> > >   }
> > > -void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> > > -		     enum node_stat_item idx, int nr)
> > > +static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
> > > +				     struct pglist_data *pgdat,
> > > +				     enum node_stat_item idx, int nr)
> > >   {
> > >   	struct mem_cgroup *memcg;
> > >   	struct lruvec *lruvec;
> > > @@ -791,7 +792,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> > >   	rcu_read_lock();
> > >   	memcg = obj_cgroup_memcg(objcg);
> > >   	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > > -	mod_memcg_lruvec_state(lruvec, idx, nr);
> > > +	__mod_memcg_lruvec_state(lruvec, idx, nr);
> > >   	rcu_read_unlock();
> > >   }
> > > @@ -2059,7 +2060,10 @@ struct memcg_stock_pcp {
> > >   #ifdef CONFIG_MEMCG_KMEM
> > >   	struct obj_cgroup *cached_objcg;
> > > +	struct pglist_data *cached_pgdat;
> > I wonder if we want to have per-node counters instead?
> > That would complicate the initialization of pcp stocks a bit,
> > but might shave off some additional cpu time.
> > But we can do it later too.
> > 
> A per node counter will certainly complicate the code and reduce the
> performance benefit too.

Hm, why? We wouldn't need to flush the stock if the release happens
on some other cpu not matching the current pgdat.

> I got a pretty good hit rate of 80%+ with the
> current code on a 2-socket system. The hit rate will probably drop when
> there are more nodes. I will do some more investigation, but it will not be
> for this patchset.

Works for me!

Thanks!
