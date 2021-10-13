Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B5042CF0A
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 01:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJMXSH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Oct 2021 19:18:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53594 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhJMXSG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Oct 2021 19:18:06 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DMkHAN014598;
        Wed, 13 Oct 2021 16:15:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=sNuyzC9OG8MT+XbnK4abuJVvFQkez++T/XhUW8ob6JI=;
 b=HIuu3+2gNyWOY224Vyq3VYchiLJkquirw+xW9dbKSiIXPfqTskGjb+syzDvc+n0efiNb
 R6AH9OabqeLdeYHYi1LGvtkFDZgdPehASWeZPLIZv/HLkxHm01kAz+8v1JQFlywnnFl3
 3gHzg3wGl82Nrwhqwwp8bTjEC02qMAPoEUw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bp8hr06dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Oct 2021 16:15:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 13 Oct 2021 16:15:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVGhrlZKZ/LUivQMvBqwD05vvFpglXIS6C5bC/buWKTQp/moNC/r/oOjI6GK2xnuiuEVm3n2EEW8yCZhGock9QIZDFNNIS5UoE91ig10CTz3Kd2rJMuiDe3XuOqxrY07xkY6GHOP/sjPWGqEzW6p6vPtq09abpe6yB908VNbsv52tJci1JLBoaZV9RlBi9OeCZfVDl+SmKOZZaHFI5EOiAB13cA/jxUAe22Fbs8+8WxR6hj9r5EGQd7UpBRXE8o3ipRDFiPkYemfhzVEyRIDWbnLQfjc05YoBx4JHERzh0YYrPMebYyhiKN7/arQmt5qZKybcrjedS6K0XnhPKXRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNuyzC9OG8MT+XbnK4abuJVvFQkez++T/XhUW8ob6JI=;
 b=T4OtvtjuvSa44ouSjsQ/S00Ro+88a5hBU9OWff/VQZT7bMWNstI8J9lVu2/6Var/Z8HGeR31eN4Sxwqmbz689RG6GJVr4XxwCk8wElFgttU+vrDJABciT51su/ybxZ9Ngf46206UoWn4/PjMkxp8vPo4MxXGsFOWKNWDG+k+rL3Zc3CTCt4VHvQrF0/oyGbPFVO9fYaHPulo/EFtfhXB8h6gBwxO/6MGYfM/o4ZypeDTUBCGRN34EhjV+eYHgFKpkz88FskajMVNUbPh/ei1ffAT8UVq8Kzh0KlJUQFdmAT2W1wO1eR4J1/kD3bmNv31j5u1Pl/sMUzyAlMaosTCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3555.namprd15.prod.outlook.com (2603:10b6:a03:1f5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 23:15:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 23:15:31 +0000
Date:   Wed, 13 Oct 2021 16:15:27 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
Message-ID: <YWdoj9FZy2B4oLj8@carbon.DHCP.thefacebook.com>
References: <20211013194338.1804247-1-shakeelb@google.com>
 <YWdXv+RBjXvdmsK+@carbon.DHCP.thefacebook.com>
 <CALvZod6ZppPNk2XfvKFfdPhrsSF6NbSBKrOOOc6UyJMfDEfKoQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod6ZppPNk2XfvKFfdPhrsSF6NbSBKrOOOc6UyJMfDEfKoQ@mail.gmail.com>
X-ClientProxiedBy: CO2PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:104:1::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:284f) by CO2PR05CA0088.namprd05.prod.outlook.com (2603:10b6:104:1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.8 via Frontend Transport; Wed, 13 Oct 2021 23:15:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 572e3394-bc00-446b-73f5-08d98e9f5a13
X-MS-TrafficTypeDiagnostic: BY5PR15MB3555:
X-Microsoft-Antispam-PRVS: <BY5PR15MB35555BA931E87E2CCA87D17BBEB79@BY5PR15MB3555.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Ig9Ls1NKz8QZFFntr+dszVlx2gnWKeWIIJ+iVca6LDWZJgb5+5nYCvC5aIp9jmyNtl2u/GHlPaI1ORrRNPjZMOi1ZU5lxk9jxw54iGDxh0NHpgWJb8WWEYnLMLzof83BeFj7pn479cyoSjZjFyRPZUoSuIXB13meWta6YVBKz9M1j3aHOtvtkGIPGKKXx4otENvHnmUJlmtgNCNi0XX9iyHS0JLbV45gUksHiAV8tuXwMGK0aPx+S+UhyHdEtyiZ/PW728KM8qEEeifHiUWy6q8G/dq/FDqFqaVK/dDpgID+lRu5n9vRSBC27FZufLdVPqZA5D74h8JSU9tRJdKG1MRux2TJhDqUqjdOnNfhsDlztLyGkesHHxD+zZhbWRBaqsFh8kr8F0E8HlgewgOk4KWVnE0sHkOqUdethIlKGUpFaDbusR749ll9V6Jcsq3pTPjmj48J9mWmYqzjnHyeTsSuXnZ4ZYJvyYxAnqVlokK9QHtzZlFDE8tvMkgCQCYqLpBl+N3qtSKWMqpWMjITUUDBItFM6XqFzw+jP/+1+vI/EXsoUK1C9RpVwDw5HWVH5bcoKqzM5QIrHb5j0OgTpFMXp15kTexQmpOEH0yP6OmxdbQSS6aFqmRiGn71xZGza9CrmafJSXHJ+86vLSOdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(316002)(5660300002)(508600001)(38100700002)(83380400001)(8936002)(8676002)(6506007)(6916009)(66946007)(6666004)(7696005)(66556008)(55016002)(53546011)(66476007)(52116002)(4326008)(86362001)(9686003)(186003)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SC+m4W9IUhEXsOFwWCGi+XCvvyeM7cr/XqhfKqqBmiUD1I/WKwMP9S5VKoMF?=
 =?us-ascii?Q?tOdXp+mRQsPCWGEngrDErV8TmsDpZhI5oXK10tdA+3sl2NWNgA9oB/zqsvt/?=
 =?us-ascii?Q?qN+Xgt3Qp9E/JihjnLq4SsCKl2WCiNf6hAaNyISEEUv76177pIUetu+vw5Rw?=
 =?us-ascii?Q?CbKPCXyHTIu9CDHbKFqwgyd5a/zLnwHGFHIKDsWXm/Yjz6oLT22RGeV1xRL+?=
 =?us-ascii?Q?4eO2fO4uHdKDVwZBkuvmJwoPsVLY/8ISh8VDtUHaw1Cx0S2btnb5OumGzXUQ?=
 =?us-ascii?Q?O/QOzPp3ocyxVASR90s36mCKPbPQRakg2aZKlJVjk46wpfh60FTnb0kcNaBF?=
 =?us-ascii?Q?PoeV/yyoX1apyTvVQ+3vXq259pySJNZTgdBIVtojvXbKHsQkxJlnWYi+/cAg?=
 =?us-ascii?Q?2EwCZnDgmlVwt2v67LUkZDP/0YvqX32JHKgpp9EdSLFCYx+xV171wLSpA+QU?=
 =?us-ascii?Q?YJJ3bNL4NHoaENMe2vCNCuIM14JJjz2m9E+LRJKZx5HULf0aaqSOLKx+9ImW?=
 =?us-ascii?Q?wRvoF6ZQgz235rhrIZqAAQAwhgVDWgyw7Ab8roEjCkNfjLgrpUvJfbsysYRM?=
 =?us-ascii?Q?LrTsTzZzxwg1lWnyo/s6NVvJIlKDosjvHIWD4vUL6XqEAygREZCUHjH7QoJz?=
 =?us-ascii?Q?YgZ7wV8n2abFcwzvn9yPOt/7C2p/pkd3SK4MNJEVTuHAm1ryuBPZxVJuAmPL?=
 =?us-ascii?Q?XMDG2oBFOd8NjlSXF3FEtLkQKQiFQjDB+kyfqaWt9fmz/XkFih20y8k6rNwg?=
 =?us-ascii?Q?mcKN/xC0yCQRUC1O8RC9eHDToEfs+2TZtqoYQLyfiqqhLtxjyya7Gj0lT3/v?=
 =?us-ascii?Q?75wx2/7BVF6MmCJXJsmhRUUeqljLhPhjxalrcanfJGO2/12LGdGbKXtiH3SR?=
 =?us-ascii?Q?N+RVxFuBoA60dqUzmrLxeLyUUmHqrklMUZRzmDfc2LwSXHVSXxdFYSmjCjhL?=
 =?us-ascii?Q?/uDVLh29YtAt6sE7zSMSXJm8VTHLc0Kwn9GMcOXz3XF3r323ncB0F8r/MYYU?=
 =?us-ascii?Q?mfFld8E7SugSBVC5mQZYIMHQUZwXC3zLJmHP5xYLq7/M11aW0vR62pst3R9R?=
 =?us-ascii?Q?+JaycukRR2D4w3aYo/sgOqHl5QJm54uwq9QVyKApFAZhZunXyML8shmmA+3L?=
 =?us-ascii?Q?DrXluZkGSUZb0YZhFJYkfuP7QhFlFX4epFokMQ7NpkSb43FBmyAQSYXrg+Gz?=
 =?us-ascii?Q?RJuSVB+zeSDbOwoPcOtHNsuhLE3YDySyZajzwMm1nF9mPyLIdzlGkZ7y797S?=
 =?us-ascii?Q?27DLzSChZXMb9z5EF913kvhu0XcmGJb2Yljls5hetiC2/bylc94kwQMkG1WB?=
 =?us-ascii?Q?RhFfUj15mdixfOTz67u8IX0xhJ5rrp1WnQ4rWfXMhjFvRg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 572e3394-bc00-446b-73f5-08d98e9f5a13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 23:15:31.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oinaLRDLRRYTjfKdM6e73k3LYOhm9pN8YE71Po5oOr6chXNQPtM5hkAV6j7wdtuP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3555
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: LVddqxF0aKtttWtdhrLvC7anDQN37YcM
X-Proofpoint-GUID: LVddqxF0aKtttWtdhrLvC7anDQN37YcM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_09,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=846 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 13, 2021 at 03:26:11PM -0700, Shakeel Butt wrote:
> On Wed, Oct 13, 2021 at 3:03 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Wed, Oct 13, 2021 at 12:43:38PM -0700, Shakeel Butt wrote:
> > > The commit 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in
> > > __vmalloc_area_node()") switched to bulk page allocator for order 0
> > > allocation backing vmalloc. However bulk page allocator does not support
> > > __GFP_ACCOUNT allocations and there are several users of
> > > kvmalloc(__GFP_ACCOUNT).
> > >
> > > For now make __GFP_ACCOUNT allocations bypass bulk page allocator. In
> > > future if there is workload that can be significantly improved with the
> > > bulk page allocator with __GFP_ACCCOUNT support, we can revisit the
> > > decision.
> > >
> > > Fixes: 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in __vmalloc_area_node()")
> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > ---
> > >  mm/page_alloc.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 668edb16446a..b3acad4615d3 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -5215,6 +5215,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
> > >       unsigned int alloc_flags = ALLOC_WMARK_LOW;
> > >       int nr_populated = 0, nr_account = 0;
> > >
> > > +     /* Bulk allocator does not support memcg accounting. */
> > > +     if (unlikely(gfp & __GFP_ACCOUNT))
> > > +             goto out;
> > > +
> >
> > Isn't it a bit too aggressive?
> >
> > How about
> >     if (WARN_ON_ONCE(gfp & __GFP_ACCOUNT))
> 
> We actually know that kvmalloc(__GFP_ACCOUNT) users exist and can
> trigger bulk page allocator through vmalloc, so I don't think the
> warning would be any helpful.
> 
> >        gfp &= ~__GFP_ACCOUNT;
> 
> Bulk allocator is best effort, so callers have adequate fallbacks.
> Transparently disabling accounting would be unexpected.

I see...

Shouldn't we then move this check to an upper level?

E.g.:

if (!(gfp & __GFP_ACCOUNT))
   call_into_bulk_allocator();
else
   call_into_per_page_allocator();

Not a big deal, I'm just worried about potential silent memory allocation
failures.

Thanks!
