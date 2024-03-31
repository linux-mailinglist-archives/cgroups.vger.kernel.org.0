Return-Path: <cgroups+bounces-2256-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D2893542
	for <lists+cgroups@lfdr.de>; Sun, 31 Mar 2024 19:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8915A1F219C3
	for <lists+cgroups@lfdr.de>; Sun, 31 Mar 2024 17:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B2C14534A;
	Sun, 31 Mar 2024 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHvgWdYh"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBA1DDCE;
	Sun, 31 Mar 2024 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711906565; cv=none; b=SgXelR8bXw8ID3Ss21FPYU304txwMe/RR9IhDfz9QOShbgiir5CiDuvzxtVGeIaNa6DqeGJs5UdLuJkRj4/16H+8LevNahbzKl33+eujGdBHCl4cGuNirwCLlVNl4dknOV9BrbfzUgyZqZ0cp7TmtrpPp3xBlJDDtdxFFfqKfvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711906565; c=relaxed/simple;
	bh=5G1GEIWNh4wgtSrPSubJRUDD7diK+EByYdDzXtFnNpw=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=o3LuuoH1mJ1r/sUCCWHTG0uRNbSDLpEQh7ncW6hRxqGyVPCZw4xng9+H4YKRaax7UP2vTNB/CTtSSeS/F3r97Q5CV5A1DK95hkU8lxogTWTHvlJBeqDEGOdjrhtpbmw4r5PBrPr9soPROtz/4Qd3ld/0DlyKyvbuH3q2oOHcvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHvgWdYh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711906563; x=1743442563;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=5G1GEIWNh4wgtSrPSubJRUDD7diK+EByYdDzXtFnNpw=;
  b=mHvgWdYhLKOQXnUbG4kaXPTjcfKMopy862/X43oREgtiEYE5bRsP306g
   /wO8df2s9pTzGq+K4pFeuW/MK82P1T6VcQj/1zUI5o+cqIXdaH3vLaxfw
   oKzHF1h4XAwt+HVRwAurGvpPxXYKTFfToa5/GlaMzxMwo/01ia5dc7dtD
   KKG8yy0Qgpp0iHu1k3P+8ME+zHdz79UCjBQghuEX7dbxQvU5eOvLLEV2z
   fo3e4qZ/0+UUAyNeAuuZSnViTj0web/dmMxiZcdQEGz9Ou8rEmtvuKypB
   RmvKfTgUbKOw/f4UiXqPkIqv1m2zobm7zKS0GzhpZVI49bYH2YkVKdYes
   w==;
X-CSE-ConnectionGUID: ZqIlcroiRfGOdnlGsxz5Ug==
X-CSE-MsgGUID: FD0rlwbBTUqIHmWo3Xr0gQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="17602858"
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="17602858"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 10:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="48475200"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 31 Mar 2024 10:36:00 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, tim.c.chen@linux.intel.com, "Jarkko
 Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
 <op.2lbrsagbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D071I61AGNZ7.HQGKJZI2D5UW@kernel.org>
 <op.2lgdg1tpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D082LCMM4PMU.GN9HOSMXOQR@kernel.org>
Date: Sun, 31 Mar 2024 12:35:56 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2lidt6qmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D082LCMM4PMU.GN9HOSMXOQR@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Sun, 31 Mar 2024 11:19:04 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Sat Mar 30, 2024 at 5:32 PM EET, Haitao Huang wrote:
>> On Sat, 30 Mar 2024 06:15:14 -0500, Jarkko Sakkinen <jarkko@kernel.org>
>> wrote:
>>
>> > On Thu Mar 28, 2024 at 5:54 AM EET, Haitao Huang wrote:
>> >> On Wed, 27 Mar 2024 07:55:34 -0500, Jarkko Sakkinen  
>> <jarkko@kernel.org>
>> >> wrote:
>> >>
>> >> > On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
>> >> >> The scripts rely on cgroup-tools package from libcgroup [1].
>> >> >>
>> >> >> To run selftests for epc cgroup:
>> >> >>
>> >> >> sudo ./run_epc_cg_selftests.sh
>> >> >>
>> >> >> To watch misc cgroup 'current' changes during testing, run this  
>> in a
>> >> >> separate terminal:
>> >> >>
>> >> >> ./watch_misc_for_tests.sh current
>> >> >>
>> >> >> With different cgroups, the script starts one or multiple  
>> concurrent
>> >> >> SGX
>> >> >> selftests, each to run one unclobbered_vdso_oversubscribed  
>> test.Each
>> >> >> of such test tries to load an enclave of EPC size equal to the EPC
>> >> >> capacity available on the platform. The script checks results  
>> against
>> >> >> the expectation set for each cgroup and reports success or  
>> failure.
>> >> >>
>> >> >> The script creates 3 different cgroups at the beginning with
>> >> >> following
>> >> >> expectations:
>> >> >>
>> >> >> 1) SMALL - intentionally small enough to fail the test loading an
>> >> >> enclave of size equal to the capacity.
>> >> >> 2) LARGE - large enough to run up to 4 concurrent tests but fail  
>> some
>> >> >> if
>> >> >> more than 4 concurrent tests are run. The script starts 4  
>> expecting
>> >> >> at
>> >> >> least one test to pass, and then starts 5 expecting at least one  
>> test
>> >> >> to fail.
>> >> >> 3) LARGER - limit is the same as the capacity, large enough to run
>> >> >> lots of
>> >> >> concurrent tests. The script starts 8 of them and expects all  
>> pass.
>> >> >> Then it reruns the same test with one process randomly killed and
>> >> >> usage checked to be zero after all process exit.
>> >> >>
>> >> >> The script also includes a test with low mem_cg limit and LARGE
>> >> >> sgx_epc
>> >> >> limit to verify that the RAM used for per-cgroup reclamation is
>> >> >> charged
>> >> >> to a proper mem_cg.
>> >> >>
>> >> >> [1] https://github.com/libcgroup/libcgroup/blob/main/README
>> >> >>
>> >> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> >> >> ---
>> >> >> V7:
>> >> >> - Added memcontrol test.
>> >> >>
>> >> >> V5:
>> >> >> - Added script with automatic results checking, remove the
>> >> >> interactive
>> >> >> script.
>> >> >> - The script can run independent from the series below.
>> >> >> ---
>> >> >>  .../selftests/sgx/run_epc_cg_selftests.sh     | 246
>> >> >> ++++++++++++++++++
>> >> >>  .../selftests/sgx/watch_misc_for_tests.sh     |  13 +
>> >> >>  2 files changed, 259 insertions(+)
>> >> >>  create mode 100755
>> >> >> tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>> >> >>  create mode 100755
>> >> >> tools/testing/selftests/sgx/watch_misc_for_tests.sh
>> >> >>
>> >> >> diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>> >> >> b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>> >> >> new file mode 100755
>> >> >> index 000000000000..e027bf39f005
>> >> >> --- /dev/null
>> >> >> +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>> >> >> @@ -0,0 +1,246 @@
>> >> >> +#!/bin/bash
>> >> >
>> >> > This is not portable and neither does hold in the wild.
>> >> >
>> >> > It does not even often hold as it is not uncommon to place bash
>> >> > to the path /usr/bin/bash. If I recall correctly, e.g. NixOS has
>> >> > a path that is neither of those two.
>> >> >
>> >> > Should be #!/usr/bin/env bash
>> >> >
>> >> > That is POSIX compatible form.
>> >> >
>> >>
>> >> Sure
>> >>
>> >> > Just got around trying to test this in NUC7 so looking into this in
>> >> > more detail.
>> >>
>> >> Thanks. Could you please check if this version works for you?
>> >>
>> >>  
>> https://github.com/haitaohuang/linux/commit/3c424b841cf3cf66b085a424f4b537fbc3bbff6f
>> >>
>> >> >
>> >> > That said can you make the script work with just "#!/usr/bin/env  
>> sh"
>> >> > and make sure that it is busybox ash compatible?
>> >>
>> >> Yes.
>> >>
>> >> >
>> >> > I don't see any necessity to make this bash only and it adds to the
>> >> > compilation time of the image. Otherwise lot of this could be  
>> tested
>> >> > just with qemu+bzImage+busybox(inside initramfs).
>> >> >
>> >>
>> >> will still need cgroup-tools as you pointed out later. Compiling from
>> >> its
>> >> upstream code OK?
>> >
>> > Can you explain why you need it?
>> >
>> > What is the thing you cannot do without it?
>> >
>> > BR, Jarkko
>> >
>> I did not find a nice way to start a process in a specified cgroup like
>> cgexec does. I could wrap the test in a shell: move the current shell  
>> to a
>> new cgroup then do exec to run the test app. But that seems cumbersome  
>> as
>> I need to spawn many shells, and check results of them.  Another option  
>> is
>> create my own cgexec, which I'm sure will be very similar to cgexec  
>> code.
>> Was not sure how far we want to go with this.
>>
>> I can experiment with the shell wrapper idea and see how bad it can be  
>> and
>> fall back to implement cgexec? Open to suggestions.
>
> I guess there's only few variants of how cgexec is invoked right?
>
> The first thing we need to do is what exact steps those variants
> perform.
>
> After that we an decide how to implement exactly those variants.
>
> E.g. without knowing do we need to perform any syscalls or can
> this all done through sysfs affects somewhat how to proceed.
>
> Right now if I want to build e.g. image with BuildRoot I'd need
> to patch the existing recipe to add new dependencies in order to
> execute these tests, and probably do the same for every project
> that can package selftests to image.
>
> BR, Jarkko
>
Can be done through sysfs without syscalls. I implemented the wrapper  
shell and it looks not as bad I expected.
Will send an add-on patch with that change and other changes to address  
your comments so far for the test scripts.
If we agree on the approach, I'll squash it with this one later.

Thanks
Haitao

