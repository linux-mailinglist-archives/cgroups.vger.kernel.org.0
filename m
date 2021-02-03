Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1430D18E
	for <lists+cgroups@lfdr.de>; Wed,  3 Feb 2021 03:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhBCC3v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 21:29:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21474 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhBCC3t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 21:29:49 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1132Q833002594;
        Tue, 2 Feb 2021 18:29:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=UyikSY9c2CyK14yztGolAG6yxN2SE3+M5dkc3tRuvBU=;
 b=Jc/aoqFWSrNhfb6Yokv7YqwlCNhSSrrG2308Qymtq471i1pelHXYerJeO8FgYqQITeVE
 Mf0Of4JEoxmC3ZiXkEBmGmgMetawU1Jmf2lnGsKiAbXw0cFqRwdt/xYIUq4VEerWbVdy
 d7CnYd1Vvh8O8uv5h+3m/4hGp+w0FBVBMVY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36fj01896j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Feb 2021 18:29:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Feb 2021 18:28:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6CayDW1O0Qwkk5tBqDQMYs8h0YhaZJaMqjIb5GynDWTSbAItJ429iYUkjVHHb//1BJlVzJReeQeaTlXXSUg2OiXcIHyoc5DDHDNGpYJ8khCVkKcq4bLdgjLntXklu4sp7mojl0NdPvyrkHDNovD+uL4XSWcQVmm9j6DVY/WzqFP8oSzHozk6Rq/w9+PHQgNOBLs/IT+Zu4HcEx2FHo6l7q2HGngJn5se4NWSGd9pnpTSXEi+9xByL1KeX9XRDZsukwdz6Sn+5GbXSkWDppGu80XdXnKZmTdtdSFiaayuFc/xI0wRzWh77Xy/Q6nRnoRHDllcNBgwiHkpEmbHBtqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyikSY9c2CyK14yztGolAG6yxN2SE3+M5dkc3tRuvBU=;
 b=GiMfQcgnRWVmsvYOMLTYSRn8IIdDThUFJXNUyRM2KAPmzpOhU9t0Ky/DKpyPjA7xHi8dNXLUUbIjWdZqwPVWUfAPF/Ra0nEeQLOhbY56+gHIhukP8GDXuPGsssLn3BPI1N9txrbhWaqyAsXXKv3K2hWqusQ9UuGgHbG7zYd2Nz9OBoeAlNB/AaXFm7m7J8oesnaaSxBnCYmXpm6vnQo0+Vu451SXRsz+zRmVvmBmlCHFFBHsNJZ0N6XdHcpkpO4aAgS2Urfdx3FCLCmy58wJhJA8CUon8fF8RR4688lK6cC4jwplUT8gx6odKBvMfbS7j+vU2XmBQ/0fUUiGvR3Pew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyikSY9c2CyK14yztGolAG6yxN2SE3+M5dkc3tRuvBU=;
 b=T4uPRSduQDXHw6fTaE4dg2MoWb5rKzdWQeUZo16QXGq9rukhA6cnfGP3exZNz2jq2IGWzSnxmwuU8/QBTpSy1nkhr2IpImz7aYXSwC8OdfcTCYw/fNX5LKDOym9vt23GrBe1fIDLLBwzPApkSeYvnfMHe8M+Q7JpZQP4toOJctA=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3143.namprd15.prod.outlook.com (2603:10b6:a03:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Wed, 3 Feb
 2021 02:28:57 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 02:28:57 +0000
Date:   Tue, 2 Feb 2021 18:28:53 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 1/7] mm: memcontrol: fix cpuhotplug statistics flushing
Message-ID: <20210203022853.GG1812008@carbon.dhcp.thefacebook.com>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-2-hannes@cmpxchg.org>
 <20210202230747.GA1812008@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202230747.GA1812008@carbon.dhcp.thefacebook.com>
X-Originating-IP: [2620:10d:c090:400::5:52e4]
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:52e4) by SJ0PR05CA0185.namprd05.prod.outlook.com (2603:10b6:a03:330::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend Transport; Wed, 3 Feb 2021 02:28:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52bfd306-107c-4052-530c-08d8c7eb753f
X-MS-TrafficTypeDiagnostic: BYAPR15MB3143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB314385D4114A2ADD2BDEDA78BEB49@BYAPR15MB3143.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMurKx8j8d+I4OHX7XTz4P4bCxl7Tg2mth4iJ+F/PS7hdQMPWl1guY0ZZVtJHDsTacPIQSiK+h96O6p6OWojh5kYtH8fzXv0/BkTwKyHcesx1JVH39J04n32yNplL/Ol4cpeAf+cOLjF/rAgQ9NlasTxTtBPn195/gDvSls+07Hrw+B3GgdcZJpa03IB5wcP5KiM1lMXRU+hE0UnpmYLjQ08ybC9mV+z+yNnzo9CjFP5F1DCIsVQDsuoxK069+ijXJsCmQGPdx4THqN8dtw75y3TxEF6+olVZPiaRdgOKaEfplRPgKD7arNMM5zMzAVIwNTtMA5b7VNrJ+9df7nNmZlSgr9GVUV1sO0n3mdwZ2f7Fm51PV9Kz2rqsbwwP0xV6biQ9WVZCkOmsbkiRqX1WbkW4O7VUhUBkKRMPK98oLcntd5Zz3j0zuFbKPtpFq50lbc1oENxObrfJ8lG1nzUyMTrwuVB+8UYTW7/zb2nTmB0gW9DJ7zWY/+DgigarQ/xp1DFX5fK7WBg+rdsbyoang==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(396003)(376002)(4326008)(66556008)(316002)(66476007)(6666004)(86362001)(5660300002)(83380400001)(6916009)(8676002)(186003)(16526019)(8936002)(7696005)(52116002)(55016002)(66946007)(6506007)(54906003)(478600001)(1076003)(2906002)(9686003)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+qY5KrCsru4rT0h3IzBLmgol97r59Z8i3wSE0EnDSYMnIP+p7p6uDmPc0qYe?=
 =?us-ascii?Q?W7qFtdkOS+kuJRydWlKuzBxye3lO1BOy5KeDW+CPR5VzFSCM7gRq9jN8O0L4?=
 =?us-ascii?Q?4FUdOiQ5R/fdVBhC+p/OJ/7nkHGyfFgh5jjvx5iZE5BOLLw3iFadwoeLVtDD?=
 =?us-ascii?Q?XmYVKiQFWZOYQToO9Cfl90bSJFCRIRJWo5ICpqahX9v2l2TfBoKIww+TUBFS?=
 =?us-ascii?Q?luW7T6OpX6NORegDFjrQG51HuPm6ROBSxP7YEudNEeV8syjb5EWHl9J25nTp?=
 =?us-ascii?Q?2Ay3ryucsP85Fh9WSgeuC+hkLz8G0ZhiWYSpxO750cdI9EkUW6Bb6saa3pVk?=
 =?us-ascii?Q?rtRzk3jyVvnLwFLNBORDkVRSuNZulLcmVfJ0pBJCbUBzKDgdc0RJaPc5JPwn?=
 =?us-ascii?Q?b4tq99ul//vu/MBbgWNpE134dsjMbIY4/5slCu89rantjEO9OKofYsVYssBk?=
 =?us-ascii?Q?C9lzgPoxxJcs4AnVIoBwtgDp6YmdZLEH4E8gHW8CiV3ypWuZ91ilaYKuiUMS?=
 =?us-ascii?Q?puucTbj43B9bDltr+UwZ8vScnvczsxhse32+4nK6uPNFxXJMvYZgXiZROOUZ?=
 =?us-ascii?Q?eAISwMgb2PHs+5TeA71dhjR+8TIpDn1px+1ZWeDowm24SkjNT/gIBtmT8ecj?=
 =?us-ascii?Q?rxO0+BvLltfoO9ll7GMQx4xiUU6qJCcUTUpBNaNveieR5rMNCYWXz9AosoZU?=
 =?us-ascii?Q?ijnOoHMwqrqBXbr7glzbdGFJJsZJHeBMiTDG3O/6C9wG++ev4gSvfQBSIL42?=
 =?us-ascii?Q?OfXwzJebsKMEv/oUNQR/85FdTTnNn1wgLPeWaZ3XKSkX3nv+vjTsLmbQqcv4?=
 =?us-ascii?Q?Ktw6ZIZ+bn6PU+NG0qeg+NxQZFNIoY5SLA7cyLiIYO6slygAWcV4EKASsNyX?=
 =?us-ascii?Q?mCkF31Tnk7x8EA7b8MKl8lRdUcpN/6ZMqkektqhJqG2HZjOsE7G/RuBoD9Qw?=
 =?us-ascii?Q?kCoNbNklKeJrwzC2186s1ev6wo7KUrGgZ47aNQS2ZaZFsdvUbrxlbuGT6UyX?=
 =?us-ascii?Q?ugwdnvUf6yEuAzvQYpVMDxXOUSNaUvTLI+HLwhKUM6A17Me/khUN35RoCWWR?=
 =?us-ascii?Q?pM72POktRBgplavonT6wP8qv5gixMj/LaY/hSbU3hIX+2odIdg0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bfd306-107c-4052-530c-08d8c7eb753f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 02:28:57.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44HhOBNotDbxeIwmzU81E4f3J1iWtQIzGgs7KNJIRcTYWaw7r+fEbTgdW22UsEuR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3143
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_13:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=906 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 02, 2021 at 03:07:47PM -0800, Roman Gushchin wrote:
> On Tue, Feb 02, 2021 at 01:47:40PM -0500, Johannes Weiner wrote:
> > The memcg hotunplug callback erroneously flushes counts on the local
> > CPU, not the counts of the CPU going away; those counts will be lost.
> > 
> > Flush the CPU that is actually going away.
> > 
> > Also simplify the code a bit by using mod_memcg_state() and
> > count_memcg_events() instead of open-coding the upward flush - this is
> > comparable to how vmstat.c handles hotunplug flushing.
> 
> To the whole series: it's really nice to have an accurate stats at
> non-leaf levels. Just as an illustration: if there are 32 CPUs and
> 1000 sub-cgroups (which is an absolutely realistic number, because
> often there are many dying generations of each cgroup), the error
> margin is 3.9GB. It makes all numbers pretty much random and all
> possible tests extremely flaky.

Btw, I was just looking into kmem kselftests failures/flakiness,
which is caused by exactly this problem: without waiting for the
finish of dying cgroups reclaim, we can't make any reliable assumptions
about what to expect from memcg stats.

So looking forward to have this patchset merged!
