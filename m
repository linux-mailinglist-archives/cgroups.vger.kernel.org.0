Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CE41F86F
	for <lists+cgroups@lfdr.de>; Sat,  2 Oct 2021 02:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhJBADY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Oct 2021 20:03:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45402 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232167AbhJBADY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Oct 2021 20:03:24 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191NBW5H009633;
        Fri, 1 Oct 2021 17:01:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=5gz7YSlarJ07h01uq4IkCdGsjsXQ/zFjQMWSISYmfRI=;
 b=TAGYh5KOTLgX648FkirXbVF16NHX22SVguiImWTieSayt2+006j48+G3IocOFOVq8j18
 lg7yVUnb/gtluRyhZ+noF3fEK2l464NMGonA/hC0GWUX0Pk2s9nqlZhKBB66vHqR1/cw
 MvRoT/xnCg2ezrwsIWEH72ar0VPJOo3kBTk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bebsj87df-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 01 Oct 2021 17:01:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 1 Oct 2021 17:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In9pyACTJ5zwTiV2YbZhY2G8Cn+1WAq/VtZ41VoQp4KRJfLZOR6x+Jh6wKszRMvgu+mKHL1EO1xnsMebY7kJMB7uVW2GhzHQGmB3HvFuJlnc+Q/oac3jKMCvBbfKqgIhhGRCvRbsL99RsMdl34L8KDPFVL3zrvqPX3u52b2p8W42QWrunhxOLYUu/M1pmc47RMH0jl65p1pRpjRDUElsiuHM3WdXVqijVulkaEvOtGUSI14j/dL+O5c/du2Rgd++YGt1huYAGmfCUVFWfJx8/9mCVRk5ayNrFltCjAf6M54xzua0K/9qg2FJfejLq0lgoviGIGKGKwdyjs5lNaQqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gz7YSlarJ07h01uq4IkCdGsjsXQ/zFjQMWSISYmfRI=;
 b=TFAaTgJ/xdFINiG1oTzejcoRbAS8evz1N24BlBgZl/5Uxr7K1c4TTsn2Gb33sa5iSEu83dLFLXsKVK73O9lQYzT4vaQEP3iKsM6ksLFyS8pbSi6SylFEEE0Pci9IAWngtT/YsPNN4/5rw1XFMF23HZnvELYDFGyw64VgWQKlWKnodfJrrGIGPfOL//v7iz54YY9R1DMyTqX40BR8XfFetVpjEZM3ZhwtkP9dVTMrvqyxMRTTNL8R1lTTGTrOohqQKc962E7ehEXObRvI4nD/JLAdAAMVIykSRZL3xFKt7aprfxjeXTCnyGIAbtLbgrMkCAR61118Wd6fWOmsiElIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3480.namprd15.prod.outlook.com (2603:10b6:a03:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Sat, 2 Oct
 2021 00:01:06 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4566.019; Sat, 2 Oct 2021
 00:01:06 +0000
Date:   Fri, 1 Oct 2021 17:01:03 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 2/3] mm, memcg: Remove obsolete memcg_free_kmem()
Message-ID: <YVehP18mCcsXmFy1@carbon.dhcp.thefacebook.com>
References: <20211001190938.14050-1-longman@redhat.com>
 <20211001190938.14050-3-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211001190938.14050-3-longman@redhat.com>
X-ClientProxiedBy: SJ0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2431) by SJ0PR03CA0197.namprd03.prod.outlook.com (2603:10b6:a03:2ef::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Sat, 2 Oct 2021 00:01:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b5d35de-5eb2-4437-d65a-08d98537bb85
X-MS-TrafficTypeDiagnostic: BYAPR15MB3480:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3480B3A7023D015678ABE8F4BEAC9@BYAPR15MB3480.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpbOMav1IUOTyIpFSXN6GLfF3aQX/iJm3z/iSz0c7EK+XbAhiPK+00/aln+jTN7cjQviEej/x5bjiy+XhheJ+sGRovPmzXcdeo1OTF6ktjYlxY7Iu0pi0IX0CBZLqo71A8BstixNIhLJdLqg3KZzHYA2CA37gZODzL4vRVOEBsKwFVj7rRlvmxAOE15Gfc75q+KwPSGCoCaApQ+xtZqVpXjDg6BKvpynMP28j4nwI2z3Ou5FcE/+0DobXuXPpYIgWJ4WiJm7dnh/Fp5QDKLtcZKww17I8kn0/etQ4H8+22fszdU6RxbkPnUzRFTH1zUDGqirb7cYKcXtol+Uzba1mqQUkn0i96gQSi1hAy6xDDhebaUyEa3jrdpd+gJ3AxfJkE3oyRWqE/7gjKwZiUEjZd0xdRqn7Fyh0Lewn7Jo4a38SeiGX/b4VCZI1gzGtgqSkYz5C/gUwrVI+A0K+66RIX0RyuipDoCPJWe/y+txEBmLdj6dDcugIYtE3xxSVYSY+VYn0tUOv3TovrRRHCsDu9ffq8bmDv6pMKka3sFrg3K4hmnao/MHkaco23e1i0+r4dfZjy1n/L9GY3pfNHGLLoWKRPdpTvkYdfdXmH6+FYnjbj59ZbvJI+ilijTsSmEMUFNHafVOoyvKI4Dl/DGilQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(316002)(54906003)(6916009)(508600001)(4326008)(7416002)(8936002)(8676002)(83380400001)(7696005)(52116002)(2906002)(66556008)(9686003)(86362001)(66476007)(6666004)(6506007)(186003)(55016002)(5660300002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?29zsu40KTs0IPPKoo7b/hFgnlJyjBcgr/i0OxX6woENFXjVcaDLbe6uilxwP?=
 =?us-ascii?Q?PHquNDEhZSJLtciIJ6Jh1vSs1vcXa/kQV745UgQypMM7y7ZUPGvypPSxlHPi?=
 =?us-ascii?Q?+DEGd0KSSaOuvetR+CDfJ2mVUQStw49tJbj2tg0nE4FQJOb9ZwpGF7WMQgUQ?=
 =?us-ascii?Q?woITU4N+ry57djScWuGDTS+8dXLTJSaRr0K59jgQslxcZY4pN8fUC4nqUM55?=
 =?us-ascii?Q?4w9pRW7oc9VFromQmsPW2gUjHJxgQr1k5AkL+Qo6ntAAQCNLZYv9yyxdTcO+?=
 =?us-ascii?Q?gttSVkvwF1pf13z0H/xhKZaegKl3oWB9/NKg3iu/lJ+E9VLUSVjresDhXvhN?=
 =?us-ascii?Q?qhMwOu+aQ9BekHYSH6GX0GKlmOJ3+NKPysHyYbdfYEwLFhD6oPEFd8PBb2tP?=
 =?us-ascii?Q?/YuPOeikw6PYvH3u7/6RDCfKqBl1X+aHbogBo8UtGrAO9trZYxzkOwvgn6Vw?=
 =?us-ascii?Q?wqlqRN8esD6A7KuqWqO1thS2+JZ3BByIJ7dPuuAv+SVai9Z6nrDc276bS0bw?=
 =?us-ascii?Q?Atab9DYct8GrQT2qYXa2pGt5G43v1SWwl8aX+M6/XpJTP7esMm13Eqv3Nmqd?=
 =?us-ascii?Q?ZCQ2DOcw9GajFa3gsRaQQdTyVVOngxSN9fXRchD2QLw7mxH4jmYqjN9EQlkO?=
 =?us-ascii?Q?ChBPcObMvwSBV0s1mbTWbdA6QkrCxgcyt+k71Vu9yLdT69s4XVbV2KwJRLcy?=
 =?us-ascii?Q?Tj3JPwQjvSHzY60DVvgYu3Nt7WxgydkLFjqvBKOxD2KvkRbf9eAQWNKzCBcT?=
 =?us-ascii?Q?v2c2MBzZxX0YfJRn/rNmzbEnpASlc+StZWmo1xCbA10UqdJruPljPihpkuTv?=
 =?us-ascii?Q?F44dN7KUnXcaNJXcesesGTNTN5t1fJglG+xCYqwpv45EMami3ez6ZXDtyzH4?=
 =?us-ascii?Q?XgRwxXEGmgpGzN3Rs/Da9dBMeRp5gchQTTwzaWAHyDFRrfYQuT92rtk8NZjO?=
 =?us-ascii?Q?488OIiTFQeplEamPvqZqGu6vgIUtOj+fEmAfsiZwlbFZ3QOBz936glH8BdNT?=
 =?us-ascii?Q?4kr9VGdRP9i78vIY77d3M+p29qaqaHhEP+9hH95GmczXRF9QISxP7GKHHvpx?=
 =?us-ascii?Q?JkiGJuHF+i20pZFzN7dbUAVSUO9AA+p+EOf+yt+0qvT4tncFPencaYiH147/?=
 =?us-ascii?Q?IBDep9i9aF/XCZPWJaZbNZsDgAsujpisOd4yxBDcRR+4uM24ff0ZAzjozspS?=
 =?us-ascii?Q?VcXJBEZ8YSjGE/PEarlHYLb7JxAT5UDfsVXzq+Z2+wOgG6HQUC1cEGrHxp5b?=
 =?us-ascii?Q?aATMX2aZVCeBcO/SlLMSGqrTlK1YLgZOivNQSqBRAMF7EieVlXmvs9kQTCRB?=
 =?us-ascii?Q?TQDQ+aCeoyQHle5FIGBUGIfNwZO3NDu8+rKRCPft7Kyn6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5d35de-5eb2-4437-d65a-08d98537bb85
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2021 00:01:06.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufE/40Q2RsT1y7U2fgOGL03yelb8Uc94v5JNf4kK3g8+yPeZ8qn5gyqGwVcSQ4Ko
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3480
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: YBhHUXRzzF9_lJNYnKgDI_RHiu_M1n0n
X-Proofpoint-GUID: YBhHUXRzzF9_lJNYnKgDI_RHiu_M1n0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-01_05,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxlogscore=912
 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010167
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 01, 2021 at 03:09:37PM -0400, Waiman Long wrote:
> Since commit d648bcc7fe65 ("mm: kmem: make memcg_kmem_enabled()
> irreversible"), the only thing memcg_free_kmem() does is to call
> memcg_offline_kmem() when the memcg is still online. However,
> memcg_offline_kmem() is only called from mem_cgroup_css_free() which
> cannot be reached if the memcg hasn't been offlined first.

Hm, is it true? What if online_css() fails?

> As this
> function now serves no purpose, we should just remove it.

It looks like we can just use memcg_offline_kmem() instead of
memcg_free_kmem().

Thanks!

> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4568363062c1..8177f253a127 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3673,13 +3673,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
>  
>  	memcg_free_cache_id(kmemcg_id);
>  }
> -
> -static void memcg_free_kmem(struct mem_cgroup *memcg)
> -{
> -	/* css_alloc() failed, offlining didn't happen */
> -	if (unlikely(memcg->kmem_state == KMEM_ONLINE))
> -		memcg_offline_kmem(memcg);
> -}
>  #else
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>  {
> @@ -3688,9 +3681,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
>  static void memcg_offline_kmem(struct mem_cgroup *memcg)
>  {
>  }
> -static void memcg_free_kmem(struct mem_cgroup *memcg)
> -{
> -}
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  static int memcg_update_kmem_max(struct mem_cgroup *memcg,
> @@ -5325,7 +5315,6 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>  	cancel_work_sync(&memcg->high_work);
>  	mem_cgroup_remove_from_trees(memcg);
>  	free_shrinker_info(memcg);
> -	memcg_free_kmem(memcg);
>  	mem_cgroup_free(memcg);
>  }
>  
> -- 
> 2.18.1
> 
