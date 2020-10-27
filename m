Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF829C31D
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 18:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1821395AbgJ0RnV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Oct 2020 13:43:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23462 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1821393AbgJ0RnU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Oct 2020 13:43:20 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09RHYdMN005700;
        Tue, 27 Oct 2020 10:42:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=HKF61jpSHkELrGyeUZ9KBZQCL+Wm+QFL2+V/mDIllu8=;
 b=VxGGc7C9Lx9fEkCDg9Q/5lSOHDj5noPu0z4WI0KizQ0OOl9j03sm+4R6lyfqjxcKU+CO
 wLVo0qqcmrEWhZv3eeCgWsWOmv17rMAza1kJOzf4LijX778fpmrdxSNBtF971j2UzIIi
 pMsqDrkAOCHYyMi2bLEo4qCYAZHSOTirp80= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34d43kcrn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 10:42:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 27 Oct 2020 10:42:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCIzVaqGqt8FYii7O7Wscv9vzo8/SwNmfapYjHTGS4AuLsvmp9K2fddu6DKH0SAIYEeN8lUi2GxHcUl6EhzqL9Qk/r7BrgQYngeZBzfB9XaBBAbF5tmZZt/piDWhJINdZ7WWRRe3tuo/YbOb80pezllN0UbW1XiWtz+TvLKoj8uHIAzV0AV6tMxgOkGYs7wmPasLt85yQx/qwSDeaGHPd6/LLaMBTjzRapz1zFAlYKioDkyOY//HyokiNB3xIXbterUgAX0ZD4TNPJBauI01DTskCQogocvyiOJj5jUyQ/W1gen9ecLsN9P6DC9etW+JZ442x/DxYnPJY4m0ufeL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKF61jpSHkELrGyeUZ9KBZQCL+Wm+QFL2+V/mDIllu8=;
 b=imwEzZVccZcBzKDfU2jJQk8BiP8Rq3939Mb4bgrV3xS6fS9VGiGRfbzC+oMp0O5dZAGJM6gKSEROGJA05CWcB5yzexv6rb2nv3r33IsXbsUQKKDEtjLCTZVeYKXppN4CY+QHl1ySRrHQu8gP/FgAqGxK/7Uy+Sv1HWyZuubAax7DltwvWttmpYlQuPAUKIiyITdOjv9ToLE2HtoR012PoR66nzCFm/IWBjNAHigosT+utw9x3BX6P3ssC/VvGpoB+5Tubcr3XINePado8iv/YRvgXevRvhcdNolyx9cdNTmxtAdYQdo3CVtHhiNKqx9KUbpC8jzWyOxZX1gWtAsxFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKF61jpSHkELrGyeUZ9KBZQCL+Wm+QFL2+V/mDIllu8=;
 b=Ce5ijDAj/UD3WkJSCDSdZ60kGJJ7B7wpiqrTSIeUErSZpxhZd4kGut9YKCwhhqDSkDwmZGUDXA68+Mb8vAzs1O2mHdf2OvGjB5SnJl3aJyu2dyYvFVIVyYY7wVCcEyF6UfRG8BqU20F+jAmo3+WHTopvfRmDI6SlHCPMbZawsls=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 17:42:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 17:42:42 +0000
Date:   Tue, 27 Oct 2020 10:42:36 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <iamjoonsoo.kim@lge.com>,
        <laoar.shao@gmail.com>, <chris@chrisdown.name>,
        <christian.brauner@ubuntu.com>, <peterz@infradead.org>,
        <mingo@kernel.org>, <keescook@chromium.org>, <tglx@linutronix.de>,
        <esyr@redhat.com>, <surenb@google.com>, <areber@redhat.com>,
        <elver@google.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 1/5] mm: memcg/slab: Fix return child memcg objcg for
 root memcg
Message-ID: <20201027174236.GB725724@carbon.dhcp.thefacebook.com>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027080256.76497-2-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::4:ba7e]
X-ClientProxiedBy: MWHPR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:301:1::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:ba7e) by MWHPR11CA0023.namprd11.prod.outlook.com (2603:10b6:301:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Tue, 27 Oct 2020 17:42:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30822ad-e36c-4933-3417-08d87a9fb4e2
X-MS-TrafficTypeDiagnostic: BY5PR15MB3651:
X-Microsoft-Antispam-PRVS: <BY5PR15MB365143F520A4E66ACEA77965BE160@BY5PR15MB3651.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfyenTPJuMytI7v9PWZ+GB4G0fCUUxADAS+vppb6TK/JYjFdYnM5nZIlxLrcH5wODsIzHHAuNom4lRjOPMa/q0oAhDrnoQFg5dzDORG8Neioti9MmJoC5hiPvzE5ef/OL7PhU7j4Jk9u+w8AoVm+gqT65FouTxXJmKNShTkcjFSdrlu+IxVq6niBD/P0nKNAfIe1un/G5vtRNy/P90zzsR/JhlXcq0WaN3vqeZPyjvm0PZJY+38KIlWmHIJDV9fPdZNowVe9pVfZ10BFBqxdoTEZAk5O41WgOWPPJ9Bm6bhZo8ODO0T+ELhoBMaOHmWHk68HDLEuAxDNaSv9GDsfB8p1o1xj8VeeH5DiuSG7D4gMLa3gRbNwoRXgQflxsjAVg4aWDBYZwNroq6fYbK1nAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(136003)(39860400002)(966005)(8676002)(316002)(7696005)(478600001)(86362001)(7416002)(52116002)(186003)(4326008)(33656002)(16526019)(2906002)(9686003)(6506007)(6916009)(8936002)(55016002)(66556008)(5660300002)(6666004)(66946007)(1076003)(66476007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +1I0SWb++thBqtrQc6s/UDj1AF8f3nngbQLljw1VlZPXJEP6PTikdCqeAFciKupVNPb3r3GS6gpM7WJHJFcE3eKLoW9bnijDxHxmX9LoWuFkIFJjVNtMvObPgArWMr3qxRqIiNTG6JeX9MqZUzZUfZPaUK1PFRk2rWXKoBeAfQYIF0aekPmLzvVwYiR4yuy+gJ3JYSYeulPWVkNfEyEsCH4FgdGnVkSotTLK19cLap+O1AZIWGXsFB5NEhplqiDR7MLot0dNTSFX9Xf65qN6MHrHEr3bxLIhMU/Zq4LHMUS9CUoI+9+s++dKIJOHFmyxmZD17eR7KY/RvTbbzi7Wu0dsLlg6VX6IRbJwsYFuvcNUXyG1Vfsgb5DGqWbs7teARiCV6YV6ty8nyapBbxan83b8NE2J+u4kj0tuGS8s+ec0arUnF5IbN94iD2BuH/0shDGxrFGgP5FVaTZq2/iGlaKGBXinHwna6LFkiOxS4aR9scF9BSWL7ECyef0K5vGOWxxbXOR/0++JGL3ggwLltiMdtjLLLWNpvpzNZxsOWu5Lk43qMOfYtUdJkUcPxQiTpJMKNWi0E9l8DYicHYJBHn/pIgkyeEZxxTlTMajeXUsvWucKHl7YisLrS3SDXK8D2fXolffvWg+x0Sf+XUTz0sUnbOH2wtHiWntoqzwEPas=
X-MS-Exchange-CrossTenant-Network-Message-Id: d30822ad-e36c-4933-3417-08d87a9fb4e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 17:42:42.7876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkm9wphU7RHHxsRJNzXKjwpDFvftDuaRgMJSxhDhIVBRt4EWG3qdMO/BaLfTkWf3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3651
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_10:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 27, 2020 at 04:02:52PM +0800, Muchun Song wrote:
> Consider the following memcg hierarchy.
> 
>                     root
>                    /    \
>                   A      B
> 
> If we get the objcg of memcg A failed, the get_obj_cgroup_from_current
> can return the wrong objcg for the root memcg.
> 
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Hi Muchun,

thank you for the patchset!

A generic note: it's usually not a good idea to group fixes with non-fixes
in one patchset if fixes are planned to be backported to stable.

> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1337775b04f3..fcbd79c5023e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2945,7 +2945,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  
>  __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>  {
> -	struct obj_cgroup *objcg = NULL;
> +	struct obj_cgroup *objcg;
>  	struct mem_cgroup *memcg;
>  
>  	if (memcg_kmem_bypass())
> @@ -2964,6 +2964,9 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>  	}
>  	rcu_read_unlock();
>  
> +	if (memcg == root_mem_cgroup)
> +		return NULL;
> +
>  	return objcg;
>  }

I agree, it's a bug. Good catch, thanks!

I would prefer a slightly different fix though. Because we're going to change how
the root memory cgroup is handled (an rfc version posted here:
https://lkml.org/lkml/2020/10/21/612), it's better to not use a comparison
with the root_mem_cgroup and handle the obj_cgroup_tryget() return code instead.
Something like this:

@@ -2973,6 +2973,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 		objcg = rcu_dereference(memcg->objcg);
 		if (objcg && obj_cgroup_tryget(objcg))
 			break;
+		objcg = NULL;
 	}
 	rcu_read_unlock();

Or a more explicit:
   if (obj_cgroup_tryget(objcg)) {
     ...
   } else {
     ...
   }

Also, please, add:
Cc: stable@vger.kernel.org

Thanks!
