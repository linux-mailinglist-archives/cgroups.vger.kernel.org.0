Return-Path: <cgroups+bounces-16002-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOFIA3otCGrYcwMAu9opvQ
	(envelope-from <cgroups+bounces-16002-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 10:40:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACE855AC76
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 10:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C76F1301A395
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 08:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0784B3CFF57;
	Sat, 16 May 2026 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvbS/DGA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5D38BF63
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778920809; cv=none; b=G8CK8+XCCEFHOCWDCzq3Ml+2gZIihUKoI0JQ0bW/goeNTAUBkoi6IEWNhFsjiQvsD1IpeHZBIgiOVHwtaZrAkzsOdyWzpVR4irovHY5tyFdjjLtogaELk6F5gZ0LsqbAR3utVFzk2I1uWa7/+/i+Xb6pSq2b6JE3FB7p9DgWhzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778920809; c=relaxed/simple;
	bh=y+cssOF3JI3QPMolzFAOadB7Do4nnXYRXVDNACSVwkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMSl+Op3hMGCpddJXEGJB/pQeyQJO3vh3TYhg6A8hgwJnQj5xcfAzHjRGBCz0IPBQelagTAtYzjdBASousoD/07tbTRLhCZP17WM3x8gdjjmHe8MtQ0ZmEL8c/E3/i5F+JGJnOopIGay4CH4brqaTFo386awi3cc1/1o7zqnU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvbS/DGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563F2C4AF0B
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 08:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778920809;
	bh=y+cssOF3JI3QPMolzFAOadB7Do4nnXYRXVDNACSVwkQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tvbS/DGAmwukiGZJwJxkLpU8q18SbF1usZs165c2E4z129+TCBxQRgO79D6/d3FSG
	 grpo2HrkUzRjYbo0B4eFX7NXzK9MoowEVLeS9obWh7xDVirpHEvDgivl2EkoK4f/pB
	 U49SOqLzMpvXoF+I16XeKoGVcQNa/dLpyXTmFs+7/p1Mj5e/scwaeMaJmyJrt020Hb
	 R7ygS24p4zLcx/nztB1ztLZYDvK28yIUhhvX8nyVsN4OcDHppEEFQWEqjDxEi30oIn
	 tfv+FPDDCN/QDDn71qq28hU0HK2L/ojYnDxhEaNoHt0HpFJPfBu170/5vnRJpUHIR0
	 iJ79PgQ2bpPPw==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8acb856a674so12090326d6.0
        for <cgroups@vger.kernel.org>; Sat, 16 May 2026 01:40:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8+8ccpWUwl2kCwqsmq0ae1JfMKWttID+lEWIpCiuv+4D4FouuyRdf9g5XwrEe4DGXjLPEbszlo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqbz3DqKNA4jSqdEuEbGEE0oZxpAOeZQXEWU56f0XZRKZE8Rkk
	87eY8zPE5YwWGf/iKJgefOryz3vh8mkPeuo1klbnrLHjk+UjoR7BxZnIEIl0DWJ5UDfUQt0jnSs
	NXeSjqYZTlKFu8P7eRKLO7sBheUy+0Zo=
X-Received: by 2002:a05:6214:484a:b0:8b1:f2e9:2996 with SMTP id
 6a1803df08f44-8ca0f6f9b30mr88104796d6.15.1778920808440; Sat, 16 May 2026
 01:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
In-Reply-To: <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Sat, 16 May 2026 16:39:57 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zjrFJYQQsLThTGXR6g+2PXzeAhjyDpLHfDFqVViWvyBQ@mail.gmail.com>
X-Gm-Features: AVHnY4KGpLFyShwsPFT2_ko1YKgIHsQeEWpI94e5tOAyYvyldimzi4eq_T9PySo
Message-ID: <CAGsJ_4zjrFJYQQsLThTGXR6g+2PXzeAhjyDpLHfDFqVViWvyBQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: "T.J. Mercier" <tjmercier@google.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mripard@kernel.org, echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8ACE855AC76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16002-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 2:54=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Tue, May 12, 2026 at 3:14=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 5/12/26 11:10, Albert Esteve wrote:
> > > On embedded platforms a central process often allocates dma-buf
> > > memory on behalf of client applications. Without a way to
> > > attribute the charge to the requesting client's cgroup, the
> > > cost lands on the allocator, making per-cgroup memory limits
> > > ineffective for the actual consumers.
> > >
> > > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> > > a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> > > memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> > > inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> > > the mem_accounting module parameter enabled, the buffer is charged
> > > to the allocator's own cgroup.
> > >
> > > Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> > > system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> > > page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> > > twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> > > all accounting through a single MEMCG_DMABUF path.
> > >
> > > Usage examples:
> > >
> > >   1. Central allocator charging to a client at allocation time.
> > >      The allocator knows the client's PID (e.g., from binder's
> > >      sender_pid) and uses pidfd to attribute the charge:
> > >
> > >        pid_t client_pid =3D txn->sender_pid;
> > >        int pidfd =3D pidfd_open(client_pid, 0);
> > >
> > >        struct dma_heap_allocation_data alloc =3D {
> > >            .len             =3D buffer_size,
> > >            .fd_flags        =3D O_RDWR | O_CLOEXEC,
> > >            .charge_pid_fd   =3D pidfd,
> > >        };
> > >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > >        close(pidfd);
> > >        /* alloc.fd is now charged to client's cgroup */
> > >
> > >   2. Default allocation (no pidfd, mem_accounting=3D1).
> > >      When charge_pid_fd is not set and the mem_accounting module
> > >      parameter is enabled, the buffer is charged to the allocator's
> > >      own cgroup:
> > >
> > >        struct dma_heap_allocation_data alloc =3D {
> > >            .len      =3D buffer_size,
> > >            .fd_flags =3D O_RDWR | O_CLOEXEC,
> > >        };
> > >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > >        /* charged to current process's cgroup */
> > >
> > > Current limitations:
> > >
> > >  - Single-owner model: a dma-buf carries one memcg charge regardless =
of
> > >    how many processes share it. Means only the first owner (and expor=
ter)
> > >    of the shared buffer bears the charge.
> > >  - Only memcg accounting supported. While this makes sense for system
> > >    heap buffers, other heaps (e.g., CMA heaps) will require selective=
ly
> > >    charging also for the dmem controller.
> >
> > Well that doesn't looks soo bad, it at least seems to tackle the proble=
m at hand for Android and some of other embedded use cases.
>
> Yeah I think this might work. I know of 3 cases, and it trivially
> solves the first two. The third requires some work on our end to
> extend our userspace interfaces to include the pidfd but it seems
> doable. I'm checking with our graphics folks.
>
> 1) Direct allocation from user (e.g. app -> allocation ioctl on
> /dev/dma_heap/foo)
> No changes required to userspace. mem_accounting=3D1 charges the app.
>
> 2) Single hop remote allocation (e.g. app -> AHardwareBuffer_allocate
> -> gralloc)
> gralloc has the caller's pid as described in the commit message. Open
> a pidfd and pass it in the dma_heap_allocation_data.
>
> 3) Double hop remote allocation (e.g. app -> dequeueBuffer ->
> SurfaceFlinger -> gralloc)
> In this case gralloc knows SurfaceFlinger's pid, but not the app's. So
> we need to add the app's pidfd to the SurfaceFlinger -> gralloc
> interface, or transfer the memcg charge from SurfaceFlinger to the app
> after the allocation.
> It'd be nice to avoid the charge transfer option entirely, but if we
> need it that doesn't seem so bad in this case because it's a bulk
> charge for the entire dmabuf rather than per-page. So the exporter
> doesn't need to get involved (we wouldn't need a new dma_buf_op) and
> we wouldn't have to worry about looping and locking for each page.
>

Hi T.J.,

Your description of the three different cases sounds very interesting.
It helps me understand how difficult it can be to correctly charge
dma-buf in the current user scenarios.

I=E2=80=99m wondering where I can find Android userspace code that transfer=
s
the PID of RPC callers. Do we have any existing sample code in Android
for this?

> > I'm just not sure if this is future prove and will work for all use cas=
es, e.g. cloud gaming, native context for automotive etc...

Thanks
Barry

