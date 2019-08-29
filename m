Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263FBA1154
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 08:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfH2GFp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 02:05:45 -0400
Received: from mail-eopbgr780044.outbound.protection.outlook.com ([40.107.78.44]:8582
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfH2GFp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 02:05:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAEKhY3VRVJD2U4x32HCSPEB0jWu4quk5Yvnp7yNBQ093Ud4golmYG6HpDZXm0hmjEEb0xb/WrHe5Gog2tWnQMRoNBoIpS156XBX2itgrltSdsKrPUpwHSPTokVkGgulaeEKP+8NX2jmsBKrHvN5KvHYcf+lIrsys2zlJFExQqIaPB6AkhkpdE9nFBnPswOJ/5VnO625EpZi1MS7yfda+PCOF0IALSMbU9ZWpUSOs5SGtbcN7YlhNyqYwIe253EfddECfS3Y/EodAIlQHnURcPesv3jmpSLqk+Yszo/7Pmy3OrOoubnvtBPNoqcxYRp53u2p+5GZUm368e9Xxt2+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSNgEF85IeOcqJFrAbHc5u9NbE1ewkRRWykeVKtI1w0=;
 b=bbcNT6zmxX4RNZvPDCae8lFTpm7a9Stgn8Us9KjfznMH5GlQC20EWVZG4fh0v22BgGzlKe/uWmeXCRKU1EAbcFjbDWuHi/S+LgMTG2VTTMfWqKjBnVp7Wt0pvO4wExm+Atk3wQw3KNcHduiEvPtSqdyuF4XHJ0bW3vys/6YntS+f2giCLLO2GV48Lf25zJMT5gFolM4vGJAC+saOsf/PfxHjYzWuNGUZsGOXIQ8RLnzFzVZ8hghimLLd3FzkQNj49sQt2Mt/GTjYhOFgZkSglDZMx6cgN5bZ6EkbzLJyY+nn4/e6vy2Q8QsXze32BlN6Jw+A7+pXBvVvdx5KNZ1kgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=cray.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSNgEF85IeOcqJFrAbHc5u9NbE1ewkRRWykeVKtI1w0=;
 b=SBH1lU4s+VBhtUxURvXXe25xqmne+sLHaPeo5R67M1jU/NS1oKwTczeBTgxhbDCKBX+fPhQ6rC/w7FXDoZvYmH+XY/U2cYXOm7BedKrMibrnapXI9vdNiBmnPON6TGSG3aowv5ffqgVIZbeGP4gjjfx16h8poGsjKHZWzCulSqM=
Received: from CH2PR12CA0015.namprd12.prod.outlook.com (2603:10b6:610:57::25)
 by BN6PR12MB1265.namprd12.prod.outlook.com (2603:10b6:404:1d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.19; Thu, 29 Aug
 2019 06:05:42 +0000
Received: from CO1NAM03FT045.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by CH2PR12CA0015.outlook.office365.com
 (2603:10b6:610:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Thu, 29 Aug 2019 06:05:42 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; cray.com; dkim=none (message not signed)
 header.d=none;cray.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT045.mail.protection.outlook.com (10.152.81.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Thu, 29 Aug 2019 06:05:41 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 29 Aug 2019
 01:05:40 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <felix.kuehling@amd.com>,
        <joseph.greathouse@amd.com>, <jsparks@cray.com>,
        <lkaplan@cray.com>, <daniel@ffwll.ch>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
Date:   Thu, 29 Aug 2019 02:05:17 -0400
Message-ID: <20190829060533.32315-1-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(2980300002)(428003)(189003)(199004)(4326008)(126002)(5660300002)(336012)(81156014)(48376002)(81166006)(36756003)(305945005)(50466002)(8676002)(2616005)(110136005)(476003)(2870700001)(478600001)(47776003)(426003)(2906002)(86362001)(2201001)(26005)(7696005)(6306002)(966005)(50226002)(53936002)(356004)(6666004)(1076003)(486006)(53416004)(316002)(186003)(14444005)(8936002)(70586007)(70206006)(51416003)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1265;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef6e4f53-a1dc-4478-2577-08d72c46ec3a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328);SRVR:BN6PR12MB1265;
X-MS-TrafficTypeDiagnostic: BN6PR12MB1265:
X-MS-Exchange-PUrlCount: 11
X-Microsoft-Antispam-PRVS: <BN6PR12MB1265227FCEA822948F4BA80883A20@BN6PR12MB1265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0144B30E41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: m94ctZ32wtyu66gtNnyjCNnacgZ3MkBdTTErLhtiAMl9Vvx5Gqu0ZcM8beGiA3wu/Rn1Hi34pfsUCbuoFoIr4gSIsQX5NITvgYnW82MkgqwLL06yzuCv26R7/yp9+0JSqRJ4LZFLCWY7+1e10coddUVkyXVvbzZIrXaNLJWnXnlzmql/F6wZuzavFo7eEI6VW8bEvMyhtCshfMh41JVdh8UP6CrMjC7K/nVfeG/tC99f30ygSVDblMNXASLlazy11XidGcxnmxCHHf5wvpFXrbR9+KG/R5U68vQt+opSXy0owphqiewqmxHB0AeI9lJkavevYa0a0yv8PZblcOT4VgbV+J2a72gBHu1dlHzbkAzgkr6ytWcicb3kRqHpO9TgW6EPNwJW4i1IrD4FyafYTTxTayoAdXQzkj+skaddksM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2019 06:05:41.3146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6e4f53-a1dc-4478-2577-08d72c46ec3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1265
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is a follow up to the RFC I made previously to introduce a cgroup
controller for the GPU/DRM subsystem [v1,v2,v3].  The goal is to be able to
provide resource management to GPU resources using things like container.  

With this RFC v4, I am hoping to have some consensus on a merge plan.  I believe
the GEM related resources (drm.buffer.*) introduced in previous RFC and,
hopefully, the logical GPU concept (drm.lgpu.*) introduced in this RFC are
uncontroversial and ready to move out of RFC and into a more formal review.  I
will continue to work on the memory backend resources (drm.memory.*).

The cover letter from v1 is copied below for reference.

[v1]: https://lists.freedesktop.org/archives/dri-devel/2018-November/197106.html
[v2]: https://www.spinics.net/lists/cgroups/msg22074.html
[v3]: https://lists.freedesktop.org/archives/amd-gfx/2019-June/036026.html

v4:
Unchanged (no review needed)
* drm.memory.*/ttm resources (Patch 9-13, I am still working on memory bandwidth
and shrinker)
Base on feedbacks on v3:
* update nominclature to drmcg
* embed per device drmcg properties into drm_device
* split GEM buffer related commits into stats and limit
* rename function name to align with convention
* combined buffer accounting and check into a try_charge function
* support buffer stats without limit enforcement
* removed GEM buffer sharing limitation
* updated documentations
New features:
* introducing logical GPU concept
* example implementation with AMD KFD

v3:
Base on feedbacks on v2:
* removed .help type file from v2
* conform to cgroup convention for default and max handling
* conform to cgroup convention for addressing device specific limits (with major:minor)
New function:
* adopted memparse for memory size related attributes
* added macro to marshall drmcgrp cftype private  (DRMCG_CTF_PRIV, etc.)
* added ttm buffer usage stats (per cgroup, for system, tt, vram.)
* added ttm buffer usage limit (per cgroup, for vram.)
* added per cgroup bandwidth stats and limiting (burst and average bandwidth)

v2:
* Removed the vendoring concepts
* Add limit to total buffer allocation
* Add limit to the maximum size of a buffer allocation

v1: cover letter

The purpose of this patch series is to start a discussion for a generic cgroup
controller for the drm subsystem.  The design proposed here is a very early one.
We are hoping to engage the community as we develop the idea.


Backgrounds
==========
Control Groups/cgroup provide a mechanism for aggregating/partitioning sets of
tasks, and all their future children, into hierarchical groups with specialized
behaviour, such as accounting/limiting the resources which processes in a cgroup
can access[1].  Weights, limits, protections, allocations are the main resource
distribution models.  Existing cgroup controllers includes cpu, memory, io,
rdma, and more.  cgroup is one of the foundational technologies that enables the
popular container application deployment and management method.

Direct Rendering Manager/drm contains code intended to support the needs of
complex graphics devices. Graphics drivers in the kernel may make use of DRM
functions to make tasks like memory management, interrupt handling and DMA
easier, and provide a uniform interface to applications.  The DRM has also
developed beyond traditional graphics applications to support compute/GPGPU
applications.


Motivations
=========
As GPU grow beyond the realm of desktop/workstation graphics into areas like
data center clusters and IoT, there are increasing needs to monitor and regulate
GPU as a resource like cpu, memory and io.

Matt Roper from Intel began working on similar idea in early 2018 [2] for the
purpose of managing GPU priority using the cgroup hierarchy.  While that
particular use case may not warrant a standalone drm cgroup controller, there
are other use cases where having one can be useful [3].  Monitoring GPU
resources such as VRAM and buffers, CU (compute unit [AMD's nomenclature])/EU
(execution unit [Intel's nomenclature]), GPU job scheduling [4] can help
sysadmins get a better understanding of the applications usage profile.  Further
usage regulations of the aforementioned resources can also help sysadmins
optimize workload deployment on limited GPU resources.

With the increased importance of machine learning, data science and other
cloud-based applications, GPUs are already in production use in data centers
today [5,6,7].  Existing GPU resource management is very course grain, however,
as sysadmins are only able to distribute workload on a per-GPU basis [8].  An
alternative is to use GPU virtualization (with or without SRIOV) but it
generally acts on the entire GPU instead of the specific resources in a GPU.
With a drm cgroup controller, we can enable alternate, fine-grain, sub-GPU
resource management (in addition to what may be available via GPU
virtualization.)

In addition to production use, the DRM cgroup can also help with testing
graphics application robustness by providing a mean to artificially limit DRM
resources availble to the applications.


Challenges
========
While there are common infrastructure in DRM that is shared across many vendors
(the scheduler [4] for example), there are also aspects of DRM that are vendor
specific.  To accommodate this, we borrowed the mechanism used by the cgroup to
handle different kinds of cgroup controller.

Resources for DRM are also often device (GPU) specific instead of system
specific and a system may contain more than one GPU.  For this, we borrowed some
of the ideas from RDMA cgroup controller.

Approach
=======
To experiment with the idea of a DRM cgroup, we would like to start with basic
accounting and statistics, then continue to iterate and add regulating
mechanisms into the driver.

[1] https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt
[2] https://lists.freedesktop.org/archives/intel-gfx/2018-January/153156.html
[3] https://www.spinics.net/lists/cgroups/msg20720.html
[4] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/scheduler
[5] https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/
[6] https://blog.openshift.com/gpu-accelerated-sql-queries-with-postgresql-pg-strom-in-openshift-3-10/
[7] https://github.com/RadeonOpenCompute/k8s-device-plugin
[8] https://github.com/kubernetes/kubernetes/issues/52757

Kenny Ho (16):
  drm: Add drm_minor_for_each
  cgroup: Introduce cgroup for drm subsystem
  drm, cgroup: Initialize drmcg properties
  drm, cgroup: Add total GEM buffer allocation stats
  drm, cgroup: Add peak GEM buffer allocation stats
  drm, cgroup: Add GEM buffer allocation count stats
  drm, cgroup: Add total GEM buffer allocation limit
  drm, cgroup: Add peak GEM buffer allocation limit
  drm, cgroup: Add TTM buffer allocation stats
  drm, cgroup: Add TTM buffer peak usage stats
  drm, cgroup: Add per cgroup bw measure and control
  drm, cgroup: Add soft VRAM limit
  drm, cgroup: Allow more aggressive memory reclaim
  drm, cgroup: Introduce lgpu as DRM cgroup resource
  drm, cgroup: add update trigger after limit change
  drm/amdgpu: Integrate with DRM cgroup

 Documentation/admin-guide/cgroup-v2.rst       |  163 +-
 Documentation/cgroup-v1/drm.rst               |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   29 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |    3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |    6 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |    3 +
 .../amd/amdkfd/kfd_process_queue_manager.c    |  140 ++
 drivers/gpu/drm/drm_drv.c                     |   26 +
 drivers/gpu/drm/drm_gem.c                     |   16 +-
 drivers/gpu/drm/drm_internal.h                |    4 -
 drivers/gpu/drm/ttm/ttm_bo.c                  |   93 ++
 drivers/gpu/drm/ttm/ttm_bo_util.c             |    4 +
 include/drm/drm_cgroup.h                      |  122 ++
 include/drm/drm_device.h                      |    7 +
 include/drm/drm_drv.h                         |   23 +
 include/drm/drm_gem.h                         |   13 +-
 include/drm/ttm/ttm_bo_api.h                  |    2 +
 include/drm/ttm/ttm_bo_driver.h               |   10 +
 include/linux/cgroup_drm.h                    |  151 ++
 include/linux/cgroup_subsys.h                 |    4 +
 init/Kconfig                                  |    5 +
 kernel/cgroup/Makefile                        |    1 +
 kernel/cgroup/drm.c                           | 1367 +++++++++++++++++
 25 files changed, 2193 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/cgroup-v1/drm.rst
 create mode 100644 include/drm/drm_cgroup.h
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

-- 
2.22.0

