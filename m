Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB87431024D
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 02:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhBEBgx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 20:36:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41748 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbhBEBgv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 20:36:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1151ZfUQ092812;
        Fri, 5 Feb 2021 01:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=9mUzFjaVs74qLb6Q14lutmjVoiosGF/lazrQY9m+wPc=;
 b=mAicFptooX7xaprci6Ni+42tLGgnB2YY14g0ePdwRTQpQZNqBFbiQ0j4V3OqtoCn5evr
 gy4kW7sZrtGWVkO9zGW3MPfIuUbNw9ankbH3CXQMG3LFWgThVHrEFPsWsGfZzY+fUVOw
 LSZbk3z4j1czSwLIiREKi9sfkTza4jJQ3arliQ0/4xBg2vcFdtm9iNM2VmY1Cp2gw+h2
 vFE1qLOpME/Vpn+YU5KfacOT3FBHcXz0XqiOBi6Izv68HhJDaajf0lwtfmOqnX2RDyjh
 whF0/22uQIlYIefDIRxqzns+ojZdGqoxjeK9dmzPVz3dgVvrlzzP7djdVRH8H1/IIzUK Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36cydm7wua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 01:35:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1151ZceG127175;
        Fri, 5 Feb 2021 01:35:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 36dh1t94hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 01:35:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH6P7cRW/2Y/4vtCmhBV6dBpR+sZz9Ru66+P0/yLFw9afSfSAuwZTq2zZ6k7jX3WtVamQhOYyqvVcUu2rhdCcvUjZo7R2X9V5XrmDBElKxVKmdfvKOOU2BLO8103B8vtqyiiVTWREenPKM2gvkoaTO1P9iG7eWN0yPavtyX9sHG4DxcBAdQjTxLi/rfKtIPgWdd6iZmmwkfekKPeXyz3ZvC46XTSZ2+KgB8rHt7OLanp2Ky36Dwo6gZaHZUNpvnB8XJWlpHpq6u8Jt2nMIT6cgUftJrjRvqjquRpaVjBMAjhKLedl3p89gYF1dKiW8aSYmHFDHt+KWSzWcn/zgKQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mUzFjaVs74qLb6Q14lutmjVoiosGF/lazrQY9m+wPc=;
 b=b9qfQPo5BfnweEPsl9UXIWeAzfNMtL03NFdBZOxOqErbClr75R7Cz8zx6dgHJXWz3KBxdZKHIOdYAkjfedvXjdixv1aS8Luq/ljMnAMvXnF4Y0enJhC9vp0zusNIOM96BIJZFha/Eg7QD5o2Xfm0m4XqPIe4HpNo6ohvB6dIaMAJYG3rsmir4/WBYRYDmDz4qoEf/FCNYk/vkKYtjYwlWPu0NT6oZq0fd1+p6oT7MewH1bKA5XeW1CFzXWb6FVkUVveN63W2zbW/hMOf/smIuCWvq2ZOwJQNwvtsqtP6jHV9O4hOSBNPdLa3TaFdRSjTZBcvJirioOv6N21Cw4qFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mUzFjaVs74qLb6Q14lutmjVoiosGF/lazrQY9m+wPc=;
 b=tOnD3hvCR8JpbPq1XO5OQ+8tsoUHc9lJKiK6qzaMJT7xdTZrO/5TsDnMYioAboVjk1Lna+8e6ssr/nKKVn+pnfrPIkLSAU4s95PKm0qirDKlGO49Yc0uyG+Ad8yGhAZk2ZY8stYy1yz44w+SFNuU2tv68x425/Z7HMbor7Dbu2Q=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1774.namprd10.prod.outlook.com (2603:10b6:301:9::13)
 by CO1PR10MB4513.namprd10.prod.outlook.com (2603:10b6:303:93::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Fri, 5 Feb
 2021 01:35:38 +0000
Received: from MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::24eb:1300:dd70:4183]) by MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::24eb:1300:dd70:4183%3]) with mapi id 15.20.3805.027; Fri, 5 Feb 2021
 01:35:38 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alexey Klimov <aklimov@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com, tglx@linutronix.de,
        jobaker@redhat.com, audralmitchel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, tj@kernel.org,
        lizefan@huawei.com, qais.yousef@arm.com, hannes@cmpxchg.org,
        klimov.linux@gmail.com
Subject: Re: [PATCH] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
In-Reply-To: <20210204010157.1823669-1-aklimov@redhat.com>
References: <20210204010157.1823669-1-aklimov@redhat.com>
Date:   Thu, 04 Feb 2021 20:35:34 -0500
Message-ID: <87blczz47t.fsf@oracle.com>
Content-Type: text/plain
X-Originating-IP: [98.229.125.203]
X-ClientProxiedBy: BLAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:208:32d::8) To MWHPR10MB1774.namprd10.prod.outlook.com
 (2603:10b6:301:9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from parnassus (98.229.125.203) by BLAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:208:32d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 01:35:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e55bec54-80e0-4fe9-b7ea-08d8c9765763
X-MS-TrafficTypeDiagnostic: CO1PR10MB4513:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4513DA39241A56686CFBB2D3D9B29@CO1PR10MB4513.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VTFYfSxeTil+DzP9UeLmVD013+f04cy/edEoLy4/WC3TicNek2bhGGV0532E3oMclg2KUs8uxDlp95VHsSKCuKEpfo4Y0m2IdM3/Z8EFzTlVNZAemgXQQ54SkT0fJmG/f5eGYzdqoFT+GEqWLfJno67iCQrOVEI2PMyF6eDon8vBOI9lYooqsD5sVgJ+CeeFpQ4e+m/5hI07EEVezcdWbM1pQn18A0W87KELJapvIrWiaRO4wOTEaCNrkOtpuD2ZcH+LhQDEHUesZrLB3hjiDb714sYI4qeuZzygnFrp/TwQ+mtkWmaKTe1QBiVH4i5Fd0lk2Ly/f3VwWzD9Hn0YTlOk5JSAnP3NJ2drweB1Y7rvlSyC/y7DTybmwC0IGEpcY+2MAjFBLqM1HGk0Z40MrGonuIrWYuyv8c49atglwTv/KMtya3xIOqmamNrnLbm8L2xhjJ0mhBK5beYlhLYnqKCxYm/fD/qesYSmEuCR+rPDNwwk2Tiny8f/E+fsmeYHasF1Xq5xNKTOkQ6wPSUSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1774.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(396003)(39860400002)(6496006)(83380400001)(66556008)(478600001)(4326008)(66946007)(86362001)(26005)(66476007)(5660300002)(186003)(6486002)(16526019)(2906002)(7416002)(36756003)(956004)(8936002)(8676002)(2616005)(316002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7LVzSE240GSkAAurK3uUmWaZFNz5v8aWYcwiqSzAMgVHu6Aut0ATu8YXc4jy?=
 =?us-ascii?Q?jQ0zhiNEz3NZNFtT1f+33ktv/EFX4O0cJmHoVyuNgt6JBSx6VLz7kUe4z40p?=
 =?us-ascii?Q?dtxJ7H3hYS2gWRe7rjRveyhM+e13GrjdQJex9BtazCOkj0JGgozYUSSx0JZ6?=
 =?us-ascii?Q?DVc6Rh2J7F8uGepb9nx+gUo5K3TWV0VdiIiMkJh6Pv9MxqW78PWKpBtpHdyY?=
 =?us-ascii?Q?VOAP6UitdsOWaFk5YG7XLskgabmX/JCSi/EPkGRq2V1763v7sEhYksbFDAMm?=
 =?us-ascii?Q?nX12XEGH7owmGpskQhiCCiFalQ+Zv87+YmBaPTijaSecPYlcR0czgDbzAyBh?=
 =?us-ascii?Q?IEoIGWYxzk9e0iQ2iUGanCmMO1GBsuE8hxs50oV5YT8Z4f2UbN0wDHWydp0R?=
 =?us-ascii?Q?X/Y11Y+qF3rivj3fBtLi2T4asLyEcULvV2mUZXBpRA11+BhNQkXmafaUYw90?=
 =?us-ascii?Q?ZwXJYJjNJUcMz4L1wXzwOs7Yj5qhJQreR4mZBq0xUkP4nXN0gmr8bgLgNi6b?=
 =?us-ascii?Q?56o4VX0tZ8Ae/t4LoCDFg/d/sSIbbtTlKKwRh25FnCc+0J8mPkMzWbi16D0Q?=
 =?us-ascii?Q?r4Pgqu5nJScE5II8ZgCN8qa6E4/xvSaNvooMEWCVGMtvGXdrg71qTPqubXYn?=
 =?us-ascii?Q?tdj1hERbYi6F7T2cu3hXWA9ua2qj58D7mXEEXTxEzFD6oGuuj9SNgpu/Oqqq?=
 =?us-ascii?Q?6iJ2v1Q1/A2JzoFibgBPabdcekGU2+LSzUU+cchIqRyhEgAi/lOa81Qyz7dO?=
 =?us-ascii?Q?ze95dQ+Txqk74iE8Dpi9nnqklLKxLhgKCmwqCUtBGsTKzXeZMt2N6IMI/hkU?=
 =?us-ascii?Q?dWz/g/vi61xeCqBcqwpGlw/FIBjYpkEIP6gfGhZ4aVy/FLfVgMbUltkrO/Iu?=
 =?us-ascii?Q?AWLB0cSaU0bIwFRWzgPnDLoz1iy1mxloIob6n3B/L767yFfE02N4f/yVr2Ks?=
 =?us-ascii?Q?z03EZ42moKt3ArcxS9WGOf8XXWoWQOlHYR79cg84xiO6RJ+6dpfQOE4lOL3n?=
 =?us-ascii?Q?GoduCsOLDmlhkCyr747Qop7teYPIgB5DI+FUEG8Tw0FT4RSw8g9o2mJ7YyZR?=
 =?us-ascii?Q?1KPlEWprgLv7SMqkSqNF7D6SnBRJKWVNJZJv9FBnZ1laWhdjiuhep5I0+1gL?=
 =?us-ascii?Q?burerJc85/TZdPIJZPKu5rwrNEBNdb/0EyZMXORRV8/aTqu3P+C9cb9E1o+i?=
 =?us-ascii?Q?uWXaEHfQEhBMCrmqRPX2hVahFWyc1Ob87QLyGt+mYPNMBCu0b4gT4BG7Wsyc?=
 =?us-ascii?Q?ZlXaox5NXKtFz2RCwVzihVQRsW/ZTt277YdX7BhnWWoD6Plro50HBSf1PotO?=
 =?us-ascii?Q?G1XQeHX9MoHjOdoseWYWGXjY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55bec54-80e0-4fe9-b7ea-08d8c9765763
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1774.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 01:35:38.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bOV0lcPo4L199cDs7UW66JY7a5hBnRo/GqNN3apXlonw5O7BXIt/vp5gaUl05Vk7p9JbdPxlQo4qsY/h8232ruKri1BjFz7cQUZsF9CfCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050007
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050007
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Alexey Klimov <aklimov@redhat.com> writes:

> When a CPU offlined and onlined via device_offline() and device_online()
> the userspace gets uevent notification. If, after receiving "online" uevent,
> userspace executes sched_setaffinity() on some task trying to move it
> to a recently onlined CPU, then it often fails with -EINVAL. Userspace needs
> to wait around 5..30 ms before sched_setaffinity() will succeed for the recently
> onlined CPU after receiving uevent.
>
> If in_mask argument for sched_setaffinity() has only recently onlined CPU,
> it often fails with such flow:
>
>   sched_setaffinity()
>     cpuset_cpus_allowed()
>       guarantee_online_cpus()   <-- cs->effective_cpus mask does not
>                                         contain recently onlined cpu
>     cpumask_and()               <-- final new_mask is empty
>     __set_cpus_allowed_ptr()
>       cpumask_any_and_distribute() <-- returns dest_cpu equal to nr_cpu_ids
>       returns -EINVAL
>
> Cpusets used in guarantee_online_cpus() are updated using workqueue from
> cpuset_update_active_cpus() which in its turn is called from cpu hotplug callback
> sched_cpu_activate() hence it may not be observable by sched_setaffinity() if
> it is called immediately after uevent.
> Out of line uevent can be avoided if we will ensure that cpuset_hotplug_work
> has run to completion using cpuset_wait_for_hotplug() after onlining the
> cpu in cpu_up() and in cpuhp_smt_enable().

Nice writeup.  I just have some nits, patch looks ok otherwise.

> @@ -1281,6 +1282,11 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
>  	err = _cpu_up(cpu, 0, target);
>  out:
>  	cpu_maps_update_done();
> +
> +	/* To avoid out of line uevent */

Not sure this will make sense out of context.  Maybe,

        /*
         * Wait for cpuset updates to cpumasks to finish.  Later on this path
         * may generate uevents whose consumers rely on the updates.
         */

> @@ -2062,8 +2068,6 @@ static void cpuhp_offline_cpu_device(unsigned int cpu)
>  	struct device *dev = get_cpu_device(cpu);
>  
>  	dev->offline = true;
>  }
>  
> @@ -2071,14 +2075,18 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
>  	struct device *dev = get_cpu_device(cpu);
>  
>  	dev->offline = false;
>  }

You could get rid of these functions and just put the few remaining bits
in the callers.  They each have only one.
