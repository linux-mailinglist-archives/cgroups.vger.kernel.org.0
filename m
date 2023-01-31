Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8941C682B5E
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 12:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjAaLYu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 06:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAaLYn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 06:24:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAD649951;
        Tue, 31 Jan 2023 03:24:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF7GDvvJxNQyAX+7lAnT56UpJo7rw24vW4rHAPsIl3HQ9qJKR6ggP81GU531ZKf7QiooOOVQ9Av76yvbEv2k7fojvN84YcZsyCXerHDdVZwIc7BXibGvp2wgr+ewLHnvezWXue9vSLNl12VN6Z1qjGBLuhfUGzt+jIynlWjC3MOKPhgGDu+S+gDrVkTa9gHfo59/wt9YFuSK6DONQXslAmlJoJYKTR+0LMV/YilYefn+yvoWSxJls0lQotCGQyfqcwoA+LY7U9iBIEHLWOjOb8HY2a6gZ8uzFK8mNLabSw4typ4a+e6H1qfsCVwEiJemwcGgIRcXAPfjzNEuqWx2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeHapgeMSTJHuaCYtM4Ojl2PzuU/BBrQLgS6y/7KXys=;
 b=U3sAmgWAgkXgmvsxdT6U8vVpVj2mFX5D3z33wUla6+bmWGmXvdLAYSy8U0TljptwrT4Dfsoyhul8oFbM1CQM3CtM3cPgSB6lMkcLL1gdX/DG3tI/hJ8hLSvesh1Ov0io/c8sgqCEMycdMqPEHGoZtMiS4PCvXA7wxzvZReuR249tIy044Q4ie/KdyfufFQX8yp2CJXBZYiGDFGoL9SH+A2foF2o6i6Owxnq1aGKCkhCM4I3wzjWqFzYdEzBo3Lfi+m0IRcRzUPSZighvxkWt1wjRMGIxngG0YGfI+qjyMyES9F+OMmK3r+7Dwv2BezibKwmGGSsILa7HTVIjSLiyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeHapgeMSTJHuaCYtM4Ojl2PzuU/BBrQLgS6y/7KXys=;
 b=Kc0lU2ZunmGHh6Os5WENRf2FuB/fDyna6dvjkRBUYycR7UQLvq4eAv7XtEUgCZfGb/yX3P8cH/WoWlIR4zwNwTfleR4895LaQCUatGKoZ73ciEhJhMnqaHU0rJ53/dblGC9O8ojbfEOyluwMguacZvXEYwE7sD4aEiASOYp1jQ/45VjghfSqPYLX8N1up7XmxZgljNXQ3e0NE78f+vbeEYfkA1X7bQT2CwtL1zmA8XqeEfNgi19M2/AyF1MHVxd73fiBYSGW7uGnZTe08l7/jB6ZRkHsUPl4Jwm7rY2GLkJVWMTBwYLbrBhdhSq8Y+euG1OKb48I7Y5Oo3KEblUYOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 11:24:39 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6043.023; Tue, 31 Jan 2023
 11:24:39 +0000
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <CAJD7tkavoSu9WOnw4Nbxz41nq+Rm6Sq5EeOjh3CTyA=AT5=ujg@mail.gmail.com>
 <874js7zf38.fsf@nvidia.com>
 <CAJD7tkZTvXjoNZYC99yekbA0zHkD4iFj0J3+8dsOMht6rxrRcQ@mail.gmail.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch
Subject: Re: [RFC PATCH 00/19] mm: Introduce a cgroup to limit the amount of
 locked and pinned memory
Date:   Tue, 31 Jan 2023 22:22:42 +1100
In-reply-to: <CAJD7tkZTvXjoNZYC99yekbA0zHkD4iFj0J3+8dsOMht6rxrRcQ@mail.gmail.com>
Message-ID: <87r0vblzf3.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0045.ausprd01.prod.outlook.com
 (2603:10c6:10:e::33) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1a380f-6272-4be9-c89b-08db037dbdde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0G/XZdoS58hbK+l/TlvSW2Dpd5pcUxxxJyJoE6ucbEdEUq3WIRxLiaJRP+yGmxeO+s/rvYx1qtUSpd5YU+7yE5/ZCqGlxoQBsZH45GGgji972ugau/mG3JHcRdy2NwAt/jnzghu0s0XicvrN2H6m9ShLLT71u9H8jTM4LhB4n/ypAxImefe9+2iA0nit/gToiWMjhqsfu/JBkOuMMWh58NF7Sqq5iHNj7cvHwG9i5iATlO+vGvSwYN9LMDdxWB+EvxxqFxgjmWQZ09dFv4seUW5TLrtCWvkMXbqxf/qc0WSp0DGeuEF9MSoVeDp0/sPWY+CGDpOT3GwBx8HWlx7J7CEjKibQBrKPWuh12ZHEKLEb5KFNq+/fb1CBFOJAyLmlFhHLvvFm8jINVMIpwSTHeTdjPAA2qZGYiABLbCZTNqmYG5Ji07quVA/nMTyE7AOgIdiDwQ/ep8mG5loyAhI+WdT6ICozK/X1PEMOcKZd7+cV+w3MU0s7o7Ca3PAtlP47Z6HL2FVSA9E+rMFI8t4RNUdew5KUrSXiBPB6YyLZZMp8f5Qk7GNmgsCK3RBYDTUhE21bOO3ASGid34hR5ZoFqpTewZoC+Q/6csg6+q2RMlN+3E26dsuaeU+t7BIZ9uSE1ynXXclG0W+vHf9/0zIt5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199018)(6486002)(478600001)(6666004)(2906002)(86362001)(66946007)(4326008)(186003)(26005)(6512007)(53546011)(6506007)(8676002)(316002)(66899018)(41300700001)(5660300002)(8936002)(66556008)(38100700002)(66476007)(6916009)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zBNujdhKNSIZvp9KH+VZ6kkCkuQujpw0rJs9ob0ojqvn1Nt1exuSxole468l?=
 =?us-ascii?Q?gjz52uSmDq48DppURX3z3KU2dFEj0bcPaOVNYL0vB/x3hZcNWTzGvQ7MzVyY?=
 =?us-ascii?Q?h3YX4X2ofxaaIkQj1tj2Xahpax+S83dmNA29d37m/uom54gPF/nU4WiJqHCU?=
 =?us-ascii?Q?2ByESTeOvsOvynLm/W6pLKndeHNcyuPWCjrp5Ep0rzIqDaT7Lxq+creW0Z+w?=
 =?us-ascii?Q?i1AoiI4LpwKw877T1yw0gaFiOyYHqhNQ1PBlkeHkss+oClkIPrnqL3ptCAW4?=
 =?us-ascii?Q?hjLbYcpQa1NvQrssNt3o5urrjk0PIoWGs7toGHzhVXOCyo7/lrPvWylLjbmW?=
 =?us-ascii?Q?PGjT3aC9Xm2JrNj5hhi/GPfmJmFWltYepQdAADMM5gAiZ0s0NBJU9OKsP+EA?=
 =?us-ascii?Q?0P12g3rEJbwsOUeXm5qyDNf5TRpLuMmxhAdp27SYB8m7Ia5/POxCRWWYERK6?=
 =?us-ascii?Q?+Ccz0gBggptRvY6IxpMNtIpoODvXyHSWYskfFFhgwLqVYxB24Tr1Hn5pGJyT?=
 =?us-ascii?Q?ZqHRONhN45Vr/X82CaOAeRUcSrqN3me3IYIu0M3ivVLrky7Bvmtx8+MyvDkF?=
 =?us-ascii?Q?DoaNUZ+33DpOTmBbrne8b1/TXj+j42Hx8VKYx7duYVYfu69szxJkM0yJOT5C?=
 =?us-ascii?Q?dgWxbx9wcmgx2h5luxPY1I63/E0UI5Ai6BtM8oPJk423HxAsB4YV6BsbGjwU?=
 =?us-ascii?Q?0UxY0SEQEpTmHeoN3bpXjarxQkbxzsqgdHUwpWHoE5wwM/D3FRUu6VwqCNWo?=
 =?us-ascii?Q?J+Qy05GPwj9qrXEw2k2OvpBRMtGZB/nZH/NEdd8Gcpd7yzCynHymOGGwtQyv?=
 =?us-ascii?Q?GVXuNoBHh4NIUXrd2CKmZJ/LqWqiNUBiOwVOJRbq3lIS8UvKXLdcVh6HVzal?=
 =?us-ascii?Q?Pj54tiZr6NgAFfmaborGX1xIaTdDmRPwdb2jvCruEJ+37H94pWG4sXFEsUeY?=
 =?us-ascii?Q?Eq9tLFWVaF8gPdEdaNCEpH5UcTjo8f2aSnYd7ztQ/VTg3EGTQM+X63ab8azY?=
 =?us-ascii?Q?9S0brHehDStgxTVK8kxeFcc3+H1t8F8QWJmF/Bqi880QHxGrYzZaQpmu8lfc?=
 =?us-ascii?Q?QVj1z2nrYZ0bCqiVvIR0oTjsYWAocvUWXkQV5yXFI1ihST6lnbxNOgkauwTo?=
 =?us-ascii?Q?KX/BrsOUQpC5RIPlssCfhmg+fAg2cJvbEdBmqQPZ9biaXbSi0Ek4IAeI0wgd?=
 =?us-ascii?Q?f9VvuiAYfq3bR+GX06ZE76PukDliK4p/NZoqm+Ip4HVhNB+khUXo4vR8IVGe?=
 =?us-ascii?Q?s27qWA9SDMb2AuJgIsuHwNKvXNrIyVsX5nZl9Bilv+sTRWjaccUT5ll0gbk1?=
 =?us-ascii?Q?/IDpLL2+w5hw5gt9qDT2WvGYfCxtjY8LHhmOxfTaeFhpE5Mavkn+0RMk/XSW?=
 =?us-ascii?Q?mCH3W4209xX7jH8TT4YN1FWw7KRhtwJV/Hjm6iSy1FA3ZY6L+ptfFO1lYKxs?=
 =?us-ascii?Q?dtvJsyFmWTrtKaxD/7qBzJTNnDupOL32Ji34IOmdj4FPlb4wZNZowzOvv9JE?=
 =?us-ascii?Q?pj2cPjaaAKqyfNS9bv3Da2V9xlj1KzBMqH8LMNKzPup4cTADc3ugITsa8tBI?=
 =?us-ascii?Q?gTaQg1NUwWCC2KqyYTfm1hANdmDqW4u3gZeSWzL9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1a380f-6272-4be9-c89b-08db037dbdde
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 11:24:39.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9G7VlpP6p70kPJogCFDLtFHB6xlHTSv4EykYqx18gJfsHgEheUkFOvn1PNVweytaiTu8b2Bn82u+hU2EohF1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Yosry Ahmed <yosryahmed@google.com> writes:

> On Mon, Jan 30, 2023 at 5:07 PM Alistair Popple <apopple@nvidia.com> wrote:
>>
>>
>> Yosry Ahmed <yosryahmed@google.com> writes:
>>
>> > On Mon, Jan 23, 2023 at 9:43 PM Alistair Popple <apopple@nvidia.com> wrote:
>> >>
>> >> Having large amounts of unmovable or unreclaimable memory in a system
>> >> can lead to system instability due to increasing the likelihood of
>> >> encountering out-of-memory conditions. Therefore it is desirable to
>> >> limit the amount of memory users can lock or pin.
>> >>
>> >> From userspace such limits can be enforced by setting
>> >> RLIMIT_MEMLOCK. However there is no standard method that drivers and
>> >> other in-kernel users can use to check and enforce this limit.
>> >>
>> >> This has lead to a large number of inconsistencies in how limits are
>> >> enforced. For example some drivers will use mm->locked_mm while others
>> >> will use mm->pinned_mm or user->locked_mm. It is therefore possible to
>> >> have up to three times RLIMIT_MEMLOCKED pinned.
>> >>
>> >> Having pinned memory limited per-task also makes it easy for users to
>> >> exceed the limit. For example drivers that pin memory with
>> >> pin_user_pages() it tends to remain pinned after fork. To deal with
>> >> this and other issues this series introduces a cgroup for tracking and
>> >> limiting the number of pages pinned or locked by tasks in the group.
>> >>
>> >> However the existing behaviour with regards to the rlimit needs to be
>> >> maintained. Therefore the lesser of the two limits is
>> >> enforced. Furthermore having CAP_IPC_LOCK usually bypasses the rlimit,
>> >> but this bypass is not allowed for the cgroup.
>> >>
>> >> The first part of this series converts existing drivers which
>> >> open-code the use of locked_mm/pinned_mm over to a common interface
>> >> which manages the refcounts of the associated task/mm/user
>> >> structs. This ensures accounting of pages is consistent and makes it
>> >> easier to add charging of the cgroup.
>> >>
>> >> The second part of the series adds the cgroup and converts core mm
>> >> code such as mlock over to charging the cgroup before finally
>> >> introducing some selftests.
>> >
>> >
>> > I didn't go through the entire series, so apologies if this was
>> > mentioned somewhere, but do you mind elaborating on why this is added
>> > as a separate cgroup controller rather than an extension of the memory
>> > cgroup controller?
>>
>> One of my early prototypes actually did add this to the memcg
>> controller. However pinned pages fall under their own limit, and we
>> wanted to always account pages to the cgroup of the task using the
>> driver rather than say folio_memcg(). So adding it to memcg didn't seem
>> to have much benefit as we didn't end up using any of the infrastructure
>> provided by memcg. Hence I thought it was clearer to just add it as it's
>> own controller.
>
> To clarify, you account and limit pinned memory based on the cgroup of
> the process pinning the pages, not based on the cgroup that the pages
> are actually charged to? Is my understanding correct?

That's correct.

> IOW, you limit the amount of memory that processes in a cgroup can
> pin, not the amount of memory charged to a cgroup that can be pinned?

Right, that's a good clarification which I might steal and add to the
cover letter.

>>
>>  - Alistair
>>
>> >>
>> >>
>> >> As I don't have access to systems with all the various devices I
>> >> haven't been able to test all driver changes. Any help there would be
>> >> appreciated.
>> >>
>> >> Alistair Popple (19):
>> >>   mm: Introduce vm_account
>> >>   drivers/vhost: Convert to use vm_account
>> >>   drivers/vdpa: Convert vdpa to use the new vm_structure
>> >>   infiniband/umem: Convert to use vm_account
>> >>   RMDA/siw: Convert to use vm_account
>> >>   RDMA/usnic: convert to use vm_account
>> >>   vfio/type1: Charge pinned pages to pinned_vm instead of locked_vm
>> >>   vfio/spapr_tce: Convert accounting to pinned_vm
>> >>   io_uring: convert to use vm_account
>> >>   net: skb: Switch to using vm_account
>> >>   xdp: convert to use vm_account
>> >>   kvm/book3s_64_vio: Convert account_locked_vm() to vm_account_pinned()
>> >>   fpga: dfl: afu: convert to use vm_account
>> >>   mm: Introduce a cgroup for pinned memory
>> >>   mm/util: Extend vm_account to charge pages against the pin cgroup
>> >>   mm/util: Refactor account_locked_vm
>> >>   mm: Convert mmap and mlock to use account_locked_vm
>> >>   mm/mmap: Charge locked memory to pins cgroup
>> >>   selftests/vm: Add pins-cgroup selftest for mlock/mmap
>> >>
>> >>  MAINTAINERS                              |   8 +-
>> >>  arch/powerpc/kvm/book3s_64_vio.c         |  10 +-
>> >>  arch/powerpc/mm/book3s64/iommu_api.c     |  29 +--
>> >>  drivers/fpga/dfl-afu-dma-region.c        |  11 +-
>> >>  drivers/fpga/dfl-afu.h                   |   1 +-
>> >>  drivers/infiniband/core/umem.c           |  16 +-
>> >>  drivers/infiniband/core/umem_odp.c       |   6 +-
>> >>  drivers/infiniband/hw/usnic/usnic_uiom.c |  13 +-
>> >>  drivers/infiniband/hw/usnic/usnic_uiom.h |   1 +-
>> >>  drivers/infiniband/sw/siw/siw.h          |   2 +-
>> >>  drivers/infiniband/sw/siw/siw_mem.c      |  20 +--
>> >>  drivers/infiniband/sw/siw/siw_verbs.c    |  15 +-
>> >>  drivers/vdpa/vdpa_user/vduse_dev.c       |  20 +--
>> >>  drivers/vfio/vfio_iommu_spapr_tce.c      |  15 +-
>> >>  drivers/vfio/vfio_iommu_type1.c          |  59 +----
>> >>  drivers/vhost/vdpa.c                     |   9 +-
>> >>  drivers/vhost/vhost.c                    |   2 +-
>> >>  drivers/vhost/vhost.h                    |   1 +-
>> >>  include/linux/cgroup.h                   |  20 ++-
>> >>  include/linux/cgroup_subsys.h            |   4 +-
>> >>  include/linux/io_uring_types.h           |   3 +-
>> >>  include/linux/kvm_host.h                 |   1 +-
>> >>  include/linux/mm.h                       |   5 +-
>> >>  include/linux/mm_types.h                 |  88 ++++++++-
>> >>  include/linux/skbuff.h                   |   6 +-
>> >>  include/net/sock.h                       |   2 +-
>> >>  include/net/xdp_sock.h                   |   2 +-
>> >>  include/rdma/ib_umem.h                   |   1 +-
>> >>  io_uring/io_uring.c                      |  20 +--
>> >>  io_uring/notif.c                         |   4 +-
>> >>  io_uring/notif.h                         |  10 +-
>> >>  io_uring/rsrc.c                          |  38 +---
>> >>  io_uring/rsrc.h                          |   9 +-
>> >>  mm/Kconfig                               |  11 +-
>> >>  mm/Makefile                              |   1 +-
>> >>  mm/internal.h                            |   2 +-
>> >>  mm/mlock.c                               |  76 +------
>> >>  mm/mmap.c                                |  76 +++----
>> >>  mm/mremap.c                              |  54 +++--
>> >>  mm/pins_cgroup.c                         | 273 ++++++++++++++++++++++++-
>> >>  mm/secretmem.c                           |   6 +-
>> >>  mm/util.c                                | 196 +++++++++++++++--
>> >>  net/core/skbuff.c                        |  47 +---
>> >>  net/rds/message.c                        |   9 +-
>> >>  net/xdp/xdp_umem.c                       |  38 +--
>> >>  tools/testing/selftests/vm/Makefile      |   1 +-
>> >>  tools/testing/selftests/vm/pins-cgroup.c | 271 ++++++++++++++++++++++++-
>> >>  virt/kvm/kvm_main.c                      |   3 +-
>> >>  48 files changed, 1114 insertions(+), 401 deletions(-)
>> >>  create mode 100644 mm/pins_cgroup.c
>> >>  create mode 100644 tools/testing/selftests/vm/pins-cgroup.c
>> >>
>> >> base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
>> >> --
>> >> git-series 0.9.1
>> >>
>>

