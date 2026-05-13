Return-Path: <cgroups+bounces-15900-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIGpFHuoBGqPMgIAu9opvQ
	(envelope-from <cgroups+bounces-15900-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 18:36:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 309BE5372ED
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 18:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A42A73004627
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26944CA267;
	Wed, 13 May 2026 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQC3JTdm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88484CA293
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690148; cv=pass; b=q2XcMORZKuk1wjgzwyD8AGHVq9w0MYaK54lz3qDLHH6lMEtaepNW6p0/hJANftZHe5YrY8yEDTb+TD0XAL644bDVqSECs+m5tB+25ALirVJ+1n/OleyAP8HREyNfJHDaaiSq4bCZa4wnv9HWBHkDD3zHG1bqaEGyhC6Q2M+Fn0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690148; c=relaxed/simple;
	bh=Jq1fWy244eY5eEMPZv5X1HbRD0PUMAliVcwDS0t0Xiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgxisDnrbTZq6t3F57mk07SUXchNB/AxbztkKz6TwqxTk4/jUvVX4s59iaUqqWLNQvQFjbV9kNQCpQ8eOo3if8xjOR3pXe5FV1tV1ihIJdPzaNIDRVCm+q8fqt6fJI01gQAIMEog+tKbNMpnvvwMB2F15ZhtHPmL6j1LzTCw0tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQC3JTdm; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48d1c670255so3455e9.0
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 09:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778690144; cv=none;
        d=google.com; s=arc-20240605;
        b=SGP/xovHPoiP3dW/FR4NU2HBojLT6zPa5yohwGbuE7AEHzgAvlG3Qq0bnQktErU/kN
         Fuljqm+uBWbhCgfyhZV9xm5P0uYjB3wVK7F0ms6iCu36XUX47ZQgiUU8PEE0KuE2jMbJ
         VQO4ZD671PzCuBAAokehC20px/offjdZcAwj58+7k1DhFnlQwdvtYon5Eu70p82HPmgg
         sOlN3oXlb6JC8KCmQ1U4JQ5ah6dDIeVKv8en/Lk/0XeXv54g5i01B/OdIKFhD1jTj3ji
         ONhhskRrThBVREp/K4VgwVE5O+AwRxwiA+gRwJTZNuIamfXsEzpvqYN2pOzEt4Ouo1LO
         L6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zj0jmb9V6uocZqGLBP2x2wTsHN3iLoSffmt/99lGtBQ=;
        fh=XlbaY2nLpsTZejb92meCDcYFNJPDedQJjHKeYom7nwc=;
        b=WS1bGbU7j0dop2ilGK3qguvltXd+QQpHH3CP491EOaNcKzJR7LGrtUdYSFeIS/9ISx
         C0eYoOVnj5Hbe7SCFqkd3QLkgH5zIeDLPuGutGThes1iNtmNhb3THk60HhOquX2PoNEn
         J58mH4ApGCQ7t9WPN9JrR7hTGuyRb5+dluaDU9RWvDX3pVcAM8EQSN+Da9FiOCGj4fAh
         LVDd6bidtAa15ar+P0mgd1+rUIV3GQoUr/yIwSF7c0LkcDpR3Wk/7Ueg5hFwF9/RGFoQ
         v2NmHYKo2dh2ETW9fSvPQwNNSVYOans1VYv8tBYp2FZyWv1FqN3QgTlSKfd0j+1lCzVg
         85wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778690144; x=1779294944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj0jmb9V6uocZqGLBP2x2wTsHN3iLoSffmt/99lGtBQ=;
        b=dQC3JTdmhCh2WLloctDlvW9VYT6jDBzuT3Qy7g2uZK4kmx2qdp9IrxVx/V/stGTbKq
         PHIKaolbomeybxGrCVmzS8Ne3OuGo7tw4N3jiECFc9XKKDlxmR4kTFB6l3m6u9llaK2l
         tA9yqwO6Wrrhph0byFld1Nl/3rwhKgq8d51cbU9TK09Qp4e+t9Xfjch5DJIXk3vRYUnA
         cJNIiAPxTk78MLWkgwY/+WZqeNcnLpNJMrYJU8dEz0aIxZsx6xLepBUmjw97WWU2aJh9
         eY/czNKncxJfW7ICx/3yJ/K1ymUawoIa6quDsiisdcVL/7OGbfojvMuXJl59SpYeBKut
         s4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690144; x=1779294944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zj0jmb9V6uocZqGLBP2x2wTsHN3iLoSffmt/99lGtBQ=;
        b=P9Bplq3klXZpm/QIDkqsAxZ+D7JIdLXTMs8ZOkHdwB9PeyO4czCFXnDBEUTGW8tmlC
         8Xwiu6kAA5cf3PQptuhXPaxGhVKTdjxUf3FTvsGOfiBZCspqHEMvwhd4GFWcCRZNpEmq
         drlU5BJc7n2AvZYntFgyafJmipc0MbLc/XHSumpGvlX9SYoz3Lr5olENoq38KMgeE2Qj
         Gkc2VZpgOZItsMyqD4lsqoIa5E4RGKW0t2tu7iRsfICbvuYUbTKkriyhJ1IUXHH05XtU
         XM3wf5OhBv2XRW8QpA1KsTJluX+eyBziEDz3LPX1ezegcCJbssavLF3TihcN0fkdDQVU
         9dEA==
X-Forwarded-Encrypted: i=1; AFNElJ/k9Q1kAVMPOXnyvrPsSDjIMEaWkwmaj0bhqJaNDzHvHkoBmRPBmeetcPwCXjFm5kYQhr062Nwl@vger.kernel.org
X-Gm-Message-State: AOJu0YwFLlRpV+mGP8OG0si5muax9bgqb7qDtrxXosga28Nl8s0u/nrY
	tpVbkrdt6QPuNUqGu9QhwT5ZX6cXJYwoL18ZVTjH7L9BZGJVmqTB/yVKD1nYKa3vDvZAKtwuauJ
	MfFL1Wc7uJ3OBVAmOiSBq+2eud/XkAlqPnf4T5fw1
X-Gm-Gg: Acq92OHh98iVaqfku4d884gAvUf1a3Wcoev6+OUGl1cff6JAL34zXyCLo4yoN++ZykP
	oWYRNwsacqVdb7LsuqMDIE8wGfLjwSgUJxm6+cCaTPGq30KKUESnb9akXiPc8xiSWFSgBSKam4m
	FT098tO7Z1xkMCrggFHngHHwU2PM8wVfrbnhMakK4sor4QRJJ2OBhuMESZ7ytUOA7C1Xb0oBCps
	0uBjuTlsS1pxy5CTCMG1PLgOlE0n3eyy8Gx+5F++w9FUH3xrSw0PcqCO/iklXk8mtZfpIOjLpch
	DZcJgWflxkCJ4bnrsWazGfcNVH0jaQU7vCoJgdyfkvdhyulR4RY6u122CPlhenn4G9FqQybVqrh
	IWiEA
X-Received: by 2002:a05:600c:498a:b0:48a:5d55:c194 with SMTP id
 5b1f17b1804b1-48fcaebf633mr637765e9.7.1778690143587; Wed, 13 May 2026
 09:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CADSE00Jq_uvNgvxgPze0mEdUd+hF4-DPZkHy0KroWHZzygf4WA@mail.gmail.com>
In-Reply-To: <CADSE00Jq_uvNgvxgPze0mEdUd+hF4-DPZkHy0KroWHZzygf4WA@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 13 May 2026 09:35:30 -0700
X-Gm-Features: AVHnY4Iz5pSM22PHb1EjHxZSE2q7iQu1xvmkgoj7rmjnAMtDWn75b0gWmoJdQQM
Message-ID: <CABdmKX3DhejYBis9htLDnzPrG7vuF3R3URLVNEbnyd61SSsx=g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Albert Esteve <aesteve@redhat.com>
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
X-Rspamd-Queue-Id: 309BE5372ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15900-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 4:39=E2=80=AFAM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On Tue, May 12, 2026 at 8:53=E2=80=AFPM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > On Tue, May 12, 2026 at 3:14=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> > >
> > > On 5/12/26 11:10, Albert Esteve wrote:
> > > > On embedded platforms a central process often allocates dma-buf
> > > > memory on behalf of client applications. Without a way to
> > > > attribute the charge to the requesting client's cgroup, the
> > > > cost lands on the allocator, making per-cgroup memory limits
> > > > ineffective for the actual consumers.
> > > >
> > > > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> > > > a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> > > > memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> > > > inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> > > > the mem_accounting module parameter enabled, the buffer is charged
> > > > to the allocator's own cgroup.
> > > >
> > > > Additionally, commit 3c227be90659 ("dma-buf: system_heap: account f=
or
> > > > system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> > > > page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> > > > twice (once to kmem, once to MEMCG_DMABUF), thus remove it and rout=
e
> > > > all accounting through a single MEMCG_DMABUF path.
> > > >
> > > > Usage examples:
> > > >
> > > >   1. Central allocator charging to a client at allocation time.
> > > >      The allocator knows the client's PID (e.g., from binder's
> > > >      sender_pid) and uses pidfd to attribute the charge:
> > > >
> > > >        pid_t client_pid =3D txn->sender_pid;
> > > >        int pidfd =3D pidfd_open(client_pid, 0);
> > > >
> > > >        struct dma_heap_allocation_data alloc =3D {
> > > >            .len             =3D buffer_size,
> > > >            .fd_flags        =3D O_RDWR | O_CLOEXEC,
> > > >            .charge_pid_fd   =3D pidfd,
> > > >        };
> > > >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > > >        close(pidfd);
> > > >        /* alloc.fd is now charged to client's cgroup */
> > > >
> > > >   2. Default allocation (no pidfd, mem_accounting=3D1).
> > > >      When charge_pid_fd is not set and the mem_accounting module
> > > >      parameter is enabled, the buffer is charged to the allocator's
> > > >      own cgroup:
> > > >
> > > >        struct dma_heap_allocation_data alloc =3D {
> > > >            .len      =3D buffer_size,
> > > >            .fd_flags =3D O_RDWR | O_CLOEXEC,
> > > >        };
> > > >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > > >        /* charged to current process's cgroup */
> > > >
> > > > Current limitations:
> > > >
> > > >  - Single-owner model: a dma-buf carries one memcg charge regardles=
s of
> > > >    how many processes share it. Means only the first owner (and exp=
orter)
> > > >    of the shared buffer bears the charge.
> > > >  - Only memcg accounting supported. While this makes sense for syst=
em
> > > >    heap buffers, other heaps (e.g., CMA heaps) will require selecti=
vely
> > > >    charging also for the dmem controller.
> > >
> > > Well that doesn't looks soo bad, it at least seems to tackle the prob=
lem at hand for Android and some of other embedded use cases.
> >
> > Yeah I think this might work. I know of 3 cases, and it trivially
> > solves the first two. The third requires some work on our end to
> > extend our userspace interfaces to include the pidfd but it seems
> > doable. I'm checking with our graphics folks.
> >
> > 1) Direct allocation from user (e.g. app -> allocation ioctl on
> > /dev/dma_heap/foo)
> > No changes required to userspace. mem_accounting=3D1 charges the app.
> >
> > 2) Single hop remote allocation (e.g. app -> AHardwareBuffer_allocate
> > -> gralloc)
> > gralloc has the caller's pid as described in the commit message. Open
> > a pidfd and pass it in the dma_heap_allocation_data.
> >
> > 3) Double hop remote allocation (e.g. app -> dequeueBuffer ->
> > SurfaceFlinger -> gralloc)
> > In this case gralloc knows SurfaceFlinger's pid, but not the app's. So
> > we need to add the app's pidfd to the SurfaceFlinger -> gralloc
> > interface, or transfer the memcg charge from SurfaceFlinger to the app
> > after the allocation.
> > It'd be nice to avoid the charge transfer option entirely, but if we
> > need it that doesn't seem so bad in this case because it's a bulk
> > charge for the entire dmabuf rather than per-page. So the exporter
> > doesn't need to get involved (we wouldn't need a new dma_buf_op) and
> > we wouldn't have to worry about looping and locking for each page.
> >
> > > I'm just not sure if this is future prove and will work for all use c=
ases, e.g. cloud gaming, native context for automotive etc...
> > >
> > > Essentially the problem boils down to two limitations:
> > > 1) a piece of memory can only be charged to one cgroup, the framework=
 doesn't has a concept of charging shared memory to multiple groups
> >
> > Yup, memcg already has this problem with pagecache and shmem.
> >
> > > 2) when memory references in the form of file descriptors are passed =
between applications we have no way of changing the accounting to a differe=
nt cgroup
> > >
> > > The passing of the memory reference already has a well defined uAPI a=
nd if we could solve those two limitations we not only solve the problem wi=
thout introducing new uAPI (with potential new security risks) but also sol=
ve it for all other use cases which uses file descriptors as well as. E.g. =
memfd, accel and GPU drivers etc...
> > >
> > > On the other hand it is really nice to finally see this tackled for a=
t least DMA-buf heaps.
> >
> > I have a question about this part. Albert I guess you are interested
> > only in accounting dmabuf-heap allocations, or do you expect to add
> > __GFP_ACCOUNT or mem_cgroup_charge_dmabuf calls to other
> > non-dmabuf-heap exporters?
>
> We're scoping this to dma-buf heaps for now. CMA heaps and the dmem
> controller are on the radar for follow-up/parallel work (there will be
> dragons and will surely need discussion). For DRM and V4L2 the
> long-term intent is migration to heaps, which would make direct
> accounting on those paths unnecessary.

Ah I see. GEM buffers exported to dmabufs are what I had in mind. I
guess this would only leave the odd non-DRM driver with the need to
add their own accounting calls, which I don't expect would be a big
problem.

> udmabufs are already
> memcg-charged, so adding a separate MEMCG_DMABUF would double count.
> Are there any other exporters you had in mind that would benefit from
> this approach?
>
> BR,
> Albert.
>
> >
> > > On the GPU side I have seen just another try of a driver doing some k=
ind of special driver specific accounting to solve this just a few weeks ag=
o. And to be honest such single driver island approach have the tendency to=
 break more often that they are working correctly.
> > >
> > > Regards,
> > > Christian.
> > >
> > > >
> > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > ---
> > > >  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
> > > >  drivers/dma-buf/dma-buf.c               | 16 ++++---------
> > > >  drivers/dma-buf/dma-heap.c              | 42 +++++++++++++++++++++=
+++++++++---
> > > >  drivers/dma-buf/heaps/system_heap.c     |  2 --
> > > >  include/uapi/linux/dma-heap.h           |  6 +++++
> > > >  5 files changed, 53 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentatio=
n/admin-guide/cgroup-v2.rst
> > > > index 8bdbc2e866430..824d269531eb1 100644
> > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > @@ -1636,8 +1636,9 @@ The following nested keys are defined.
> > > >               structures.
> > > >
> > > >         dmabuf (npn)
> > > > -             Amount of memory used for exported DMA buffers alloca=
ted by the cgroup.
> > > > -             Stays with the allocating cgroup regardless of how th=
e buffer is shared.
> > > > +             Amount of memory used for exported DMA buffers alloca=
ted by or on
> > > > +             behalf of the cgroup. Stays with the allocating cgrou=
p regardless
> > > > +             of how the buffer is shared.
> > > >
> > > >         workingset_refault_anon
> > > >               Number of refaults of previously evicted anonymous pa=
ges.
> > > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > > index ce02377f48908..23fb758b78297 100644
> > > > --- a/drivers/dma-buf/dma-buf.c
> > > > +++ b/drivers/dma-buf/dma-buf.c
> > > > @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *den=
try)
> > > >        */
> > > >       BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
> > > >
> > > > -     mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->=
size) / PAGE_SIZE);
> > > > -     mem_cgroup_put(dmabuf->memcg);
> > > > +     if (dmabuf->memcg) {
> > > > +             mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
> > > > +                                       PAGE_ALIGN(dmabuf->size) / =
PAGE_SIZE);
> > > > +             mem_cgroup_put(dmabuf->memcg);
> > > > +     }
> > > >
> > > >       dmabuf->ops->release(dmabuf);
> > > >
> > > > @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dm=
a_buf_export_info *exp_info)
> > > >               dmabuf->resv =3D resv;
> > > >       }
> > > >
> > > > -     dmabuf->memcg =3D get_mem_cgroup_from_mm(current->mm);
> > > > -     if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabu=
f->size) / PAGE_SIZE,
> > > > -                                   GFP_KERNEL)) {
> > > > -             ret =3D -ENOMEM;
> > > > -             goto err_memcg;
> > > > -     }
> > > > -
> > > >       file->private_data =3D dmabuf;
> > > >       file->f_path.dentry->d_fsdata =3D dmabuf;
> > > >       dmabuf->file =3D file;
> > > > @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma=
_buf_export_info *exp_info)
> > > >
> > > >       return dmabuf;
> > > >
> > > > -err_memcg:
> > > > -     mem_cgroup_put(dmabuf->memcg);
> > > >  err_file:
> > > >       fput(file);
> > > >  err_module:
> > > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.=
c
> > > > index ac5f8685a6494..ff6e259afcdc0 100644
> > > > --- a/drivers/dma-buf/dma-heap.c
> > > > +++ b/drivers/dma-buf/dma-heap.c
> > > > @@ -7,13 +7,17 @@
> > > >   */
> > > >
> > > >  #include <linux/cdev.h>
> > > > +#include <linux/cgroup.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/dma-buf.h>
> > > >  #include <linux/dma-heap.h>
> > > > +#include <linux/memcontrol.h>
> > > > +#include <linux/sched/mm.h>
> > > >  #include <linux/err.h>
> > > >  #include <linux/export.h>
> > > >  #include <linux/list.h>
> > > >  #include <linux/nospec.h>
> > > > +#include <linux/pidfd.h>
> > > >  #include <linux/syscalls.h>
> > > >  #include <linux/uaccess.h>
> > > >  #include <linux/xarray.h>
> > > > @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
> > > >                "Enable cgroup-based memory accounting for dma-buf h=
eap allocations (default=3Dfalse).");
> > > >
> > > >  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len=
,
> > > > -                              u32 fd_flags,
> > > > -                              u64 heap_flags)
> > > > +                              u32 fd_flags, u64 heap_flags,
> > > > +                              struct mem_cgroup *charge_to)
> > > >  {
> > > >       struct dma_buf *dmabuf;
> > > > +     unsigned int nr_pages;
> > > > +     struct mem_cgroup *memcg =3D charge_to;
> > > >       int fd;
> > > >
> > > >       /*
> > > > @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap=
 *heap, size_t len,
> > > >       if (IS_ERR(dmabuf))
> > > >               return PTR_ERR(dmabuf);
> > > >
> > > > +     nr_pages =3D len / PAGE_SIZE;
> > > > +
> > > > +     if (memcg)
> > > > +             css_get(&memcg->css);
> > > > +     else if (mem_accounting)
> > > > +             memcg =3D get_mem_cgroup_from_mm(current->mm);
> > > > +
> > > > +     if (memcg) {
> > > > +             if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KE=
RNEL)) {
> > > > +                     mem_cgroup_put(memcg);
> > > > +                     dma_buf_put(dmabuf);
> > > > +                     return -ENOMEM;
> > > > +             }
> > > > +             dmabuf->memcg =3D memcg;
> > > > +     }
> > > > +
> > > >       fd =3D dma_buf_fd(dmabuf, fd_flags);
> > > >       if (fd < 0) {
> > > >               dma_buf_put(dmabuf);
> > > > @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file=
 *file, void *data)
> > > >  {
> > > >       struct dma_heap_allocation_data *heap_allocation =3D data;
> > > >       struct dma_heap *heap =3D file->private_data;
> > > > +     struct mem_cgroup *memcg =3D NULL;
> > > > +     struct task_struct *task;
> > > > +     unsigned int pidfd_flags;
> > > >       int fd;
> > > >
> > > >       if (heap_allocation->fd)
> > > > @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct fil=
e *file, void *data)
> > > >       if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> > > >               return -EINVAL;
> > > >
> > > > +     if (heap_allocation->charge_pid_fd) {
> > > > +             task =3D pidfd_get_task(heap_allocation->charge_pid_f=
d, &pidfd_flags);
> > > > +             if (IS_ERR(task))
> > > > +                     return PTR_ERR(task);
> > > > +
> > > > +             memcg =3D get_mem_cgroup_from_mm(task->mm);
> > > > +             put_task_struct(task);
> > > > +     }
> > > > +
> > > >       fd =3D dma_heap_buffer_alloc(heap, heap_allocation->len,
> > > >                                  heap_allocation->fd_flags,
> > > > -                                heap_allocation->heap_flags);
> > > > +                                heap_allocation->heap_flags,
> > > > +                                memcg);
> > > > +     mem_cgroup_put(memcg);
> > > >       if (fd < 0)
> > > >               return fd;
> > > >
> > > > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/=
heaps/system_heap.c
> > > > index 03c2b87cb1112..95d7688167b93 100644
> > > > --- a/drivers/dma-buf/heaps/system_heap.c
> > > > +++ b/drivers/dma-buf/heaps/system_heap.c
> > > > @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(uns=
igned long size,
> > > >               if (max_order < orders[i])
> > > >                       continue;
> > > >               flags =3D order_flags[i];
> > > > -             if (mem_accounting)
> > > > -                     flags |=3D __GFP_ACCOUNT;
> > > >               page =3D alloc_pages(flags, orders[i]);
> > > >               if (!page)
> > > >                       continue;
> > > > diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma=
-heap.h
> > > > index a4cf716a49fa6..e02b0f8cbc6a1 100644
> > > > --- a/include/uapi/linux/dma-heap.h
> > > > +++ b/include/uapi/linux/dma-heap.h
> > > > @@ -29,6 +29,10 @@
> > > >   *                   handle to the allocated dma-buf
> > > >   * @fd_flags:                file descriptor flags used when alloc=
ating
> > > >   * @heap_flags:              flags passed to heap
> > > > + * @charge_pid_fd:   optional pidfd of the process whose cgroup sh=
ould be
> > > > + *                   charged for this allocation; 0 means charge t=
he calling
> > > > + *                   process's cgroup
> > > > + * @__padding:               reserved, must be zero
> > > >   *
> > > >   * Provided by userspace as an argument to the ioctl
> > > >   */
> > > > @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
> > > >       __u32 fd;
> > > >       __u32 fd_flags;
> > > >       __u64 heap_flags;
> > > > +     __u32 charge_pid_fd;
> > > > +     __u32 __padding;
> > > >  };
> > > >
> > > >  #define DMA_HEAP_IOC_MAGIC           'H'
> > > >
> > >
> >
>

