Return-Path: <cgroups+bounces-4906-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B22297CEE2
	for <lists+cgroups@lfdr.de>; Thu, 19 Sep 2024 23:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63459283B5B
	for <lists+cgroups@lfdr.de>; Thu, 19 Sep 2024 21:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39EF18E053;
	Thu, 19 Sep 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a06UjLzx"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DDE1946C2;
	Thu, 19 Sep 2024 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782755; cv=none; b=Y7ymDPtRr/CB529iyIsfEURVnYta+sgzB1PDW1galNHg9/TZphFqzqCGo21Sh5NGxJoKOaVoxNCvVTylZ8HYkzvK4Rjix0BAm/0GZloZhg51Y6NddMgu117fZsdibcMu/I3SuB1wtO6M1NRrAD8FQg6HCjTTGVe34cXoPZfGa4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782755; c=relaxed/simple;
	bh=RHCftHVh0VYEKLZvIPJy7UQLlCOcdazq8yCwXdgPsvU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vCZZ1AbXaV+8j8Mt3C7ARiqgvKVF2Oc/oWn+UCBjYyJpVGRC6Ur5CLqi0BuanE0CPcdxHWQ0CngGb9HDhGAsEGX9UUuN8yz6I2dJ5ZfUClP3NfTueo4NhlNelX4xsXeELseRW8B+D2eAFi5i5BDVdajJCzgTii27vABOiDkGcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a06UjLzx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726782754; x=1758318754;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RHCftHVh0VYEKLZvIPJy7UQLlCOcdazq8yCwXdgPsvU=;
  b=a06UjLzxOfUuF9TmLf4PnaKl3F1PZXN8eNQRjfdLjV1+sR2BK69wp0Io
   jn2+vC8cfoCzKVKFs8wCY3YJINhbZ5/q23mGfX25p4gSI+E+Ak0MkSbrP
   FnP4rTlmC9ZAhiSdpYT+WX/BZxvCUylgaqwLDliih69fF27Yx+h+/Fyka
   sT2HqBwF22vt1UNxaXVz4tdxl50L2brvnftaBuMnieCknhTucRyhTP4IJ
   MKQFrg5QEDewsXyhAHgvVZ0Is8Xwdgc6hkXa6NFMad0qsuXDrSrOYOK+z
   qzOooAF1CCX3j4KdvmJr8XgyBHbaVfuPsD2dj09xbee8ZIQ4aAyiyC5um
   w==;
X-CSE-ConnectionGUID: YMz+nwHgSqGTZworDVsn7Q==
X-CSE-MsgGUID: jIYY2LYFTsSo/2WdSZaCEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25870746"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="25870746"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:52:34 -0700
X-CSE-ConnectionGUID: CGgwDlO/S7WcXIlSY+Y4ZA==
X-CSE-MsgGUID: M+l5qJ78Tt+9fXBEU4UVMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74862540"
Received: from trevorcr-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.197])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:52:33 -0700
Date: Thu, 19 Sep 2024 14:52:31 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Kaplan <David.Kaplan@amd.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH RFC 0/2] Selective mitigation for trusted userspace
Message-ID: <20240919-selective-mitigation-v1-0-1846cf41895e@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAIyc7GYC/x3MTQqAIBBA4avErBNMpKht0AHaRgu1yQb6Q0WC8
 O5Jy7f43gseHaGHrnjBYSRP15mjKgswmzotMlpyg+BC8rZqmccdTaCI7KBAVoUMWL1wYaTWuhE
 aMr0drvT82wnGoYc5pQ/qSdgKawAAAA==
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This is an experimental series exploring the feasibility of selectively
applying CPU vulnerability mitigations on a per-process basis. The
motivation behind this work is to address the performance degradation
experienced by trusted user-space applications due to system-wide CPU
mitigations.

Currently, the mitigations are applied universally across the system,
without discrimination between trusted and untrusted user-space processes.
This results in a performance penalty for all applications, regardless of
their trustworthiness. The proposed solution aims to provide a mechanism
for system administrators to explicitly mark certain applications as
trusted, allowing them to bypass these mitigations and regain lost
performance.

The series introduces a new cgroup attribute and a separate kernel
entry/exit path that can be used to selectively disable CPU mitigations for
processes that are deemed trustworthy by the system administrator. This
approach provides a tool to the administrator who understands the security
implications and is aware of trustworthiness of the applications that they
care.

The rationale for choosing the cgroup interface over other potential
interfaces, such as LSMs, is cgroup's inherent support for core scheduling.
Core scheduling allows the grouping of tasks such that they are scheduled
to run on the same cores. By leveraging core scheduling, we can minimize
the performance overhead caused by the MSR writes during context switching
between trusted and untrusted processes. With the end goal being trusted
and untrusted processes run on separate cores, enhancing the security.

Patch 1 adds the unmitigated entry/exit path.
Patch 2 provides a cgroup knob to bypass CPU mitigations.

This series is lightly tested. Feedback and discussion are welcome.

TODO:
- Add CONFIG_MITIGATION_PER_PROCESS
- Add support for skipping other mitigations like RSB filling.
- Update suspend/resume paths to handle the new entry/exit path.
- Should child processes inherit the parent's unmitigated status?
- Add documentation.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Pawan Gupta (2):
      x86/entry_64: Add a separate unmitigated entry/exit path
      cpu/bugs: cgroup: Add a cgroup knob to bypass CPU mitigations

 arch/x86/entry/entry_64.S        | 66 +++++++++++++++++++++++++++++++++-------
 arch/x86/include/asm/proto.h     | 15 ++++++---
 arch/x86/include/asm/ptrace.h    | 15 ++++++---
 arch/x86/include/asm/switch_to.h | 10 ++++++
 arch/x86/kernel/cpu/bugs.c       | 21 +++++++++++++
 arch/x86/kernel/cpu/common.c     |  2 +-
 include/linux/cgroup-defs.h      |  3 ++
 kernel/cgroup/cgroup.c           | 42 +++++++++++++++++++++++++
 kernel/sched/core.c              |  2 +-
 9 files changed, 155 insertions(+), 21 deletions(-)
---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240919-selective-mitigation-6d02c4bbb72b

-- 
Thanks,
Pawan


