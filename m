Return-Path: <cgroups+bounces-11304-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6AC170EE
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 22:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11051A2251D
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 21:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074242D8DC8;
	Tue, 28 Oct 2025 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phmrTVky"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82212D5C95
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687235; cv=none; b=U1CsDtFhsQPq6UUeXxYujqo48xqd/YOxXTK0fofbUp4TDdj81GwNTMqc0eMRDZUW+oxMjeZASqk7QJasZ4+IQ0/YOmp9hsIeB5Kb1c/8+ZCmdksfpRxK8o8G9GuDyo9cNLfDHDOLF9rzhe6x9kgip1/XJCyYxt/hDaz7wf92FPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687235; c=relaxed/simple;
	bh=iFWP7xxMJgkbRCwFD/Ow8yzZAuMAdW311BwnuPvp2SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtocNgkq/+ayGujzwZAhGw23uiFAr/kiCgHIJnhWuT/5gkcCD68Kzva4KbwhqpDKyGFqwL48dGEteU0TwQrURunjpDo7JgPZdWk7Ylt9gNMwe/Icoap0cvQ3hVI/ssXpfelzffQ8qAL0/RZA4JREt/pjYuo8FOjn843BWWexmPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phmrTVky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417CDC116D0
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 21:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761687235;
	bh=iFWP7xxMJgkbRCwFD/Ow8yzZAuMAdW311BwnuPvp2SA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=phmrTVkyk/RJJ+EFRqA64SJtzZw1RrTXF0Jy7f1CXc/pvZLehllXnDr4sgfEh9lXA
	 2/twG9h2eNIdBfauTgXEQuIRcS4YaIBUHDFnASGVKVGIr9PViTjDz3uHg1aUHndGnm
	 JfmMrIDVcmMtfhGvsEaRyHNrcNHVVSFVyWqW7mc2lxSIew6H7Ge6bK3IDkKkVZFTE+
	 ckLbL07VYqopMUKqVW/aEdK3rZ1Vhdn7Jx2oYQrh9yRmC9zb2iiksD6jhqrAr/U6XF
	 BoaOIR9Ixch8dADOEBUFirZRLio3iFt5cOVoN7gFFs9TvytO8YcKQnFMJVdWxBjyCE
	 nG+tulYpts/hw==
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78f30dac856so73672156d6.2
        for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:33:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVKG6yQsGpQ8oizRxeP6YEUL5Iv77v0rswvlrbgdwK0XcUNBXboJ6QvN9kDAohaTOi8HjLHrd5@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgKxfX+z6/DEfj8For6DD5m0nWQIoj9YGBdukxcCyrgOzmoyF
	TqkVdsQvz4WxXkb6V0rFHa35Y2rVvAGAAmjnuEP5fof2NJSPv53NuB2c7WKEM3/tpq6bfvUqwSS
	sTjS1Qo1+iRXa2OmIMqKvXLQJDypEF0E=
X-Google-Smtp-Source: AGHT+IESUEc3eeZzEWwxs00NmoTrW71KQg0jPt0Nsondh+RQEdb4dLarCNV80h0sV/jj5ri8Uz9bMzHY51U++MLe3GA=
X-Received: by 2002:a05:6214:2129:b0:807:ca4f:5666 with SMTP id
 6a1803df08f44-88009ad0903mr10291646d6.2.1761687234390; Tue, 28 Oct 2025
 14:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev> <20251027231727.472628-7-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-7-roman.gushchin@linux.dev>
From: Song Liu <song@kernel.org>
Date: Tue, 28 Oct 2025 14:33:43 -0700
X-Gmail-Original-Message-ID: <CAHzjS_vrNZpEbBuHLhHwHaGzLaF3QEeKWz-VikCm0bYrFBq4UA@mail.gmail.com>
X-Gm-Features: AWmQ_bn4FJi2CLDbiuBc051gpuUbvflP1rY5GJvh4T7UtMPVn-sJ9ZXRwYG7Zb8
Message-ID: <CAHzjS_vrNZpEbBuHLhHwHaGzLaF3QEeKWz-VikCm0bYrFBq4UA@mail.gmail.com>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:18=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
[...]
> +
> +struct bpf_oom_ops {
> +       /**
> +        * @handle_out_of_memory: Out of memory bpf handler, called befor=
e
> +        * the in-kernel OOM killer.
> +        * @ctx: Execution context
> +        * @oc: OOM control structure
> +        *
> +        * Should return 1 if some memory was freed up, otherwise
> +        * the in-kernel OOM killer is invoked.
> +        */
> +       int (*handle_out_of_memory)(struct bpf_oom_ctx *ctx, struct oom_c=
ontrol *oc);
> +
> +       /**
> +        * @handle_cgroup_offline: Cgroup offline callback
> +        * @ctx: Execution context
> +        * @cgroup_id: Id of deleted cgroup
> +        *
> +        * Called if the cgroup with the attached bpf_oom_ops is deleted.
> +        */
> +       void (*handle_cgroup_offline)(struct bpf_oom_ctx *ctx, u64 cgroup=
_id);

handle_out_of_memory() and handle_cgroup_offline() takes bpf_oom_ctx,
which is just cgroup_id for now. Shall we pass in struct mem_cgroup, which
should be easier to use?

Thanks,
Song

> +
> +       /**
> +        * @name: BPF OOM policy name
> +        */
> +       char name[BPF_OOM_NAME_MAX_LEN];
> +};
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +/**
> + * @bpf_handle_oom: handle out of memory condition using bpf
> + * @oc: OOM control structure
> + *
> + * Returns true if some memory was freed.
> + */
> +bool bpf_handle_oom(struct oom_control *oc);
> +

