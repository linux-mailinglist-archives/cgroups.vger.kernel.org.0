Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C921682146
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 02:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjAaBHv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Jan 2023 20:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjAaBHu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Jan 2023 20:07:50 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5E2FCE0;
        Mon, 30 Jan 2023 17:07:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAe55TfF37jgIdmQ5XgOp9qGo6DxNZNpQr1vjg5aCNkQT/GnOxX1uTnnycD3oZm4mh2Wx8Erxzbo/eU6+YrmgdjSMEK9wSoYGTz4tz+WXUFJ2iSi+uDR8cOPutnnkQ10lU0PFCIqI88y9RKaUNsOIFezPnAAlXmUyug2XurcNvnjSSr44eb/58bB0KKvEoo8YS+SwVxMEu8A4oRIgois7qp3o8hUKs/n5fo3QxzM0qQ8Ev2JGk0865CtC3NLN4O/hLXQcDvyW1jERrfRc5SHJjSwhefu3ueH+zyRyUbnmSd8h7VjuocuTPh6qT4DgHi4qdP5K6Ew2Ao/s4kIOfp4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFQT3Xs8fBf2yGNhs7PKtR1XTGYn+5x6UNzKWleM/NE=;
 b=STGgQVJp5LkHqP8ILc8YdSYKGXUvY9R2mG9csA/n1qWhJvlaCIydkSQpjyX/GtcNKrx1tibVsCqLP8cmCaDwQ4EV8MuurOhIHPgDnuJg5uK6R0FQcQGdBOonTNqNhs0SkX33oA3PI3/XF1juKB5lhWA8AJHb48wTbunULrmgq1Vr2WeU3582GDpc2tFv3LBG93/YUuP+IOcEyE6KVZArThBY1LS8xist4+foYocAqA3ZjoRO9Mjl8Pv/HrLaaNPvg2Hz6arG10G/auOfXjaPmcpPt2kt1p9ehu+PLqjpmIrdHkSHPIpIlD7FqsTZdIpU+SIggwH2a6tdZvH6Hkt+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFQT3Xs8fBf2yGNhs7PKtR1XTGYn+5x6UNzKWleM/NE=;
 b=T4xvYqqlvPzECmI38uGp92YufClakDo1o1PhLBHUN/1iObQInUA8J13XC13DH2iNLLS8q+nwehFPo1Vku0LKOslDNPBAfcTbJ14Pf7sym40+8IOkyEd29+GCM3z+Ukr54v/m8Zs3LGa0UrNW4yPHTIR5XdWGUFNELVxud94WUM7by2plsIXwzaGC4eaAc6Cg/o71LcNmyUayaOLtwuPASeIaRiLnYwkSlFQPCxmk5CChxKCd5GwZHqHjXK5BRKg5DaSWqH5y819olWmoPyhaCRv3ddZ6+JDmYSrvlfJgXmzRRfWtnHUI3SmmyQBv0xZ6ldczteDSYJTe7UOBbFH9PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Tue, 31 Jan
 2023 01:07:46 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6043.023; Tue, 31 Jan 2023
 01:07:46 +0000
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <CAJD7tkavoSu9WOnw4Nbxz41nq+Rm6Sq5EeOjh3CTyA=AT5=ujg@mail.gmail.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch
Subject: Re: [RFC PATCH 00/19] mm: Introduce a cgroup to limit the amount of
 locked and pinned memory
Date:   Tue, 31 Jan 2023 11:54:20 +1100
In-reply-to: <CAJD7tkavoSu9WOnw4Nbxz41nq+Rm6Sq5EeOjh3CTyA=AT5=ujg@mail.gmail.com>
Message-ID: <874js7zf38.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0009.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: a22e79bf-e0c5-4784-1d0f-08db03279032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMas+zb7dQgG/1XNlaaSX9NtkxESyA+oFhnyo/HgiczaUusvvNKzrUNtdR/03B7KjCApi6yTiP5WbGYR3S5lVsCqg2uVarhwASetn0z8mhX4CiIDAZhPAmL4rfnAzUMcwTborNvluzVju8IhJwp11V+kDukpM677E9ziQtChB/ycJHkashvz932vk9yjc8Wsx6e18rg4ed6l1Ui7Z++aoHOilbHnYjHZasFAomK7POi3fSBH33CbO7rsPF9fyyirvuYpYH0BUzD5ClRCfvqhMfcNZom+xl9NvZeSaT2s6XxbSti+4i0ZPFItYRUz9lgu7f6ABrliGtztsUBI+u5b1jaCxDw9PSSHiWlzgzHtiWHP+JgrvGM+FwDzLI3cbkph+mmSEXMyniI5OnFZiuOdYLhYFk8qKVChnlNIO72W6WUA6BB/EApHZfLdApMoBos0PP/7qPPq8BFApwA1iokblyKPLMWcJx3lCLyVC/ANKHjaIrnvMZlAp+qC0gk5vtW8MwSMhlHSuefmCocj5m0fYlczku3bSz+it4nYORRcs22D4Cb6dg2rTkbx90IwAWHAEPMSLuveOD/D+msFKA9357cw/P2DcpUYZoc3tlMlaHVwqgLPlcoKI0pGYH1BzQxSWpgAHDBBlRZ6V50H4PRn9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199018)(5660300002)(41300700001)(316002)(2906002)(8936002)(66899018)(66556008)(6486002)(6916009)(4326008)(26005)(66946007)(6666004)(478600001)(6512007)(186003)(6506007)(66476007)(53546011)(2616005)(83380400001)(38100700002)(8676002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EnbMGtXoDIekVZ2LCTT2Q8GOmMTeBbQpNOmfWyO9gC7BD0IMBe95eNIO9LNt?=
 =?us-ascii?Q?4qt/armT9c3VyA4H2cR4Buk0i9nvXUToqsni6ySt+L/6SNyNbyZpavEa8nHm?=
 =?us-ascii?Q?eKAsylH+tCcWKmhPPnzskGat3gFJdy/HEAbRTuCbmZtTU2r5YULuJOX1HfAg?=
 =?us-ascii?Q?5S2PwQEFXe+xnAA9Tl/AcT3mINUFIMcsxv8KEdFbnL5LHNepCDO/W+wEi7bs?=
 =?us-ascii?Q?NddCD5CqTFAvmLlR/E/47CXkBEI54SYMIoMBN/4XJVFeFJlPu8qHSsbkhonG?=
 =?us-ascii?Q?yusYVHqRGqAL2ZpRyOjjua9D/u8u4FJtKh2Su/86AgaJg7PcrC0sJ7qKsbez?=
 =?us-ascii?Q?04YmsOVziRsf5s4CcQ5ZOIbjn+9i5o0zxsp67w/aOpsPNRLaACaATRf73pIT?=
 =?us-ascii?Q?I+gOwbZvyEFJPNtt6XJolTkfFa8u9a7fxXTXhNkk7AlCzHaF/3VlwCFj2Wl1?=
 =?us-ascii?Q?XcsrZbHsC75Ey6HqNMhn16MWN9mBab3GPLgTJhhV5Lwd0UwjhnBsUS8ZgX8x?=
 =?us-ascii?Q?T/ixWokiN1w7wUfnwn7Nx7MhM9Q5Uog442IMmeI/AiuJLASmPoVfuuIIKA4O?=
 =?us-ascii?Q?y3QspMZenlKgEwaNNT69QrqVqo8WlMImWzBYqYugUqiXIgdBhxh2sA2wxFTP?=
 =?us-ascii?Q?PFtXxIwet3Hrpr+PrzLSOpoeNhVjwLG1bQGnK/3XJNTAzY8tLP+Kr4bB8ic/?=
 =?us-ascii?Q?b0JWPlrmrfkLk4w0ueYA9ZTOPt80QACX5shuXr183+kkRw1GvyQKZ/pYkKpB?=
 =?us-ascii?Q?eTJAsT2YjOoYDo8m7Axz5xelItVJUGdIvcGI2XiExNP3yZ7KtZU8VzVKMgxr?=
 =?us-ascii?Q?GcGFy54jLKZBRl0xSfMnrDO7yH+GIDDwnw0gqYToSUHE+UhsmCWBYYTz81G2?=
 =?us-ascii?Q?X/dIKpyoeuGB2UtHEZjKsvY6t+Ek3zomiombC5sFPr1jxQnhe7+op1RNeu3q?=
 =?us-ascii?Q?sxco6i1T3iHisu3tvPXYGP1bSPyH+tgFmqYfOwClKgPmg4pd0guUbt03Xfax?=
 =?us-ascii?Q?/Ww5i9vYIfRfkBtxONK+iqbKfw9ZJUfNoR5Ut6Xpp/eDiyHex+ecaILus1C2?=
 =?us-ascii?Q?iyE1BWJ5tZhGniAl47R0eyRRY2Jk5UUZWpWCUFyHKhdjTMetJ52APBYqor9P?=
 =?us-ascii?Q?mxwHNghHxFmvo7NHKOg0Lfo/SQs/D9GG+UKiNGl8263zK77RmbltVpotL0t5?=
 =?us-ascii?Q?bkkPe+mVkbxcHEdGEydNLD4RXPpj3leGmLGAFha6G34yhvm/RS5wn7/8D1vX?=
 =?us-ascii?Q?+Jk9nvwBSo2I/fsG+VquO44M6rOhuNs6vSCDJID3x/ErsbYtfwhceJWmv4Cq?=
 =?us-ascii?Q?GrlXBz3v7lzogjT7sDW8SU9yhftwXXB4LjSbJGmmwjnE3qINREh/vFcbC/GZ?=
 =?us-ascii?Q?41nwoU0eglRZX2KLeuB+votK+74RbolGE36kBszVZ+vTD2LiHkHeDPzpN4Cl?=
 =?us-ascii?Q?/vGQy/1yPQw9EO/Bqkv0cdjFiRMS/OoeTsIzxuIcO1F3K0cJA4vnzyM+1b9W?=
 =?us-ascii?Q?5RALouBkYFnmXTAEuDKqtkykXm6GwdjTjR81MgRcjFvMenDCNE96Fa/ITjcL?=
 =?us-ascii?Q?nsbj6dPmiO+arjVu2ZAbpXtsrdPnH/aw42n9IDOv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22e79bf-e0c5-4784-1d0f-08db03279032
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 01:07:46.2897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vlda9n3Mx6W8U4ZR95Bm6vrFnCoMuqf4yAn/ZdOMp2t0nYlY+pxt3ruNAPTrmLGj0p/TBkdbwGjDoQO9nXvTLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
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

> On Mon, Jan 23, 2023 at 9:43 PM Alistair Popple <apopple@nvidia.com> wrote:
>>
>> Having large amounts of unmovable or unreclaimable memory in a system
>> can lead to system instability due to increasing the likelihood of
>> encountering out-of-memory conditions. Therefore it is desirable to
>> limit the amount of memory users can lock or pin.
>>
>> From userspace such limits can be enforced by setting
>> RLIMIT_MEMLOCK. However there is no standard method that drivers and
>> other in-kernel users can use to check and enforce this limit.
>>
>> This has lead to a large number of inconsistencies in how limits are
>> enforced. For example some drivers will use mm->locked_mm while others
>> will use mm->pinned_mm or user->locked_mm. It is therefore possible to
>> have up to three times RLIMIT_MEMLOCKED pinned.
>>
>> Having pinned memory limited per-task also makes it easy for users to
>> exceed the limit. For example drivers that pin memory with
>> pin_user_pages() it tends to remain pinned after fork. To deal with
>> this and other issues this series introduces a cgroup for tracking and
>> limiting the number of pages pinned or locked by tasks in the group.
>>
>> However the existing behaviour with regards to the rlimit needs to be
>> maintained. Therefore the lesser of the two limits is
>> enforced. Furthermore having CAP_IPC_LOCK usually bypasses the rlimit,
>> but this bypass is not allowed for the cgroup.
>>
>> The first part of this series converts existing drivers which
>> open-code the use of locked_mm/pinned_mm over to a common interface
>> which manages the refcounts of the associated task/mm/user
>> structs. This ensures accounting of pages is consistent and makes it
>> easier to add charging of the cgroup.
>>
>> The second part of the series adds the cgroup and converts core mm
>> code such as mlock over to charging the cgroup before finally
>> introducing some selftests.
>
>
> I didn't go through the entire series, so apologies if this was
> mentioned somewhere, but do you mind elaborating on why this is added
> as a separate cgroup controller rather than an extension of the memory
> cgroup controller?

One of my early prototypes actually did add this to the memcg
controller. However pinned pages fall under their own limit, and we
wanted to always account pages to the cgroup of the task using the
driver rather than say folio_memcg(). So adding it to memcg didn't seem
to have much benefit as we didn't end up using any of the infrastructure
provided by memcg. Hence I thought it was clearer to just add it as it's
own controller.

 - Alistair
 
>>
>>
>> As I don't have access to systems with all the various devices I
>> haven't been able to test all driver changes. Any help there would be
>> appreciated.
>>
>> Alistair Popple (19):
>>   mm: Introduce vm_account
>>   drivers/vhost: Convert to use vm_account
>>   drivers/vdpa: Convert vdpa to use the new vm_structure
>>   infiniband/umem: Convert to use vm_account
>>   RMDA/siw: Convert to use vm_account
>>   RDMA/usnic: convert to use vm_account
>>   vfio/type1: Charge pinned pages to pinned_vm instead of locked_vm
>>   vfio/spapr_tce: Convert accounting to pinned_vm
>>   io_uring: convert to use vm_account
>>   net: skb: Switch to using vm_account
>>   xdp: convert to use vm_account
>>   kvm/book3s_64_vio: Convert account_locked_vm() to vm_account_pinned()
>>   fpga: dfl: afu: convert to use vm_account
>>   mm: Introduce a cgroup for pinned memory
>>   mm/util: Extend vm_account to charge pages against the pin cgroup
>>   mm/util: Refactor account_locked_vm
>>   mm: Convert mmap and mlock to use account_locked_vm
>>   mm/mmap: Charge locked memory to pins cgroup
>>   selftests/vm: Add pins-cgroup selftest for mlock/mmap
>>
>>  MAINTAINERS                              |   8 +-
>>  arch/powerpc/kvm/book3s_64_vio.c         |  10 +-
>>  arch/powerpc/mm/book3s64/iommu_api.c     |  29 +--
>>  drivers/fpga/dfl-afu-dma-region.c        |  11 +-
>>  drivers/fpga/dfl-afu.h                   |   1 +-
>>  drivers/infiniband/core/umem.c           |  16 +-
>>  drivers/infiniband/core/umem_odp.c       |   6 +-
>>  drivers/infiniband/hw/usnic/usnic_uiom.c |  13 +-
>>  drivers/infiniband/hw/usnic/usnic_uiom.h |   1 +-
>>  drivers/infiniband/sw/siw/siw.h          |   2 +-
>>  drivers/infiniband/sw/siw/siw_mem.c      |  20 +--
>>  drivers/infiniband/sw/siw/siw_verbs.c    |  15 +-
>>  drivers/vdpa/vdpa_user/vduse_dev.c       |  20 +--
>>  drivers/vfio/vfio_iommu_spapr_tce.c      |  15 +-
>>  drivers/vfio/vfio_iommu_type1.c          |  59 +----
>>  drivers/vhost/vdpa.c                     |   9 +-
>>  drivers/vhost/vhost.c                    |   2 +-
>>  drivers/vhost/vhost.h                    |   1 +-
>>  include/linux/cgroup.h                   |  20 ++-
>>  include/linux/cgroup_subsys.h            |   4 +-
>>  include/linux/io_uring_types.h           |   3 +-
>>  include/linux/kvm_host.h                 |   1 +-
>>  include/linux/mm.h                       |   5 +-
>>  include/linux/mm_types.h                 |  88 ++++++++-
>>  include/linux/skbuff.h                   |   6 +-
>>  include/net/sock.h                       |   2 +-
>>  include/net/xdp_sock.h                   |   2 +-
>>  include/rdma/ib_umem.h                   |   1 +-
>>  io_uring/io_uring.c                      |  20 +--
>>  io_uring/notif.c                         |   4 +-
>>  io_uring/notif.h                         |  10 +-
>>  io_uring/rsrc.c                          |  38 +---
>>  io_uring/rsrc.h                          |   9 +-
>>  mm/Kconfig                               |  11 +-
>>  mm/Makefile                              |   1 +-
>>  mm/internal.h                            |   2 +-
>>  mm/mlock.c                               |  76 +------
>>  mm/mmap.c                                |  76 +++----
>>  mm/mremap.c                              |  54 +++--
>>  mm/pins_cgroup.c                         | 273 ++++++++++++++++++++++++-
>>  mm/secretmem.c                           |   6 +-
>>  mm/util.c                                | 196 +++++++++++++++--
>>  net/core/skbuff.c                        |  47 +---
>>  net/rds/message.c                        |   9 +-
>>  net/xdp/xdp_umem.c                       |  38 +--
>>  tools/testing/selftests/vm/Makefile      |   1 +-
>>  tools/testing/selftests/vm/pins-cgroup.c | 271 ++++++++++++++++++++++++-
>>  virt/kvm/kvm_main.c                      |   3 +-
>>  48 files changed, 1114 insertions(+), 401 deletions(-)
>>  create mode 100644 mm/pins_cgroup.c
>>  create mode 100644 tools/testing/selftests/vm/pins-cgroup.c
>>
>> base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
>> --
>> git-series 0.9.1
>>

