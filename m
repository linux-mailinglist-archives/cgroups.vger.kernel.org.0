Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C9A3101BE
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 01:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhBEAmI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 19:42:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50412 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhBEAmE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 19:42:04 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1150Tocc037179;
        Fri, 5 Feb 2021 00:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=B0oeoIkDQic+Z/sWxuOFhU7kHtMOG+6OE8uBFA33J1E=;
 b=kssS9qudajOD/39Rs5bDcr8O6KOdr8a6ahf1EX3v4rFIyDu4yzM0H5EDWjp4OaAGV2RG
 m1bwSidb1/LT9tByU++IM4APEVd9A3i7KQ1R/htFb37j8J+fbazQc+20w+QC+w0FC8gK
 ODXTlvxua2ck7MAvswi+V8543yqQb0TFgEMjrQKyf1dVNBo0julXd4vlEwM4tlE/+cq5
 zTiLa6jXvQ1FJWdaXpQ9i4b66MjxDd+2r4pW7OwuOlqq+gVqE1ftb9YrvYtnHPOUTU8z
 d2Llb18uYRMnBgz6HNzQssEZUjfYklRL1wyDDevsNzEjZriNfrHr8G8gFKJuqijSPZqJ SA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36cvyb81bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 00:40:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1150Vcu2127836;
        Fri, 5 Feb 2021 00:40:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3030.oracle.com with ESMTP id 36dh1t7hxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 00:40:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9PurKmQOirZ053O2wTnIaE/k2AHCFkxItg7nGr7CRoIgkkj8qWa9aXdOAVTsi263Qt+DyBIxqYwRinjah4R+Z/1aWz/nyssLTHgOT3GvTIe3qf7uD/PWAW5L9anS6hhm1SZasVtweGwt6hr3D3S26iTwHr4moqyMJGJYAmy/6eJ3Vn67xKBqmPHykUTPlS/XV175hntrmkl5RwlXtsOEtKGsJi55t45nXS0CKie4l+HVJ+8fJLp/IyWCifnMzLtffEcDAtBvgamcLBwyacP3A+Qg6bhQnXw0RRVinO9yiUs9Xn+V0k8JNXje6BBTz4Pi/LjRzvIB17aHM9cICGcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0oeoIkDQic+Z/sWxuOFhU7kHtMOG+6OE8uBFA33J1E=;
 b=Yqw9Arf2n3LbsnBsF6IN64yNRKQgev+7/AnriedYDCFZapzzTKvNe6pdqE/S/KR2zjTKcdkgh5iuHqUXZ2hnjjJrwHd67WuUAAskdSahIbLhzKxm9lZt4+yy45m+iqe8/gaO1ZZNfeHMjbzIAzGowxuUO+m2t8hQprFLpSYiWSqcWhy1uWG/do+49Onv6NE/fCEmgvp1QbMzzgOCtIpgwM/eetNE4LkngdlGIliB7QbBqyT2uvokPKlEcRQVjk7903aKKt2hcPNal93V/5+R+DLxOiAd3PN+6pajsiFpUtC9wUiYRLPB88eFPFMGMDJYMSUaJBQO17ZnWgDOGC6MYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0oeoIkDQic+Z/sWxuOFhU7kHtMOG+6OE8uBFA33J1E=;
 b=jCp11bJCmsXYKsqyurD/oaun9uUQR3Vcmz1iIq16Vwwvm/GYCARhFg8P/aT6CsJoj4GtCznPxKRgK0hhTVV53Ia1iTZgsMEA9GNF1OMNQ3++5mjp2zUlyJ959378uAdIAfhQSyWgSWSn8tP2BoUiEEDn56wechEz0G7J2x/NmZw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1774.namprd10.prod.outlook.com (2603:10b6:301:9::13)
 by CO1PR10MB4499.namprd10.prod.outlook.com (2603:10b6:303:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Fri, 5 Feb
 2021 00:40:41 +0000
Received: from MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::24eb:1300:dd70:4183]) by MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::24eb:1300:dd70:4183%3]) with mapi id 15.20.3805.027; Fri, 5 Feb 2021
 00:40:41 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Alexey Klimov <aklimov@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yury.norov@gmail.com, tglx@linutronix.de,
        Joshua Baker <jobaker@redhat.com>, audralmitchel@gmail.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, rafael@kernel.org,
        tj@kernel.org, lizefan@huawei.com, qais.yousef@arm.com,
        hannes@cmpxchg.org, Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
In-Reply-To: <YBv5qDBdb/VAq0Vw@hirez.programming.kicks-ass.net>
References: <20210204010157.1823669-1-aklimov@redhat.com>
 <YBvCYhdPai+pb8u2@hirez.programming.kicks-ass.net>
 <CAFBcO+_Z1LKqPPwEKq-XGX+RnWQa+vFBVJ9D9y0MNHGUkM_4Jw@mail.gmail.com>
 <YBv5qDBdb/VAq0Vw@hirez.programming.kicks-ass.net>
Date:   Thu, 04 Feb 2021 19:39:42 -0500
Message-ID: <87eehvz6sx.fsf@oracle.com>
Content-Type: text/plain
X-Originating-IP: [98.229.125.203]
X-ClientProxiedBy: BLAPR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:208:329::17) To MWHPR10MB1774.namprd10.prod.outlook.com
 (2603:10b6:301:9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from parnassus (98.229.125.203) by BLAPR03CA0072.namprd03.prod.outlook.com (2603:10b6:208:329::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21 via Frontend Transport; Fri, 5 Feb 2021 00:40:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7ae1bc5-dbbb-43cf-bca6-08d8c96ea9f9
X-MS-TrafficTypeDiagnostic: CO1PR10MB4499:
X-Microsoft-Antispam-PRVS: <CO1PR10MB44994D6BF7F390986AB05AAFD9B29@CO1PR10MB4499.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWsz0eoehxqKuVFgZAm8HQgX0dW8C1cCA2kMlmrxTpzOxxq/Fyh/PCMxxic6Ob0PNJYbZ6tkxbJymyj3JPKVT6OLWpgbx256uKFVZ12603qylNMAcr1Zz4H9BW/p6XFo5GoV0mXiW7OvYBbLPw/WpG/XUrLKHdc3qUUfR6UWQylBxxqEYCILw89Kg//EHoFI7wzPJdne190oAWs8lafhyKR/BpQu/s1dsa3GpmjpQy0CtW8b/ksK2fqGyn8gRuOBd0GCDn0ewBWivagPZfiReWf9wWAFY4EL+fp5c281yMPLLNPNW1vGV8D1pmO0z98kWSosq31zn9sx2qgGJtKUi1NULIHSs6iwYjYOSCl9sXKwDd0OGAPcRlD5y6YhQAYaabfPhZbfVQH4FHWviIE/8lnReds6L7+tsCjU3UmZ8tMftXtAT5kuB1RpY2gUeem3YlD62tfb+2KXETS3z0qCob2pFkeQXccpBlN4UognKxQsMZCnf0GaCGhfP/UI667I9gZPjd+5O4l8E1bK2upvFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1774.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(136003)(396003)(8936002)(2906002)(5660300002)(6496006)(36756003)(6486002)(8676002)(54906003)(316002)(4326008)(186003)(86362001)(6666004)(52116002)(66556008)(2616005)(66476007)(66946007)(956004)(83380400001)(7416002)(110136005)(16526019)(53546011)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?690CfqNuyVI2l4fxaUCB+oEoIsAvnE6Xx/DBAxdM+NuD3Na+hZZd22evdaoI?=
 =?us-ascii?Q?ltj1nPfvvPQUPmKiKFH6gECKpvP1fAp4gIoIbLPdRvakg0YfXH4Wb3BG7J4h?=
 =?us-ascii?Q?t46w6X+aestQDltm6ZxZGdY0XPjplj0jr3lbCYUtJyu6jlMMVRek1CZC+MiG?=
 =?us-ascii?Q?Xpu9TtAtF6uZdtSat+7KIXSccgzUGKbvd7LvosXqXkAbtN0Wzr5ZNWZRPWCB?=
 =?us-ascii?Q?7g+Zbtm/DPUfsRJu20l65DD5L+ts64b/+R7NxbyUCDaQDvzXPXmMVpWcTB9p?=
 =?us-ascii?Q?h7Qis5M4F3O2KyCP77M9XG9FiEJ88I45yhEDfl6XZ567N2pgPqj5WeWPFlqe?=
 =?us-ascii?Q?JtzfZeTqYTuSJOw2kH3ucL9XykgvnBxIQSBc+ggJlsnbHuaizSrqnzLHkyC4?=
 =?us-ascii?Q?D7sI3vNDKzrq2+XL/jOxUyj0t0PXRgSiXaiJcqRmwMXlYebdWbW0iw6e89mV?=
 =?us-ascii?Q?uBuAqAqJKUXLsDuobblFhDMvp3lQh+8ZAxu1FczqeggqenvkgsdO+ovIuNbT?=
 =?us-ascii?Q?wuFlzRGC9Y+gQt76XS4b/tutyIWzxdi+uMatWkAnN1u/pxd2OSwqSmhvUbuN?=
 =?us-ascii?Q?IHS83a78DWh1x1YzU92lT28Mz+2fpOXyo89CZTWmHQwAfU6Kj8bQXbx21QZa?=
 =?us-ascii?Q?vIqFcDbGLH5UleWamknM9bUEYCgCgxrhhkprsO7E3yvpKQrDYqsRfsevNl1C?=
 =?us-ascii?Q?8ZJqRQGYk4ZMPo2D5BQF5V9ZHTdLNw6LvScxKHUNvwTz8z8fO5EWNbBGJdwq?=
 =?us-ascii?Q?8laNvsTWOL6cnhFONaEo8w1KBZW2f2uaykF9DRAP0d1iiOflfLH59JqdAooy?=
 =?us-ascii?Q?EnKV+0rPlEwZnDtIKpwqIL0f30kiiERMxmHCvgupKliALgE/lyT4YvJ031kY?=
 =?us-ascii?Q?bc13cbkwSYbkJme1cL1DCiL1Fna7jRJ/hffdssbYsjwgGe7AeBXFh+8j7oGi?=
 =?us-ascii?Q?RmCYpSbcZgdxDnZt9TQpLblURcDVeyMnf23hxiE4OUCCqGdDtPCLQjK9qkTx?=
 =?us-ascii?Q?8OlDys015OfReduvQJVd6gqNu1TFXA6LYReVYjJAsN49i3Vma2TGJOkP3Yvb?=
 =?us-ascii?Q?QUtswpeq/b7iaOeCKBWPRrbohnw9jpz1cuYyLxPbc9RuSa2aKktTBkQ3YGPq?=
 =?us-ascii?Q?iWWIM1+H/aSJWCpWWaLjk3goks/O+ct1Sj/86eXgF+KRWt5XQlUp3+bV3Psr?=
 =?us-ascii?Q?41hMJgKGsY6LukJmJRu4maw6RU7+lzG2tNnwnGVCUX8ZbxINgNhL+IOXFCbN?=
 =?us-ascii?Q?8rrCxENGnNLg4JKWQRftOxk2obOKpH6ZHLxqiin/a9ipSjlRfpZzZQvJU7hI?=
 =?us-ascii?Q?3wOo+1SfGPgPUcipN9vg4omI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ae1bc5-dbbb-43cf-bca6-08d8c96ea9f9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1774.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 00:40:41.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kx6vLXhkUQfGccu0q5nNAaGF78Uzx/MpzWz+CPPAR0bVRabjRMmd6hatRZ7QJ+94ZTcrLLhFXY2Z2s0KohVyaTXzkuDNxHytMDAWdgb9BPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4499
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050000
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Feb 04, 2021 at 12:50:34PM +0000, Alexey Klimov wrote:
>> On Thu, Feb 4, 2021 at 9:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> >
>> > On Thu, Feb 04, 2021 at 01:01:57AM +0000, Alexey Klimov wrote:
>> > > @@ -1281,6 +1282,11 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
>> > >       err = _cpu_up(cpu, 0, target);
>> > >  out:
>> > >       cpu_maps_update_done();
>> > > +
>> > > +     /* To avoid out of line uevent */
>> > > +     if (!err)
>> > > +             cpuset_wait_for_hotplug();
>> > > +
>> > >       return err;
>> > >  }
>> > >
>> >
>> > > @@ -2071,14 +2075,18 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
>> > >       struct device *dev = get_cpu_device(cpu);
>> > >
>> > >       dev->offline = false;
>> > > -     /* Tell user space about the state change */
>> > > -     kobject_uevent(&dev->kobj, KOBJ_ONLINE);
>> > >  }
>> > >
>> >
>> > One concequence of this is that you'll now get a bunch of notifications
>> > across things like suspend/hybernate.
>> 
>> The patch doesn't change the number of kobject_uevent()s. The
>> userspace will get the same number of uevents as before the patch (at
>> least if I can rely on my eyes).
>
> bringup_hibernate_cpu() didn't used to generate an event, it does now.
> Same for bringup_nonboot_cpus().

Both of those call cpu_up(), which only gets a cpuset_wait_for_hotplug()
in this patch.  No new events generated from that, right, it's just a
wrapper for a flush_work()?

> Also, looking again, you don't seem to be reinstating the OFFLINE event
> you took out.

It seems to be reinstated in cpuhp_smt_disable()?
