Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041E836601E
	for <lists+cgroups@lfdr.de>; Tue, 20 Apr 2021 21:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhDTTSq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Apr 2021 15:18:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60202 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233518AbhDTTSp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Apr 2021 15:18:45 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KJ7kE0012685;
        Tue, 20 Apr 2021 12:18:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=+Nr8aTrUc4EEeXeaW3ifa+be2lW0Pv6b5f+8AnmPVMg=;
 b=nURjeuHbzPr9pUMcb/MbbeQvkpyHBpADsvmKXvyUHy3d+2yhqsc+GF+dBCMvtBIgqQGS
 jKduCeahu2kOl7CbNzBNIA9v9rVk7WcQqgxedfFiD7FOjtK0gaaPW/HMh2A4GcPn78kY
 U7tprq+qwIUafrqDdAK+UMiQUtXu25ThLho= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 381fdfxg6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Apr 2021 12:18:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Apr 2021 12:18:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLLV7o4VlZAM0umpDbz4xiKMT5KqtbluKnMwNRTmKvNrxJLQdgOboseDz67b3tCu4iMhumFksGVrYNzCfKPQWfMhXMysSIZqGP7oFc4V1Q48KexyDj5cNc8+0U8cuq4TJG9w5VHqJKKRmAxD+NS14spIF5p0fvd2hmoVG0j8B2WW6rLmVT2g3DzLpDHy5xPicTFTJ/1NTH4btqFiUjhD9LWYcBWk+OlGALeaxsihc/WahjAOKyLfn6qluzBJ1kn9Cu/Fs58I79gKHPAE/CpbPpeo0Q2qT1+P9i/J+V1tm6Rh3WPdFiF9X0kcl1xVYLVEQJ30NVMB6+N9hPPjyGvgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Nr8aTrUc4EEeXeaW3ifa+be2lW0Pv6b5f+8AnmPVMg=;
 b=PW7KoQnXe3JFmdvksUryhfNdLBt41tHdv6SSKFr0Ycb/MXLP77QMZjihiSTgGzL8JPXiC/zyZU+hpcELhNK9yuMgXud1WpzS8AtaXdm8ovuxddEUQmuJmjRJT7Bdl0Inj0s+vl5aW4l+e4b3AqRR2WZDDN9xYpDy8wIUJbpnkuuNEKZhnj7Isd/mS2Jzv3gVhHxe4lbI11sCjkSrRwPeZAxqqh3uHJQhNYY6Xvek23Tg6O2hc7X8decTIQ8E7tnZ+Ayt6ddd8GF/+A0b24dgcERyENQcjYzcgo0+AHAm2aDJn52wiWkNLiURX+xyjQftuhVNTBTf0xXgEX2FpcRTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4866.namprd15.prod.outlook.com (2603:10b6:a03:3c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 19:18:04 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 19:18:04 +0000
Date:   Tue, 20 Apr 2021 12:17:58 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
Message-ID: <YH8o5iIau85FaeLw@carbon.DHCP.thefacebook.com>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:3ae2]
X-ClientProxiedBy: MWHPR01CA0048.prod.exchangelabs.com (2603:10b6:300:101::34)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:3ae2) by MWHPR01CA0048.prod.exchangelabs.com (2603:10b6:300:101::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Tue, 20 Apr 2021 19:18:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e94beea0-9aa1-4e98-524c-08d904310551
X-MS-TrafficTypeDiagnostic: BY3PR15MB4866:
X-Microsoft-Antispam-PRVS: <BY3PR15MB48668370173667D496E6A260BE489@BY3PR15MB4866.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JE7g6ZAsQPZuM8AAjsFc8aT2MVRHi04AcetrRwuD6enWX1ztrxV+ivaOzT7GjO3kFHjJi8HUet48myRUxCVrMpbAPtZ8vD/k/zKSsT/NR8jGcqmWP7ux07XBxJ/UdQ+uj8aHCSLg3Zjajvcajx1fFLMs+wm1IbNh5b+U7XWZa7puUBW6uxojikfdoUC5zSmPeqWkgsb0GAFw9Y9hpIkpB+Iaw77xOItcscUQrLhyTF0KbKR3rKQZmHg3nbCjJ/GdQ3fXx+mIJV0PnzKMQAXtJPyn6oIxmkHzTNJpG81/6VLpHTLkPfxelHMvN6oqAFxt66009SVTi6j35c9aX/9sI2qZ9KTxMtxwPdpO7/n+U7Jm2GXP/tdENZ1YFQc3WYQ0q115KBtxZV14vhegVYQE7dT0znrU9jMUrPyXU/FgieWSdyPoW7GgoIYFOINNdi1KB/uND580bdOvdUWuLBLBv8OFnJhh2YwvtEQtNDy6YvBC+W+3y1smXALtvzlsF5XFZ23AjvdmQjGvSfvXhPWUbDhyzZ2kwiA/qHH/eZQV5kSHW+bgQZAGddOZXQVL5xWVag9HgCg0gFchYAu0bDFelBKuoo/cz7kOLnIs6FK7kLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(39860400002)(376002)(66556008)(6666004)(478600001)(16526019)(7696005)(66946007)(55016002)(52116002)(38100700002)(66476007)(4326008)(2906002)(9686003)(186003)(83380400001)(7416002)(6506007)(316002)(8676002)(8936002)(5660300002)(86362001)(6916009)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L4CbJiHxV0mNAgWRus8M6DDdGrx/4RJ0p1Q2DDjS6zHgw5k4JuiXZ3219mfp?=
 =?us-ascii?Q?cwAPk/2GKbJYpyccGsY8eM2DTyv7FGy94ChjcH3mXAJi1qCg0YcP/zw+8KaT?=
 =?us-ascii?Q?SIWaOTuiSajOAwe4FvuCcNH5rfeYPx2mk8bDDIE54Eg0mqjpEiFFdmAoW9Oi?=
 =?us-ascii?Q?zMFz2qANNr/JdJtVxfErTst0FDyEcAe6sRSu8yrds1xZEoAXMsQGaWPAsRxk?=
 =?us-ascii?Q?CRLIg8qETfqBhhEUftPsCI+qsNmsTzXnvIGtaLPydKe8LPCJfsJYTMUt0F+m?=
 =?us-ascii?Q?S1W8tZBOPau5LY2OE73eodCAn99v9S5ZjKrbxfE2MNOj013EWaBMSXu++FaR?=
 =?us-ascii?Q?DV17i/uNwzy2HiHSgMVcUtSVGr/vrLORcFWpmqQ5KIYy+nCVHde4nKPBuNBL?=
 =?us-ascii?Q?ZyANyTo7cvIILTae8P/6qe/E3QZ9yw8deFTmRqVBM5bjTA/WsyVlYeH4YM2z?=
 =?us-ascii?Q?EJpcO1ItxGv63cgwR7I44Hmobj8s2Fvb2E8e9g5Lkr3Vqo+heOKEh8BifJaY?=
 =?us-ascii?Q?aIQgUqkdwSsPN0D1Z8IZDpxjST8kwYVV6wKhrNKA+rNTtichIGEStIswO7Th?=
 =?us-ascii?Q?p6BwZAo9f7RafRgmEjKiH2OFbhPfXHib+uPpkAFkc5DHV3AXAQ31l9yPLB/A?=
 =?us-ascii?Q?Y4XbynulQIxt9fprxs6qOwfazbOS9l3QgK/gDhnvXLLP8pZzbezsl88s69z9?=
 =?us-ascii?Q?6h3jtdJwxVwL5yjsq/XSqdM59l5mcoJhJtFfMUFjv8K+Hv4yUcSjQQZ7e0JB?=
 =?us-ascii?Q?zgmaZXLVMiY+uCBqcQu6ryC5xhXWcLipuyG2ZS5VS5Fhw2dXW1xQFEJMq/11?=
 =?us-ascii?Q?i1SjviHYnQX/4bgFTKwvIiQj/L+1nNfAvrKDj9J+HVtdoMQR5/NNm4jqY5KV?=
 =?us-ascii?Q?HDECooUjhVawA11Z6rWsO9+WXRBUvCOuncVQWH2ww1Vf20XFS7SbZ6+4N5c+?=
 =?us-ascii?Q?0AAbZjqQoHS+hDFY39TXXxpoUWgjmj4kwPEQb2OkwYCmLaeP/nl4KVYCO2gv?=
 =?us-ascii?Q?a9P2zuL3Nhkuynwqa36WI1ggqRhql6VUK2UWcOCQtDlZdCYs6XIFIgZRnwAY?=
 =?us-ascii?Q?zkSuMi+6OD08XSltaNeQR+JXxAC4KwtoDlFhg8LRA6C1hTlQBkr7w/WvgqJm?=
 =?us-ascii?Q?ioCqi9CZgShxokYZ3WrnsUfE+4IkIje6w4MfmW9+cIrCctJ1+jXsrM/lkvI4?=
 =?us-ascii?Q?T6GYuow1SpJAAxcLWddmHbCMHnXyqXlGjhMkl/A0kcP3lPHXiVKgsKt3Vx2C?=
 =?us-ascii?Q?vJgMhhNr3PZsoZ3S5U+Eh+RHJlnEBWYX5INSVpKV6DbNqK8sC2FD8VF1zzjE?=
 =?us-ascii?Q?DCeipR6B6lBNnazQZW/Y/LIYIgumLuLKySv1fm4t7+KfRQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e94beea0-9aa1-4e98-524c-08d904310551
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 19:18:04.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRbgjQKf1mHJz9tCOTSWy4POJUilFNRWCzxB8iCEYWEZpwY26eCEVGWeI8C3TXL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4866
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: YkqDQFuS4fkgjv0VVRJjenPfEQZBrzn7
X-Proofpoint-ORIG-GUID: YkqDQFuS4fkgjv0VVRJjenPfEQZBrzn7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_11:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 19, 2021 at 06:44:02PM -0700, Shakeel Butt wrote:
> Proposal: Provide memory guarantees to userspace oom-killer.
> 
> Background:
> 
> Issues with kernel oom-killer:
> 1. Very conservative and prefer to reclaim. Applications can suffer
> for a long time.
> 2. Borrows the context of the allocator which can be resource limited
> (low sched priority or limited CPU quota).
> 3. Serialized by global lock.
> 4. Very simplistic oom victim selection policy.
> 
> These issues are resolved through userspace oom-killer by:
> 1. Ability to monitor arbitrary metrics (PSI, vmstat, memcg stats) to
> early detect suffering.
> 2. Independent process context which can be given dedicated CPU quota
> and high scheduling priority.
> 3. Can be more aggressive as required.
> 4. Can implement sophisticated business logic/policies.
> 
> Android's LMKD and Facebook's oomd are the prime examples of userspace
> oom-killers. One of the biggest challenges for userspace oom-killers
> is to potentially function under intense memory pressure and are prone
> to getting stuck in memory reclaim themselves. Current userspace
> oom-killers aim to avoid this situation by preallocating user memory
> and protecting themselves from global reclaim by either mlocking or
> memory.min. However a new allocation from userspace oom-killer can
> still get stuck in the reclaim and policy rich oom-killer do trigger
> new allocations through syscalls or even heap.
> 
> Our attempt of userspace oom-killer faces similar challenges.
> Particularly at the tail on the very highly utilized machines we have
> observed userspace oom-killer spectacularly failing in many possible
> ways in the direct reclaim. We have seen oom-killer stuck in direct
> reclaim throttling, stuck in reclaim and allocations from interrupts
> keep stealing reclaimed memory. We have even observed systems where
> all the processes were stuck in throttle_direct_reclaim() and only
> kswapd was running and the interrupts kept stealing the memory
> reclaimed by kswapd.
> 
> To reliably solve this problem, we need to give guaranteed memory to
> the userspace oom-killer. At the moment we are contemplating between
> the following options and I would like to get some feedback.
> 
> 1. prctl(PF_MEMALLOC)
> 
> The idea is to give userspace oom-killer (just one thread which is
> finding the appropriate victims and will be sending SIGKILLs) access
> to MEMALLOC reserves. Most of the time the preallocation, mlock and
> memory.min will be good enough but for rare occasions, when the
> userspace oom-killer needs to allocate, the PF_MEMALLOC flag will
> protect it from reclaim and let the allocation dip into the memory
> reserves.
> 
> The misuse of this feature would be risky but it can be limited to
> privileged applications. Userspace oom-killer is the only appropriate
> user of this feature. This option is simple to implement.

Hello Shakeel!

If ordinary PAGE_SIZE and smaller kernel allocations start to fail,
the system is already in a relatively bad shape. Arguably the userspace
OOM killer should kick in earlier, it's already a bit too late.
Allowing to use reserves just pushes this even further, so we're risking
the kernel stability for no good reason.

But I agree that throttling the oom daemon in direct reclaim makes no sense.
I wonder if we can introduce a per-task flag which will exclude the task from
throttling, but instead all (large) allocations will just fail under a
significant memory pressure more easily. In this case if there is a significant
memory shortage the oom daemon will not be fully functional (will get -ENOMEM
for an attempt to read some stats, for example), but still will be able to kill
some processes and make the forward progress.
But maybe it can be done in userspace too: by splitting the daemon into
a core- and extended part and avoid doing anything behind bare minimum
in the core part.

> 
> 2. Mempool
> 
> The idea is to preallocate mempool with a given amount of memory for
> userspace oom-killer. Preferably this will be per-thread and
> oom-killer can preallocate mempool for its specific threads. The core
> page allocator can check before going to the reclaim path if the task
> has private access to the mempool and return page from it if yes.
> 
> This option would be more complicated than the previous option as the
> lifecycle of the page from the mempool would be more sophisticated.
> Additionally the current mempool does not handle higher order pages
> and we might need to extend it to allow such allocations. Though this
> feature might have more use-cases and it would be less risky than the
> previous option.

It looks like an over-kill for the oom daemon protection, but if there
are other good use cases, maybe it's a good feature to have.

> 
> Another idea I had was to use kthread based oom-killer and provide the
> policies through eBPF program. Though I am not sure how to make it
> monitor arbitrary metrics and if that can be done without any
> allocations.

To start this effort it would be nice to understand what metrics various
oom daemons use and how easy is to gather them from the bpf side. I like
this idea long-term, but not sure if it has been settled down enough.
I imagine it will require a fair amount of work on the bpf side, so we
need a good understanding of features we need.

Thanks!
