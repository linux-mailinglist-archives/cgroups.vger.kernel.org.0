Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758CE56D25
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfFZPFd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:05:33 -0400
Received: from mail-eopbgr680082.outbound.protection.outlook.com ([40.107.68.82]:26625
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbfFZPFd (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuNOFvnJEgjd3ITI/I1VOYq4kv7C3bzZ5frz0dUO+84=;
 b=WuvJGN5NYdAQsbENnokK4oP3cjNYWOTSZU8wPjg7RfKfJFZJvoac+Oj991cf7UAolGcgI1iubai/rPC6pPZeFvDiJGEW6JRTnekzC7vmAvC1MS2fxKTfm/93JegzDSfggKALoyj1TGGZW1VrrAse87alE37WhjdQIaPIcRT2fhc=
Received: from MWHPR12CA0058.namprd12.prod.outlook.com (2603:10b6:300:103::20)
 by MWHPR12MB1710.namprd12.prod.outlook.com (2603:10b6:300:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Wed, 26 Jun
 2019 15:05:29 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::209) by MWHPR12CA0058.outlook.office365.com
 (2603:10b6:300:103::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Wed, 26 Jun 2019 15:05:28 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 26 Jun 2019 15:05:28 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Wed, 26 Jun 2019
 10:05:25 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <joseph.greathouse@amd.com>,
        <jsparks@cray.com>, <lkaplan@cray.com>
CC:     Kenny Ho <Kenny.Ho@amd.com>
Subject: [RFC PATCH v3 00/11] new cgroup controller for gpu/drm subsystem
Date:   Wed, 26 Jun 2019 11:05:11 -0400
Message-ID: <20190626150522.11618-1-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(428003)(199004)(189003)(426003)(47776003)(305945005)(6666004)(36756003)(356004)(336012)(6306002)(51416003)(1076003)(4326008)(5660300002)(186003)(77096007)(26005)(2201001)(53416004)(2870700001)(86362001)(72206003)(50226002)(2906002)(81166006)(81156014)(50466002)(7696005)(70586007)(70206006)(8676002)(126002)(966005)(2616005)(14444005)(476003)(110136005)(48376002)(478600001)(53936002)(8936002)(486006)(68736007)(316002)(921003)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1710;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f99fb5a-3ef1-407b-c65f-08d6fa47b9ce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:MWHPR12MB1710;
X-MS-TrafficTypeDiagnostic: MWHPR12MB1710:
X-MS-Exchange-PUrlCount: 10
X-Microsoft-Antispam-PRVS: <MWHPR12MB1710662592DA9FAEE7E193F383E20@MWHPR12MB1710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 00808B16F3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: oWQHLgdlIHwNp25dgFXce3bdHJtweQOhWI/jo7RCYoxdCM1pa34nQ11yee319NoZ3wiq/TXGzePFh1xvFvpEzrxyaZ0LUZrIwzFVoFGqaAKbuX3bcKI/42dZdDe8gg2ncjxKo5YpYtix45uDZm4Gvq/DB6wmIt3SUES0vCfcq3mn2w+gUgKolM3KqtQjw1uXbWB51N8WMsaJj6+m+mDkSxTQ7vXenGUWi18gJu41a7wktL+Nu06LKtGYpqHnq51gT5mLhPu2uxQDA94oFu3ANhWRcYWMaQ3eTa2/xsScBKi9J5vyEYvybVZ1xV8npADm37x5YQ1bmO0R8ZKOw6eF7cWeKg9WPOyXXIGbUj8PAYKWeltFhjeWLW/+TjkAY/MwXc2fz6fCrSfFCjYOg4rpmOL2iwZJCkxNJooDf03lFaY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2019 15:05:28.0927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f99fb5a-3ef1-407b-c65f-08d6fa47b9ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1710
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is a follow up to the RFC I made previously to introduce a cgroup
controller for the GPU/DRM subsystem [v1,v2].  The goal is to be able to
provide resource management to GPU resources using things like container.
The cover letter from v1 is copied below for reference.

[v1]: https://lists.freedesktop.org/archives/dri-devel/2018-November/197106.html
[v2]: https://www.spinics.net/lists/cgroups/msg22074.html

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

Kenny Ho (11):
  cgroup: Introduce cgroup for drm subsystem
  cgroup: Add mechanism to register DRM devices
  drm/amdgpu: Register AMD devices for DRM cgroup
  drm, cgroup: Add total GEM buffer allocation limit
  drm, cgroup: Add peak GEM buffer allocation limit
  drm, cgroup: Add GEM buffer allocation count stats
  drm, cgroup: Add TTM buffer allocation stats
  drm, cgroup: Add TTM buffer peak usage stats
  drm, cgroup: Add per cgroup bw measure and control
  drm, cgroup: Add soft VRAM limit
  drm, cgroup: Allow more aggressive memory reclaim

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |    3 +-
 drivers/gpu/drm/drm_gem.c                  |    8 +
 drivers/gpu/drm/drm_prime.c                |    9 +
 drivers/gpu/drm/ttm/ttm_bo.c               |   91 ++
 drivers/gpu/drm/ttm/ttm_bo_util.c          |    4 +
 include/drm/drm_cgroup.h                   |  115 ++
 include/drm/drm_gem.h                      |   11 +
 include/drm/ttm/ttm_bo_api.h               |    2 +
 include/drm/ttm/ttm_bo_driver.h            |   10 +
 include/linux/cgroup_drm.h                 |  114 ++
 include/linux/cgroup_subsys.h              |    4 +
 init/Kconfig                               |    5 +
 kernel/cgroup/Makefile                     |    1 +
 kernel/cgroup/drm.c                        | 1171 ++++++++++++++++++++
 16 files changed, 1555 insertions(+), 1 deletion(-)
 create mode 100644 include/drm/drm_cgroup.h
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

-- 
2.21.0

