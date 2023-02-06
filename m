Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E2E68C881
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 22:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBFVVJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 16:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBFVVI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 16:21:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52AD1716B
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 13:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675718467; x=1707254467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oOMOY8LLrCs8UUvKbPbScwtm0njsbY4fgCgiPc84ANI=;
  b=HELr36d6uUcZCelGuKA5vchPbFg105UFUWAlKlEhbB0s6YbE+afB6L3q
   p6zNVzOWnI8w/PtkzgBG91vQQBakUy2LqAmL62hoHUYu+9eKc7TV0aRf1
   bzvUTYnEraztcCDFEab6OD/vqhGy3PQIcZF7JR1g7BHFmrnP2ci3Vy1YM
   Ang0AS4uOy26xmn3ypPAfmsf8v11tLoBMHc/lx4hpBb/tP+Wh5a8vt5cM
   hZ88RzbbPts7jSF+gVaeBNKkrez+KqQ/TupRFHo7g5EGHlIfpGC13Dkuk
   EdmbPcOPlBxAjIgi77ILguYu0jh/9xC0G60XJ0shvygLHPNhRTfGWdDiv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="312972921"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312972921"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 13:21:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616565626"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616565626"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 13:21:07 -0800
Date:   Mon, 6 Feb 2023 13:21:05 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, Ramesh Thomas <ramesh.thomas@intel.com>
Subject: Using cgroup membership for resource access control?
Message-ID: <Y+FvQbfTdcTe9GVu@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

Cgroups primary function seems to be to divide limited resources and
make sure that they are allocated "fairly" (where the sysadmin decides
what is fair, and how much of each resource should be made available to
groups of processes).

Intel has a h/w feature in the DSA (Data Streaming Accelerator) device
that will allow a process to offer access to bounded virtual windows
into its address space to other processes.

The case where one process wants to make this offer to just one other
process seems simple.

But the h/w allows, and a process might want, to offer a virtual window
to several other processes. As soon as anyone says the words "several
processes" the immediate thought is "can cgroups help with this?"

I'm thinking along these lines:

1) Sysadmin creates a cgroup for a "job". Initializes the limits on
how many of these virtual windows can be used (h/w has a fixed number).
Assigns tasks in the job to this cgroup.

2) Tasks in the job that want to offer virtual windows call into the
driver to allocate and partially set up windows tagged with "available
to any other process in my cgroup".

3) Other tasks in the group ask the driver to complete the h/w
initialization by adding them (their PASID) to the access list
for each window.

My questions:

1) Is this horrible - have I misunderstood cgroups?
	1a) If this is horrible, can it be rescued?

2) Will it work - is "membership in a cgroup" a valid security mechanism?

3) Has someone done something similar before (so I can learn from their code)?

4) Is there an existing exported API to help. I see task_cgroup_path()
which looks generally helpful (though I'd prefer a task_cgroup() that
just takes a task and gives me the cgroup to which it belongs.)

Thanks

-Tony
