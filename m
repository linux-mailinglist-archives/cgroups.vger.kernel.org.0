Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D9629F6CB
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 22:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgJ2V02 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 17:26:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39348 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbgJ2V02 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 17:26:28 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09TLNYY7012391;
        Thu, 29 Oct 2020 14:26:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=NULL1jFkMVxKNQ8qfqLQp2HhKq8uLzw6n1P2kqs2Wvo=;
 b=giX/Zi4EvnlqtHWzqa6L7QIhLLUjwei8oZn8g8Gh/TYC0d0aEkq+fqWZvWP853uHZBoz
 ymhBifeEYM3iqJza3jalaV6c1c77nD5mKxhObk7k2PGfVIR0g6j5v2uDO96jGpwB4mFt
 18RjALoN8kh+JqYLUWP4t0RSde1RwzZLbEc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34f7pjj1b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Oct 2020 14:26:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 29 Oct 2020 14:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmEQdx+x7DDyKMmf0laZnQSGm+oYpToU6n6/MoNSIQNMiIGEz667Xu4s7F69oOh2Z7TnQu9QMl1LPQBhQ3l2j7rQdA8cin+s+tPoCqW+IV2MYM3tXt/fXxvbJRPOhi49P7qdw/hXrHjoWnJOhaJeAs88tT/cggNbbEPaZ2g0lFdCIWhxgcZbiDENTBWpzD/1fUOze+qF0W3+Wa8t3oR8GKa729NJb7QGkFXlQHb4I5VOa7GAyFOraji7mzFD2YU+g2r1YqYwKv60i+lURqH96lETU9h09qh0tEQ8dUkQ1kGeWszDI2BIi1BfujXkiHUylMm8MQltaz1meGIl0AzASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NULL1jFkMVxKNQ8qfqLQp2HhKq8uLzw6n1P2kqs2Wvo=;
 b=XCKtSSrAp8VtFw9deXmCGz85cqq6ZKaGY6sDAAL4BZVg8pKvaVgNB9EmYnV1OJE73sz8vvvONqB6/0491P+KAGXd2MNrlIlgAP1KKOExL/bP/HLRmLoZl/ccBLQJGsCMgYlYyafGNPLURW6S6usQfxrFasobBaz7J1KzuxI45mDdyY1RgrO6owEeVO7znRi3jXka5fmysjaT1zPLrLZql673ipdYtS8yF4dNgx0GuFg8z167mMjDfVFCu33H1XTEIvGQw5fPYUZO8OQjkpk2ceXjnhe1lK6zXXj0vYB9k0benb/Vgu4upa7h3r7Tx+UxxF7iGQD97s212MlSPJjuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NULL1jFkMVxKNQ8qfqLQp2HhKq8uLzw6n1P2kqs2Wvo=;
 b=f8k5m1UmmE69HjXaBzFjwPhIKuozOJqsGSRoBPs0g1am//k/+kCf9ynNlO5y1TKVFwTtKTbs2jH+/FGxSlaJJRcyAvSBPNIjIcJ9tgi45wf64AUMadFxa78SMYdH/cBIwacOYwfSL47VItdhhcTAcgbcjE0YUOyqIpEqp8BL/HI=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4153.namprd15.prod.outlook.com (2603:10b6:a03:2ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 29 Oct
 2020 21:26:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 21:26:03 +0000
Date:   Thu, 29 Oct 2020 14:25:57 -0700
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
Message-ID: <20201029212557.GJ827280@carbon.dhcp.thefacebook.com>
References: <20201028035013.99711-1-songmuchun@bytedance.com>
 <CALvZod6p_y2fTEK5fzAL=JfPsguqYbttgWC4_GPc=rF1PsN6TQ@mail.gmail.com>
 <20201029170955.GI827280@carbon.dhcp.thefacebook.com>
 <CALvZod65MhzQiwGgLM89_gZzCFDaeSZofn08viPgcvra0JRvSg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod65MhzQiwGgLM89_gZzCFDaeSZofn08viPgcvra0JRvSg@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::4:cadf]
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:cadf) by BY5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:1d0::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 21:26:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dac0aa6b-1225-4d7f-52f0-08d87c513cb0
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4153:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB41535EEDE415FA83E9557676BE140@SJ0PR15MB4153.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RLV97oCshK5Kv1zs3PA0+yh+xnXTzGb6yGyd0khXuB4NHqTnniK5oBHkZ912FtirC+wQ0Lkq21KzbhJ+oM5LClHk6B1PSyRtwQW5BCr1PvoFGPvCqsswLS14rA066+A7NhNQoUVcV2oTCM+Th4h/+xi6kODPZS3GRfDcaWD1sm29RaG6V6u9NAsjn5mjhi+8EeYo+Xk8+62mB/KtcXomyiATDBaUS7o/+4lZZavgvhA+xsYVSwHixeybLeDdAbG31emwKoCIMJSu/GM1o1fVlf7Qld9DDa+PT/mgnErfGriDy8Td5na50Oc/cHvayGiRnNLAJnvx1mqemslcgrX1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(366004)(136003)(33656002)(1076003)(5660300002)(8936002)(6666004)(66946007)(83380400001)(66556008)(86362001)(66476007)(8676002)(316002)(2906002)(54906003)(53546011)(55016002)(7416002)(52116002)(478600001)(9686003)(7696005)(186003)(16526019)(6506007)(6916009)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2gvWmXO5ECjTAKvQ8YnmUCg6ay4E3rJ5/4+9akVmS7m/96iIUJlix3RQ0My4KHulq+YjGzpNvPQ0QZcMD8G0YEbxRVb/VVQ4AP5gmEhfLPpSRWO0s87SX8Edwmg7plCi8JNYo0k8D+5zRndEhYj2YJyjgP2RoF+4ytEmq+zlqpiGe7MUKwgtQK19JKetAM6HsHD887cQs1b/3CGA+aB92Zf1Oxxyxg/CM7Pga2/CwqvEwCWHnQdPPIct58MAszkOc4cp6hEfaULdNI2skZiiTNwefs3eM5hsWhsZ+Oo3i6Q8PSe48i+pbzgGUmHwB3Bnwjr2MI6GU7Kq3NsgLg66Z4D7S6Zig6H/2NqeXAVPXM+Wbqo5/1EgEJlHH5gW08ue7mxHez4tD3JPToJbsgtCO82b9WRb3fjO4TzngGAXWZ/sX5Ijkae388aVDW829QzrCVuv4V4w+XkG+kfKKbvcWQ3Cq0l6BUEJJ38SysysQhXLQbEtQ7pcGdC1gVvAcTbXE0+c3SrfvcwP90YHrG7liFKhCRdSuJtFnvRpozD271SGw2gweMEOoYMavS2g6Cj3Ir8kITkT/o0ChxoKQnTsxpV269jtwX31U2RAhW9PAK8eD+yqydh0TGBfIzITy+Z6dJxGsjxFDw3NUdgTkhyKh23xMoBKZqSRKCeiLda+K9Y=
X-MS-Exchange-CrossTenant-Network-Message-Id: dac0aa6b-1225-4d7f-52f0-08d87c513cb0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 21:26:02.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TV21IlW/ECS7bxcIWVObNUTxHn5DcbenI2PRv0MjjxzRXm2aUNPPGkgPzASjWP/5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4153
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_12:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=1 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010290149
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 01:34:57PM -0700, Shakeel Butt wrote:
> On Thu, Oct 29, 2020 at 10:10 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, Oct 29, 2020 at 08:48:45AM -0700, Shakeel Butt wrote:
> > > On Tue, Oct 27, 2020 at 8:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > Consider the following memcg hierarchy.
> > > >
> > > >                     root
> > > >                    /    \
> > > >                   A      B
> > > >
> > > > If we get the objcg of memcg A failed,
> > >
> > > Please fix the above statement.
> > >
> > > > the get_obj_cgroup_from_current
> > > > can return the wrong objcg for the root memcg.
> > > >
> > > > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  changelog in v2:
> > > >  1. Do not use a comparison with the root_mem_cgroup
> > > >
> > > >  mm/memcontrol.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 1337775b04f3..8c8b4c3ed5a0 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -2961,6 +2961,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> > > >                 objcg = rcu_dereference(memcg->objcg);
> > > >                 if (objcg && obj_cgroup_tryget(objcg))
> > > >                         break;
> > > > +               objcg = NULL;
> > >
> > > Roman, in your cleanup, are you planning to have objcg for root memcg as well?
> >
> > Yes. I'll just change the for loop to include the root_mem_cgroup.
> >
> 
> Then do we really need this patch since it's not tagged for stable?

A good question.

Honestly, I really doubt that obj_cgroup_tryget() can fail even with the current code.
But, formally speaking, it's possible. So there is likely no practical difference if
we'll apply this patch or not, even without the root handling cleanup.

But you're right, with the root handling cleanup, it will make even less of a difference.

Thanks!


