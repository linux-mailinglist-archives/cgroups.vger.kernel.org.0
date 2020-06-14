Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075F01F89D1
	for <lists+cgroups@lfdr.de>; Sun, 14 Jun 2020 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgFNRXH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 14 Jun 2020 13:23:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726905AbgFNRXG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 14 Jun 2020 13:23:06 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05EHKS3T022232;
        Sun, 14 Jun 2020 10:22:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=UC2t9cOPa56YyaDDRH7B20GO+AqGGxmlmTJko6c2T1A=;
 b=ppYV3pfuK1afmjx1JrpgTEKCyvuXDoJYdaA9O1T23HP+HBF577dv0596fyu8nZzJJ00k
 B+wCq8KUpE6iixH4yZNO/pdSJeODdTBQcXSMLfPh4Jb7CFMJoAweYLGfsLGRRUst9Bf2
 1nTxr8k3SwajUxhCp3lzCxxI4DndbDTpJow= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 31mt9yc9u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 14 Jun 2020 10:22:58 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 14 Jun 2020 10:22:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKHs4AKjEHaCnm9hUxaK1RvnSOnV1oG80ZUE5biEBiKK9ychZDv4KJbOByWzbrlYligtaPb7loK2I8BowwigErG+Uo+srQ+l2e7nUHmlm6cl8ZPhLku/4pHfKf0DHLi9P6sheAFVVpJ/3XiSRnVdRUeUt3qkn4qgoh+Rnq2SrMIUQ9mW0H+jXlGNkEo/D36PuHQaZnC8rI4Q1i60CHWY34E+OxwDwCnYDCN3mBv2tRHnCIO+/QyKL17C2yfsfmUPHDjwarCsmv2cK9OXaxDUc2XvTFNa/2IcvLp+icrtuIPPgItfyGx5ktX70DY7msaE8kBq9P9Byw4G68Hs2b0SmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC2t9cOPa56YyaDDRH7B20GO+AqGGxmlmTJko6c2T1A=;
 b=GP6d64dk5N0oREY4xir4vP32QL/CRqzDwJE2QpIWq8FOfse6ZFvy5LeRRKAoIiF22QdLKOjLU77aAUWJBUrVUIskI4HSSVT3OgbZEDTwuCwmEO+uZ+T60Wa5Hit20M2Qg2PSMLu1Hig9+6Y1CDegQulahl7onbv25Vfy8m9ncsddgYpqmIkmjNKuUZHnmbhyjqeuUfulHfQ/lCsj4czAytdf5u4q1sqQRdkfOGnY16koMHPYwp9qXXO3ud+iN4LXiJIhA5Dqjtud6aidkF+YBWxQfBqJXBzg9XeOqTL7pSUkJjzp+w8QAJwe3C3+kapCbb06zmqaJl65uEcq8zrSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC2t9cOPa56YyaDDRH7B20GO+AqGGxmlmTJko6c2T1A=;
 b=HWv8dzFQondlfTV5au2JyQmIXTrUOooWABTGitN1aK6F5scQoynVw/e22gMs9NZPql0OJ4Xzo+BBUX6TAzqpi1UBavUwxlj3ns/qfUz37xpV9Ssds2j2sbk9p72un2VH6CbB0Z9XUvvXAG6Iyc8fdwnAymrx3yIKHHBMzdKBDIM=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2439.namprd15.prod.outlook.com (2603:10b6:a02:8e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Sun, 14 Jun
 2020 17:22:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3088.028; Sun, 14 Jun 2020
 17:22:41 +0000
Date:   Sun, 14 Jun 2020 10:22:38 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <cai@lca.pw>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: Fix do not put the css reference
Message-ID: <20200614172238.GA755479@carbon.DHCP.thefacebook.com>
References: <20200614122653.98829-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614122653.98829-1-songmuchun@bytedance.com>
X-ClientProxiedBy: BYAPR01CA0050.prod.exchangelabs.com (2603:10b6:a03:94::27)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:f917) by BYAPR01CA0050.prod.exchangelabs.com (2603:10b6:a03:94::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Sun, 14 Jun 2020 17:22:40 +0000
X-Originating-IP: [2620:10d:c090:400::5:f917]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abb15d84-54bd-4322-3058-08d810878b08
X-MS-TrafficTypeDiagnostic: BYAPR15MB2439:
X-Microsoft-Antispam-PRVS: <BYAPR15MB243948C30EE915684CCDAEBCBE9F0@BYAPR15MB2439.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 04347F8039
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3t4cX3DQQVQJcLK+5rkdx1AapASXJbuPmPNyUfiV/8yOq4muy2PI2fQMzG+77HQqKntOzZBZ3+bvV0IX80O26XG94jRwrSbEPRiTPcdELT4IYKvhmZH2Vi9hyiRjTreOs+RqVlPwjz4JK8R06ixpCiVXCvidE4ahHXOyCA91G1QnPBjJPs+AMJ0qBA0y6adlJm++1fcFq/SopC5F16ewASpOL7yM+1HIzDoDBSIWFg2P5WQcQMtUq+JOVCcplRob/XW++dXpItStP/ww9qLKDYGP5c9rqBaLCDMhCMY7NfBtCW/W1d738fpbJUfmK28q5CVQZiIIwoufTHAcx7mvPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(39860400002)(346002)(366004)(396003)(186003)(86362001)(8936002)(4744005)(66556008)(66946007)(6506007)(6916009)(5660300002)(2906002)(478600001)(16526019)(66476007)(52116002)(7696005)(83380400001)(33656002)(4326008)(55016002)(1076003)(316002)(8676002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: oz9q69NdPmH9BTT/RR8MfL+hXiOeK/R55g/B7aXHEpu2orhimqKuhvwAmAhKbCFPFK8pigocnNCaVgQbMXuIQWpev3Z5itKA3HErQJ4PidMMQU/cC66rRP/TEmMj/M67EFKuBUrt7Co88KNLqijXBiLsB13ojBpy5UVL3CxIPq8RFjkEoPQ8GKNJOQ8FkIK1q58qCIxBgwtZpZoBKF+3aOq+Aptvnq4hQx5wGfnizzgswTUNe8sx7DvR74JyJqN+WqrSKzPeDtMmfAtDe76XDfuHu+CNJ7d0pxaYiNJTLvEvKSSDDjUUUQtF5vbmyO9nQUNKUD2K6T1cWA5aLLh35vsIFK0RrOErto+vIT1GLjbNdjAUb2cxUSYv4pgaJhahKOUwT/CEnxs+mSEQ97ZzXbVsBP1D5vqeX9o5Cm6qRMhcduBSoAf3f1HYDVZkik4GjRxb539Cub1ZKUWewME3Cx9h/a0Fq1Ylgv5EcBTR8F2ShLNKSp8Wf8dqF43mbbGIFau7qeZs/fVeLq+Bz9cD4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: abb15d84-54bd-4322-3058-08d810878b08
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2020 17:22:41.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZgl4PM43yMox+1RFyZw7KwvERC74npHSjRb5KA9rcdk6ljihK6PCyL7HgJFE4iP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2439
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-14_04:2020-06-12,2020-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 bulkscore=0 malwarescore=0 spamscore=0
 cotscore=-2147483648 phishscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006140153
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jun 14, 2020 at 08:26:53PM +0800, Muchun Song wrote:
> We should put the css reference when memory allocation failed.
> 
> Fixes: f0a3a24b532d ("mm: memcg/slab: rework non-root kmem_cache lifecycle management")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Good catch, thank you!

Acked-by: Roman Gushchin <guro@fb.com>

> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0b38b6ad547d..2323d811ee8e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2772,8 +2772,10 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>  		return;
>  
>  	cw = kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
> -	if (!cw)
> +	if (!cw) {
> +		css_put(&memcg->css);
>  		return;
> +	}
>  
>  	cw->memcg = memcg;
>  	cw->cachep = cachep;
> -- 
> 2.11.0
> 
