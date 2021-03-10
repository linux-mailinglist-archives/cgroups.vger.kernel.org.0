Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF724334793
	for <lists+cgroups@lfdr.de>; Wed, 10 Mar 2021 20:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhCJTJh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Mar 2021 14:09:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9954 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233594AbhCJTJW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Mar 2021 14:09:22 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AIw7rp020508;
        Wed, 10 Mar 2021 11:09:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=SqrnM5rUjX4Rc9LZhCE/7SAx5fRzevVuNPcpF1zfDD4=;
 b=fGeXerzzx5wAmKbDRy14oL0y8MUXL4x/NKc6/WSqZx/+1JtNIHb4ZLeYtylsbgYiS2xp
 hGI+zWWeOeGBMx97GlYHlxKAhp5Oyo4JnZLO3nwyh9WRjAc7WUdOAe+wa089KnZPWoMr
 QgAacUAmtDZ2F9pZacz14fXar6QNhrE3b1c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 376be5yrxn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Mar 2021 11:09:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 10 Mar 2021 11:09:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9rv28jp6TmTiJzXRcFlaxWfUUm0C/kjqyyFNEYT4qF5ysCCxvEJHZYCdFaEOmgbnnAtf6BlF3SS3gV5IhpTOqt9VhQKz4vsanEx073YIEz0VdvT/R23pyhMx4eEyF9o2AULXsWejwCesXnsnfKKJLuwOo3yup9vReHzlWWyLt91ohSkYAmtmzq6zKOzBzjK/Jjww/vG1QO+NoH6EUR+uNeZUYlZTDbTT/X4O0XIZbB8185CMmzv5wdZTD1TzSwtO5x8LdvqDBUQ0UJTwqceusOboZOx+AgEeRmA7+yv6gfXQL3DapHMwd9KejrVeSGnH38Yp0/NrQ/3x+xFqgPipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqrnM5rUjX4Rc9LZhCE/7SAx5fRzevVuNPcpF1zfDD4=;
 b=HymVm1HhP5lXwp20qo74kPnA2l4TUghW8TkUZTWmBJc10S3FIXYKWKpZQv3Bh5dNVWuwxVprYV6QDCpnpvUkvHnyvFQB4FsSyR0bsV9b3OnUEgs8Arsz05OjRK6G9ElB4rCWgb15Gwa7pIgoY2Tq6+5KFx2/eyzxo3CS3qtnINSLZhSXKrMzka5V5LC5BkPRgwinmlZqm7Z7gSL1xxL3hOa8iJ9CtEvSqKf8E2IisG1hDjSnuKwPHCWyeIVB6sht+gzKY65gTUO1S8+mFFtyRcRSNbe3fCBZ3p/mmFP2PoknE75v7BZk3yckvCbzVdDopZNYZRrl8nqIug8KFb56ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4598.namprd15.prod.outlook.com (2603:10b6:a03:37b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Wed, 10 Mar
 2021 19:09:09 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 19:09:09 +0000
Date:   Wed, 10 Mar 2021 11:09:04 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Shakeel Butt <shakeelb@google.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 1/9] memcg: accounting for allocations called with
 disabled BH
Message-ID: <YEkZUGc/Kw56MwwA@carbon.dhcp.thefacebook.com>
References: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
 <CALvZod4QiAhjgQOGO4KYCs4-GjUmqb6th+4tr8nQ+bPumGFzNg@mail.gmail.com>
 <YEfYFIlRH0+0XWwT@carbon.dhcp.thefacebook.com>
 <YEiUhWjsC6HbYFpT@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YEiUhWjsC6HbYFpT@dhcp22.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:69a3]
X-ClientProxiedBy: MW3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:303:2b::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:69a3) by MW3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:303:2b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend Transport; Wed, 10 Mar 2021 19:09:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c02d4e6-df44-45e2-fd53-08d8e3f7fbb6
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4598:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4598D50DBF126F96E457CEC5BE919@SJ0PR15MB4598.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yMZbAXHwDMRdBo4IGbhtbOYRsEnpYDYgfk9nXrU8XOR6lBlkSd7AJSRNKjYa5nGS5NlBqeUd7mBxDkbL5lKMxKKNDOR6Emh1DUU7U1cUbN/BhD30aUe/e1FGqt/k0Qw/u4E/kEPkob2SYtclABDXYxT5E059yZSbEc4O3+ptM/LAgrv4EQMviB4I+6rv6L8LRttEYKKpj8Bfg+2mBtcAJ+AUAyGO//bu8IQSDTH1wK8rjIOtyacG9Qr4ewtJ540m2tSSqHwVwGVTYVQi9p/izr1wbvNWPZzM07dTSlQSP9SuZCtAIl2WEGhuXKV4CXuqPzgJO2jQeRXdaa7kew2ltcu0RKHM5izC6dHRYp8CdLCNEUlnXuQefxxozDeTmVPhkBYgzFSp/QRCEmHuso/KVZuWeGXLdCGZJmEj45yHU9swCjPashiETp5JlfTS5rmYx/ZTXwmznlDKuYquZ7QOyy/dy3qfu2dMP6IIOiC0aswmxQAQNINEkUVIvfTwQ5/dfC5jtLqNZzp1dd/Jo2d7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39860400002)(346002)(376002)(2906002)(6506007)(15650500001)(52116002)(7696005)(53546011)(6916009)(66946007)(66556008)(478600001)(6666004)(55016002)(5660300002)(9686003)(16526019)(186003)(8936002)(8676002)(4326008)(66476007)(86362001)(83380400001)(316002)(4744005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DsjYM2D5E9PuEj1UT0u/Ay1pdLP9YGcKZ4qC7v0U0Da6qG85Lfg/ZvfEijnB?=
 =?us-ascii?Q?d2forf5wQ5VjXHqUSJVuMXN4nZMenzsbdr2gnqz+qdhp8AnNakMUnwif/YMo?=
 =?us-ascii?Q?3/HnJaNxsdsM5wOYyMeUtTRuZluVM/6EuvmSo6+yevT5ffkyVnefFooHVVY+?=
 =?us-ascii?Q?65T3WlrqwphePrcwFVvyGKM83q34QFgzXxjtPPFS32xYmkjq1L81oag2uppZ?=
 =?us-ascii?Q?Kb+6WtF2V3F+eNDuxMKOTbPB2NOL4MLjdqOXvE6VrTycTyyWPAbiObDubZc5?=
 =?us-ascii?Q?BYi2pDeiFtPsvyd44uWCX/sEeSTYqjn9xk1C5fcLlB3NHslH4M0z+pVORZ7Z?=
 =?us-ascii?Q?pRQlmgzSlgTGV0dQZTfNA4EMExvjAJ1ZRW+LY8LV8iD4wbJ8N8fnTU/Xv7RH?=
 =?us-ascii?Q?x0lsTKL8/Fvjv4cAJcznbjt3eHG4HQIqe0Su22t3xyRVdMZkn3t6AY00+tt+?=
 =?us-ascii?Q?pgGwR0qVKt61XYPhBW/lVXt+8gXkiht/GAnVq3a216L8aMmleA1TgrTYVuqw?=
 =?us-ascii?Q?gxMgMITEnb8kPjZ8BIRpQeAzAcUOjwIIxS93f1ZvCCh2AREtVr6geaz4PT1B?=
 =?us-ascii?Q?OMxIf20yaXAxj18gTt8mvenUbKGAVukjn6oPIOdF3y5qum3igQLLNxdgO3PY?=
 =?us-ascii?Q?FMpE0gYb6ebjwvRFJPoAShTzMG1PDYCrFt0jv1P6y/2FuiCx8d50vMEevVWB?=
 =?us-ascii?Q?1kmMOZPh1V/V3/vfFwABtyrN4ZfvNu9k7+HpwbV1LkgqizIKy+oOhRLkSGHI?=
 =?us-ascii?Q?CZc8p0w4ZWERCmbNxxY7z1XNivDS8F/4ELEs9uX38YJijPq2BIEjwWZVhOtF?=
 =?us-ascii?Q?vpLH541J4dNTExHsM2NemRRNdTrz3rMlfsPKEBeAFiKrK3JkyPQpTW4Wau3f?=
 =?us-ascii?Q?3OcN8QwS0wXyKa4X7Ndd0f9AxqC3R+pN16hf63GRm7aItvSoRXpR4Hg7d4Gs?=
 =?us-ascii?Q?XMqVdVU0sUAfBCxrjBUIBFIU7Wqp4kE4LoOLplhJJE1jedQuumBBHbF/vkMM?=
 =?us-ascii?Q?gxZ4v5jLiafp81XLUZJFsmRhv7FEK6w4CagvujaQmDd1FFz4EGnANC7gNA5c?=
 =?us-ascii?Q?V92KgEiN5t4Wku9Zc2ELyQKT85Sk8Fjdn0QcZfO2cjvNj3mKR+gXkSHvqJF9?=
 =?us-ascii?Q?iQSJ2ZTNKFyGsOSxPPw9myz6brwg8SNV2+zjQ7PA9ee04IVPRb9B3YGRKuuo?=
 =?us-ascii?Q?9pPpEynRrmInabp1bsXq/n4C9xaXjHfzAYvVgTM1let4q5uCuGo2N00H3RLb?=
 =?us-ascii?Q?Y8nUT5gYDRxPsRXdoYAC38sSHvXLqWKcy4U3pqrsi4bJQKmOBEjrnzrkq5Or?=
 =?us-ascii?Q?FoA/V/UeFyX0Pde/ClQHGoIShnZXAAMNYFTzRo5C7h8muw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c02d4e6-df44-45e2-fd53-08d8e3f7fbb6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 19:09:09.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOV4709Y8uObB7VFTQt4uG9F1Moolv5AiQMfXUbKGSZl1dG6tKzTKoHZoVziR0ri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4598
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_10:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=980 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 10, 2021 at 10:42:29AM +0100, Michal Hocko wrote:
> On Tue 09-03-21 12:18:28, Roman Gushchin wrote:
> > On Tue, Mar 09, 2021 at 11:39:41AM -0800, Shakeel Butt wrote:
> > > On Tue, Mar 9, 2021 at 12:04 AM Vasily Averin <vvs@virtuozzo.com> wrote:
> > > >
> > > > in_interrupt() check in memcg_kmem_bypass() is incorrect because
> > > > it does not allow to account memory allocation called from task context
> > > > with disabled BH, i.e. inside spin_lock_bh()/spin_unlock_bh() sections
> > > >
> > > > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> > > 
> > > In that file in_interrupt() is used at other places too. Should we
> > > change those too?
> > 
> > Yes, it seems so. Let me prepare a fix (it seems like most of them were
> > introduced by me).
> 
> Does this affect any existing in-tree users?

I'll double check this, but I doubt. We should fix it anyway, but I don't think
we need any stable backports.
