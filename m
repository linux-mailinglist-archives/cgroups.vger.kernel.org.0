Return-Path: <cgroups+bounces-8211-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647DCAB897F
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 16:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3954E426D
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DF713B7A3;
	Thu, 15 May 2025 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SKbcaR1g"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F913A86C
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319501; cv=none; b=UiI9j74GI0q6qIO8Rhjgx/XBwt1LGc67FjKyS/I+978EHR2P42G9pObWvzUE4TwkWgpKTwR5+DnSVMDdgyzC5Ebgrq8dbULp8OhN9tY5/n71x0jaUwnaO1aIpKssXVd/WqL3otgK+nopFiq1yUG4Imqc5O7+IBn5YuulXnL0iuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319501; c=relaxed/simple;
	bh=heBnoNQS7qSXi4BvdVbMHG/Q0/5UYojtsxzKt5l9f5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0v/cKjPzTrbFOyP3v8cfmykbj0C/Zy87ld5JDdy6aY/O3wDhYGjaNewg1o1YHlbgz4/LsQO588NF1wpFhLZqnRH4M4iyHxMb8ZxOHlqSUmIoAjzzvjXOfk7afODduLk4VywcSnVyLWSvwMwEUapYEZkl9AFeQisTxU+jwdNZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SKbcaR1g; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCVQxn3FnteDKKo3BFx5ofCkncUoL4fkvhfkIimfmGkz3QOW0+Gfpld+ilvsBtUadZSLeraLfxwhemM7PgsR@vger.kernel.org, AJvYcCXC2Z1P6i/GdLS/DO35SWvGe9WN+2kHKlQe1l7FaMYUluJLCa6Y3UqoNh1vjTgUdRqOxe7FQfOpBA==@vger.kernel.org, AJvYcCXQm9s9MUkVhvZkf8Z3x+VVCAJ08NSG96v8Wn3NNsHNPn+4aAarhp5Zs8yXiTssL9e840A=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747319487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFetwXF/VwiHsM2Y9xmcYYhX84ZJvWa2dyXEgkPZk18=;
	b=SKbcaR1gFAxvOyZWx2twk8ConWLTfGusMxqcDFFu1nMsTCMRicKXaXAcbBGUm1QpBkVeJK
	blK51c5zEWUJwBoErZOmoTsLN8WQ5//nC4KujbiwfazSqYXSI2SONjttNiCIUxj4MCta//
	ondJlSVZrjlVl3WitIVpT7HBdVJL33w=
X-Gm-Message-State: AOJu0Yy8CL43WB1+v2bmKiPcns3u6lsmZkgAdyAGwC3GGN8vOqPqh1Dk
	108XfCh3xuo3lLWCBfHBIeposzl0u1yuNAwUxF5j0+hMRIW4E+eE2AtI5GdeLnIHI37/R3+LLh+
	xVXyHUuz90TtpjanVO1zOIb13lQ4=
X-Google-Smtp-Source: AGHT+IGQIU2q5KzVhNqIoGtPyXwZcXsLMJcH4k4PnyFhVeQq9UMndtkORnyWj6lRGN+WELtJVJXaSFxNE3JUAPOlHYA=
X-Received: by 2002:a54:4393:0:b0:403:5277:9424 with SMTP id
 5614622812f47-404c21373f2mr3743430b6e.32.1747319480654; Thu, 15 May 2025
 07:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
 <20250514184158.3471331-2-shakeel.butt@linux.dev> <22f69e6e-7908-4e92-96ca-5c70d535c439@lucifer.local>
In-Reply-To: <22f69e6e-7908-4e92-96ca-5c70d535c439@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Thu, 15 May 2025 07:31:09 -0700
X-Gmail-Original-Message-ID: <CAGj-7pUJQZD59Sx7E69Uvi1++dB59R8wWkDYvSTGYhU-18AHXg@mail.gmail.com>
X-Gm-Features: AX0GCFuAJwtLNKJwKPDMOLiftKy-4ToNrqm6RD1vIrynPcQ5WImKcXb6Sk0ZoHk
Message-ID: <CAGj-7pUJQZD59Sx7E69Uvi1++dB59R8wWkDYvSTGYhU-18AHXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] memcg: memcg_rstat_updated re-entrant safe against irqs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, May 15, 2025 at 5:47=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Shakeel - This breaks the build in mm-new for me:
>
>   CC      mm/pt_reclaim.o
> In file included from ./arch/x86/include/asm/rmwcc.h:5,
>                  from ./arch/x86/include/asm/bitops.h:18,
>                  from ./include/linux/bitops.h:68,
>                  from ./include/linux/radix-tree.h:11,
>                  from ./include/linux/idr.h:15,
>                  from ./include/linux/cgroup-defs.h:13,
>                  from mm/memcontrol.c:28:
> mm/memcontrol.c: In function =E2=80=98mem_cgroup_alloc=E2=80=99:
> ./arch/x86/include/asm/percpu.h:39:45: error: expected identifier or =E2=
=80=98(=E2=80=99 before =E2=80=98__seg_gs=E2=80=99
>    39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
>       |                                             ^~~~~~
> ./include/linux/args.h:25:24: note: in definition of macro =E2=80=98__CON=
CAT=E2=80=99
>    25 | #define __CONCAT(a, b) a ## b
>       |                        ^
> ./arch/x86/include/asm/percpu.h:39:33: note: in expansion of macro =E2=80=
=98CONCATENATE=E2=80=99
>    39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
>       |                                 ^~~~~~~~~~~
> ./arch/x86/include/asm/percpu.h:93:33: note: in expansion of macro =E2=80=
=98__percpu_seg_override=E2=80=99
>    93 | # define __percpu_qual          __percpu_seg_override
>       |                                 ^~~~~~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:60:25: note: in expansion of macro =E2=
=80=98__percpu_qual=E2=80=99
>    60 | # define __percpu       __percpu_qual BTF_TYPE_TAG(percpu)
>       |                         ^~~~~~~~~~~~~
> mm/memcontrol.c:3700:45: note: in expansion of macro =E2=80=98__percpu=E2=
=80=99
>  3700 |         struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu=
;
>       |                                             ^~~~~~~~
> mm/memcontrol.c:3731:25: error: =E2=80=98pstatc_pcpu=E2=80=99 undeclared =
(first use in this function); did you mean =E2=80=98kstat_cpu=E2=80=99?
>  3731 |                         pstatc_pcpu =3D parent->vmstats_percpu;
>       |                         ^~~~~~~~~~~
>       |                         kstat_cpu
> mm/memcontrol.c:3731:25: note: each undeclared identifier is reported onl=
y once for each function it appears in
>
> The __percpu macro seems to be a bit screwy with comma-delimited decls, a=
s it
> seems that putting this on its own line fixes this problem:
>

Which compiler (and version) is this? Thanks for the fix.

