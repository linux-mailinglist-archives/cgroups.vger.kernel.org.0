Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F5329C853
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 20:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829369AbgJ0TGV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Oct 2020 15:06:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59534 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502289AbgJ0TGV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Oct 2020 15:06:21 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09RIsDXL012813;
        Tue, 27 Oct 2020 12:06:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0yVIa6zqsaXdlZ8tq9gri3+NMQxI8VO/iI2YTFptDRE=;
 b=D8+gdzfUcnHY09aCEHUaB895h3qFd9BBqbz547f8ymmsg7QSidtNfngXpkH3d8FVV73f
 CA/ZiRIRRkmgakRdz5brW/bjaF+5NcrkT3g/yb6ZE3BAOZQFvROHG5s9WjcbAWeYWDEi
 NTnMb32/xFJB8ds4NiEtQAMJwCMaChd12Uw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34ej3nat3q-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 12:05:59 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 27 Oct 2020 12:05:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L26SF0zu9/f4p3gISoMfzzFeNfM7A7Ul4sZPNS6JyN2uzbjZsOhhA/6E89m5s0IOgyWIGHnhlDwQNJ4IP6vhhvzPATUGCHvAmZdl5atVz8WezJ0p2oe269Fw3i2T3Mxqy7tDuiTn15KGVxgIsJB7OraRFSzmdkGbw30eUtu0WB8YsIAPGaEke/9icBQ/nVHMXhIsec2vqNPc6Ywa6of0g4va3PjUICfKGlqCtD9vW2WXea3rsz1XIpZRLjtGsz/iDAI/Nj6Rs7iqTwdLUpXqEIU2uvWQi4PFp5PDANaRSSsozix3xPN1ntTaKCf5Lm1eTw2w6rCzfxsBGDoKxLNK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yVIa6zqsaXdlZ8tq9gri3+NMQxI8VO/iI2YTFptDRE=;
 b=EN9z4C+0QGuHD5qOnR8tjgfax8nw7FPYgXJ9dma84XZZLa9sXlrr867wdl+Zt3npSD78zr1hvxCtlKA/IMbK3J7ytG1zvZV9XrYtik7zfmk6Bad2UZnpAo5NBtIHyPisv/3kcD9mYyOpPzHn2s6EJHC7KlbY5J34p4YM/iWw63iFP648VkTggZF+eDbm5IOhabMQ+Nd9nHnvww5xAnQXsHjHA8y3kgoNCBAq946twGPDE2yXXhdE0lWUDuwur/LR0q35m64BcpTpub+mI0wnFNM51w2/44q/REMLU6a3pLZpEEH/hX/OO4bQe/ay7d4glHEgL1cMZ+x5UJ+kG9ipPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yVIa6zqsaXdlZ8tq9gri3+NMQxI8VO/iI2YTFptDRE=;
 b=RKLe2omN7EdQLRWW+KGG18nXwq1Dk+UUfyUU/Jiq9j7yLmYiqa7EOwv0cM92mVg9PJmM23Tx2Co9Ow82/bTGhzukPacUsAcZ7grzziv1tMisXl3Cu+avZ7w/UtfhfuMVED1IT00BAu3ldhEIn16mG5FdtSxH7iBuDWLWiXLDDzk=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2278.namprd15.prod.outlook.com (2603:10b6:a02:8e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 19:05:55 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 19:05:54 +0000
Date:   Tue, 27 Oct 2020 12:05:49 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <iamjoonsoo.kim@lge.com>,
        <laoar.shao@gmail.com>, <chris@chrisdown.name>,
        <christian.brauner@ubuntu.com>, <peterz@infradead.org>,
        <mingo@kernel.org>, <keescook@chromium.org>, <tglx@linutronix.de>,
        <esyr@redhat.com>, <surenb@google.com>, <areber@redhat.com>,
        <elver@google.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 1/5] mm: memcg/slab: Fix return child memcg objcg for
 root memcg
Message-ID: <20201027190549.GC827280@carbon.dhcp.thefacebook.com>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-2-songmuchun@bytedance.com>
 <20201027174236.GB725724@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027174236.GB725724@carbon.dhcp.thefacebook.com>
X-Originating-IP: [2620:10d:c090:400::4:e2f0]
X-ClientProxiedBy: MWHPR18CA0064.namprd18.prod.outlook.com
 (2603:10b6:300:39::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:e2f0) by MWHPR18CA0064.namprd18.prod.outlook.com (2603:10b6:300:39::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24 via Frontend Transport; Tue, 27 Oct 2020 19:05:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e24510e-8a4c-48db-8191-08d87aab5442
X-MS-TrafficTypeDiagnostic: BYAPR15MB2278:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2278C9A2FD897BF2D29B61E7BE160@BYAPR15MB2278.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HautWl4pDRYafdJxSofpeGSU5zJJUp1qQgzdOIuNZP3/v+IGySpyfutYNl2kLvKIuQ5/ajX3jGXXJKL83ozwp/pcvebBcGIJAQauPtTJqCRsZBdOJRxp21vqwTBwljNs8win58CKjhWk2UHaT7aQJzdM/W18lTE2S2jjXiz14H9MWzkXbNpRZSwzckg1CPVnCNdxKHKQ4GClezjLJHIg8Ss8iNjIAmwF8H033IAhznZ56h+WR3GdbUqLJSkWykIZZEpnkiBuNOG8RCn+vkmEc1O3pHVckbPncjB47n4auMPJmhgZwuUbU35KGOw732ngodymWTFaPKxXw03ONSQBQ8YxErJkP+J2oQ4TkyHS7o56cSJ/wzTNOvBqmT9B1Z8/r7KMhD7HfBf2v3tiDIwFUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(366004)(376002)(346002)(396003)(8936002)(966005)(7416002)(478600001)(9686003)(6506007)(66946007)(5660300002)(6666004)(66556008)(316002)(66476007)(4326008)(6916009)(83380400001)(52116002)(33656002)(16526019)(186003)(1076003)(2906002)(86362001)(7696005)(8676002)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QMO92R4fJZxOr2ISLAIijCoep0W20HSNoHHGkDIxR50e+bbM7Z9jfuFI/V4hfhmsfjMw3Smt1Vccf9MXsZjb9iX6J8Nc5TLqWJ+TOAM3g8LwoSRYyMVbPbg418eSu8MbbFoxzcsrqxVYJBqI/JrYXDncqPbLDq8pHA6ecRaR3BZj3cxdCdN9AAFvo8eqRBtacnwOiu8oXHk6nCPKpkG8xNqcwkgZAAVtlg/gpRcPgDLqVpXsOdVHm5e3CneLUeFWqNu5MuZM8len0acIqxtoNI45nEQJ9rVzGPIr31QE9oA4dKXtxtdj5f8kGXZ4aQ7yKVJUCy6V2N/0XRBByiCgEZSKaazTkTvEP4inc6mmu3IkLw+23wPr1MHszYf78WmbUKNuQftfhEKWQWkDuMQbR9rqDtP4envx6jCLSUhPo6jvbgTwuSSj0ApxOrN0Nq2H6Yqmt79NeGIzgdtLq2erLzotK57diNmpFMb11dXF/sGprBv//mMYEv2BQGw4KfuJtmr5V+jo28mpd966CCTTLsfc5+qeXD/b4YJ7q8PncUnZWbJ5uC3VDptCxdWc/t9k54a0yx91h9l37cvaTD++6eGe6ay4q8K/jPoObp/FkYX0Uo1jNN3Zh2d6PUf88wL17CxjWStJRRpAFTq1B1AMk4LPKZMPdMfBhuQkizQ0ikA=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e24510e-8a4c-48db-8191-08d87aab5442
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 19:05:54.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daSaThPUabFNzzL1xXTzFVoIOxmhZRZacfeJPl/Qi4yshJ+ZOp19DVVTuEXNwe4h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2278
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_10:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 27, 2020 at 10:42:36AM -0700, Roman Gushchin wrote:
> On Tue, Oct 27, 2020 at 04:02:52PM +0800, Muchun Song wrote:
> > Consider the following memcg hierarchy.
> > 
> >                     root
> >                    /    \
> >                   A      B
> > 
> > If we get the objcg of memcg A failed, the get_obj_cgroup_from_current
> > can return the wrong objcg for the root memcg.
> > 
> > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/memcontrol.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Hi Muchun,
> 
> thank you for the patchset!
> 
> A generic note: it's usually not a good idea to group fixes with non-fixes
> in one patchset if fixes are planned to be backported to stable.
> 
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 1337775b04f3..fcbd79c5023e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2945,7 +2945,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
> >  
> >  __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> >  {
> > -	struct obj_cgroup *objcg = NULL;
> > +	struct obj_cgroup *objcg;
> >  	struct mem_cgroup *memcg;
> >  
> >  	if (memcg_kmem_bypass())
> > @@ -2964,6 +2964,9 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> >  	}
> >  	rcu_read_unlock();
> >  
> > +	if (memcg == root_mem_cgroup)
> > +		return NULL;
> > +
> >  	return objcg;
> >  }
> 
> I agree, it's a bug. Good catch, thanks!
> 
> I would prefer a slightly different fix though. Because we're going to change how
> the root memory cgroup is handled (an rfc version posted here:
> https://lkml.org/lkml/2020/10/21/612), it's better to not use a comparison
> with the root_mem_cgroup and handle the obj_cgroup_tryget() return code instead.
> Something like this:
> 
> @@ -2973,6 +2973,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>  		objcg = rcu_dereference(memcg->objcg);
>  		if (objcg && obj_cgroup_tryget(objcg))
>  			break;
> +		objcg = NULL;
>  	}
>  	rcu_read_unlock();
> 
> Or a more explicit:
>    if (obj_cgroup_tryget(objcg)) {
>      ...
>    } else {
>      ...
>    }
> 
> Also, please, add:
> Cc: stable@vger.kernel.org

After a second thought, it's also a highly theoretical race. In order to have
obj_cgroup_tryget() failed we need to enter get_obj_cgroup_from_current()
racing with cgroup offlining (which is already tricky) and then have
memcg_reparent_objcgs() finish in between reading memcg->objcg and bumping
the reference counter.

So I'm not sure we need a stable@ backport, sorry for the confusion.

Thanks!
