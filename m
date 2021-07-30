Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE033DB1B8
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 05:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhG3DHT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 23:07:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47894 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230199AbhG3DHS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 23:07:18 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U33nni018413;
        Thu, 29 Jul 2021 20:06:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=S08o8wPM415psdFP8cZfMwjsANBaG2Gp9rNommJKq1M=;
 b=R/UuRm+ZhuxdPAmJez6I3xpa0scitUDnr8Y+pnRWhUlmzp68XNGk9gs6XI+zfc1nNdRF
 SmJYX5dsSMTQFv7efTQM1gux8Z6iJLN4yo1De94otRo//RYt7N11EJtO+RFetwiEfOos
 GjxCK3JQJfJYM8K7cFDOoStA1Orja9YVX0U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3a9r35cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 20:06:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 20:06:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQs4h0cIH7dvCUaKzTHShItZlqtGIWRQJA9jg95F7OkNhebnBySmvOQi1sifDtnSY/GI8asxj8CO65ZO6XRtOILpxJqS1hPDq5zZ4pfblupCX7ImwkySK+5BzBJG6uAxBnMQy1dncJdKt8sHI8Q5gSa9BBbeYdiw5CfkbynwSkzG4dtDj6VZoZvg0IaVO88Q+BNdXLwFFoLz2IQIBafZ+6f3DzxENIba+ojzOVgLp/eCAK5tjJ+9pkacN4kDQDnSyiKH+1x0hCGz28psK7PVWMT7BWl1zp+r0b0A45AqqhBL96/SHoN1Z9LddP60xQLmHxMb0PrcwAhFZwRZriHzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S08o8wPM415psdFP8cZfMwjsANBaG2Gp9rNommJKq1M=;
 b=TS1RxhK836lD9TJK49aWr9QpS/kLoUeR8MpyqBBM82c3pb9tjnJEBTUHVuY2kuDSSEbwpC2twq8l3pREU8zrG5N1QKEQAWF1uE8VhWsQ41KVJUhzIiNLV3hglHeiXOgZv5pJu2BZRuUn2miuMnfiEI74vNS0gimU4tDoYGcL8M00vdUIzgs/AxzsfGAS7aRDFNYK1AkGUvpvE2BQn+IgJrluQHPL4z2D/hSc2aMA7E/6xr/H2Ke+pjg0vDTGapbg155tX+11qFuMngftyn+RxhJkNuy/mGpuFXF2xL4D+OdiqZvepMe5158wfVfzpZlyPEQ0HY1Rs3X7hYiAP4r+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4472.namprd15.prod.outlook.com (2603:10b6:a03:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 03:06:49 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4352.034; Fri, 30 Jul 2021
 03:06:49 +0000
Date:   Thu, 29 Jul 2021 20:06:45 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <willy@infradead.org>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
Message-ID: <YQNsxVPsRSBZcfGG@carbon.lan>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210729125755.16871-3-linmiaohe@huawei.com>
X-ClientProxiedBy: CO2PR04CA0146.namprd04.prod.outlook.com (2603:10b6:104::24)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:166a) by CO2PR04CA0146.namprd04.prod.outlook.com (2603:10b6:104::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 03:06:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb52b41d-ebd6-4133-534a-08d953071295
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4472:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4472EFA5D6B3D48FB4D14D5DBEEC9@SJ0PR15MB4472.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAeQSLHDTcF4B75wvPtLLMFSFZ/uhyQQ0WWWRtodRFHdTA5ca6VNkHe/RfSWXjYQnfZS0b0HW04DTgQ1J3ZEJavE6seUEf5Rotcd2I9p8dDuclUve6QeJ/fEThuOzlYZkIKX0lBSUqgFnjfjuMEjeiGc/qSn+RsjOv6PKNJuYKvimDBHV6HEwOlRnBYpHLAAQG7npcLmBUvVmk4uMJA6iO+6c5qPY8ILb/70WqvBk7ROjALt/iMAO/4m9b2sqCIlE6eS3PS6RJ1TIocaNuW7aDiyDYEkamQEoI2uNzHvkB89VGABCXjI8CFlVFsX0XP6uiTL7u8qeeqQjJ1PFYkyN9E5yOJ59XPmWJzhIeyHEaKWPZMqlzbFsmbIZTHmmewAOsa4YlXbrg0yi2TvGs12GhQ7U+NNi0EfV1tRjxVBiH4tgvhyF6pHFsKwhT+NYU0/8bxpgtT/Bo+DVzLpcufqkw5bSeDkDC2QYiRHPuhwe2rG841rASXoFhNkU1mXX8KnxEa1dj/xlkiSWFL9A4R093nQqnnmtKkON806uIpUMfatYUmQSl3SrjPq7Wj+D4EPMsusE/KepRbIfTrrJ7AeHdaZYCrkSoMLhpOlldmJEGINB9GownWqJyFsVS7bzn7MEz3o4eHi860nx7hIbFX0PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(86362001)(6506007)(316002)(6916009)(5660300002)(6666004)(186003)(2906002)(55016002)(9686003)(478600001)(66476007)(4326008)(7696005)(52116002)(8936002)(38100700002)(83380400001)(66946007)(66556008)(7416002)(8676002)(8886007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wroxk0PpRWbS8h7ZwquPGVpywXLuI2yrD8LgiPAuX2bLLTXdzVBrWXrhw1nc?=
 =?us-ascii?Q?nmOjIT1rS+zAeT9/8VM/chdvOV2BASEhsT78Ja4uoFFj7xkgNyzJQGOcjMDK?=
 =?us-ascii?Q?f5nEjRcoNsIDl56DqQLenfvwIRIuzuzqQ2mBYJdz1Vmo5sZ/a00W7s0LypwW?=
 =?us-ascii?Q?g+r9LaxTeIGw13pZ7Yq0AWPafwn4TEDFhmYQ0OLdImpzn+8H7ih2zyb+GmQs?=
 =?us-ascii?Q?GrivPXFyozkKD73x6/m3GInFaZSpS5KbWEoo3qqZvhi+fONsg+LSFCSU5A5x?=
 =?us-ascii?Q?vKk2w1o/5L+Go7WZnu4W4Ywoplp9z78lkQeEHVE7iOzkwI51ZisTjvQoIhKs?=
 =?us-ascii?Q?48mc6IYifEV4kLGX2XpLYoZM71e8bAaMAtjV8hpMDYT+2qp24iMDMCzMIvDH?=
 =?us-ascii?Q?JCFCa+un0a1Jubb6E27E+ELCxIw5CS5lUR8lxayeUsGlJCKN+CQXeSWoHs9U?=
 =?us-ascii?Q?iIf4j1cjUxRmzsVimqIovcead3i7KZGBQeshvLHYta9wMYTqgqO6wC2LHzvF?=
 =?us-ascii?Q?J3lxmEzmm8GvgaagWt7KQ30RbgNZr1SY2HOQXWZWHRGoAdD/pPyri30O/h72?=
 =?us-ascii?Q?DpMYfr5ZQWEz2Gtl41bWwTuqiN2GCLdvavtB+KcU0nyIZHAhuaW9q6iz/njJ?=
 =?us-ascii?Q?uDmxfg0WaM2av5fPPZ39jMqGuUr7aX+exv/5j/L5ZVW2amWHO9qlwNew5H82?=
 =?us-ascii?Q?O8RuimRmcITPUnevNYugnWfdXfQxKUcE0nW5fWI6KFDsT8eXS1zKS5LW1DM7?=
 =?us-ascii?Q?qUQX5xKvwU3oiD3UjDVy2QuzTjnlu518O2fIp8E0HP43JEI/FmYZO0SpUMoX?=
 =?us-ascii?Q?hdTu2WFCxiaa2ucug/WJ81NEQ197DJz1IiYVRLtVzhKNmu2UF28q/LWpU1rH?=
 =?us-ascii?Q?E+MsE/hQvYa/7xeJLTP0cmx8HL6Ni64+F2mfGfuUwEgF+/deRMS+8Mtq3iCG?=
 =?us-ascii?Q?aqXfGuAXYC8LjcHphvhs4bOOgVHckhPCkpkKVXT+/A1Rmlokg8JrxQRNWb7I?=
 =?us-ascii?Q?ThfBEvIHDtRhlwk4p8v/Ye8CmiKncGzqcdycvhLF3BBBiqeqiXq6e2iMv9Ne?=
 =?us-ascii?Q?y4dKuEo+t9bCariSZiUgPI7G5pb3bIE4RoNHjJeI3Gpe/UJcJaQSE1Og5/Ub?=
 =?us-ascii?Q?XYcn5JG+Rs3DXrswQz2Wu4LSDNxgbvi6XG1O8zZu/C+a3RnUkCveTvzUSqDb?=
 =?us-ascii?Q?n2RIsj/hGXrzulyMEERoWkU1eWYszPh+n9UwJoILua/HumYI8KZ0Bbic4Cu8?=
 =?us-ascii?Q?xpKGGssovhOUCLaLcZx5Hpb437qTqqc53zqHv4RztXOLYNMtZawtKm0ZalXL?=
 =?us-ascii?Q?KsvCXbhzpSp/iBZx+iBknDmpY+loq2sChLinyc2In1Mf1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb52b41d-ebd6-4133-534a-08d953071295
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 03:06:49.2637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQYoTkGXvDkAzj71S333elNgqogNXhSKFQT33XPqNIGEonVfIYHT3uZOvmmDCq1N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4472
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: s6pDf6YlEjZgTbwz6T3_e9gwEg5kSSk7
X-Proofpoint-ORIG-GUID: s6pDf6YlEjZgTbwz6T3_e9gwEg5kSSk7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_20:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=916
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 29, 2021 at 08:57:52PM +0800, Miaohe Lin wrote:
> Since percpu_charge_mutex is only used inside drain_all_stock(), we can
> narrow the scope of percpu_charge_mutex by moving it here.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6580c2381a3e..a03e24e57cd9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2050,7 +2050,6 @@ struct memcg_stock_pcp {
>  #define FLUSHING_CACHED_CHARGE	0
>  };
>  static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
> -static DEFINE_MUTEX(percpu_charge_mutex);
>  
>  #ifdef CONFIG_MEMCG_KMEM
>  static void drain_obj_stock(struct obj_stock *stock);
> @@ -2209,6 +2208,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>   */
>  static void drain_all_stock(struct mem_cgroup *root_memcg)
>  {
> +	static DEFINE_MUTEX(percpu_charge_mutex);
>  	int cpu, curcpu;

It's considered a good practice to protect data instead of code paths. After
the proposed change it becomes obvious that the opposite is done here: the mutex
is used to prevent a simultaneous execution of the code of the drain_all_stock()
function.

Actually we don't need a mutex here: nobody ever sleeps on it. So I'd replace
it with a simple atomic variable or even a single bitfield. Then the change will
be better justified, IMO.

Thanks!
