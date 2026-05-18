Return-Path: <cgroups+bounces-16049-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JPEEwGCC2oNIwUAu9opvQ
	(envelope-from <cgroups+bounces-16049-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 23:17:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCBB573BB8
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 23:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64B70303BBA2
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB47D397E8D;
	Mon, 18 May 2026 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2JbJ7lZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5678328610
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139062; cv=pass; b=dYorJAXeseKk+001T6McGFD2qdwi7ILV+h+DVtF3Zdx9aiiL4GH0kyf2v3UOq4fZAzBZIE3o2fWbkyC1026dfx5+athHF10fvzrOABf5coahy9Bu9vK6E/HYX+qhCwU92dhbWge3V4gGRtvdz3KojZdc7/NVDAuyHe2BTW6jOwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139062; c=relaxed/simple;
	bh=5vGdQyHp/I7JpGHhFk5fuQSzwyP9mbsuOCfc+s4mAv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2dMcMy7ioHDIsiIjUhN9UumqSTKuD5K68XG1Sjec2+k6YIF7oXOFvFHKSSqkVBtfztdIw9+lIKuU+Xi8SL0B6x2AQJi4mIwnYIuMcd2gzGVa+vTLzqdL3WqjiBGPBaghNFVsrq2RmpSyf551ecj6NX9Hn+eoKXN/jYasDl17r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2JbJ7lZ; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so55e9.1
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 14:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779139059; cv=none;
        d=google.com; s=arc-20240605;
        b=LTkSbXJLsRqQ4h+34KYFMFLSYRPTbvqiskqoauHnTNoPAkBMv6yXGne9POLGFgfmkE
         i40mSf7Zi3d9TYxLeRjyG6Ooe9RmhtY/dx77mwyvihhjTEApc9KEUkVtrc5FZ139DBJH
         Mke2mWu/eB2DvVD+703f4oon9oEpF+yQeLTMBSR+EIO4stJ1osQxh42WvUmYYAHmpSmM
         LuJ47a9hUGaQJi8msPEJgtbaz7z3ef4hgikab9m+d4bnlZHNc3LNI5VZg63SK0EWWW2F
         dN39miJ5YE2jfem0xoVZqgCUcJgTRCUWXoBw8fwdopTtdUd6pE9WK+TIiXyVdMukHdoW
         IRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=log57cx8SdjIr5w2o2XwNSf2dPRv6imxY1LxmZJSaF0=;
        fh=ByO6iqmYpqZpA3MmpWDVcjvgF3FcXkSFfO3uYctTk3E=;
        b=jlxg7FxclUHpFTNvq1xYurV9ELZhEhzBIh2eUAJP7TcY4jIfOp+CmQM5j0vI1DS6rm
         4ePsqd6JpDoII0G8B7n76u1v4rTS8By9v8Um7cBHCqF0dvCKNRCZB7zzTXIpqKjY+91K
         2d07ZmZKSphuyuuHsODD2Nd9O1g78qnlZKTTfI/Ro6Yb86m6/2XXWNdjf4N3UAgp6mIm
         pwEGbOcduXR8nAjLpJi/gVZpIgsUbv4RzVQsfyHKAr8pgz4dk3+/lwi2Dgepd6ByMAr/
         uN5lJAAZfMBzpx92ZxGwXMxIKn8XN8ERRWWfI2KJieh1oPDFPaZAaR16QxMnM81WIpZE
         yR1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779139059; x=1779743859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=log57cx8SdjIr5w2o2XwNSf2dPRv6imxY1LxmZJSaF0=;
        b=k2JbJ7lZHGQ+jVMY2vstQvctCN7mgH3ovFbAyWiKjT/QHJl6RDsYXnBym/Vq8MVsnY
         VdS7pP4zUllKvJwn/6HN1sA5gjNFA3BsRZXh57jsQdBChX1yAUh/oc1x53Cwgq9v8/dS
         WyhmC2QxDx8ACFPiiOClK5N3fcrigo7U9CKqyqYxYdS+shOhBSwHcT6DFOgDbTKD2k2x
         inl9u4+tOQdDcpTde2dJqu4PfdRd0R5RqKOYLvtRx5bwaRlAp4MdtwZd8ImvmRBazHhL
         xpOaq60msFXqZwUOCjd9kBfnF+a8yxCswBJAPbKXXVkWw8KllZ9n7gIdFdeXz72ypZkj
         7ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779139059; x=1779743859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=log57cx8SdjIr5w2o2XwNSf2dPRv6imxY1LxmZJSaF0=;
        b=Gx/rxuASTwoKMHo/+hTzhzZKCIHNgbuZBR6BcA04Hc6cAtnUPt4nrAdneRszJ2IONW
         8phycW46wLa/djU1jFq8rkkoG/aNKvuaCMVKxYKhEhfBHwdeNPEndy0WMoMzSEDuO1WH
         6ACxaFQiBlt5mNbzx9uPHfDxiXzGtoKu1kJMi8Lrpuj5krdssggJxdFKxdtrfcgy9v7M
         AXmAqqPpfqKY8/PxfzSq0XnVv+n1qF/EkAcobwETjqDVzld4sz27FQhbkDXXBkNbygrD
         wugTgfKIFRTKyRO+baA6GE5WeKfXQ0g1M1au0XsedGZBwH1SVxRIvW+K8M/ptfXDtS8/
         MWjw==
X-Forwarded-Encrypted: i=1; AFNElJ9xhfLVy1X277iuBnf7qVLf+13T5IK3v9eJQ1vNkzuOwlbjK0p+0f27whfveiSOBEDstjyBlnmM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg2QlF4P4SSsty7VQXk/IYQsi2nlx7e8WiqXcAwgHvAxRwgcVI
	rYFULwaGYkLSvOOAjRvTI5nrZj+G+IKiRMiMJZgNMD1HJcTfuvxV5qdE+ikkN58mx5hfsPco//u
	GXZ6l2dMrk4GILjoWzyb0adYuILTDmavG6HNhLalG
X-Gm-Gg: Acq92OGT5vnb4TWNnqjzqwv889qzkwO/0BCwoGHx2b0o7pk9xcM8HCPzolwWDQRcY9X
	KbdY/thZrAjob0Sfvy697ameU2c5Rl65ey9tNK6+1wVsN20/Jioqmz1CdKvVVqSpe1AlIASbGcq
	XPq19OZsuRjvd0F81NCpKYr9u5ZOjPf3MJNPaLqwftTU1GYVwErerhEfAvTWGg35VUKr92wj6Z1
	42RhtFM/fsvw5C0/UjjB8fgn6RvGiKTDokIiAzMPNF+so5VnNpCEEdLwq9IHAHWaCIYpMemLFW0
	eq31MuHf0J2SVXSAaWGk/h6KO3/FqF0VMJQ1rVEh/tpy92uz7jKOqMaBQqc=
X-Received: by 2002:a05:600c:5888:b0:45f:2940:d194 with SMTP id
 5b1f17b1804b1-48ffa5a3865mr1584195e9.2.1779139058579; Mon, 18 May 2026
 14:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CAGsJ_4zjrFJYQQsLThTGXR6g+2PXzeAhjyDpLHfDFqVViWvyBQ@mail.gmail.com> <CABdmKX0gqg309hcXcOHSj_yTg0h1zwDL34GDk8mX3wp4YoyfDg@mail.gmail.com>
In-Reply-To: <CABdmKX0gqg309hcXcOHSj_yTg0h1zwDL34GDk8mX3wp4YoyfDg@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 14:17:26 -0700
X-Gm-Features: AVHnY4KTHXYs5nrbWVXYvXQ9l6M2g--DIK3-AK3RR8R_cqbjNyBgiR1O8BbuYxI
Message-ID: <CABdmKX3wwgovwS-V8rVC3=+EZcTvPs_cttpQb1w6WemwLAVhsw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16049-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,android.com:url]
X-Rspamd-Queue-Id: 0BCBB573BB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 2:12=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Sat, May 16, 2026 at 1:40=E2=80=AFAM Barry Song <baohua@kernel.org> wr=
ote:
> >
> > On Wed, May 13, 2026 at 2:54=E2=80=AFAM T.J. Mercier <tjmercier@google.=
com> wrote:
> > >
> > > On Tue, May 12, 2026 at 3:14=E2=80=AFAM Christian K=C3=B6nig
> > > <christian.koenig@amd.com> wrote:
> > > >
> > > > On 5/12/26 11:10, Albert Esteve wrote:
> > > > > On embedded platforms a central process often allocates dma-buf
> > > > > memory on behalf of client applications. Without a way to
> > > > > attribute the charge to the requesting client's cgroup, the
> > > > > cost lands on the allocator, making per-cgroup memory limits
> > > > > ineffective for the actual consumers.
> > > > >
> > > > > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> > > > > a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> > > > > memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> > > > > inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> > > > > the mem_accounting module parameter enabled, the buffer is charge=
d
> > > > > to the allocator's own cgroup.
> > > > >
> > > > > Additionally, commit 3c227be90659 ("dma-buf: system_heap: account=
 for
> > > > > system heap allocation in memcg") adds __GFP_ACCOUNT to system-he=
ap
> > > > > page allocations. Keeping __GFP_ACCOUNT would charge the same pag=
es
> > > > > twice (once to kmem, once to MEMCG_DMABUF), thus remove it and ro=
ute
> > > > > all accounting through a single MEMCG_DMABUF path.
> > > > >
> > > > > Usage examples:
> > > > >
> > > > >   1. Central allocator charging to a client at allocation time.
> > > > >      The allocator knows the client's PID (e.g., from binder's
> > > > >      sender_pid) and uses pidfd to attribute the charge:
> > > > >
> > > > >        pid_t client_pid =3D txn->sender_pid;
> > > > >        int pidfd =3D pidfd_open(client_pid, 0);
> > > > >
> > > > >        struct dma_heap_allocation_data alloc =3D {
> > > > >            .len             =3D buffer_size,
> > > > >            .fd_flags        =3D O_RDWR | O_CLOEXEC,
> > > > >            .charge_pid_fd   =3D pidfd,
> > > > >        };
> > > > >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > > > >        close(pidfd);
> > > > >        /* alloc.fd is now charged to client's cgroup */
> > > > >
> > > > >   2. Default allocation (no pidfd, mem_accounting=3D1).
> > > > >      When charge_pid_fd is not set and the mem_accounting module
> > > > >      parameter is enabled, the buffer is charged to the allocator=
's
> > > > >      own cgroup:
> > > > >
> > > > >        struct dma_heap_allocation_data alloc =3D {
> > > > >            .len      =3D buffer_size,
> > > > >            .fd_flags =3D O_RDWR | O_CLOEXEC,
> > > > >        };
> > > > >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > > > >        /* charged to current process's cgroup */
> > > > >
> > > > > Current limitations:
> > > > >
> > > > >  - Single-owner model: a dma-buf carries one memcg charge regardl=
ess of
> > > > >    how many processes share it. Means only the first owner (and e=
xporter)
> > > > >    of the shared buffer bears the charge.
> > > > >  - Only memcg accounting supported. While this makes sense for sy=
stem
> > > > >    heap buffers, other heaps (e.g., CMA heaps) will require selec=
tively
> > > > >    charging also for the dmem controller.
> > > >
> > > > Well that doesn't looks soo bad, it at least seems to tackle the pr=
oblem at hand for Android and some of other embedded use cases.
> > >
> > > Yeah I think this might work. I know of 3 cases, and it trivially
> > > solves the first two. The third requires some work on our end to
> > > extend our userspace interfaces to include the pidfd but it seems
> > > doable. I'm checking with our graphics folks.
> > >
> > > 1) Direct allocation from user (e.g. app -> allocation ioctl on
> > > /dev/dma_heap/foo)
> > > No changes required to userspace. mem_accounting=3D1 charges the app.
> > >
> > > 2) Single hop remote allocation (e.g. app -> AHardwareBuffer_allocate
> > > -> gralloc)
> > > gralloc has the caller's pid as described in the commit message. Open
> > > a pidfd and pass it in the dma_heap_allocation_data.
> > >
> > > 3) Double hop remote allocation (e.g. app -> dequeueBuffer ->
> > > SurfaceFlinger -> gralloc)
> > > In this case gralloc knows SurfaceFlinger's pid, but not the app's. S=
o
> > > we need to add the app's pidfd to the SurfaceFlinger -> gralloc
> > > interface, or transfer the memcg charge from SurfaceFlinger to the ap=
p
> > > after the allocation.
> > > It'd be nice to avoid the charge transfer option entirely, but if we
> > > need it that doesn't seem so bad in this case because it's a bulk
> > > charge for the entire dmabuf rather than per-page. So the exporter
> > > doesn't need to get involved (we wouldn't need a new dma_buf_op) and
> > > we wouldn't have to worry about looping and locking for each page.
> > >
> >
> > Hi T.J.,
> >
> > Your description of the three different cases sounds very interesting.
> > It helps me understand how difficult it can be to correctly charge
> > dma-buf in the current user scenarios.
> >
> > I=E2=80=99m wondering where I can find Android userspace code that tran=
sfers
> > the PID of RPC callers. Do we have any existing sample code in Android
> > for this?
>
> Hi Barry,
>
> In Java android.os.Binder.getCallingPid() will provide it. Here

... let me try again

Here are some examples from the framework code:

https://cs.android.com/search?q=3DgetCallingPid%20f:ActivityManager&sq=3D&s=
s=3Dandroid%2Fplatform%2Fsuperproject

In native code we have AIBinder_getCallingPid and
android::IPCThreadState::self()->getCallingPid() (or
android::hardware::IPCThreadState::self()->getCallingPid() for HIDL)

https://cs.android.com/search?q=3DgetCallingPid%20l:cpp%20-f:prebuilt&ss=3D=
android%2Fplatform%2Fsuperproject

