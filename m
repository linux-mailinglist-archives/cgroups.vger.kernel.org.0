Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B5267900E
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 06:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjAXFn1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 00:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAXFn0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 00:43:26 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E163346C;
        Mon, 23 Jan 2023 21:43:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYPC4PFWGum7hZxHsFml+MGgzA1i7RUxDVzTfLcAuSwMsI6iSU3zBCJx1w3I+t5hLLz9N71AiXSIeqsGwl0+wxkM1agF5n784GHfiZeTeDyaK3qhCy/hR/OKZvunb3m7rJ+SW/eTgrixIPLlSec1yDikB2ZMbce3NxtQUG+vQNnIUMTHlKWswMZ1LgwZAWEts3pk690q+FFC7QYDMVlMrCc3sntoKq9zQ1Lpok/rfyykKvMxPrQp/rXonaPeO24oH9gItYDMvkRRKMVsJUter0t47LN2Jtj763zIe44n81LnFRC7mrcpMwJ0TJD7Ld4qFpXsOPGokU33xQfrZh5hIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjiFpve7UU1PFy62Cv9loVcC9ZrCHwMjfsJQ2a58EO0=;
 b=CS6sLVQdgJi/r/VkyNgwSI4xygj6n29RG4BjkRxJeiOQ97l4JBytPWev+Cs5evlPiLpBvWWFoWMysu/8eJzWod1H9c0baa1UP4sNrOaWnTIJa8I1ktKcgGhOQJz47a03uRs46qBbFr8v614dP601XYznbsm6nEx95z9eU8NLTNiPPGnqQbB9WiCo3N/BZgYmUptG/kZM+tyegB+UOjaB56VO0yNyoubMpSiq2a4py0wZ0+eMN5d2eEJWUYu6BRJ90daVMjWPRoYFS4fMupx2ZvDDZs0NY787BkO2iZSm3nlkntP07AFRRxilfDtxwxavEWJI36+zRKuznyYzl2nlMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjiFpve7UU1PFy62Cv9loVcC9ZrCHwMjfsJQ2a58EO0=;
 b=TQxk4/Oh3nrA3NDEChbqEG1UgNQUTho1ie3iC0sF89WFW4bZo6Y87y4jhfEkuDGOKZQflQpe9qonRWNFq5662fMUWyvHZ+e1I3KB35PdYOsJzRdAdj6psTaAQQ2MjcsMzt3xcZRVwHVImTAM56nk0FbxFk8C8t6yy6snRJQYU73ANFRU9Cug6z3HmTSjYaxuaFG6VhvipE+6PiaPdmt1o1q6kNf8nhYQTV/FwFJJEvg5lb0thySMx0W5WO6YjxIOOmdnVG3zND7uY8+Q7S+LP89E1krIGVpIrNBlWJNN9MYmDl+MxTKmHvxAb4F8pG19WGOth696uLjqCve10U3tAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:43:24 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:43:24 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Alistair Popple <apopple@nvidia.com>
Subject: [RFC PATCH 00/19] mm: Introduce a cgroup to limit the amount of locked and pinned memory
Date:   Tue, 24 Jan 2023 16:42:29 +1100
Message-Id: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0033.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::10) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MW3PR12MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3af0fe-921b-4dc4-8f7c-08dafdcde86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5BvCtPuzZtexFmS+0oLG/en4LIQMCbj5QVGEcmpf4zJy4zPf5jfuNKl5AMt8FePYlLSahzEwIOyWf2H3jQlesFl2jxcUlyOHjrl5c1+yeEcS/tlZy2ZSOwkKXjddwaBU4wqsTuX722X/eAQtpYIgL4A8KG2hbxReZ9krPZpfxyp2z1sO0pkkn7p3d9kNZD+JisDmdne/E2Du7m2tAcGSFI0zzM1bZpFbd6qTlqNM+5zhltgE1uGfFOdrnf6h6iMSNRwM5/3LOtUOR7Q+XP3QEqUChAtLZfKRqAQeeIJupKqa3S6XANkazodb/KUqUyHT3PI41W+vM2v9iHfL+PW2qpTDLeis0gF/NeUG0uUnk9CEK/e7JoC35BIBUBH5aESlHPvhyIhsecoTcB0IP6qIngUQeUQf6zyuylh+KQhfZVnVK+ev/jY/ZmDp6V57/OdR0Nlqp3VgNZiXh4yF9mHKVcjxxL9qpuxdag/0yl++J390yuoa2ePqu1/fPBIbb/aWnZTNuZsGY1+Bx5svynPnFUDBnAfoDSrUbBrn9x1NnFAxvQItU+ygz8l4n6vB2wCvaK1tysOlPnrXHTWFCuExWwarxFUakFdv4TnX/CjD39TK/cIPyAadxmxepTrNESMrtv+uSExNkQ506e1kRj+GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199015)(66899015)(36756003)(86362001)(5660300002)(38100700002)(2906002)(4326008)(8936002)(83380400001)(41300700001)(66476007)(478600001)(6486002)(66556008)(6506007)(6512007)(8676002)(26005)(186003)(316002)(66946007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WRS8/D0oQ3hDQU/9jO4Q2RmFCNU3B87fHyVloLkmwYJkXRTT0awgtVucNM95?=
 =?us-ascii?Q?GIVZO3TYrML0QWTZSxtMk1E+MDZeoSsnQ1FcktafwXxtDhncXXw726rbiCsx?=
 =?us-ascii?Q?ZI6Nr8kprgqDHBPTF/I3TB+yXFWE89zGSgkEMqY9NmduDFzQ0Gd0f8kTNs8+?=
 =?us-ascii?Q?pvLgdQ/AJNUlXTDoRKGQh9u2++ubhN9WAgo1+oNlZExLJIV5aew8TxS0fDJX?=
 =?us-ascii?Q?dzH4Jf+8ARqorK71t9cIUUkMPD2O5eJeZ4AgMiZOwLcivp+wrM/JmOEQte20?=
 =?us-ascii?Q?jkPBKdLJSVzvHTdxX34ZJG61jn9ZiPAtVPhZPWzHv/arr98/gkjSsauBjsCl?=
 =?us-ascii?Q?7xxfTJn2c3fBK2NjyFt888k1ujIdAh367UlrFbY82KKp95BnrZMppLTBWH62?=
 =?us-ascii?Q?rvx9m5Mhq7al8W/LplIQrArAguxoZY3UK8EHv2NgC5iAfRLueKj8gC/VT/CV?=
 =?us-ascii?Q?Mi0oxSI1ErVXKgCf4/odyF3fm1OBFfHgmv7/PbAxBvK6Kig/nu052myrTvIy?=
 =?us-ascii?Q?AMbKqkh2jyaQSix4MQimzI7bypWL7rIvgh9+k94kSOz7PjCu3eAuDpvYjv8H?=
 =?us-ascii?Q?ifywoRaqLQdrCRVSafoLiqMDd7zPVqfxh6TWPWSACfexCREhrT56xDpwb6SR?=
 =?us-ascii?Q?iFYvNWiD71D9lt3kuuC83ZLh8cu1zIBMvwo5ySUzsCXER0KSM5q3JlJaSZE5?=
 =?us-ascii?Q?UoiY6QrD5RWluxRURzgz1C00N2VRSlAjTrNZw540NxoCCLDHo0PJFjK5tPpA?=
 =?us-ascii?Q?uvG+f7olLNs5KuogUnv9br5Tt752gfgABz3ndiy6dWzNrvPtEQor0AswnwQ+?=
 =?us-ascii?Q?JkYdoWS2C7e7NsrNso2qqeU9mJN3QlH8wXi74J71FQyUiKtwkMaxIgGu39re?=
 =?us-ascii?Q?l5ppCNuWTVJRzHigGazhH8qf89P9WG2v9Dlysa8hRLqeYBhBuSXJoVOA5O4S?=
 =?us-ascii?Q?6MsFknBJaWxaOFBUaAs1VNdLbfHSLGvne10appPqUdS4HVMLn6bikNu1CutI?=
 =?us-ascii?Q?htDmvgG3i2xcqROJc6zGxfVQt90smpN1XL9BPVUZZoYjpMJncaz3fyrc9hkf?=
 =?us-ascii?Q?u8wYoIeyXBnuAPbjmd6Amj+rMzSZ9z6s3QxLYaLHoqjjMg04Ux3xu82yuTCF?=
 =?us-ascii?Q?PTs6Pk0tsJ7JBUqOJ9akO2uwp8rUdxWGQ5Sp4vscp90HVKos3LMTyMBXcC3+?=
 =?us-ascii?Q?ND9OojrMvx3ZJsJAAlCcTbK4iKbTxoDcularAaA62BUEWh7G5ErsrgsgXldB?=
 =?us-ascii?Q?W1eaKjWNLdU10PnsTbetroBZkP68h85jNht1W9cyWoeqinju1h0LEsT7GXsj?=
 =?us-ascii?Q?VPPhZL+DDlCn8AB66ceBCYlwOfgTTsHMZLyTNt2ui/dsb5hD/OvLyIvPN95F?=
 =?us-ascii?Q?0eunqsE5+/Odi6l/ZY4SEiFfIGjpgnr+5B9Ol8CusinXosAnDES5EioJuaKX?=
 =?us-ascii?Q?jT22oXSXyQz/LxV2OuCd0G7YtiWdr8AuboHQVw1J2Tn2NZtwXVLNH/HsB8c4?=
 =?us-ascii?Q?2hQCBCT/RDMMuRFYIx34Aq/hX5Wp+UwVb63EVChyCLbsuO5SCYBIhdkG4b6u?=
 =?us-ascii?Q?cRMUzMG8d9p3YnJow7sjEFMw3iQGR1V9i4ETz3w0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3af0fe-921b-4dc4-8f7c-08dafdcde86c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 05:43:23.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eb8/86cneqdDQ3j0Y8YGoLaaDH+4zDj/KeBxs2GlDKF4pRtb6dNSfME+VgD8XA7KAQVayOofJ6vMDIup4ghypA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4540
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The second part of the series adds the cgroup and converts core mm
code such as mlock over to charging the cgroup before finally
introducing some selftests.

As I don't have access to systems with all the various devices I
haven't been able to test all driver changes. Any help there would be
appreciated.

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
 arch/powerpc/mm/book3s64/iommu_api.c     |  29 +--
 drivers/fpga/dfl-afu-dma-region.c        |  11 +-
 drivers/fpga/dfl-afu.h                   |   1 +-
 drivers/infiniband/core/umem.c           |  16 +-
 drivers/infiniband/core/umem_odp.c       |   6 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c |  13 +-
 drivers/infiniband/hw/usnic/usnic_uiom.h |   1 +-
 drivers/infiniband/sw/siw/siw.h          |   2 +-
 drivers/infiniband/sw/siw/siw_mem.c      |  20 +--
 drivers/infiniband/sw/siw/siw_verbs.c    |  15 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  20 +--
 drivers/vfio/vfio_iommu_spapr_tce.c      |  15 +-
 drivers/vfio/vfio_iommu_type1.c          |  59 +----
 drivers/vhost/vdpa.c                     |   9 +-
 drivers/vhost/vhost.c                    |   2 +-
 drivers/vhost/vhost.h                    |   1 +-
 include/linux/cgroup.h                   |  20 ++-
 include/linux/cgroup_subsys.h            |   4 +-
 include/linux/io_uring_types.h           |   3 +-
 include/linux/kvm_host.h                 |   1 +-
 include/linux/mm.h                       |   5 +-
 include/linux/mm_types.h                 |  88 ++++++++-
 include/linux/skbuff.h                   |   6 +-
 include/net/sock.h                       |   2 +-
 include/net/xdp_sock.h                   |   2 +-
 include/rdma/ib_umem.h                   |   1 +-
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
 mm/util.c                                | 196 +++++++++++++++--
 net/core/skbuff.c                        |  47 +---
 net/rds/message.c                        |   9 +-
 net/xdp/xdp_umem.c                       |  38 +--
 tools/testing/selftests/vm/Makefile      |   1 +-
 tools/testing/selftests/vm/pins-cgroup.c | 271 ++++++++++++++++++++++++-
 virt/kvm/kvm_main.c                      |   3 +-
 48 files changed, 1114 insertions(+), 401 deletions(-)
 create mode 100644 mm/pins_cgroup.c
 create mode 100644 tools/testing/selftests/vm/pins-cgroup.c

base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
-- 
git-series 0.9.1
