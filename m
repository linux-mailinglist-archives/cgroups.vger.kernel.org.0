Return-Path: <cgroups+bounces-16071-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAbWKAkwDGpuZAUAu9opvQ
	(envelope-from <cgroups+bounces-16071-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 11:40:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD42F57B736
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 11:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50BF5303B2D1
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D424E3F58DE;
	Tue, 19 May 2026 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cM3I3Mnc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qvia8Yl1"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12643F0A9C
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182246; cv=pass; b=toXdkIs8KPyY2deE3C9qQ3weqiyYpjZ736isl9bUHGRyzNHZR7eTEC3LPV4cHpJS6eZF+wjuj176hCV22pA5biO6DoIT6SJM8AraVXVM6449yXKaTLokiE5JMg3UdFf0GC68yfElj5v+WqcMgIxuQKYpWgxk5YYX3XeGh2vJTZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182246; c=relaxed/simple;
	bh=ahxcxmkOaihabfP2WFI6asNswH1uQirOjdb0LjAlcss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSSDf1c+H2D2TZoyuTIbhy6BZPextEg7xrhln1OfX85Z60kmYa+Rls/wZwUmCrKzUJLw4vmyLT38DL1zmomJvWVCsURmLuFCmiA1E7/5eDrCH1/BW5iKKKDv00G6R6qbpJ1IM6sy8pKLXqbQ9wSLOFrNMo8LgY5b9Mqm+reQQgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cM3I3Mnc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qvia8Yl1; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779182243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahxcxmkOaihabfP2WFI6asNswH1uQirOjdb0LjAlcss=;
	b=cM3I3MncDkyLcYz6AJzTdkRXRAP6RNHfCCGRBIC9faN7rr64uQp0UGfln+TeYz54DzYDfR
	4vdLpw3eBCo1xGyA9KwVWpqblaJzqtgwkEWxmgniOhu4dhBVKR+XGqpCSBtcoFHL5ZzE+g
	aRE9HMdLjHsaS617kw/8wQEjVSnb4ow=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-GBu3uSRMOVerv8E-8ZL5HQ-1; Tue, 19 May 2026 05:17:22 -0400
X-MC-Unique: GBu3uSRMOVerv8E-8ZL5HQ-1
X-Mimecast-MFC-AGG-ID: GBu3uSRMOVerv8E-8ZL5HQ_1779182242
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7bd6f72e5aeso50123807b3.1
        for <cgroups@vger.kernel.org>; Tue, 19 May 2026 02:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779182242; cv=none;
        d=google.com; s=arc-20240605;
        b=MMv8/JOXmSlJC/VmjL1jPpCIC2vt50C843hVno7OPqNjEaVQbE/4cCAuN2MJagjJ2m
         6uw+rxVRU69hzvRytmMfJS8GdqPrwhPKfA/gtAEGaG91iNaea3Nf0SNEACPYEHHL7wLD
         +z2VIBzSy3SPjeMmBqUz1hhZG9CCr3UuyZJ5gbYTuTjUCJi65vI2nsTdHop5zrnXhMA8
         J6yXM2e/oMzfQEVoOATGC5SpP7+7bDJVmG8XJ0f49RRwMYLYNdFOKZoN/yuGtHG8VrYv
         j5WVkP5nF8fozxKQork8vMykQbntHNwdj/rA8RU4Ou2Pg+ShzElIyVAL+WhVOjvW5phR
         DouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ahxcxmkOaihabfP2WFI6asNswH1uQirOjdb0LjAlcss=;
        fh=EO+fKf3omi2mq5CfpMoymZ5l9zYFQKti8m4IhDcX/jA=;
        b=GdE2zghyiWY0/cNulECQzjy2ESs25FnfQfG5oH067LIDCQWI/6LUJdscRJmuR8Bygj
         1tSOVKPIY98UVlBNjCnd5CDtSzg2jBGa55f+DQFlj69GdvRx5GFfv6P8CeB4kaiQn1Fy
         8NwRvkWydSqI0SJt02m0KHHuDl5+nFJ+7vlgc0G7OWxa0aY5/IQHUVwmveRIFAfbVL5g
         0vOVse3oYnC0KkU2KCAdRgPKed15BYo8eWmMME+sbuXVT9mCKcAXvHHVHxvSZDbs7WIH
         LrAsPjBmLn7vBLga7SBwFwQduSDpBR+/k5dXVZSYuqYgnB+QFuqB/za/sWqYBlEgXoH1
         eLjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779182242; x=1779787042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahxcxmkOaihabfP2WFI6asNswH1uQirOjdb0LjAlcss=;
        b=qvia8Yl1VZBOEkQ86mS3aIVG1q8FX6h42hqISIixHt0A1lAeoANof82medLl6SbTC3
         cUO8xorSlCTK++u+4yVlN0vmpI8HJ367/nIuxoWC1isBD27Wig/2OMKkYMO38QPaiLIX
         vXL5233zvsFfIobVXoaiflR4ahGM0uUXaZFM8gb3vtRkcENHgWy8JLu56GHAp9WuK8qy
         v4KusyLi37P5MnD3/N3p8quc3k1QMk9WyTAwaNRn+P5JqRuWuiDjZzDJPH/7S7zXpi7Z
         big8Jox/ATLs3U9uyxFzDG25wvmOFvvSWmELbArKwjVnBP2nVsHzL391vCVlnPbTlkMe
         u3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182242; x=1779787042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahxcxmkOaihabfP2WFI6asNswH1uQirOjdb0LjAlcss=;
        b=ocrtqragxTSEU+1yr3GqZGiq77MsvX/k4190c+/P9CC0m0As7rJYzX4cizUkRgcct5
         U1vKqEUlaJvH4NtAtLc5W5MSdtZtg0L+jg14bkE4fcPA9/S9qaKNWTW12xWpKrwnXO7m
         Ps0Qn3+ouMJQ7Ucf/Q8hZSseF1KpLsuQzHKhSKKmoyaG8Z+c+GvWQmdfSMd3lB2Balum
         eZBuoGm+lhkfog4OPrJL1ofhh8BlRII4YDlXdXDXmVzf8S0qN77biSONDRYODoYs9Z9A
         qzaPqpOyC9Nceu2hT/PJZVFdGZ+wzjqoQ95vPz+0WTIjP8Y+uAs9nlsgEyxMXekSyRp1
         bPdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XwOGZeo1Pc52qdnHSQmI6alYyVuW+6u4J3LwGdectuq3NegD4QH2dCkqrCc7vc8lsmPFTrG9E@vger.kernel.org
X-Gm-Message-State: AOJu0YyGmFETtBpQZwGu7WekgRd81gKJmCbRLsx9g9xK5KtmiBXMh+/M
	rOHjHICtyi17xzRXXFuM9bQJjJ9VNRSMb7J+EXXYmrTR3gZcRvyDCJNUF4n7Xq72xXt+Gux6B87
	RkPHeTK9bLKZKZxUsnYzFiqC5XzrmSGJSgZrkb0FimTqQRT0RkSJjAqXHBfe+07j0V5qXUCu2eJ
	hbZJzY9FAviTI4NjTr84aap2REqUS4TK7rRQ==
X-Gm-Gg: Acq92OGicwqfz2J6Dsgdgl+gE3/WdebIBbh/L3YKdbiIsBJCtJgrku6Y9a/GKBehqqY
	RnsEZpmF6+mIzBGDDj34Ifcv50KoGoh/K9PYRU5RYwp1Asc+2ZkTA/pLbVBJVix/gZ3IaeYYMIz
	5FH3If52+MOvfq4duKMXJQvMowTh1oLiFnxk99+3Dy+1hSkJ4fs/kgnnHpZz571RkvJwy0SrZyS
	LRrxw==
X-Received: by 2002:a05:690c:c513:b0:7b4:f43f:1a23 with SMTP id 00721157ae682-7c95d1d5de1mr201683127b3.34.1779182241787;
        Tue, 19 May 2026 02:17:21 -0700 (PDT)
X-Received: by 2002:a05:690c:c513:b0:7b4:f43f:1a23 with SMTP id
 00721157ae682-7c95d1d5de1mr201682637b3.34.1779182241263; Tue, 19 May 2026
 02:17:21 -0700 (PDT)
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
 <CABdmKX3DhejYBis9htLDnzPrG7vuF3R3URLVNEbnyd61SSsx=g@mail.gmail.com>
 <CAGsJ_4zyecY6E-=Tm4_couT7uoM9LMcFdTMUPkZAjj4zUKE-dQ@mail.gmail.com>
 <cb84c2ee-9de1-4565-b2e0-60984721228f@amd.com> <CADSE00Lc42s2bzXzV5D7t1Enf56u4BVj-yXLp3Yxhm0=qMPvuw@mail.gmail.com>
 <9cc79977-9a42-40eb-bfa7-460881c1e10f@amd.com>
In-Reply-To: <9cc79977-9a42-40eb-bfa7-460881c1e10f@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 19 May 2026 11:17:09 +0200
X-Gm-Features: AVHnY4IPueDokk-vXqsRnZz3u8JK7NQGe3IxviX_AiFOJ3NwW-K39W0igYKchDQ
Message-ID: <CADSE00Lxti-MabrZq9KWijRxTHX49NOAV=hMdfLdqKrj-C=Jug@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH RFC 2/5] dma-heap: charge dma-buf
 memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Barry Song <baohua@kernel.org>, "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
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
	linux-media@vger.kernel.org, dri- <devel@lists.freedesktop.org>, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mripard@kernel.org, echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16071-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AD42F57B736
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 9:53=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/18/26 14:06, Albert Esteve wrote:
> >>>>> udmabufs are already
> >>>>> memcg-charged, so adding a separate MEMCG_DMABUF would double count=
.
> >>>>> Are there any other exporters you had in mind that would benefit fr=
om
> >>>>> this approach?
> >>
> >> Well apart from DMA-buf memfd_create() is one of the things which as b=
roken our neck in the past a couple of times.
> >>
> >> But thinking more about it what if instead of making this DMA-buf heap=
s specific what if we have a general cgroups function which allows to chang=
e accounting of a buffer referenced by a file descriptor to a different pro=
cess?
> >>
> >> That would cover not only the DMA-buf heaps use case, but also all oth=
er DMA-buf with dmem and whatever we come up in the future as well.
> >
> > I removed a draft adding an ioctl for charge transfer from the series
> > before sending because I wanted to focus on the charge_pid_fd approach
> > and keep things simple, deferring the recharge path to a follow-up
> > depending on feedback.
> >
> > The main difference between my removed draft and what you're
> > describing, iiuc, is scope and layer: my draft was an explicit ioctl
> > on the dma-buf fd that the consumer calls to claim the charge (see
> > below), while you seem to be suggesting a more general kernel-internal
> > function that could work across buffer types and cgroup controllers,
> > so not necessarily userspace-initiated? A kernel-internal function
> > will need a way to identify the target process, which sounds similar
> > to the binder-backed approach from TJ [1]. For everything else, the
> > receiver still needs to declare itself, which the ioctl accomplishes.
> >
> > ```
> > # When an app imports a daemon-allocated buffer, it can transfer the
> > charge to itself:
> > int buf_fd =3D receive_dmabuf_from_daemon();
> > ioctl(buf_fd, DMA_BUF_IOCTL_XFER_CHARGE); /* charge now attributed to
> > apps's cgroup */
>
> Well that thinking goes into the right direction, but the requirements ar=
e still not completely covered as far as I can see.
>
> Let me explain below a bit more.
>
> >
> > [1] https://lore.kernel.org/cgroups/20230109213809.418135-1-tjmercier@g=
oogle.com/
> >
> >>
> >> The only drawback I can see is that DMA-buf heap allocations would be =
temporarily accounted to the memory allocation daemon, but I don't think th=
at this would be a problem.
> >
> > The main reasons we moved away from TJ's transfer-based approach
> > toward `charge_pid_fd` are: avoid the transient charge window on the
> > daemon's cgroup; and to decouple from Binder, allowing any allocator
> > to use it.
>
> Yeah those concerns are completely correct.
>
> The application should not volunteering says 'Charge that buffer to me.',=
 but rather that the daemon says force charge that buffer to this applicati=
on and tell me when the application is over its limit.
>
> >
> > Technically, both approaches could coexist, though. Of the three
> > scenarios TJ described:
> > - Scenario 2 is directly addressed by charge_pid_fd approach without
> > any transient charge on the daemon at the cost of one extra field in
> > the heap ioctl uAPI struct.
>
> Yeah extending the uAPI to pass in the pid on allocation time is not much=
 of a problem, but you also need to modify the whole stack above it and tha=
t is a bit more trickier.
>
> > - Scenario 3 can be handled by the charge transfer function without
> > changes to SurfaceFlinger. The app or dequeueBuffer claims the charge
> > for itself or the app, respectively (depending on whether we include a
> > pid_fd field in the transfer ioctl). It also covers non-heap
> > exporters. The con in both variants is the transient charge window on
> > the daemon.
>
> It should be trivial for the deamon to charge the buffer to an applicatio=
n before handing it out.

Yeah, true.

>
> > Both approaches shift the responsibility for correct charging
> > attribution to userspace: first, 'charge_pid_fd` on the allocator's
> > side, and the transfer charge on the consumer's side.
>
> Yeah that's why I said it would be better if we do that without any uAPI =
change, but with all the uAPI we have to transfer file descriptors (dup(), =
fork(), passing FDs over sockets etc...) it could be really tricky to imple=
ment that.
>
> > Deciding on one, the other or both depends on how much we value
> > avoiding transient attribution, and how much we need a non-heap
> > generic solution. With the XFER_CHARGE we can cover both. Thus, the
> > `charge_pid_fd` approach in this RFC can be seen as a
> > performance/strictness optimisation, eliminating transient charges to
> > the daemon at the cost of a permanent uAPI addition to the heap ioctl
> > struct, but not strictly required for correctness.
>
> Well all we need is a uAPI which says charge this buffer (file descriptor=
) to that cgroup (pidfd).

So you favor having only the XFER_CHARGE variant. That is fine with me.
If that is fine for others also that could be the way forward. If we
extend it to accept either a pidfd or a cgroup fd (as commented
previously), we can cover all dma-buf use cases with a single
primitive:
```
ioctl(buf_fd, DMA_BUF_IOCTL_XFER_CHARGE, charge_fd);
```
With the daemon invoking this ioctl before handing out the buf_fd.

This should cover most usecases? Except for the memfd case, which
requires a separate mechanism. That would be follow-up work.

>
> With this at hand we should be able to handle all use cases at the same t=
ime.
>
> > On the other hand,
> > if we agree on the end goal of migrating other exporters to use
> > dma-buf heaps
>
> That won't work. DMA-buf heaps is actually only a rather small and Anroid=
 specific use case.
>
> We have tons of other interfaces to allocate DMA-bufs which need to stay =
around because of HW restrictions and we do need a solution for them as wel=
l.
>
> Regards,
> Christian.
>
> >, and scenario 3 is addressed by adding the app's pid_fd
> > to SurfaceFlinger, then `charge_pid_fd` alone is a coherent/sufficient
> > approach despite the uAPI change.
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Thanks
> >>> Barry
> >>
> >
>


