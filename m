Return-Path: <cgroups+bounces-15982-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIx/M41UB2pIygIAu9opvQ
	(envelope-from <cgroups+bounces-15982-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 19:14:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7138C554AC4
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 19:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 990803054BF5
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 17:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E64EA395;
	Fri, 15 May 2026 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0srMPLx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDC74D90AA
	for <cgroups@vger.kernel.org>; Fri, 15 May 2026 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864828; cv=pass; b=ra1bblCGon83t+3n9YI91jEurLqJmEH0XXi5KW55hiIdxjjF4B+xX0B83RzQAYYd0ChLa+o5ixgGzZc2jn+wEjNAvDm4W7wNpbscMHhMCv1f45YQpPyh2iJEZMMxe7H6Lpca9Jzj9m8eusCZ2MWGY0fZ9YtuHS4hwfBNYnARduc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864828; c=relaxed/simple;
	bh=nfVVCWXzvqa1LUWfzx7loZHs3RrGdLWJRj9wkdFaNyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5QI0XCRaBxDrs952G4wt8JgUqQkd2ylRIlew7OCOYv5DkhAQTOUoMqG35CcPzDg7kddQZ4OBlH3GEXSFr1V8RUL2k/1WhdLxx9X0FCRtNaR8lhCThtqHP2rY1Qc3LQHi2/1tVf0g9I9V9HMhHvTOmf+Xu9C+3h/3ZYHvf1zhi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0srMPLx; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so2855e9.1
        for <cgroups@vger.kernel.org>; Fri, 15 May 2026 10:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778864824; cv=none;
        d=google.com; s=arc-20240605;
        b=BkE6chXMpJnQUA+mJ3lUxEZJJvy8fmHBWalzwda1JYYb4IXfLJGhYktQBpvKCh6VJr
         rkp2eSD2j+x8IrqdPIw5tsjoS84obbAAirMOmthhP0oWuQ8a0KAqgEulPa/ZtO4A9fz1
         8F2aFR+6XNnze2RcCCOmK0TKPgazuNqEqrFqcnGkbN4w7ql2RLAYAtq9dXRmMKzhJ2Qk
         3lWvEoGQqdugwRfOmjaEgcmE/y1MuF1Z2lGWA2Hw2m5dvsYK+0LU8sH1+QHq9DjnLkWX
         GF1AlmlRjxB68+4XacZCjSBa6f+hyF6YvodXiy+5PwokWLrtFG4It0Qa90OyiGl4sd4R
         hzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LQnzcBlc7+y3xboPXu3CAuDhwWayfDkxWRZzNgig+eE=;
        fh=oGxwHwLm/hlwwDT4XZqTOO+45vPoyxfbKP4rkkLSv2g=;
        b=T8ZPtud7+GMM62jc66xI8tVkkVigCaXDqKtitX39DCtkU0661/Rb/Zi34Vo+/F8MzT
         469GD19RoQxfJpuhnX/RaUdl/V7SiEq4c26lRb4w87FMWTQo0zHQfjHW0aMQPbCEu5AL
         iuFdJKsAyCWNychGyu4WxahZlFNeCWDBXrTBIFUBZtFoaSK74ix5nAxQYRyHJFxWCZgv
         0uVR11HW7lGU9ls+vFMRtVdzPs0WdpmL0sgYsvfEN4GpEDqNLiFYsCLy6eU/weTmjnKy
         GR7Uf9OhplJN6zmSYeyqqCx1I+xaxaRyQycfLBIVKQF9F7I2dlZ6VXzFIO1DQm0Hf4PL
         s+1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778864824; x=1779469624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQnzcBlc7+y3xboPXu3CAuDhwWayfDkxWRZzNgig+eE=;
        b=E0srMPLxCnbv4KB+EQPF5rUjYvkR9PlBB7xN/JKyrfvX9MCkwGvTj5Wp6yUh6ELTX1
         wLUDZbjN1jpwGP1SqsN3atkssUt11imLO3YwSPXCp6sHkOCVReBTSTDKcB5dJkOraJf0
         kl7AbBgrxmSkdjNyF7qgTvydVY+uTkTaTpgUObzjQjZG0VVfHit2RPvQIOegafOIsU0R
         vZn4OGzAGJlOnQtyG7YhI7QoDrpo6hGMsht4DjUGiCqgpgQRGrL44LZ53ijorf+4/zSa
         bAdyZqGCp3GnpUfkC0io5hgmqbD1sbUrBEJM9TdQHeBKHiI7pxL7RycGbjfk3h5EtPdM
         mLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778864824; x=1779469624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQnzcBlc7+y3xboPXu3CAuDhwWayfDkxWRZzNgig+eE=;
        b=dyKBUyM33BKXycmocG2wc5d6LmfVAD1iIRXIBCy64YmqZcXwETDjMN90Vd9ZX6ho4k
         csIXR5CCLgys22mm6/vOwei4J1ecua/J/YYKhUlQYfukuIOlERrSpV+vgvG41fw7B6RQ
         MYc6BjcxCB4yOJtSywc+wZqapbY9OztmfErIW5uM8/8mSbAxBDh7fs69nOOq539KKV/g
         npElS99LwL/0O4IO4f3v+uoKUtJpeym7jj+rFH5/sCTlIVYbwiqLASTPkQUhMO0JepBc
         Aet5vBU4ccDPNero+KoRNAQlNGLhQH452is8xmOcBjon7ELestkRQCxyV+BXmHpvOksE
         51Tg==
X-Forwarded-Encrypted: i=1; AFNElJ9o9gxLUl/orBvrC+pjU8RDw6UUAKi0KpQF1AyQeowAjDiOFaIqiwl3zf3zsbWuO9iLghy1Ndv5@vger.kernel.org
X-Gm-Message-State: AOJu0YztB3GjvnVyGj3WzHxCr2fhAtUkYTKiJPBaPlJxH1YGnWjOM7bu
	Xz0t67qAs9lWNh4iwK5k8sZJO5mgZeY0wfQfPpIROk+y30oBzWHJz74eCMZWo6+b48QXY5qc4vl
	hNtAWSpK40kyvXNJqnbj/ckv9IieDQYP0YWz0Jd3Q
X-Gm-Gg: Acq92OFsMwAW/jTAQstgxg/nMJTzOlibXBXyML2UaGMN8EgsLiQRuXUWi8BdFdWSBpx
	Ub69KlgpStpDOWfHIYRYKw3MeY10+hy9RdJfyUGiQb7xjboHu414dHxJfxbJOmiNWIu1CxMqcg5
	Wkhq5PPynYGl2QkEna4kyo6TfLQmJ2ZiqBwN1E/d90Ag1AMqNfc/0U5G3mCNuew1k/jn+fkvm3C
	2eqalxdO/M3xgeNjTxVvUYqCJWbtLTRStmdeKWmuYdD7B+SLBfs7zz7rTlrZPMg/LJLXa8P2ZyM
	nEMYtDbMxVwbFznBK6foSaS2zR0W0xhklub+4wY70gcvwxV7
X-Received: by 2002:a05:600c:4999:b0:489:1adc:f017 with SMTP id
 5b1f17b1804b1-48fe881e582mr645715e9.5.1778864823481; Fri, 15 May 2026
 10:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com> <20260515-hinschauen-effizient-9e3a05a94f2e@brauner>
In-Reply-To: <20260515-hinschauen-effizient-9e3a05a94f2e@brauner>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 15 May 2026 10:06:50 -0700
X-Gm-Features: AVHnY4LllvNrEvKpMMJyjJvPlkuCoR7DSmB99jM3FHC68bpYwfg1MyASdUtT0JM
Message-ID: <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Christian Brauner <brauner@kernel.org>
Cc: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, mripard@kernel.org, 
	echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7138C554AC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15982-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 6:53=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> > On embedded platforms a central process often allocates dma-buf
> > memory on behalf of client applications. Without a way to
> > attribute the charge to the requesting client's cgroup, the
> > cost lands on the allocator, making per-cgroup memory limits
> > ineffective for the actual consumers.
> >
> > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
>
> Please be aware that pidfds come in two flavors:
>
> thread-group pidfds and thread-specific pidfds. Make sure that your API
> doesn't implicitly depend on this distinction not existing.

Hi Christian,

Memcg is not a controller that supports "thread mode" so all threads
in a group should belong to the same memcg.

Checking the flags from pidfd_get_pid would be the best way for an
explicit check of the pidfd type?

> > a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> > memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> > inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> > the mem_accounting module parameter enabled, the buffer is charged
> > to the allocator's own cgroup.
> >
> > Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> > system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> > page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> > twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> > all accounting through a single MEMCG_DMABUF path.
> >
> > Usage examples:
> >
> >   1. Central allocator charging to a client at allocation time.
> >      The allocator knows the client's PID (e.g., from binder's
> >      sender_pid) and uses pidfd to attribute the charge:
> >
> >        pid_t client_pid =3D txn->sender_pid;
> >        int pidfd =3D pidfd_open(client_pid, 0);
> >
> >        struct dma_heap_allocation_data alloc =3D {
> >            .len             =3D buffer_size,
> >            .fd_flags        =3D O_RDWR | O_CLOEXEC,
> >            .charge_pid_fd   =3D pidfd,
> >        };
> >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> >        close(pidfd);
> >        /* alloc.fd is now charged to client's cgroup */
> >
> >   2. Default allocation (no pidfd, mem_accounting=3D1).
> >      When charge_pid_fd is not set and the mem_accounting module
> >      parameter is enabled, the buffer is charged to the allocator's
> >      own cgroup:
> >
> >        struct dma_heap_allocation_data alloc =3D {
> >            .len      =3D buffer_size,
> >            .fd_flags =3D O_RDWR | O_CLOEXEC,
> >        };
> >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> >        /* charged to current process's cgroup */
> >
> > Current limitations:
> >
> >  - Single-owner model: a dma-buf carries one memcg charge regardless of
> >    how many processes share it. Means only the first owner (and exporte=
r)
> >    of the shared buffer bears the charge.
> >  - Only memcg accounting supported. While this makes sense for system
> >    heap buffers, other heaps (e.g., CMA heaps) will require selectively
> >    charging also for the dmem controller.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
> >  drivers/dma-buf/dma-buf.c               | 16 ++++---------
> >  drivers/dma-buf/dma-heap.c              | 42 +++++++++++++++++++++++++=
+++++---
> >  drivers/dma-buf/heaps/system_heap.c     |  2 --
> >  include/uapi/linux/dma-heap.h           |  6 +++++
> >  5 files changed, 53 insertions(+), 18 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 8bdbc2e866430..824d269531eb1 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1636,8 +1636,9 @@ The following nested keys are defined.
> >               structures.
> >
> >         dmabuf (npn)
> > -             Amount of memory used for exported DMA buffers allocated =
by the cgroup.
> > -             Stays with the allocating cgroup regardless of how the bu=
ffer is shared.
> > +             Amount of memory used for exported DMA buffers allocated =
by or on
> > +             behalf of the cgroup. Stays with the allocating cgroup re=
gardless
> > +             of how the buffer is shared.
> >
> >         workingset_refault_anon
> >               Number of refaults of previously evicted anonymous pages.
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index ce02377f48908..23fb758b78297 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *dentry)
> >        */
> >       BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
> >
> > -     mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size=
) / PAGE_SIZE);
> > -     mem_cgroup_put(dmabuf->memcg);
> > +     if (dmabuf->memcg) {
> > +             mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
> > +                                       PAGE_ALIGN(dmabuf->size) / PAGE=
_SIZE);
> > +             mem_cgroup_put(dmabuf->memcg);
> > +     }
> >
> >       dmabuf->ops->release(dmabuf);
> >
> > @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dma_bu=
f_export_info *exp_info)
> >               dmabuf->resv =3D resv;
> >       }
> >
> > -     dmabuf->memcg =3D get_mem_cgroup_from_mm(current->mm);
> > -     if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->s=
ize) / PAGE_SIZE,
> > -                                   GFP_KERNEL)) {
> > -             ret =3D -ENOMEM;
> > -             goto err_memcg;
> > -     }
> > -
> >       file->private_data =3D dmabuf;
> >       file->f_path.dentry->d_fsdata =3D dmabuf;
> >       dmabuf->file =3D file;
> > @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf=
_export_info *exp_info)
> >
> >       return dmabuf;
> >
> > -err_memcg:
> > -     mem_cgroup_put(dmabuf->memcg);
> >  err_file:
> >       fput(file);
> >  err_module:
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index ac5f8685a6494..ff6e259afcdc0 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -7,13 +7,17 @@
> >   */
> >
> >  #include <linux/cdev.h>
> > +#include <linux/cgroup.h>
> >  #include <linux/device.h>
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-heap.h>
> > +#include <linux/memcontrol.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/err.h>
> >  #include <linux/export.h>
> >  #include <linux/list.h>
> >  #include <linux/nospec.h>
> > +#include <linux/pidfd.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/xarray.h>
> > @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
> >                "Enable cgroup-based memory accounting for dma-buf heap =
allocations (default=3Dfalse).");
> >
> >  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> > -                              u32 fd_flags,
> > -                              u64 heap_flags)
> > +                              u32 fd_flags, u64 heap_flags,
> > +                              struct mem_cgroup *charge_to)
> >  {
> >       struct dma_buf *dmabuf;
> > +     unsigned int nr_pages;
> > +     struct mem_cgroup *memcg =3D charge_to;
> >       int fd;
> >
> >       /*
> > @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap *he=
ap, size_t len,
> >       if (IS_ERR(dmabuf))
> >               return PTR_ERR(dmabuf);
> >
> > +     nr_pages =3D len / PAGE_SIZE;
> > +
> > +     if (memcg)
> > +             css_get(&memcg->css);
> > +     else if (mem_accounting)
> > +             memcg =3D get_mem_cgroup_from_mm(current->mm);
> > +
> > +     if (memcg) {
> > +             if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KERNEL=
)) {
> > +                     mem_cgroup_put(memcg);
> > +                     dma_buf_put(dmabuf);
> > +                     return -ENOMEM;
> > +             }
> > +             dmabuf->memcg =3D memcg;
> > +     }
> > +
> >       fd =3D dma_buf_fd(dmabuf, fd_flags);
> >       if (fd < 0) {
> >               dma_buf_put(dmabuf);
> > @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file *fi=
le, void *data)
> >  {
> >       struct dma_heap_allocation_data *heap_allocation =3D data;
> >       struct dma_heap *heap =3D file->private_data;
> > +     struct mem_cgroup *memcg =3D NULL;
> > +     struct task_struct *task;
> > +     unsigned int pidfd_flags;
> >       int fd;
> >
> >       if (heap_allocation->fd)
> > @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct file *f=
ile, void *data)
> >       if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> >               return -EINVAL;
> >
> > +     if (heap_allocation->charge_pid_fd) {
> > +             task =3D pidfd_get_task(heap_allocation->charge_pid_fd, &=
pidfd_flags);
>
> Will always get a thread-group leader pidfd and will fail if this is a
> thread-specific pidfd. pidfd_open(1234, PIDFD_THREAD) can be used to
> open a thread-specific pidfd.
>
> > +             if (IS_ERR(task))
> > +                     return PTR_ERR(task);
> > +
> > +             memcg =3D get_mem_cgroup_from_mm(task->mm);
> > +             put_task_struct(task);
> > +     }
> > +
> >       fd =3D dma_heap_buffer_alloc(heap, heap_allocation->len,
> >                                  heap_allocation->fd_flags,
> > -                                heap_allocation->heap_flags);
> > +                                heap_allocation->heap_flags,
> > +                                memcg);
> > +     mem_cgroup_put(memcg);
> >       if (fd < 0)
> >               return fd;
> >
> > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heap=
s/system_heap.c
> > index 03c2b87cb1112..95d7688167b93 100644
> > --- a/drivers/dma-buf/heaps/system_heap.c
> > +++ b/drivers/dma-buf/heaps/system_heap.c
> > @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(unsigne=
d long size,
> >               if (max_order < orders[i])
> >                       continue;
> >               flags =3D order_flags[i];
> > -             if (mem_accounting)
> > -                     flags |=3D __GFP_ACCOUNT;
> >               page =3D alloc_pages(flags, orders[i]);
> >               if (!page)
> >                       continue;
> > diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-hea=
p.h
> > index a4cf716a49fa6..e02b0f8cbc6a1 100644
> > --- a/include/uapi/linux/dma-heap.h
> > +++ b/include/uapi/linux/dma-heap.h
> > @@ -29,6 +29,10 @@
> >   *                   handle to the allocated dma-buf
> >   * @fd_flags:                file descriptor flags used when allocatin=
g
> >   * @heap_flags:              flags passed to heap
> > + * @charge_pid_fd:   optional pidfd of the process whose cgroup should=
 be
> > + *                   charged for this allocation; 0 means charge the c=
alling
> > + *                   process's cgroup
> > + * @__padding:               reserved, must be zero
> >   *
> >   * Provided by userspace as an argument to the ioctl
> >   */
> > @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
> >       __u32 fd;
> >       __u32 fd_flags;
> >       __u64 heap_flags;
> > +     __u32 charge_pid_fd;
> > +     __u32 __padding;
> >  };
> >
> >  #define DMA_HEAP_IOC_MAGIC           'H'
> >
> > --
> > 2.53.0
> >

