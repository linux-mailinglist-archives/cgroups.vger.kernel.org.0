Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CA72D3959
	for <lists+cgroups@lfdr.de>; Wed,  9 Dec 2020 04:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgLIDxh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Dec 2020 22:53:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54886 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbgLIDxh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Dec 2020 22:53:37 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B93h6AR010262;
        Tue, 8 Dec 2020 19:52:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=j84ueRbd5U3HePmJX5oQjdX2Bf/TWLQOa+LPbgAb1Ko=;
 b=Krnsx0yvhpkI4pPM9qxyOcv/0F765WRZTDCUG5lDowoCDin6aagiFAQ7eVDgE0pr7EFE
 JhpkP1GJwItPFVyhZvuhtowa0Mtx/Z34FNRTM+VYpPysea1LbNO9TV/JI08fMmDc5yZb
 kmTdGlIVVcav0/tN6qv7AnJrHUx0lYirf5U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35ahu7tc7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Dec 2020 19:52:42 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Dec 2020 19:52:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A90YL3cADtPiquQMyIyzJszeW26f2fZHSltQLOgIqyr7eA3GgqbeDHaMMTjdA6SWsNz1Tom0QN28NSBPXbxoQdo9yxqogBn8kcUoH9dAX9gQRIkcrU8O8N6BWXCHH13I89oqfqA4HTpYpLRUos+tGfj+2hT3rAshLzimLjNVhuojGN4aTVtxwXfeQ6GWvA7DypL360lkH2k6LwH+4ibpfBWAmiPFnm3E8R0UmfMUrz4Ip6y0701jfkVeOvNMNGw+Z9REzO9oiqibkSqqvjZw18WiOhcj/Nk1VOO4Ha5pYWgy4DQM7mbeIUmqvPklCocvj+E/svoEGg2dRMjTSaFvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j84ueRbd5U3HePmJX5oQjdX2Bf/TWLQOa+LPbgAb1Ko=;
 b=BvcOMZ4wdAcM+dJs7Idmg4V690lWarVhn8O/DpNiSTyo9G9Nd2f7DQs8u42Twyev4g00Rftra6atA9iWn4OxEEANsz51KFhlxw5jOir4qSuN2v9rW2Mbu/7ze/yG/g6R6LDQEh6Nh6y6chZzMaARqeetDMCJbtELQM3DDV3Wv3d0hOEwAxWo4vQitEewAWSOpwRjQ2DIAz/e2w4jxlBQLq9lmtwImfiMBtGYt+ri6VVupqfWvDXu3+OmbtAkT2YvJAgJLla9PEaQaPLoSps3HpsBNAhQ2P6+RMZoGl/6EyizOei1tXLFRyNI2FI6FKAeJ+3wjvF+JgGXIaHoveV5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j84ueRbd5U3HePmJX5oQjdX2Bf/TWLQOa+LPbgAb1Ko=;
 b=E3QxU9N/E805zJ30GyhAnQUjnTiv1FAgwSAnsJN4GyUp5BDOL2FQx9THo5jTfmsKAdZbXWaKcIMLCBQ4F5AVjEBDvqc4hBk0EPJqBPtfYbE1tEt6+FkG1Jqd7DmPHS05JM40WSJwXitydqK0buZFLvgyeVj5Moh0Fj+6OXDCSkE=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3399.namprd15.prod.outlook.com (2603:10b6:a03:10a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 9 Dec
 2020 03:52:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.024; Wed, 9 Dec 2020
 03:52:40 +0000
Date:   Tue, 8 Dec 2020 19:52:35 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        <richard.weiyang@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [External] Re: [PATCH v2] mm: memcontrol: optimize per-lruvec
 stats counter memory usage
Message-ID: <20201209031115.GA2390587@carbon.lan>
References: <20201208095132.79383-1-songmuchun@bytedance.com>
 <20201209022118.GB2385286@carbon.DHCP.thefacebook.com>
 <CAMZfGtUMP6mz3DE7DHS55fyto=LZuQpcitt59WuwhZw8m2LqBg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUMP6mz3DE7DHS55fyto=LZuQpcitt59WuwhZw8m2LqBg@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:c836]
X-ClientProxiedBy: CO2PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:104:1::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:c836) by CO2PR05CA0108.namprd05.prod.outlook.com (2603:10b6:104:1::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend Transport; Wed, 9 Dec 2020 03:52:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11454200-0e2f-4ceb-81ca-08d89bf5e01c
X-MS-TrafficTypeDiagnostic: BYAPR15MB3399:
X-Microsoft-Antispam-PRVS: <BYAPR15MB339915BF1874005304F6DAC2BECC0@BYAPR15MB3399.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4FYAEEezVE2yCuuja4h8NCssVoej5wnYg4TTkGrC9Zd/KauIRbf2Qsv/KOefqXt2N/lSvpmF3J+imsg0FJ/2Sw1c6hphGieI4CzbsyMmVbGjBCYwNh8y2pUrjn5ISHAKeOs4uS8V9McrvFSCFFfyiIwDmz9YhyH4BsNsd5jr2hDflZtvFpX131tdqL6SseLk4Pu3XHBMJnsStu2AltMlWPj11JGw9HqvCQcC04t9U8wAwGwDo1eUMeDIw8Zv2eTlhwDZr1wHKhzHlg9F3DgBxhztJj/cDwTABYMKDycyt25+9HEgg2iZozW7iICvhdSkwzVb+PsWR+y152w1v1sZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(508600001)(33656002)(8936002)(52116002)(16526019)(9686003)(86362001)(4326008)(7696005)(2906002)(55016002)(5660300002)(36756003)(186003)(8886007)(7416002)(53546011)(6916009)(54906003)(1076003)(8676002)(6666004)(66476007)(66946007)(66556008)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0Gn0OuIRglzjgQrc7BookLBwTQP/ZVDXMhCpKOZsEwx2rqioUqJkGncUqhSM?=
 =?us-ascii?Q?o99RfOnCnW7AwvQO9vhc7Zs2PETxrOyTd7efwfRxC6/pMXzahyZAFh71qWPD?=
 =?us-ascii?Q?doihs0dq+XpEtUMo5dY6cyOsP3Oe57/hjdJ4o9Bn7DQSbyp09i/yoyT2diV9?=
 =?us-ascii?Q?p0mW9n4UlVEvG0cKm8t9LanLiEgC23qx6jgANlxQIo6xQykvkF1VtpxdpAib?=
 =?us-ascii?Q?L+pEEDS/NlnMUmIlKzew/oOFd9BdxqKJT0Sk2EGVrF/UXojhwhhaTdUZ96v7?=
 =?us-ascii?Q?5MTVjqXDs4vDHyEvuw+v9qogvbJI2wlxH7+c3UcjPhb8AwDLKWnrW4gKwxfI?=
 =?us-ascii?Q?XjUWiCyJoX8CT5IcFrh3GxNL9988M8HrwB/WwFCX5NzZmHQi2IQ+iCCtC44g?=
 =?us-ascii?Q?9EXZVMDdjrE0CzV8S2Srd8RPTfhuWiI49ggyOipmeC6w6vYbxZ54P9ZWmMKY?=
 =?us-ascii?Q?ljuJf4LO6AQruwlCnFXuGdyFXnf7cxXtEK/EElzbYkdYYvwPOi78bOigOZyN?=
 =?us-ascii?Q?n3Saa9MNjsDMdP+CgtaAhdqcCTls70PSEFboaTcxJdWqhLqlJ2CTATyuXZ6N?=
 =?us-ascii?Q?unhNZeX5dm25mq5LGZEDoBs/UrVVvSu+B0E2SZN2AyyriUeA6GzuFGeApAUU?=
 =?us-ascii?Q?UC80um0JTq4YP268CcpqS4gTQeyXAHNqJTh7fE/gnlYEoHLFax6CZkz1rnSW?=
 =?us-ascii?Q?prcysncBRCuO8A31itX5YCB7501uaIT7xm8j4b9+vSIv5aPGGEOqNhxwEC8t?=
 =?us-ascii?Q?Gyyb7296gsQmwIC7+fq/N7L+5aQbfdBuwi61B6g7MpMiF0i0Ud76XsskHyU7?=
 =?us-ascii?Q?uEHU+T137g4T6XK9B6E4vp/YcFdt3uv2kMdhYYC5yZ2bhKlxU9Lh3xIdaulm?=
 =?us-ascii?Q?qgUz9SBUMrM+vawNwWvGdrV5NlMjxaRQhqGymJSDvno6lkMo1wr4P0YbAkJ6?=
 =?us-ascii?Q?oN3qQaM/J5lR0utwY7DNYJ3alSmJoXP7qZZROgrdHxUj015UZ73jpFv7twjn?=
 =?us-ascii?Q?h+rbJrV44G7cW7YZHdeHQt9R8A=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 03:52:40.1363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 11454200-0e2f-4ceb-81ca-08d89bf5e01c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKFqaRR9x5cXYfhM2P0Lbq74jot9ndyn0pvjxIDS/tb42iYJMJ8QFrlF7woQgwD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3399
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_03:2020-12-08,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=1 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 09, 2020 at 10:31:55AM +0800, Muchun Song wrote:
> On Wed, Dec 9, 2020 at 10:21 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Dec 08, 2020 at 05:51:32PM +0800, Muchun Song wrote:
> > > The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), so the type of s32
> > > of lruvec_stat_cpu is enough.

Actually the threshold can be as big as MEMCG_CHARGE_BATCH * PAGE_SIZE.
It still fits into s32, but without explicitly saying it it's hard to
understand why not choosing s8, as in vmstat.c.

> > >
> > > The size of struct lruvec_stat is 304 bytes on 64 bits system. As it
> > > is a per-cpu structure. So with this patch, we can save 304 / 2 * ncpu
> > > bytes per-memcg per-node where ncpu is the number of the possible CPU.
> > > If there are c memory cgroup (include dying cgroup) and n NUMA node in
> > > the system. Finally, we can save (152 * ncpu * c * n) bytes.
> >
> > Honestly, I'm not convinced.
> > Say, ncpu = 32, n = 2, c = 500. We're saving <5Mb of memory.
> > If the machine has 128Gb of RAM, it's .000000003%.
> 
> Hi Roman,
> 
> When the cpu hotplug is enabled, the ncpu can be 256 on
> some configurations. Also, the c can be more large when
> there are many dying cgroup in the system.
> 
> So the savings depends on the environment and
> configurations. Right?

Of course, but machines with more CPUs tend to have more RAM as well.

Thanks!
