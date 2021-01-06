Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1042EB8E5
	for <lists+cgroups@lfdr.de>; Wed,  6 Jan 2021 05:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbhAFE10 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jan 2021 23:27:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28558 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbhAFE1Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jan 2021 23:27:25 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1064Jemw010277;
        Tue, 5 Jan 2021 20:26:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0LAztK/1ttBt+WBb6oUnoEtr86qt4gMuPISh3DCFVgE=;
 b=ZQ7xv8suf2ANljJ1j0fFaqcFYAPjhEhRVO6FASR9K5rFXb+OVivQU7H37iObMNWgOxrT
 elOuLj3nXOIFRgz8NvVbuVotE18cEFuG3fR3Yx5JKmVLct98acwMEdq9o7iXrPYfToTj
 nrh3kdBAw5uxrCmz8DZDnQqKYZWAP0XER8g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35u9ruw495-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Jan 2021 20:26:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 5 Jan 2021 20:26:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3x8KttWjLIgiLw8d9aN5CmztDlP8LTTYLut9trGsb5pP9eXlDJ6VIJBd2WcjOhuIh6nBClC4Vh4cBKZeMWRYYDKOT3ZgjVJgs6VHZ+56Fm69rm/Vtj2TKv3GJ7DRZ/E3CXbtvN9rVQSHEHTwXmLS0Xy/9Lyz0Ej6dmf2zWj1AELk5U9vhJIXYFE7vCmZ21PglI+fRaoksJe+lSWmDb7kA/T3fDuUKfZEBsEuE/14AmESa7tWWEGR4soXZ1jfhK5RDSurpCvtEiwTUDVoIGqUGU+rsF0TN2maG7BFT0MK4RdS597WXoFr3eSKUVWsRg0A3O7Xo0nujIUNzlaeiUCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LAztK/1ttBt+WBb6oUnoEtr86qt4gMuPISh3DCFVgE=;
 b=CNJDSGQyp4PnQH3gKuZSj2r6MCDZbX1Zxex38RpGbg+qK7Y7ENpPUh0RP7SymoOfQ6c1EdqX4Vx4xxINbwMxGrS5Y/5fTqh5lbdSqu1DZCxZTWbUzMwUEi54Zq0cZkj7blldeBXqcqvw9T37d6ydazrrI2OgU9EOG4SsxBq1brJQo/MozCaEcHP1Lk3+98Onwf/pTBm3C4zp+VP0lOMWesUpr0wwv6VcV/E1vgNqQRiC6N9xEhfqpjs5BMy8q+vbJC1wgQtdsQ9ws9Rqp6LybgL4vUjRGMW4ys/7DtYdAV/NfmYhl0dZHNcFBd7ZDO0M1rSEW+tAzr+YDcm63J1QNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LAztK/1ttBt+WBb6oUnoEtr86qt4gMuPISh3DCFVgE=;
 b=Jhha8P2M36bHKDY+n+vof5gF3FsQkiMq+kWnr7UFolChSE95uiJB0/H/1j79PsOPz5/g8048BIMcX4JvfrR//bdTncyAdQUXNfjV3eprQW2czYwzJWoFbO3N89RxSKpgSAMawAX5VRYW8AfMwxQG/YxVlqpOBDOISy2eVLECc9k=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2440.namprd15.prod.outlook.com (2603:10b6:a02:91::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 04:26:35 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 04:26:35 +0000
Date:   Tue, 5 Jan 2021 20:26:30 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Imran Khan <imran.f.khan@oracle.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/memcontrol: Increase threshold for draining
 per-cpu stocked bytes.
Message-ID: <20210106042630.GA1110904@carbon.dhcp.thefacebook.com>
References: <1609862862-3573-1-git-send-email-imran.f.khan@oracle.com>
 <20210105182352.GE371241@carbon.dhcp.thefacebook.com>
 <20210105184558.GF371241@carbon.dhcp.thefacebook.com>
 <127fa24c-d4c4-5c24-ec30-ea6349f37923@oracle.com>
 <20210106032909.GG371241@carbon.dhcp.thefacebook.com>
 <9bd3018e-7182-fe4a-3ba2-ed0cf2e0875a@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bd3018e-7182-fe4a-3ba2-ed0cf2e0875a@oracle.com>
X-Originating-IP: [2620:10d:c090:400::5:ac37]
X-ClientProxiedBy: MW4PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:303:b7::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ac37) by MW4PR03CA0112.namprd03.prod.outlook.com (2603:10b6:303:b7::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 04:26:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55ae371c-b858-41fc-7752-08d8b1fb4093
X-MS-TrafficTypeDiagnostic: BYAPR15MB2440:
X-Microsoft-Antispam-PRVS: <BYAPR15MB24409F9D0D2559BF9A057D34BED00@BYAPR15MB2440.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIJheCTpXZUTIeJ1T3WR1XynXpGIDcWNvxruXTjMiE7gH2+zIfcJSCWhcCcctPzKqYO/a/N7k76nI5olCpqBvkaxEeuNV/pZY/qAiRiRW4a4UXK8YdXaDseCDV6gnRnhuDDnMZ8DpcWj0P21kOHl/yOhwzWZtkbVE7gwpKyDrrYzQREpt6nQNbTsFVzwhWcc1HZsZWbK5RVpWjLPoZOL0ULYVaTE+OfyyhnSZHcMPp1lP3/rBrkt558TnX5HnlB4bB/qmM7lJY7GxYuJUuo0oe85m+fp3dXE6pgoiu/J5CZSmW9f9IkDmIM5D55Mnf6fNHZMSLzAUs9wUxJbIW4twDlhT/+pxYtk3TwkKmOsjGYax5MpYXV2GY4OBE6zsJpXvuMt4cSMRpM1AqN0BgLWyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(376002)(136003)(346002)(478600001)(316002)(4326008)(83380400001)(8936002)(6916009)(1076003)(2906002)(5660300002)(9686003)(55016002)(66476007)(66556008)(86362001)(33656002)(16526019)(66946007)(52116002)(7696005)(186003)(8676002)(53546011)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Jq4NuVGBGB2LEEt/YzonUgJI/8quYkaSuFpuG8iw2c0jqFjV0Ww7CHy0zRlS?=
 =?us-ascii?Q?cFlwAJqTm/50QmN9F+X6/CvkFU2FJKUJY9vrldx5ZMOdmFZYDzN69Bt/N74h?=
 =?us-ascii?Q?1egloVtiu2idr1nzRH8yEJlrseXslX+uxqdlUE/yqeRw9/rUJSyOFYeydjKn?=
 =?us-ascii?Q?aAJANkvZQI2TGhYNA9hcKuag6HF5c4lepOgq6R3xsoTBk2EWlRwOxzzJToKx?=
 =?us-ascii?Q?xjDAaHg5d4qPj+iJ9vs1N0vb+qPWWb54WmmBDmcr1lSc7KfXLHSalLAWvPz1?=
 =?us-ascii?Q?gQO2WVYkO+/b1A4VldpfRwLYveuoK29nLHar7KepCWXb97G67AfFm70Mhksi?=
 =?us-ascii?Q?Vze3a3/ivgWsrNQuoDyz4ZfM9RUcVgCfXL9Kq11iTdTYLF6l/kJp0zIdfoAt?=
 =?us-ascii?Q?NPIn/+fMxGkdshNfMhbN5Ez9HeVL2V03YezcMcRIdb63xQKf7l8LAoHcoq/G?=
 =?us-ascii?Q?xWcZGYM8cgUm4jQfHyb05otSmPkTwvc2nc/02DhgopS+2nw1RXHmcURIrvrb?=
 =?us-ascii?Q?lfKK0/9sGoPsSdQ2RPQ7tn1RYMrZkLU+XP7i2ZlgrD6B3lQqCrLHkbU+NJGs?=
 =?us-ascii?Q?lTdInKK6pPDOTGQ9HPrNpMOKoxy+4iZDsUR6s5VQrERSaKZRUFl4hzcTPvUx?=
 =?us-ascii?Q?Km3q3zZx2rn+8joGHPk4X1bjP/ba/6yR/XxjeZaUqu9u0LmyXNogwFEBK3WD?=
 =?us-ascii?Q?6XRYJh6qMtrj7kQXhvlt/WPqTL9itXnqiTfW74ALouCydxKwu7MhBfZR6aGi?=
 =?us-ascii?Q?8AtybaJcx1acFb+HAn3pOhp2RQHQY+bzWIL+2essLYVsSPxnq3ZUHrHIvujq?=
 =?us-ascii?Q?bnhxFf+NmcC/UQ2xsOVOTRwcBTYCuY1boiZgfRisFQn0Ler1tAoKFdk/81wf?=
 =?us-ascii?Q?YTwyGaJ4Q+IC2rPA0m1zYqaz9FP1jwdwVVOrF/5qA/SdO7UOLGReZ9vkrv9I?=
 =?us-ascii?Q?SrpATL2BvhiHF5//Ufv7PCKnBgChZYWiQbd6hk5hcwi/SWzaJb4MGnbFca7v?=
 =?us-ascii?Q?p8mnHV6sKp5A5lznL5VHa6tDfQ=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 04:26:35.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ae371c-b858-41fc-7752-08d8b1fb4093
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HNxhLpxjiuJt1EXvqlFNS26JBZG7nf9ilJVpiqCT+ASFvALRC14fRz5/3IlpkUs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2440
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_03:2021-01-05,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 06, 2021 at 02:39:05PM +1100, Imran Khan wrote:
> On 6/1/21 2:29 pm, Roman Gushchin wrote:
> 
> > On Wed, Jan 06, 2021 at 02:07:12PM +1100, Imran Khan wrote:
> > > On 6/1/21 5:45 am, Roman Gushchin wrote:
> > > > On Tue, Jan 05, 2021 at 10:23:52AM -0800, Roman Gushchin wrote:
> > > > > On Tue, Jan 05, 2021 at 04:07:42PM +0000, Imran Khan wrote:
> > > > > > While allocating objects whose size is multiple of PAGE_SIZE,
> > > > > > say kmalloc-4K, we charge one page for extra bytes corresponding
> > > > > > to the obj_cgroup membership pointer and remainder of the charged
> > > > > > page gets added to per-cpu stocked bytes. If this allocation is
> > > > > > followed by another allocation of the same size, the stocked bytes
> > > > > > will not suffice and thus we endup charging an extra page
> > > > > > again for membership pointer and remainder of this page gets added
> > > > > > to per-cpu stocked bytes. This second addition will cause amount of
> > > > > > stocked bytes to go beyond PAGE_SIZE and hence will result in
> > > > > > invocation of drain_obj_stock.
> > > > > > 
> > > > > > So if we are in a scenario where we are consecutively allocating,
> > > > > > several PAGE_SIZE multiple sized objects, the stocked bytes will
> > > > > > never be enough to suffice a request and every second request will
> > > > > > trigger draining of stocked bytes.
> > > > > > 
> > > > > > For example invoking __alloc_skb multiple times with
> > > > > > 2K < packet size < 4K will give a call graph like:
> > > > > > 
> > > > > > __alloc_skb
> > > > > >       |
> > > > > >       |__kmalloc_reserve.isra.61
> > > > > >       |    |
> > > > > >       |    |__kmalloc_node_track_caller
> > > > > >       |    |    |
> > > > > >       |    |    |slab_pre_alloc_hook.constprop.88
> > > > > >       |    |     obj_cgroup_charge
> > > > > >       |    |    |    |
> > > > > >       |    |    |    |__memcg_kmem_charge
> > > > > >       |    |    |    |    |
> > > > > >       |    |    |    |    |page_counter_try_charge
> > > > > >       |    |    |    |
> > > > > >       |    |    |    |refill_obj_stock
> > > > > >       |    |    |    |    |
> > > > > >       |    |    |    |    |drain_obj_stock.isra.68
> > > > > >       |    |    |    |    |    |
> > > > > >       |    |    |    |    |    |__memcg_kmem_uncharge
> > > > > >       |    |    |    |    |    |    |
> > > > > >       |    |    |    |    |    |    |page_counter_uncharge
> > > > > >       |    |    |    |    |    |    |    |
> > > > > >       |    |    |    |    |    |    |    |page_counter_cancel
> > > > > >       |    |    |
> > > > > >       |    |    |
> > > > > >       |    |    |__slab_alloc
> > > > > >       |    |    |    |
> > > > > >       |    |    |    |___slab_alloc
> > > > > >       |    |    |    |
> > > > > >       |    |    |slab_post_alloc_hook
> > > > > > 
> > > > > > This frequent draining of stock bytes and resultant charging of pages
> > > > > > increases the CPU load and hence deteriorates the scheduler latency.
> > > > > > 
> > > > > > The above mentioned scenario and it's impact can be seen by running
> > > > > > hackbench with large packet size on v5.8 and subsequent kernels. The
> > > > > > deterioration in hackbench number starts appearing from v5.9 kernel,
> > > > > > 'commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> > > > > > instead of pages")'.
> > > > > > 
> > > > > > Increasing the draining limit to twice of KMALLOC_MAX_CACHE_SIZE
> > > > > > (a safe upper limit for size of slab cache objects), will avoid draining
> > > > > > of stock, every second allocation request, for the above mentioned
> > > > > > scenario and hence will reduce the CPU load for such cases. For
> > > > > > allocation of smaller objects or other allocation patterns the behaviour
> > > > > > will be same as before.
> > > > > > 
> > > > > > This change increases the draining threshold for per-cpu stocked bytes
> > > > > > from PAGE_SIZE to KMALLOC_MAX_CACHE_SIZE * 2.
> > > > > Hello, Imran!
> > > > > 
> > > > > Yes, it makes total sense to me.
> > > Hi Roman,
> > > 
> > > Thanks for reviewing this patch.
> > > 
> > > > > Btw, in earlier versions of the new slab controller there was a separate stock
> > > > > for byte-sized charging and it was 32 pages large. Later Johannes suggested
> > > > > the current layered design and he thought that because of the layering a single
> > > > > page is enough for the upper layer.
> > > > > 
> > > > > > Below are the hackbench numbers with and without this change on
> > > > > > v5.10.0-rc7.
> > > > > > 
> > > > > > Without this change:
> > > > > >       # hackbench process 10 1000 -s 100000
> > > > > >       Running in process mode with 10 groups using 40 file descriptors
> > > > > >       each (== 400 tasks)
> > > > > >       Each sender will pass 100 messages of 100000 bytes
> > > > > >       Time: 4.401
> > > > > > 
> > > > > >       # hackbench process 10 1000 -s 100000
> > > > > >       Running in process mode with 10 groups using 40 file descriptors
> > > > > >       each (== 400 tasks)
> > > > > >       Each sender will pass 100 messages of 100000 bytes
> > > > > >       Time: 4.470
> > > > > > 
> > > > > > With this change:
> > > > > >       # hackbench process 10 1000 -s 100000
> > > > > >       Running in process mode with 10 groups using 40 file descriptors
> > > > > >       each (== 400 tasks)
> > > > > >       Each sender will pass 100 messages of 100000 bytes
> > > > > >       Time: 3.782
> > > > > > 
> > > > > >       # hackbench process 10 1000 -s 100000
> > > > > >       Running in process mode with 10 groups using 40 file descriptors
> > > > > >       each (== 400 tasks)
> > > > > >       Each sender will pass 100 messages of 100000 bytes
> > > > > >       Time: 3.827
> > > > > > 
> > > > > > As can be seen the change gives an improvement of about 15% in hackbench
> > > > > > numbers.
> > > > > > Also numbers obtained with the change are inline with those obtained
> > > > > > from v5.8 kernel.
> > > > > The difference is quite impressive!
> > > > > 
> > > > > I wonder if you tried smaller values than KMALLOC_MAX_CACHE_SIZE * 2?
> > > > > Let's say 16 and 32?
> > > I have tested my change with smaller sizes as well and could see similar difference
> > > in hackbench numbers
> > > 
> > > Without change(5.10.0-rc7 vanilla):
> > > 
> > > # hackbench process 10 1000 -s 16
> > > Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> > > Each sender will pass 100 messages of 16 bytes
> > > Time: 0.429
> > > 
> > > # hackbench process 10 1000 -s 32
> > > Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> > > Each sender will pass 100 messages of 32 bytes
> > > Time: 0.458
> > > 
> > > With my changes on top of 5.10.0-rc7
> > > # hackbench process 10 1000 -s 16
> > > Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> > > Each sender will pass 100 messages of 16 bytes
> > > Time: 0.347
> > > 
> > > # hackbench process 10 1000 -s 32
> > > Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> > > Each sender will pass 100 messages of 32 bytes
> > > Time: 0.324
> > > 
> > > I am confirming using BCC based argdist tool that these sizes result in call to
> > > __alloc_skb with size as 16 and 32 respectively.
> > > 
> > > > > KMALLOC_MAX_CACHE_SIZE * 2 makes sense to me, but then the whole construction
> > > > > with two layer caching is very questionable. Anyway, it's not a reason to not
> > > > > merge your patch, just something I wanna look at later.
> > > > Hm, can you, please, benchmark the following change (without your change)?
> > > > 
> > > > @@ -3204,7 +3204,7 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
> > > >    		if (nr_pages) {
> > > >    			rcu_read_lock();
> > > > -			__memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
> > > > +			refill_stock(obj_cgroup_memcg(old), nr_pages);
> > > >    			rcu_read_unlock();
> > > >    		}
> > > I have tested this change on top of v5.10-rc7 and this too gives performance improvement.
> > > I further confirmed using flamegraphs that with this change too we are avoiding following
> > > CPU intensive path
> > > 
> > > |__memcg_kmem_uncharge
> > >      |
> > >      |page_counter_uncharge
> > >      |    |
> > >      |    |page_counter_cancel
> > > 
> > > Please find the hackbench numbers with your change as given below:
> > > # hackbench process 10 1000 -s 100000
> > > Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> > > Each sender will pass 100 messages of 100000 bytes
> > > Time: 3.841
> > > 
> > > # hackbench process 10 1000 -s 100000
> > > Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> > > Each sender will pass 100 messages of 100000 bytes
> > > Time: 3.863
> > > 
> > > # hackbench process 10 1000 -s 16
> > > Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> > > Each sender will pass 100 messages of 16 bytes
> > > Time: 0.306
> > > 
> > > # hackbench process 10 1000 -s 32
> > > Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> > > Each sender will pass 100 messages of 32 bytes
> > > Time: 0.320
> > Thank you for testing it!
> > 
> > If there is no significant difference, I'd prefer to stick with this change instead of increasing
> > the size of the percpu batch, because it will preserve the accuracy of accounting.
> > 
> > Will it work for you?
> 
> Yes, this works for me too.

Great!

Just sent the full version of the patch (you're in cc).

It's slightly different: initially I've missed the handling of a separate kmem page counter.
There should be no difference on cgroup v2, and hopefully it will be still acceptable on cgroup v1.
Your Tested-by will be highly appreciated.

Thank you!

Roman
