Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F9E364807
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhDSQQG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 12:16:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45272 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233856AbhDSQQC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 12:16:02 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JG9Wux014553;
        Mon, 19 Apr 2021 09:15:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=qUUJkXQGPRLgHK3O0aTtQROA0Wm0eIL3Cj9nkoLiah8=;
 b=CBgQcPt1G+HWkrTxESJ+eldJsVR4bTD5DjK7I0HbZISRB7wxh+q0EhvsZF9OyB6g8SNq
 bNaYilQkFgWOcBrxgNp8Q1BdCCHz0D1OV4XnsFLt0ttv0ivX3uJXJF37Sa3z93qmYUYL
 fv5LWOCbg2xlPd5uk5gpqP8BA0wmorvfV+s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 381abr92ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Apr 2021 09:15:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 09:15:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeCnJtATaioQqPyCXR/t5swdRrx1vDqbMA+r8waBKq4ELqkAaLCj8/RhRoBe/qf2+4Yqj9pirnbS0KtRDVyk77KJszG47zNm976dJhuha3zac3ya0Uc81As4dRuCAITwh1RcFCZmqSHQc7m1kAwcqwRmHQJ4Ly7qf+Q3o0uKyY9SaI5qOkkZ5ny/G0oieWFkdkQf3n86TVTWLtEBr4CoUb/ook8/e19J2vDvqSrOQuShU+IWtDz7uZ01j2ynD/ujxxwnMVpEIhCKNii4QTGu+qTV9Iezb3Y8qXJlNOndzwyMADPKZ0NvJ4LV+8x9vFFm/xuJOHOb8giXuAWN92qCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUUJkXQGPRLgHK3O0aTtQROA0Wm0eIL3Cj9nkoLiah8=;
 b=FU1s31MfZERsxoXdVQ8OqkDCZoLAy15TW59hd60iEhJoY6t/BGHMKNBjEOMB6bSeTo87gWxuRguekLUZ6SR2KQtt0wP2cMxEvlUons8exM/GPSnCPzHkXDJR+xnQ6Z2N2i07oDibVEqLX9YgMw2Mm18/5vq3zP1NejoyfXlxfihUSYNCnaUFzewSkCdsTuNpY7At0m/7Uyds/liJHgu4u1vajqAGSKFTMJwl/6ML2butWqTbeccGbvnJEQlNhIOO41Zvo9DF4RPl3BgbDzpR5g9hGWJYZxJ9k4I3vIL+dXB+eDtgCEHKevVp7I6bqXntBNEitJ+qX+IBOMOHHnMZzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4631.namprd15.prod.outlook.com (2603:10b6:a03:37c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 16:15:20 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 16:15:20 +0000
Date:   Mon, 19 Apr 2021 09:15:16 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, <cgroups@vger.kernel.org>
Subject: Re: Killing cgroups
Message-ID: <YH2slGErZ7s4t6DC@carbon.dhcp.thefacebook.com>
References: <20210419155607.gmwu376cj4nyagyj@wittgenstein>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210419155607.gmwu376cj4nyagyj@wittgenstein>
X-Originating-IP: [2620:10d:c090:400::5:e8f2]
X-ClientProxiedBy: MWHPR22CA0001.namprd22.prod.outlook.com
 (2603:10b6:300:ef::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e8f2) by MWHPR22CA0001.namprd22.prod.outlook.com (2603:10b6:300:ef::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Mon, 19 Apr 2021 16:15:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1180fd28-5074-43a7-b9d4-08d9034e53f1
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4631:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB463175C98B0FC544D03E745CBE499@SJ0PR15MB4631.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QCTYQ9ofqYAmk48dRiLtRFq2wlU/OCnS6eOtNwO6vSjydDPKv3cNwv6DHWk5nP1f8g6WkK0pnqqIA5Gnl/WhdHN7PHN0CT0tMeffHoiriAbvJPPwgoI/xRj9wXevnjwAoWcrMswhov105awAg8iEsFaqOFselhguIFORGlkgXzCQ1MWYlFpt21m09j59nRueyvcs/Osjc6hz1+i5XajsNsTKiAIAAswkqMTWCk2GPZmPyHMtxBSLuF4QdIEYMsVV/8sCKNJ+Hy6Om0mYlb6jKjzseGGRp6eqn+NxFAipLoJGfKOVg7FxbYy90RlLafKGWavhYmW0Gi2B/TPTuLQGgQnwZP9S8cXYGiNt8kMi0+usXCu8CKwlP4l8NXBIjuw26P1lzJDPVNoRozoSfZH3Mq2wOirSQAqzNblil4t5U4/d2X9ECp+L+fXf68/uOzGr4HDb0+2A1Nrl14U0TlLAV6KMjEXbhpCK7oHwrRxj9Z4GWTGc9DC6K1jsA6VcPfSDhnWHXOLIF0sxG82BEJxOmSqMCFP36Cw3DHLkyLm0AHZXxI7VQqmFg7AGDt5KnhU8y8TYYq8WcLLSTjMwzuwSlmDhKgC+ZkntoiLfT9C42M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(2906002)(66946007)(16526019)(9686003)(186003)(38100700002)(66476007)(66556008)(7116003)(478600001)(8676002)(55016002)(6666004)(54906003)(316002)(8936002)(52116002)(5660300002)(6506007)(3480700007)(4326008)(6916009)(86362001)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RAxeReWZgOhjYN8eZtdZYGquAJ4SfiSH2GVAV3kDbD8q1mFUHqFeP2nwBBgZ?=
 =?us-ascii?Q?U4z7UEqvqAFpk9+ILHjD6nIsXypISE8pX7FDV2I1+NLwIjyIvKM6iupR2GED?=
 =?us-ascii?Q?WcZ4VNNh0iC+7FcYvF7iStxLaW9SAUt71pqbA7/5cxjq1KtRD6Y+TLAt5Tos?=
 =?us-ascii?Q?S6aKHXvAyONeDwXJDXbq4ZN5MAHjuTGeBytDGcIGymhAerhfS62W+kdJf7Ob?=
 =?us-ascii?Q?8l3xUc6G8ph4jfMvs8wHrpFDzYRB59idjVzOnMGjJaTKb4VEqKrS3koFxrdf?=
 =?us-ascii?Q?zzcGL9aGQB+TiMnFPUXuJbEg3ZerFxXc+//aSHgroEEWbofYpLvBLKTrqRAl?=
 =?us-ascii?Q?GIlKyleuebhchP4SbCuUrcYOCaPiGuRZE+LAPD1KzNbeNx1Oyu1LUPj4srpR?=
 =?us-ascii?Q?wcpPcfspkdC0+hytcHoFaZHLOkIVANicXC1sACBO36qpTj9FkBGjlAAgAq3B?=
 =?us-ascii?Q?m8THjLff3w4F9/STdfetWVcYpoGFoj4yfRpTQRd03DBlLJNzadeRvo2PwzMa?=
 =?us-ascii?Q?P1h2pLcRwgPBLjrdxENh8pP3Qsp5JCZv5aQlAACk7IJYyhgfRbSX7thc2fQN?=
 =?us-ascii?Q?doO/MD9q6jzirzSR4PTgfq372odg/E36y+VEq5NrECiJ3oGT1wk+77Az6C3k?=
 =?us-ascii?Q?XgAU/RcZDyHlHUucwPuApuQasJRp24EXyX0ISQkTe77E6aUg9ZmLt/2MXXQ2?=
 =?us-ascii?Q?KXwYROMLK3QcOVQWcwwFfWw2HTZvYOMpPzkIYmewWRaP8z4+mTyUTkwCu8KK?=
 =?us-ascii?Q?/wPdcGgmAQHzFVs+7qv46ziYZoe+yac47wg7fPqW9h2rXPCIwszuUUeOtkVb?=
 =?us-ascii?Q?iTEoAAZoVy1oO4AS16BX0YOFEs0XpDk9Gn2UycWZ81/S8LMo/s2HwrIn+Woo?=
 =?us-ascii?Q?QNA24//T8kSl7fCV90vQECBgx7/DDG7avzand8EvPZxxT/4lfsli0CNNl4Do?=
 =?us-ascii?Q?/1cUuMREVfOVDzBMlvtj7YCazKug9ALE0C+8DTWXU9p4Md5Z0mk4WPj2pyCj?=
 =?us-ascii?Q?Kc9xTvsN/9REnf7gbSn+f8K2kbWO4OUThiW3AFhcMg+Y34US57Ge/4g7OXp5?=
 =?us-ascii?Q?sZ76meTFvfXl5ckJ8om1t0+qSxqvYlzBI+YvOGG/L2Y8iKILyWXXELa8ydkC?=
 =?us-ascii?Q?ihAW0+LK90nrc/NRU96FQWmOACyVfUWjOaISA29LdTyVdhUbGg5DlKuUXNFX?=
 =?us-ascii?Q?Tpt/1G3f0fwaMU3lHdcWT7HCPiaXnYVPumJ4OugV5v9neUIoCrz/QsxDbeqE?=
 =?us-ascii?Q?2wEHTlTYejOazixiWfNpP/3HRBmeTDzNifyjFzPtVWrmGQVtlo3U3oCpB/BL?=
 =?us-ascii?Q?nHhA76XP+FZpaHm8OByQKy+BVNjxJlnrWuTzjzHKRpYX6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1180fd28-5074-43a7-b9d4-08d9034e53f1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 16:15:20.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBjY0Avzh+iRiHPW2VKsNMKiF/CPJ/Ns/fYJmMrcCwUCtGjSeMcvzfW6efIatis2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4631
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: AjDbT2ucEUlejUyC-lsJkwHwSYyDWm1R
X-Proofpoint-GUID: AjDbT2ucEUlejUyC-lsJkwHwSYyDWm1R
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_11:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1011 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 19, 2021 at 05:56:07PM +0200, Christian Brauner wrote:
> Hey,
> 
> It's not as dramatic as it sounds but I've been mulling a cgroup feature
> for some time now which I would like to get some input on. :)
> 
> So in container-land assuming a conservative layout where we treat a
> container as a separate machine we tend to give each container a
> delegated cgroup. That has already been the case with cgroup v1 and now
> even more so with cgroup v2.
> 
> So usually you will have a 1:1 mapping between container and cgroup. If
> the container in addition uses a separate pid namespace then killing a
> container becomes a simple kill -9 <container-init-pid> from an ancestor
> pid namespace.
> 
> However, there are quite a few scenarios where one or two of those
> assumptions aren't true, i.e. there are containers that share the cgroup
> with other processes on purpose that are supposed to be bound to the
> lifetime of the container but are not in the same pidns of the
> container. Containers that are in a delegated cgroup but share the pid
> namespace with the host or other containers.
> 
> This is just the container use-case. There are additional use-cases from
> systemd services for example.
> 
> For such scenarios it would be helpful to have a way to kill/signal all
> processes in a given cgroup.
> 
> It feels to me that conceptually this is somewhat similar to the freezer
> feature. Freezer is now nicely implemented in cgroup.freeze. I would
> think we could do something similar for the signal feature I'm thinking
> about. So we add a file cgroup.signal which can be opened with O_RDWR
> and can be used to send a signal to all processes in a given cgroup:
> 
> int fd = open("/sys/fs/cgroup/my/delegated/cgroup", O_RDWR);
> write(fd, "SIGKILL", sizeof("SIGKILL") - 1);
> 
> with SIGKILL being the only signal supported for a start and we can in
> the future extend this to more signals.
> 
> I'd like to hear your general thoughts about a feature like this or
> similar to this before prototyping it.

Hello Christian!

Tejun and me discussed a feature like this during my work on the freezer
controller, and we both thought it might be useful. But because there is
a relatively simple userspace way to do it (which is implemented many times),
and systemd and other similar control daemons will need to keep it in a
working state for a quite some time anyway (to work on older kernels),
it was considered a low-prio feature, and it was somewhere on my to-do list
since then.
I'm not sure we need anything beyond SIGKILL and _maybe_ SIGTERM.
Indeed it can be implemented re-using a lot from the freezer code.
Please, let me know if I can help.

Thanks!
