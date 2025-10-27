Return-Path: <cgroups+bounces-11233-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB74AC121A2
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B856351F0C
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3A5333734;
	Mon, 27 Oct 2025 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjqGamAZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7E33031F;
	Mon, 27 Oct 2025 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608911; cv=none; b=PZCy3lTVRYEeoMKAfRM6tTLolFTZ19PYahHDr9yuqaKd7dWk7sgms6ddZVP90VQyBIM/pM36JKH8/oE0lZ312mL3CfGvTA2lOSmeRx1d/3js7DY1KZRGZTCg+M9KNWNEHP7O4c3Eht41Pbr14tJNM96S9WU3Wz8ZYXfc5e/cXFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608911; c=relaxed/simple;
	bh=zTR7NNf/0/v66tZ9uBGApZ4ujktgFV1nV9bNyBtCkTQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cFckWawYTWEUskzW5tqIsQDH89x+5VRPBXRESFAD5lQfl6dg6G5J5HplshKVOx5zpWkcADXgJy10UxQOWybadlJ21ABBHsishHZ5HrHRN4ymE56oUqKgoDlCxWLaPZFXgEbITFHYsHLbukgy+5+1xbV2/H6B1LwvNpUkwrslz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjqGamAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59EAC4CEF1;
	Mon, 27 Oct 2025 23:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761608910;
	bh=zTR7NNf/0/v66tZ9uBGApZ4ujktgFV1nV9bNyBtCkTQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IjqGamAZxJF+TwcJQx9bAyTi3yBwvFFX9hLNbgr/GOomJEIGfSIqEUz5tZ05Ji0LM
	 neYa0tZUKxXMHYwhnxTRQhhheBO+DNEz6c2nu0x8Q926psVnohcuVRnDhC8Qzganc7
	 mHvtqyE0FcEb4/RpZYS7FTsrVQaJj6JArFr8xoPiixfK15bq8uN2FyshkpGEhCBdw9
	 +Hg/0M4GrSULoixm0TP1DQBFMFLBFVKbXfdQBI2ywVoZK4WALgY39bkAZOQj0ZdnKa
	 mS3AEn/Efpe02m+N/9/dM5uk84UXGGKd5bPNPZAPawlxUrlS4ttlfu+dOeNS8Dc8RV
	 bRXHJgbBvP5qw==
Content-Type: multipart/mixed; boundary="===============1951758182374278910=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab8c7bf2f312e150c22d83e5ebe91e17f3c4be42b3ff0825623caf3aac4086af@mail.kernel.org>
In-Reply-To: <20251027232206.473085-13-roman.gushchin@linux.dev>
References: <20251027232206.473085-13-roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 23/23] bpf: selftests: PSI struct ops test
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,surenb@google.com,mhocko@kernel.org,shakeel.butt@linux.dev,hannes@cmpxchg.org,andrii@kernel.org,inwardvessel@gmail.com,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,martin.lau@kernel.org,song@kernel.org,memxor@gmail.com,tj@kernel.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Oct 2025 23:48:28 +0000 (UTC)

--===============1951758182374278910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 70a4d534559f5708a811241190cd158e83451a42
Author: Roman Gushchin <roman.gushchin@linux.dev>

bpf: selftests: PSI struct ops test

This patch adds a BPF selftest for PSI struct ops functionality,
including cgroup lifecycle callbacks, PSI trigger creation, and
memory pressure event handling.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_psi.c b/tools/testing/selftests/bpf/prog_tests/test_psi.c
> new file mode 100644
> index 000000000..b294cea0a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_psi.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_psi.c b/tools/testing/selftests/bpf/progs/test_psi.c
> new file mode 100644
> index 000000000..4ddec7ec3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_psi.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define PSI_FULL 0x80000000
> +
> +/* cgroup which will experience the high memory pressure */
> +u64 high_pressure_cgroup_id;
> +
> +/* cgroup which will be deleted */
> +u64 deleted_cgroup_id;
> +
> +/* cgroup which will be created */
> +u64 new_cgroup_id;
> +
> +/* cgroup which was deleted */
> +u64 deleted_cgroup_id;
>    ^^^^^^^^^^^^^^^^^^

Is deleted_cgroup_id intentionally declared twice here? This appears
to be a duplicate global variable declaration - the same variable is
declared at line 13 with comment "cgroup which will be deleted" and
again at line 19 with comment "cgroup which was deleted".

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `bpf: selftests: PSI struct ops test`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18859027430

--===============1951758182374278910==--

