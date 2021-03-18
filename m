Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1210B340E3A
	for <lists+cgroups@lfdr.de>; Thu, 18 Mar 2021 20:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhCRT2z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Mar 2021 15:28:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46470 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhCRT2h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Mar 2021 15:28:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IJJvYo045397;
        Thu, 18 Mar 2021 19:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=uOQfgSt7DnQHzU9CkYe3OcxfQ5H3Z/rsIPYYFJiCANs=;
 b=QJH9dy+su5JGPKj1DYwDoSiq3eVLBtHQ/Q1NqpXZTK/YXViWnsNsSnZ+4l1k2CvUFrzX
 GOhecQRvRfk3rZZWPZvKRu3Tby3c4Sf8stkcR6ueU3zPqsuznNaHX7IgwcWvK0R8I3oS
 rWY9mF8C4Uwi6DIeH/V1d/WWCWb8vWxM7yq0LidQINkzdnAfZb8chj11vBhcw6D5CEhB
 ALwJ/tvdhdEY3ILNNviss+a39QtEp+jhLRz4GiFDGnQ8JhBxwLRtzkNN4tXu+SpzsUuq
 uXkKnCwWuG31WQbCMhbmdScfUkGXVQnJMCLGMVaRxcUEE0L9tG3YfCc0RYD77ElkXPf3 /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 378jwbrsx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 19:28:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IJQ7QV008640;
        Thu, 18 Mar 2021 19:28:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3030.oracle.com with ESMTP id 3797b3bqtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 19:28:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8AV6NrqMunvleqIlLqTAYhxLFUfyf6IcLU3jEvWqThBZEH7Uu3iPR7hBkt0KWOqUMiPLWotc1zIxWceoWvOkkrJR4IduXyZxXbZtZ46hJkm+A25TN8012rSyjftqzr8GbycxdpQQVhaHizJ8iTvW0WuH5MLSQohIX+pZC/DYFbUtOOcyI5mUD+l9n368GtmpgOwq/ni94G2UKLPGdGBpVct1Pd23yaNc6baAhn1vsjjggYbWIUEc6MkZc4l3LhBV0hQIy3bO+YK8IjgqjoRHFkRCJAWfJj5UpzWXnSJsGElOfIBbD6383YGPdsrcqOat0WkXZ5J/SDw8cNsD0/SSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOQfgSt7DnQHzU9CkYe3OcxfQ5H3Z/rsIPYYFJiCANs=;
 b=DOJcrD4sZ9AizzZkk+s4ocuz67z9gfdzHGsJUHlRwjFTDIkvNa5C79ZVgLzyuoIlyC4jKu+DpHPKIuNzlPX9cy0dIQj6Kv+F3Fi0BqTq467hnZZFnf1rGbDDlRSBk5RVqHrQQa1kcV/KXCvcF2B8BMvIws/cSKceydopj/WWw4Kl8sYNCLZJfepR2rpoUOSBlskcot0O0Ey2M1/V1cm09mVhU5G5oz3FAMWxQfIyoD3qoMzJp6X+yfw/Hbm0V4Bf+cGNE5k/Q11UPiLUObaQwxqBj4MG/csWhsvBJUJAMlp1yLaCFztRSqSKe5Ay5b0x3L31TgpdcH2+bNiVClkhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOQfgSt7DnQHzU9CkYe3OcxfQ5H3Z/rsIPYYFJiCANs=;
 b=JstB/y8hptP2LlfLQBpvfgrlbZ483A2DKvjGkP/egrrAV7A0keULTYrNCsM9jda338ytDlplXK+LNpPJVHzGgPScAb9635N7PWzz2JCjqLJd5FzSGi2K7e2dpahMBziShrvWa24fBofOB4IvHDHKhOgs5I0iz6U6JUmXQAyzAnE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1774.namprd10.prod.outlook.com (2603:10b6:301:9::13)
 by CO1PR10MB4738.namprd10.prod.outlook.com (2603:10b6:303:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 19:28:14 +0000
Received: from MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::24eb:1300:dd70:4183]) by MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::24eb:1300:dd70:4183%3]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 19:28:14 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alexey Klimov <aklimov@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com, tglx@linutronix.de,
        jobaker@redhat.com, audralmitchel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, tj@kernel.org,
        qais.yousef@arm.com, hannes@cmpxchg.org, klimov.linux@gmail.com
Subject: Re: [PATCH v3] cpu/hotplug: wait for cpuset_hotplug_work to finish
 on cpu onlining
In-Reply-To: <20210317003616.2817418-1-aklimov@redhat.com>
References: <20210317003616.2817418-1-aklimov@redhat.com>
Date:   Thu, 18 Mar 2021 15:28:09 -0400
Message-ID: <877dm4uura.fsf@oracle.com>
Content-Type: text/plain
X-Originating-IP: [98.229.125.203]
X-ClientProxiedBy: BL0PR02CA0102.namprd02.prod.outlook.com
 (2603:10b6:208:51::43) To MWHPR10MB1774.namprd10.prod.outlook.com
 (2603:10b6:301:9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from parnassus (98.229.125.203) by BL0PR02CA0102.namprd02.prod.outlook.com (2603:10b6:208:51::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 19:28:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff52179e-f490-48d5-a8fa-08d8ea43f952
X-MS-TrafficTypeDiagnostic: CO1PR10MB4738:
X-Microsoft-Antispam-PRVS: <CO1PR10MB473899C1F70D4CD5151D218FD9699@CO1PR10MB4738.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIHrPcH6ZTXHHU+NuzHH23zZpR8UdIthu7WnEwunfUDhi20l0qcduo2Gk3e7lhdzDRec4qv5sOLhJEDxuzIROiWLKKBXWB0/FKPKBw7ocYMwfqJI/avHOJgKMmM0Gx4HIAVhZNBNi4vjT+W5vhW8LvZ4PYCLR1IwDG1jrSq7fGz5hxeTbyl9T3gOuWFKbA5Xgm6LS7jsy4OvSb6O7qHMJZf6wQLwAPzg1chby2lqdObPIeEtHDpQ3MwK1zUoo64TqvZ7MH7pdYtUCj89tPOHEjWZwZryxQOgqN9hZ8NtwjfWYeWLd983mQrqyNCViFsEgy03W4VOBAL/1LCHiYy74lKYni1Fe0fZ2Lfrgjii13Sumj860duJs2W8xi1p6DDwLISarKlomb4vzDPYFhiCpPys8yxrnBW62cXjygDLA5bcLKWfsjO6+OpI7tROog89VeP5ZYFYarPzkLEMm1gTZTl9ctM1zS07UoMYJASBDeVNJFq9+0gVTV1lPSLLTmutjBjavmuIufFKE+WhCtiNzl/5Kc2j+jXZiIWt+ubhxMvbSIvltQ9p5wofV3Cp7PewnZk+qY4z7fdwMAxDd8xcWa7nyPahearwQ5BExNUl8/ue/VJVYTR4s1INTUwNwMN9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1774.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(39860400002)(136003)(86362001)(956004)(36756003)(8936002)(38100700001)(2906002)(4326008)(16526019)(2616005)(316002)(66946007)(6496006)(83380400001)(66556008)(5660300002)(52116002)(7416002)(8676002)(6486002)(26005)(186003)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Qt7XhfhcA2m9QIH1cb4+rK0Y88kr1QmzMgDNMjXPzhnFtFAzp02QucPwhKI/?=
 =?us-ascii?Q?GyFrz9dIqEt9HJjchwHD7hQe2bmk0wO8lm1eM5jpA2dYMVy+/hUdltjZO1Ej?=
 =?us-ascii?Q?IOPqlP5H0M9MFWG0kDlBoAxItSw2K8SH2m9r6w0A8De07AHTctTYpY9DSpaV?=
 =?us-ascii?Q?pnpTpCYHkB8fr5OeS1kWePpVeyfqd3v1N4fXwX2PMloQ1H9oBuUG9CQLsMMr?=
 =?us-ascii?Q?eSLS6QJesAmu/b/ZC6Bk802dHnQJACaqxPMufrCChnTvNaJjNz5+6PINZ+qv?=
 =?us-ascii?Q?hisidZGuZd4s0DhkFNdluMIpK7FwyLOWKtc1ln95Fkdqzn/37trvNcKghVTM?=
 =?us-ascii?Q?cBUbu15bj3fuiH9lhwuoB21r4sua7hY/O+DTABLZd19n44FQzzsllN3wpyMM?=
 =?us-ascii?Q?xVMZwT0vtWgcWXHim57OCs+2Dlot3F07Dzp+u9ZDBhvmlYmobYLUcRTbl7ua?=
 =?us-ascii?Q?0KuVbeeJ6t/BtH94yz5pVkPDgQTiDiClc+T4A6ePrCX3HwhpOP5Sz0MO/B1X?=
 =?us-ascii?Q?XQwcsq/uKrl6HTPWLURCygrDSLiA49ObfleGEQw8GJsdWaznGOpb4EGSxG4l?=
 =?us-ascii?Q?exBerQlr653bYf+kzEuQgSiU43HmjfvpsfhLuAgax03F06xGjtdxbc0RnFsn?=
 =?us-ascii?Q?SHQuEZIP3Pey5AszbqOfb6Sm8fVCPmK78iCgiEM6xxgo8EbW3pX0JKewb70K?=
 =?us-ascii?Q?GK4zOKv2XREFZysM7NG1RWZCuV+bRsO+gtpxNsbslMO0/iaN3C3TEA44OuLp?=
 =?us-ascii?Q?elMcdWFJo3HhvqoZi6DaW3nLaVp3fpM9Cj5Fi1pQSrsavnklXD5tGRpdq1B9?=
 =?us-ascii?Q?gDWLs3Drl81NicSjRMGFdZvshfe3RIOxhxHmyNJekaEVlTybFxAFs8UA5qkY?=
 =?us-ascii?Q?klbVuIlHZI2+B9iw3Vq8/Geb9gBrxzIWEkr32omzUA8Vt4WTtMurDrwOPdQT?=
 =?us-ascii?Q?Nk7WbfkjCwXq0d2BVTWo+e/CLEwcIM7sT31SsVVs4T+Z7QS/ibs1QlDfCTtq?=
 =?us-ascii?Q?UXj/VwRUMsUHfJjq895zlH5X+5TeFV1QYan5lcjKXhpyDhLBMIGRlspfEBuW?=
 =?us-ascii?Q?zO0UyEJZj02mntR40TOlBXvbtZOLij//P/IlXkCoSdyZHSOKcZXqz2iDfhbi?=
 =?us-ascii?Q?UukeKUhGkEhD1FXASN0SANd//JHqwuQH7JFQS/zQSsPXUlgh19C/z4vx3iel?=
 =?us-ascii?Q?4/5I21Emf4bj2SAxUzgDgTW3QoD1iq4FwwUA4ibFpcqMkZsHjZJOwiVZ4JRi?=
 =?us-ascii?Q?WwV0KKQdXJSAz9lOKOQOM60dIJ5hRbGI75L+gkBWXwNUx8ZvBa8IvArcBNZP?=
 =?us-ascii?Q?FrPJosM+VBhEvB3/z7K2+6IO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff52179e-f490-48d5-a8fa-08d8ea43f952
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1774.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 19:28:14.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qM+wDSi3IGj+oLryLZx6HulwANsw2zjaP3Ce0fJG7NiQIyVWoezgJpKd1o83MmZ8jO1/ZgBtBBM32p6LyeQ9z22XMVtqlVd2n3R4GmR2bdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4738
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180138
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180137
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Alexey Klimov <aklimov@redhat.com> writes:
> When a CPU offlined and onlined via device_offline() and device_online()
> the userspace gets uevent notification. If, after receiving "online" uevent,
> userspace executes sched_setaffinity() on some task trying to move it
> to a recently onlined CPU, then it sometimes fails with -EINVAL. Userspace
> needs to wait around 5..30 ms before sched_setaffinity() will succeed for
> recently onlined CPU after receiving uevent.
>
> If in_mask argument for sched_setaffinity() has only recently onlined CPU,
> it could fail with such flow:
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
>
> Out of line uevent can be avoided if we will ensure that cpuset_hotplug_work
> has run to completion using cpuset_wait_for_hotplug() after onlining the
> cpu in cpu_device_up() and in cpuhp_smt_enable().
>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> Co-analyzed-by: Joshua Baker <jobaker@redhat.com>
> Signed-off-by: Alexey Klimov <aklimov@redhat.com>

Looks good to me.

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
