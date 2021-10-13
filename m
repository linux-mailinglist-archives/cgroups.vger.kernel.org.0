Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC96A42CD39
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 00:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhJMWGB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Oct 2021 18:06:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50592 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229754AbhJMWGA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Oct 2021 18:06:00 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DLsQdg011337;
        Wed, 13 Oct 2021 15:03:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=2yYmfk642mQwFFUimUIRHFvXhzSEK0e061gZFS0gQHk=;
 b=P6i+TaxJlkDvVcrWf7MB+2xKvB2v9riQYOWt/JLZ0IHUUcWMeI/A3esUvPcl+1kb67rV
 78baaQPr14u0rX5R2cd+070irVvpeijG28ZODqbo5UuoZ7Wbu4bQ38vsUSatndVXRP0m
 Fp4Tl12YumSIFts5wicj17A43md9WV73nQ8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bp5tt13qv-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Oct 2021 15:03:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 13 Oct 2021 15:03:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5iAzgx+1Ju4vAlsMV1WUi9KzQ+Yp6mZQ1zY8I/OIZEebX3L36MZ8pk+Wj3p5t5NNAIKAL0zXjx0aBQAJ9KalFmvKV1yYukoDO/i7r9Q/Bg73AyuqR0HznNIoAkuoyH/sdgC+Vxj49w+W4fGd/VXKOoDqiqBH0LY52rkWXLSXCe2JM9YgQreoApQAX9lzl0xLNgfHJtGyqj0kDpQzY/Q3VV0cco5DriI9aliL4Yp8Sj8cyMQFsgMHfb0s2hs+lijjhFP+GLwlQ0+ez6Y5Vcf5fNwqkQKk2nnqoDpPfkUTJCIrAyxhoR2cMlorPiRHoKVBJS9Q0IPrHx0rGntNDLxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yYmfk642mQwFFUimUIRHFvXhzSEK0e061gZFS0gQHk=;
 b=YZJrEqd0exJZ7ngkZj3u1Ll9lymhz+Y2fdHzvUnaKK6yhT1ktcQagPLix0R2f27YovITW0XcYoZfVpCI7/0WN+dvmntLU2p5Tu521aiHwgPwTETLdrio9c1/zNrPOm4AavxsMcbBzJHKVD+YzzSyLe/Q8i+FDLZFuG9CrxKnhns47ZMtsbZf+gNOxzR2sxKHaW98JgriM0a5hbengTAJ+cgJ6nufOy4hmR2KRm9UWo3pjBIuAjfs0B+HWLPMYQGb0rjbT8bNBlsYE1uyz165eKR2Bu266X8TLw0R5Nhho/ll2q1IYeFi+264xVufBaRDkPJFWbIG/Ri+1wbNPxrP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4932.namprd15.prod.outlook.com (2603:10b6:a03:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Wed, 13 Oct
 2021 22:03:47 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 22:03:47 +0000
Date:   Wed, 13 Oct 2021 15:03:43 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
Message-ID: <YWdXv+RBjXvdmsK+@carbon.DHCP.thefacebook.com>
References: <20211013194338.1804247-1-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211013194338.1804247-1-shakeelb@google.com>
X-ClientProxiedBy: CO2PR06CA0074.namprd06.prod.outlook.com
 (2603:10b6:104:3::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:284f) by CO2PR06CA0074.namprd06.prod.outlook.com (2603:10b6:104:3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 22:03:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cef49df-27fe-4810-8288-08d98e955466
X-MS-TrafficTypeDiagnostic: BY3PR15MB4932:
X-Microsoft-Antispam-PRVS: <BY3PR15MB4932D4B7E9D16A2D3931CECBBEB79@BY3PR15MB4932.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5O9JgRWFKu/AaNtzIY0KbAAx7kP4e7rN9S+VDBTliRwAQHzWnyqaLHuIZk0M+/ClUPBlwLsmK0T10DihALjiMnaWk8cdI2v9E4GKyhXWp63ytTmiErnEg29bNvPE8pWUL/hBIq+g3ALpQ7xu5IQRS3sbO9XtPnCjBXDVjDpoRpgOr/tpu1vXSRTiJYszj4AxFj0vQxGgxCp53gLsxBYlA+/GsI54IN2BXEEqOLLJf6ZpyH/HDnLhLorlLgVM94vQ8bUPDs4h465EsKOcQdyyVgo7+4+lKvpPgzmGJz2GWbPR7JTWN0sJTCpotC0IGF9Q2tPCfnicZ+4y4SkVg9MI+hwGo7QxDegK8gOd4CpHGjBI7oKsAIlrsM6khrjjPGZtfyrIVybbrg6iOyVMz0KMuVdAJ9SBLO+WFJhbti7UgUuO1HNHqWzfdOI35agNc+CUz8ocx1WB//xBPDLwm1hCI13fvv6wZOl0EJcOduM0I96saaKRYCwq1hk+OPhHKJ9vPOxNRBgzWjaYUriguYshwNtHiv0VYQg0plPsbz8OygBZWZXxNvn+kwRAGpIvtAeP2Ik1NN9eAkkddwuqz/+FOW1sr2NEqEqQ7aiWHVegT42bP2pgEopOJG3gNwd2iE138+LtBvvhXtxdcrzwQ4w+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(55016002)(186003)(8676002)(7696005)(6916009)(6506007)(83380400001)(9686003)(52116002)(4326008)(86362001)(7416002)(508600001)(2906002)(8936002)(6666004)(54906003)(38100700002)(66476007)(66946007)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SDknYSziR/oSpiHB1UyDxYAy/ngCTT9g80m2KuDkqd+ZCo8kOINNK8dB+d5M?=
 =?us-ascii?Q?CB6q4uMLkZT/wbJVmh48i8K79gUu/s9KtwdUk6lxmxDTR32T2RQMgjgt85+u?=
 =?us-ascii?Q?B8fJQNRs1E5O2EMEgrFWHEKf3QiFCyp/6/CTxspM1iezJWVNw5rEyzZ6jrp0?=
 =?us-ascii?Q?6iLOvbFCwRtGhKe3hekVRhnyIp/K7c64LCUZH/Vvwjz24YNoXP2BEPclDgPL?=
 =?us-ascii?Q?sV651p/o1k0EbMY6Yk1b1+H/jf49f0hY0oDbXglhva8ilsWg3KN7GcoE0HMo?=
 =?us-ascii?Q?78U1wm160UxPwcj6AHg+KgKQPkrX3OWLo1IHse+ZkrprJQS5EyP1SweDp/Ud?=
 =?us-ascii?Q?17yeYPfS9YYFHAAlBeAFqxeMi9XBV4trihTcK5wJmSnyqNAR+Acq6jVcPnfx?=
 =?us-ascii?Q?/g1ePrV6Lixk8qCLL5LPuInSq0w0nAehPmWeM6IYxpzqXOQS36bQ52srh7W+?=
 =?us-ascii?Q?El8bkY0JvK+h3uMmZNa1/HhG8QAU/WpBRl3hZQJL98PcsszrHH+aCyBQkR4z?=
 =?us-ascii?Q?iQ6ii90mvb5alIqsSKgvFXXBUCwW6IBw0RMcDL02XAK0OJPdJA+jn+KgGca0?=
 =?us-ascii?Q?wOpvMDVjXxLc5z0MSnU+y7mVmXgGKgaiHvJR/uXXjNFCCd0Z6e81y1nFygpA?=
 =?us-ascii?Q?DjUi7KFEcLcpjAq5u+6scvh8ACNYfuGmqjYOTnF+ElSCD+w+nVoH4IyRv9kr?=
 =?us-ascii?Q?gFbSz8yg2S5LxJAQy2pOZRVnr0ajd9P9jVmccd2og/7lGJIlhUjG2qSEbF86?=
 =?us-ascii?Q?g+mW2bg/s6B4I07PiQDKYWGV/H8GtP47W0y/fv+RyTox+o8jyl+8qFXFgcGa?=
 =?us-ascii?Q?V3V4Q0rIQGn0w1RlQnxsdg42JK81z0wV7eOWjcP7sMQpYWe/6YnNteSW4P9h?=
 =?us-ascii?Q?5ILfWHtL96fkZ2FQODRvM1/WSzgkkzk8Mjri/+tJfpMlWEhI0HmvV8ER3Mvw?=
 =?us-ascii?Q?w7oqAm7zr+V3w6725sRMeJvO9dZ3NOR1mEbHyWUOLfNp0o1b+hQcMTxbECgj?=
 =?us-ascii?Q?oaGN+AlVenzwbAuOykCJS9L66IUlmPq3lXkcTxQljh5l2CTfDhCG4w7cnMjK?=
 =?us-ascii?Q?yPWElc3cuR7dO6daOl2SaAYoLlP+p/x9kUA8XIRegkEmuRG833cqjEe1+dJJ?=
 =?us-ascii?Q?54Q+eFNOOKDFyrOC5zQchd2BIl4TjyvIQjD8vCXaG2qREPOeJ6B3egdNTsoS?=
 =?us-ascii?Q?91Z9iUXF0sSVJls1+Z8QiH6nh8kZB+4xyJYXHplRLg5bGUdi3zexb810ontT?=
 =?us-ascii?Q?chMhbq+G3yuEhqc/gPLdHwV8q8QanMQ9rGeyJD4KWUiDte2bgRJZj3E8JuJk?=
 =?us-ascii?Q?66d1emhPlcJDg9cuPZhXDJNnF5sIVbFX7RqUJ77VqRWsbA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cef49df-27fe-4810-8288-08d98e955466
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 22:03:46.8700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJgdxJv1/G1nA8ahGzS0eUkQj11fObrWVJ7VuUVGqIK+VN8ih3BvBzPYSR0G5UIP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4932
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 2Ep601Gw28405jULmG8o8Iz2hvOnM7Vx
X-Proofpoint-GUID: 2Ep601Gw28405jULmG8o8Iz2hvOnM7Vx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_08,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=758 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 13, 2021 at 12:43:38PM -0700, Shakeel Butt wrote:
> The commit 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in
> __vmalloc_area_node()") switched to bulk page allocator for order 0
> allocation backing vmalloc. However bulk page allocator does not support
> __GFP_ACCOUNT allocations and there are several users of
> kvmalloc(__GFP_ACCOUNT).
> 
> For now make __GFP_ACCOUNT allocations bypass bulk page allocator. In
> future if there is workload that can be significantly improved with the
> bulk page allocator with __GFP_ACCCOUNT support, we can revisit the
> decision.
> 
> Fixes: 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in __vmalloc_area_node()")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/page_alloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 668edb16446a..b3acad4615d3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5215,6 +5215,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	unsigned int alloc_flags = ALLOC_WMARK_LOW;
>  	int nr_populated = 0, nr_account = 0;
>  
> +	/* Bulk allocator does not support memcg accounting. */
> +	if (unlikely(gfp & __GFP_ACCOUNT))
> +		goto out;
> +

Isn't it a bit too aggressive?

How about
    if (WARN_ON_ONCE(gfp & __GFP_ACCOUNT))
       gfp &= ~__GFP_ACCOUNT;

And maybe with some explanatory message?

Thanks!
