Return-Path: <cgroups+bounces-11232-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABEBC121BA
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447335608B8
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F94332EAD;
	Mon, 27 Oct 2025 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip4AuaoN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC925332916;
	Mon, 27 Oct 2025 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608906; cv=none; b=X0LfdgyziR9BLtFM1gQgDdAXgMT00qid571izBJxdT7tn0AygePf+UIrttnf9Ne8/Qa+cYpVoYtDD5bO9SPyYsfFDHGoTrjv/uUbyUlgVm/D7tkKdlrI/NHZQeLhPuhUDu7t9bmYTpZUnehXi0vs5ZiqNZL51Q83xzEurEjQamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608906; c=relaxed/simple;
	bh=Ymrk/bnWDm2vxd/nlsLHXR0AGQ17YZKwVmvB5bIG/UQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mHq6bXCuq4grd11jv3L62dgvE2lVXzxgvT47F/73ijlBRhqbBqzjAzdnVKhDUaHrqyTc7MMlgVTPSMWgdhFQgLQnxRMK4foLg7A5Pz77aR/f+Y0ff41YEP1ZJ3ctJ6j783vMPypZAUZV79F0m8M9vGEKbvWThjfahlnP6QWfvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip4AuaoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E68C113D0;
	Mon, 27 Oct 2025 23:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761608906;
	bh=Ymrk/bnWDm2vxd/nlsLHXR0AGQ17YZKwVmvB5bIG/UQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ip4AuaoNa+2WWxf+izH396ZLhnsd/7XBE26w4xIzGTJgtZn8K932+c9sMUNuwAqkZ
	 vcMLNsWCbeZsH7HhNPpueq2Oxeum7lgdSqilydy4isaJN8WGoEuJBOuYXkndDByQMl
	 up/nvZDWqorYxBwD2lv4mmIeGOae/TQnDS8uzehub6NKnu+GTspISnZNiuYlyqRAN2
	 dI4bogd2tfpkKHRXbuMIaMgbf0aogoC/p/9CXCjdAFRSiI8VT6Rrfxux5RjRnJFiNU
	 +hU/AOHoinvhfn4LDK17radRPA8GQ1MzFt73YBFVND+Y2NxW6eRWtDjdLSdAgMD3jA
	 f8PWukPa8bvFQ==
Content-Type: multipart/mixed; boundary="===============7910205454797298679=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <58dd6b759499f212f626e6d7658dd558b3e6a334e0780898002cb2cb84dbcb85@mail.kernel.org>
In-Reply-To: <20251027232206.473085-7-roman.gushchin@linux.dev>
References: <20251027232206.473085-7-roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 17/23] bpf: selftests: introduce read_cgroup_file() helper
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,surenb@google.com,mhocko@kernel.org,shakeel.butt@linux.dev,hannes@cmpxchg.org,andrii@kernel.org,inwardvessel@gmail.com,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,martin.lau@kernel.org,song@kernel.org,memxor@gmail.com,tj@kernel.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Oct 2025 23:48:24 +0000 (UTC)

--===============7910205454797298679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 712137918bba1b0a9c7c670bab9200b0f0d6a7e8
Author: Roman Gushchin <roman.gushchin@linux.dev>

bpf: selftests: introduce read_cgroup_file() helper

This patch adds a new helper function read_cgroup_file() to read from
cgroup control files in BPF selftests. The function opens a file,
reads into a buffer, and returns the result.

> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
> index 20cede4db..8fb02fe4c 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c
> @@ -126,6 +126,45 @@ int enable_controllers(const char *relative_path, const char *controllers)
>  	return __enable_controllers(cgroup_path, controllers);
>  }
>
> +static size_t __read_cgroup_file(const char *cgroup_path, const char *file,
> +				 char *buf, size_t size)
> +{
> +	char file_path[PATH_MAX + 1];
> +	size_t ret;
> +	int fd;
> +
> +	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
> +	fd = open(file_path, O_RDONLY);
> +	if (fd < 0) {
> +		log_err("Opening %s", file_path);
> +		return -1;

Can __read_cgroup_file() return -1 when its return type is size_t?

The function signature declares size_t (unsigned), but returns -1 here.
When -1 is implicitly converted to size_t, it becomes SIZE_MAX
(18446744073709551615 on 64-bit systems). Callers checking for errors
with "if (ret < 0)" will fail because size_t is unsigned, and callers
checking "if (ret == -1)" will also fail after the cast.

> +	}
> +
> +	ret = read(fd, buf, size);
> +	close(fd);
> +	return ret;

Does this handle read() errors correctly?

The read() syscall returns ssize_t which can be negative on error.
Assigning this to size_t (line 143) converts negative error codes into
large positive numbers. For example, read() returning -1 becomes SIZE_MAX
when stored in ret.

Should the return type be ssize_t instead of size_t to properly propagate
both success (byte count) and error (negative values) to callers?

> +}
> +
> +/**
> + * read_cgroup_file() - Read to a cgroup file
> + * @relative_path: The cgroup path, relative to the workdir
> + * @file: The name of the file in cgroupfs to read to
> + * @buf: Buffer to read from the file
> + * @size: Size of the buffer
> + *
> + * Read to a file in the given cgroup's directory.
> + *
> + * If successful, the number of read bytes is returned.
> + */
> +size_t read_cgroup_file(const char *relative_path, const char *file,
> +			char *buf, size_t size)
> +{
> +	char cgroup_path[PATH_MAX - 24];
> +
> +	format_cgroup_path(cgroup_path, relative_path);
> +	return __read_cgroup_file(cgroup_path, file, buf, size);
> +}
> +

[ ... ]

> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
> index 3857304be..9f9bb6b5d 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.h
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.h
> @@ -11,6 +11,8 @@
>
>  /* cgroupv2 related */
>  int enable_controllers(const char *relative_path, const char *controllers);
> +size_t read_cgroup_file(const char *relative_path, const char *file,
> +			char *buf, size_t size);
>  int write_cgroup_file(const char *relative_path, const char *file,
>  		      const char *buf);

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `bpf: selftests: introduce read_cgroup_file() helper`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18859027430

--===============7910205454797298679==--

