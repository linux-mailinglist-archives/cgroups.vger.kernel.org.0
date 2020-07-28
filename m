Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1A4231208
	for <lists+cgroups@lfdr.de>; Tue, 28 Jul 2020 20:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbgG1Sxz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 14:53:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45890 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728782AbgG1Sxz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 14:53:55 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06SIoWCT004054;
        Tue, 28 Jul 2020 11:53:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FVNIR2xjk/9l9AEZJ00iTvtiTR8dEBO3vE9XfzlitWc=;
 b=gP9o441jVCsBKj6ajeSRfOwOOWmH82HF1aaFcpXtSMIDimrC66Zd2rksWc/ciyNEc+jL
 A/WZDNi3vcFAwErOMqBeucLkSFF79CumYbXVVmLFYX92GKoq0WN/KMN8PBj9+aHJhAIp
 B3A0z9XlZbRPQxs0IomC41Izior5Mi/n/Lo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32jp0uh790-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Jul 2020 11:53:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 28 Jul 2020 11:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOsszuzYNlmu5j8sLaBgIa1xfzLt5Oe673+V3TUSfW1s69nJvNOU+l6WTygrqFfJ6tSrkcg9NATCLfIoRK+2negNGBAyIqptqGhcnKaKHNtlOWwGEdoCY0ZBJ6buZn1LbFBgm8uBNvDlmvuMf6Ycf91MP19gH6k7udZ2FQuH9S8IAXxwntEXz/m0c+s+YlHkseBP+EHO7qgTuHy3MkWnidyN/rtUHpuQsyc5MXTf+wC3p1Ede3rg4oTsiOiFD39OjzL4jN3ARcLtYww7VWgRqVOKNqOc2JKfEqmk8YrFdT9IlJUv3ud3d9Hu4rrbJK9dRLSCUyiuo17QEs72RBR0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVNIR2xjk/9l9AEZJ00iTvtiTR8dEBO3vE9XfzlitWc=;
 b=hW+aFhpWSDK4p/bsCrrRQW/TO46u0zVaD5sFP9mlAAgAaRfcMetW3QiNhQdzczKhnObiKAol+BORysIo/S4nO6VrRjTPjzEb9wDwM9XYGOy4wJ2Jicm3d/WzRGH0kQB7O+YtOQbbu2rebFWJzUdFrgLTewAyJ+pyjcljyiLG7oxgtgsGR4CKUZXN/p1TNSNu4wbvv83Xtkxp7G8x6YmCHTvouG6kB+iLlSPo4F6dkYbVJLbNFsQjQSuW/0OHBRVYv32jWXp1AO5h73w+YkhvKWzFizT10GSDNuK6sQ9FOrjjWJNzcgycEDWXekWiK8e+e3yEbpEX//AYLdkY6lgiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVNIR2xjk/9l9AEZJ00iTvtiTR8dEBO3vE9XfzlitWc=;
 b=Z7ZiC9i2fll3ivLLcSLh6WTjpARzYpgi3evXwxLTELo25+zUwYoJFbIwr0EcTG8NL/3BA+qBO2Jo0K2WNTHQcg6OuM9TcFq9KXWYJUXi02lbGqE6RJMa9iAVny03r7+fLnT7eJmIF05y0bL9nK5HrGr/drU43MG2fVwBCke46vM=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3480.namprd15.prod.outlook.com (2603:10b6:a03:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 18:53:44 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 18:53:44 +0000
Date:   Tue, 28 Jul 2020 11:53:41 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: don't count limit-setting reclaim as
 memory pressure
Message-ID: <20200728185341.GA410810@carbon.DHCP.thefacebook.com>
References: <20200728135210.379885-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728135210.379885-2-hannes@cmpxchg.org>
X-ClientProxiedBy: BYAPR11CA0047.namprd11.prod.outlook.com
 (2603:10b6:a03:80::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:19ed) by BYAPR11CA0047.namprd11.prod.outlook.com (2603:10b6:a03:80::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Tue, 28 Jul 2020 18:53:44 +0000
X-Originating-IP: [2620:10d:c090:400::5:19ed]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74470a21-29cc-432b-d248-08d833278d80
X-MS-TrafficTypeDiagnostic: BYAPR15MB3480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3480B9BA85BBAF3C7D80E5D4BE730@BYAPR15MB3480.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4+idC3rz6jzkc1I9W9G+TANYWmIaITJWYJs+SdTqYzY05SA8BiRL8psSe5z4BgVEJwOtuZ6iFP/0snYI/JH//AB0uW9HLT4mw+SqMlSnbM+YtN6Uh9b96ItHF7i+fBt0UVXa/an8vMuzTNS60pFJD64n3rriZvbjk1CG+AYeSkKI5j8zJZKxnzXjuIZI3oYPxs85YjEk22ZWOedXcp7y/MsvWOvQdAa2ebiVln3CwiYOJ8WDLZtvWuHxUZfTdRVXaFgnJ50qhId1GIuxnvJTRz3KBkI/q6Fde6ktQmJWh8mM2/00ZUwlnqVYSv1gV7CaWZNhfoF7GiF+QQyxbRDbw53CmtHx50WwJJe5P298J5WaYlWuijy4suIo3CcEfBM3FVSfADSNHPoCyE288eoHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(136003)(346002)(376002)(366004)(83380400001)(1076003)(52116002)(6506007)(186003)(16526019)(7696005)(8676002)(8936002)(33656002)(86362001)(5660300002)(316002)(4326008)(55016002)(66946007)(9686003)(66476007)(6916009)(478600001)(66556008)(54906003)(2906002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cCNNx8UhM3WCI4k0o5j0euqW570IH9vYQML49tXArQmWrpYlt7BcfI2Vo4GT+bz5BXGIBzeZ91eZb7OFm3ondmmmSEeKqF5N91No9a97V0oiyQn3Y/NkuLElH0Vg+uxPf8A974D8nVHRs56wTORZLRqZqFgZb4P2UCBiHZp4xOiWKMJSgo56/f5oXFLonrVHFK6sPkuyC5IPPxA1kHdmDiHa+f4C5eFH/x5r62x1gVHCOFfV+gj1eDK+J1n1zxzak+gY1cA+NxzhEW7BNa6yIvpdnicpTFhKIbHprtT0aKYBzv5zff4OP1GuctdvLYrU5aw1UNZdNNWM4+s/I1FzNuUEEOkpIn0QTb5D+zLslp6ds2dAlH4O00hS7QTQrf7WTibngtTSiIv3vgf2QxY9cqz568U1/MOQLh29vRgZAcWu619WwLcfxt3160u82j4qTRY42pHOrbcQMzg6ycV4qxC9xlg4g4vuBToGJ+AL8LKavJ++Ie4eznq+PS4EckvFX5F5jN9m31+uBm8fCRRlsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 74470a21-29cc-432b-d248-08d833278d80
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 18:53:44.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dk7qRxiYsS1qoFvGbvA+GeGZl8DqNVQfS8yRgpCmdhzMwQDLytwddHs94UnWfBFd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3480
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_15:2020-07-28,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280133
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 28, 2020 at 09:52:10AM -0400, Johannes Weiner wrote:
> When an outside process lowers one of the memory limits of a cgroup
> (or uses the force_empty knob in cgroup1), direct reclaim is performed
> in the context of the write(), in order to directly enforce the new
> limit and have it being met by the time the write() returns.
> 
> Currently, this reclaim activity is accounted as memory pressure in
> the cgroup that the writer(!) belongs to. This is unexpected. It
> specifically causes problems for senpai
> (https://github.com/facebookincubator/senpai), which is an agent that
> routinely adjusts the memory limits and performs associated reclaim
> work in tens or even hundreds of cgroups running on the host. The
> cgroup that senpai is running in itself will report elevated levels of
> memory pressure, even though it itself is under no memory shortage or
> any sort of distress.
> 
> Move the psi annotation from the central cgroup reclaim function to
> callsites in the allocation context, and thereby no longer count any
> limit-setting reclaim as memory pressure. If the newly set limit
> causes the workload inside the cgroup into direct reclaim, that of
> course will continue to count as memory pressure.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  mm/memcontrol.c | 12 +++++++++++-
>  mm/vmscan.c     |  6 ------
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 805a44bf948c..8377640ad494 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2233,11 +2233,18 @@ static void reclaim_high(struct mem_cgroup *memcg,
>  			 gfp_t gfp_mask)
>  {
>  	do {
> +		unsigned long pflags;
> +
>  		if (page_counter_read(&memcg->memory) <=
>  		    READ_ONCE(memcg->memory.high))
>  			continue;
> +
>  		memcg_memory_event(memcg, MEMCG_HIGH);
> +
> +		psi_memstall_enter(&pflags);
>  		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
> +		psi_memstall_leave(&pflags);
> +
>  	} while ((memcg = parent_mem_cgroup(memcg)) &&
>  		 !mem_cgroup_is_root(memcg));
>  }
> @@ -2451,10 +2458,11 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
>  	struct mem_cgroup *mem_over_limit;
>  	struct page_counter *counter;
> +	enum oom_status oom_status;
>  	unsigned long nr_reclaimed;
>  	bool may_swap = true;
>  	bool drained = false;
> -	enum oom_status oom_status;
> +	unsigned long pflags;
>  
>  	if (mem_cgroup_is_root(memcg))
>  		return 0;
> @@ -2514,8 +2522,10 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  
>  	memcg_memory_event(mem_over_limit, MEMCG_MAX);
>  
> +	psi_memstall_enter(&pflags);
>  	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
>  						    gfp_mask, may_swap);
> +	psi_memstall_leave(&pflags);
>  
>  	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
>  		goto retry;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749d239c62b2..742538543c79 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3318,7 +3318,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  					   bool may_swap)
>  {
>  	unsigned long nr_reclaimed;
> -	unsigned long pflags;
>  	unsigned int noreclaim_flag;
>  	struct scan_control sc = {
>  		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
> @@ -3339,17 +3338,12 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
>  
>  	set_task_reclaim_state(current, &sc.reclaim_state);
> -
>  	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
> -
> -	psi_memstall_enter(&pflags);
>  	noreclaim_flag = memalloc_noreclaim_save();
>  
>  	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>  
>  	memalloc_noreclaim_restore(noreclaim_flag);
> -	psi_memstall_leave(&pflags);
> -
>  	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
>  	set_task_reclaim_state(current, NULL);
>  
> -- 
> 2.27.0
> 
