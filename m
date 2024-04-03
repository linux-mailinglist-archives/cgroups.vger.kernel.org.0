Return-Path: <cgroups+bounces-2297-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66A3897414
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 17:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826BF289EB4
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 15:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E393814A0B5;
	Wed,  3 Apr 2024 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7ZFqz7M"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47714A092;
	Wed,  3 Apr 2024 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158471; cv=none; b=kMrh93Vc7cb0Y5RKfVFnpT5lylzA1CBb7TsPpWp6vNTdzM+O0zcE9WX0UM+SklGjDkt7InU29Odium/aAuq6wOyCo4zVVYkS0JxE2ywTiiKh99DcKrOIo8ARhJiQkqXqD3kqfvVSl7kqLQIdQvhycu7Hyidc7E1yQ5+E0O2048s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158471; c=relaxed/simple;
	bh=Mxc+CC8sC/scrgK6foejLgrA2eOYbMZE4L+NN/kTniA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=u+QVpBHHLSwJ8IKetn+JaZlzKOFaWeChtWEYOUjOBpz5CaD7egs6evsqlVTystP4oJ+3NkraoFH1zb34d40l83VER07JeUpo7FeJwvPy56BxvE65NE9HQfDfEejr7qv+eLTDxvRHRyLdwREA63pCgbJyl+j53fhN/qqqL8wEAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7ZFqz7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80CEC433F1;
	Wed,  3 Apr 2024 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712158471;
	bh=Mxc+CC8sC/scrgK6foejLgrA2eOYbMZE4L+NN/kTniA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=E7ZFqz7MZg+3CPEomG/D2lcumlgIERtDKcjeo603ozf4CuxA8Ko6KDuBfNfsRukNz
	 iU2nxtDWub9HYPkJtDmGCCZOOoRJR/ydGBKcrp6NnYlBRYUvhEfymlUlTqpAnUTVAB
	 2weWAnkzLdog+IEW+Rp769dAtV+mKoc2j4RpoIQBV2XicEk17tFzhK9cGf9YYMLjUB
	 +h5gU6Qd054+0Rf0BpQSjCeqfbo57b4gGycTh++/hVa9Sji6MojEY21x2Q4mmB8/GO
	 VdCrC4ADZFBuVbDwm7OXooLH2NencpaZLdVwuQ/xEZj/AWdcA/0Qolkj/LBe81KXr6
	 nTrc6IR0Quhvg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Apr 2024 18:34:24 +0300
Message-Id: <D0ALIS78E2UP.O2C1LEQ5NNER@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>
Cc: <anakrish@microsoft.com>, <bp@alien8.de>, <cgroups@vger.kernel.org>,
 <chrisyan@microsoft.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
 <kai.huang@intel.com>, <kristen@linux.intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <mikko.ylinen@linux.intel.com>, <mingo@redhat.com>, <mkoutny@suse.com>,
 <seanjc@google.com>, <sohil.mehta@intel.com>, <tglx@linutronix.de>,
 <tim.c.chen@linux.intel.com>, <tj@kernel.org>, <x86@kernel.org>,
 <yangjie@microsoft.com>, <zhanb@microsoft.com>, <zhiquan1.li@intel.com>
Subject: Re: [PATCH v2] selftests/sgx: Improve cgroup test scripts
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <D08UQJ2XQY6L.1XEOEJ6HIUJ8Y@kernel.org>
 <20240402014254.27717-1-haitao.huang@linux.intel.com>
 <D09GVMLN1O4Z.2RXQUH4ZY5IVF@kernel.org>
 <op.2ll2yyfgwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2ll2yyfgwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Tue Apr 2, 2024 at 8:31 PM EEST, Haitao Huang wrote:
> On Tue, 02 Apr 2024 02:43:25 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Tue Apr 2, 2024 at 4:42 AM EEST, Haitao Huang wrote:
> >> Make cgroup test scripts ash compatible.
> >> Remove cg-tools dependency.
> >> Add documentation for functions.
> >>
> >> Tested with busybox on Ubuntu.
> >>
> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> ---
> >> v2:
> >> - Fixes for v2 cgroup
> >> - Turn off swapping before memcontrol tests and back on after
> >> - Add comments and reformat
> >> ---
> >>  tools/testing/selftests/sgx/ash_cgexec.sh     |  57 ++++++
> >>  .../selftests/sgx/run_epc_cg_selftests.sh     | 187 +++++++++++------=
-
> >>  .../selftests/sgx/watch_misc_for_tests.sh     |  13 +-
> >>  3 files changed, 179 insertions(+), 78 deletions(-)
> >>  create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh
> >>
> >> diff --git a/tools/testing/selftests/sgx/ash_cgexec.sh =20
> >> b/tools/testing/selftests/sgx/ash_cgexec.sh
> >> new file mode 100755
> >> index 000000000000..9607784378df
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/sgx/ash_cgexec.sh
> >> @@ -0,0 +1,57 @@
> >> +#!/usr/bin/env sh
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright(c) 2024 Intel Corporation.
> >> +
> >> +# Move the current shell process to the specified cgroup
> >> +# Arguments:
> >> +# 	$1 - The cgroup controller name, e.g., misc, memory.
> >> +#	$2 - The path of the cgroup,
> >> +#		relative to /sys/fs/cgroup for cgroup v2,
> >> +#		relative to /sys/fs/cgroup/$1 for v1.
> >> +move_to_cgroup() {
> >> +    controllers=3D"$1"
> >> +    path=3D"$2"
> >> +
> >> +    # Check if cgroup v2 is in use
> >> +    if [ ! -d "/sys/fs/cgroup/misc" ]; then
> >> +        # Cgroup v2 logic
> >> +        cgroup_full_path=3D"/sys/fs/cgroup/${path}"
> >> +        echo $$ > "${cgroup_full_path}/cgroup.procs"
> >> +    else
> >> +        # Cgroup v1 logic
> >> +        OLD_IFS=3D"$IFS"
> >> +        IFS=3D','
> >> +        for controller in $controllers; do
> >> +            cgroup_full_path=3D"/sys/fs/cgroup/${controller}/${path}"
> >> +            echo $$ > "${cgroup_full_path}/tasks"
> >> +        done
> >> +        IFS=3D"$OLD_IFS"
> >> +    fi
> >
> > I think that if you could point me to git v10 and all this I could
> > then quite easily create test image and see what I get from that.
> >
> > I will code review the whole thing but this is definitely good
> > enough to start testing this series properly! Thanks for the
> > effort with this. The payback from this comes after the feature
> > is mainline. We have now sort of reference of the usage patterns
> > and less layers when we need to debug any possible (likely) bugs
> > in the future.
> >
> > This is definitely to the right direction. I'm just wondering do
> > we want to support v1 cgroups or would it make sense support only
> > v2?
> > BR, Jarkko
> >
> I can drop v1. I think most distro now support v2.
> Created this branch to host these changes so far: =20
> https://github.com/haitaohuang/linux/tree/sgx_cg_upstream_v10_plus

Thanks!=20

I'll point my build to that, make a test image and report the
results.

BR, Jarkko

