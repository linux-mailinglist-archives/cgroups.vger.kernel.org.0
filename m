Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59E93DB1D6
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 05:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhG3DN3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 23:13:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229971AbhG3DN2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 23:13:28 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U393EP024039;
        Thu, 29 Jul 2021 20:13:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=PEzx+2a/ZKj2U2ou/gU8CKrbFFrilUTmU4EkkU5zLPE=;
 b=Uy6JsIcYbpWdCVOIejUoJq6UEkXqzElWNgHMXV4Z3ksgOrNqtLPpbVn8YPMw+VPjgSBK
 dmjkjP7SuFaaNzCKz8SV9MCCWACeFI7kJsiK4WtYg42jK48qoBN7PesvwYO3Bhl/JELk
 kJRiFZSFqCIXBCR9WP20e4oAIx7YG0CasB0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3cde2euk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 20:12:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 20:12:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfeQGnD3piuWq65x7rdrsZISFJiOOagj7s/kswhUIKc1J9QhR2IUs7QoA0jnW9CHUiBV/smMwnOWb3N6EqVCxYbJ5n/pZQiB0w0+iTwH9PR34mppQ39StSUdSJuVaDVD83XMshXoDUI505MSd9vNAznf4URvAejvP6cmWGsU9D5TPBMs/pfBtbhA3He34dMi9I3aHcDfs6hKyZN6ED3FF1/KmiE6/1x76n1OTa+26l3vFUWxnixznLqZEY65gH+HWcLr2jX/EUl8RRfjpYiUVuxE850sIGoAXFcNSJeXydVZpLaqHtrM3Wd28GYfyt1EaKDg9c9CLRz1uIAuW5lnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEzx+2a/ZKj2U2ou/gU8CKrbFFrilUTmU4EkkU5zLPE=;
 b=WKq3pKrDovlf+G8vsfEgkIW5hYOVi3E4mdKFnFOqKI1WruDpanXKgAAxzUew93D5nCkDrxRLW+QwXEDU/sa4Tn3R42RiWcDKks/DA/Zkd2FeRyTnSgx/BdZzrsTVkO74inPFFXhsmelvuXOzbMV7p9KiQc7gz8gmGfuLu4D5di16DrZEN9s3OFQKTGLQ+COowiwvzKwEQ1nGCTL+/hVbntBZz4JO16FNuxeVjNNVkpSCrNw7KQoH5ThUeguniB3/7v14qzea0Y/HY1zluxz06HddREWheaH6saG3R3zWcKYFQshhZ447Pnu0mwEwtE2WIvXvKbGvI4tufdnpkPszyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4472.namprd15.prod.outlook.com (2603:10b6:a03:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 03:12:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4352.034; Fri, 30 Jul 2021
 03:12:48 +0000
Date:   Thu, 29 Jul 2021 20:12:43 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <willy@infradead.org>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH 4/5] mm, memcg: avoid possible NULL pointer dereferencing
 in mem_cgroup_init()
Message-ID: <YQNuK+jN7pZLJTvT@carbon.lan>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210729125755.16871-5-linmiaohe@huawei.com>
X-ClientProxiedBy: MWHPR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:300:95::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:6b55) by MWHPR13CA0029.namprd13.prod.outlook.com (2603:10b6:300:95::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend Transport; Fri, 30 Jul 2021 03:12:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffb8befb-dd05-4529-1cdb-08d95307e875
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4472:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4472850B7704B31183DD2C28BEEC9@SJ0PR15MB4472.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55gaudD+9OfNAbnVh2oSwy0sgPrXBl84zTaL/pK2+llHFdjnPnSCKgWwfeTLFf/4xfN2fyyDxD9zKuM3Em6eS4S3K7BdLdL553Ns95EJcRcRHCoSNMVO/JnTLDQBYddyu64uga06up8raOAYp3MYc1TLHagCH0jjeVDNd3jiLiRYjvtHn53h83kAcDDnvkS8s7usyGzF8SRVfDwXMZIuvchrwDzuqbS328f+mHbGlxwkek5YKC/VKz8rid6H4WaewJiwEwggApOtym0olkwrgyJ2mzklURV2fIjU8CsKLWbVuO+0EL8tWTfXVPcZh1gWKdzY1oGm2sUTu/ePOfCuYfOVeZ4cmLpR/zE/hxjmBOdMYdAnqzTGT6xIzBNR4YhbGJxqV6hFLiFxdII84syiE/8Vne+g+hZUSFjMkwiBM+K8JVboTO+H2XNu13ZTYMFyfwdGkBxkSTby3VF8sNbIDnOgVEmx3pNTp0r8Eb0sT8KGjpsyAWv5j4UEbXE3GJIv2Ky8xR+5aPlvnBOcYYH18xwJLOWiI1fIqcfVzCD1AUgSNiW/+1wSJfAh2mW1gFxe0HRBPpB4a6mW6FAF57m7c8i0O2eCHGGwjE+hbd67jhvesNX5nuCNVgpFRcOOZWJKtBcguO9xbSKux/QGl+yj8BmVVYOP3hnL717KTbpnDjdbAZtsML+YfobSbxUBa6AM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(7696005)(52116002)(4326008)(478600001)(66476007)(8676002)(36756003)(8886007)(66946007)(66556008)(83380400001)(8936002)(38100700002)(7416002)(86362001)(6506007)(6916009)(316002)(9686003)(6666004)(5660300002)(55016002)(2906002)(186003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6lM0JPhY1wfH/KZrwLeV2gfUpcUGwSRf/fv8HXjAdJB4O4CFyeKhMrccu962?=
 =?us-ascii?Q?pYJAfU5bMAo+mUpknwAd5HCne1Od5o6gV1E48V3QV6CKO6GWU04Dck2Wmwhn?=
 =?us-ascii?Q?hvyHxAv8kGHr6R+hmkl/4xFHqi9Fpbowf70IKJ9ZggNmrNTMPpT/JOiUzDeo?=
 =?us-ascii?Q?WCr9pBs2Z9Iq8995LN9S9Nj3EbUkK3R6DYeoiHmZx54TkbnxPwyc6NClMee9?=
 =?us-ascii?Q?n+NYAn3m69NOeNogO+ggZMPte8HIdE9CITJIVKeiNhUZOMegVCwG52pY9vtY?=
 =?us-ascii?Q?GnAGsu2L9SMS3jNHxPHVB2MdKIDcG+QdQvmMgbvxM+bngejscew+43ZaE/HJ?=
 =?us-ascii?Q?C/eMe0WbrVe8Th5zZl2YA+R7H/7rzKHqIY2daeVY0h3Xm0hhqZgWhJBWDBv1?=
 =?us-ascii?Q?e2wJjXT7xQBWGkupSQYC1ulozlbilU+IwI8vfyqEDC4V6jNqLZPO4fqfjc19?=
 =?us-ascii?Q?LurFrjZGAaCYTzEyfy0DV7m8acbL08pX5k2Lyzf7GpP8EQ8x4Fyvu+++KlY7?=
 =?us-ascii?Q?YEeLYJ9Y9Q1qcg97NCa+f1tVG6uSUAnvYfhP7nMHyG8TpWvPkhzc7dYWMWve?=
 =?us-ascii?Q?RpSmw4M6DadarF/U5M379emq8iuUMvllvsV75mPlK8W3TuQvIuEPRuppy3QN?=
 =?us-ascii?Q?aDVRhk59KGxhvWkwh+wHGJUv87gMXgxG59tB03v5XPc0S0GyA7Ed2hKVN94V?=
 =?us-ascii?Q?uW+v8HFKfgSROoJXUD7hlRtT/3tfWm0mINvazj3WA1gzE2hkYmDo3VDyERIl?=
 =?us-ascii?Q?JdirwE7AR2Oz7HHEV8C5w+KkRazOVFWkFd7XlXzA3094jeuwA22evmQrfd79?=
 =?us-ascii?Q?mloD/2c5JD1AATDLWR3P3Tey7/15yZ9hpaWYBkVbdgjxuR/qEE6Qz02deiDn?=
 =?us-ascii?Q?2DHEnp67jZEduwfZu9xfUiWaJrR+uLSXNaz6hI7ovW0V8ytLBuMaTXHhJoj/?=
 =?us-ascii?Q?ml0KSrj4JUBwmLh7rHooRzRsM4dRI+o6x5NtdZwYULk9f5gDdYn4rBOiN/Wo?=
 =?us-ascii?Q?IMrIj+iOIpoU7l8tfQEW2hNd1JcuXJL7ZRVw87Ge+o4wBy9f/KG5+mRLohrv?=
 =?us-ascii?Q?mWkOh6gB56nFpk6fYxt6wTpIjkwLbuM7WP0BrUAqigzyx9BinGaRWKX6vDO4?=
 =?us-ascii?Q?aqWxZV/lnyEElJCAny9Lk3sxdDRUNWpMRHwP0BmhGBOoqu9dKr8H3lAkwLYl?=
 =?us-ascii?Q?6wVskNzlKGhtBLANmyLLZi+Rg1hkmTDIdAH0dmKE9OfjQtUb54BP8f9lnXuV?=
 =?us-ascii?Q?0DynzXICETtG2JWMUsnAa5GujO8fKCzfipn0h5fjYs3mh1xkJpwxQpJgOSM6?=
 =?us-ascii?Q?Xa3Pg63PMuthE37oOs7lotWPAUsbbDqs/bnkDEcwP0hBww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb8befb-dd05-4529-1cdb-08d95307e875
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 03:12:48.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwUcYwW4YsE5fxdqREXAxp/KD4uDRQR4Ob3CmUFbFQwj24xtv3ag/9rhP+FoPb3U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4472
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: HurTpnurt5Nuh2AI6Im2ISI_OetWjlMO
X-Proofpoint-GUID: HurTpnurt5Nuh2AI6Im2ISI_OetWjlMO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_20:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=989 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 29, 2021 at 08:57:54PM +0800, Miaohe Lin wrote:
> rtpn might be NULL in very rare case. We have better to check it before
> dereferencing it. Since memcg can live with NULL rb_tree_per_node in
> soft_limit_tree, warn this case and continue.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memcontrol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5b4592d1e0f2..70a32174e7c4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7109,6 +7109,8 @@ static int __init mem_cgroup_init(void)
>  		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
>  				    node_online(node) ? node : NUMA_NO_NODE);
>  
> +		if (WARN_ON_ONCE(!rtpn))
> +			continue;

I also really doubt that it makes any sense to continue in this case.
If this allocations fails (at the very beginning of the system's life, it's an __init function),
something is terribly wrong and panic'ing on a NULL-pointer dereference sounds like
a perfect choice.

Is this a real world problem? Do I miss something?
