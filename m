Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F13663D4
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 04:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhDUC72 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Apr 2021 22:59:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58954 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233874AbhDUC72 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Apr 2021 22:59:28 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13L2rbZI016976;
        Tue, 20 Apr 2021 19:58:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rcEqyBGyYbPZrnR9SXF3vGnhX7JsD52+JAY0/t51lJc=;
 b=TBNtrgeIXOeHS4t2xaEXr7QYn0OsiZuTZgIXWoqt9o13z1UQn+Io7yPasZf+knx3Ue/H
 YiNCgCSiLQ5tfJO0sdYHzTbBFeOFjjyR/HkwPCLJceRan6PtZEVll1tmyd1wBiuFv8gY
 hf4b0BwnLygn0j9TvB+UlOU8UTACaZpoXks= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3826yu97xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Apr 2021 19:58:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Apr 2021 19:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyCLD/dllebiB6cfVVRg9CRRbPckiIwmwkUkmt4IJn7y11iWP0wUCwJEMPd+cqff4GLE6n7w9GNQ5MOHcu1cRFlPaF57HRaGEPB7S4qGhO0fwIfQm1qxtLRPKiZ57xlJGi4KPzkHPsu+ZkgaTJGJ3QWBE43cEsk6eEJwxpUiHWof8Atr7zJQYkl31J3T3GXun6sdfX/ozpsw4+aF4YKXxcdHmJVMDuKO8FORCqhhJHXWgkuQb3c8g2QU8D3eMR2pc3wF44DAJJDpRCzswEpavNr2QNQ+y4c/aFU0D4TFRkJqrAXyB1KgaFz/lxlwswmPUgU/+AWXvyIEjrKTYYrFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcEqyBGyYbPZrnR9SXF3vGnhX7JsD52+JAY0/t51lJc=;
 b=c1brokvJwBgPMJt8Vb9mFvNg5aeRumDmZAcZ2Q9h3TC7vnLhmUjEHa1P4OIo7LQezN55JT1YLD5o735CS+cNn0FdzsJKca0KjiEP3AeG4lW5bzPlVwT7AzTlYAJrmLmqAvf9IjNVnEG/5tux++ngoSXtVtlm50rMYIy4h0NvlvfqJlMG5tUO50YcknEBwtVe3pFKIkpu8ENmgSACHdFCo6MK+r/CieKCQILLy3nHGQNicSOpGYShYS2X5g4vhNZ/wrqPloUtTZtktd+y8y4xpvdBXv59BpM/A6NR1WTbPkX3yk4TL8Q8gO09tfk3PKzDXMnxfZKQmRXVinNHTG7Cbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4501.namprd15.prod.outlook.com (2603:10b6:a03:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 02:58:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 02:58:47 +0000
Date:   Tue, 20 Apr 2021 19:58:41 -0700
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
Message-ID: <YH+U4X8PKWZpOpAA@carbon.dhcp.thefacebook.com>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH8o5iIau85FaeLw@carbon.DHCP.thefacebook.com>
 <CALvZod7dXuFPeMv5NGu96uCosFpWY_Gy07iDsfSORCA0dT_zsA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod7dXuFPeMv5NGu96uCosFpWY_Gy07iDsfSORCA0dT_zsA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:792c]
X-ClientProxiedBy: MW4PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:303:b8::12) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:792c) by MW4PR03CA0187.namprd03.prod.outlook.com (2603:10b6:303:b8::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Wed, 21 Apr 2021 02:58:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55489e0c-e88e-41a4-bb48-08d90471621b
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4501:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4501B391C65ABE960C55E150BE479@SJ0PR15MB4501.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVLShwhK2TwwnmkQS8mVP29F3RUw3l8lhdaYVOPR504E/C59ZntkFKaJaogdu6s+l2j32YfRFeH5a3DcP+6za4JZjXodOYJrBFPmQbj0M/8+rmImM17CVZOzXEni7JAtPf3t+ZICm6dVa2H3ohnD1msGOuw1oKKdQKsxZShQUCtjpVsDpsV7791Mm2ieobDI08N9da1HmHFg9FNJfxqlhWmwKwJ3l9oQ0x5DKfMxNDc6Gu6gffKMJ+y2Lhh74TtUJTuRJmTOvFtP0PNkaDGnJTss28655ngbXCj29oJyXNDXx3USg7QE9nvoZyCcT8irjRNUu3rk85njoWAhdAG+k72iI8jBNYaFKRf8ixRRDjUS+1olpIOsRt6pDx3BYXADYqv3OmLi6ptfPvI61U/Xhjqe58iWc92YZJe0+7ynGgpAonHkG7T1mLWmpfUSc0XMuZKWqI6d53qZMqPrOT5f/gmD0/xXCYqxDcTvcECp1wF1Lcl/026tuQ1vPMxJRFMIpEmog7XfkszVpKxagfCxEIBrQxIi6hiVtnd3b2L3CLzalv8blSlkX3SSFc33gTPk4akkBglwbtTh8/5KJQ3u/KrpBuFDG6WU32FQSC4GvovK9YfTs2e5i4clO0mRRGVwXazpR0yRfcC9Yls5gT3OHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(346002)(376002)(6916009)(52116002)(9686003)(7696005)(478600001)(38100700002)(5660300002)(6506007)(55016002)(7416002)(53546011)(2906002)(316002)(54906003)(66476007)(86362001)(8936002)(8676002)(186003)(6666004)(66556008)(83380400001)(16526019)(4326008)(66946007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?k78wU6nLPsmYmvvU5R3zGyyX1sq1mhKY52ZLMNg3d+BbT8PQ1f37fbeRwORK?=
 =?us-ascii?Q?6HA0drNado0pix9YZ2ca8lJM68sIRf/MmTEIbAE1Cg9SE8djDaTIFtkOCEH7?=
 =?us-ascii?Q?nL+yxkPY+M9oU64QYnA2a3drUtMl0grRTrur3DXgXKwaXdSVo9f7/FZsA2Ef?=
 =?us-ascii?Q?FqcK76RDn6wdCJOn0Sw2rHwSfzeX+hpyE76Or95qmAG/WhyLhBk6L8qV4bWd?=
 =?us-ascii?Q?sD8DFZmsY1G6pFm3C9jdRJl5wHKiwWSp7pa6hDkafShGzhU/pgIYI6UL1S9w?=
 =?us-ascii?Q?sqe9K4KPwNjZkScyB4hJPqAZRFklS5L3XhHFRASwnpYtAhvtO+jd+PMHS3Ew?=
 =?us-ascii?Q?7ZyAp5pA8mjFyQ50ECHiq9OeiZ3IL0ndm7DeiziOkbBehKKJJ8WRGcmts65k?=
 =?us-ascii?Q?h7G3kX8VOLmDVxkqrBDZOAn2ioRU9zC8/Cp06YJqNXIUoq/sUgMlZGtyP9Gt?=
 =?us-ascii?Q?4JL6onrvBJs3yTk9LEz0f8mUsBfghGnRKkXgVHGdVnNdMY9juL4I3Hr7baD2?=
 =?us-ascii?Q?YqPU2NwE6G/64X3S5HYnpgGDcxywQq0ro8/V5dUCfRNpBgk8i0etE9Z67O0i?=
 =?us-ascii?Q?+yUsV8eJ+UOVxbwg9slKY2t1wXDDXbnBjqXKK2lHSymuVgB7+ONCFhus8DFS?=
 =?us-ascii?Q?U0dkh4MP6qlWN1cYAC+uhLwc6x6w7RMLwKd2dIy7yFVUZkHVrcPCbuCga3ee?=
 =?us-ascii?Q?5RZBP5S0ZLMKkbESd8sNvurXr4VelTC7c0GfTK34MCjFdemzv2x5mzMgjOG5?=
 =?us-ascii?Q?qWqySEZb0K9mG5OMk0xJbUVjtnDvmPmYSnm3LDXSfc1XGt6aofDT1AeHYoVC?=
 =?us-ascii?Q?KMb/iUpMwH8wZVaLGWiiBFXN7zW6YKU/qGJ78lhLtcr0VdXsELmM2Rym5mzr?=
 =?us-ascii?Q?WbfjoFinaa6bWjM9N/XPibEFkeDMWY/syqRjcEaOVuGzlsoartrtcWIRtDr+?=
 =?us-ascii?Q?FDW2ldz+wwcUX7UECVAcfpO6lj+E+ZeaByzLvnYHXpiQo5vjWh5noz19wf8x?=
 =?us-ascii?Q?LOPBoPvQ80+UoE34EVnf+TLHWSmN7suPLhBo9poytjJThZLqwVNyxFQaGERF?=
 =?us-ascii?Q?NcBlEfETbBjJIfJ4f5djK/TY28fdnobzeCqM9vqA9VWgufbhK+y0xo/+lSr+?=
 =?us-ascii?Q?gncGECuNDynvJD2+BdCKfAxpRxKg5NaeQznsCYG4UdnpmFLjEjvtxfmX+OuU?=
 =?us-ascii?Q?HmAEvvoB9QtH28Dt1a4FA8F1E3pGdunANWTgVnxiNfVcYz0uAuQ1Eh5Nw3xu?=
 =?us-ascii?Q?IkjXLUeHLGdiJMYU8X5i5yJPwv/4J9QPgK8RheJcsNs68/Uej95cfuCtY6L1?=
 =?us-ascii?Q?Je9sbmdKghd3+EdThWdUlH7aIZWL4KPVZKx3cIebgNMV1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55489e0c-e88e-41a4-bb48-08d90471621b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 02:58:47.9422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9QGQj1QJJ977n7J9xqLHPi/+VOSZTVXFVDcYv4daCrxXf3cUUhd71m1kbT8ONxI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4501
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: jFg5cGpavqzNDvzes_dAWotlI9ksEU5x
X-Proofpoint-ORIG-GUID: jFg5cGpavqzNDvzes_dAWotlI9ksEU5x
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_11:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 20, 2021 at 06:18:29PM -0700, Shakeel Butt wrote:
> On Tue, Apr 20, 2021 at 12:18 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Mon, Apr 19, 2021 at 06:44:02PM -0700, Shakeel Butt wrote:
> [...]
> > > 1. prctl(PF_MEMALLOC)
> > >
> > > The idea is to give userspace oom-killer (just one thread which is
> > > finding the appropriate victims and will be sending SIGKILLs) access
> > > to MEMALLOC reserves. Most of the time the preallocation, mlock and
> > > memory.min will be good enough but for rare occasions, when the
> > > userspace oom-killer needs to allocate, the PF_MEMALLOC flag will
> > > protect it from reclaim and let the allocation dip into the memory
> > > reserves.
> > >
> > > The misuse of this feature would be risky but it can be limited to
> > > privileged applications. Userspace oom-killer is the only appropriate
> > > user of this feature. This option is simple to implement.
> >
> > Hello Shakeel!
> >
> > If ordinary PAGE_SIZE and smaller kernel allocations start to fail,
> > the system is already in a relatively bad shape. Arguably the userspace
> > OOM killer should kick in earlier, it's already a bit too late.
> 
> Please note that these are not allocation failures but rather reclaim
> on allocations (which is very normal). Our observation is that this
> reclaim is very unpredictable and depends on the type of memory
> present on the system which depends on the workload. If there is a
> good amount of easily reclaimable memory (e.g. clean file pages), the
> reclaim would be really fast. However for other types of reclaimable
> memory the reclaim time varies a lot. The unreclaimable memory, pinned
> memory, too many direct reclaimers, too many isolated memory and many
> other things/heuristics/assumptions make the reclaim further
> non-deterministic.
> 
> In our observation the global reclaim is very non-deterministic at the
> tail and dramatically impacts the reliability of the system. We are
> looking for a solution which is independent of the global reclaim.
> 
> > Allowing to use reserves just pushes this even further, so we're risking
> > the kernel stability for no good reason.
> 
> Michal has suggested ALLOC_OOM which is less risky.

The problem is that even if you'll serve the oom daemon task with pages
from a reserve/custom pool, it doesn't guarantee anything, because the task
still can wait for a long time on some mutex, taken by another process,
throttled somewhere in the reclaim. You're basically trying to introduce a
"higher memory priority" and as always in such cases there will be priority
inversion problems.

So I doubt that you can simple create a common mechanism which will work
flawlessly for all kinds of allocations, I anticipate many special cases
requiring an individual approach.

> 
> >
> > But I agree that throttling the oom daemon in direct reclaim makes no sense.
> > I wonder if we can introduce a per-task flag which will exclude the task from
> > throttling, but instead all (large) allocations will just fail under a
> > significant memory pressure more easily. In this case if there is a significant
> > memory shortage the oom daemon will not be fully functional (will get -ENOMEM
> > for an attempt to read some stats, for example), but still will be able to kill
> > some processes and make the forward progress.
> 
> So, the suggestion is to have a per-task flag to (1) indicate to not
> throttle and (2) fail allocations easily on significant memory
> pressure.
> 
> For (1), the challenge I see is that there are a lot of places in the
> reclaim code paths where a task can get throttled. There are
> filesystems that block/throttle in slab shrinking. Any process can get
> blocked on an unrelated page or inode writeback within reclaim.
> 
> For (2), I am not sure how to deterministically define "significant
> memory pressure". One idea is to follow the __GFP_NORETRY semantics
> and along with (1) the userspace oom-killer will see ENOMEM more
> reliably than stucking in the reclaim.
> 
> So, the oom-killer maintains a list of processes to kill in extreme
> conditions, have their pidfds open and keep that list fresh. Whenever
> any syscalls returns ENOMEM, it starts doing
> pidfd_send_signal(SIGKILL) to that list of processes, right?
> 
> The idea has merit but I don't see how this is any simpler. The (1) is
> challenging on its own and my main concern is that it will be very
> hard to maintain as reclaim code (particularly shrinkers) callbacks
> into many diverse subsystems.

Yeah, I thought about something like this, but I didn't go too deep.
Basically we can emulate __GFP_NOFS | __GFP_NORETRY, but I'm not sure
we can apply it for any random allocation without bad consequences.

Btw, this approach can be easily prototyped using bpf: a bpf program
can be called on each allocation and modify the behavior based on
the pid of the process and other circumstances.

> 
> > But maybe it can be done in userspace too: by splitting the daemon into
> > a core- and extended part and avoid doing anything behind bare minimum
> > in the core part.
> >
> > >
> > > 2. Mempool
> > >
> > > The idea is to preallocate mempool with a given amount of memory for
> > > userspace oom-killer. Preferably this will be per-thread and
> > > oom-killer can preallocate mempool for its specific threads. The core
> > > page allocator can check before going to the reclaim path if the task
> > > has private access to the mempool and return page from it if yes.
> > >
> > > This option would be more complicated than the previous option as the
> > > lifecycle of the page from the mempool would be more sophisticated.
> > > Additionally the current mempool does not handle higher order pages
> > > and we might need to extend it to allow such allocations. Though this
> > > feature might have more use-cases and it would be less risky than the
> > > previous option.
> >
> > It looks like an over-kill for the oom daemon protection, but if there
> > are other good use cases, maybe it's a good feature to have.
> >
> 
> IMHO it is not an over-kill and easier to do then to remove all
> instances of potential blocking/throttling sites in memory reclaim.
> 
> > >
> > > Another idea I had was to use kthread based oom-killer and provide the
> > > policies through eBPF program. Though I am not sure how to make it
> > > monitor arbitrary metrics and if that can be done without any
> > > allocations.
> >
> > To start this effort it would be nice to understand what metrics various
> > oom daemons use and how easy is to gather them from the bpf side. I like
> > this idea long-term, but not sure if it has been settled down enough.
> > I imagine it will require a fair amount of work on the bpf side, so we
> > need a good understanding of features we need.
> >
> 
> Are there any examples of gathering existing metrics from bpf? Suren
> has given a list of metrics useful for Android. Is it possible to
> gather those metrics?

First, I need to admit that I didn't follow the bpf development too close
for last couple of years, so my knowledge can be a bit outdated.

But in general bpf is great when there is a fixed amount of data as input
(e.g. skb) and a fixed output (e.g. drop/pass the packet). There are different
maps which are handy to store some persistent data between calls.

However traversing complex data structures is way more complicated. It's
especially tricky if the data structure is not of a fixed size: bpf programs
have to be deterministic, so there are significant constraints on loops.

Just for example: it's easy to call a bpf program for each task in the system,
provide some stats/access to some fields of struct task and expect it to return
an oom score, which then the kernel will look at to select the victim.
Something like this can be done with cgroups too.

Writing a kthread, which can sleep, poll some data all over the system and
decide what to do (what oomd/... does),  will be really challenging.
And going back, it will not provide any guarantees unless we're not taking
any locks, which is already quite challenging.

Thanks!
