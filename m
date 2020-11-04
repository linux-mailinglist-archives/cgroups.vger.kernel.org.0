Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797022A70A5
	for <lists+cgroups@lfdr.de>; Wed,  4 Nov 2020 23:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgKDWiV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Nov 2020 17:38:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31972 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728085AbgKDWiV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Nov 2020 17:38:21 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4MTvXQ006018;
        Wed, 4 Nov 2020 14:38:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=SaXYkKIlRUoE2k29DxM72HhU3WLstM7GE8lDlgF29S8=;
 b=jJOWNDX3uFjBKHQP197Ajf+iOzNFtbD7H/mju691sv6If979RmQpjJ10ahihL9UOjPFC
 E+AJtQQAAs0tPBH8EfhZJ2iNjYw1C8nrorQGy37aKa8bYeZ/QBaXrVpHaYd0fkE7s7dH
 rqSMC+wCFnVFXGeUhgctA9co+cINrLiW/9g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34ky5tt9uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Nov 2020 14:38:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 14:38:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1eVIKBmqZU8k7TTXxUNXFQtTFZZf0XvNFKq9fx1F2lVkx4qRpA1hQ0KXw83elLjkIrQHPCSoYEz/6MEL1uLUvDpmVmjzasq/g+cD0LO6zCEuS+/tjO1edQuQd6ySXgo1fz1mJupd4lGZ87DSJbOpyP9irTcqGVmI2XonDgGjuq6rkABXlAraOdirRXuuxI+uzVAoBrkEsmzb0cWqsSgWZNSy8JYSwbImT/JLjna04kNyKlrYzBzvz8rFqNiky5nf0+O/uRLQF9L8COgokOP7UP69HxlaQg3ih9Y8wJEnEyHvRrN0Hzu1NmGcGzuFBRXd/CHtLhTc2AVxlaA8A/HyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaXYkKIlRUoE2k29DxM72HhU3WLstM7GE8lDlgF29S8=;
 b=SnM+laQNrX+FVBFXKeA+fgPWLe2SkTcgwCpk5zRC7cRKtYCAkMTDKevi6f0xG/pmRwxYDqjppP1IFKbMbsrqy30jScsVDTti7PwC5IIVPXDF9xvOnoL+RfBK5pr+0THvviv1fMsJw08UeMYniIs5F5oC8XsSi3bZkYCepOt+xFFam6m3ojHSvu5+o6GIVvYygjfs6IXSIOviQNs+3t03in4ZoS3MmF4qE6Fq29eBqj++oIpoLLgy6kKwcbwAZ2zIDt5K/4GsUOShFQ8b7if1Pcey/A8Q/FR1XfOp5R8/NKBNU0zBF05HbWXCs13M1M5cyROUFkiJjGfiWGDaPKwZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaXYkKIlRUoE2k29DxM72HhU3WLstM7GE8lDlgF29S8=;
 b=TDENzwI3mNN8drG9OZM+Lc3CC5ZefjbWaxNbV8DQ1leGm+t2RMiNLMqPBR5RpI14dR2X41ip54+nWHau1/92s5OH762Hi9WiADFRBI+8DX7QSehMgk8rp6d5xk6GuNi6NojCG32CVGwPuUwyS8X/tEsjOkHkQC2SFaLdMwztEIc=
Authentication-Results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2391.namprd15.prod.outlook.com (2603:10b6:a02:8c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 4 Nov
 2020 22:38:04 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 22:38:04 +0000
Date:   Wed, 4 Nov 2020 14:38:00 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Hui Su <sh_def@163.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <laoar.shao@gmail.com>,
        <chris@chrisdown.name>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/memcontrol:rewrite mem_cgroup_page_lruvec()
Message-ID: <20201104223800.GD1938922@carbon.dhcp.thefacebook.com>
References: <20201104142516.GA106571@rlk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104142516.GA106571@rlk>
X-Originating-IP: [2620:10d:c090:400::5:ae3f]
X-ClientProxiedBy: MWHPR14CA0061.namprd14.prod.outlook.com
 (2603:10b6:300:81::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ae3f) by MWHPR14CA0061.namprd14.prod.outlook.com (2603:10b6:300:81::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 22:38:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22cd2d9c-1a39-4beb-879a-08d881124b2e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2391:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2391706F8957759B683F67B8BEEF0@BYAPR15MB2391.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3As0JoBdg9I0wFZshkl2qN6V7YMb4RRwqi9r6dQxmKYENvdERTJ6JkMQeXEjwBhTC7jgg8cu9RYlHr4SPwqE0W5RDG3wqyxbQv/h29jDV8RU2fiiABociWrvchzDtVRwLH+25X3alMa7L0DSgwq6u9qFw8RD+xLSg6IetNbFjJMA1NY1Hsve7hZvIJwBgkG3mOqRg0v9qUN/072zZvkpd8NsPaOShMMU9WMhMlM5cLU7MIEKTCUT8v31gfO/CgcXlQ4VEa40sDmPJ25o7PS4GTFeUWNS7u6K9Km9UVbJ1xQKX+oeoX5KEwTG6BsqpywVviHxwxS+lfAWl1RT+iKqyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(396003)(366004)(9686003)(4326008)(86362001)(5660300002)(8676002)(83380400001)(1076003)(55016002)(2906002)(66556008)(66476007)(7696005)(66946007)(8936002)(16526019)(6506007)(33656002)(52116002)(186003)(478600001)(7416002)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: HPCsBN+bSVeyVmB/lV/vDkwc2mUuX5Y+C0Zr67w+6i8IchCQdetUXnOBmfl2VydmyAORC+e4ezhDyUbaGxchSZBNKPkRwd401v2qfFIlb57YsYj0VBGEhHGnBXiMQVoFsZUJ7SLBHhmkRIT3HZdVyCJkrvtPHa6amScJcZAAXJx4+vzzqxkx+d2qF7X97mj13Rp+RTuU4voYJb42rpY2EB/x1R3tKirP0/Zm9FvHVHLwwLm6DwyoujzrouX6kbeZe5coP5Q5TRyGoHMGnoPf1mtfJLa3pw7lCXP6bp3K4nHkeJRrZGnyzZGLFGKnDgBisjg4SIul2zWGpQ9NWC95UAR6LbiZ8vieFs7a4F789NlxYyzIegckEhxRKcEEfGjo3U/teyYMnPWgwoSqWvmC0JYUdVuGYy2asX+4g9fLxuqQMppS2eSm7ekBY9Mb/V+E2kbv/EQRvX/vpZN9P/2TYToosQuJorwkhkZyphfPdmOlbSvQeQ/3ZnceWeMbI+BxMKoXX8S2a3PdCNUOGQ/JHl5w/WRPBL1M8t1IdlTLU9a4U5rSKU++4ImqiEuDFMbLztI81KCXI9TlCt0x9oAu1ViI8oGySBY0Mb7XVQbykcRcC7ubAM5ilfXs3CRXLL/J8XnrUEx2AnfAwT4rRrcdSayA4HUqXXMoy0srfe+hc5c=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cd2d9c-1a39-4beb-879a-08d881124b2e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 22:38:04.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSy3X/01QdUTpQh+yDluV1tL5msVKCqfoc8FR9FZkp2colpjp20RebXNIL+wyEgG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2391
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_15:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 suspectscore=1 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040161
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 04, 2020 at 10:25:16PM +0800, Hui Su wrote:
> mem_cgroup_page_lruvec() in memcontrol.c and
> mem_cgroup_lruvec() in memcontrol.h is very similar
> except for the param(page and memcg) which also can be
> convert to each other.
> 
> So rewrite mem_cgroup_page_lruvec() with mem_cgroup_lruvec().
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  include/linux/memcontrol.h | 18 +++++++++++++++--
>  mm/memcontrol.c            | 40 --------------------------------------
>  2 files changed, 16 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e391e3c56de5..a586363fb766 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -457,9 +457,10 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
>  /**
>   * mem_cgroup_lruvec - get the lru list vector for a memcg & node
>   * @memcg: memcg of the wanted lruvec
> + * @pgdat: pglist_data
>   *
>   * Returns the lru list vector holding pages for a given @memcg &
> - * @node combination. This can be the node lruvec, if the memory
> + * @pgdat combination. This can be the node lruvec, if the memory
>   * controller is disabled.
>   */
>  static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> @@ -489,7 +490,20 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>  	return lruvec;
>  }

Hi Hui,

>  
> -struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
> +/**
> + * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
> + * @page: the page
> + * @pgdat: pgdat of the page
> + *
> + * This function relies on page->mem_cgroup being stable.
> + */
> +static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
> +						struct pglist_data *pgdat)

Hm, do we need to pass page and pgdat?

> +{
> +	struct mem_cgroup *memcg = page->mem_cgroup;

It seems like you need to rebase the patch against the latest mm snapshot.

> +
> +	return mem_cgroup_lruvec(memcg, pgdat);

Thanks!
