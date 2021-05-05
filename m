Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20983743C9
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhEEQv4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 12:51:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12628 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234662AbhEEQsF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 12:48:05 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 145GccBO014817;
        Wed, 5 May 2021 09:46:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=BEpaIDP5RFuqf5+6IRNmCEX0RBS4oU0O6eTJreg0IOE=;
 b=FNs/wzerMcTEirrKb6mebm7CTV83Lumxtefo3xfoSmTwtXZHhXX5oXqVyKol1miHs0Sl
 aMnMJPgXOuKGex1Pm4C+XPpSH3G6juEKXOLpQug2shgWUStFP704c673TGDKs6R5BIEE
 4ZMXa3NItOGJcGSwkoyegBSr1C5CuruH70A= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 38bed1vhyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 09:46:45 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 09:46:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4Lrnf/0KLv7nItyu34PKtRf16wU0yXq/nJUtAQgQFeFI557ycbdf1fQxZChhdkaa80jZ2Y3EozYnN1WwnnjtqJzBXcJyWGrt6YLGJb0rdKSF7i96MkLNpC3IqkRsG4j7+nk5u9a0XfpcHXdfcdAmvTMEj/WZ65dMvw1xk3G7WIocFLfaH+xsn0lbbp2+dU/IWZutDPU5sPdCvAwc2RdDjfnMfFEmwuHfESvyv+JHyK2CbVZvtRQWtzIISd8X78UgheOnJ+Fva/FpniB6yqd+pGiv0v4VAIV+cC7Hhf2/pvCQ5wi/6SqvorwsSNdcFZ4r8QSPQEXM8uBwgl8k4VIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEpaIDP5RFuqf5+6IRNmCEX0RBS4oU0O6eTJreg0IOE=;
 b=IFpcouevh9IgHmt0HrNkEOMeuwg9N3LmD1oSWiHQSWVCO0BhTxXUH+9YoYmWjoXjwZb0NFO0GQ+o37Vj4/IbLkt05WFiTi31jNe5zVK/2g+FgzwV87pSV70u2RJRwcxPmduoqsJ5Rharft+P4t7l/jU4aNF/ukFZKMixiL+WzqLQXSzDwNyWLM+zR3o8Hb7+5EYsTHqwuR/IRljhLDiRy1Dw8ARb/cR2LCBxCt4dMYVX4sUGh6eIvx7PzuNaKpFBnHfSbjJvrkvNSqUKc+rmxnzBO1eqO7WfYs8ay7Y4vV6zOQ7IwE5xOzW+EVS/7tJ/A9VwiUMggnej3u5HNFZAQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2805.namprd15.prod.outlook.com (2603:10b6:a03:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Wed, 5 May
 2021 16:46:43 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 16:46:43 +0000
Date:   Wed, 5 May 2021 09:46:39 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 1/2] mm: memcg/slab: Properly set up gfp flags for
 objcg pointer array
Message-ID: <YJLL74J1reAL0VP0@carbon.DHCP.thefacebook.com>
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-2-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210505154613.17214-2-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:1dc0]
X-ClientProxiedBy: CO1PR15CA0114.namprd15.prod.outlook.com
 (2603:10b6:101:21::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:1dc0) by CO1PR15CA0114.namprd15.prod.outlook.com (2603:10b6:101:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 16:46:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: feb7f71d-1868-4142-83d1-08d90fe55d0d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2805:
X-Microsoft-Antispam-PRVS: <BYAPR15MB280562133C49046AEBF3360DBE599@BYAPR15MB2805.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZJZyddGTgSxUaoIkVOvTMNysvtAxk+0oBme6ssUEjVOFyane6YGezdo8u8uCnjVziJ/1j4BWplUsle5NG2Mr4uALIUoG5Cg4yQkDsCJNtCX1/Z4TvbmuAclhbuDb37HB4EtYIfx8d0RxrVDh8+VgShf3woiL7/9N34AgtCgEqQ3XPESLMWsntVIhst+JPFVtNbhyaKrGUtQShq/EHwGaQvqy+KUKeLxUAZxbHLSUk7KEV3XbltnasMWXDVIvlBtqb5MbJhsTFSRLFFS2CHP/F+AbuzaJUKlEaLOEFJQ1j2P/glHQu+Knwlh1rRM++I84WqFONLdgGSM++hOm6QdoytWwIPdC05ggPMe/ShS9zjroXm074YocPRPb5/qbAnbCzSMIkosF+BSP2zQwc95dWuDM5kU5g4RCGpEFTjeRCA7v3WPT4FlyrKUydCtiWVybRc4xZbUL79AXMuCC81antb3jgWwXJCUUv8ZOLAS7tn99onno99wFiHxl/xmF7ECU7s1QEq3uT+ia/nnSKO/zzDzWBuKNrpl1tdnxhHbF6WNDvJQcisv9mDBI267BWkjRGWaGJQHVN/DngezmIBZtrOZFtQhj8yOf8mQ7uTZxUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(316002)(5660300002)(4326008)(66476007)(66556008)(38100700002)(6506007)(55016002)(52116002)(4744005)(478600001)(8676002)(8936002)(7696005)(9686003)(66946007)(16526019)(186003)(2906002)(6666004)(7416002)(6916009)(86362001)(54906003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LUuYGWOAIWGYWA+QyxxU151yhrdzvKby9X3MPoHhlQgNh5Xb7uJplmb4lt4w?=
 =?us-ascii?Q?fXCXSYEToxAOoq8ANUaMdKGKCJTaOMO7Kclrj2tdMUzXt805Bva9uxCkz6Tp?=
 =?us-ascii?Q?woGaLHJCsuhSpbTPCscdkDdTcfQkoTY+8B9YDtD0J+5vh90+76Q+5wjGXqJ9?=
 =?us-ascii?Q?nfV+trq49TaVcI749jycqq01vg6efonU9X+wwE4zqM/xovKNfCjsx/2qh+kY?=
 =?us-ascii?Q?HG9cOVrj+3WmR4H1ZqOtA7f+K7a3dpRdPEG0PhdMkvfWTQNnISipSCW0mK6A?=
 =?us-ascii?Q?pkeofylyphbeHcGpVcwAd1b8yZFHa8d20wqAw6cgrBzHkRCJxx8wroM4J8Iu?=
 =?us-ascii?Q?AexbCFtflaIeWbNzqhY+58YcKnn+n2CVHsKT2dsOIigQFvOpd4K2Fl3Ce+Gf?=
 =?us-ascii?Q?P11Uu+sMayojuwl/5ZiNLPuIn8cAgbs5vfvc2cEb08ptOVcU+PvoncyyaAZ4?=
 =?us-ascii?Q?Dl/IRetbEwcjIV1wsvUKhpMCVk9XsgeVg0WhVnm2gv+So74Io+RrmPh+a8Vb?=
 =?us-ascii?Q?DrMWbMt5v4JRGvPBHSp25r7mqPWnbVU7VEvTWuxOSr77iPE8T2XWmiFdI/qJ?=
 =?us-ascii?Q?9pJKcK1JRbFjxDKnNnKAloHzYY9/mPOR0aGv2Glb+9PT6BxSQjJ/OzQAnFx5?=
 =?us-ascii?Q?6GvvaCYGsYNkGPGWYm2FVDbwb0CfkrrrnFxqjTiBX6KqC+0On5TbP0lHlEYq?=
 =?us-ascii?Q?BUM6ETNBvq0ETmZOXTg5mx66xuD0L1izsBCmCjHJvyCmp3Z89O+b4olfnHnJ?=
 =?us-ascii?Q?WSLm4iA6hY0I/3YfMVEcxGp5LXSX0fsMHLL2LgIL8LwmbYt3F1ZAtDPdc0Tn?=
 =?us-ascii?Q?RV05nIVNtmYOprZeCQWx7bsp8DD8nE6HI4dYVFkWN+ok4CDL1A2CIFuhO4Aa?=
 =?us-ascii?Q?N3/lgaKUOTQhBpVHBTv3b38ASEGL/fEIt4hSB6IFwhZtpFPViKT61zyBXfBE?=
 =?us-ascii?Q?jY0MNZ2Phw0OWr4I006USSB/2nGpiYiEl0kOPCqvgE19udzWDwqBulTn8Ge8?=
 =?us-ascii?Q?mdRXaPSuQXALANtYdx5MCGLo1ygR2QoDzWFizHc1OrrxTZom/m2/aV76L6TT?=
 =?us-ascii?Q?xdAq96HLLsxGXfDrh3lhC3UdkdBUR3Em1+P6O+S75MFzdSZ6ET10jrtPELC6?=
 =?us-ascii?Q?5rF3+JyJyPR0Toi08BAWurIQk8JlXEAFfKCLb0PUgkkS3TxwhPabSY7Vade+?=
 =?us-ascii?Q?uRi7uS5x0Kwm24E3quYTCQNJMzKYkXuPwoMjfwVfpQhCktIRYmoI5R4njSPu?=
 =?us-ascii?Q?nxEgXhhR1p9sA19s1+5u9fPRJTnRSvr/URMgC+oBqi0AF78UWx6Sd9yGjUzQ?=
 =?us-ascii?Q?sM0rZpi+Wk2C/a52VJDcs4uBb8FIG1dDmAKVa3wahc4GMw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: feb7f71d-1868-4142-83d1-08d90fe55d0d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 16:46:43.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebK7jZpyHfzeY6Bu3vYGCwnS5aPb9THytgQNBTtP1kTzMZMgNGcmtfczqV7Vzaak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2805
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: OBNznwWjYN0gawxGiPmOv9L8G1enyWyf
X-Proofpoint-ORIG-GUID: OBNznwWjYN0gawxGiPmOv9L8G1enyWyf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=878
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105050116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 11:46:12AM -0400, Waiman Long wrote:
> Since the merging of the new slab memory controller in v5.9, the page
> structure may store a pointer to obj_cgroup pointer array for slab pages.
> Currently, only the __GFP_ACCOUNT bit is masked off. However, the array
> is not readily reclaimable and doesn't need to come from the DMA buffer.
> So those GFP bits should be masked off as well.
> 
> Do the flag bit clearing at memcg_alloc_page_obj_cgroups() to make sure
> that it is consistently applied no matter where it is called.
> 
> Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 8 ++++++++
>  mm/slab.h       | 1 -
>  2 files changed, 8 insertions(+), 1 deletion(-)

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
