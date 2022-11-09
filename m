Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5A0622FC6
	for <lists+cgroups@lfdr.de>; Wed,  9 Nov 2022 17:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiKIQMC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Nov 2022 11:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiKIQMB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Nov 2022 11:12:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B69D62CA;
        Wed,  9 Nov 2022 08:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668010320; x=1699546320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nJI4ro+jAHzR4PBbYjNzbAwO3BQ6On2uoSrJJcY3Zwg=;
  b=JV56PBKOwye+RFINirmN5UgnL+MQG6LuOgudO9r1Xk0NUHf10S+91Qlq
   stCsTge7PApUi8QlAwU53chs/+T6Xn5qvvKGlyi9acbcwnb/oELx4oVH7
   qcQ3ngFNvapYRWCo2pT34upSy5Kp8EDZKb8Qo4GwrSpEZivr/I/sYFN+e
   aQ95efRd8Fj9yT2LbyExYdmSayhOPGU1KuR4T73mblMfBWNI49Cr2OrIp
   kLkngSni9fLZoFNKpCHeghpfBjrkNipWyLiERPE/YzoqlfBDUc955fSao
   w2cT6mqLn61eDIIHhZgM+kwd35r+oThIXvB8IKhO+gRcTyRk40XUty4i6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="290735929"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="290735929"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:11:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811684351"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="811684351"
Received: from smurnane-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.196.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:11:54 -0800
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC v2 00/13] DRM scheduling cgroup controller
Date:   Wed,  9 Nov 2022 16:11:28 +0000
Message-Id: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

This series contains a proposal for a DRM scheduling cgroup controller which
implements a weight based hierarchical GPU usage budget based controller
similar in concept to some of the existing controllers.

Motivation mostly comes from my earlier proposal where I identified that GPU
scheduling lags significantly behind what is available for CPU and IO. Whereas
back then I was proposing to somehow tie this with process nice, feedback mostly
was that people wanted cgroups. So here it is - in the world of heterogenous
computing pipelines I think it is time to do something about this gap.

Code is not finished but should survive some light experimenting with. I am
sharing it early since the topic has been controversial in the past. I hope to
demonstrate there are gains to be had in real world usage(*), today, and that
the concepts the proposal relies are well enough established and stable.

*) Specifically under ChromeOS which uses cgroups to control CPU bandwith for
   VMs based on the window focused status. It can be demonstrated how GPU
   scheduling control can easily be integrated into that setup.

There should be no conflict with this proposal and any efforts to implement
memory usage based controller. Skeleton DRM cgroup controller is deliberatly
purely a skeleton patch where any further functionality can be added with no
real conflicts. [In fact, perhaps scheduling is even easier to deal with than
memory accounting.]

Structure of the series is as follows:

  1-3) Improve client ownership tracking in DRM core.
    4) Adds a skeleton DRM cgroup controller with no functionality.
 5-10) Laying down some infrastructure to enable the controller.
   11) The controller itself.
12-13) i915 support for the controller.

The proposals defines a delegation of duties between the tree parties: cgroup
controller, DRM core and individual drivers. Two way communication interfaces
are then defined to enable the delegation to work.

DRM scheduling soft limits
~~~~~~~~~~~~~~~~~~~~~~~~~~

Because of the heterogenous hardware and driver DRM capabilities, soft limits
are implemented as a loose co-operative (bi-directional) interface between the
controller and DRM core.

The controller configures the GPU time allowed per group and periodically scans
the belonging tasks to detect the over budget condition, at which point it
invokes a callback notifying the DRM core of the condition.

DRM core provides an API to query per process GPU utilization and 2nd API to
receive notification from the cgroup controller when the group enters or exits
the over budget condition.

Individual DRM drivers which implement the interface are expected to act on this
in the best-effort manner only. There are no guarantees that the soft limits
will be respected.

DRM scheduling soft limits interface files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  drm.weight
	Standard cgroup weight based control [1, 10000] used to configure the
	relative distributing of GPU time between the sibling groups.

  drm.period_us (Most probably only a debugging aid during RFC phase.)
	An integer representing the period with which the controller should look
	at the GPU usage by the group and potentially send the over/under budget
	signal.
	Value of zero (defaul) disables the soft limit checking.

This builds upon the per client GPU utilisation work which landed recently for a
few drivers. My thinking is that in principle, an intersect of drivers which
support both that and some sort of scheduling control, like  priorities, could
also in theory support this controller.

Another really interesting angle for this controller is that it mimics the same
control menthod used by the CPU scheduler. That is the proportional/weight based
GPU time budgeting. Which makes it easy to configure and does not need a new
mental model.

However, as the introduction mentions, GPUs are much more heterogenous and
therefore the controller uses very "soft" wording as to what it promises. The
general statement is that it can define budgets, notify clients when they are
over them, and let individual drivers implement best effort handling of those
conditions.

Delegation of duties in the implementation goes likes this:

 * DRM cgroup controller implements the control files and the scanning loop.
 * DRM core is required to track all DRM clients belonging to processes so it
   can answer when asked how much GPU time is a process using.
 * DRM core also provides a call back which the controller will call when a
   certain process is over budget.
 * Individual drivers need to implement two similar hooks, but which work for
   a single DRM client. Over budget callback and GPU utilisation query.

What I have demonstrated in practice is that when wired to i915, in a really
primitive way where the over-budget condition simply lowers the scheduling
priority, the concept can be almost equally effective as the static priority
control. I say almost because the design where budget control depends on the
periodic usage scanning has a fundamental delay, so responsiveness will depend
on the scanning period, which may or may not be a problem for a particular use
case.

There are also interesting conversations to be had around mental models for what
is GPU usage as a single number when faced with GPUs which have different
execution engines. To an extent this is similar to the multi-core and cgroup
CPU controller problems, but definitely goes further than that.

I deliberately did not want to include any such complications in the controller
itself and left the individual drivers to handle it. For instance in the i915
over-budget callback it will not do anything unless client's GPU usage is on a
physical engine which is oversubscribed. This enables multiple clients to be
harmlessly over budget, as long as they are not competing for the same GPU
resource.

This much for now, hope some good discussion will follow.

P.S.
A disclaimer of a kind -  I was not familiar with how to implement a cgroup
controller at all when I started this prototype therefore it is quite possible
there are many bugs and misunderstandings on how it should be done.

v2:
 * Prefaced the series with some core DRM work as suggested by Christian.
 * Dropped the priority based controller for now.
 * Dropped the introspection cgroup controller file.
 * Implemented unused budget sharing/propagation.
 * Some small fixes/tweak as per review feedback and in general.

Tvrtko Ursulin (13):
  drm: Replace DRM_DEBUG with drm_dbg_core in file and ioctl handling
  drm: Track clients by tgid and not tid
  drm: Update file owner during use
  cgroup: Add the DRM cgroup controller
  drm/cgroup: Track clients per owning process
  drm/cgroup: Allow safe external access to file_priv
  drm/cgroup: Add ability to query drm cgroup GPU time
  drm/cgroup: Add over budget signalling callback
  drm/cgroup: Only track clients which are providing drm_cgroup_ops
  cgroup/drm: Client exit hook
  cgroup/drm: Introduce weight based drm cgroup control
  drm/i915: Wire up with drm controller GPU time query
  drm/i915: Implement cgroup controller over budget throttling

 Documentation/admin-guide/cgroup-v2.rst       |  37 ++
 drivers/gpu/drm/Kconfig                       |   1 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   6 +-
 drivers/gpu/drm/drm_auth.c                    |   3 +-
 drivers/gpu/drm/drm_cgroup.c                  | 192 ++++++
 drivers/gpu/drm/drm_debugfs.c                 |  12 +-
 drivers/gpu/drm/drm_file.c                    |  74 ++-
 drivers/gpu/drm/drm_ioc32.c                   |  13 +-
 drivers/gpu/drm/drm_ioctl.c                   |  28 +-
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |  37 +-
 drivers/gpu/drm/i915/i915_driver.c            |  11 +
 drivers/gpu/drm/i915/i915_drm_client.c        | 169 +++++-
 drivers/gpu/drm/i915/i915_drm_client.h        |  13 +
 drivers/gpu/drm/nouveau/nouveau_drm.c         |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c           |   6 +-
 include/drm/drm_clients.h                     |  47 ++
 include/drm/drm_drv.h                         |  36 ++
 include/drm/drm_file.h                        |  17 +-
 include/linux/cgroup_drm.h                    |  13 +
 include/linux/cgroup_subsys.h                 |   4 +
 init/Kconfig                                  |   8 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/drm.c                           | 572 ++++++++++++++++++
 24 files changed, 1249 insertions(+), 57 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_cgroup.c
 create mode 100644 include/drm/drm_clients.h
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

-- 
2.34.1

