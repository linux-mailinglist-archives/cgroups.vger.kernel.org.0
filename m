Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94722CC8C1
	for <lists+cgroups@lfdr.de>; Wed,  2 Dec 2020 22:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgLBVRm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Dec 2020 16:17:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53586 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgLBVRm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Dec 2020 16:17:42 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2LEiP7025649;
        Wed, 2 Dec 2020 13:16:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oZ07i7MpPX+Ffa5uHH9P9ixLS7lxGFSDBft5r+BM73k=;
 b=FZDEd0V6JTvtoSVNjgM3vjSbKyG1pDCOIGeWldc6qkuErdyKYxvJnsDFug4/sL8r1sZk
 LYHi9SB+eGN5D8i2CVKHsrNyHLn0EbV3h3JXTU4bnyAzzm+4V9J0FXygSkEhGGP3URND
 cnsexik/ASl6UT/prTByXrZZkHtSxYTXMsY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35615fegrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Dec 2020 13:16:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 13:16:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwDYoscOSN97R8gIvgCMaFRQw/xm/i58vcv7btjLyerH1ezZiDTzrLo6iDuHpKUeZlUioRU4iJUuDjSXugpgn03NSlwAeIeLWso+tt+m3t6iHldjn4iy+smxZcN9WVhv8iJOZzrkNVMZPMCHBGJuSodcd7apLkV7E4FNtn2wBQM9btqfD+0KsphnU1GqRn71xDCS98WVVDoOtj1Vp3UxCp5sWmRf9KN8XxfcxKttdhF72AvHPsA6/P5yADyrBJIr8Pk4q00BRWiOU+VRqqz7/KRG8kEn5NYqgndpcbZir889UEOtprbzRx0w0DPgPHjgMol0EUgNi/qI3J/pS4VsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ07i7MpPX+Ffa5uHH9P9ixLS7lxGFSDBft5r+BM73k=;
 b=dqq8xFtT8FeC7whWhLNdZKzK3iPMPtNC1duorkvGnp1uzo4bPiI+/jXS0c6BShzYn0eTs/4h+vDii8J666Wy9eiVWLeZquQIA6NQf+6ZhcQ0+pjIKOC1BV7c982cQkyaEVVologq7Az+SEuShonQS3Un6FbwZzqf+Poq0w4IX7YtNBhWT5pokIKFwr0GgrmCqn6iNb2PZmL2zNADqwR4foqajjV7LDEzFSUsivugZ1CQgjc92WjXq8sGuzoBlAQTlIz1ohuL+gBw12xlSS5gZgAWMmNOO32ONKa8w6uWn3MBBHKhrK8Sxl3nwhkYQ0uh+SQIebzeWAEnU+rkkXTMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ07i7MpPX+Ffa5uHH9P9ixLS7lxGFSDBft5r+BM73k=;
 b=PlzTcFYkXSV4Z3quW5nA6WNnPyupplJwK61vivweBSDOE17WXzliqPzgJwH3GtWKAc8soByUh0LG16FdqriIXYZhUZ8FZLvxCTTD9A+AmOQRNrVk2O5LGZwk3/PB/WkEYGFCQU7PU9Pf+j5rfxMRgJxBQSVk5rj+A3oCa/pMDsA=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2342.namprd15.prod.outlook.com (2603:10b6:a02:88::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 2 Dec
 2020 21:16:51 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.019; Wed, 2 Dec 2020
 21:16:51 +0000
Date:   Wed, 2 Dec 2020 13:16:46 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memcontrol: make the slab calculation consistent
Message-ID: <20201202211646.GA1517142@carbon.lan>
References: <20201202121434.75099-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202121434.75099-1-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:beca]
X-ClientProxiedBy: MWHPR17CA0049.namprd17.prod.outlook.com
 (2603:10b6:300:93::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:beca) by MWHPR17CA0049.namprd17.prod.outlook.com (2603:10b6:300:93::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 21:16:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f42d8c08-f4d3-465a-fc19-08d897079623
X-MS-TrafficTypeDiagnostic: BYAPR15MB2342:
X-Microsoft-Antispam-PRVS: <BYAPR15MB23424A1AC35A61721D7C091BBEF30@BYAPR15MB2342.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91EnmRBIghU3pDqeNVnz8bE2HoBfWssJttoqOaN6UIitV7XlI+hL4cJV6YGHgkxnaD/GZktpeeV9sV/RU0Cq6GyS4eWPz9CXwcml7+Qmh1sij6ZkMD2JKIVSAPEPGH6XZaFoCch+osBXtNJjvtBjwRzwXWkcyxmUusMl+75mY9cFYy2ucv27j677r7bGb3sbXx6DWzqWBpcoRQJsh6SFy9F2eUM/0pBpEBitqB+X1N3CX9Z52zPQZjKzwxUf+6cTJVZCnCtD/POeBCN0hTCkTDXSmVGMtqCx2NfDu1re4CPcOZziHFIKSz7zCsSCh1pFQxWunhwKP0VpsYYxdaoDrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(366004)(396003)(136003)(9686003)(33656002)(5660300002)(66946007)(55016002)(1076003)(2906002)(6666004)(4326008)(66476007)(8886007)(6916009)(66556008)(36756003)(83380400001)(186003)(8936002)(6506007)(8676002)(16526019)(7696005)(86362001)(316002)(478600001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cBXVOd05AMU/04QeVHMMry0tNRDcQf0Ee0Ux6mci/pN+XFxwfszk9JFmg7JI?=
 =?us-ascii?Q?A11Z1dnGmEtH2YqUgHbHPF18t3tq9fMSzQtk7rpj/B/Ej8Nlkv3Xwjxhlkkl?=
 =?us-ascii?Q?BlPi7Maw/uMQB+APBppZ6b3H0IEkHxIR5XL4Osrn4MSR56zOqiaW51dlFdJz?=
 =?us-ascii?Q?8M0/3IO5wr7bntx5VB9C43BobnP/9WKJowffD/zFz5sDqazTOLq/tY3k05nG?=
 =?us-ascii?Q?XzT9MgRcXatwVI36+3nm6AoPZys5Y/NWlrgdX3nKLXfsSpOZqq2EH76wikgY?=
 =?us-ascii?Q?qqwX4JpcrNrSTMusSf7Xg/Wh2KkBltDSO1f1aI8rboTctHtjAEL+14V6D5H1?=
 =?us-ascii?Q?3gIb8GD1CbbL+WPAJ1+ubnO2mT8RHg4KnSUjVPNW/Yo2DkNUJupi3UNTjSFL?=
 =?us-ascii?Q?zwbyJuFevUvE15tcwr/Q2ncJUObobPnSl10b75YLnHk2CG2ZSvYHGVCE9Gyf?=
 =?us-ascii?Q?J4kk1fhzxpGs8eYD57bKv5InCN4L7R6WANM4PD8U/L6hPc5tZ07icaubGzbf?=
 =?us-ascii?Q?9SW1UX84UZWWdAq53Pa0NeDxPXYpEPB3488xF40oxOatE6301qGj6hhxcqV3?=
 =?us-ascii?Q?HLqfXCMMUsB5AUt6W+5ZvR4fNWR0bkUafDDrm3/aHeOSsHZ5eXnHHHzFiAi5?=
 =?us-ascii?Q?zoGQr3Q5OqnbXIhAtYcm1YshtpP6IAloZGBD/qDGe2KNWiD9Kcuo1O7FcEzU?=
 =?us-ascii?Q?tBLs1qEU981zPWzVJ8E7rDkZMdLGovw/Dzoh7pqzq5122yw8iPrnjNVHGZal?=
 =?us-ascii?Q?NCkzR+ChM2qygllVXQgOHuQgDIKJdkmUEZa0yD4aPkjUht4mW+BgFvkXBnJ6?=
 =?us-ascii?Q?Ewez83QIcax22HbntP2IUO5rJr2giEFHeN5CfxxgOzjkVi4BfrmAWwKXclVU?=
 =?us-ascii?Q?uddsxh7vev7DuMgj/xYU1NeszmTGKa/lfSdZ35XuFHX/67QACcgOV9EOFn7g?=
 =?us-ascii?Q?fU6qBT2aHIkDpDwd+0D6R/309InUiv8PZmfR1+fM0hYI8dfrAx5njo3R42Zn?=
 =?us-ascii?Q?x4830TpLNfHpFcgGUUZebdKiuA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f42d8c08-f4d3-465a-fc19-08d897079623
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 21:16:51.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOqVLVVVGdONwlYSP2mEoSCw5mt88uHnomtLY+KN5RtnKI8/xzfAsqXTmb/3kzrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2342
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_13:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=1 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012020128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 02, 2020 at 08:14:34PM +0800, Muchun Song wrote:
> Although the ratio of the slab is one, we also should read the ratio
> from the related memory_stats instead of hard-coding. And the local
> variable of size is already the value of slab_unreclaimable. So we
> do not need to read again. Simplify the code here.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Hi Muchun!

> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9922f1510956..03a9c64560f6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1545,12 +1545,22 @@ static int __init memory_stats_init(void)
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
> +		switch (memory_stats[i].idx) {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -		if (memory_stats[i].idx == NR_ANON_THPS ||
> -		    memory_stats[i].idx == NR_FILE_THPS ||
> -		    memory_stats[i].idx == NR_SHMEM_THPS)
> +		case NR_ANON_THPS:
> +		case NR_FILE_THPS:
> +		case NR_SHMEM_THPS:
>  			memory_stats[i].ratio = HPAGE_PMD_SIZE;
> +			break;
>  #endif
> +		case NR_SLAB_UNRECLAIMABLE_B:
> +			VM_BUG_ON(i < 1);
> +			VM_BUG_ON(memory_stats[i - 1].idx != NR_SLAB_RECLAIMABLE_B);

Please, convert these to BUILD_BUG_ON(), they don't have to be runtime checks.


> +			break;
> +		default:
> +			break;
> +		}
> +
>  		VM_BUG_ON(!memory_stats[i].ratio);
>  		VM_BUG_ON(memory_stats[i].idx >= MEMCG_NR_STAT);
>  	}
> @@ -1587,8 +1597,10 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
>

Can you, please, add a small comment here stating that we're printing
unreclaimable, reclaimable and the sum of both? It will simplify the reading of the code.

>  		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
> -			size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
> -			       memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
> +			int idx = i - 1;
> +
> +			size += memcg_page_state(memcg, memory_stats[idx].idx) *
> +				memory_stats[idx].ratio;
>  			seq_buf_printf(&s, "slab %llu\n", size);
>  		}
>  	}

Otherwise the patch looks good to me! Please, feel free to add
Acked-by: Roman Gushchin <guro@fb.com>
after addressing my comments.

Thanks!
> -- 
> 2.11.0
> 
