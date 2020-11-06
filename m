Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B613B2A9EB4
	for <lists+cgroups@lfdr.de>; Fri,  6 Nov 2020 21:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgKFUv5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Nov 2020 15:51:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50618 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728444AbgKFUv5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Nov 2020 15:51:57 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6KilTe017041;
        Fri, 6 Nov 2020 12:51:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=g/IF6JDeuYmH1ljRDYU6MG+7bcLFRY47bRijoqWLlug=;
 b=G4m5UURfK2cLS7lmNUqhuY0NnUrFFAX0/GYVEinPITWo5KYgnwY6TIjgWKaexUklh8SP
 eIvhtcXmsIuvT2ZDJn0FjLV3RsSzzw+WeLB6iiIC2RIPj7g1U817IS8h/Xb2N9/VosKK
 XiavQmdPQ99BtdryV0lPbvA01ITzEM3xPPI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34mr9be927-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 06 Nov 2020 12:51:48 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 12:51:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnmrVO9cDhXYd1SjnhaEdDOK6qiNFm7OCp9P2/8nGTpeL+MFicNu23Tkr3wzUdfrvJQw3ZJVPs9ty1nTlhBkdossahxysy+WWr9WZaccsldxHz1ReH7CPR6bt1dJdjYV/3Ji+cFpi8aGQA+wP+z7/aRfqWs5pm6kb+DE4uU59L4JnuzwQGE1DAcWwheY4q2vLRcBkpL7h7q31yMFii/+7DYnidBr4LdfhPCi7r8q1lZCe7D7SKy3tSAuajjyki9KA3wprhnHkCSJ9w/L18JdAd9ZE1dIZI+MHVzJe8AwJcqn1kowPvd9TJ+hDleBGSCdeUduLNx+UXLzYKmn/tEfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/IF6JDeuYmH1ljRDYU6MG+7bcLFRY47bRijoqWLlug=;
 b=WxQJMyOzQsbamJLAEBOWcKKB7Tma3YTf1CJxbsNMZarWVBrY4ma4LDcOKsyPaQNLi1Qgw8bw4YfaQDWFFeuwUbY9nyC3FGbt+0NDjSJzhONSmrjXXOVncoGnm8aqTsiP5y8eLhMAHsmX4doViasSil/BV7wzAYEOfjx99UxVuVpXHfKTAWkTpRnDI9suQK1iTh6iR9ZvJpugBjkWLLfM1mseEBLRnoyHp5OdhVWPrboXfyBZfjzfChh5GiJk16BVYjVInukYl5ZqSZyw5RFPPOKTobpjr1PhCPS8wmf6In+9skofp/WQRUEDKtHboQlQuC23UVwNFeVF1AgUS1irTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/IF6JDeuYmH1ljRDYU6MG+7bcLFRY47bRijoqWLlug=;
 b=Mr+OC9T3Mw00pmrXTf77P7zajnLuaQV+JYhX3/k8Ip7DXM9KKHTzT9bqzvzEsjVy3BwsgDHbid+RVASBLJoLZR9nyarmO28x5wIFyWnuJkw8sUM8o0APTPMNEZd+20l8WWkvnuX0RKTFqnbwJ5io8r3G+F87/6luzTvihE5hhjs=
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3400.namprd15.prod.outlook.com (2603:10b6:a03:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 20:51:46 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 20:51:46 +0000
Date:   Fri, 6 Nov 2020 12:51:40 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
CC:     <hannes@cmpxchg.org>, <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memcg: update page struct member in comments
Message-ID: <20201106205140.GA2285866@carbon.dhcp.thefacebook.com>
References: <1604662413-5734-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604662413-5734-1-git-send-email-alex.shi@linux.alibaba.com>
X-Originating-IP: [2620:10d:c090:400::5:b957]
X-ClientProxiedBy: CO2PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:104:7::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b957) by CO2PR04CA0116.namprd04.prod.outlook.com (2603:10b6:104:7::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Fri, 6 Nov 2020 20:51:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ae20a48-3e6e-4de2-a245-08d88295c654
X-MS-TrafficTypeDiagnostic: BYAPR15MB3400:
X-Microsoft-Antispam-PRVS: <BYAPR15MB34005D3E3CCEC315BD8BDA93BEED0@BYAPR15MB3400.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08hHHBH0MOL6vnpEq8/r5XYGSSRlIDIsEdzf6KXZTpqnHqkIUmNHl7V9w6MYNBNLpPg/Fg+KP7ZOmyfzoDwqbqzZsoY4tmI0p7OlfC0Q4p4Cx/h1ZmAN9hc6JIQpYBTSX4+amAFLfvuSmil4lzMltaswL1fjLzWLSXvs5P8J7GLNg0hzGMckbJrD6sJPwkDQXqi3OcHQyhau+QA675JRIvvlOeIPEgKj9ZYpAvgPDXRC5gIVt5fRHz7+l1jcodg4/eUBPiWxs4DTXkZfdq4POjUUgLrSBeA9/Iju8VvyFGRLw7pSXwy8PLoxqPmXy/MZopAT/k1a9rt9IeVP9kgmlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(346002)(366004)(66476007)(6506007)(186003)(2906002)(8676002)(6916009)(16526019)(54906003)(6666004)(66946007)(86362001)(52116002)(8936002)(4326008)(478600001)(9686003)(5660300002)(83380400001)(55016002)(316002)(1076003)(33656002)(66556008)(15650500001)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 50kg3qKfBRR0eQxVDHWyR6FPOE4Q/rQvdkGk7E4ZI1E8osbet5+jCc29vun0DfTpGINTZNQTUbuaABUor25PyWHc89HSSqrndOSBrCJGY78Zj7u6QdaVdjtRjE9P1ILuD+1UMaVU9tLCdPzzti4z22wjyIH7MotUljw84g8vX1I1SujlknQ+1vk2KNyF+OfTii9YOjl/LFnLCKe6janVIYEKEUFF6LQPX+TZrDMN8RHJYkf5jR31Cl97oL8PUovit9Pc6t4j8Dq6+dIR05Ir8bBEPAmkZfn/H46hQAne0wvVJbgfJkvWxGOJ4LbxfvQSXCthRsozibn3G5wqpmfoTJ4TTb9DZt7wFdtv7897oYrSZDKVo28iNMxYThuFkpb3/xko0sGm+uM85WE/X56AovqduJ4/gr8ni0V6jSPmXrP4MkKqGgb6Z2YzWFXrjH3DH6Xg2ItohIfAXfvHIpgYyZlzGt44eOT5LYHvUnEhfHUAzly1xlXtInBk6lL/XC5nW+HljHa8zvn/na+Edyxk/BzSXp7FYYsKcVBAUZGDcMXbdIZWOze+67v2cD30BCe2Sxxhyh16fLFh6Y3g6gnnx9NW2FunIjNhCYKxTHA9nVtUqmUum0c1QaRuxufdyKhUA58xOCT6Mw9deJ2zxh92VmkkzFUpRRRQ0kxYCwS0GjQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae20a48-3e6e-4de2-a245-08d88295c654
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 20:51:46.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvgo0dzQEZ/G7EZrTpd5ItYiNZgx0MFFMUblnaMnH8VsSmQVB1AptTHZIVdyTJHa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3400
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 suspectscore=1 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 06, 2020 at 07:33:33PM +0800, Alex Shi wrote:
> The page->mem_cgroup member is replaced by memcg_data, and add a helper
> page_memcg() for it. Need to update comments to avoid confusing.

Hi Alex,

thank you for bringing it in!
I definitely missed those.

> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org> 
> Cc: Michal Hocko <mhocko@kernel.org> 
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com> 
> Cc: Andrew Morton <akpm@linux-foundation.org> 
> Cc: cgroups@vger.kernel.org 
> Cc: linux-mm@kvack.org 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b2aa3b73ab82..8a8debea34fc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1310,7 +1310,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>   * @page: the page
>   * @pgdat: pgdat of the page
>   *
> - * This function relies on page->mem_cgroup being stable - see the
> + * This function relies on page_memcg(page) being stable - see the
>   * access rules in commit_charge().

There are "page and memcg binding" and "page's memcg" used in similar cases,
I think it's more obvious than "page_memcg(page) being stable".

Maybe it helps to address Ira's comment.

Anyway, please feel free to add:
Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
