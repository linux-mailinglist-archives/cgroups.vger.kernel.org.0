Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CCA2EB868
	for <lists+cgroups@lfdr.de>; Wed,  6 Jan 2021 04:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbhAFDaG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jan 2021 22:30:06 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16634 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbhAFDaF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jan 2021 22:30:05 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1063Ert0015105;
        Tue, 5 Jan 2021 19:29:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=6UZ35nITwq/YC4CNUKW5jybDW6RJSuTOZPwlg6nu8lw=;
 b=a+xKHkjqrCDp1LWrYCvlcWURs2cKZQ+fiowciQzLdgVMVePB3d4RvgOTw/allJ0l+Apr
 bsT5m05lnc1BzatajDbD/RmQd6crKvdpAH9ELmqNmIg+J/Xo0DKI7XV8ozOF/qG2ka4L
 DiywvuJvJfA5kVoOnPmUubDMddWTvgaJyzY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35vtuab41v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Jan 2021 19:29:17 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 5 Jan 2021 19:29:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hR8eyalEpWNXobNr+iBfGup4N1sRItvVqEDMwoRsAZ3i7PkKYoguAdAqytK6zj0Sv4vI2HGEZHvDIrhvsfoyLWOPSj6fImgKLW3UuFd3AxPe1grOIKxi9VamKNIV/Kz/NsPzyCd3unXlyXlTxdsGlGnHH/yGRv3MbVv3xk9EmaEo7qKWZqyv4n6tnEAldGpLzb0MmGMZszNUTcMMicYrUeohYrdiP2eBaRuEf+ncfhspv9UUHBio/4t5a9xuGdn4R4IWMAOqUJ6zNASGGAi/4YcGEmPODHihUC01Ts9jmYamFLvEpUQ5nx0kBUhlL8cir0EK+6cUTFVjF7liQoGP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UZ35nITwq/YC4CNUKW5jybDW6RJSuTOZPwlg6nu8lw=;
 b=OGPRWznKtY/ew4E/yKqRmbfOXQjkR4kSwQtfG6GVN52Gp0uzmJIZ1nhRWURfbf5hlSLQv/0fCDAAnlE//8g+FV4qNf0KXJkV/Uex1cM5N6pT3mHqR3UcYMVe/Keb+gpUuhPM9gtEF1l5tOKZFJX4lUKv6QshtUHm48psYk3MrxRmtRkBl5+B/Ve1K2UWVkC4y64TbLxllVGu3pC7DJMCY4CFUOz8iX3o8MAKsEFx08LGJslPfbHZiIJqXlp5rupjjuhtKSNkCJS3ysidR/pufPlz5/JUQ9/CEQQAai8DP+lMzll5etxOFmFO/bUoY/WRJHaeltydXP771u/FYVdVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UZ35nITwq/YC4CNUKW5jybDW6RJSuTOZPwlg6nu8lw=;
 b=YhwdHVCpHtr9ljURmjXbNOzyD29x4u31LFCpOknRAEvTRFV7bLqiHmNBkbKRIcHgMPE+udzxYjsLaOV3nQqULyMrC+mILBdAQn1GHHya3j34JExlVM5rx5pveHcMzH04eOH952/eb+QKkIpqiIScOml22G+mcqU3IwDP7TYIvSg=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3159.namprd15.prod.outlook.com (2603:10b6:a03:101::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Wed, 6 Jan
 2021 03:29:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 03:29:14 +0000
Date:   Tue, 5 Jan 2021 19:29:09 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Imran Khan <imran.f.khan@oracle.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/memcontrol: Increase threshold for draining
 per-cpu stocked bytes.
Message-ID: <20210106032909.GG371241@carbon.dhcp.thefacebook.com>
References: <1609862862-3573-1-git-send-email-imran.f.khan@oracle.com>
 <20210105182352.GE371241@carbon.dhcp.thefacebook.com>
 <20210105184558.GF371241@carbon.dhcp.thefacebook.com>
 <127fa24c-d4c4-5c24-ec30-ea6349f37923@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <127fa24c-d4c4-5c24-ec30-ea6349f37923@oracle.com>
X-Originating-IP: [2620:10d:c090:400::5:5263]
X-ClientProxiedBy: MW4PR03CA0366.namprd03.prod.outlook.com
 (2603:10b6:303:114::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5263) by MW4PR03CA0366.namprd03.prod.outlook.com (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22 via Frontend Transport; Wed, 6 Jan 2021 03:29:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e31d6092-4845-425b-6b46-08d8b1f33dcd
X-MS-TrafficTypeDiagnostic: BYAPR15MB3159:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3159B1CD6864CAE0741D1966BED00@BYAPR15MB3159.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMxrYJZvkyrTcJsSJBa0eCodCvA/k9G0+rcEjMjZsECx4QMlOj0ugajCuIQCnt4YiVhuMu8HHGaE8wopqDMTHSiLFUZiuGDBqTZ44Itc0EpEnqYwbWa5m19mTCp0cWNVlUPvqZDu1CJLtJE6DaJ6p/KDERh2pCjVEy1E3mO5bDq1jZrraANgnfri/zIbyy5f89LR38mE/VLVo90twqOGuVqZ1rGtr+Rc165TYPbMR1QgTTdQfTsIWWD8z2TbILhKnLy9zzo6txLwCjET+Zz+ttbkxwM1hlNF2gxBuUFP1KD+FYWTkU68Qhfasd7n437kUzLOyb2zkfOK0deC4LiFDU6xx3b/s/9kS6F998WNfF47eSYlnjr709Q55vux/tBm8GbiqcQC57BotwoseerlpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(396003)(136003)(66556008)(8676002)(66476007)(16526019)(186003)(66946007)(55016002)(316002)(6666004)(2906002)(86362001)(52116002)(9686003)(53546011)(5660300002)(1076003)(83380400001)(6916009)(6506007)(4326008)(8936002)(7696005)(33656002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3rOLhYTwPCwu6zwLMIP/OPxNqS1VnXjXfHnj1moJ6HRuHR6tGtKQB4SiTgxQ?=
 =?us-ascii?Q?1Q9uRrS4ScbynnAvmGqFkY9oJrR3EbQUTPDanMAc59fOV77fxwQk8ECiGZ7N?=
 =?us-ascii?Q?Ky8bDvkf8MsBbpUQ8gOD8rB6gQb8AN2Qc+5HRAxGT4T6No9hRLWiY/4WdtxT?=
 =?us-ascii?Q?YNVC1Govf1vgcX12D3nFLi1a74wJfHd+618NVEq33yEWufUlYCGm9x+2EI2Q?=
 =?us-ascii?Q?l0f9/HGx0IMhL4p46jhQeMGL7CqhEopKCi2KWSxRtm3IvxXN5EaNS8FbRthx?=
 =?us-ascii?Q?YhpNg7jcClBJD/BmhH5LuJrTxcj5WJKswssQKF/ySeqYqSNW/EBbZxwEAwao?=
 =?us-ascii?Q?sYehNYmaI/phZUD7P6uYX33ErQwv7Q4figA4s9GgEGmLyC/3NB6mxYRKLtAy?=
 =?us-ascii?Q?cDpekqC/fpncaXJ2lb/rPiSyShEVahUCCNtBc1g8ncmmlYEeJ8HpDXzkrej2?=
 =?us-ascii?Q?tAJpX6VWpWvNr91v6iQyHFHA2aPL2YuXFZWualfyiJuelYsGgzVU8ybvLu38?=
 =?us-ascii?Q?1lhNRsOTw2l8JZIBDrNEFsq3MbNpX6zCb+dH6B9hwHHMhk07bU155d31Kc4n?=
 =?us-ascii?Q?nW4jC/HdRzQADPwMG55VwAfdHfmHARUyISISL1qQjv0R6gBsSaC9obQzOdCd?=
 =?us-ascii?Q?EoOSk4sAY9tBZboWubEI73xCC7KY4RtIV/ttju07nHh1DvYoeHsECtGSnJie?=
 =?us-ascii?Q?8KoJfA4OebmjpcSTcW4Ki45OJRjz/nEPFZ8/IAMA6G6npujQKhYi/oPe5FHN?=
 =?us-ascii?Q?0yuJ9g1m9X4sHxsHED5pbbsoWxWDT5C/WQPc39b3QgSVtSRu9DeVolQuYjpY?=
 =?us-ascii?Q?zFGeF711vPlP7AJC6UyQFIyi1/JNetfclk5p7IcyrYiGJd47ccYLxCVLP+UT?=
 =?us-ascii?Q?fbErfN4UaTFJoZat7xgJc7lzidoQb+s63C70nBqkhW5BcB2ug7kL2uf5RVEC?=
 =?us-ascii?Q?ZUueG6yImytVNHidln1mO3ODnUzr5EJY4p+HfKTbcfoUzHs4h+knxfLCG/7C?=
 =?us-ascii?Q?5OO4ndwSz8nfBqIusCE055IZwg=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 03:29:14.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: e31d6092-4845-425b-6b46-08d8b1f33dcd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PLBYNxlS+HQMJa/4aV/P8F4Q4VU23f8yG1i+3fW7YfVe4XpPOdAFvBAWo+EIngv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3159
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_03:2021-01-05,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101060019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 06, 2021 at 02:07:12PM +1100, Imran Khan wrote:
> 
> On 6/1/21 5:45 am, Roman Gushchin wrote:
> > On Tue, Jan 05, 2021 at 10:23:52AM -0800, Roman Gushchin wrote:
> > > On Tue, Jan 05, 2021 at 04:07:42PM +0000, Imran Khan wrote:
> > > > While allocating objects whose size is multiple of PAGE_SIZE,
> > > > say kmalloc-4K, we charge one page for extra bytes corresponding
> > > > to the obj_cgroup membership pointer and remainder of the charged
> > > > page gets added to per-cpu stocked bytes. If this allocation is
> > > > followed by another allocation of the same size, the stocked bytes
> > > > will not suffice and thus we endup charging an extra page
> > > > again for membership pointer and remainder of this page gets added
> > > > to per-cpu stocked bytes. This second addition will cause amount of
> > > > stocked bytes to go beyond PAGE_SIZE and hence will result in
> > > > invocation of drain_obj_stock.
> > > > 
> > > > So if we are in a scenario where we are consecutively allocating,
> > > > several PAGE_SIZE multiple sized objects, the stocked bytes will
> > > > never be enough to suffice a request and every second request will
> > > > trigger draining of stocked bytes.
> > > > 
> > > > For example invoking __alloc_skb multiple times with
> > > > 2K < packet size < 4K will give a call graph like:
> > > > 
> > > > __alloc_skb
> > > >      |
> > > >      |__kmalloc_reserve.isra.61
> > > >      |    |
> > > >      |    |__kmalloc_node_track_caller
> > > >      |    |    |
> > > >      |    |    |slab_pre_alloc_hook.constprop.88
> > > >      |    |     obj_cgroup_charge
> > > >      |    |    |    |
> > > >      |    |    |    |__memcg_kmem_charge
> > > >      |    |    |    |    |
> > > >      |    |    |    |    |page_counter_try_charge
> > > >      |    |    |    |
> > > >      |    |    |    |refill_obj_stock
> > > >      |    |    |    |    |
> > > >      |    |    |    |    |drain_obj_stock.isra.68
> > > >      |    |    |    |    |    |
> > > >      |    |    |    |    |    |__memcg_kmem_uncharge
> > > >      |    |    |    |    |    |    |
> > > >      |    |    |    |    |    |    |page_counter_uncharge
> > > >      |    |    |    |    |    |    |    |
> > > >      |    |    |    |    |    |    |    |page_counter_cancel
> > > >      |    |    |
> > > >      |    |    |
> > > >      |    |    |__slab_alloc
> > > >      |    |    |    |
> > > >      |    |    |    |___slab_alloc
> > > >      |    |    |    |
> > > >      |    |    |slab_post_alloc_hook
> > > > 
> > > > This frequent draining of stock bytes and resultant charging of pages
> > > > increases the CPU load and hence deteriorates the scheduler latency.
> > > > 
> > > > The above mentioned scenario and it's impact can be seen by running
> > > > hackbench with large packet size on v5.8 and subsequent kernels. The
> > > > deterioration in hackbench number starts appearing from v5.9 kernel,
> > > > 'commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> > > > instead of pages")'.
> > > > 
> > > > Increasing the draining limit to twice of KMALLOC_MAX_CACHE_SIZE
> > > > (a safe upper limit for size of slab cache objects), will avoid draining
> > > > of stock, every second allocation request, for the above mentioned
> > > > scenario and hence will reduce the CPU load for such cases. For
> > > > allocation of smaller objects or other allocation patterns the behaviour
> > > > will be same as before.
> > > > 
> > > > This change increases the draining threshold for per-cpu stocked bytes
> > > > from PAGE_SIZE to KMALLOC_MAX_CACHE_SIZE * 2.
> > > Hello, Imran!
> > > 
> > > Yes, it makes total sense to me.
> 
> Hi Roman,
> 
> Thanks for reviewing this patch.
> 
> > > 
> > > Btw, in earlier versions of the new slab controller there was a separate stock
> > > for byte-sized charging and it was 32 pages large. Later Johannes suggested
> > > the current layered design and he thought that because of the layering a single
> > > page is enough for the upper layer.
> > > 
> > > > Below are the hackbench numbers with and without this change on
> > > > v5.10.0-rc7.
> > > > 
> > > > Without this change:
> > > >      # hackbench process 10 1000 -s 100000
> > > >      Running in process mode with 10 groups using 40 file descriptors
> > > >      each (== 400 tasks)
> > > >      Each sender will pass 100 messages of 100000 bytes
> > > >      Time: 4.401
> > > > 
> > > >      # hackbench process 10 1000 -s 100000
> > > >      Running in process mode with 10 groups using 40 file descriptors
> > > >      each (== 400 tasks)
> > > >      Each sender will pass 100 messages of 100000 bytes
> > > >      Time: 4.470
> > > > 
> > > > With this change:
> > > >      # hackbench process 10 1000 -s 100000
> > > >      Running in process mode with 10 groups using 40 file descriptors
> > > >      each (== 400 tasks)
> > > >      Each sender will pass 100 messages of 100000 bytes
> > > >      Time: 3.782
> > > > 
> > > >      # hackbench process 10 1000 -s 100000
> > > >      Running in process mode with 10 groups using 40 file descriptors
> > > >      each (== 400 tasks)
> > > >      Each sender will pass 100 messages of 100000 bytes
> > > >      Time: 3.827
> > > > 
> > > > As can be seen the change gives an improvement of about 15% in hackbench
> > > > numbers.
> > > > Also numbers obtained with the change are inline with those obtained
> > > > from v5.8 kernel.
> > > The difference is quite impressive!
> > > 
> > > I wonder if you tried smaller values than KMALLOC_MAX_CACHE_SIZE * 2?
> > > Let's say 16 and 32?
> 
> I have tested my change with smaller sizes as well and could see similar difference
> in hackbench numbers
> 
> Without change(5.10.0-rc7 vanilla):
> 
> # hackbench process 10 1000 -s 16
> Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> Each sender will pass 100 messages of 16 bytes
> Time: 0.429
> 
> # hackbench process 10 1000 -s 32
> Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> Each sender will pass 100 messages of 32 bytes
> Time: 0.458
> 
> With my changes on top of 5.10.0-rc7
> # hackbench process 10 1000 -s 16
> Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> Each sender will pass 100 messages of 16 bytes
> Time: 0.347
> 
> # hackbench process 10 1000 -s 32
> Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> Each sender will pass 100 messages of 32 bytes
> Time: 0.324
> 
> I am confirming using BCC based argdist tool that these sizes result in call to
> __alloc_skb with size as 16 and 32 respectively.
> 
> > > 
> > > KMALLOC_MAX_CACHE_SIZE * 2 makes sense to me, but then the whole construction
> > > with two layer caching is very questionable. Anyway, it's not a reason to not
> > > merge your patch, just something I wanna look at later.
> > Hm, can you, please, benchmark the following change (without your change)?
> > 
> > @@ -3204,7 +3204,7 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
> >   		if (nr_pages) {
> >   			rcu_read_lock();
> > -			__memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
> > +			refill_stock(obj_cgroup_memcg(old), nr_pages);
> >   			rcu_read_unlock();
> >   		}
> 
> I have tested this change on top of v5.10-rc7 and this too gives performance improvement.
> I further confirmed using flamegraphs that with this change too we are avoiding following
> CPU intensive path
> 
> |__memcg_kmem_uncharge
>     |
>     |page_counter_uncharge
>     |    |
>     |    |page_counter_cancel
> 
> Please find the hackbench numbers with your change as given below:
> # hackbench process 10 1000 -s 100000
> Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> Each sender will pass 100 messages of 100000 bytes
> Time: 3.841
> 
> # hackbench process 10 1000 -s 100000
> Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> Each sender will pass 100 messages of 100000 bytes
> Time: 3.863
> 
> # hackbench process 10 1000 -s 16
> Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> Each sender will pass 100 messages of 16 bytes
> Time: 0.306
> 
> # hackbench process 10 1000 -s 32
> Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
> Each sender will pass 100 messages of 32 bytes
> Time: 0.320

Thank you for testing it!

If there is no significant difference, I'd prefer to stick with this change instead of increasing
the size of the percpu batch, because it will preserve the accuracy of accounting.

Will it work for you?

Thanks!
