Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046BE36DEDA
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 20:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbhD1SN7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 14:13:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9414 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243434AbhD1SN6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Apr 2021 14:13:58 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SIBr1D024918;
        Wed, 28 Apr 2021 11:13:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=dsHrC0BjbEnRdj2iXri5RWr++ZEC426Y3RuW5qu1hgM=;
 b=iGEfniD9ISsp+l1d1HNw83p1ywSYMBAf8xvMCkGDI0IJ0ZOn1K5kg2riN7exJwNhXxvW
 KOTrAPxUJfE0OOFY0V5/puJWXK2ChqfDIOt6SqwquOdYLXYUds8aXDb11w90BIBiBE0f
 1EIYd3jTV844sY13kyWloD5l8sdUpN0a0Xc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 386wp5mqgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Apr 2021 11:13:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Apr 2021 11:13:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIyAfG9R7Yig+Zb9bu1YFDINsgtG0oHIXOcYTY9g6RrR7PkS1292qAFn0/4Dt1HIeAp23HKWSJGAAh5VOd5c8t5o7MFmYNOFtIJMmvy5gR/4nlWem3fmyoyWmT3xzSK/knW7XhN40BPRUapRrGjBNlaEmR+ECV+eQjubyDGg6zzppJ0XJ4Am7KbXCFviTxctktHpHhKiUNpzXfWWYHxrnoyWEYKetjXLFgMdBXvijxOmP5G5yCy047FPCjqFv81Vs6REg4FwQiZB6VWaCF47mFUzuJiZswFaq/A1S/PUciev3Ny9CKivtEYYqy5XuZtZZcsDB5gTAZVUkSAtMvRG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsHrC0BjbEnRdj2iXri5RWr++ZEC426Y3RuW5qu1hgM=;
 b=SahDjRDCz34WkV6n2lDJaB2+72Wly+g1gtr4WG3h48X5M1rPHav8+s9HpMTk383hF7wN+8d8pguhAEOsWXlE3D+DhEQyIpTTAwnokp5036cTBctJird0DQOvRo98+LTvDgqzeDW7x+PKJ4SV345/wbbTutInQ9neGX7O8HII6p2ED5+paNs830TOuo7x2M2Gz75rgQOT60GxGhBmrJhPss54bT00DCv/S5bWy0XC04IAX5gZkMT/UHggh9zBMXNsJYCkOEMujcDhpFyiPMvZr3GHNu0wkT4kLC333YqTAsVHgybLR4TFv9BcaUSu0NPFoeL5OHwic/3K9KOf6QOJGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4358.namprd15.prod.outlook.com (2603:10b6:a03:335::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 18:13:01 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 18:13:01 +0000
Date:   Wed, 28 Apr 2021 11:12:57 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Christian Brauner <christian.brauner@ubuntu.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, <cgroups@vger.kernel.org>
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
Message-ID: <YImlqYSpkAD4uaxG@carbon.dhcp.thefacebook.com>
References: <20210423171351.3614430-1-brauner@kernel.org>
 <YIcOZEbvky7hGbR1@blackbook>
 <20210427093606.kygcgb74otakofes@wittgenstein>
 <YIgfrP5J3aXHfM1i@slm.duckdns.org>
 <20210428143746.p6tjwv6ywgpixnjy@wittgenstein>
 <YImHjGGuIt0ebL0G@slm.duckdns.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YImHjGGuIt0ebL0G@slm.duckdns.org>
X-Originating-IP: [2620:10d:c090:400::5:57eb]
X-ClientProxiedBy: MW2PR16CA0067.namprd16.prod.outlook.com
 (2603:10b6:907:1::44) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:57eb) by MW2PR16CA0067.namprd16.prod.outlook.com (2603:10b6:907:1::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Wed, 28 Apr 2021 18:13:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 542b28d4-6009-46a5-e839-08d90a714234
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4358:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB43585B852E0A9CA67832EF8DBE409@SJ0PR15MB4358.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UcFZDFXgIHPnkiCLnxzDKjz2vNlkTDS7pRO/JZjzP17ohMhLl8dfnLK59FTZ42iF8ZDdsGL/YUq/ODQ+VqYJWunXbXLNP/+Vvo0/mq7wueyH7xbgrIG8H8MgzcjNj+AcFiwNGGOhMtw5MpyNFnBf9yIw98Cla4OsfvM1/+wHroVLY+q8vTg27wRaQzwzwc2UMBcKEw693MeZuqyBmUN1AQ66UfXdcF/TFUbz83IpQiP1vCrxWk5gYmCpaP55eB3MEeFKS9QsIBOzrRL6WEvDUvhpwIwTxU4ls2PUJmDoBRI+ru3NWprEs8a37dWiOQOI4o8PHUNxSgwc9LZp+TKYCQ3ObZMugZIBSy4G91ze0WN6F3uyNEbVkylQaYsK2h8hwFXhQxhecqMqoyeVvGeYUU3ub3WUgDvORJRUMNrW/Dp69RXfFnwWDMMDo09dMzyUeQlMPQGWikJFafpQn9VLC3Sc+7Lai6V67MJm9t2U8mybufY4hVcFvxKwQiub/bxXBhR74/wFmnEbSO5/froyda9FIsvwjTCEvSEIqtmdQrRLyppSBf/Bl8/9XpJqRMgUYwU8nD/cjjpNqMXCopHgpV29po3IU87kBP85CI7Eh6x55WndgoOUUl8+DirXLiOiuOEPGBwQgqR/Q2LIfdJzqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(54906003)(4326008)(6506007)(9686003)(52116002)(7696005)(38100700002)(5660300002)(86362001)(66574015)(8676002)(2906002)(66556008)(66946007)(66476007)(478600001)(16526019)(6666004)(8936002)(186003)(6916009)(55016002)(316002)(83380400001)(60764002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ydpgHmaRYuOvj3I0esWDUYXHGXSxjFOs8M/MGBUGtqFD+upPITP95/Iqt8eh?=
 =?us-ascii?Q?2e23wURmDs+CFT6I+WJBk52AzEDVYrk8KzEFoquXk2FwYMCJqEX13TQ9u8G/?=
 =?us-ascii?Q?uc1XUkK2PKEn42AAYEq8pmNd8sKVe0lIhFhgcCkQBjGpyFASfDcJu3F25WUM?=
 =?us-ascii?Q?Ky9MFpx5WWqpJce8UaKMIm8DIxdzCNLqwhjKu2sYXu6X7nGJZz8RDS81jbBG?=
 =?us-ascii?Q?NpM767Enoua5OxICgra8xEIJKw4TId34P807zNSLKo0xApK+SaqaC7i+iA5C?=
 =?us-ascii?Q?T/z2LrstfHJx1tWm7PnM7pMy6Nudo/Y99viZ9wXmexgZL86HsDucSkCk4PVJ?=
 =?us-ascii?Q?SSqC/mIlAx4AF+ekoAxdLC6htypOPJ3RNVLssKX64QruuD7mvu2HRRZ3IsF3?=
 =?us-ascii?Q?bQmol32M4DWjM/2EcWOiHPRsLNxpehcz7f15oDKxkL4GDrZwoPkLw/fuF4mg?=
 =?us-ascii?Q?1LnHhuUnvXUfui+spz7vpfkMcap4JGmnPvV7BP8PIbkanNi9/O1sT2IptoUB?=
 =?us-ascii?Q?RXDD6x92nWArHgtocYVVYqEyez5BrAdWnYCBvU1fmN1s/ZZpoq8y0Py0zix6?=
 =?us-ascii?Q?JZ9tKFtCp0kGTsIj+iRJsVrOQG0tgCSnt7gK7CXKNavnT5TF6qGreW2LebfO?=
 =?us-ascii?Q?lCcm3YVlEfCLTyYVy0uQIIIOUpukM1oNSKENxwIivL0jwPhREPQrmztmWcrQ?=
 =?us-ascii?Q?If5CWPZNAVxDYqZD/K8zmPLyNHVFpTBSXc3o78FEl0dUim4TlpJlWbZ4scfh?=
 =?us-ascii?Q?888eyS1JBdwRfWkeflbVww3+Ko8a4Wi7E6ZULssxyHMlqteHK4Xd3Q5Kp6Qi?=
 =?us-ascii?Q?pZy4j/4UU0hHRvsb2ZC32DLCkv0JTtm0HtqmueVOOpJ/RPPc0P8cSSTwX94m?=
 =?us-ascii?Q?2qkpnxQO/sCsQ9GO3Dzym52Hkt/EljfCUM8yJtxZ6ePsWVhi+wN99WdHG4v8?=
 =?us-ascii?Q?QYEQlyigA9IuMQMGPj+HhaoVWjJYCF2JhJ+F73Q1kUGjjIqPKykkRjscfttv?=
 =?us-ascii?Q?LAKevX1YKTdCHzhuIZJm7/nvcC1gVMS8ZM1v8VOAepBEI/9f+blitafK84uj?=
 =?us-ascii?Q?Pp3AHuVa2kOXGuz+7dQNiJ6cjXkGAi4qRArSci3VkzCYX512QKQ9V+Go1b3X?=
 =?us-ascii?Q?lk1DYf5BbVkGPKzwHUONEpjVSfJqprENBQpwLwcxZVgLJCwLc0CbKrJv30Up?=
 =?us-ascii?Q?Ttfkrs2Xr2PBNYeRbxXW0yKrrK6ta5RJNdWYbUVCODQfmF0lEB/B1NQvvzzo?=
 =?us-ascii?Q?RfhcJP8y99IML4EIUyU9IXSi2rReyq1sG7L41b2KNC4DHyLwKTBMEDpo+BrS?=
 =?us-ascii?Q?9dgditW4iMbLj2hzgXMn5DI99y143F344jjsN/2jTCcvjQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 542b28d4-6009-46a5-e839-08d90a714234
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 18:13:00.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PovbcIILv3LhbaPULpE9T+7EPt92ws+a9wi3NFtRu0I8QSFIe5Io640DVD9VzxnU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4358
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: EDN1QhSxi_QqSaU4IlZiCtS150zeQb1W
X-Proofpoint-ORIG-GUID: EDN1QhSxi_QqSaU4IlZiCtS150zeQb1W
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_10:2021-04-28,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 28, 2021 at 12:04:28PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 28, 2021 at 04:37:46PM +0200, Christian Brauner wrote:
> > > I'd align it with cgroup.procs. Killing is a process-level operation (unlike
> > > arbitrary signal delivery which I think is another reason to confine this to
> > > killing) and threaded cgroups should be invisible to process-level
> > > operations.
> > 
> > Ok, so we make write to cgroup.kill in threaded cgroups EOPNOTSUPP which
> > is equivalent what a read on cgroup.procs would yield.
> 
> Sounds good to me.
> 
> > Tejun, Roman, Michal, I've been thinking a bit about the escaping
> > children during fork() when killing a cgroup and I would like to propose
> > we simply take the write-side of threadgroup_rwsem during cgroup.kill.
> > 
> > This would give us robust protection against escaping children during
> > fork() since fork()ing takes the read-side already in cgroup_can_fork().
> > And cgroup.kill should be sufficiently rare that this isn't an
> > additional burden.
> > 
> > Other ways seems more fragile where the child can potentially escape
> > being killed. The most obvious case is when CLONE_INTO_CGROUP is not
> > used. If a cgroup.kill is initiated after cgroup_can_fork() and after
> > the parent's fatal_signal_pending() check we will wait for the parent to
> > release the siglock in cgroup_kill(). Once it does we deliver the fatal
> > signal to the parent. But if we haven't passed cgroup_post_fork() fast
> > enough the child can be placed into that cgroup right after the kill.
> > That's not super bad per se since the child isn't technically visible in
> > the target cgroup anyway but it feels a bit cleaner if it would die
> > right away. We could minimize the window by raising a flag say CGRP_KILL
> > say:
> 
> So, yeah, I wouldn't worry about the case where migration is competing
> against killing. The order of operations simply isn't defined and any
> outcome is fine. As for the specific synchronization method to use, my gut
> feeling is whatever which aligns better with the freezer implementation but
> I don't have strong feelings otherwise. Roman, what do you think?

I'd introduce a CGRP_KILL flag and check it in cgroup_post_fork(), similar
to how we check CGRP_FREEZE. That would solve the problem with a forking bomb.
Migrations and kills are synchronized via cgroup_mutex. So we guarantee
that all tasks (and their descendants) that were in the cgroup at the moment
when a user asked to kill the cgroup will die. Tasks moved into the cgroup
later shouldn't be killed.

Thanks!
