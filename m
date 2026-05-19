Return-Path: <cgroups+bounces-16096-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJeiENimDGrskQUAu9opvQ
	(envelope-from <cgroups+bounces-16096-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 20:07:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A1E5836B8
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 20:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6083D301572D
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4827328243;
	Tue, 19 May 2026 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyNnfYft"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416E324B33
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214030; cv=pass; b=PIC+fMxsAzb9AMsRs4h9GZp4uE50/0APycQwFdGNpwjXB4Fj798h+RePVFZqWYBxb9M7ZlTiIaPU2mW9nAb9pLXkXcx7tUqmuriUh3nWYxbip2CX5AAtlhf0tIsXwWbwmRpGWZwDkcqzP5/zEEp58yselLCAs04vB+/w6Eh32gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214030; c=relaxed/simple;
	bh=xWuRtr4K/5gUdgYtvuhsDbR4Td/jrXMBs73+p4Eyg4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kd/w98KmiCDPslH+MiPGbworInHewCnfS4DUB6LihZ9yJ6smZKHSunjMFsRwxCsjRxHTVfe3DmYG1vwlvdDdLdnS0/8gxKSuyQMGJedYhv4dlNh/fy3IKq3K+0vpLgQooOFzCrMIB8kYLPW1xDfk4iZsmAjY9+LApu6HXWr8nP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VyNnfYft; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48d1c670255so435e9.0
        for <cgroups@vger.kernel.org>; Tue, 19 May 2026 11:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779214027; cv=none;
        d=google.com; s=arc-20240605;
        b=QWhzbEvhdqkDeODlF6PTZs6wPOTOWx5gU9YS3c3PewGG/iUy2JWmfF+F7c575+O6QZ
         BXd9gwILYMqODCszREfIDMaJNw7I36bYvQN7H1bzWJwpabkAtSdoddgZatUTBi6eCl/V
         NsbiFX3YZXbmZKGvVRPmqsD2s7whW3OP114bz063DOkjpB2A4X3EIJzoX5JBJ9wOlZdo
         Ii0bbr9O6kgN6lgIFASncejCqgBG3IjEuGIsSlpXpncNURESKWPdwH/AOOgi0thSPnLc
         IYJMvHYSyjLSHn7rM/Xoe97K6AxPJXQkU9hFVqUBEdptpFjfFaLSgxxrxhAtEfz8ohfY
         9ySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWuRtr4K/5gUdgYtvuhsDbR4Td/jrXMBs73+p4Eyg4o=;
        fh=fz1hWDhW+nbK/bjFINuvBRO5NbRfzySPFpFBhbbO+7w=;
        b=P7qqJGJ9bf8TS1nVIYV8BLMFyiZaNr6QhY4i8NtGyLQnnpWApA4XswulzWXxJlAQQR
         aAEJ3JoiJGmlvzBE8Vbg+3A6a821gnJc19/in/rS7o7hyB18OfPqk1DYl7OtcS9yTE82
         CXb/kyuAVhApeKltNzY05MYY0vTOLqXI8bI57Lz19MEKgnOiIsUaRCqbAGtMfq6dvaTB
         u8Kw6sdMWZ2TFfYogrKropve3fhSqDF9i+hPu1Ne3u9JscdZEjK/VcjcPSZtwMW2oFjY
         CVyYlI7aCM5v8RNP14k29f6Yge3ZB7GvZ6aJGeN2fBmwuRo0LozkiNc9SkvAVei0wMvh
         uXWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779214027; x=1779818827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWuRtr4K/5gUdgYtvuhsDbR4Td/jrXMBs73+p4Eyg4o=;
        b=VyNnfYftN5Zm7O1g2zyDlanIBedjkc47HlTLcNZ8DlZPYbkSWMxSMsRf/CSz/2X/qd
         tkFfv1f0AYulKDrFrLqicAKcw20yqGpc2OkOBAEpUtwyIzNd1kxo64awQjdv3IrxYX1t
         Oh+W9sZAKcEkARL23u68EYToymkAIudI8ZmkttSx9pxJS/AqQ1pWHFuufcC7lDArQGOi
         0NRrUBPaWOWepg197ofEZXkMKb85xn4S3yqEm78eNuhF88mLGEM2VqYLO4A2nCiyhX+7
         0r8nJ5g0e60NJsAhHU7/NimQjv7wvNc6d/BhMwDku/SKQrdBipRznT+XwjDJFvO2rL8f
         GU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214027; x=1779818827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWuRtr4K/5gUdgYtvuhsDbR4Td/jrXMBs73+p4Eyg4o=;
        b=r3746PQ+EmK9+CRTiSl8BNsGAnEEm2xmvx9BFDBOR4XNnHtFx/1qwPEVTQjDoPzMMy
         FIQEcuFsESsmJDFFbxYuYyK9rloJQP0VBkFeD6JsMHJZuFCo7E7ZsiMuOzT3ufKFjAgq
         L+Jq6j9Qyj8B4FDn4Fs5XNrF5M+CqYDOxWcry0/F4B8LhYjHoit3LaYx1TAujDHAD1HI
         VZ33tsOqzIypJ8sHSuD5IvOGpvjcIh20HdXK1AxWz08JJ+Hv+4bkAcADwmhppBvHH6ST
         VCltpk51h2XywBkZoVCpq9ru+LqJIE/wI2BZDicieDebH4Ws3ChAdwD+ZIdBD20ywBAN
         0xQA==
X-Forwarded-Encrypted: i=1; AFNElJ+T77LEdAuve00BytMjuvhpc3EXhXsdVG5VMtXzz7Andyv0uGHVxt1vCfZezoaI8gp2SIBJgIWF@vger.kernel.org
X-Gm-Message-State: AOJu0YxeDijbDa/9yV7+WFbloDSgxDjuLFKTgDX9VfhHRyRArM4xz/4P
	i/25xXw+M8S6lOD4Pl9dNU20TWx8wwuSTtXcyI8e9BQJfIBYUzoFywoKsNwF8AWzVAUjLwEeIWV
	vd0bCWp5YBphzTvePgj8oQn4XE6voINurSPqUmM+i
X-Gm-Gg: Acq92OFYKmMCSxA3N3KtNvddhnRxXuYHUyLkkA50xIyr7plV4ktVAQp2H0Vikt9hDrM
	d8sPcI9mk7/sCOk13TOniGiG+4evJT6zg5lsm3N4bpBrsnJzSCQwVApfMzw8+T8NaSFEhwg+1GS
	ozRCHnAyp6XA1rkJFWgk+q+PHxSRwYQovxnOQzP735ANDf6WhtoMpc8jMtfdNEGo54DitSY2Ued
	uMcLbfdFfIuc1lh4sxQS2kNA/w42WvWGULrBrxSpcTpHumfF0BzEBzjt9+2nIBB2qvSc0oucv/N
	HEgQ7pWncvzcXe3pkvsjYZ01GtPF4ncknZCACNMg3D677bpZziuhYw7GjjI=
X-Received: by 2002:a05:600c:828f:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-48ffa06d607mr4555145e9.0.1779214026686; Tue, 19 May 2026
 11:07:06 -0700 (PDT)
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
 <cb84c2ee-9de1-4565-b2e0-60984721228f@amd.com> <CAGsJ_4z121v4tK_3+j-hkD7HH0gH3w8tWD8nk0CwRhFE5T+4Og@mail.gmail.com>
 <8a13b1ad-f1be-4ef4-905e-0d9828ae8cb5@amd.com>
In-Reply-To: <8a13b1ad-f1be-4ef4-905e-0d9828ae8cb5@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 19 May 2026 11:06:53 -0700
X-Gm-Features: AVHnY4ILqt3aAhuKzQVtfjO_TWAUc-lBkfBsfy8pZGOgOTZtrN6Xce9TENH_RxE
Message-ID: <CABdmKX1o5FeR697DGdExhSDAzdLBN=y4ijpA2SZyisC6ThYKbQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH RFC 2/5] dma-heap: charge dma-buf
 memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Barry Song <baohua@kernel.org>, Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, 
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
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16096-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Queue-Id: D3A1E5836B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 12:10=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/19/26 01:00, Barry Song wrote:
> > On Mon, May 18, 2026 at 3:34=E2=80=AFPM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/16/26 11:19, Barry Song wrote:
> >>> On Thu, May 14, 2026 at 12:35=E2=80=AFAM T.J. Mercier <tjmercier@goog=
le.com> wrote:
> >>> [...]
> >>>>>> I have a question about this part. Albert I guess you are interest=
ed
> >>>>>> only in accounting dmabuf-heap allocations, or do you expect to ad=
d
> >>>>>> __GFP_ACCOUNT or mem_cgroup_charge_dmabuf calls to other
> >>>>>> non-dmabuf-heap exporters?
> >>>>>
> >>>>> We're scoping this to dma-buf heaps for now. CMA heaps and the dmem
> >>>>> controller are on the radar for follow-up/parallel work (there will=
 be
> >>>>> dragons and will surely need discussion). For DRM and V4L2 the
> >>>>> long-term intent is migration to heaps, which would make direct
> >>>>> accounting on those paths unnecessary.
> >>>>
> >>>> Ah I see. GEM buffers exported to dmabufs are what I had in mind. I
> >>>> guess this would only leave the odd non-DRM driver with the need to
> >>>> add their own accounting calls, which I don't expect would be a big
> >>>> problem.
> >>>>
> >>>
> >>> sounds like we still have a long way to go to correctly account for
> >>> various v4l2, drm, GEM, CMA, etc. In patch 1, the charging is done in
> >>> dma_buf_export(), so I guess it covers all dma-buf types except
> >>> dma_heap, but the problem is that it has no remote charging support a=
t
> >>> all?
> >>
> >> No, just the other way around
> >>
> >> DMA-buf heaps can be handled here because we know that it is pure syst=
em memory and nothing special so memcg always applies.
> >>
> >> dma_buf_export() on the other hand handles tons of different use cases=
, ranging from buffer accounted to dmem, over special resources which aren'=
t even memory all the way to buffers which can migrate from dmem to memcg a=
nd back during their lifetime.
> >>
> >
> > Hi Christian,
> >
> > Thanks very much for your explanation. So basically it seems that
> > dma_buf_export() is not the proper place to charge, since it may end up
> > mixing in non-system-memory accounting?
>
> Yes, exactly that.
>
> > My question is also about the global view for both heap and non-heap ca=
ses.
> > After reading the discussion, I=E2=80=99ve tried to summarize it=E2=80=
=94please let me know
> > if my understanding is correct.
> >
> > for dma_heap, we have the ioctl DMA_HEAP_IOCTL_ALLOC, where users can p=
ass a
> > remote pidfd or similar information to indicate where the dma-buf shoul=
d be
> > charged, as in Albert's patchset.
>
> Well that's the current proposal, but I think we need to come up with som=
ething more general.
>
> > For non-dma_heap dma-bufs, we don=E2=80=99t have an obvious userspace e=
ntry point that
> > triggers the allocation. So we likely need other approaches. We could e=
ither
> > move more drivers over to dma-heap, or introduce something like
> > DMA_BUF_IOCTL_XFER_CHARGE, as you are discussing, to let userspace expl=
icitly
> > declare a charge.
>
> Yeah but that's not only for DMA-buf, we need that for file descriptors r=
eturned by memfd_create() as well.

memfds get charged on fault, so an allocator shouldn't currently be
charged just for creating the fd. Unlike system/CMA heap buffers, the
shmem backing a memfd / udmabuf is LRU memory, and swapping the memcg
owner of those pages is a more-involved process which is not supported
by memcg v2. There used to be some support in memcg v1, but it was
removed. Commit e548ad4a7cbf ("mm: memcg: move charge migration code
to memcontrol-v1.c ") said, "It's a fairly large and complicated code
which created a number of problems in the past." So I'm not sure how
much appetite there would be to support it in v2 for this.

