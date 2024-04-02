Return-Path: <cgroups+bounces-2268-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037E6894CC8
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 09:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED301C21F0C
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 07:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0596A3BBC3;
	Tue,  2 Apr 2024 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNMMpQJi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000432C8B;
	Tue,  2 Apr 2024 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043812; cv=none; b=Nz13lVrFoCQNjDqXZNywdp6vDkVOPJz4hPp2V8yQmd4HmCqOUMWBxUmhbiVsBPymK21THzGh09jS6yPmhwXZkcnTlz+o5JZNq9NaDl9m9KdR2n8widF7jZSXwNJAOq8ImZRiSsUROJgQaJLmMwnQDERWf6oPgrwq6JvICT3aalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043812; c=relaxed/simple;
	bh=lOeUlS13nUasibcKAc+APQJ2GhDUpD5w9apCgLzBdJE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=hMUxfn3yIFCN8LB1lem57NR7B3xHKbHZq6d167b3Atb9zi3m1IaLIkVZL7phtx9v2MKlRrRQSzmGuxDb5qrnVY6sX1UqHQn17Vb13WBbJ7t8amimsgvjYbzyPkp1Q+wlVJegDmHP5EGedGbNdWAgRxjeBPBbDQdF5F/qEEamWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNMMpQJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2DFC433C7;
	Tue,  2 Apr 2024 07:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712043812;
	bh=lOeUlS13nUasibcKAc+APQJ2GhDUpD5w9apCgLzBdJE=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=rNMMpQJi+z+zXGyHrgy/DaCtRevEEQ2tWUaeN8zXTqLSVU39HoUSZ+2WR1yJCDzUW
	 DCJjUe6N6V+1DAlLXPtlQ5ZHQbWc8ZdmJjOjW4ZtIqFqI1QhOx9tT0eH/478GSmmju
	 hnl7rpHkzPa+GYy9qktz7b9hScg9TGVHIHsFc0Bnd3yarZf6p2X+Gf7WCmeR5MNeSX
	 mop2J/pam1R2GlPb6+5DbUXYdqb6Sgsy5NT6AYUr92tPb+wzghIA2/n5ieiUm28lDw
	 91DOnwCWeBfJ/kdIWnQPR7WfeUpUEbq1sR1Ga6r4kCY7dsO2rlGYxaJ/T8PvgK/bNY
	 UWsTtxzmgfyOA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Apr 2024 10:43:25 +0300
Message-Id: <D09GVMLN1O4Z.2RXQUH4ZY5IVF@kernel.org>
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
In-Reply-To: <20240402014254.27717-1-haitao.huang@linux.intel.com>

On Tue Apr 2, 2024 at 4:42 AM EEST, Haitao Huang wrote:
> Make cgroup test scripts ash compatible.
> Remove cg-tools dependency.
> Add documentation for functions.
>
> Tested with busybox on Ubuntu.
>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> v2:
> - Fixes for v2 cgroup
> - Turn off swapping before memcontrol tests and back on after
> - Add comments and reformat
> ---
>  tools/testing/selftests/sgx/ash_cgexec.sh     |  57 ++++++
>  .../selftests/sgx/run_epc_cg_selftests.sh     | 187 +++++++++++-------
>  .../selftests/sgx/watch_misc_for_tests.sh     |  13 +-
>  3 files changed, 179 insertions(+), 78 deletions(-)
>  create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh
>
> diff --git a/tools/testing/selftests/sgx/ash_cgexec.sh b/tools/testing/se=
lftests/sgx/ash_cgexec.sh
> new file mode 100755
> index 000000000000..9607784378df
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/ash_cgexec.sh
> @@ -0,0 +1,57 @@
> +#!/usr/bin/env sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2024 Intel Corporation.
> +
> +# Move the current shell process to the specified cgroup
> +# Arguments:
> +# 	$1 - The cgroup controller name, e.g., misc, memory.
> +#	$2 - The path of the cgroup,
> +#		relative to /sys/fs/cgroup for cgroup v2,
> +#		relative to /sys/fs/cgroup/$1 for v1.
> +move_to_cgroup() {
> +    controllers=3D"$1"
> +    path=3D"$2"
> +
> +    # Check if cgroup v2 is in use
> +    if [ ! -d "/sys/fs/cgroup/misc" ]; then
> +        # Cgroup v2 logic
> +        cgroup_full_path=3D"/sys/fs/cgroup/${path}"
> +        echo $$ > "${cgroup_full_path}/cgroup.procs"
> +    else
> +        # Cgroup v1 logic
> +        OLD_IFS=3D"$IFS"
> +        IFS=3D','
> +        for controller in $controllers; do
> +            cgroup_full_path=3D"/sys/fs/cgroup/${controller}/${path}"
> +            echo $$ > "${cgroup_full_path}/tasks"
> +        done
> +        IFS=3D"$OLD_IFS"
> +    fi

I think that if you could point me to git v10 and all this I could
then quite easily create test image and see what I get from that.

I will code review the whole thing but this is definitely good
enough to start testing this series properly! Thanks for the
effort with this. The payback from this comes after the feature
is mainline. We have now sort of reference of the usage patterns
and less layers when we need to debug any possible (likely) bugs
in the future.

This is definitely to the right direction. I'm just wondering do
we want to support v1 cgroups or would it make sense support only
v2?
=20
BR, Jarkko

