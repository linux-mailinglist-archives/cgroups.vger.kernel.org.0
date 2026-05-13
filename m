Return-Path: <cgroups+bounces-15892-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOJpFudyBGprIQIAu9opvQ
	(envelope-from <cgroups+bounces-15892-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 14:47:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2E85334AC
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 14:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00C1330C14B7
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED79E38757A;
	Wed, 13 May 2026 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWEgefCV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc+c1Ssd"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70641C2E2
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676115; cv=pass; b=kNk7C8Bs6s/vZ19EK7iP07KvY9Xzea/VTMYRAOwXqax9MRhHt8s2uQ/Bbaiovb7/4AQ8fcOZAbM4A9lX1c4QtGAvUX0V4FMOMALukvb4GztuFiVkkbLCSRc/SyBNBJtU5R0Jl7ht57VNGXivolzwAW0XODQVxzqQU6nhik1uXHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676115; c=relaxed/simple;
	bh=L/wYW9IF0FeMQ8Wtbxz4pehnliZS976zGzHZnl9wEsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnZP9gFPLCANwdVjBrcQFJNLyiklPq6qLIxk5GyWXnzq0aGMRwuML29KGao5O/ipzDRk4PtkTG8c1K4wMBsUy2WMYkwjzMg/NQAKHABYgYQIX1aOGE3njx92GrdKEFVLtgzUw0vqOA3yX5niwqNERcZzfnnxbNvNCHEVHAflRVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWEgefCV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc+c1Ssd; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778676113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOEhaYXxHcDCT/VWabJKKAhll1HKQfDPQhsQeGsErgM=;
	b=MWEgefCVWkLg5T5K7hUKq842mpCLXuF1xYZc1YxGuxwTkRFi5go01TVrAJWA268mwnyUUq
	OsSmCFQVfOsH7Y7tsr0KjxnIGP5O+AgUASyfsWL4Fi7qn34UL2iQk4qseajND9FkvtkfoO
	Vb9+IkYtvqxzRNuCcvgNi7F27FCfXF4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-laQI2zM0Nv6AjpfDvcnaCw-1; Wed, 13 May 2026 08:41:51 -0400
X-MC-Unique: laQI2zM0Nv6AjpfDvcnaCw-1
X-Mimecast-MFC-AGG-ID: laQI2zM0Nv6AjpfDvcnaCw_1778676111
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7bd5c9e1826so131484737b3.1
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 05:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778676111; cv=none;
        d=google.com; s=arc-20240605;
        b=Q1BkPOWMQqUBa+xFvTlYI5qNnDoYlKAXKQBjlkRpzsihxgLaXJj2pg5CsGOrBEmOWr
         saY1m+NCqKMNIaS55BPbESEUcJmUgDstkdCziC1KmnK+mvMluMe/JrVzADBzxw7wD3kR
         gE0vvpyHtP1+EN68R+e26yl+29+HJ4SZT4tO7sjHOsLBNg3M7LbDBoGtGobmD230VQP/
         jE4mulk8EaL1pfw4qQ5rzG6h8+eQf9GOEetpLIJMGXGZl6jP3G8Rs/eLI/ugaT39rS/c
         IZ+MDWuhCV+x8w0JuC4WsispoIVdJyAcOBLNlbJ7tL2GfYYUMpaTo0VoqmD00N6L+JTg
         VeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zOEhaYXxHcDCT/VWabJKKAhll1HKQfDPQhsQeGsErgM=;
        fh=cyHa/IKwpkQmI6fG5hdCYjL2YbnY6P7zI2+cbsJaY9E=;
        b=h/KedcdSu75MLlvVc9Ip7eHrXNoRC/q7Bv3GK9IMv5KlP0SAhcF7wo/jwldOsEHCWi
         SSuCQjAse4pZfobOSuMjlqKYsADn64Gam7YbKwu4AWx/16zR7RUQmY3cxed4Xu8lQoJ1
         YGHOv5xvosPq2bP6HjMUpzSbv3Fxa26FKYl/DEe6KIpVSTX+Rqa0SBLbSlPe7DDBLXs+
         95gtz2V7VieIniJCO9oFRZx1aWnhKu1/YPVmLwGulKaBGrgytIJyWqLuzGPZ+57ltkhS
         k/HBBHBQJ+QIb61fVybJ5z6sLoOFyKPFAeVKz3aKG1FLl6pIbWLGRCpPFZ3YpUQeoqDj
         PngA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778676111; x=1779280911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOEhaYXxHcDCT/VWabJKKAhll1HKQfDPQhsQeGsErgM=;
        b=Sc+c1Ssd81aAzeuRYA4EmSUsh2NdPHcHckGiMSnZQyklXXSnC3Ve/VwJHuV22SLaZM
         u9CqRcRCyqnVlojA8xomU2IEwTBt3FDmLgxo09E8rPL2+5ly9YGUsOiTV6sfg9J11dOI
         OVTXAbMddiTHdPZZDeDuCClQ55uYR5Ye9cbIwI2ozNrOuCVoVyJh/olhe82uojOTApBv
         /8h6PrvUkS2GXn4Q7OJ9jluTHLo0h03rnGa1zvCgjFH/17t5IQd6cW3k0HA915qMcpaU
         fhl6zMM96OCwamELi/dp3J9vUT7k7I7F+F6hniEnSB25T5sb2vSYgXXnr3p32KNboMAl
         /MrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676111; x=1779280911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zOEhaYXxHcDCT/VWabJKKAhll1HKQfDPQhsQeGsErgM=;
        b=bVCPmKT8T5K3/38wfvENGsB5RVSA7s3V9bUQ/qRiUAY/tm7qTY5ZiUvupXE2Btt+b6
         N0QUTBhVZEBM7cIGtlM33hM9E8mhSloDBWtbTsUiemhSK6DXjMHSO0QnIjRruRfFgTyA
         QK591sDbyPSB4EuzPoKejx7pgcl29e6W0hCrfUL4LAq9+mTF9v+AeiIUgUL+ESQ7NjTx
         2sLPKndkPOZTyAkDPZufqAsqf7AwDVTTQ08TKiG/eObcsWthUlOKDPyRV2V/zODd9K3P
         h+jPWSTINY9am+mPNx5WscMd8wGWmMFr1V1WkEwDRuLVpALsWDjsuVS+STcsyQXKC9w4
         47oA==
X-Forwarded-Encrypted: i=1; AFNElJ8OZJpH39o5iHZJUMMT9rWny0X3c6agDCoZN7Mf8DUEyBMX5DggvAk+l1LNjq/qy0ct+Iu6UH8e@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZBoeahG/Fk+RlhnFjgMbS922vRN+IKuBQaWvQr+Ym99zl5Z6
	Or4Y+IDmz7CqX7HeEf0vFnSMFf8ws8PtCvXBrN/gJN5mxJ3L9sUWNVMALYMgIuNpgp/MqPHHa/E
	GkE70Z9Alsx2AfODHla7ROeHcLCIgYkwNnfeuGRorBMhnNxfCKmEIQ5baz//WihdqsEDIIc7lNQ
	+0xSxoG4xuxqDY1Gc69h+hzGXW9W06QU1Ujw==
X-Gm-Gg: Acq92OEmdiOYTw4lO5FQ1iffLhlebPKGSmfjK6KV1wooFhiTNV52jqG9/meAJw5eoOC
	dIC9326mpC6jnVMst4la2RmuP7kFJOqeZNgC5Y8kWWqWn7Ir658ZNA6Xvv+qVsDuBVCg5K/1Igc
	CQckSX42ny7or1zWOukFn0/6eczav3NdsfLeglyFnYG4f18nmAtH5iElCteDr+6/DPL9XcRpO6o
	8nLag==
X-Received: by 2002:a05:690c:348a:b0:7bf:ff7:ea71 with SMTP id 00721157ae682-7c69ae49726mr25055117b3.17.1778676110925;
        Wed, 13 May 2026 05:41:50 -0700 (PDT)
X-Received: by 2002:a05:690c:348a:b0:7bf:ff7:ea71 with SMTP id
 00721157ae682-7c69ae49726mr25053037b3.17.1778676105682; Wed, 13 May 2026
 05:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com> <8ef38815-6ae9-4359-86d4-042554357639@amd.com>
In-Reply-To: <8ef38815-6ae9-4359-86d4-042554357639@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 13 May 2026 14:41:33 +0200
X-Gm-Features: AVHnY4I5gWDDEj4SX_HuB44fjlMWKZYdMLtmbKqRDSeay77iEzEWghV7sNPOxmY
Message-ID: <CADSE00KZMJFYJ92XZa=r9EeJJRGT=SNChwOW-_jTznc7F79xGw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
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
X-Rspamd-Queue-Id: CB2E85334AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15892-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 12:14=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/12/26 11:10, Albert Esteve wrote:
> > On embedded platforms a central process often allocates dma-buf
> > memory on behalf of client applications. Without a way to
> > attribute the charge to the requesting client's cgroup, the
> > cost lands on the allocator, making per-cgroup memory limits
> > ineffective for the actual consumers.
> >
> > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
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
>
> Well that doesn't looks soo bad, it at least seems to tackle the problem =
at hand for Android and some of other embedded use cases.
>
> I'm just not sure if this is future prove and will work for all use cases=
, e.g. cloud gaming, native context for automotive etc...
>
> Essentially the problem boils down to two limitations:
> 1) a piece of memory can only be charged to one cgroup, the framework doe=
sn't has a concept of charging shared memory to multiple groups
> 2) when memory references in the form of file descriptors are passed betw=
een applications we have no way of changing the accounting to a different c=
group
>
> The passing of the memory reference already has a well defined uAPI and i=
f we could solve those two limitations we not only solve the problem withou=
t introducing new uAPI (with potential new security risks) but also solve i=
t for all other use cases which uses file descriptors as well as. E.g. memf=
d, accel and GPU drivers etc...

Honestly, adding a hook to fd-passing uAPI to manage charge transfers
sounds like a promising solution requiring no uAPI changes. However,
it still does not cover all paths, e.g., dup() or fork(). And shared
memory sounds like a hard one to tackle, where deciding the best
policy is more a per-usecase thing and would probably require
userspace configuration. All in all, charge_pid_fd covers a
well-defined and immediately practical subset. The UAPI cost is small
and the mechanism is explicit about what it does and doesn't solve. A
general solution, if it ever converges, would likely supersede
charge_pid_fd for most cases, which is a fine outcome if it solves the
problem more completely.

Either way, if you have a specific approach in mind for solving any of
the above limitations, I'd be happy to look into it further.

BR,
Albert.

>
> On the other hand it is really nice to finally see this tackled for at le=
ast DMA-buf heaps. On the GPU side I have seen just another try of a driver=
 doing some kind of special driver specific accounting to solve this just a=
 few weeks ago. And to be honest such single driver island approach have th=
e tendency to break more often that they are working correctly.
>
> Regards,
> Christian.
>
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
>


