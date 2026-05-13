Return-Path: <cgroups+bounces-15889-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHbqOftiBGq6HgIAu9opvQ
	(envelope-from <cgroups+bounces-15889-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 13:39:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2865326A5
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 13:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26FF5301CD90
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 11:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC873FF88C;
	Wed, 13 May 2026 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYDdNVK4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFe/G9C4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D629D3FE342
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672365; cv=pass; b=GkRiX9w4vC6w2stcnnDlbnAY0V2e8JBvSuzzlQ61YgN+JE4YQcJl8K2FnVRqJ8QElRXeYHLtWyrE7Hy+7qv8MydSnaSRgQsA39+cdy0ytVhY8rGljZeO30iZ+2HS2aw64cNeVTxPQ7x2Gddk2kXd7pHgpM7yXZPyxxLwoRhPFgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672365; c=relaxed/simple;
	bh=6eAXM3xC4dFdGdmUPUhwi7HJjpeA8xmemKR+aCc+eh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8hbGQfd1hI/wZkKNpnwlDiIKvZ3sJus779Xc5DQoWNv3kcFhmMZcfVmPVvLIbFHZWb5w4iDjq4zoKq4El8IdVlGtKXwUzg3xG76pM5MUIqsErtOfkeOfSscK8D7NRw5ErkVDmor5IiW4+O7pE62q7rC+BAIqjCvzgQJ/Js8YwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYDdNVK4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFe/G9C4; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778672363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hS/2FuqLU5pwunCNcA3n2Q2AppnYr82PFc8PIbH39/U=;
	b=QYDdNVK45+cTMBxo7gKEMf2E6l7ovu6Sky8fiOCDDvp5M4R93+ftYzFNeby5O7Tz3QapEY
	8qnGA3ktxX47MqLvVazvSFc8TEDkaGPnUhS1pfMTxaxHBCB2gLlQYqG3dQL2HQLy6G9/R+
	fPAkJqDt2y2Wo21EgI2EcXoZd9hm4q8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-EfQFLPgmMYaiiyjPymdAFQ-1; Wed, 13 May 2026 07:39:21 -0400
X-MC-Unique: EfQFLPgmMYaiiyjPymdAFQ-1
X-Mimecast-MFC-AGG-ID: EfQFLPgmMYaiiyjPymdAFQ_1778672360
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7c24193e2b8so72122967b3.0
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 04:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778672360; cv=none;
        d=google.com; s=arc-20240605;
        b=Am9pLvckQH28wFtJ4n79NEZOV4ptkOP1teD4gvYu+2e0ymIhVDl6/JUA9XtgMXdX/I
         wHqX5bjrR5FnY+RiuGdOW+uon1pH046HSHCNoHsOh1qNgc89yh9C/5xOp6aCn66t7zN1
         llRTemqw0kIo/qiGMYMmqxGnGwVuLy1gwz6WfAyrc4oNlOZoPYzD6550FZOuh7MvHS51
         RLB68g2P5O/i5gLtnfAaWxDm3kWnuQq2D5pDhc7DkOx3q9OwX3eRIvIoLm6puBfg2FJJ
         BDb0wZYbKY/eYKn4doEk/+1CgKeHtwH9ZKilAEkt3XS9kh9p+fdoJVQF6dWPrM3qN3Nr
         ZJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hS/2FuqLU5pwunCNcA3n2Q2AppnYr82PFc8PIbH39/U=;
        fh=yNvkvf08bhPsv1uOEODB+GvJ65wHb9U6Hqw0PDl6onc=;
        b=NCQO6u/w8o1J7NkMo2JTNdsT8MNLD8B6+6MxlMjz3c6HS9xwdGuheFfalxIO8HOvDX
         4MvBTN/Dh0OHkRxC5phb02VIsV7a5itG8bkMp0lwx5nDu3hiCL0oh1vIk1pTHxt2J3K3
         JIxtgwVWV7BiLUZRvNnyIwUQuElg1v4lAvHjqu3cayeyXh8kxOiai6ymqH2r9plfsdHQ
         xPltYes37RFEZ8lYDHhse7anUfbSTwOesAmT2a8+bc9faPpe0FYCX+YZ18mbnzZzLRVo
         CzOvCiguHyRsVYHDYSFZvAyoYH9rKFsnvDb42MhzxGaRmPgebbqeu1+1mZhCoZAkWt7r
         wkag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778672360; x=1779277160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hS/2FuqLU5pwunCNcA3n2Q2AppnYr82PFc8PIbH39/U=;
        b=QFe/G9C4QuQMgubSfjHBzGiAnTNZlSjyy+5Vu+nE5Kf58PqwosiWaUZnQN9frHj4ct
         gjm7wGjvd+eZxRey7DiN/FX+bIXAJBGej7xTa6hMwG/4vioFs3DoPBToT1v3cbTKUCdG
         TW5V0EUENgBqXv8Nx9dXijRrPs/H5hZ5NGrfxhFJOz0E+RhZ0u/9ylCm9iMsIjIPsHhI
         zb5v76vBF46AiNnG8A70n69M7KvcFdx3NFBp72GP2UqgcW1s7c1xQ81+U7GkIFrEIiIv
         dPepQF8Q0j3UeUNkE3pXSjDTCKHek9h551hRhexeuESlIGheDUUtrjTw/+wrvlqX3dwp
         eo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778672360; x=1779277160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hS/2FuqLU5pwunCNcA3n2Q2AppnYr82PFc8PIbH39/U=;
        b=m80B3rpJGPn14cyzGQ+6BBhSNowsheZE/URvi59toxje6rfqDYNK47FSF0qNKmZ6Jp
         51NckhDkGb6jpTrP5p3z/M1ZV8zEbblMf8Ok4kRM5X9r4dWXDVLDMrqo/rD9aQjwY02d
         rPAKihqLAjYfeHeGlswfqHoi7QkDLl/06yjZet1zT/tXwagtBQ/R9Qv4pMAYdUzPH1v1
         cYhSQcWXzGhsKugslBvDRSGsJfrcqqitnPGsOSqCDJqPXRHbTOScFGSOOhzvkepGBLt7
         nYWTla00ypB5ATJ2XFZ4HkZ4k24EFFP0RCXm6dPFWZrLzugQKdfdvdn94I6q/00y/KYS
         aC9w==
X-Forwarded-Encrypted: i=1; AFNElJ/yLFj3H3g1QSqIQdY1HfW+IPPbbeXe03FMiU2lnRd6+6APCYmvwc7DQjPEqSYjBP9joz2y6o6D@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Amw/RaFJ2MXF0gRkUZHuu2BTv/rBXsKL9HOVXfHiKdS0zZuG
	dbHaemC1B6MZeJ0GBvUD9hMADwQl/VE3wpSp92HZ8czY1AN7c1AGwpN5Se3I76G2Swo0ZaFOdbm
	zrKoswwH39Jts3pmUHLfBn9nYcYDJUwBmPbDE77gcY9n4DbvFh3Z+zDd/f1EFEIC9Ospi5pSjtA
	BRTcUWqm9idIS4E9tD7+/JpczDOQRXliRQrg==
X-Gm-Gg: Acq92OFOPHy/0GRyj98Ge84a2vvvGlm2KQSj/Pe6daVSooaEuvUSEtggYlotsgr2Umv
	Id81IRs9tWFTX+O22vqwSqb8FK2BgDLMqadBlwl1B1AWnhv5yh0pZizimYPt5GR6DHYw89eMCLR
	hLerf8qUQ/QNEL05wQ29IHY329eHJ8x8cX7z2goehtcWXT3ilOuSdqajFWzqCcN9TUgRV3yhj9J
	zn6Mg==
X-Received: by 2002:a05:690c:ec9:b0:79b:73dc:d30b with SMTP id 00721157ae682-7c6ab5e7f27mr28939957b3.8.1778672359859;
        Wed, 13 May 2026 04:39:19 -0700 (PDT)
X-Received: by 2002:a05:690c:ec9:b0:79b:73dc:d30b with SMTP id
 00721157ae682-7c6ab5e7f27mr28939637b3.8.1778672359313; Wed, 13 May 2026
 04:39:19 -0700 (PDT)
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
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 13 May 2026 13:39:07 +0200
X-Gm-Features: AVHnY4I5m32D5Cdj2nVcdFoZWX746xqo3L8u6WpqbwAq2rXYLtU6Dq-6Gs38REw
Message-ID: <CADSE00Jq_uvNgvxgPze0mEdUd+hF4-DPZkHy0KroWHZzygf4WA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: "T.J. Mercier" <tjmercier@google.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
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
X-Rspamd-Queue-Id: 6A2865326A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15889-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 8:53=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
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
> > I'm just not sure if this is future prove and will work for all use cas=
es, e.g. cloud gaming, native context for automotive etc...
> >
> > Essentially the problem boils down to two limitations:
> > 1) a piece of memory can only be charged to one cgroup, the framework d=
oesn't has a concept of charging shared memory to multiple groups
>
> Yup, memcg already has this problem with pagecache and shmem.
>
> > 2) when memory references in the form of file descriptors are passed be=
tween applications we have no way of changing the accounting to a different=
 cgroup
> >
> > The passing of the memory reference already has a well defined uAPI and=
 if we could solve those two limitations we not only solve the problem with=
out introducing new uAPI (with potential new security risks) but also solve=
 it for all other use cases which uses file descriptors as well as. E.g. me=
mfd, accel and GPU drivers etc...
> >
> > On the other hand it is really nice to finally see this tackled for at =
least DMA-buf heaps.
>
> I have a question about this part. Albert I guess you are interested
> only in accounting dmabuf-heap allocations, or do you expect to add
> __GFP_ACCOUNT or mem_cgroup_charge_dmabuf calls to other
> non-dmabuf-heap exporters?

We're scoping this to dma-buf heaps for now. CMA heaps and the dmem
controller are on the radar for follow-up/parallel work (there will be
dragons and will surely need discussion). For DRM and V4L2 the
long-term intent is migration to heaps, which would make direct
accounting on those paths unnecessary. udmabufs are already
memcg-charged, so adding a separate MEMCG_DMABUF would double count.
Are there any other exporters you had in mind that would benefit from
this approach?

BR,
Albert.

>
> > On the GPU side I have seen just another try of a driver doing some kin=
d of special driver specific accounting to solve this just a few weeks ago.=
 And to be honest such single driver island approach have the tendency to b=
reak more often that they are working correctly.
> >
> > Regards,
> > Christian.
> >
> > >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
> > >  drivers/dma-buf/dma-buf.c               | 16 ++++---------
> > >  drivers/dma-buf/dma-heap.c              | 42 +++++++++++++++++++++++=
+++++++---
> > >  drivers/dma-buf/heaps/system_heap.c     |  2 --
> > >  include/uapi/linux/dma-heap.h           |  6 +++++
> > >  5 files changed, 53 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/=
admin-guide/cgroup-v2.rst
> > > index 8bdbc2e866430..824d269531eb1 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1636,8 +1636,9 @@ The following nested keys are defined.
> > >               structures.
> > >
> > >         dmabuf (npn)
> > > -             Amount of memory used for exported DMA buffers allocate=
d by the cgroup.
> > > -             Stays with the allocating cgroup regardless of how the =
buffer is shared.
> > > +             Amount of memory used for exported DMA buffers allocate=
d by or on
> > > +             behalf of the cgroup. Stays with the allocating cgroup =
regardless
> > > +             of how the buffer is shared.
> > >
> > >         workingset_refault_anon
> > >               Number of refaults of previously evicted anonymous page=
s.
> > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > index ce02377f48908..23fb758b78297 100644
> > > --- a/drivers/dma-buf/dma-buf.c
> > > +++ b/drivers/dma-buf/dma-buf.c
> > > @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *dentr=
y)
> > >        */
> > >       BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
> > >
> > > -     mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->si=
ze) / PAGE_SIZE);
> > > -     mem_cgroup_put(dmabuf->memcg);
> > > +     if (dmabuf->memcg) {
> > > +             mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
> > > +                                       PAGE_ALIGN(dmabuf->size) / PA=
GE_SIZE);
> > > +             mem_cgroup_put(dmabuf->memcg);
> > > +     }
> > >
> > >       dmabuf->ops->release(dmabuf);
> > >
> > > @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dma_=
buf_export_info *exp_info)
> > >               dmabuf->resv =3D resv;
> > >       }
> > >
> > > -     dmabuf->memcg =3D get_mem_cgroup_from_mm(current->mm);
> > > -     if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf-=
>size) / PAGE_SIZE,
> > > -                                   GFP_KERNEL)) {
> > > -             ret =3D -ENOMEM;
> > > -             goto err_memcg;
> > > -     }
> > > -
> > >       file->private_data =3D dmabuf;
> > >       file->f_path.dentry->d_fsdata =3D dmabuf;
> > >       dmabuf->file =3D file;
> > > @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma_b=
uf_export_info *exp_info)
> > >
> > >       return dmabuf;
> > >
> > > -err_memcg:
> > > -     mem_cgroup_put(dmabuf->memcg);
> > >  err_file:
> > >       fput(file);
> > >  err_module:
> > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > > index ac5f8685a6494..ff6e259afcdc0 100644
> > > --- a/drivers/dma-buf/dma-heap.c
> > > +++ b/drivers/dma-buf/dma-heap.c
> > > @@ -7,13 +7,17 @@
> > >   */
> > >
> > >  #include <linux/cdev.h>
> > > +#include <linux/cgroup.h>
> > >  #include <linux/device.h>
> > >  #include <linux/dma-buf.h>
> > >  #include <linux/dma-heap.h>
> > > +#include <linux/memcontrol.h>
> > > +#include <linux/sched/mm.h>
> > >  #include <linux/err.h>
> > >  #include <linux/export.h>
> > >  #include <linux/list.h>
> > >  #include <linux/nospec.h>
> > > +#include <linux/pidfd.h>
> > >  #include <linux/syscalls.h>
> > >  #include <linux/uaccess.h>
> > >  #include <linux/xarray.h>
> > > @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
> > >                "Enable cgroup-based memory accounting for dma-buf hea=
p allocations (default=3Dfalse).");
> > >
> > >  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> > > -                              u32 fd_flags,
> > > -                              u64 heap_flags)
> > > +                              u32 fd_flags, u64 heap_flags,
> > > +                              struct mem_cgroup *charge_to)
> > >  {
> > >       struct dma_buf *dmabuf;
> > > +     unsigned int nr_pages;
> > > +     struct mem_cgroup *memcg =3D charge_to;
> > >       int fd;
> > >
> > >       /*
> > > @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap *=
heap, size_t len,
> > >       if (IS_ERR(dmabuf))
> > >               return PTR_ERR(dmabuf);
> > >
> > > +     nr_pages =3D len / PAGE_SIZE;
> > > +
> > > +     if (memcg)
> > > +             css_get(&memcg->css);
> > > +     else if (mem_accounting)
> > > +             memcg =3D get_mem_cgroup_from_mm(current->mm);
> > > +
> > > +     if (memcg) {
> > > +             if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KERN=
EL)) {
> > > +                     mem_cgroup_put(memcg);
> > > +                     dma_buf_put(dmabuf);
> > > +                     return -ENOMEM;
> > > +             }
> > > +             dmabuf->memcg =3D memcg;
> > > +     }
> > > +
> > >       fd =3D dma_buf_fd(dmabuf, fd_flags);
> > >       if (fd < 0) {
> > >               dma_buf_put(dmabuf);
> > > @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file *=
file, void *data)
> > >  {
> > >       struct dma_heap_allocation_data *heap_allocation =3D data;
> > >       struct dma_heap *heap =3D file->private_data;
> > > +     struct mem_cgroup *memcg =3D NULL;
> > > +     struct task_struct *task;
> > > +     unsigned int pidfd_flags;
> > >       int fd;
> > >
> > >       if (heap_allocation->fd)
> > > @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct file =
*file, void *data)
> > >       if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> > >               return -EINVAL;
> > >
> > > +     if (heap_allocation->charge_pid_fd) {
> > > +             task =3D pidfd_get_task(heap_allocation->charge_pid_fd,=
 &pidfd_flags);
> > > +             if (IS_ERR(task))
> > > +                     return PTR_ERR(task);
> > > +
> > > +             memcg =3D get_mem_cgroup_from_mm(task->mm);
> > > +             put_task_struct(task);
> > > +     }
> > > +
> > >       fd =3D dma_heap_buffer_alloc(heap, heap_allocation->len,
> > >                                  heap_allocation->fd_flags,
> > > -                                heap_allocation->heap_flags);
> > > +                                heap_allocation->heap_flags,
> > > +                                memcg);
> > > +     mem_cgroup_put(memcg);
> > >       if (fd < 0)
> > >               return fd;
> > >
> > > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/he=
aps/system_heap.c
> > > index 03c2b87cb1112..95d7688167b93 100644
> > > --- a/drivers/dma-buf/heaps/system_heap.c
> > > +++ b/drivers/dma-buf/heaps/system_heap.c
> > > @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(unsig=
ned long size,
> > >               if (max_order < orders[i])
> > >                       continue;
> > >               flags =3D order_flags[i];
> > > -             if (mem_accounting)
> > > -                     flags |=3D __GFP_ACCOUNT;
> > >               page =3D alloc_pages(flags, orders[i]);
> > >               if (!page)
> > >                       continue;
> > > diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-h=
eap.h
> > > index a4cf716a49fa6..e02b0f8cbc6a1 100644
> > > --- a/include/uapi/linux/dma-heap.h
> > > +++ b/include/uapi/linux/dma-heap.h
> > > @@ -29,6 +29,10 @@
> > >   *                   handle to the allocated dma-buf
> > >   * @fd_flags:                file descriptor flags used when allocat=
ing
> > >   * @heap_flags:              flags passed to heap
> > > + * @charge_pid_fd:   optional pidfd of the process whose cgroup shou=
ld be
> > > + *                   charged for this allocation; 0 means charge the=
 calling
> > > + *                   process's cgroup
> > > + * @__padding:               reserved, must be zero
> > >   *
> > >   * Provided by userspace as an argument to the ioctl
> > >   */
> > > @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
> > >       __u32 fd;
> > >       __u32 fd_flags;
> > >       __u64 heap_flags;
> > > +     __u32 charge_pid_fd;
> > > +     __u32 __padding;
> > >  };
> > >
> > >  #define DMA_HEAP_IOC_MAGIC           'H'
> > >
> >
>


