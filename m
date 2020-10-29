Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2D029F2AA
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 18:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgJ2RKe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 13:10:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47696 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbgJ2RKe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 13:10:34 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09TH984x027353;
        Thu, 29 Oct 2020 10:10:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=APzs3PbGPrjNJb2CBBRZg3gOxaBp2qvf/TPBM3BJxtE=;
 b=mFHcE/Ganwj37eCh8LsANZiq12+Zi6jsuE7egjFBUUU0O9DPu5/U7/6VBDxVPUUjH1Ra
 kX+5rZkG3BFFKUjJDpZwzuqQUd9pnopvyAVCpzZARdVY6ktHvYdKa41P6yROo9EXqbXJ
 y1uWvYdBscLQTZ+W+xJKGMX5xyiC9rECgqg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34fuvbt6f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Oct 2020 10:10:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 29 Oct 2020 10:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD7GF7h83ggiZNO4vwTRfOjUnSksjQRS22I+NwA+Oc+r2gdbridTTORorFufwmz7ql9A4q8z4YGB+1Islxf/Zq9OrptoK12CfWjG0//Yw9owDzfbwhYCDOOU7+CEkHS2bGzzvd09IPFlzP8AE5pCHVdUchPB/XNouvk3Gucd9DUM5OR+jaT7Mh1RHp/9bsUuvoaSpoIJNhjuTLBD6Y/GUUaeZhiC5jA8yL70dBvWbPPLKyye+W/KhLcBHPZCeUSFx4Xm7iSDCbUHB452e3jH/Y6EQZuajUHNqUSXVmOGcDAr/+36NqFHfTBj85Ns6LzGosBtwM6IaQ/XEGwND6qAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APzs3PbGPrjNJb2CBBRZg3gOxaBp2qvf/TPBM3BJxtE=;
 b=OwnS1T0ml8v9o0A543qZpgrrm1XAGXw7RmMsCjyXoj/fUGEEzeYhnBrfrwZv3uTDmD5arAK+C864CPAhPLC8ZXd+lDmB9u2Y+mcLxWB/NAIYoUN+cId6d4nKBsG5eqMva6PtaIcBOxcLqjxa2dYpsx8I0EbAI4X0nd8hSb1ZOIAqzUb99Z7wlitzQ4CavHumEFg1i8goyvd6VbXrbRZbMGu3ddezzccMe9qdsZ/laICWfRjNY6dSznw0rldLECENfmOv6CpwnOLyAmHDvpBi0aFNGH89jOBKQDGZhGayCD1RnnyReuUba6lFpQzFtsKSq28vQ/qTTAfBg/xm5bNcDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APzs3PbGPrjNJb2CBBRZg3gOxaBp2qvf/TPBM3BJxtE=;
 b=k87AMIJbDtKr0USW0j7xOCtUVCgMXPDqmBOD99pWO3XL+AkPRG2mLBHEx/xdMs3Y5mTDgV9ykvQWDs6zvunh8I0DLMUTp3/69jCL7bEMWvI/H5u/L4GMUtRW7Z3IxEGssqdSQEnLCW89ozIQb4UOmEECz9BOdiuCkOs9/bx+Dm8=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2215.namprd15.prod.outlook.com (2603:10b6:a02:89::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 17:10:00 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 17:10:00 +0000
Date:   Thu, 29 Oct 2020 10:09:55 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, <esyr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>, <areber@redhat.com>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: memcg/slab: Fix return child memcg objcg for root
 memcg
Message-ID: <20201029170955.GI827280@carbon.dhcp.thefacebook.com>
References: <20201028035013.99711-1-songmuchun@bytedance.com>
 <CALvZod6p_y2fTEK5fzAL=JfPsguqYbttgWC4_GPc=rF1PsN6TQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6p_y2fTEK5fzAL=JfPsguqYbttgWC4_GPc=rF1PsN6TQ@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::4:cadf]
X-ClientProxiedBy: MWHPR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:300:6c::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:cadf) by MWHPR04CA0051.namprd04.prod.outlook.com (2603:10b6:300:6c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 17:09:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c442fdd4-7aa8-42c9-1b17-08d87c2d7837
X-MS-TrafficTypeDiagnostic: BYAPR15MB2215:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2215E1521EDA13DEF19B16B3BE140@BYAPR15MB2215.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TD90K+B8O6Qd0kVNg2wysnHMHH83n5s06mk3+xqNmvRKRXOBfymVbOM5un75dXd+J9qkorNt1DJ0PZGVZl+XP3h1fKjjDmNraDQcdHrOwbiYMfA/xZ2RyiAk6QW9K7w9BcRN6Nt+JUKQrlfDfp35XdfnE3XqMPdkGpp3J8gVX8873rTRqsqM1aQkMOfPw/VxCeSVzg4Xtkwd7jpmlvB1FhDy3lt16pmTMCEbsLgvEi4j+9mTRyPhCitti5wdU8Jo1PrUD6or6brxFGKJ9CVS54Z1NRCQSOZK5shNvWaKkDG1dRlvh/KvKYTetHlAYO1z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(478600001)(7696005)(66946007)(52116002)(66476007)(8676002)(316002)(66556008)(7416002)(1076003)(6666004)(54906003)(186003)(16526019)(53546011)(5660300002)(55016002)(9686003)(6506007)(2906002)(4326008)(6916009)(8936002)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bMpB2leJFlMm+PI+XwX3X+NIvp+Ze1A6hKLz8i3QIALl301zfqKRv9JPCzM1B/h6tUY5+0hMj/ZWKowBmPah9W6vRQxmRz/qrGoDCPQ42q3cIhM+E+joS3AXgfp7jyw+j5Qs7OuK9lxXlFFp17rlgYCPOqVYoYhMoOAjTznJlUQFWOLAQXFQxB7kfx/N1ztiSLG68qK3YFdinrioXyCkPv11tX7Zau89TEe3WOqs1jK1l007fy0Bf6ULWE1H7nOt6Pw3fqYkcn9e54kToI7wLyTxXUSQJZ50BbxIKRCljVgDaRzbtkSR9hXtpoHuYquAFJLePM1no5ZnbdL9ttHHX3C64ryoOBMSdhsnC6I4GgyMfqP0CX/nrVeuFvVR5TwUMKa9WaXrkndIXQR7ba9vJxEmHZTL4SoyWE4xk9rD4OI3fX+zQEcim7nWYJpHC/WJdAZod/5rRNsngYqoPV4zv0Tt+qOKrq5JymhLC7CmxTsGcLquK6pV4ETmK9q1PKK9Z9hl0KM9N/HTWdtiml4OfYH11vYaMno7cht8F4GX9WFLUke/IK+42hZeTlM3a4vMYwh7jF+76HkWaT9wAfv3g5KNYhOLuCRw+mFCdigcdIz1wH8DTBIBCTRKALzCr8M+2XXQm66i2/M00KqyebmtSuDScohJUqSR3etSywmsUTQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: c442fdd4-7aa8-42c9-1b17-08d87c2d7837
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 17:10:00.7073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4QCob6BDAebqvAJLhgcFfEqOWCC4OHJruiuK0Q6PRY3Okcl6FmdeM6b25fxQq1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2215
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_11:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 phishscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 suspectscore=1 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 08:48:45AM -0700, Shakeel Butt wrote:
> On Tue, Oct 27, 2020 at 8:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > Consider the following memcg hierarchy.
> >
> >                     root
> >                    /    \
> >                   A      B
> >
> > If we get the objcg of memcg A failed,
> 
> Please fix the above statement.
> 
> > the get_obj_cgroup_from_current
> > can return the wrong objcg for the root memcg.
> >
> > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  changelog in v2:
> >  1. Do not use a comparison with the root_mem_cgroup
> >
> >  mm/memcontrol.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 1337775b04f3..8c8b4c3ed5a0 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2961,6 +2961,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> >                 objcg = rcu_dereference(memcg->objcg);
> >                 if (objcg && obj_cgroup_tryget(objcg))
> >                         break;
> > +               objcg = NULL;
> 
> Roman, in your cleanup, are you planning to have objcg for root memcg as well?

Yes. I'll just change the for loop to include the root_mem_cgroup.

Thanks!
