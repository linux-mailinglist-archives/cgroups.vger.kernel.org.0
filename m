Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F40B2EB2BF
	for <lists+cgroups@lfdr.de>; Tue,  5 Jan 2021 19:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbhAESqz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jan 2021 13:46:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41272 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbhAESqy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jan 2021 13:46:54 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 105IZUMN029699;
        Tue, 5 Jan 2021 10:46:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0zNiS3/pqnh1Cu+cbbYpbdARDCnoWUy92aKObi58e/w=;
 b=e9UnTewacR3LkT90IJfQ8Dex/FhyRFTGUpj+ivjx3UreVngQGo0zeS8Q9HiQQVFKKGfm
 0LqRfgIzOgXby5vtKMtJsX9L+MeJQMYgAR2c7sExnWc7sCsiORBreh6Vew0O3D/WmCCH
 PyS3cuDjBAhGRpbUOzDaf/Zhu4c/T3FVc6E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35vcs8caf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Jan 2021 10:46:05 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 5 Jan 2021 10:46:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDh4CY4m+OQOCB8li+Tm+99tElfgaBhoEfR46iMU4xiy+DkJSx01zA/H9JIrhMsy6eEiwvCoW/Sln4WYl3JVLhRYOYBdAsQ6ClEIBZRVz4MioWQnpHL9Cp2HeIwddEXWyMVJJN5dxn81H7OoqyEvox4trejJj+j0vDJHJwE56CR1iLYw+5787G1D5R/GoQd5RHsB8ZYMkKri1zo4fW+xpm1rw79ATC5r7DJGWftx/Yb4wg7sI2l1s21Ogm0L9MYCNaGBPhtsOHUHNfY1nAyncJpOyu6ycw186rQv8uL4xHP3HwTwMkgolgyIEQke4XmyEhPj7FERlQ7jxYsQcRD4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zNiS3/pqnh1Cu+cbbYpbdARDCnoWUy92aKObi58e/w=;
 b=CngWAc3Z59mdSfirN9An0eUxWd53zWyuMKSQX9mpzDwCuM97iL4MbswxUcoMSz6veQ4WtvXx1rGyLY1LMQHFgxXb+AocgGsp6kagZJ3+0Z7Looh2Gw7ulaHZiC7o5GJu6zbFf2QeyIiK7IN0cVRWI26GNnvOC8bx87nkF/l5GVpEdPZMi4s4kA6spD85MJ8R0naM73Fgx0SDFhYxfkw4OK+fkNhay9bGRRIjFx5JoUUVThlnHjFcS6z1tUz37CI9TJgJChGnESKywzDjFn1YPFtEDhnZoFYEinVStp+izHayatmuni/R/ryz4wtnchhyGJJzl2Re1YfNUNrAZsHi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zNiS3/pqnh1Cu+cbbYpbdARDCnoWUy92aKObi58e/w=;
 b=LpBCeW93Jarn+VG9CZ/CeNktYt/2p8WcKK/4Xp8ug4yb1+spnfC110dk6A0btJUcM3KQQRtA2Ggtznq+fYw1cInRcNZyDkle30MTok73gehdsg29Zx5Rx0zamj58yJ0zMjaja760Muvk9a2m//Sdi5V23ejebC/unLIB5neJioo=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3125.namprd15.prod.outlook.com (2603:10b6:a03:fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 18:46:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 18:46:03 +0000
Date:   Tue, 5 Jan 2021 10:45:58 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Imran Khan <imran.f.khan@oracle.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/memcontrol: Increase threshold for draining
 per-cpu stocked bytes.
Message-ID: <20210105184558.GF371241@carbon.dhcp.thefacebook.com>
References: <1609862862-3573-1-git-send-email-imran.f.khan@oracle.com>
 <20210105182352.GE371241@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105182352.GE371241@carbon.dhcp.thefacebook.com>
X-Originating-IP: [2620:10d:c090:400::5:e6f5]
X-ClientProxiedBy: CO2PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:102:1::51) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e6f5) by CO2PR04CA0083.namprd04.prod.outlook.com (2603:10b6:102:1::51) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Tue, 5 Jan 2021 18:46:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98781649-49db-4430-9c74-08d8b1aa272b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3125:
X-Microsoft-Antispam-PRVS: <BYAPR15MB31254A258B4F9EDA8454651DBED10@BYAPR15MB3125.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfjOUcOoGIzSs8K0uY+GmIo05Eq7/d/7IjsGaQrjrrgQP6EBYv3P8zcJpkWx2S9q3eh2aJMbEO82mIw5xlLOAn7C9o00TWJVxRDRUfIcz6NOsp1qNmjWRiWiMeC30RgIscOMPeb0kroovQ/7zuvgt4wPMTGiY7oZ1ryI5IG21q5bWhXM7Oi13f4z4LpLM6aqTUWpGx+N79/yJoxoA4utQP437pSP9I50o4asbTrzxG8L5ftWdZbc/3xNO0MjKsJKn0VJitznWDM+wuMYbcgXOC4Uk8uc1CCxPH8JixEmgTCWk/ZQGzLHuCcCRq0g6P/WsnLW6Y4xcKCX7Haw7HaqOLab0XN4fZKDUIcBGi7ksSo+Dsutek4cQnRTjoGtQiHj4JgF57FiJYM4u/jVv9tT8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39860400002)(366004)(52116002)(8936002)(478600001)(5660300002)(2906002)(4326008)(66556008)(66476007)(55016002)(83380400001)(66946007)(1076003)(316002)(33656002)(6916009)(16526019)(8676002)(86362001)(186003)(6506007)(9686003)(7696005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6lOKsAPj9TrbaDAK5lVSkeF1h9y+j0gbf2dtJGE89RbEFewiTwMdPzMAI2SV?=
 =?us-ascii?Q?szoafXnGxl163Q/KTK38EAO/hMWuNj2RRvTzp+vRVrxS0nJMKcXCTTlVEoef?=
 =?us-ascii?Q?8IyPwoo3aIx+Jw9zdylDR/SM0sira4+xVetNJar61V5HXPRrUtqNV98OjBid?=
 =?us-ascii?Q?dPrjI1h2o2WgaGPXrGIgeqVNiIv0mc70Le01W7kB2rLlyMv+LZbn3Khl5gax?=
 =?us-ascii?Q?lhuvjgKiDF7P3/HNkfLedxfkWHHjS1b51wNxmCMakxj+bTzEVCy09fmgi5vu?=
 =?us-ascii?Q?B1lRrEIjPYJ+2nB+3mcgcceMote8VdSyuDdEdviMx02jeVjxCOB47IQrKGla?=
 =?us-ascii?Q?RNww42Dmau9MOJHqV3AdjAr2gTKhDyILFxiH8TpFFHQCPoMKjwmEP/VsbEpp?=
 =?us-ascii?Q?ibWrujq+l+1//5gLLHT6J5UvhQwGd7WuklyHzENYpEi+6AVr00XjGyMuQcBa?=
 =?us-ascii?Q?vQXWU1BNzwO0lcx0H+OBn0UsuaFPEfjy+XUf33Ou0CLBHqCj7OxD/W3cFQmJ?=
 =?us-ascii?Q?YpmcTQruwPYi056sg7JvD8KiNlecDKsO/NiYkkMpu2VAcQ+tRxEpnw7bWbnW?=
 =?us-ascii?Q?Ovi16bdTXn++eWFdzDbN4a50I004voUW/i+XBiU/puuBmgd6XcgYd0bp+rsd?=
 =?us-ascii?Q?TAFPlQAfFMPBVNu886omh0RfERJP0X2vTStSkLitt66Aw/xg+Mbf7/c7QCRu?=
 =?us-ascii?Q?euhIz0yv3dzOBkdSK3EfgX7h3h/w7ct+zjRmB4Ey00w5BiYrcGeeMWXzVIt0?=
 =?us-ascii?Q?qf2eZFuEc6rWSKv74zExI1awElW8/AJD4E11OODowoirIz3wjwm2WLG1S9mF?=
 =?us-ascii?Q?u3yQSrp17g9Z52yzFBEuwx1ban24HPbxiNEMksYixHz5bnugzqSKwKkT/wfZ?=
 =?us-ascii?Q?1vdLygTLnZumAY1Non+ynxBUxzfe3lgqrxkUvaEtaGVtYyZrT9cjXtJrT33C?=
 =?us-ascii?Q?appMQwBhEhmqepxtxU/f1rCGS/ADydKs9/49C00iFwptBtVUoZV4uSC45B1r?=
 =?us-ascii?Q?VLc2mQQMP5SpdkModFJv+qbE0A=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 18:46:03.1182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 98781649-49db-4430-9c74-08d8b1aa272b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00ZjAjDwMmk+lpN5ptjpl05CYlko7EGXxNA88b5NHOVD/3/UyVWO6xQxtTyBRk7Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3125
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_05:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 05, 2021 at 10:23:52AM -0800, Roman Gushchin wrote:
> On Tue, Jan 05, 2021 at 04:07:42PM +0000, Imran Khan wrote:
> > While allocating objects whose size is multiple of PAGE_SIZE,
> > say kmalloc-4K, we charge one page for extra bytes corresponding
> > to the obj_cgroup membership pointer and remainder of the charged
> > page gets added to per-cpu stocked bytes. If this allocation is
> > followed by another allocation of the same size, the stocked bytes
> > will not suffice and thus we endup charging an extra page
> > again for membership pointer and remainder of this page gets added
> > to per-cpu stocked bytes. This second addition will cause amount of
> > stocked bytes to go beyond PAGE_SIZE and hence will result in
> > invocation of drain_obj_stock.
> > 
> > So if we are in a scenario where we are consecutively allocating,
> > several PAGE_SIZE multiple sized objects, the stocked bytes will
> > never be enough to suffice a request and every second request will
> > trigger draining of stocked bytes.
> > 
> > For example invoking __alloc_skb multiple times with
> > 2K < packet size < 4K will give a call graph like:
> > 
> > __alloc_skb
> >     |
> >     |__kmalloc_reserve.isra.61
> >     |    |
> >     |    |__kmalloc_node_track_caller
> >     |    |    |
> >     |    |    |slab_pre_alloc_hook.constprop.88
> >     |    |     obj_cgroup_charge
> >     |    |    |    |
> >     |    |    |    |__memcg_kmem_charge
> >     |    |    |    |    |
> >     |    |    |    |    |page_counter_try_charge
> >     |    |    |    |
> >     |    |    |    |refill_obj_stock
> >     |    |    |    |    |
> >     |    |    |    |    |drain_obj_stock.isra.68
> >     |    |    |    |    |    |
> >     |    |    |    |    |    |__memcg_kmem_uncharge
> >     |    |    |    |    |    |    |
> >     |    |    |    |    |    |    |page_counter_uncharge
> >     |    |    |    |    |    |    |    |
> >     |    |    |    |    |    |    |    |page_counter_cancel
> >     |    |    |
> >     |    |    |
> >     |    |    |__slab_alloc
> >     |    |    |    |
> >     |    |    |    |___slab_alloc
> >     |    |    |    |
> >     |    |    |slab_post_alloc_hook
> > 
> > This frequent draining of stock bytes and resultant charging of pages
> > increases the CPU load and hence deteriorates the scheduler latency.
> > 
> > The above mentioned scenario and it's impact can be seen by running
> > hackbench with large packet size on v5.8 and subsequent kernels. The
> > deterioration in hackbench number starts appearing from v5.9 kernel,
> > 'commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> > instead of pages")'.
> > 
> > Increasing the draining limit to twice of KMALLOC_MAX_CACHE_SIZE
> > (a safe upper limit for size of slab cache objects), will avoid draining
> > of stock, every second allocation request, for the above mentioned
> > scenario and hence will reduce the CPU load for such cases. For
> > allocation of smaller objects or other allocation patterns the behaviour
> > will be same as before.
> > 
> > This change increases the draining threshold for per-cpu stocked bytes
> > from PAGE_SIZE to KMALLOC_MAX_CACHE_SIZE * 2.
> 
> Hello, Imran!
> 
> Yes, it makes total sense to me.
> 
> Btw, in earlier versions of the new slab controller there was a separate stock
> for byte-sized charging and it was 32 pages large. Later Johannes suggested
> the current layered design and he thought that because of the layering a single
> page is enough for the upper layer.
> 
> > 
> > Below are the hackbench numbers with and without this change on
> > v5.10.0-rc7.
> > 
> > Without this change:
> >     # hackbench process 10 1000 -s 100000
> >     Running in process mode with 10 groups using 40 file descriptors
> >     each (== 400 tasks)
> >     Each sender will pass 100 messages of 100000 bytes
> >     Time: 4.401
> > 
> >     # hackbench process 10 1000 -s 100000
> >     Running in process mode with 10 groups using 40 file descriptors
> >     each (== 400 tasks)
> >     Each sender will pass 100 messages of 100000 bytes
> >     Time: 4.470
> > 
> > With this change:
> >     # hackbench process 10 1000 -s 100000
> >     Running in process mode with 10 groups using 40 file descriptors
> >     each (== 400 tasks)
> >     Each sender will pass 100 messages of 100000 bytes
> >     Time: 3.782
> > 
> >     # hackbench process 10 1000 -s 100000
> >     Running in process mode with 10 groups using 40 file descriptors
> >     each (== 400 tasks)
> >     Each sender will pass 100 messages of 100000 bytes
> >     Time: 3.827
> > 
> > As can be seen the change gives an improvement of about 15% in hackbench
> > numbers.
> > Also numbers obtained with the change are inline with those obtained
> > from v5.8 kernel.
> 
> The difference is quite impressive!
> 
> I wonder if you tried smaller values than KMALLOC_MAX_CACHE_SIZE * 2?
> Let's say 16 and 32?
> 
> KMALLOC_MAX_CACHE_SIZE * 2 makes sense to me, but then the whole construction
> with two layer caching is very questionable. Anyway, it's not a reason to not
> merge your patch, just something I wanna look at later.

Hm, can you, please, benchmark the following change (without your change)?

@@ -3204,7 +3204,7 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 
 		if (nr_pages) {
 			rcu_read_lock();
-			__memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
+			refill_stock(obj_cgroup_memcg(old), nr_pages);
 			rcu_read_unlock();
 		}
 
