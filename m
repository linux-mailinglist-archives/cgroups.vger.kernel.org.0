Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B8D604EB4
	for <lists+cgroups@lfdr.de>; Wed, 19 Oct 2022 19:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJSRdX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Oct 2022 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJSRdW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Oct 2022 13:33:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77631C19D5;
        Wed, 19 Oct 2022 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666200801; x=1697736801;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1rzbHXSDTF9kSQKAGkXBlCWE2acf03cl0S7cxgjoDng=;
  b=LedX074FKPQ+NBNfF7wisdPWniB33HEkVk27vUt6q5+0uDYYNrxtS8l9
   eodGRypbVDYOFY4c2pjF4dXGX8O+Xq1QrMyVR29GfXo2qb0OBUK7a/6VB
   jHKRImXHMElLjO5XWT5FNSDJ0AyNYPJb4XFe8uYSrEUoCgKRHVRJDPtZN
   ZPyJHxw7CV90d0oZDDF891p+nD2aElSkyzyj9SxWX2YGa+9UUv1k7Bkco
   k5zK3sVF4bQMEBe4H2Q2I95N1b8kfEo6bFhIN8i8HOm1vi4U24WtQpuxZ
   osDTGFYw3OLRfEfpXWmYXnA73F2KTsjovsdI55/J1D/r+3nSR+TAXM7FV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306474266"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306474266"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:33:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607204657"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607204657"
Received: from mjmcener-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.213.233.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:33:15 -0700
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
Subject: [RFC 00/17] DRM scheduling cgroup controller
Date:   Wed, 19 Oct 2022 18:32:37 +0100
Message-Id: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

This series contains two independent proposals for a DRM scheduling cgroup
controller: static priority based controller and GPU usage budget based
controller.

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

To re-iterate, two proposal are completely functionaly independent and can be
evaluated and progressed independently.

Structure of the series is as follows:

    1) Adds a skeleton DRM cgroup controller with no functionality.
  2-6) First proposal - static priority based controller.
    7) i915 adds support for the static priority based controller.
 8-14) Second proposal - GPU usage based controller.
15-17) i915 adds support for the GPU usage based controller.

Both proposals define a delegation of duties between the tree parties: cgroup
controller, DRM core and individual drivers. Two way communication interfaces
are then defined to enable the delegation to work. Principle of discoverability
is also employed so that the level of supported functionality can be observed
in situation when there are multiple GPUs in use, each with a different set of
scheduling capabilities.

DRM static priority control
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Static priority control exposes a hierarchical control interface for the
scheduling priority support present in many DRM device drivers.

Hierarchical meaning that the child group priorities are relative to their
parent. As an example:

	A=-1000
	   /\
	  /  \
	 /    \
	B=0   C=100

This results in the effective priority of a group B of -1000 and C of -900. In
other words the fact C is configured for elevated priority is relative to its
parent being a low priority and hence is only elevated in the context of its
siblings.

The scope of individual DRM scheduling priority may be per device or per device
driver, or a combination of both, depending on the implementation. The
controller does not ensure any priority ordering across multiple DRM drivers nor
does it impose any further policy and leaves desired configuration to the system
administrator.

Individual DRM drivers are required to transparently convert the cgroup priority
into values suitable for their capabilities.

No guarantees on effectiveness or granularity are provided by the controller,
apart the available range being chosen to be an integer and hence allowing a
generic concept of normal (zero), lower (negative values) and higher (positive
values) priority.

DRM static priority interface files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  drm.priority_levels
	One of:
	 1) And integer representing the minimum number of discrete priority
	    levels for the whole group.
	    Optionally followed by an asterisk ('*') indicating some DRM clients
	    in the group support more than the minimum number.
	 2) '0'- indicating one or more DRM clients in the group has no support
	    for static priority control.
	 3) 'n/a' - when there are no DRM clients in the configured group.

  drm.priority
	A read-write integer between -10000 and 10000 (inclusive) representing
	an abstract static priority level.

  drm.effective_priority
	Read only integer showing the current effective priority level for the
	group. Effective meaning taking into account the chain of inherited

This approach should work with all DRM drivers which support priority control,
for instance i915, amdgpu or msm. In the future possibly all that are built on
top of the drm/scheduler as well.

I considered a few options for priority control including range based (min/max
limits, or a flavour of) but ended up settling for simplest one. Mainly because
of the limited priority level support with some drivers, and so to enable adding
wide spread support as easily as possible.

All that is required to enable the setup to be useful is for the drivers to
support the concept of a low, normal and high scheduling priority, which can
then be mapped to from the abstract negatitve, default zero and positive cgroup
priorities.

If range based controls are later wanted they can be added in a backward
compatible manner. Until then priority overlap is possible meaning groups need
to be correctly configured by the "administrator" (entity configuring cgroup
usage on a given system).

As mentioned before, this controller can be easily integrated with the current
ChromeOS architecture for managing CPU bandwith of focused versus unfocused
VM windows. As the OS re-configures the respective CPU shares in a respective
cgroup on a window focus status change, DRM cgroup controller could be attached
to the same group and DRM scheduling priority changed at the same time.

I have ran an experiment where I have shown that doing this can enable the
foreground browser window hit 60fps with no dropped frames, when faced with a
Android game runnning in the background, where if DRM priorities were not used
foreground window was only able to maintain around 45fps.

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

  drm.period_us
	An integer representing the period with which the controller should look
	at the GPU usage by the group and potentially send the over/under budget
	signal.
	Value of zero (defaul) disables the soft limit checking.

  drm.budget_supported
	One of:
	 1) 'yes' - when all DRM clients in the group support the functionality.
	 2) 'no' - when at least one of the DRM clients does not support the
		   functionality.
	 3) 'n/a' - when there are no DRM clients in the group.

The second proposal is a little bit more advanced in concept and also a little
bit less finished. Interesting thing is that it builds upon the per client GPU
utilisation work which landed recently for a few drivers. So my thinking is that
in principle, an intersect of drivers which support both that and some sort of
priority scheduling control, could also in theory support this.

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

The unfinished part is the GPU budgeting split which currently does not
propagate unused bandwith to children, neither can share it with siblings. But
this is not due fundamental reasons, just to avoid spending too much time on it
too early.

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

Tvrtko Ursulin (17):
  cgroup: Add the DRM cgroup controller
  drm: Track clients per owning process
  cgroup/drm: Support cgroup priority control
  drm/cgroup: Allow safe external access to file_priv
  drm: Connect priority updates to drm core
  drm: Only track clients which are providing drm_cgroup_ops
  drm/i915: i915 priority
  drm: Allow for migration of clients
  cgroup/drm: Introduce weight based drm cgroup control
  drm: Add ability to query drm cgroup GPU time
  drm: Add over budget signalling callback
  cgroup/drm: Client exit hook
  cgroup/drm: Ability to periodically scan cgroups for over budget GPU
    usage
  cgroup/drm: Show group budget signaling capability in sysfs
  drm/i915: Migrate client to new owner on context create
  drm/i915: Wire up with drm controller GPU time query
  drm/i915: Implement cgroup controller over budget throttling

 Documentation/admin-guide/cgroup-v2.rst       | 100 +++
 drivers/gpu/drm/Kconfig                       |   1 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/drm_cgroup.c                  | 294 +++++++
 drivers/gpu/drm/drm_file.c                    |  22 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c   |   3 +
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |  45 +-
 drivers/gpu/drm/i915/i915_driver.c            |  12 +
 drivers/gpu/drm/i915/i915_drm_client.c        | 183 ++++-
 drivers/gpu/drm/i915/i915_drm_client.h        |  15 +
 include/drm/drm_clients.h                     |  50 ++
 include/drm/drm_drv.h                         |  73 ++
 include/drm/drm_file.h                        |  15 +
 include/linux/cgroup_drm.h                    |  18 +
 include/linux/cgroup_subsys.h                 |   4 +
 init/Kconfig                                  |   8 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/drm.c                           | 764 ++++++++++++++++++
 18 files changed, 1594 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_cgroup.c
 create mode 100644 include/drm/drm_clients.h
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

-- 
2.34.1

