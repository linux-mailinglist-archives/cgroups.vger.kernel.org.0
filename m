Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B212168B78
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2020 02:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBVBLA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Feb 2020 20:11:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27654 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727614AbgBVBLA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Feb 2020 20:11:00 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01M14KnP017113;
        Fri, 21 Feb 2020 17:10:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=4eRmRnp8FS/CmnrSgyAD67jo6cjwwDO++cBE1P7DmxM=;
 b=o4SdbUDqPIaD6GzoXkPdGKWwnVuksrXzhxAEMMFS3u1TWsDLStzcVHfbUwRHfn3eRJ2I
 J8tMN99MM6pljb99mxMKHvuNMWYUZz7CSrltsGTjgcXPv5rRxC6c8jtSbEmI73nO17ee
 OgZrznzcgVW1HMWLJeqt90cKuZrgm/5WjuA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yah9qasu1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Feb 2020 17:10:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 21 Feb 2020 17:10:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RelMBIhc4ngiAaWBDFsaK4Eb1TfvNJ2z1LLqJY9Li0SM27K21V7jU1tiDbdEt/XHRTs/QOw7luOtEBjAuLByCU2i5PxRjEUDuFqmSV0Li8QoAfCe9uDpHF5p7ANGvH56EmvRnEUKrMGiR2x7LgXzGoYFpe77Zca4Z8su6+c0UWePj+4nAD42w1J3lKDL1gLvQF4VTm6B4GGcrWZf8OYGc51ieAfKNwpLaGGKI1lqGZcLfSo/4jv5tMMVSRrroo2H1h+3G3dlH4iFJwgvPssoV9GZX3m4qYLaPJcraL1bNHhK5yhKhzCeOzmoabGcjFznpuOk5oMZuiMqTU4RFCXZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eRmRnp8FS/CmnrSgyAD67jo6cjwwDO++cBE1P7DmxM=;
 b=fy8CcsTikbKYHhL7cq1AhBDSx79dks6wX+mtcW/ppceWOdj91mfh8aauNURLQQmUkHTFNu/v3lceQZuDTXp9uS7A2KQ+WiGu00l/IlygzidcjiTOlO+8R6LkDsQMlxPStRXdbnGKG6MtU2wT2JpyIEc3gCPcBN7zykUA0+LPENPnI5WEH5FcWCIIHXWWDXn9rSFiO9SuuTSoIIr94nUaHicAv+kLQLcDPpo5rEkkGuBeWVnrdcXeb47MMiD6f1f1F5JUVLZistu9Jf/CjXeISpJsAJTqUCmr6lpnkYmIeb/vG8dmIFBOeaGlhQ48xVSfi0c0veBnC7jW9Cy9Or18Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eRmRnp8FS/CmnrSgyAD67jo6cjwwDO++cBE1P7DmxM=;
 b=XadzIhL8iY2j71gL4NM4uf0RbghdM/tzr9pkkJwdhmUqUXJolVxsAUmXT8F+CvCbKONI5bNGA+c8i2flXvyjKxjA7x5965sGgKw+uuuJ36EUWYxwJi/jA5dP8nEgfkmsG5WfGK1n+YyC7d/bZtOQ1PwTHyqGTAbDfEFvokI9eGo=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2216.namprd15.prod.outlook.com (52.135.197.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Sat, 22 Feb 2020 01:10:51 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2729.033; Sat, 22 Feb 2020
 01:10:51 +0000
Date:   Fri, 21 Feb 2020 17:10:46 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: css_tryget_online cleanups
Message-ID: <20200222011046.GB459391@carbon.DHCP.thefacebook.com>
References: <20200221195919.186576-1-shakeelb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221195919.186576-1-shakeelb@google.com>
X-ClientProxiedBy: CO2PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:102:2::36) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:c751) by CO2PR05CA0068.namprd05.prod.outlook.com (2603:10b6:102:2::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.9 via Frontend Transport; Sat, 22 Feb 2020 01:10:50 +0000
X-Originating-IP: [2620:10d:c090:400::5:c751]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 240f50db-8b18-4ce7-42a6-08d7b7340eab
X-MS-TrafficTypeDiagnostic: BYAPR15MB2216:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22163A6ECFF27BF1D6190059BEEE0@BYAPR15MB2216.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03218BFD9F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(39860400002)(136003)(199004)(189003)(81156014)(55016002)(66946007)(52116002)(8676002)(66476007)(4326008)(66556008)(7696005)(478600001)(86362001)(316002)(54906003)(9686003)(1076003)(2906002)(33656002)(186003)(8936002)(16526019)(6506007)(6916009)(6666004)(81166006)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2216;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppv2GihhZU6uTVGP6s/9Go8onmc6V5UrzQRlQD6bVad86AiTmQ22yczilHd9d0lqyAHXw6/ZHBHI0CtykR0ZhoMGer9OioKYgUCWOLlmgmTTvW53fLQL+bI3MjMhlOc6ktzrtvGuyLGIKptNgM/VdFwrBZgjSob81Xg2sh3dgLzNsLa0+ItNXybMXQ5buU0nNp2yv0/RHHdkIgjEL821EhGardaQj/+ykYX5za04P91W984LAi1RwnprTnkyur7Bikq5JMsDSVetWYyt2/zZf/izAqwd+7fya6dZLVk4zCDhjU2epFd5l9lSEhGFWZCSg6zyn9ClrcnCNLtanbMDrY+CE7ZgTQOLnZOGsloCi80sSmmwwY3GJmb+aKXc3RTNDvbUBjJdW5OczFagF2poUSqUDjQhRFtqGKIb996aq+R8vXO50HlNLVxJbhLmf+CY
X-MS-Exchange-AntiSpam-MessageData: zYF0IbKG+9aIXfu0CRvCuZddNA3xvReG3wcyOcQbORSK5m7B2TrRVIJq4LAFlLrx7i5RKzj0M7cWl8Z9J3eIeMAqxZAaxEegVbffBy6oVWyNKd9Iqx1gVSQBT67zHJxtbGNzB/U9Y3ffpm/LiJhyts5DcZbecblng2PV6xIs260Hy1FsFshUj3f0932DF0cT
X-MS-Exchange-CrossTenant-Network-Message-Id: 240f50db-8b18-4ce7-42a6-08d7b7340eab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2020 01:10:51.1859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rA4nqMXKSn/oudTNjz/ZIx92h0G1CJfS5T7+MhXehwpZ6WSwVRFqPC635+/GMimL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2216
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_09:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1015
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002220005
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 21, 2020 at 11:59:19AM -0800, Shakeel Butt wrote:
> Currently multiple locations in memcg code, css_tryget_online() is being
> used. However it doesn't matter whether the cgroup is online for the
> callers. Online used to matter when we had reparenting on offlining and
> we needed a way to prevent new ones from showing up.
> 
> The failure case for couple of these css_tryget_online usage is to
> fallback to root_mem_cgroup which kind of make bypassing the memcg
> limits possible for some workloads. For example creating an inotify
> group in a subcontainer and then deleting that container after moving the
> process to a different container will make all the event objects
> allocated for that group to the root_mem_cgroup. So, using
> css_tryget_online() is dangerous for such cases.
> 
> Two locations still use the online version. The swapin of offlined
> memcg's pages and the memcg kmem cache creation. The kmem cache indeed
> needs the online version as the kernel does the reparenting of memcg
> kmem caches. For the swapin case, it has been left for later as the
> fallback is not really that concerning.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Hello, Shakeel!

> ---
>  mm/memcontrol.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 63bb6a2aab81..75fa8123909e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -656,7 +656,7 @@ __mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>  	 */
>  	__mem_cgroup_remove_exceeded(mz, mctz);
>  	if (!soft_limit_excess(mz->memcg) ||
> -	    !css_tryget_online(&mz->memcg->css))
> +	    !css_tryget(&mz->memcg->css))

Looks good.

>  		goto retry;
>  done:
>  	return mz;
> @@ -962,7 +962,8 @@ struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
>  		return NULL;
>  
>  	rcu_read_lock();
> -	if (!memcg || !css_tryget_online(&memcg->css))
> +	/* Page should not get uncharged and freed memcg under us. */
> +	if (!memcg || WARN_ON(!css_tryget(&memcg->css)))

I'm slightly worried about this WARN_ON().
As I understand the idea is that the caller must own the page and make
sure that page->memcg remains intact. Do we really need this?

Also, I'd go with WARN_ON_ONCE() to limit the dmesg flow in the case
if something will go wrong.

>  		memcg = root_mem_cgroup;
>  	rcu_read_unlock();
>  	return memcg;
> @@ -975,10 +976,13 @@ EXPORT_SYMBOL(get_mem_cgroup_from_page);
>  static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
>  {
>  	if (unlikely(current->active_memcg)) {
> -		struct mem_cgroup *memcg = root_mem_cgroup;
> +		struct mem_cgroup *memcg;
>  
>  		rcu_read_lock();
> -		if (css_tryget_online(&current->active_memcg->css))
> +		/* current->active_memcg must hold a ref. */

Hm, does it?
memalloc_use_memcg() isn't touching the memcg's reference counter.
And if it does hold a reference, why can't we just do css_get()?

> +		if (WARN_ON(!css_tryget(&current->active_memcg->css)))
> +			memcg = root_mem_cgroup;

Btw, if css_tryget() fails here, what does it mean?
I'd s/WARN_ON/WARN_ON_ONCE too.

> +		else
>  			memcg = current->active_memcg;
>  		rcu_read_unlock();
>  		return memcg;
> @@ -6703,7 +6707,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
>  		goto out;
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
>  		goto out;
> -	if (css_tryget_online(&memcg->css))
> +	if (css_tryget(&memcg->css))

So it can be offline, right? Makes sense.

>  		sk->sk_memcg = memcg;
>  out:
>  	rcu_read_unlock();
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 

Overall I have to admit it all is quite tricky. I had a patchset doing
a similar cleanup (but not only in the mm code), but dropped it after
Tejun showed me some edge cases, when it would cause a regression.

So I really think it's a valuable work, but we need to be careful here.

Thank you!
