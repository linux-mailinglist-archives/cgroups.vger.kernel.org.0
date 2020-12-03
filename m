Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC22CCD74
	for <lists+cgroups@lfdr.de>; Thu,  3 Dec 2020 04:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgLCDuQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Dec 2020 22:50:16 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29574 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726938AbgLCDuQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Dec 2020 22:50:16 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B33jrrT014571;
        Wed, 2 Dec 2020 19:49:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=o9iCmBwL99PQGKnZm+cgxJgrNkHDFUoF4cv2ptcyvqA=;
 b=LZySaxuJmuu2rwPaVnFfvGG5df+AF3MESzKI0Q79O4dPhoWkf9WBpgyYTj3xQImydDpU
 zFSZhbY6+l6Sd3Vop1unhqKR0Iky/Ir6AkNok3FxzfZBTnw968wVi648QrPz0nntg+mf
 ifO3lytKvNt4I4BXkggGh8izh0rAG0LpqN8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 355t7ybfc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Dec 2020 19:49:30 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 19:49:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0P80BILpb1UohrxFHUs/YVjVoLFmmqf3vAo+TdGot7mjrULDhUAtmvpBIK2gXKTQm6/vQILzg0VHlesf2Gc89cjjKjWMihA0c1ppcEVIRlSrAe6/AVP15WbqhtMQy0SAxRKuJnq+eNiYj1dkSI7RmcT6E5GeIyOytiPWuvqK2nTJcSsOjy2GP37JvXiEo9p6M/FKrljVoOpsW/mGTf49xWb9WhMe/d6JOp6K0aR0NCKfiT/lHZRC4Fboq0t7dYJjtaWcTcjKxEhUr3reI6PQQLzjcj4zOyWVnvcTwpeGktokHx5g1GofDBlh/K5FuMPPUObeKpKWP0LxG4jCB5vEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9iCmBwL99PQGKnZm+cgxJgrNkHDFUoF4cv2ptcyvqA=;
 b=G6SN886DHwrSe4WwJFggvnBIF46d3GMJ9VMYiARtpBOYfi+PvMJHnOUcmdIU3GzHnsjFFnW3sq/vls31k4HVmLNgKBEW5RkRGzEFOuVWm6d+uNQwVXGu4iMErHThg99+VzbU7o4hQp2xCZ1IOc/juk0pEkRp4rR4tu9VXSmtOAxKfI9VXxD+aKguL6dhejdh/cep8JaI3LZVpH2TE1i/INiaX/vIZ8s7sFpsyBHl6Wd4ecBK6uJXYXEIRnVixtThN4/rgJ9CvjSB4mAHqnpLLfRE0ig1yAapoHsByiXQ6s3PzJukxioveKhoTLwDOc6lOGTBX8Zur+AQ887TG1u/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9iCmBwL99PQGKnZm+cgxJgrNkHDFUoF4cv2ptcyvqA=;
 b=fN9wk0ZxcUZhXSE2e1IlTLRPgS4uOQAkCR2EUaJhSAQyryTMV01G7daRhD+m8m/wou2QJJQIYQkhA9JleJC1+p0P1dhL7D/tXGaHpJfUC7c0MyCt7XjeRU9h57MZ+BrNJf3c3LNiYN0MddlbANW4MdeQVat+SlFL8G5pjPU4Wow=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2437.namprd15.prod.outlook.com (2603:10b6:a02:8d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 3 Dec
 2020 03:49:22 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 03:49:22 +0000
Date:   Wed, 2 Dec 2020 19:49:17 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] mm/memcontrol: make the slab calculation
 consistent
Message-ID: <20201203034917.GA1571588@carbon.DHCP.thefacebook.com>
References: <20201202121434.75099-1-songmuchun@bytedance.com>
 <20201202211646.GA1517142@carbon.lan>
 <CAMZfGtWUWAO8J6iBpQLV0T8xPAuQvFTfX9UQ7G2eM_O9C7w83w@mail.gmail.com>
 <20201203032052.GA1568874@carbon.DHCP.thefacebook.com>
 <CAMZfGtUY11=2tna7gOv+LH5-=ossA+BPrLrC09odTw=qd3RJQg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUY11=2tna7gOv+LH5-=ossA+BPrLrC09odTw=qd3RJQg@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:787d]
X-ClientProxiedBy: MWHPR1701CA0003.namprd17.prod.outlook.com
 (2603:10b6:301:14::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:787d) by MWHPR1701CA0003.namprd17.prod.outlook.com (2603:10b6:301:14::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 03:49:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3e98748-78d7-4da0-46e7-08d8973e6bc9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2437:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2437CDDB76BFF540EC57114BBEF20@BYAPR15MB2437.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZ5eOM/KrhwsWGbLejL7czCDQeW0m9ICG2xVhxxVpNQi9qnz9Y6bhBzcD4UJVOq38IK0CnPvhgB1KxG8nh/aHhB8e3zg2mD+cZezSBCQZT8WcMeiAB+UrAzkphNXWu5+YGRzB4ZbnlS6oj2Ap9dT61xwk7he6QEIUIcXGAhx2M+NcoQwv9kDySRm68HQq2sqvRWtB3j0FOvsPb5AOriEDPc93yzYjyhb/0ZrbmPOxwyuYr+xdVnbkSw4ez2xvwOR69F0kzG2QF5rX9C1ZKaCQQ2sLHjndUWx8jG3bhlJ+hu6k4XPCKAl/SMO9xuVMcpC8Ny+MdB6/xKbWFB1mRMecA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(136003)(39860400002)(316002)(6666004)(86362001)(55016002)(8676002)(83380400001)(9686003)(4326008)(5660300002)(66476007)(8936002)(2906002)(66946007)(66556008)(33656002)(6916009)(52116002)(7696005)(1076003)(54906003)(186003)(53546011)(6506007)(478600001)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ogQQVlRLI5Y2pCob4lzccILT7YGyFEr+TSLVcy6BQQWbV1oQIqEnHKYB6s2Q?=
 =?us-ascii?Q?Be+tavcOx2MeskFPzWNJX4dCVMSc5c/M44BKSXDb/Ou9tJhV4qY0WkJ0HWaD?=
 =?us-ascii?Q?gkbbSUdTW+9JMe9fv/2UbLbPGy1Yi/2kYIMfCG0dnbfEqrMTz82SpJhEATSr?=
 =?us-ascii?Q?cIBCZM6MQJ5Ne3JGnruHqD+uA6ZIbvDFnY7NOXtnKiC75y4QEr5xHIdL4bdu?=
 =?us-ascii?Q?/63JKA7lbmEIg7azrCrY/fMztfHISe9sqEvnuwY1nBNPLWR6V127TzKiLCoz?=
 =?us-ascii?Q?6I6fEaFK6J1quwmNO/QkGoVZLoquucyUfQblrLZRxZKVnHdGHzP9qFugmjh/?=
 =?us-ascii?Q?Il9h7QBciPlLTG0TtkrKdc7EWcrUKDG2bybxbr5e6JmaElCP470E5Okkvop3?=
 =?us-ascii?Q?/GgB+q+3YWLrXl68w5kPZs9vQogFd+nI3BVKk2csjUH54PSzhazh8udN9kbG?=
 =?us-ascii?Q?vvuEvC5e0TEft8CLBj1NUknj03v+VFiGTkmxoYt/14DqrRdBagSQ1diWswKU?=
 =?us-ascii?Q?Is7vaMuoeZxvLmng1KkCkYibpp/zvQa90AqNKd9MQq2qtISmNKkBWMMxb+Jz?=
 =?us-ascii?Q?6BJsWa3OtcqX6FSY5X174xmTXX1LTGcwvVeCRJOrxn1p1sgTtFj9r0UdwE8n?=
 =?us-ascii?Q?YF6T+Kp9yBDBS/mrV/MYpuidduWc09TqHQ70mnY9cpUc7DHJZdW/B3J1K2U7?=
 =?us-ascii?Q?RGsshjkRYcoyivywZB17f8nPkuD5mjGZqDED6v6huzwLEvnJVL/oBmSqS291?=
 =?us-ascii?Q?vYet0MO+5b1XPJBJzhx8xsD/CjNB017pR57fs0ZSuY6UxTKfaz2mnUCZZvNF?=
 =?us-ascii?Q?Xw+qUYI2UcTwSqfuRo5FftUdWfWk3CzPv5rKKtMaUUldzBoGIZTCiQaxSsWY?=
 =?us-ascii?Q?7o111gMQMat0SxA6ITnA9jNLRB3VTLspyTm2nynUr4OuvECjqpeikCM1dqcl?=
 =?us-ascii?Q?aw+0hY8nq/eznRXC4ojPC9MAnLKvxVya899HT4xRTnFrRDM8xNiWNR8g7OqM?=
 =?us-ascii?Q?zbmeqwjhb1qBxD0xKH4P7fm8wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e98748-78d7-4da0-46e7-08d8973e6bc9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 03:49:22.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvdSTdGXRbsY1GNnbSvN5qPgvs+4MQjrzmLvFbzHSBUFWIom5FQWdgrrSBKOn9kM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_01:2020-11-30,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 suspectscore=1 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 03, 2020 at 11:36:54AM +0800, Muchun Song wrote:
> On Thu, Dec 3, 2020 at 11:21 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, Dec 03, 2020 at 10:53:33AM +0800, Muchun Song wrote:
> > > On Thu, Dec 3, 2020 at 5:16 AM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Wed, Dec 02, 2020 at 08:14:34PM +0800, Muchun Song wrote:
> > > > > Although the ratio of the slab is one, we also should read the ratio
> > > > > from the related memory_stats instead of hard-coding. And the local
> > > > > variable of size is already the value of slab_unreclaimable. So we
> > > > > do not need to read again. Simplify the code here.
> > > > >
> > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > ---
> > > > >  mm/memcontrol.c | 22 +++++++++++++++++-----
> > > > >  1 file changed, 17 insertions(+), 5 deletions(-)
> > > >
> > > > Hi Muchun!
> > > >
> > > > >
> > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > index 9922f1510956..03a9c64560f6 100644
> > > > > --- a/mm/memcontrol.c
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -1545,12 +1545,22 @@ static int __init memory_stats_init(void)
> > > > >       int i;
> > > > >
> > > > >       for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
> > > > > +             switch (memory_stats[i].idx) {
> > > > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > > -             if (memory_stats[i].idx == NR_ANON_THPS ||
> > > > > -                 memory_stats[i].idx == NR_FILE_THPS ||
> > > > > -                 memory_stats[i].idx == NR_SHMEM_THPS)
> > > > > +             case NR_ANON_THPS:
> > > > > +             case NR_FILE_THPS:
> > > > > +             case NR_SHMEM_THPS:
> > > > >                       memory_stats[i].ratio = HPAGE_PMD_SIZE;
> > > > > +                     break;
> > > > >  #endif
> > > > > +             case NR_SLAB_UNRECLAIMABLE_B:
> > > > > +                     VM_BUG_ON(i < 1);
> > > > > +                     VM_BUG_ON(memory_stats[i - 1].idx != NR_SLAB_RECLAIMABLE_B);
> > > >
> > > > Please, convert these to BUILD_BUG_ON(), they don't have to be runtime checks.
> > >
> > > Agree. But here we cannot use BUILD_BUG_ON(). The compiler will
> > > complain about it.
> >
> > We can!
> >
> > We just need to change the condition. All we really need to check is that
> > NR_SLAB_UNRECLAIMABLE_B immediately following NR_SLAB_RECLAIMABLE_B.
> 
> But I think that we need to check that memory_stats[i] immediately following
> memory_stats[j] where i is the index of NR_SLAB_UNRECLAIMABLE_B and
> j is the index of NR_SLAB_RECLAIMABLE_B.

Ok, I see. Thanks!
