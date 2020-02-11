Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189C3159225
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2020 15:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgBKOop (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Feb 2020 09:44:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23004 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727728AbgBKOop (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Feb 2020 09:44:45 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BEibMc019066;
        Tue, 11 Feb 2020 06:44:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=898GNIYJYiCvxqLwhhSO7pZniKBGW1/77sws03+Vo/o=;
 b=hEWH7kaFExfm/zUnj507655AaP9x3dZlggEInPKOfljx8ZauVJ8Y4d35MCWPmpYw+7GN
 lHhqzEHITYOLqYeWGpKqXbBcjhbx5s0nDfd+crnQJo91VjzpdC+weA6aiWS8LuULh3XH
 QCdxxo0qvk5JHdnPuDVEbvDaAI5iU7rCl1s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y1ucuwy1t-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Feb 2020 06:44:39 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 11 Feb 2020 06:44:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJKZq1TpRSk7+CDkU6E3byTczC3y2TzLHAG/uGHYro8wjnSQNvcXivjlOFhIqTE8ZMWbf6gb/Xjjph3k2N4o+zjAbOR35jOvNqfZO3KBIyjVzIwAJblVvHBCP1iy4u/GsoNxHUUVIFzmUP+cN+/Bj4nPEVp35hZpOALi8ANWymgClARDpA7eURjLbOW74LmQAKwa82l235VB5yoeV2wKToIYrdvwKCZnRnN85NbehD0tr3+NfJBPyRlRfmEKxwSdQJ2/e0PGELLRb2aSjtHmKn/k+GmIO+P1MFZGAyEwcIEUYJtALBoOgg61Or/lwgv4aiFdaEO93S+6HWktBCvp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=898GNIYJYiCvxqLwhhSO7pZniKBGW1/77sws03+Vo/o=;
 b=WS/NqLtMeITHwhBaLYn11zhCV1hMUmk4NnIOy3GLVnzTeFypFRfUuXwLap35FEaixcxWcbNEktf+PKlBnwRLLR7b91VxhJgUve9k3ICpyb80cf3TWutVAwRfT6msdsfViZlZOB07qq7FE+fLpusbT33c52/4een/C0enAYYTQq4QPjOHiP8OSW1jM3hIyWtqVmiGmHZp2mE894krR0RCFkPopAkMd626iiG43+gVOT6cYkTOueMVNooDBqF7F8ukKuO7waO5B9ShPboWrRiKGOjVYfBL5ZR1UXXZ7qQbi+AKWlU9UUvmmpCPQKS6PzvWhFxvrhhoi1VyQ94zbdoQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=898GNIYJYiCvxqLwhhSO7pZniKBGW1/77sws03+Vo/o=;
 b=PRK9wpjp32GGpnjmCOX3Xnv2J2D7h42S/QfStXYrZYmvSTlz377kqWZFVTF4ydHkaHp3apT9Zvru/qI9pk89SUhEfDk5Aa+XXB6Z5jp0Oddct1EZQkGA2YHaY5N+9CP0NgfpvrmEQkBKT36/k69S1H257CKy6wrO123WoSCLilw=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2293.namprd15.prod.outlook.com (52.135.194.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Tue, 11 Feb 2020 14:44:08 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 14:44:08 +0000
Date:   Tue, 11 Feb 2020 06:44:04 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Vasily Averin <vvs@virtuozzo.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH] memcg: lost css_put in memcg_expand_shrinker_maps()
Message-ID: <20200211144404.GB480760@tower.DHCP.thefacebook.com>
References: <c98414fb-7e1f-da0f-867a-9340ec4bd30b@virtuozzo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98414fb-7e1f-da0f-867a-9340ec4bd30b@virtuozzo.com>
X-ClientProxiedBy: MWHPR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:300:95::14) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::bfd8) by MWHPR13CA0028.namprd13.prod.outlook.com (2603:10b6:300:95::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.14 via Frontend Transport; Tue, 11 Feb 2020 14:44:07 +0000
X-Originating-IP: [2620:10d:c090:200::bfd8]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5c95efd-68f3-4d04-c342-08d7af00d9b5
X-MS-TrafficTypeDiagnostic: BYAPR15MB2293:
X-Microsoft-Antispam-PRVS: <BYAPR15MB229344813438A1463B1927B7BE180@BYAPR15MB2293.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(136003)(346002)(396003)(189003)(199004)(6916009)(52116002)(9686003)(7696005)(316002)(2906002)(478600001)(16526019)(86362001)(4744005)(186003)(4326008)(66556008)(66476007)(66946007)(6506007)(33656002)(5660300002)(6666004)(1076003)(55016002)(54906003)(81156014)(8676002)(8936002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2293;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVdRHvgG/WSo51r2htXHUwuBE045EDN9kFRbbR6uByc9zPuxdyHdVyQ8xPXaCOmngKqwMlwPVl9OVSa2Zw+cJP4Z/Vc8JmmLa1MD6R7DzZ36yuAd1gvmGtkVfRWiu6MnCknrPLO8qWXaMwSGdH+fyfqW89kdpvFiT62vJwXX17L+Tkn5e1UMoMmDonnNeVoxSWtUYn4Z68mH5wnTgRQfnDsH3qsGiZTwptfwfBo4DbSv2/ws/j3BJeZqkg6+zLcEC0N/7w/H647wqFQGSJHid84UQLiIyNUKkCbNu51xXyR7etm+RRdv3+ubIQ9/BdZwd5l452P5w4lTVN26haNdpqWf+aRSwJQlpv+U873F6nMHUlE+kPkzloW2JeOwHPda4YARXozKv06EPlj6HurGztzz/TI2Ktu9H7MmKXdTyclvvFJJYsvscd6jJLmxwBka
X-MS-Exchange-AntiSpam-MessageData: 3ojg/oXu3wxMkgX4TvYCx5IR6f5P9xP+8Ij0aMef1QnymGbmAaZJYkGiSVZ24N3Ut864mRXOZJBTr/TCtsxSvSCxtgNNK/S3veKm8XHPGhS0+dy/piQMr48c/MGEdcSMrXBHWdmND/dw/AddwblEEk49CVwgOCcRiGo1qywTAnU=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c95efd-68f3-4d04-c342-08d7af00d9b5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 14:44:08.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VHlS1HsCaLjFMf7HEQpQdWjf1g3uidq/0z1XUikFh1f+CdQ/0pnPFvHJntT3IU7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2293
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_04:2020-02-10,2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=978 mlxscore=0 suspectscore=1
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110111
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 11, 2020 at 02:20:10PM +0300, Vasily Averin wrote:
> for_each_mem_cgroup() increases css reference counter for memory cgroup
> and requires to use mem_cgroup_iter_break() if the walk is cancelled.
> 
> Cc: stable@vger.kernel.org
> Fixes commit 0a4465d34028("mm, memcg: assign memcg-aware shrinkers bitmap to memcg")
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thank you!

> ---
>  mm/memcontrol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6c83cf4..e2da615 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -409,8 +409,10 @@ int memcg_expand_shrinker_maps(int new_id)
>  		if (mem_cgroup_is_root(memcg))
>  			continue;
>  		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
> -		if (ret)
> +		if (ret) {
> +			mem_cgroup_iter_break(NULL, memcg);
>  			goto unlock;
> +		}
>  	}
>  unlock:
>  	if (!ret)
> -- 
> 1.8.3.1
> 
