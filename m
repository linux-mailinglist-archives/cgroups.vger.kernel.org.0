Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB582F51AD
	for <lists+cgroups@lfdr.de>; Wed, 13 Jan 2021 19:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbhAMSHn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Jan 2021 13:07:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7750 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726429AbhAMSHn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Jan 2021 13:07:43 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10DHwPFU020974;
        Wed, 13 Jan 2021 10:06:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Tqk3s2gbpL7IEpMXx5QPwfd2m6Xl9/uAFYgdXH/d59k=;
 b=gNZVLsqO5R99DCECsq9hNLTTDhM4yZS6qMGfIcDhcDT8qV06EDTSouPaP1IoAsC9P5NA
 UPnV/ryBOR9qfrLkAOG+Goow25pWZptMLDhpGCZxW8j7YRxVITR4yBp/zuPPIDKzYJyU
 LLFNAwKp2dhEhhHmr6aHWZgmtZL67Bt78NU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 361fppegtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Jan 2021 10:06:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 13 Jan 2021 10:06:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGgKo52U/SV10+PXmQJ5/w53BoVMrgBI40inZIP/hkqMC2+J3h7XsP8jrTBHG0OK7Qv5ELAAG72AHGEih/DXBA2LYO3jjwQBXL7T+Z32QtHbUeirLCl+hoNjpDvcM5Z455X0o8BNDpyjQqeJuUdIlSV9Gv6Vr6xBQ8L3tKx5NlBTJuqTUFjgC3GogUHtR5drxNgkmk9VnUbwqKHyVlSwDXGWC4f2jLjEDiZ8pg7PCTa/HP/yiXjujOauVf8Gk689Xl7tM0Qdj1FyWiaN0rcFOK/4g2jmJL1deglZLY6xkGS5zRurS1kxDjedBP8Wxr7ZkDMg/pKsNnpR/37Jl/Czeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqk3s2gbpL7IEpMXx5QPwfd2m6Xl9/uAFYgdXH/d59k=;
 b=EvKfWoI8nT5KjKVY2PhFaPteh+/cZwR1KJZOV7RdHUXVKWxH9403SHM6QR3CAfcARI+fcXV2artFCakDVhLOqcg/g3Dmi62Sfq9+cCpTvaIgrFDZLH4EIXgB8XXFabsxKK5P6bdh8WFOh8/G205nJ7ON4pBdXDzO0AVHelN7qDpJwY3kKFrSO9kHmKao/xRpfvpheCCZUKB4BJ5MvjsGTKbFCPXQxhATRVuJQnsA3Q/iEIOyMiL0jzU23pF0WdW1TjY+UkCbwkeznde0Y0Pmh1YfIAEhQLlKtC/UjCeF7gi7DAKpwxZV73SEh3AHqUbgYZdX/4JFb9ULjuLPcaoAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqk3s2gbpL7IEpMXx5QPwfd2m6Xl9/uAFYgdXH/d59k=;
 b=QCuZxlsWe2k6VrTbephjDi795JM88LcVOGCyz+zzzKYmF13ftylB8isTI5Ga2tivSXsfSM+quSJdt6o4WgwJozjzDdIVHBPKspn/ct8s4Fp+SHYTFWQ25hTI6qEIJVUqKID3D2IAg4J+8I9Pd43pPVfL9f/+i8J4wb8StieAzqk=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB3791.namprd15.prod.outlook.com
 (2603:10b6:806:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 18:06:49 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::65cb:e5a9:2b4c:ceba]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::65cb:e5a9:2b4c:ceba%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 18:06:49 +0000
Date:   Wed, 13 Jan 2021 10:06:44 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <20210113180620.GA353910@carbon.lan>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112163011.127833-1-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:31a8]
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:31a8) by MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 18:06:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d04023b-2d16-4eb5-57e5-08d8b7edffbd
X-MS-TrafficTypeDiagnostic: SA0PR15MB3791:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB37911A7E856E705F49E47129BEA90@SA0PR15MB3791.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSqV9S6/Kt7VpSTFKMxJWEJvqg/WUz1e3+DRnPd5P0Me42LOdtBeAO1o0/vDNVOBJ4pobSYi5nkuLZhJbesXAYljjqT7vUnjNgf2tfwT8sRjy8mM4lBNH4YqJ72Eu3/yWLc2Qnq48din2IQK7ZUKRgPhtRR8j9OpozthUvPb4aqRcO5rviH555wLnHGk5TKblLGLLHusIxdtcr3HyjbWxGO9JK6g0WI55eqwdLYEkqmnz8jFqwue6H4Q6Q5QyRqOOjoGD6UmdrAGlZg1aB8cmKokGViWSr6gUXUb/06Rm//GoHgAOLtI1TYG7dlWbvEVhUJI8DzT13M8aJep5FWVckM+zlYePWGbzcmlEbFKRYhSaduSN6lA4AUwdRpKxSGb6/1EzJRL1qVQKMm85zxRNF1XbKzMzYBDk+ANPzT7hFJ6viW8e24oAMCyp9RMiE0D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(396003)(39860400002)(33656002)(86362001)(52116002)(186003)(66476007)(6666004)(83380400001)(66556008)(478600001)(66946007)(7696005)(16526019)(6916009)(8676002)(9686003)(1076003)(316002)(5660300002)(55016002)(4326008)(8936002)(2906002)(36756003)(54906003)(6506007)(8886007)(27376004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lrU/2GGTVG8us/OQ2FxQaXS3Cl45jeqlEB9c8I1rBWiEge1KlPAwq1z2V05A?=
 =?us-ascii?Q?L01pPOMeTzPWgf7WCd+52FQ+qcdaYXjq95WJdmw7x7xwgHnoilYWNrXKDJhp?=
 =?us-ascii?Q?tJjvbJ8KEpEKNvbndvm0Euftdo2H65ca2x56mD0U2sAEXxxCq0kBaHgfFA5a?=
 =?us-ascii?Q?1wnlMWqWIB69w5nTffcCE5h7JWtKkIFF7JTOlOB1vm3l710v0VcRytK4oMtD?=
 =?us-ascii?Q?KMp//VERfsscbrb4QwRDabk3j2Ka6yWYQz6gXqHbxHmPg68IoEW+S9nLc8od?=
 =?us-ascii?Q?CroAH93rRArTm+7ErK0S+GCvV0hEx15T2VDuJFQLZ2FgnNzp8FN1O4cVlHZC?=
 =?us-ascii?Q?7kD/8avosO3sRK4Y4HmxqlIyBaVru6sCbRWlKYYapH0dMKZi66jpIjpQ8dGf?=
 =?us-ascii?Q?aGehiidKObnn/1zPVVE4zTVslcRv+/82Qcdh/kMhwBMP14aeH0xcbCsqxqhZ?=
 =?us-ascii?Q?wDi/GTYCu4eRGKGRuymgueLOlQMdk78cLChM6AZOq3HUAFKV2fA2xhsQzp7H?=
 =?us-ascii?Q?lZ9hrU8Hvd1GMXx1W3Y8wcXc4rwFUZkC3RBCBhXvcbkXX1WxpGm8TZ5Xq7ar?=
 =?us-ascii?Q?F7sATsctTRH1p27Fz27/FYHjGI+YgvPieH52VCbSpTKwmiUUeI1J2qGMEIM9?=
 =?us-ascii?Q?FL1RCNRWSiJjslSzRKQeKbxFMF5buI/aHXe6jhtVatDZR2JM7AbkUdAtZUcn?=
 =?us-ascii?Q?fRZ1dq/78Zd9Yn7cDUW3dGU5/0PHHPArPupVG2KEO+YjjmgRbsQhQj1D90Pt?=
 =?us-ascii?Q?YGKfUHH7BL5XB49LaPwEKgAhO4MPZkIVhQt99GugLok7+6WRdqzZ8s06OOfp?=
 =?us-ascii?Q?uBjWbFx/pTaaMyByjbGTTdN1N1Ov4Xme+zS/bd9uE4kQkb035a2rqL5VSdUP?=
 =?us-ascii?Q?zvcuqq2VExOEeHm8f0wWRbQ2ngBzc/0yvYE0qtmvnOWvF48OpeuDTcGMZBMl?=
 =?us-ascii?Q?mQdW7nyG4bGtULA25x2ajlzGc5wMUKz61nldK6dM+txNMSgD5piezVgbXinv?=
 =?us-ascii?Q?EAeBix4jCEIIBgWbhJi9Owms9Q=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 18:06:49.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d04023b-2d16-4eb5-57e5-08d8b7edffbd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BeTiQpgnNUI9/d2kEokWqKHDvoX8n+xrwtUbux20l3sdNz4u3PiWxooZYvZ59N7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3791
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_09:2021-01-13,2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101130107
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
>  			break;
>  	}
>  
> -- 
> 2.30.0
> 

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
