Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A8A333012
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 21:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhCIUjn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 15:39:43 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23996 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231668AbhCIUjb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Mar 2021 15:39:31 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129KY4Yg021183;
        Tue, 9 Mar 2021 12:39:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=tHuKjlTLpADUaNz75myE9AgMalB26gUPldhWPOy2lQU=;
 b=M6cgp/J8LZUTF59ukKAFPc81sTMIY99bA4uCRZcHpRwHZC5hROP9CPQtxfac0ewIx+eh
 3CR7uxGTXtBUDHRN7xbMk8zEDRT0RBStd0a6i4jivSMzdRHrmsq6hxqk2koi5fxEHrnx
 GtvJgwCPXvphR0YH/Y8MX/ItQi5V7p0CS1I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 374tc155hs-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Mar 2021 12:39:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 9 Mar 2021 12:39:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l47DQQNoCscQbqH/DLLiNUnrwiEL2qBIYfaJP197Fzj82iRzPOZ3nZZ7ake/dARHnnI71HJxYQTDR/B7DVPLk1oJss+0wluxPcSHWefsyy5xckc7a7BmuO8wDd58gqt0ab5Jbo7/RTwZHxW7KDSC/UJkfiEn/j4Cr/GGlZWhw63oE7opH8e8Ob44BehI/EVFaBynzIUxPTUtf+zHcXPIQozcuDSxC2P1Gn1Pcax9gfdauhwKscpUjLxDg9JXD+O/bMEbelpTWkwUsaIpEmI/sUc0UGeBYVK7YTIhQXwrYDbUJJaIi8eubN2l6j2FcvDylUij51aS90txtuAlePYiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHuKjlTLpADUaNz75myE9AgMalB26gUPldhWPOy2lQU=;
 b=BWgX+FhzJrsU0dEkGmhgR5wIH4RduLjW/MmHHAxOEvTMHUc8ybe2qbjmZtsD5lUWWAQRD4aaNTURZYxYocVNHzWj/ZNisQaGbHmMKP+YEFxKqFGPRFXiMTh6aeJcPaTKM4OF9HNbtT9VJsqbcULjNkJFHnR150ArnxF8a+F9ifB4MnytWHEVFnqiTt8b1OJ1+6fWZcpcKWCTTVWtalvwhFvRmSGLl+RlNVgq8CcMKUC1tOLCb4If+uB1g5PyZC7DMsSzqgv89vk9LvRRIpq0ZWYnzwD5XSJiDOIPi2s47eMCV/GxE181wE/0/N3uI4jkNvmhI8rwRV1Bn8LhaPCHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3159.namprd15.prod.outlook.com (2603:10b6:a03:101::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 9 Mar
 2021 20:39:23 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 20:39:23 +0000
Date:   Tue, 9 Mar 2021 12:39:18 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Vasily Averin <vvs@virtuozzo.com>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 1/9] memcg: accounting for allocations called with
 disabled BH
Message-ID: <YEfc9uCc8sfs7ooT@carbon.dhcp.thefacebook.com>
References: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
X-Originating-IP: [2620:10d:c090:400::5:e977]
X-ClientProxiedBy: MW4PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:303:b6::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e977) by MW4PR03CA0089.namprd03.prod.outlook.com (2603:10b6:303:b6::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 20:39:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d4477b5-0e0a-4887-d0d3-08d8e33b6c85
X-MS-TrafficTypeDiagnostic: BYAPR15MB3159:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3159309D34391BA406F513FABE929@BYAPR15MB3159.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wY+eUc61BD31xpbWsji5KKZYDaqpiy74sj+VEvGYn97pRNYFKxAY0LiOASdcWPfVfNRjTBdYOaPVCtIxXEoSfnt6e1qm4cGCEcR8L/aPOV1UoUqT0zxstEhVyc9Tiw4OFTkUMvwk9GXHJTtE0rPzJ6XyXlQp8vXLi7PHZ8bKtFKQ2UNVsHiOGNfD8feF1oLUgJ6tP7hgMs4dJ3EhkF47yQLZ057LwtuhvPtic090fCcfkvqP+tDGN9wLPM4gNTvtZZKtdYAKVwaUykjkiX0qvzSGl7d7DF9FqXR+QlCAZRETxRhBY98V3xlg9qoXgarcNk0WETL8ZBsbMXJ2gv+MOwmkw5GVvuf5VkVLVPL0BOgQhiRyFSSrhrJ2IV9JIB0qXVRe5ROp0y0IH/g0gyn4FT9+O2lhsbbOsZCJGKOJ1CUFBW7H3XDmKDbS8piiyppB1aSacB4GJp2WAmpq9557L9GPQaa/jCRaJ1LdfbHAK+QxrWa6kmPYvXJ/SwI8StSJbPmpVw5bMccKnusDeGq+Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(6916009)(316002)(478600001)(54906003)(6506007)(7696005)(52116002)(16526019)(4326008)(86362001)(9686003)(186003)(83380400001)(55016002)(6666004)(8936002)(66476007)(66556008)(8676002)(66946007)(15650500001)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?X5erBt6X2CXHJX/gMXOdyy37wLcMWbzYbIu3kaVoWkNe3HZpjaUeTyaTHCXd?=
 =?us-ascii?Q?uP2LnQe8qHaHhTGMHXuDO8+cFheO5bZV/N/gTMgXvarrtF8Kgnr8NchHVVKl?=
 =?us-ascii?Q?Gyv7Q9oMrGDmniIIreLRSUGpKPnvwbM2RQjg8uB0OSIryspH5kQ3Ypu/hj7q?=
 =?us-ascii?Q?vYXic+L/S1//R8DWlW8Jk5opru4Y22UtSMhOfl1n5wln6f+yJrSmDV8dpgMa?=
 =?us-ascii?Q?K8pLpy9pA6sFqIT7H98TGWmCbVM58D6ec5ceCIwCy3HQPwN849T50KhuakNY?=
 =?us-ascii?Q?NwvgOJ+xI6tjl2dyYejWj97RHww8zD3bRkZAy9PmPBsPypGfkacWnlBuu/5q?=
 =?us-ascii?Q?LnK+p5tnBOby3TkI30SD7jJHZuZE8aij4hp2jtGaTyesYvav0EN1fLUaDewU?=
 =?us-ascii?Q?vlnTfeL3BtAeT0rfPQS9HSIGUdRiCbKJBGwlhwCrEBR1i3tg7b3CujLk3AIE?=
 =?us-ascii?Q?M74TLHZvLEi5vL74z4cPFgMAmqTSSwNtXwpgMqLeHvX6X3kqyZhOyPxvkCvc?=
 =?us-ascii?Q?HzJPkz4ousvjj2eOBRY6Ke04MyCwYA5GrHnEtKbfXj1LWXUADaoHAzvRIJps?=
 =?us-ascii?Q?sIq9xCVitUspFLOm2nniu7PlJSpyIt6nPdRuNdrDobQNPqBd0W7J15VsNeq3?=
 =?us-ascii?Q?Rp6RZqPRpQR+Q2kEjSt1SZ5cQg3Ad+vCedxbMy3P0qQfMCwElrPVW266nL+q?=
 =?us-ascii?Q?Cp57BDs1NgfKA9mgDCsoJJOdQga8Yt27xCO+7n+WhHUEQDQ51vGakJprV62v?=
 =?us-ascii?Q?Qs2++WgPWbiZzkYpjE0+1sF7onQ5ReZ02sBQNu/XAPRXxWcMwVKEFzJpATiz?=
 =?us-ascii?Q?sDkDfKhPIDMrkBQwtNQmfPq8nu0/nN6ET58wb03T7tPfBagkmgf4+zinodBH?=
 =?us-ascii?Q?8W1N42+rArKtseNNHi2jC6hw3k+3WPNQdVRXDJF08sydwvid6+JWABuOA8oM?=
 =?us-ascii?Q?q8/imO22QhmrUC+BvZsxSsc5oVrGBt9QcKseNbx1kkyeI1nntwV5eHOVKGMG?=
 =?us-ascii?Q?j1vPTMfAftLgrzOzRvu4zgz1LTkNR4ganUzqG5ugo0jVuiq3W3JAaip9SDvK?=
 =?us-ascii?Q?3QXMob8+2mhnmHCzvoOIXR7R3XryvaFNJQbSjWUkBfroeMDKrK82ifeh5EBX?=
 =?us-ascii?Q?1Wb58+uXqNMSz4jFEJQMD4VntoEZ0hQFnPgiquCKNiezzfOQpBdV8gKVV07+?=
 =?us-ascii?Q?yQi334rpstujAyw9tacgC1gW5r6XpgiEAO9N1GQ7SexMTYarpTDHBlMxYdxr?=
 =?us-ascii?Q?dXKmpJTe3H9R6+KGxLbk5KTVDmJJW4JDMBnpKaBYuPkuwua1LZmW3YQ05zXD?=
 =?us-ascii?Q?v978uzAy3ARgtCSURVa+8dX111JwUR/U4Hhy+PHB+Q+DpA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4477b5-0e0a-4887-d0d3-08d8e33b6c85
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 20:39:23.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGpJPI/M19kou32Vs+3B+4lUDMZIg5me/hvS9itiS127XdtaFNmSa2tEUXJKcJy9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3159
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_15:2021-03-09,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=965 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 09, 2021 at 11:03:48AM +0300, Vasily Averin wrote:
> in_interrupt() check in memcg_kmem_bypass() is incorrect because
> it does not allow to account memory allocation called from task context
> with disabled BH, i.e. inside spin_lock_bh()/spin_unlock_bh() sections
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Good catch!

It looks like the bug was there for years: in_interrupt() was there since
the commit 7ae1e1d0f8ac ("memcg: kmem controller infrastructure") from 2012!
So I guess there is no point for a stable fix, but it's definitely nice to
have it fixed.

Acked-by: Roman Gushchin <guro@fb.com>

for this patch and the rest of the series.

Thank you!

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 845eec0..568f2cb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1076,7 +1076,7 @@ static __always_inline bool memcg_kmem_bypass(void)
>  		return false;
>  
>  	/* Memcg to charge can't be determined. */
> -	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> +	if (!in_task() || !current->mm || (current->flags & PF_KTHREAD))
>  		return true;
>  
>  	return false;
> -- 
> 1.8.3.1
> 
