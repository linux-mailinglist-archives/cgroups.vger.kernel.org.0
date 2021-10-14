Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF11F42DEF8
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 18:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhJNQQ3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 12:16:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42112 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhJNQQ3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Oct 2021 12:16:29 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EG5lgQ028339;
        Thu, 14 Oct 2021 09:13:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=+QxXeGrVygVIkPEaalUtqiu/MljAZOc12wdYnQ3/KUQ=;
 b=q69oNqhOzwUsA0tUGN+3Ger85ZzdxgR2f+LjvQqXU02X8VMWXUClI8EMYdCHkaPJtCng
 ApLN1f7blmLr9bLGdXeFCeol9EU2KvEnXP6AoO+rktBPEQJOFXYWVOD3NXdl8EL/WmAQ
 wkM/akdhcHqMDaaXqYQfj3pxKz5VRrqceyU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bpqs102a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Oct 2021 09:13:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 14 Oct 2021 09:13:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gipMNRewCzLTcpb7tzoTdV7P+56h4qZ+kCOa2oHLJVsjj8p+OoxPywFwv6ovdNDRwFYZ8R27xsB4G9vTL/vnuOmo5NZ6K/B8I2BfKn3vQuNhAe1cLOMlgA6X3+SUFcCQHt9daoaKEzKY25JE2Jm9JLQEJhhkm2WHApWUfgFuLYaW+stFykaV79YovtGRnddebg9vZ/PjMUaKJOKwHkDovWkmPqL8aUOORtPURRGzhB1KaA5ReJ7SUETQGsjzjwi+uZsgVLkpwK6GdIW0DydErNDPQ1DMeH5ipKfQnM1nFBf2WqkKnQCupoVJPpNycDzHziRYefvn2xqZFKWAzRLQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QxXeGrVygVIkPEaalUtqiu/MljAZOc12wdYnQ3/KUQ=;
 b=MvuBhtFJi6rAcUwPSRJb3p3RxHsZHgE4Nye6kkXgZc+fsGclKPzWNAvqEFOwuC+wArpuCOKPkK3a06VQGnvjrH3QrRzfLhjdZfhKG9eLH3bq33ZHZh5zeE5+0XJDhOB4eMbbRM9hvYGv87lHTMgD52WknQtzY1uKqarRw06XV4tVsC1rBhtVmD5RmejtlyxYM6hjVfyKnFzwiKVe/Goy3Zxids/eNmfWDnw2X3nX56AMP1ziWDzu5WJGffXI6dqNbyqvlY4UVvXIq6FIdoiCIxVNqeqeYWe1PabP/4wgDz5VIiYja9SVM/Yren9lG4R0dyZoAMphIOIod9cC2ldg8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2664.namprd15.prod.outlook.com (2603:10b6:a03:15a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Thu, 14 Oct
 2021 16:13:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 16:13:48 +0000
Date:   Thu, 14 Oct 2021 09:13:43 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] memcg: page_alloc: skip bulk allocator for
 __GFP_ACCOUNT
Message-ID: <YWhXN8PPVq0oy2u/@carbon.DHCP.thefacebook.com>
References: <20211014151607.2171970-1-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211014151607.2171970-1-shakeelb@google.com>
X-ClientProxiedBy: MWHPR14CA0060.namprd14.prod.outlook.com
 (2603:10b6:300:81::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:1793) by MWHPR14CA0060.namprd14.prod.outlook.com (2603:10b6:300:81::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Thu, 14 Oct 2021 16:13:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7ef036d-7814-43d6-dd13-08d98f2d9aeb
X-MS-TrafficTypeDiagnostic: BYAPR15MB2664:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2664D9C6B919C7EA5CD21F7BBEB89@BYAPR15MB2664.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xpy+TrtCU3QZO7qFoxx4TdQ7akc5WBnC/D2/j/67u1Y7K6PYzxXQCulooLMZJqiBuGKFZexYFtk0GwUDN+x7+tjAu1FrjZ9pBkqPezRgsEP0qDgIw8Bv4wbHeHB66/mwQ3YKSfoVrA1eUXSvB1OtN58JHwzqMcep81lpZgPnQUd+VQxSx3mwVI+WtXo3JtsZelsXheAeM4qCAR/G32uu+DYf22XH4/hLG0dJ1mooUAhiETN3ww5gpX7/UiClqIyxGsINcbeGdlah0izRJzSFT0D+SzIFKUshZOhbjfTPxzJsSFgnGR+uIsLHeDXSLSf9xg+/jkZe34kcFPkCkvC8j4eBjqXigslwC8T37vMTFsdZYOjvrlf3eYt+YCrMysSwUFNpgyJ0Zix1NS3VNAErRgT+BNfqwpH8BTba3fKssvXtM5EQTlFnab4ocnj1zZChx88dJsf4P/Q/IZK3Z7NBRSQPYp+yWbmW/CzQus9rHN9pfQIMYLtoE8m5lkyS0XrxE55K//EPB+Ln+/jM3cO8qWiTf4T3fUTXlaOvzrAYlqMU0lXhFqj4mcd1fKNcBw/CYnCyKvXiSgGKXndAdlNJIirQDrA/qn/i1t9/K1CfDg5LYgOGYnr/ept6q71vCSwnAqEqOvyAuq13/eJh3FrUsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8936002)(4326008)(316002)(54906003)(186003)(5660300002)(7696005)(6506007)(6916009)(6666004)(52116002)(38100700002)(508600001)(2906002)(7416002)(55016002)(9686003)(86362001)(66476007)(66556008)(66946007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zqvCuTaJ9uASyAC7m+TMb0zdqK+2EASs8fowL95lYtOiDUIjbPjBZz6A77v3?=
 =?us-ascii?Q?H4XlI+WPHwgXY4hg+oeF+rdglHVU1bdIugSnjbAvTaOXuibqtKYnyNLzRm/o?=
 =?us-ascii?Q?kwC5iVnImfdwuyFTrnv7NSANdmrsGu15P180AWiE+6UwmauxL36aBUUR3Fw7?=
 =?us-ascii?Q?0TyH8wqUBVfko8Agw6I4VmYgd88LblxvOT8nWyr+a+gOz72NXBOoe6UeN2VO?=
 =?us-ascii?Q?vLnsQOk9CHqUdTlrGqgd1tNkw75fwTg/pQssngvhIv3sKqFedJ9+AnRMwcND?=
 =?us-ascii?Q?jDpK+HKoXlb9uUFtBembAmxptK05QrsBE2w7UD9uQr+9OxyiY/BrEosVGTrk?=
 =?us-ascii?Q?3Y1aeRvd1N+YCv5MFzrT+BLOZ6k1N2z0V3wXNFFVtSfO1IMOKW2DIEoApHoa?=
 =?us-ascii?Q?0Ce6gqiQh6B9tVEf/cHsoEl7guyOdZyOLZzXjBgvEOBzbfetYfai+fViUVFb?=
 =?us-ascii?Q?h/xwfWT9uphodi7MVhOzvooAiesg0TutK7z8QaA8RxEjDrGueYsYYgoci5uy?=
 =?us-ascii?Q?Ktv6CXxYW4P/Ej5YYII5WUpmDthO2K6lM8ocpCTQHZdNpC1qwSdWTxk6/UwQ?=
 =?us-ascii?Q?QRHXp/qTG1UQhk7Ly2bj8J70KNRPxHio9xAk+ek3haGMWB2xRmVg3Xr955fy?=
 =?us-ascii?Q?NAZy4NYBHdRLX1b2ZkRqM6zMe5fH+3g5sROUrFFFp1kUoug8iw1BPn9qUF4Y?=
 =?us-ascii?Q?m8DkMZgttFHaZjwuKz8ZnNQaoYWeAFbr+uyYKSUiWvfa7ZGizLV1tJhTlqXp?=
 =?us-ascii?Q?z6bkJPzMHXbn5k1lFQ1c6Ol6qy+pPL+CnwSGk9RKDxcJAJfeJxHGt3jlABZm?=
 =?us-ascii?Q?GZ0smx3/3ezoc5r+3UGRHnjmp1LhqAfxznGZNHV+bOBis5bzc7qr270v4Efu?=
 =?us-ascii?Q?byBVHU69acfaWNahNrBUnx5VGxdb8jxOmaIHrDlv6wD9J8qUNxl1WfF7qNKG?=
 =?us-ascii?Q?GcQ7kkHzd5AHtaosAz+eW1pqsgBXJgR6ewYL5B0Z87hML8p/mPw2QmkgZG07?=
 =?us-ascii?Q?imIipFLeJu2FaZYoZjAurhWRbDOvnaznrcdlEyX4rLAGwoM4/siOAgNuq6PE?=
 =?us-ascii?Q?zFZGu4L6aDXr24IZujrVi3pvHhGyWb84/5MXQv3MZ7JC2RVIt2DAG46I/rpz?=
 =?us-ascii?Q?gSDrXwKcQR4Mbapku3QLWo9EDTX04Jt0MlXeBn9/igXuKRuA8VasEfP5RIKX?=
 =?us-ascii?Q?wXvRnkU0ScMABsvrI0uB8vQDnNnWUCaND5sfGmxeB2J/65XlNKxN5lfv/LMx?=
 =?us-ascii?Q?S9V6V05jwqW5AZrNAR5p3V8Dx/gcbMfJNddmQqAwQm9WBXNAW1kga/64MG46?=
 =?us-ascii?Q?XnXg8CezfocjZJK9A49lqyxdQ5vCWjK8BGpvbRq2MBMYKg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ef036d-7814-43d6-dd13-08d98f2d9aeb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 16:13:48.7043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aNMe/aob7Dg5tDc/Cc4tf7qJsUnbR2lXxfs2EBkqEEHqaTHdXxt0iHM1Bg5hx9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2664
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ogMtYNTOgvU6saSulbxPyAwfgKIuUrD1
X-Proofpoint-GUID: ogMtYNTOgvU6saSulbxPyAwfgKIuUrD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_09,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxlogscore=941
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110140095
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 14, 2021 at 08:16:07AM -0700, Shakeel Butt wrote:
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
> Changes since v1:
> - do fallback allocation instead of failure, suggested by Michal Hocko.

Acked-by: Roman Gushchin <guro@fb.com>

This looks indeed better! Thanks!

> 
>  mm/page_alloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 668edb16446a..9ca871dc8602 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5230,6 +5230,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	if (unlikely(page_array && nr_pages - nr_populated == 0))
>  		goto out;
>  
> +	/* Bulk allocator does not support memcg accounting. */
> +	if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT))
> +		goto failed;
> +
>  	/* Use the single page allocator for one page. */
>  	if (nr_pages - nr_populated == 1)
>  		goto failed;
> -- 
> 2.33.0.882.g93a45727a2-goog
> 
