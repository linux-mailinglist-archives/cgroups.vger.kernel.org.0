Return-Path: <cgroups+bounces-1303-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4669084645F
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 00:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B3E1C23E22
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 23:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C5D47A76;
	Thu,  1 Feb 2024 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqDS41EM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BC47A7A;
	Thu,  1 Feb 2024 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706829722; cv=none; b=O+rEGrlt496JnxhpXhBua7xCL+YOTc5SginuUqQyQ4WQMEUU0ZqDl1QPPniXPLpAu4VFZLO7Jx7d2z9p+m6ViUNtXmwqPnSswHvLuwfZMSow9uuJYr9i8XLRtz9A4Q1cyKqfpbh3/q946lYb8dQwcojhxtBTr4by1iBAw61msPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706829722; c=relaxed/simple;
	bh=G6WlvYnkVrB0wsoSQYsuZNh4sVfvs3Gqe3vjwXFttD0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Xoh65GdyQkQ+8iIkaU9rjAGQSrxGvunmIpcVcBYiDGy3x3G8c7JpZV8XaIgDjiYJZOmrroxtUkRDHVD1NazVUwcZx7kowTXVkivzXmsdyIJcHzOBPqLF0AcR5qzV5i4458R0ljp6VvAk9HdUNxxGH2DjmZ3XKooKvAH3yvVknaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqDS41EM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05682C433F1;
	Thu,  1 Feb 2024 23:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706829722;
	bh=G6WlvYnkVrB0wsoSQYsuZNh4sVfvs3Gqe3vjwXFttD0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=sqDS41EMGOKSBtpX0WoSlvxKFtrclrRkhidXvwtvZp3GiKfjUuf1zT+Qq5+HQeFIG
	 FX/EgpYJbGWDtWn5MIGOgeTGK8lrvxJGgbGyoOmcEkn5Bt8KyRdduvZe3CBmrgBwb6
	 oPTMPL5cndZ2Z3qGzpcL27tk/8ETXgVGtJXbUv91sI1z5gT9ZhfJ4pogF45nJOENXI
	 TJqkM3/7nck+eqDhc9F3gSsevRw10vaaIN904xBfL7J8/H9YKltcxw1fdAXDIvZQIT
	 vnjthjzHwSN8R6zMCvfhhgqkA7tlkR1pBR9shzlY5fU4irt0b64FqMlW7S8qd3SIDo
	 FDrlmxqz+Eeeg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 01:21:56 +0200
Message-Id: <CYU4MYUKCVN2.1RWCHNS9QO7XB@suppilovahvero>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>
Subject: Re: [PATCH v7 04/15] x86/sgx: Implement basic EPC misc cgroup
 functionality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-5-haitao.huang@linux.intel.com>
 <CYLIJZZJON62.24BNN310T3B2F@suppilovahvero>
 <op.2h07ypcmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2h07ypcmwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Wed Jan 24, 2024 at 5:29 AM EET, Haitao Huang wrote:
> On Mon, 22 Jan 2024 14:25:53 -0600, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Mon Jan 22, 2024 at 7:20 PM EET, Haitao Huang wrote:
> >> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> >>
> >> SGX Enclave Page Cache (EPC) memory allocations are separate from norm=
al
> >> RAM allocations, and are managed solely by the SGX subsystem. The
> >> existing cgroup memory controller cannot be used to limit or account f=
or
> >> SGX EPC memory, which is a desirable feature in some environments.  Fo=
r
> >> example, in a Kubernates environment, a user can request certain EPC
> >> quota for a pod but the orchestrator can not enforce the quota to limi=
t
> >> runtime EPC usage of the pod without an EPC cgroup controller.
> >>
> >> Utilize the misc controller [admin-guide/cgroup-v2.rst, 5-9. Misc] to
> >> limit and track EPC allocations per cgroup. Earlier patches have added
> >> the "sgx_epc" resource type in the misc cgroup subsystem. Add basic
> >> support in SGX driver as the "sgx_epc" resource provider:
> >>
> >> - Set "capacity" of EPC by calling misc_cg_set_capacity()
> >> - Update EPC usage counter, "current", by calling charge and uncharge
> >> APIs for EPC allocation and deallocation, respectively.
> >> - Setup sgx_epc resource type specific callbacks, which perform
> >> initialization and cleanup during cgroup allocation and deallocation,
> >> respectively.
> >>
> >> With these changes, the misc cgroup controller enables user to set a =
=20
> >> hard
> >> limit for EPC usage in the "misc.max" interface file. It reports curre=
nt
> >> usage in "misc.current", the total EPC memory available in
> >> "misc.capacity", and the number of times EPC usage reached the max lim=
it
> >> in "misc.events".
> >>
> >> For now, the EPC cgroup simply blocks additional EPC allocation in
> >> sgx_alloc_epc_page() when the limit is reached. Reclaimable pages are
> >> still tracked in the global active list, only reclaimed by the global
> >> reclaimer when the total free page count is lower than a threshold.
> >>
> >> Later patches will reorganize the tracking and reclamation code in the
> >> global reclaimer and implement per-cgroup tracking and reclaiming.
> >>
> >> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> >> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >
> > For consistency sake I'd also add co-developed-by for Kristen. This is
> > at least the format suggested by kernel documentation.
> >
> She is the "From Author", so only Signed-off-by is needed for her =20
> according to the second example in the doc[1]?

Right but okay then Kristen afaik  be the last sob so only re-ordering
is needed I guess.

>
> Thanks
> Haitao
> [1]https://docs.kernel.org/process/submitting-patches.html#when-to-use-ac=
ked-by-cc-and-co-developed-by

BR, Jarkko

