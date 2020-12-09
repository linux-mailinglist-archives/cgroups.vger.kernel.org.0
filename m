Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D22E2D38BB
	for <lists+cgroups@lfdr.de>; Wed,  9 Dec 2020 03:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgLICWg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Dec 2020 21:22:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4020 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgLICWg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Dec 2020 21:22:36 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B92GJh1004123;
        Tue, 8 Dec 2020 18:21:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xfwR2nE23+/4cUSXy7PEa+70+zQC3cmeVhVai4i1q6U=;
 b=mEMkusAX4OJr6/0Jt7UWCapOJRsULO155QtQEdpJFJRs9vj62HlKwi4Lh+SA5fKiH12R
 BXs+EVXFLRXdiHWqut1zfiA15hVUm7sRZbkhWs88dhnxZvTUoO6YNRKRGdHMYpC4BH8Q
 HZ1Ca4NzljcKkkJ3XadXos7sgFJfogFmfOE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35afx82udy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Dec 2020 18:21:40 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Dec 2020 18:21:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSc+Qm5fAQGdcRHILE8Rou4MV46WOjm+Jg9rl+R4vmkh752GnwwrlaBJw2JcAU7wwD0JJLA38lvjXaB3XqiL5tl+AwR3JUFqdd0XMspNUrHE/lMXIZ9z2u/25BXjzVErFoNYDeS3TGcBa/k6Uf8l/yCWko+q1aXHv6BNN0G9DjqhWe3mDYAJy5EMCamdBEnadP6/FppttDfwumLPNCEg4GyJdi15IALg/reK8VS2k7PgLXk1Rl9NdpV8zTuG5xurgitelxMpoiFQwi29tgU9uda7GOoabzKJc6Occ9AVkUY+zDvEymxJb+sU8J+m9wOCiTYsA3dF8eAAvY7PqjK0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfwR2nE23+/4cUSXy7PEa+70+zQC3cmeVhVai4i1q6U=;
 b=aKL/8cN1FmGhHiE8PiUw21RqMyOa11PM0pvBCpvMtXReKrtRrkQyGqWdl/N8ZKDKD+l0sCX5ZzxAHRY10xYJyUsMghZpJ1baFz5Vy9jp8974rp4BpY8zwUfOIWaDrUsi/kstLWT/UkhcEFBrjnRNi8ypQvlg0YU8BbFOco6y2zlp+ok9GwkqtNi4Xwz9VkNky438YRqJE7VlqMAUo2IgQtC4nG9I34b8Q356xFe8ZiHsvA9A9tF1tDR9cYOjNMntkB/9fHtrq4Jdj0ZypTTI+n3Igt6hxQ1VSH3B8Vxzn1ELLS9T4w1kYQjeVpQKNkyTneeSQ1MTqgx1Gd2v3fZ+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfwR2nE23+/4cUSXy7PEa+70+zQC3cmeVhVai4i1q6U=;
 b=IqdSP1RlMwdTljZxKFnyUXdwXqE/JFSHSWcFPYjsnsqRNsfPWmrEAdu8igK+6NFYdVTUubGfCp5kDy/Jc+MZo9yayeSFbDE5ZofliueAaJp2IuGITCnwTrekB5c4cDSZFTqi+I7t7j/jJ5JWp6VgT5VvCHUcYSrqaWImWGbXpzc=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2599.namprd15.prod.outlook.com (2603:10b6:a03:15a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 02:21:23 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.024; Wed, 9 Dec 2020
 02:21:23 +0000
Date:   Tue, 8 Dec 2020 18:21:18 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <sfr@canb.auug.org.au>,
        <chris@chrisdown.name>, <laoar.shao@gmail.com>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: memcontrol: optimize per-lruvec stats counter
 memory usage
Message-ID: <20201209022118.GB2385286@carbon.DHCP.thefacebook.com>
References: <20201208095132.79383-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208095132.79383-1-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:1ac1]
X-ClientProxiedBy: MWHPR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:300:93::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:1ac1) by MWHPR17CA0060.namprd17.prod.outlook.com (2603:10b6:300:93::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 02:21:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1635f64-abb6-4169-30f0-08d89be91ff5
X-MS-TrafficTypeDiagnostic: BYAPR15MB2599:
X-Microsoft-Antispam-PRVS: <BYAPR15MB25991FF976CB8F62FB986376BECC0@BYAPR15MB2599.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IvuYew8c0W7l7VyH957+EdW8j74OzMtYwpQyomcJjQXxuFWCec8MfSrYncFBO+nn4JfSFG+0W28yGWuT6fP8XYp57ZM6nzSCjVehKQIhmK9KzwvbeYfbLrCJBy0vavLalA5fEmfcjZzMLIreovAOUMg8oouitbzPryMk1eTZaPwMd31hhi93HbhxjEjL1DG6Qf5E1OpwUi6fF+iTQq4l1Og1Uk2FgaOgGuf+ovN/y9bhhup9aLDvgAVFleYzTrO46Lq24j+gagzhyJH8zLNoHq5GlYsYQdGKUZAtTX2qWt+qu5g5Uosdr4tTkn30jAVaApENas5ZJjiG0u2Wc/CyKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(1076003)(66476007)(8936002)(86362001)(5660300002)(66946007)(186003)(16526019)(52116002)(508600001)(66556008)(6666004)(6506007)(4326008)(7696005)(2906002)(55016002)(33656002)(6916009)(7416002)(8676002)(9686003)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3qxED1pfJC8NlzbU795aP+324sQUAYN+ANlAKuiVf9U+qBw4pjuAoPcFNYVV?=
 =?us-ascii?Q?glV45nAxR+kTmCxnxwg6sbUqllX9yr6ZE2hZOfGeDltN/CwM68qJ1Dov91mQ?=
 =?us-ascii?Q?pjckXv0B/XsETUSpPNtRqmZVCzKtj145iBLQ5/WB+iSGDAtBuuGRcGepMVp7?=
 =?us-ascii?Q?P9kihwIOFKq33AUjptD/1L5Z8vFJTvkFoCpd7pbgXxNtC1DtO2rDc801ausS?=
 =?us-ascii?Q?6rS5LJlRf5I43cfcb5KfU00loMLuQVQ29QFr/DzqaDIqEn4J48nGoiwXSskh?=
 =?us-ascii?Q?rAlXT//MIg6AxxsJGqloAkr26WyjarO69jbWt3A4v17e8wqvt+qOmhk0U/nL?=
 =?us-ascii?Q?rQf4rZJ1FajwyoWku50lP0zV6L3o4BvmJy48kSSqyHh3es57u76lRerSDgGe?=
 =?us-ascii?Q?GWeqpl0yOCsmGH0Nf4d4oCC/xUXoxlWC/hkxUUAjI/92b//hQZ7kgmeS//aQ?=
 =?us-ascii?Q?234YkvqDFUninVDVfA7iP//c2yYol/oOk7H9EO8+DCkv2S18Cwf+++GwbBEk?=
 =?us-ascii?Q?4VYKq/IYqXiDYuvGuc+hkpb6GktOK2uNbJ8tkoNNYI8dXnbLQYXcBXv4bik7?=
 =?us-ascii?Q?kfeV+lMH3mkRdeOwYm7fpBCkfmLYC2lv9koHOfvPyxVR/IoS/5+NQldA+xID?=
 =?us-ascii?Q?4yPf+88iaVsKwmYiwqXYsxyA4IB8efGDRedQF2sPYi5FU5aNaLDkaNJuD5YU?=
 =?us-ascii?Q?jDr9rMB1y05AZMCofOVeFVVLewDAkEelK8m7j1XmdqDRMuKmVikkmJHNv+AI?=
 =?us-ascii?Q?US/zsouiwow3tqOxPJvR3yilMSe2S0jm9gJNlEzHPv5gCj7yH0XjFHTJXOrP?=
 =?us-ascii?Q?XP6oLFUZvKbYEA4QQKdSEMxLzCT8+F05VlH6sAiZB8DxhtFnwJDP3IuKg9qw?=
 =?us-ascii?Q?7y0yQDyiSiaW7Kp1ZmbDoZ3ET5s2Qsc2ZSO5uofgoT1n3PDI0fStYM7s7AaQ?=
 =?us-ascii?Q?f+qy213QNPneEnhZ11GeBZYlJC8ArG5nnR/X8JBe8wl8NWypOBF2Vuufra/J?=
 =?us-ascii?Q?QgFv7rma/H2SkwjV6t4fHlBPGA=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 02:21:23.8513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: d1635f64-abb6-4169-30f0-08d89be91ff5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkl9Ov2alxVhLhMHNkPg7cdXFAN6tj8Mvo87JurfNOtTq9Y6hCjfQy2STTlN1Sow
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2599
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_02:2020-12-08,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=1 lowpriorityscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=954 malwarescore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090013
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 08, 2020 at 05:51:32PM +0800, Muchun Song wrote:
> The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), so the type of s32
> of lruvec_stat_cpu is enough. And introduce struct per_cpu_lruvec_stat
> to optimize memory usage.
> 
> The size of struct lruvec_stat is 304 bytes on 64 bits system. As it
> is a per-cpu structure. So with this patch, we can save 304 / 2 * ncpu
> bytes per-memcg per-node where ncpu is the number of the possible CPU.
> If there are c memory cgroup (include dying cgroup) and n NUMA node in
> the system. Finally, we can save (152 * ncpu * c * n) bytes.

Honestly, I'm not convinced.
Say, ncpu = 32, n = 2, c = 500. We're saving <5Mb of memory.
If the machine has 128Gb of RAM, it's .000000003%.

Using longs (s64) allows not to think too much about overflows
and can also be slightly faster on 64-bit machines.

Thanks!
