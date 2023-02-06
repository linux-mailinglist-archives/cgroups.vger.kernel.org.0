Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2154E68B6A1
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 08:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBFHsU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 02:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjBFHsT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 02:48:19 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C393125BF;
        Sun,  5 Feb 2023 23:48:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE0Ro4NtAGTsf60iXFNi7jGJX+F1y4ZB+G6rj4c9YWaL7RDK28mCwA3mYBssbckHVfRIz8al7+WjyTb6YBrd2RKOBFeASiND6jnUd0E0EJlT4tGiOv8MTKdbjFGugK+uCxZjB6YfFarDyFU5c/8B+8XEJbEhUgs0o6sVsv6E0JgqWLS66RZml2q6sFFgavv4Pk4Uu36X/CsM7O1NdgUd9VPIOJqeqKb1gHMerxGaBKW659wZkFItV5NGEOatFpBp8yM0bbAgfmkyGpoGrdH4waJXISshuK5aMLqGyDWzgiXd/vfl0HlLc/3p25c0xWdT8veGbq3yufukLYa2vQYfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEFLPj2bWgoScYUqwTVgfs3MlEN9Gob9d5vdVik3qT8=;
 b=Bzt9kXJU0IjDqkqJ6fWQsOwKAzPFnW8um3FuaVwt4ZBMYBJ47NEjjaNUz/9lKw7/Gl6CJ0OLL+JCB8avq58RDsoaw4a5PXNimlNiTTZTNugbb262eukeXEEAWxzkTJHyu2AtPLEP37HFUnRB05OsqmzJZPbBAdJUXV3N8PD9JBeYBo7/aGsjZXrecKscLiS7d4iCUxUNR9Bey/hWNNOTiO8iRYTHePFF8rABog7lS6SwiXjyneMh/0TCYej7Y1LNCroORtmBbn6BlnIDXaBQsMg2WF/iQJQT1Ejqe4Ap1kWQ8nRPZa7RQJUi6M3WK62xCytEKEUrYG2YD93HqXtWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEFLPj2bWgoScYUqwTVgfs3MlEN9Gob9d5vdVik3qT8=;
 b=ITF7ucOHy201DRpcx8D3LlPeKtQ9PSMyM/7kCv4yGRH9jCOXLK+V0QxgavTbeCY0yUY+BENrsaIercU61Kmo+EwMQtRGzqw80uiUJfJ4qe1nmOr5IBHUEVobtDfxPoGddK6u/Rx05Nx1Oqxr5oslrciKTkrEmTa3ZYuXiIKZgCYBhzoGxwmz4qi/YH3h/P9tcZIgpuidtXMzZC4a8ZzxY5gEYLQT8D348lwB584yoawVKUMBW3XrPMb6AkHsHpyda3mcVZB2y+qcH2Uq0C9LSfeW3JcYJFbVNFo1eCYsKdiz3SsW6ecZ0Yic7AOjm2HJVb8v+Fh2qR628x63kHdiEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:63::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 07:48:14 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 07:48:14 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 00/19] mm: Introduce a cgroup to limit the amount of locked and pinned memory
Date:   Mon,  6 Feb 2023 18:47:37 +1100
Message-Id: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0093.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::26) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2b1542-16b2-4347-c077-08db081680c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uijvKD4DZbDEZlrLZoUxB4Zq/I/cw5O5RzU924lMtJkE5dx5K3GeKuXhBNQJEyR9wiKe5xqUwOGf/NUVIyI9d59b0f8Y8dtn8/rQvmtmMaAKVfsf3BjzECdtECL9SNF/C6GODgUzZl9RMENi8UqcyLDJco3VLozh0LPWlx3WB222I2dAfXggHcXnO2+uJl3UWBspHuxzHxVRoLGUomppQkKW3veB6xxBjr5lRc7ATJODJXFz+qP0Zw5c2Pk4hibs/sMRo98wyxn4sS9ioiYpwF4vb5Hs1SOPDj+bf+Z+5wsq42Xu1SjtYBiAWwOYiK9D1kiSInMDUVZsA7sYyyQ32PcbQl+5oep/clVP7D17qPTR71yVdGGWIfAfMVpViTKcoJdd3iMY4pgZh+QQ3FDaSFu5PObfDEJmMIm0hR2xM7XGNTBwoyX+1qTkcIpP1OK22jSPPc1enld9rt7zyFGAHIQbWWhXiRUexHt2OqrM46bkN2pWwyNMAHpe1wH01VXGVH5293JJ9ly1NfBi6SQwVFTdGfS7TW7zZhdcgJKTRk1c0CZ4LTT5rUw5PyMtblsr4uV4pRSpGqdzLW4rgVpd1szKM/TXZXmYLkPZb8a5fvRWa9S9aW6eYlPRbrHAaya83BbMaa7YSKbF35KYq6OagUXMwUw6+3nKSLemsZyLd4yLj9bjDo0nXe3JFCliGZzQjPy7VGDpaYybvTBqdXFwlq8c3/R8sHgR3mc75rseraY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199018)(38100700002)(36756003)(966005)(6506007)(6666004)(6512007)(107886003)(26005)(186003)(478600001)(86362001)(6486002)(8676002)(66476007)(83380400001)(66946007)(2616005)(66556008)(4326008)(66899018)(316002)(54906003)(7416002)(2906002)(8936002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2JOTz2S9XeuBNr1Ngv1Xezoohsy9vLYgx7iUPzZPxfX2elXEFgzp4YEP7IzZ?=
 =?us-ascii?Q?g12sswETfkS1N/hvjXs3S0qPWkLuna6f4N2fkSK3Oxsc3btR1cfNuIiH1K/g?=
 =?us-ascii?Q?CTZBYBWOY+Beq1ff/dYmgIhOhra0xBHDn0h/JZ7me959PW7Y/Bd39bpgtmvS?=
 =?us-ascii?Q?8aBBYu28gzWGIaP5d0ktRPXiki06b8zk7hdOQAShPWQ2yzStVHHV44y5y58t?=
 =?us-ascii?Q?huV//nLnXi0zQLIKcD1zAB8A2htSP3IXWb5RMcpBvDMTnYJGJGoowZWKtaBe?=
 =?us-ascii?Q?OaEst31MHFwX2lL+L9tcs8agGGqJTBxcpOATPChcnxXLKoLb0HEC4+3jwsUD?=
 =?us-ascii?Q?g29NTti2Be+1ZNiMSgY8NTvZju12047GenLw0aIikrkUfHD8mYKTQSr7TrX5?=
 =?us-ascii?Q?lF2HROOsaxgvf1CntJOY1kDgWfKIZd9uBy0a28bV1faMtKl9DWwAZb1eNfKP?=
 =?us-ascii?Q?WShwVHnWTZ3km95iS/YxmKswAzkOwjK/gPuqZRXVr6blE/RTKGYTN9CPa2Xu?=
 =?us-ascii?Q?5/5WYxHozHMHEcp/7WuNTzQak1mdraqeLDeeyEzGm+FL38sxsUm/hKAwTfUw?=
 =?us-ascii?Q?tpb/u9yVtcyLmEC3TvBzov1KFk9VGOiPXYbwMjudNH8XyDGJjF65R9MT03bm?=
 =?us-ascii?Q?fIy923OjOxoyAQtdfajaMvqiG2uKgQ0GIwjNA2MDxJKpQSgloRku7x14ypki?=
 =?us-ascii?Q?jdRNlXypGnSdmoRIn35gg6RP8sxEjUrh/ITvsoIyUW0GHEfLIUxh+rctcBle?=
 =?us-ascii?Q?dCJjef9q5gr62R1CtogsYMSV++8pfzDv3hRr7hV3QZr9PsoTfZ2rZW8kRE4/?=
 =?us-ascii?Q?0IcBQDEbNGbx2whnJoWK98XAPHClK7Wm+7Dr7h+7LCygyLFKpEryJNOG5bBa?=
 =?us-ascii?Q?kmOuUnORyb6gDX9HpasPGIimV+h9hgUhR9nH1A+uxFUeogNGQY52Fx5DNHFI?=
 =?us-ascii?Q?gu4Ql/Jpq7hZ4HRyjNolZGgqD99+jhi5IE11FsiqjOXMIFp/158wHz8G5hCP?=
 =?us-ascii?Q?mn42I7nqRmPdmj/7uqB5j4KRmo6oAuqiEfUJGvUbzaKVIYBxH+PkpbwY5D1m?=
 =?us-ascii?Q?Vpoy1snY+ZgELHaMVgBsuPPZrsyorvyg6oWkaNF7A0qTj94O1HbZraoObZuI?=
 =?us-ascii?Q?z49OGC9wx23s7GXfB0jFVPG/zxEhCwZXuagXJ5o7bP9wv1+V65aq7V9TLDxx?=
 =?us-ascii?Q?2chZ1upp+xLmzgxLKMwq00R/lDNMJpe50IIQXn/VowVtf/pul45oEIY4c0C/?=
 =?us-ascii?Q?UGvPnRpK2Sq30dsN1GlkahkbsCHcXObVxmbkt4XPpR5Spkqio9cHm76dMC4l?=
 =?us-ascii?Q?ayBgn806x1FX/9cqmZb5qUGQwQKx8Jtymj0IA4SnKmtmO12SmokxwnoCfcJL?=
 =?us-ascii?Q?aQbsmg5GjI7Z/XMdw/VGhC0hFC4ehryNDrDQAs5nu/9DHMBjOPw5EZsxdZ/K?=
 =?us-ascii?Q?JGSMXO98eG1lU5a2pAeSk4LIVmESEmxhVUnrou4FL2KRZ9KWLOlPdbTg8ZyJ?=
 =?us-ascii?Q?zdom3BY2JenYnUabNZRj5PpU287TlmzuXXKPs5W8iRHUMlJuE9kl35IcxURQ?=
 =?us-ascii?Q?2K7KD+H8KepteNYOsCbhO/6qhnjIujLys8E/c+nE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2b1542-16b2-4347-c077-08db081680c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:48:14.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IrBqVVG9cUdx02dLYasiMlsarP8bApYffy2P8M8qHHPyzkj3/s80uOmFfh/49m1Z9RclAAxIwNDRtkL0YXhHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Having large amounts of unmovable or unreclaimable memory in a system
can lead to system instability due to increasing the likelihood of
encountering out-of-memory conditions. Therefore it is desirable to
limit the amount of memory users can lock or pin.

From userspace such limits can be enforced by setting
RLIMIT_MEMLOCK. However there is no standard method that drivers and
other in-kernel users can use to check and enforce this limit.

This has lead to a large number of inconsistencies in how limits are
enforced. For example some drivers will use mm->locked_mm while others
will use mm->pinned_mm or user->locked_mm. It is therefore possible to
have up to three times RLIMIT_MEMLOCKED pinned.

Having pinned memory limited per-task also makes it easy for users to
exceed the limit. For example drivers that pin memory with
pin_user_pages() it tends to remain pinned after fork. To deal with
this and other issues this series introduces a cgroup for tracking and
limiting the number of pages pinned or locked by tasks in the group.

However the existing behaviour with regards to the rlimit needs to be
maintained. Therefore the lesser of the two limits is
enforced. Furthermore having CAP_IPC_LOCK usually bypasses the rlimit,
but this bypass is not allowed for the cgroup.

The first part of this series converts existing drivers which
open-code the use of locked_mm/pinned_mm over to a common interface
which manages the refcounts of the associated task/mm/user
structs. This ensures accounting of pages is consistent and makes it
easier to add charging of the cgroup.

The second part of the series adds the cgroup controller and converts
core mm code such as mlock over to charging the cgroup before finally
introducing some selftests.

Rather than adding onto an exisiting cgroup controller such as memcg
we introduce a new controller. This is primarily because we wish to
limit the total number of pages tasks within a cgroup may pin/lock.

As I don't have access to systems with all the various devices I
haven't been able to test all driver changes. Any help there would be
appreciated.

Note that this series is based on v6.2-rc5 and
https://lore.kernel.org/linux-rdma/20230201115540.360353-1-bmt@zurich.ibm.com/
which makes updating the siw driver easier (thanks Bernard).

Changes from initial RFC:

 - Fixes to some driver error handling.

 - Pages charged with vm_account will always increment mm->pinned_vm
   and enforce the limit against user->locked_vm or mm->pinned_vm
   depending on initialisation flags.

 - Moved vm_account prototypes and struct definitions into a separate header.

 - Minor updates to commit messages and kernel docs (thanks to Jason,
   Christoph, Yosry and T.J.).

Outstanding issues:

 - David H pointed out that the vm_account naming is potentially
   confusing and I agree. However I have yet to come up with something
   better so will rename this in a subsequent version of this series
   (suggestions welcome).

 - Jason G raised some issues with adding the accounting struct to
   struct sock which are unresolved.

Alistair Popple (19):
  mm: Introduce vm_account
  drivers/vhost: Convert to use vm_account
  drivers/vdpa: Convert vdpa to use the new vm_structure
  infiniband/umem: Convert to use vm_account
  RMDA/siw: Convert to use vm_account
  RDMA/usnic: convert to use vm_account
  vfio/type1: Charge pinned pages to pinned_vm instead of locked_vm
  vfio/spapr_tce: Convert accounting to pinned_vm
  io_uring: convert to use vm_account
  net: skb: Switch to using vm_account
  xdp: convert to use vm_account
  kvm/book3s_64_vio: Convert account_locked_vm() to vm_account_pinned()
  fpga: dfl: afu: convert to use vm_account
  mm: Introduce a cgroup for pinned memory
  mm/util: Extend vm_account to charge pages against the pin cgroup
  mm/util: Refactor account_locked_vm
  mm: Convert mmap and mlock to use account_locked_vm
  mm/mmap: Charge locked memory to pins cgroup
  selftests/vm: Add pins-cgroup selftest for mlock/mmap

 MAINTAINERS                              |   8 +-
 arch/powerpc/kvm/book3s_64_vio.c         |  10 +-
 arch/powerpc/mm/book3s64/iommu_api.c     |  30 +--
 drivers/fpga/dfl-afu-dma-region.c        |  11 +-
 drivers/fpga/dfl-afu.h                   |   2 +-
 drivers/infiniband/core/umem.c           |  16 +-
 drivers/infiniband/core/umem_odp.c       |   6 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c |  14 +-
 drivers/infiniband/hw/usnic/usnic_uiom.h |   2 +-
 drivers/infiniband/sw/siw/siw.h          |   3 +-
 drivers/infiniband/sw/siw/siw_mem.c      |  21 +--
 drivers/infiniband/sw/siw/siw_verbs.c    |  15 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  21 +--
 drivers/vfio/vfio_iommu_spapr_tce.c      |  16 +-
 drivers/vfio/vfio_iommu_type1.c          |  60 +----
 drivers/vhost/vdpa.c                     |  17 +-
 drivers/vhost/vhost.c                    |   2 +-
 drivers/vhost/vhost.h                    |   2 +-
 include/linux/cgroup.h                   |  20 ++-
 include/linux/cgroup_subsys.h            |   4 +-
 include/linux/io_uring_types.h           |   4 +-
 include/linux/kvm_host.h                 |   2 +-
 include/linux/mm.h                       |   5 +-
 include/linux/skbuff.h                   |   7 +-
 include/linux/vm_account.h               |  57 +++++-
 include/net/sock.h                       |   3 +-
 include/net/xdp_sock.h                   |   3 +-
 include/rdma/ib_umem.h                   |   2 +-
 io_uring/io_uring.c                      |  20 +--
 io_uring/notif.c                         |   4 +-
 io_uring/notif.h                         |  10 +-
 io_uring/rsrc.c                          |  38 +---
 io_uring/rsrc.h                          |   9 +-
 mm/Kconfig                               |  11 +-
 mm/Makefile                              |   1 +-
 mm/internal.h                            |   2 +-
 mm/mlock.c                               |  76 +------
 mm/mmap.c                                |  76 +++----
 mm/mremap.c                              |  54 +++--
 mm/pins_cgroup.c                         | 273 ++++++++++++++++++++++++-
 mm/secretmem.c                           |   6 +-
 mm/util.c                                | 234 +++++++++++++++++++--
 net/core/skbuff.c                        |  47 +---
 net/rds/message.c                        |  10 +-
 net/xdp/xdp_umem.c                       |  38 +--
 tools/testing/selftests/vm/Makefile      |   1 +-
 tools/testing/selftests/vm/pins-cgroup.c | 271 ++++++++++++++++++++++++-
 virt/kvm/kvm_main.c                      |   3 +-
 48 files changed, 1143 insertions(+), 404 deletions(-)
 create mode 100644 include/linux/vm_account.h
 create mode 100644 mm/pins_cgroup.c
 create mode 100644 tools/testing/selftests/vm/pins-cgroup.c

base-commit: f0076df3552b965d8107318bd9d9e678530f1687
-- 
git-series 0.9.1
