Return-Path: <cgroups+bounces-16032-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN15J3YMC2pN/gQAu9opvQ
	(envelope-from <cgroups+bounces-16032-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 14:56:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B7856D24C
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 14:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E60893058671
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F844CAF3;
	Mon, 18 May 2026 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+iE65dw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lq0PJ5IT"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15349449EC5
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108647; cv=pass; b=B14KWL8CSGWJkqZzs2ffmg7bmPOtr/pyzQO+/PdbUiv8k/Z4Zup35QoGxHOgf3nwhnJRzGrH9d6ou2DpmN9iyDRE2Gi1lffePhAXjgXydufwSackHx6yym2zEhIQ6i7H4EgjoblAOEd/WkNxaKFsXOWo8F5UOWYO9sdXdAKkp/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108647; c=relaxed/simple;
	bh=2SxzrS0DGp89vUJWVtqZoEzOzAxn7JVMcHC7WjqbRbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Omo8h42PdijJgY8ixjvPEZwtgouEHyDMAQC3pN32jy+U8zaIaqrwnxC+43if8ZTpgDJmx5s21GYnRMPxRyTk++efbDuQESPf7ebSAkhtLsutQl4tdzBuqCVxRk1b4szDA6Lp83IRHMDaEBsF9o9NhZwRGTSV7L8V+YHdQLF/ViQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+iE65dw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lq0PJ5IT; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779108644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRhhMtWag6dFHgJ+9KXfvh39yjXyi0gyNukph7J5ngs=;
	b=A+iE65dwepd/3+vSRtmUf/iqrI1tMTKPLQkOHG6tYXmDxvkUlafCeCC/KLrSGhAf3vG2rz
	Fo3zoZcMDMFXCmHBXlS8F1azQjjDOQJQYc4YVFYCtu9a+2RAtAi0xJvN9rdrqiLNz4IRkn
	t8YGkqbc1bh31TZmT/BVq2u71N38ZvY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-u2MPoZg5OtSJRLUuuJk38Q-1; Mon, 18 May 2026 08:50:42 -0400
X-MC-Unique: u2MPoZg5OtSJRLUuuJk38Q-1
X-Mimecast-MFC-AGG-ID: u2MPoZg5OtSJRLUuuJk38Q_1779108642
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7bd726a9569so28146467b3.3
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 05:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779108642; cv=none;
        d=google.com; s=arc-20240605;
        b=QEAm91OEw1MrkqqosyeaEWfCeaBvwJurDYvDbpcrJR+BzOS2yDygXO03vQti8KWKEz
         iE5DhdNXC8kZn9eEmdlfeFpCpk15n0oF7jtp4TgRBwpNa2XalV9d4k7UrldxAejzMx1p
         qiiTFvQYl3mwJYlRvhrzhEdHTEmQo1IeCGBV7cxsGZfJeRBnbfbP3QNYR3cqCLKdL00c
         bgKYfZiPeadjaFv75pgMm/5Wa48ofn7gI+dh0IJPD0fAZ75qbrYLFT3WSmvWx39g5GMC
         eYihoooJlx45OT/PLO9Z16iNGQSBr1+qfXwiSi0fLu8QIoEtpygXKl+0rI5CpDeGFk89
         ps4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eRhhMtWag6dFHgJ+9KXfvh39yjXyi0gyNukph7J5ngs=;
        fh=ssaYhDw58cHlOG0i/JbwkPKw1Kpz/GS3dp+TSs0F7Sg=;
        b=KsjKzVcoHZJoDb2mcCLJJQeHADuWdITcU4N8SD+f8avUg4n/YWfDr4HS//MhrudfTB
         J2Qd3HIZzerwEiitCEJvmML5fguFLM9GCV5Qgb2rE5fu1v4XPpU7VvXNwdQda1f3W7s6
         5TZNIu89szv53rwQQdJPbSHE+sfovg42OnY+ULxlfqe8QFVStAJeWdicr9m2AVQtb0Ja
         b5VqqukYXG4xqZr7Z/9eY0K/xz0iPnMWIE60cpVf6GmMWuzSnDqMo3sehG6HzIPFEfgK
         qnp0k4QU6zh7SVYadpjZLN8HflVUVeI58CVVT6x11gSOyfSKD5aPm9JSfnDtfHTbtkwl
         R9hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779108642; x=1779713442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRhhMtWag6dFHgJ+9KXfvh39yjXyi0gyNukph7J5ngs=;
        b=lq0PJ5ITc/jbS0p2vTR4r+xln4hrYydzzjXl8vHR807q61LMtMN1KeD2tiLFB3zkPd
         YNKUDQtTr0hkUcEJqGM1VjpLlyGt5T4RWiI2ipyDpzxkQ9YSv2kdQVBE+zygr8wdOVas
         twvUYTDNudGAOIdSGLaZPy/R61JZAVVEBIqwiRwhuhTeIjXv8LHmtN3RUgebpggKPpZq
         sgmaMuLp1dxdwLHf0J89AfMTz6IKIXL7IfhuIigDKuVpbqnascNrjSWx3Yi8dUfmqwvN
         ScnySXTSVIaE1sFR4Gq5/Cmw85VBQnLWpFLggqV7wHRZ1jWQV8z9FNlfwMKy8r+EPOhb
         Y+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108642; x=1779713442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eRhhMtWag6dFHgJ+9KXfvh39yjXyi0gyNukph7J5ngs=;
        b=sJuSRO2geapQSQdWTU6uQUKVrQk6YXt/Jjp6Xc6V8Asd/BtYgiuGJFRF5a+q3M16aK
         h+al+RAVDiJ7inxTEP9hnPT9eIN+S5y+HSIdeNhgxuxeh+bFa4JHPar8GZZgItuNTis3
         zbu2NKUhNDRwjCXGjPru8IBa14Vq9rFCNPCl7Bl03hdWHu1QuOGWOOqRwuHUlwephtYQ
         7CZcQtx6TG/13dDDwQUFcjztIdKH30eWSbzlrcd8jrZW/paV+maJKoIAJ75Zuw613KW3
         7dN1SZbklgk6IRaMsFH+m7LpbVU8wCR5I0U+NutbvMtlf9JRZ0DjDAKtl4fiNMwzhG+f
         Qt0g==
X-Forwarded-Encrypted: i=1; AFNElJ/ODvdurqsXqwzukQljhXRl8BXSHPiZVfKnXOWbO/+zNHDbjMWiZtos7IVkB9EMzlfkLcofckfB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Sk1r/6t7Xrgj+z/mhJBFPE98CV4zOgj8dEIiQ7Dv5ncdzh40
	AzKCcDmUwt7PRSWokcrUHfU8tBbJtmA6ZL1cy7adnsbHwM4clYbKoMEBaPtFjiAQA3OlaHdaqK6
	HGJGfrQ94cTpMrX04SKQ2WUPn6FuaiBd6ejXoJ7rfH+zrK8rwge36V49Kl5M4WXbjIvMWvV/mEV
	udIw1LsrLh6IdUtCNZS8n/oI72UGj5Oo2Tdg==
X-Gm-Gg: Acq92OHxk9UcLf+TiH6FKCq2yBeKHceklywiI7hON3D4hRiecMBxqjjYN/dHuJmZvEQ
	WYVBOwzIxjk6TV7pAwkpKcgOemm2vIJNjnN7uFLVH+1WQAQL05cnKpa9BNKVFfJuAUlP4C/H1tl
	4+bwbuOLqb5FoNtAo0pSV6lkacfWKGAeesCdhgYOHf+eQIYTbIvfQNG2zL6jQWBegnJDsTGGO7x
	lVQjw==
X-Received: by 2002:a05:690c:c504:b0:7ba:f0ed:c5ea with SMTP id 00721157ae682-7c95c202cb8mr151839557b3.39.1779108642055;
        Mon, 18 May 2026 05:50:42 -0700 (PDT)
X-Received: by 2002:a05:690c:c504:b0:7ba:f0ed:c5ea with SMTP id
 00721157ae682-7c95c202cb8mr151838957b3.39.1779108641320; Mon, 18 May 2026
 05:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <20260515-hinschauen-effizient-9e3a05a94f2e@brauner> <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
 <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com>
In-Reply-To: <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 18 May 2026 14:50:30 +0200
X-Gm-Features: AVHnY4JVeUZbQl3fJZojeCwshobXzZdw1dcYItf6HM2iKIo4t723byYD2xZMKVg
Message-ID: <CADSE00Lh95ygoXGKJGsYvQGEsFV8sVmwEC3uvh8M6r3ERzaJwg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
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
X-Rspamd-Queue-Id: 85B7856D24C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16032-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/15/26 19:06, T.J. Mercier wrote:
> > On Fri, May 15, 2026 at 6:53=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> >>
> >> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> >>> On embedded platforms a central process often allocates dma-buf
> >>> memory on behalf of client applications. Without a way to
> >>> attribute the charge to the requesting client's cgroup, the
> >>> cost lands on the allocator, making per-cgroup memory limits
> >>> ineffective for the actual consumers.
> >>>
> >>> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> >>
> >> Please be aware that pidfds come in two flavors:
> >>
> >> thread-group pidfds and thread-specific pidfds. Make sure that your AP=
I
> >> doesn't implicitly depend on this distinction not existing.
> >
> > Hi Christian,
> >
> > Memcg is not a controller that supports "thread mode" so all threads
> > in a group should belong to the same memcg.
>
> BTW: Exactly that is the requirement automotive has with their native con=
text use case.
>
> The use case is that you have a deamon which has multiple threads were ea=
ch one is acting on behalve of some other process.
>
> At the moment we basically say they are simply not using cgroups for that=
 use case, but it would be really nice if we could handle that as well.
>
> Summarizing the requirement of that use case: You need a different cgroup=
 for each thread of a process.

Hi Christian,

Thanks for sharing this atuomotive usecase. If I understand correctly,
the actual requirement is attributing dma-buf charges to the right
client, not putting each daemon thread in a different cgroup? If so,
the `charge_pid_fd` approach achieves this directly by passing the
client's `pid_fd`, without needing to add per-thread cgroup
infrastructure.

>
> Regards,
> Christian.
>
> >
> > Checking the flags from pidfd_get_pid would be the best way for an
> > explicit check of the pidfd type?
> >
> >>> a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> >>> memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> >>> inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> >>> the mem_accounting module parameter enabled, the buffer is charged
> >>> to the allocator's own cgroup.
> >>>
> >>> Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> >>> system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> >>> page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> >>> twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> >>> all accounting through a single MEMCG_DMABUF path.
> >>>
> >>> Usage examples:
> >>>
> >>>   1. Central allocator charging to a client at allocation time.
> >>>      The allocator knows the client's PID (e.g., from binder's
> >>>      sender_pid) and uses pidfd to attribute the charge:
> >>>
> >>>        pid_t client_pid =3D txn->sender_pid;
> >>>        int pidfd =3D pidfd_open(client_pid, 0);
> >>>
> >>>        struct dma_heap_allocation_data alloc =3D {
> >>>            .len             =3D buffer_size,
> >>>            .fd_flags        =3D O_RDWR | O_CLOEXEC,
> >>>            .charge_pid_fd   =3D pidfd,
> >>>        };
> >>>        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> >>>        close(pidfd);
> >>>        /* alloc.fd is now charged to client's cgroup */
> >>>
> >>>   2. Default allocation (no pidfd, mem_accounting=3D1).
> >>>      When charge_pid_fd is not set and the mem_accounting module
> >>>      parameter is enabled, the buffer is charged to the allocator's
> >>>      own cgroup:
> >>>
> >>>        struct dma_heap_allocation_data alloc =3D {
> >>>            .len      =3D buffer_size,
> >>>            .fd_flags =3D O_RDWR | O_CLOEXEC,
> >>>        };
> >>>        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> >>>        /* charged to current process's cgroup */
> >>>
> >>> Current limitations:
> >>>
> >>>  - Single-owner model: a dma-buf carries one memcg charge regardless =
of
> >>>    how many processes share it. Means only the first owner (and expor=
ter)
> >>>    of the shared buffer bears the charge.
> >>>  - Only memcg accounting supported. While this makes sense for system
> >>>    heap buffers, other heaps (e.g., CMA heaps) will require selective=
ly
> >>>    charging also for the dmem controller.
> >>>
> >>> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >>> ---
> >>>  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
> >>>  drivers/dma-buf/dma-buf.c               | 16 ++++---------
> >>>  drivers/dma-buf/dma-heap.c              | 42 +++++++++++++++++++++++=
+++++++---
> >>>  drivers/dma-buf/heaps/system_heap.c     |  2 --
> >>>  include/uapi/linux/dma-heap.h           |  6 +++++
> >>>  5 files changed, 53 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/=
admin-guide/cgroup-v2.rst
> >>> index 8bdbc2e866430..824d269531eb1 100644
> >>> --- a/Documentation/admin-guide/cgroup-v2.rst
> >>> +++ b/Documentation/admin-guide/cgroup-v2.rst
> >>> @@ -1636,8 +1636,9 @@ The following nested keys are defined.
> >>>               structures.
> >>>
> >>>         dmabuf (npn)
> >>> -             Amount of memory used for exported DMA buffers allocate=
d by the cgroup.
> >>> -             Stays with the allocating cgroup regardless of how the =
buffer is shared.
> >>> +             Amount of memory used for exported DMA buffers allocate=
d by or on
> >>> +             behalf of the cgroup. Stays with the allocating cgroup =
regardless
> >>> +             of how the buffer is shared.
> >>>
> >>>         workingset_refault_anon
> >>>               Number of refaults of previously evicted anonymous page=
s.
> >>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> >>> index ce02377f48908..23fb758b78297 100644
> >>> --- a/drivers/dma-buf/dma-buf.c
> >>> +++ b/drivers/dma-buf/dma-buf.c
> >>> @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *dentr=
y)
> >>>        */
> >>>       BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
> >>>
> >>> -     mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->si=
ze) / PAGE_SIZE);
> >>> -     mem_cgroup_put(dmabuf->memcg);
> >>> +     if (dmabuf->memcg) {
> >>> +             mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
> >>> +                                       PAGE_ALIGN(dmabuf->size) / PA=
GE_SIZE);
> >>> +             mem_cgroup_put(dmabuf->memcg);
> >>> +     }
> >>>
> >>>       dmabuf->ops->release(dmabuf);
> >>>
> >>> @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dma_=
buf_export_info *exp_info)
> >>>               dmabuf->resv =3D resv;
> >>>       }
> >>>
> >>> -     dmabuf->memcg =3D get_mem_cgroup_from_mm(current->mm);
> >>> -     if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf-=
>size) / PAGE_SIZE,
> >>> -                                   GFP_KERNEL)) {
> >>> -             ret =3D -ENOMEM;
> >>> -             goto err_memcg;
> >>> -     }
> >>> -
> >>>       file->private_data =3D dmabuf;
> >>>       file->f_path.dentry->d_fsdata =3D dmabuf;
> >>>       dmabuf->file =3D file;
> >>> @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma_b=
uf_export_info *exp_info)
> >>>
> >>>       return dmabuf;
> >>>
> >>> -err_memcg:
> >>> -     mem_cgroup_put(dmabuf->memcg);
> >>>  err_file:
> >>>       fput(file);
> >>>  err_module:
> >>> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> >>> index ac5f8685a6494..ff6e259afcdc0 100644
> >>> --- a/drivers/dma-buf/dma-heap.c
> >>> +++ b/drivers/dma-buf/dma-heap.c
> >>> @@ -7,13 +7,17 @@
> >>>   */
> >>>
> >>>  #include <linux/cdev.h>
> >>> +#include <linux/cgroup.h>
> >>>  #include <linux/device.h>
> >>>  #include <linux/dma-buf.h>
> >>>  #include <linux/dma-heap.h>
> >>> +#include <linux/memcontrol.h>
> >>> +#include <linux/sched/mm.h>
> >>>  #include <linux/err.h>
> >>>  #include <linux/export.h>
> >>>  #include <linux/list.h>
> >>>  #include <linux/nospec.h>
> >>> +#include <linux/pidfd.h>
> >>>  #include <linux/syscalls.h>
> >>>  #include <linux/uaccess.h>
> >>>  #include <linux/xarray.h>
> >>> @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
> >>>                "Enable cgroup-based memory accounting for dma-buf hea=
p allocations (default=3Dfalse).");
> >>>
> >>>  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> >>> -                              u32 fd_flags,
> >>> -                              u64 heap_flags)
> >>> +                              u32 fd_flags, u64 heap_flags,
> >>> +                              struct mem_cgroup *charge_to)
> >>>  {
> >>>       struct dma_buf *dmabuf;
> >>> +     unsigned int nr_pages;
> >>> +     struct mem_cgroup *memcg =3D charge_to;
> >>>       int fd;
> >>>
> >>>       /*
> >>> @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap *=
heap, size_t len,
> >>>       if (IS_ERR(dmabuf))
> >>>               return PTR_ERR(dmabuf);
> >>>
> >>> +     nr_pages =3D len / PAGE_SIZE;
> >>> +
> >>> +     if (memcg)
> >>> +             css_get(&memcg->css);
> >>> +     else if (mem_accounting)
> >>> +             memcg =3D get_mem_cgroup_from_mm(current->mm);
> >>> +
> >>> +     if (memcg) {
> >>> +             if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KERN=
EL)) {
> >>> +                     mem_cgroup_put(memcg);
> >>> +                     dma_buf_put(dmabuf);
> >>> +                     return -ENOMEM;
> >>> +             }
> >>> +             dmabuf->memcg =3D memcg;
> >>> +     }
> >>> +
> >>>       fd =3D dma_buf_fd(dmabuf, fd_flags);
> >>>       if (fd < 0) {
> >>>               dma_buf_put(dmabuf);
> >>> @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file *=
file, void *data)
> >>>  {
> >>>       struct dma_heap_allocation_data *heap_allocation =3D data;
> >>>       struct dma_heap *heap =3D file->private_data;
> >>> +     struct mem_cgroup *memcg =3D NULL;
> >>> +     struct task_struct *task;
> >>> +     unsigned int pidfd_flags;
> >>>       int fd;
> >>>
> >>>       if (heap_allocation->fd)
> >>> @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct file =
*file, void *data)
> >>>       if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> >>>               return -EINVAL;
> >>>
> >>> +     if (heap_allocation->charge_pid_fd) {
> >>> +             task =3D pidfd_get_task(heap_allocation->charge_pid_fd,=
 &pidfd_flags);
> >>
> >> Will always get a thread-group leader pidfd and will fail if this is a
> >> thread-specific pidfd. pidfd_open(1234, PIDFD_THREAD) can be used to
> >> open a thread-specific pidfd.
> >>
> >>> +             if (IS_ERR(task))
> >>> +                     return PTR_ERR(task);
> >>> +
> >>> +             memcg =3D get_mem_cgroup_from_mm(task->mm);
> >>> +             put_task_struct(task);
> >>> +     }
> >>> +
> >>>       fd =3D dma_heap_buffer_alloc(heap, heap_allocation->len,
> >>>                                  heap_allocation->fd_flags,
> >>> -                                heap_allocation->heap_flags);
> >>> +                                heap_allocation->heap_flags,
> >>> +                                memcg);
> >>> +     mem_cgroup_put(memcg);
> >>>       if (fd < 0)
> >>>               return fd;
> >>>
> >>> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/he=
aps/system_heap.c
> >>> index 03c2b87cb1112..95d7688167b93 100644
> >>> --- a/drivers/dma-buf/heaps/system_heap.c
> >>> +++ b/drivers/dma-buf/heaps/system_heap.c
> >>> @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(unsig=
ned long size,
> >>>               if (max_order < orders[i])
> >>>                       continue;
> >>>               flags =3D order_flags[i];
> >>> -             if (mem_accounting)
> >>> -                     flags |=3D __GFP_ACCOUNT;
> >>>               page =3D alloc_pages(flags, orders[i]);
> >>>               if (!page)
> >>>                       continue;
> >>> diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-h=
eap.h
> >>> index a4cf716a49fa6..e02b0f8cbc6a1 100644
> >>> --- a/include/uapi/linux/dma-heap.h
> >>> +++ b/include/uapi/linux/dma-heap.h
> >>> @@ -29,6 +29,10 @@
> >>>   *                   handle to the allocated dma-buf
> >>>   * @fd_flags:                file descriptor flags used when allocat=
ing
> >>>   * @heap_flags:              flags passed to heap
> >>> + * @charge_pid_fd:   optional pidfd of the process whose cgroup shou=
ld be
> >>> + *                   charged for this allocation; 0 means charge the=
 calling
> >>> + *                   process's cgroup
> >>> + * @__padding:               reserved, must be zero
> >>>   *
> >>>   * Provided by userspace as an argument to the ioctl
> >>>   */
> >>> @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
> >>>       __u32 fd;
> >>>       __u32 fd_flags;
> >>>       __u64 heap_flags;
> >>> +     __u32 charge_pid_fd;
> >>> +     __u32 __padding;
> >>>  };
> >>>
> >>>  #define DMA_HEAP_IOC_MAGIC           'H'
> >>>
> >>> --
> >>> 2.53.0
> >>>
>


