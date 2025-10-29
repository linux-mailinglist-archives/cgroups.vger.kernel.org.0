Return-Path: <cgroups+bounces-11405-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E48A9C1D57A
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 22:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5415A4E2F87
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 21:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F71E3164C8;
	Wed, 29 Oct 2025 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXPTQ6NN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261531618F
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771877; cv=none; b=BTQaYgvadCOCapm3S0hHX+SU0KrTv6TJdOv8e1pAf77SD5htmNKT0lSYRY9Cmu7Lol/Hk122ZE8b6fMsskOtpdwewxRuPugwjC8JiqBQQyP0yJCXUm6QQZ9UtFRzcMaobscdmWqUorHlY5HkCW5RJ6QUSyQxdyvc1LysCF5uj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771877; c=relaxed/simple;
	bh=IeQrdhbzJtSGHs4OR0fhELCzRR7fb17Ll03UxCVXOf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQnTJjdK/nkXNh4BIdxwl2KlhihoAX8GicM0N4wfjs82f/rolprqQKHFFGJ3U3dMxl2J0GW1XEJIEtlCOMdRMBAmnJ2mEOPUDfQ0t2IkZTQowngOLzhHpmR2zzkSXYXi4DdnTctAKPrviVs/39pLrMLsMGm7kRfMeqq0985tTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXPTQ6NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D52C4CEF8
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 21:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761771876;
	bh=IeQrdhbzJtSGHs4OR0fhELCzRR7fb17Ll03UxCVXOf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sXPTQ6NNfN9LetKeBdJ4sOKxVBj1JnrICO57BRnyzpnOMSb8/f0Rs4pO4m4c0IwXw
	 kLhIPCj/l4G4Zt1Zq2LC09krLSQBhMVdt35eYTS9eiwNNCqygO03elPHDbu97vyNjj
	 Bt+dTTGcvx0Eup5gFYbg3DV14axVEhms9uICsONWcPS8BLPDlVDLJ3cpnVeWNz32z2
	 zoWWUBZSqn0Z8Y8dnZTnyOS0DN6ZL0s1ruZuJYQEtIgbFQVKFP9kSa2TXPLxZHjA7n
	 REfez8IDzuewVKhuCitUWJA6vpx7RRt7eMhXmitFlH9BXmf/EmYd7eysALggY3vVR2
	 EtQDbaGuUftmQ==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-87499a3cd37so2728356d6.3
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 14:04:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOkRn13vj3c3FUBT18lbnAbW7IB02XTXkiGIwo3eCp231YZXcIaIV91nYv8KZYL1x2UjWRO+i/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxddva5cs6B5k+pK7AaTiB/tPm+K8R7dDc3vpqrTX/WjAqveOkr
	PS+zgCBOwb59AcqN/hkk8RIxrU/NXxsBnInQzy8Sy6mgEQACqzaUdloSc0oCkOb/f7VlbWaKdXn
	iO2aHjsNj0QvyEGh0lreL0AYeGCBD6Qs=
X-Google-Smtp-Source: AGHT+IEqf3PIOchyUqoLcawfwjWZmR/KgFNBHjNgX4VqoOPf6lJnxW+Lti6nor6ugzHgDbmIf5F9oXMuNctmihwhxfM=
X-Received: by 2002:a05:6214:487:b0:775:1d3:d07f with SMTP id
 6a1803df08f44-8801b0c5fbemr13858946d6.11.1761771875408; Wed, 29 Oct 2025
 14:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev> <20251027231727.472628-3-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-3-roman.gushchin@linux.dev>
From: Song Liu <song@kernel.org>
Date: Wed, 29 Oct 2025 14:04:24 -0700
X-Gmail-Original-Message-ID: <CAHzjS_uagf3G4hAcJK0QWao88a4sRzXjdkQGgRMH8RZYd_C4Cw@mail.gmail.com>
X-Gm-Features: AWmQ_bmwLAYqjY6FqVrt95b3pom6p-BA2r_4lSQbeFy3VWdjR4QavcuPY05pP8A
Message-ID: <CAHzjS_uagf3G4hAcJK0QWao88a4sRzXjdkQGgRMH8RZYd_C4Cw@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
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

On Mon, Oct 27, 2025 at 4:17=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> When a struct ops is being attached and a bpf link is created,
> allow to pass a cgroup fd using bpf attr, so that struct ops
> can be attached to a cgroup instead of globally.
>
> Attached struct ops doesn't hold a reference to the cgroup,
> only preserves cgroup id.

With the current model, when a cgroup is freed, the bpf link still
holds a reference to the struct_ops. Can we make the cgroup to hold
a reference to the struct_ops, so that the struct_ops is freed
automatically when the cgroup is freed?

I think the downside is that we will need an API to remove/change
per cgroup OOM handler.

Thanks,
Song

