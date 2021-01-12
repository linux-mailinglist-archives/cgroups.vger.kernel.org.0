Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BD02F3687
	for <lists+cgroups@lfdr.de>; Tue, 12 Jan 2021 18:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392105AbhALRET (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jan 2021 12:04:19 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38652 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391244AbhALRET (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jan 2021 12:04:19 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10CH07hU020008;
        Tue, 12 Jan 2021 09:03:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=D3fuHfWCYPA85AQVaYWrcuVwe9+Dj6Wd8GCIayk9JiY=;
 b=HrrxfUByGvkUeOy1s6eQhaOS8kZwAVrJyy9UarmAxSNzDrNZw0Ca6J8zvJPFO1y33nfg
 XkJvvFc+UffPIMp0RKV6FvmGCVnAq9Nb+F62SLcq3maIxkGX5VmNZx+IhojetgiD3mOp
 D6jsWWaVeaKToi5DjsCtkTMJbWj9sdRArrw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 361fpj822h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Jan 2021 09:03:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 12 Jan 2021 09:03:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm2WqSJurQSAQD/pxGRbpcznpS3MdF6B/uglTKC2FxHvMRBUA0Nv9xodY8H5RSsoz236JgE0s+MPH4/bOa79n/ODHOk4+FVJ5MBe+sPJ2AWl7ktrrqJpVJew6WUGCuXuXbnyOsD6kL/Jc9KF8GQeRctRnvE4cQCyeHWG597aYUaDs9NiOky0OgnKrjvuLaV1gpXE/Jbjg0uhFp7Grj+XkMkSYlbMCEiQY3JkB5GsxYrDBfc5hI0bFZyo3idZmrYDiHgOOGFRSFt4TmUTcN9W2+xQTUEiwgWTQZIQqkfRYGs4KInYjitzLWrkadg14Ahu4PmIwWJllsEsmqG0EHcxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3fuHfWCYPA85AQVaYWrcuVwe9+Dj6Wd8GCIayk9JiY=;
 b=B1f355SolsWxl/4r/Nx2A5oul+q+ujCmgLiAwdSc0lwPFEn3pgfkFkE5fj3hFObdvrNY1T/X1cmovjVOuguB9TAbKdgY2oIqPu9ijECcWU8yLj4UsyOCrbr/ubqzO2NIyqGF6R4AQBk9wg0kbxtPnO7+wrBrAj/zMePBJu7FH67IKnsiqS0tAt31tQtvyydcAG9mATpXIKGFaIOCUWDHtZ9eOSy7f2e7jsamYRc91979G4B9ATlWLNO2cuAM48gHmaNJW38V1bY1Te9EZMSAAq7KSuWnRsqMx3CtTcCssbtR7HrwzZhZd5ZWsbInfHVj54pJxlP1h6HacgPSHi9zEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3fuHfWCYPA85AQVaYWrcuVwe9+Dj6Wd8GCIayk9JiY=;
 b=Q7ia5QB8Wk0ch3bJKQS43tKdpl9aHtIIKjvH0bQJbaTB0Ez67qZHGLAYLz3F4ckX4VF2zuoIo3d0vrS49TxpzFbpax3/84sI/kTMa9pxhJoD8GErGMl1YpBPkJyTPuZnq57LHUwLjbw56hlISYyIlMAyXtwNsXTkCUPwBLbHAB0=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2869.namprd15.prod.outlook.com (2603:10b6:a03:b3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 12 Jan
 2021 17:03:27 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 17:03:27 +0000
Date:   Tue, 12 Jan 2021 09:03:22 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <20210112170322.GA99586@carbon.dhcp.thefacebook.com>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112163011.127833-1-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:dcd4]
X-ClientProxiedBy: MWHPR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:301:14::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:dcd4) by MWHPR1701CA0008.namprd17.prod.outlook.com (2603:10b6:301:14::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 12 Jan 2021 17:03:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9464682-7f1b-4887-13c4-08d8b71bfab0
X-MS-TrafficTypeDiagnostic: BYAPR15MB2869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB28691C699BE1DD7EEDF78287BEAA0@BYAPR15MB2869.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0eYCvdGf9w0y1JWlJJqFrePigxYOdb5JvNO6HoMsxpTd/AeB+xF3hJuZK0x+T5DarJ5ENNfwdiMp2XeKQpbAxV04ZMrqrxLKv4xWrt76jcYxnhIOsuPta+uXes4QeF3HjTkFRelR+3u/2Gkg3uvhmr+zK/gPlsSI3sBFNkXZbaFTXg6wG94AH+ySWbG+0cH84ff3uuAlydXHG0ns2oh1mEIXwsOTb99k1LPi7sGeDoIZZEiA8WZjupxYDpxfeALPoLGnxq0039ouUYxGwHWM+GMnsUwYRqq9mKL+9sLH2XIKB/eIWABabjOxmTyWeOFTwmCsr10GZ0zKL+SJq96fksnyfKlf56/L1GBZBRNInkmEjGp/9bsV7hJyPdb9OrMVuiMhSraiT3jCxbqbxm7Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(396003)(39850400004)(16526019)(186003)(5660300002)(9686003)(55016002)(83380400001)(2906002)(8676002)(6916009)(4326008)(52116002)(1076003)(6506007)(66476007)(7696005)(54906003)(8936002)(66556008)(66946007)(86362001)(6666004)(33656002)(478600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8OgSWITBZVFtEcIsxo9dGnZId9ABaivTIAqxX/BlUqbvzdDQnt/HX1AzdTpA?=
 =?us-ascii?Q?uJuhHnFDnraxWQvvBAT08fJAbvR+kAEeRFrcDxjE2N95AvTZsOyTt2ke1rkg?=
 =?us-ascii?Q?SAlvb44zgWYjTI4evaZzs2++n7sRkR5abBdNBxg91l2LbmKFa6cVw/4tdB5w?=
 =?us-ascii?Q?p5sg0ZdYiiOn7bv8c3JgdPJQFy8QZfAPTVo93RZ9c07inccQw7PDZobvzOOe?=
 =?us-ascii?Q?ozwo8nbFI1LQgvilJiH63EcanifY4/gwkcG0DMtCNGa5V3YC/L0+mMSU2kzf?=
 =?us-ascii?Q?KFYqEbdnuxuceYFGzhxy/UQQ/LhP2F4bTKJnofUgwqFWh0h/slazDF/wtmvj?=
 =?us-ascii?Q?PsY9RTX2NpcV9Mh/joHt6WGcyKjhliUoiWO0OKmrrX2pCJWTtpIm8jURxN5+?=
 =?us-ascii?Q?g6zwUJ+4GTi0qDSiWy47PxfqgRphBgR/+xUn1I8scPzwg5d460HXbbZPdABy?=
 =?us-ascii?Q?KZuPuqLcgwm3wWf2Wckujo7iJjUkIY3qTfo1p4ebyjKZfS3WX1hnnMATO951?=
 =?us-ascii?Q?NJxjZ2USjgqDEUiOEg6u60L6/Le1zsdcBvEH0eWfUJHQmKCOArOWfGHbLphy?=
 =?us-ascii?Q?ZXFdWTIS5o9EGOS8xQ91UWaMKY8XB+56YactgkBpHBEdiJjJ/vdnNW1E/ych?=
 =?us-ascii?Q?rq6OrKtBTKSNdbm5HTr2ONP7wEpp4JQnYkpeYJC85gdGZCxWN8YJ3tQ7X7g+?=
 =?us-ascii?Q?JPF2a2IGdIIajNVoCOUJIFUgZLuPthpYCttKm9KrqlAWferusxiA/QSESbS+?=
 =?us-ascii?Q?31WqzmxSL6jUjnrmjeUu45i8wvQ9NtZmqOb8FxYYqjTrjII/TPndBLHiuwgI?=
 =?us-ascii?Q?v6bmk8CUJBjcHs/GjbtfV9Nkv1k0RQU0m1buNAKIK8qCEmuSBUFgWJMxqC93?=
 =?us-ascii?Q?FRpnOCgEpxtKm2sdUsOSzGTkoP03jXvz8kGfWkhlYtpK15MZxWQ/jWVsmoO2?=
 =?us-ascii?Q?MPQCAPWgZTFSw7v9AYkjhCpZlFvOVAeNv+hOAkyARMHvowAvMZVhyWzA3OAx?=
 =?us-ascii?Q?xZQZoGvH9JhvihhrSPdLDuuYag=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 17:03:26.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: c9464682-7f1b-4887-13c4-08d8b71bfab0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Cle1W33lpOLI6yXNZ9lsR1H082C7vzw5J0Y86cvm7sHC4oZ50nvVONmQAl2ik/S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2869
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_12:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101120099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 12, 2021 at 11:30:11AM -0500, Johannes Weiner wrote:
> When a value is written to a cgroup's memory.high control file, the
> write() context first tries to reclaim the cgroup to size before
> putting the limit in place for the workload. Concurrent charges from
> the workload can keep such a write() looping in reclaim indefinitely.
> 
> In the past, a write to memory.high would first put the limit in place
> for the workload, then do targeted reclaim until the new limit has
> been met - similar to how we do it for memory.max. This wasn't prone
> to the described starvation issue. However, this sequence could cause
> excessive latencies in the workload, when allocating threads could be
> put into long penalty sleeps on the sudden memory.high overage created
> by the write(), before that had a chance to work it off.
> 
> Now that memory_high_write() performs reclaim before enforcing the new
> limit, reflect that the cgroup may well fail to converge due to
> concurrent workload activity. Bail out of the loop after a few tries.
> 
> Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> Cc: <stable@vger.kernel.org> # 5.8+
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memcontrol.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 605f671203ef..63a8d47c1cd3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6275,7 +6275,6 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  
>  	for (;;) {
>  		unsigned long nr_pages = page_counter_read(&memcg->memory);
> -		unsigned long reclaimed;
>  
>  		if (nr_pages <= high)
>  			break;
> @@ -6289,10 +6288,10 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  			continue;
>  		}
>  
> -		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> -							 GFP_KERNEL, true);
> +		try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> +					     GFP_KERNEL, true);
>  
> -		if (!reclaimed && !nr_retries--)
> +		if (!nr_retries--)

Shouldn't it be (!reclaimed || !nr_retries) instead?

If reclaimed == 0, it probably doesn't make much sense to retry.

Otherwise the patch looks good to me.

Thanks!
