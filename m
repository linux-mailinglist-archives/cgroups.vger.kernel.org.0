Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1DC193FD
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 23:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfEIVEt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 17:04:49 -0400
Received: from mail-eopbgr680060.outbound.protection.outlook.com ([40.107.68.60]:47075
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbfEIVEs (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 9 May 2019 17:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpMEXD/9fMIms9U40QfczX6+Ub8nc+u8q76hRonweeA=;
 b=Z4xF2jQn7jCAoLuTuvA+fIbY76AyWoer6988uXwCgG2jqIsV3cFdhRiGkaEIaa5vMCHK4JuxKStuFsTcpymxp02dtqOtAuj0UPVSQXdt7/uZh1MGUpqDIdZIrta6KqCkQolZ0X8WbmFuCMgNaj8sCbvwLoz+MxbYAiiWlAp9l2c=
Received: from MWHPR12CA0032.namprd12.prod.outlook.com (2603:10b6:301:2::18)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.21; Thu, 9 May
 2019 21:04:44 +0000
Received: from CO1NAM03FT005.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by MWHPR12CA0032.outlook.office365.com
 (2603:10b6:301:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.21 via Frontend
 Transport; Thu, 9 May 2019 21:04:44 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 CO1NAM03FT005.mail.protection.outlook.com (10.152.80.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Thu, 9 May 2019 21:04:44 +0000
Received: from kho-5039A.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Thu, 9 May 2019
 16:04:41 -0500
From:   Kenny Ho <Kenny.Ho@amd.com>
To:     <y2kenny@gmail.com>, <Kenny.Ho@amd.com>, <cgroups@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <tj@kernel.org>, <sunnanyong@huawei.com>,
        <alexander.deucher@amd.com>, <brian.welty@intel.com>
Subject: [RFC PATCH v2 0/5] new cgroup controller for gpu/drm subsystem
Date:   Thu, 9 May 2019 17:04:05 -0400
Message-ID: <20190509210410.5471-1-Kenny.Ho@amd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20181120185814.13362-1-Kenny.Ho@amd.com>
References: <20181120185814.13362-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(428003)(189003)(199004)(966005)(70586007)(53936002)(72206003)(110136005)(50466002)(478600001)(48376002)(36756003)(14444005)(6306002)(81166006)(316002)(8676002)(81156014)(8936002)(50226002)(47776003)(336012)(2870700001)(2906002)(70206006)(77096007)(76176011)(26005)(305945005)(426003)(356004)(186003)(6666004)(1076003)(53416004)(86362001)(68736007)(446003)(486006)(476003)(126002)(2616005)(5660300002)(7696005)(51416003)(2201001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0062;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38c7712e-ce8a-4ba0-d67d-08d6d4c1f635
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328);SRVR:MWHPR1201MB0062;
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0062:
X-MS-Exchange-PUrlCount: 9
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0062C154FC7DD23E6F1685D983330@MWHPR1201MB0062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 003245E729
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +KwY8pF0QkiuVywObeP2pHkHyfPsBBY8zJt/NfeWio/ARtiSBQTndGBVu2IrPhIvxJ3LUam1ma2g1uhWxwucwUmgZrbcxQLolSokS15NqPM/icvz5FYjpnLHT0wh9hJeNC/UWtXC7KqnRvqQmb+S6+tU0X34l8YOOF89hoX7NoC+jVZjcmhxkgfWFNp0aQXtt83rK4a78Wc2Edytmv/bhcQis/zddmfbuzB0I5U8gVkDVcwsWWz2Pozef74mQqW5xYwCr7S3ZgK1mhDMQ7IPXuTpXPkds7sWzsUA74avpYu0jd8wN0PM4zd/wPE9XE4s6goQEbzDN8ttGXOocvcgwn4OO2dR5Pr4a8YD/mzb5UbK+SKFR5Mp46DIitjZJqPO5qrjG0n93cQdSPByd7Nrhm5/9ns2QgVPqZXOuB39D+o=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2019 21:04:44.0851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c7712e-ce8a-4ba0-d67d-08d6d4c1f635
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is a follow up to the RFC I made last november to introduce a cgroup controller for the GPU/DRM subsystem [a].  The goal is to be able to provide resource management to GPU resources using things like container.  The cover letter from v1 is copied below for reference.

Usage examples:
// set limit for card1 to 1GB
sed -i '2s/.*/1073741824/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max

// set limit for card0 to 512MB
sed -i '1s/.*/536870912/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max


v2:
* Removed the vendoring concepts
* Add limit to total buffer allocation
* Add limit to the maximum size of a buffer allocation

TODO: process migration
TODO: documentations

[a]: https://lists.freedesktop.org/archives/dri-devel/2018-November/197106.html

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

Kenny Ho (5):
  cgroup: Introduce cgroup for drm subsystem
  cgroup: Add mechanism to register DRM devices
  drm/amdgpu: Register AMD devices for DRM cgroup
  drm, cgroup: Add total GEM buffer allocation limit
  drm, cgroup: Add peak GEM buffer allocation limit

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 +
 drivers/gpu/drm/drm_gem.c                  |   7 +
 drivers/gpu/drm/drm_prime.c                |   9 +
 include/drm/drm_cgroup.h                   |  54 +++
 include/drm/drm_gem.h                      |  11 +
 include/linux/cgroup_drm.h                 |  47 ++
 include/linux/cgroup_subsys.h              |   4 +
 init/Kconfig                               |   5 +
 kernel/cgroup/Makefile                     |   1 +
 kernel/cgroup/drm.c                        | 497 +++++++++++++++++++++
 11 files changed, 643 insertions(+)
 create mode 100644 include/drm/drm_cgroup.h
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

-- 
2.21.0

