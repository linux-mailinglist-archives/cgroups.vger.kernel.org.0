Return-Path: <cgroups+bounces-56-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D891F7D578F
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 18:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C891281AAC
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD013994B;
	Tue, 24 Oct 2023 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mu0sVRCV"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BE3992A
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 16:12:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD954DD;
	Tue, 24 Oct 2023 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698163916; x=1729699916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kv14ehrAzK2a0QvO+/h7e0x6asRlQhryIp82RzeJBOY=;
  b=mu0sVRCV++heh+ZDUl6qIFWkcR0dmvIO/lgPYVjdX443/AbocwZQHDze
   EOBQ3dAqC9J9kjqVAsJo9/OxoxuhKN6hUHtkYVpLDmwRlSiy1Krq6gEiI
   waozsvGvU1wGKJQE/7nE02iccf3pCxswLoyyRxYqZkLGYzbLxLUJQcYWD
   NqGkI5Cfi/Ph/gs94LQXuFOwdZMlPsTNzrZalpGvxDWw+Bdq/GByldmzw
   O7XkSnpnT2DuLx1RGT6LrhtQ7CJwmUuDQFTy95uc5CX1jJQ0M9wgXhg+d
   L/14TXfAbjg15cMLgFlrZOn/T3ghxgJ4H7exi+gYzx3FsWLwHAeJiVZM5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451328072"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="451328072"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:07:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902237104"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="902237104"
Received: from aidenbar-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.219.125])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:05:12 -0700
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: Intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Dave Airlie <airlied@redhat.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Rob Clark <robdclark@chromium.org>,
	=?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
	"T . J . Mercier" <tjmercier@google.com>,
	Kenny.Ho@amd.com,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Brian Welty <brian.welty@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC v6 0/8] DRM scheduling cgroup controller
Date: Tue, 24 Oct 2023 17:07:19 +0100
Message-Id: <20231024160727.282960-1-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

This series contains a proposal for a DRM cgroup controller which implements a
weight based hierarchical GPU usage budget approach and is similar in concept to
some of the existing controllers like CPU and IO.

Motivation mostly comes from my earlier proposal where I identified that GPU
scheduling lags significantly behind what is available for CPU and IO. In the
modern world of heterogenous computing pipelines I think it would be good to
close this gap.

Originally my proposal was also to tie the DRM scheduling priority with process
nice, also similar to CPU and IO, and to add explicit priority control on top,
but the feedback was that scheduling priority is to abstract so that part of the
proposal was dropped.

This series hope to demonstrate there are gains to be had in real world
usage(*), today, that the concepts the proposal relies are well enough
established and stable, and that wiring up DRM drivers into the controller would
be straightforward.

*) Specifically under ChromeOS which uses cgroups to control CPU bandwith for
   VMs based on the window focused status. It can be demonstrated how GPU
   scheduling control can easily be integrated into that setup.

*) Another real world example later in the cover letter.

There should be no conflict with this proposal and any efforts to implement
memory usage based controller. Skeleton DRM cgroup controller is deliberatly
purely a skeleton patch where any further functionality can be added with no
real conflicts. [In fact, perhaps scheduling is even easier to deal with than
memory accounting.]

Structure of the series is as follows:

    1) Adds a skeleton DRM cgroup controller with no functionality.
  2-5) Laying down some infrastructure to enable the controller.
    6) The scheduling controller itself.
    7) i915 support for the scheduling controller.
    8) Expose GPU utilisation from the controller.

The proposals defines a delegation of duties between the tree parties: cgroup
controller, DRM core and individual drivers. Two way communication interfaces
are then defined to enable the delegation to work.

DRM weight based time control
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The controller configures the GPU time allowed per group and periodically scans
the belonging tasks to detect the over budget condition, at which point it
invokes a callback notifying the DRM core of the condition.

Because of the heterogenous hardware and driver DRM capabilities, time control
is implemented as a loose co-operative (bi-directional) interface between the
controller and DRM core.

DRM core provides an API to query per process GPU utilization and 2nd API to
receive notification from the cgroup controller when the group enters or exits
the over budget condition.

Individual DRM drivers which implement the interface are expected to act on this
in a best-effort manner. There are no guarantees that the time budget will be
respected.

DRM weight based time control interface files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  drm.stat
	A read-only flat-keyed file.

	Contains these fields:

	- usage_usec - GPU time used by the group, recursively including all
		       child groups.

  drm.weight
	Standard cgroup weight based control [1, 10000] used to configure the
	relative distributing of GPU time between the sibling groups.

This builds upon the per client GPU utilisation work which landed recently for a
few drivers. My thinking is that in principle, an intersection of drivers which
support both that and some sort of scheduling control, like  priorities, could
support this controller relatively easily.

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

 * DRM cgroup controller implements the control files, the scanning loop and
   tracks the DRM clients associated with each cgroup. It provides an API DRM
   core needs to call to (de)register and migrate clients.
 * DRM core defines two call-backs which the core calls directly: First for
   querying GPU time by a client and second for notifying the client that it
   is over budget. It calls controller API for (de)registering clients and
   migrating then between tasks on file descriptor hand over.
 * Individual drivers implement the above mentioned callbacks and register
   them with the DRM core.

What I have demonstrated in practice is that when wired to i915, even in a
primitive way where the over-budget condition simply lowers the scheduling
priority, the concept can be almost equally effective as the static priority
control. I say almost because the design where budget control depends on the
periodic usage scanning has a fundamental initial reaction delay, so
responsiveness will depend on the scanning period, which may or may not be a
problem for a particular use case.

There are also interesting conversations to be had around mental models for what
is GPU usage as a single number when faced with GPUs which have different
execution engines. To an extent this is similar to the multi-core and cgroup
CPU controller problems, but with GPUs it even goes further than that.

I deliberately did not want to include any such complications in the controller
itself and left the individual drivers to handle it. For instance in the i915
over-budget callback it will not do anything unless client's GPU usage is on a
physical engine which is oversubscribed. This enables multiple clients to be
harmlessly over budget, as long as they are not competing for the same GPU
resource.

Example usage from within a Linux desktop
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Standard Linux distributions like Ubuntu already uses cgroups heavily for
session management and that could easily be extended with the DRM controller.

After logging into the system graphically we can enable the DRM controller
throughout the cgroups hierarchy:

echo +drm > /sys/fs/cgroup/cgroup.subtree_control
echo +drm > /sys/fs/cgroup/user.slice/cgroup.subtree_control
echo +drm > /sys/fs/cgroup/user.slice/user-$(id -u).slice/cgroup.subtree_control

Next we will open two SSH sessions, just so separate cgroups are handily created
by systemd for this experiment.

Roughly simultaneously we run the following two benchmarks in each session
respectively:

1)
./GpuTest /test=pixmark_julia_fp32 /width=1920 /height=1080 /fullscreen /no_scorebox /benchmark /benchmark_duration_ms=60000

2)
vblank_mode=0 bin/testfw_app --gl_api=desktop_core --width=1920 --height=1080 --fullscreen 1 --gfx=glfw -t gl_manhattan

(The reason for vsync off here is because I struggled to find an easily runnable
and at the same time demanding enough benchmark, or to run on a screen large
enough to make even some simple ones demanding enough.)

With this test we get 252fps from GpuTest and 96fps from GfxBenchmark.

Premise here is that one of these GPU intensive benchmarks is intended to be ran
by the user with lower priority. Imagine kicking off some background compute
processing and continuing to use the UI for other tasks. Hence the user will now
re-run the test by first lowering the weight control of the first session (DRM
cgroup):

1)
echo 50 | sudo tee /sys/fs/cgroup/`cut -d':' -f3 /proc/self/cgroup`/drm.weight
./GpuTest /test=pixmark_julia_fp32 /width=1920 /height=1080 /fullscreen /no_scorebox /benchmark /benchmark_duration_ms=60000

2)
vblank_mode=0 bin/testfw_app --gl_api=desktop_core --width=1920 --height=1080 --fullscreen 1 --gfx=glfw -t gl_manhattan

In this case we will see that GpuTest has recorded 208fps (~18% down) and
GfxBenchmark 114fps (18% up), demonstrating that even a very simple approach of
wiring up i915 to the DRM cgroup controller can enable somewhat effective
external GPU scheduling control.

* Note here that default weight is 100, so setting 50 for the background session
  is asking the controller to give it half as much GPU bandwidth.

We can also show an example of GPU utilisation querying on a standard Linux
install:

localhost:/sys/fs/cgroup# grep -H . ./drm.stat ./user.slice/drm.stat ./system.slice/drm.stat
./drm.stat:usage_usec 59019083
./user.slice/drm.stat:usage_usec 48249318
./system.slice/drm.stat:usage_usec 10769765

Here it is visible that the GPU utilisation can be correctly queried per cgroup.

v2:
 * Prefaced the series with some core DRM work as suggested by Christian.
 * Dropped the priority based controller for now.
 * Dropped the introspection cgroup controller file.
 * Implemented unused budget sharing/propagation.
 * Some small fixes/tweak as per review feedback and in general.

v3:
 * Dropped one upstreamed patch.
 * Logging cleanup (use DRM macros where available).

v4:
 * Dropped the struct pid tracking indirection in favour of tracking individual
   DRM clients directly in the controller. (Michal Koutný)
 * Added boot time param for configuring the scanning period. (Tejun Heo)
 * Improved spreading of unused budget to over budget clients, regardless of
   their location in the tree so that all unused budget can be utilized.
 * Made scanning more robust by not re-starting it on every client de-
   registration and removal. Instead new baseline GPU activity data is simply
   collected on those events and next scan invocation can proceed as scheduled.
 * Dropped the debugging aids from the series.

v5:
 * Exposed GPU utilisation.
 * Added memory stats.

v6:
 * Dropped memory stats to avoid diluting focus.
 * Fixed CONFIG_CGROUP_DRM=n build.
 * Dropped one resolved question from the code.
 * Emit logging if scanning period modparam is set too low.
 * Survive tree modifications while recording the baseline.
 * Retired the "soft limits" wording. (Tejun)
 * Tweaked the stats file to mimic the CPU controller. (Tejun)

TODOs/Opens:

 * For now (RFC) I haven't implemented the 2nd suggestion from Tejun of having
   a shadow tree which would only contain groups with DRM clients. (Purpose
   being less nodes to traverse in the scanning loop.)

 * Allowing per DRM card configuration and queries is deliberatly left out but
   it is compatible in principle with the current proposal.

   Where today we have, for drm.weight:

   100

   We can later extend with:

   100
   card0 80
   card1 20

   Similarly for drm.stat:

   usage_usec 1000
   card0.usage_usec 500
   card1.usage_usec 500

Tvrtko Ursulin (8):
  cgroup: Add the DRM cgroup controller
  drm/cgroup: Track DRM clients per cgroup
  drm/cgroup: Add ability to query drm cgroup GPU time
  drm/cgroup: Add over budget signalling callback
  drm/cgroup: Only track clients which are providing drm_cgroup_ops
  cgroup/drm: Introduce weight based drm cgroup control
  drm/i915: Implement cgroup controller over budget throttling
  cgroup/drm: Expose GPU utilisation

 Documentation/admin-guide/cgroup-v2.rst       |  39 ++
 drivers/gpu/drm/drm_file.c                    |   6 +
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |  38 +-
 drivers/gpu/drm/i915/i915_driver.c            |  11 +
 drivers/gpu/drm/i915/i915_drm_client.c        | 203 +++++-
 drivers/gpu/drm/i915/i915_drm_client.h        |  11 +
 include/drm/drm_drv.h                         |  36 ++
 include/drm/drm_file.h                        |   6 +
 include/linux/cgroup_drm.h                    |  29 +
 include/linux/cgroup_subsys.h                 |   4 +
 init/Kconfig                                  |   7 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/drm.c                           | 608 ++++++++++++++++++
 13 files changed, 989 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

-- 
2.39.2


