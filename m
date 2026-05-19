Return-Path: <cgroups+bounces-16072-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFVRESY3DGq2aAUAu9opvQ
	(envelope-from <cgroups+bounces-16072-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 12:10:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B00C57BEE9
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 12:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F0FE30678BE
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC2480DE1;
	Tue, 19 May 2026 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtLgIlST";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPqn1IrL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C7847F2E0
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183803; cv=pass; b=EObHf7MV4CUo4/B6bXHW50SNOpe7oyV96Lt9GHeoR90MukQwmhtOVWSQKYfrf8kAXPT4OBh5PF4jphduMjemQgnjL3YXMWiybKqBQM/W0GZruppY/6MaYKoZ/q8c0fSQeKe9Iyy9O8tSMCooaH65AQS6SnqswP5/7e7yxCDrrZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183803; c=relaxed/simple;
	bh=vupX0NJyQoj+YpsPS+mWEYXWTs2EEV9LxivCpOIjPNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVklvzctvpbjkBABDvqiVB6KWpDfpM6ADVrtThwExA79CjhIUeXHTV2MnQt27V8DdVurgOH5UhshwEaEhc7JazQCPcHJUgtElrMSyYs39xD80I127KMYEch+BxlOTcVAOiqkdXcQTSJi/uv7dS/18MfIVrs9326wPNErgeKPXrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtLgIlST; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPqn1IrL; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779183801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5x571feKyCrxAyf039bp6xhn3Td73dplWB4PHAo5Mng=;
	b=TtLgIlSTk0kRO9ZPvkrLDs9bgs97tSEGLHjqELywBE1r1nxKee7tyjOPXl+NA1uniPtiD2
	4n4OEGVnU3vAUFTvOKNO/5yAU3aUkfLHlQsMYidVeWmo7s8vS+gNudIRuY14GHNXKGmwL3
	NXmtRi3LU5+Fy0wTn6VTMlQMNF1t7Pg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-DI0luvUEPhSI-r4RVNHVXw-1; Tue, 19 May 2026 05:43:20 -0400
X-MC-Unique: DI0luvUEPhSI-r4RVNHVXw-1
X-Mimecast-MFC-AGG-ID: DI0luvUEPhSI-r4RVNHVXw_1779183800
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7bd66ec877aso56654127b3.1
        for <cgroups@vger.kernel.org>; Tue, 19 May 2026 02:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779183799; cv=none;
        d=google.com; s=arc-20240605;
        b=ityLmabA+Rq8fVCMUDjeHzE7yha+H9nlnEN3ZThtbcWEyk1b3lviLsQMBxbNPTWjIu
         pGl3o/CtFuWCt+wLBL7YMSOXkp2AfVqvYi8J7IqETNPqqqkaYG6UsbqVCDZ60fd0wtF4
         Vj+Nh6OBK/LyExwJiFVglH1n9qf2UAcrvEJjM0cnyxuEtdVDRDvh05nJmsXAYAR0G/0y
         CxbvTcu5Frh6yLIyxZ9313ro1f+iSGOinyJbsFI2wBjmWKuBZi4GaENrR2X+pBSjlgAe
         U5Z/LXS9D+m3ec7vGRNBFwhV6QXVc0XYtSAdlnXrMQmGbZkjzCPUqI7fvwq9yufwYcro
         pIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5x571feKyCrxAyf039bp6xhn3Td73dplWB4PHAo5Mng=;
        fh=tgNcchO9Ecgzr0sdxZrCpZ8xobUeiJKHYDJlkaQsU5A=;
        b=IdvFdJ44qsq0TkmMjMsXs9J9OqhSi9j1V3+kttJqjA1GjJ+MKgUUwiTQT6p5yYKzor
         dV716uVQXnnULxNfFKsEJqnyZRqvuxB2gGPTZU1eBuJm63lTTDZ2bMzpfukr0hHpaubv
         XMX6JfRF6yLWb6vmwyiMFzDEp2D18W2nsZmOmP9B8Q6oTH3/3jx859zeWHqtkLkn7O8Q
         uRs45lDCnOWNoxymNt15jCH/Oc8ScILMljt1lvJVkr2oAdvzGB+h8dgRAYGWLZR1j0U4
         3jHOLZ33Cim/Q7eiInPvGRti2AkgLrIHV+AybhgZ5JJ5vgJa1sGx+qqrcdfgv2DUcC/r
         YmCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779183799; x=1779788599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5x571feKyCrxAyf039bp6xhn3Td73dplWB4PHAo5Mng=;
        b=KPqn1IrLOVpiT+kXRx1cIJ/wy0pmC8vIciCxnXaSVniK793kZf9uSDYqJSuTyq4+Vo
         OCOcJDVLp9dLU1aOfW91FAWCNMT4qHX+zhTVBluntj/iGMA7ZVyt9Z5fi7Lew+tUu7ku
         9j6ITpTCdxLhUI99sWiydZmA0jsbdc6nZcTgUez2egzACU3Ib79/E7ng+XiuDOQ+Fe/W
         TopIi2ZMUKYOzpb6fJELqgfefKHR38gF6UMySaCkix6C9FWBChjVsNwmkS6osJsq+HoC
         XIrxaQ4ELApiNy7TGCCBCrh51OJengTn6qb+ftJxbLkB0t8K3VNXyeY1TGxwkf0Z/eYF
         II2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183799; x=1779788599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5x571feKyCrxAyf039bp6xhn3Td73dplWB4PHAo5Mng=;
        b=aTuYI1I4pNPr1QERoIvHk2ZCXMrPQkpJwEeJLl07GUH8WeQ6Cxh+5MrOgdoKFxg8fw
         fTK7vOWla433MosXaJngynRW2NNXCZ71NKFNynLuFvfIDWHOX1gsaNNkYV639NRYwx3+
         VWXV6COJ+zYvZH67dGdiGePvJ5lxmY6V9POUApNQ97O3czO6lwitkps03Dj7m44rJasF
         6X4Il/N/ZMloK/iJrv0Mxm2L1lRlBfwMTRc8dT+iPlvBp2gQuHqWKngObByDp32pglS9
         MADIuzK8/j4uW2561Cpf9tsjYjmqjun1saQ/omVDGTuqvl4ncnYeEuXpsJX5KC+FfPJR
         U7rA==
X-Forwarded-Encrypted: i=1; AFNElJ+mtyL6J7Kp55Fv44voanG5VTMGjKPYoRqt91mGY2bcbj+iRJYThRjkMnfxM7bznZx28w4KyBV0@vger.kernel.org
X-Gm-Message-State: AOJu0YywoYapZQAbL1LeArchSb2LdN0TfFlkUe3DpbE/k8G3Uiem8IqU
	ygMd/rDMFPzas1Tcey4akNPO7ZJumQxqGx9Hcy8U+m/b/XOPMYqYnHzLK2GmIdYYpxmGHLW36ii
	XFTY9ZmAufpVnb0okYwpwQfUgqziSM3UbmJSPxJ9pbXFBRJBPJL7dWh9fFRhrzS6mMUTaF6WFrA
	OSVdJpOuAGJKI9/DsWg5bfyWtElyZ1yG5/8Q==
X-Gm-Gg: Acq92OGHfoZLL5rgl25IpUpHn/Yfo5Iz/qHJkQjbgWq7ipnoc5zhPANxMFy1UOjuqFa
	+uQmeoOcLHtCSHsCdsXW1X3ls2ISYO77VbcggTFPLTy7i3MgyDzbwQpfnu8kR01+9+NhHyAlmw7
	KmwPQcbMQja+NebMur6HdOhXx1xQK9XTJHr0JQ5u4MkKZgBB9wmt8eF/b5xcUkScr11eL4jZqoa
	YciGQ==
X-Received: by 2002:a05:690c:6e81:b0:7bd:a63d:fe69 with SMTP id 00721157ae682-7c7e6586abemr212584777b3.9.1779183799602;
        Tue, 19 May 2026 02:43:19 -0700 (PDT)
X-Received: by 2002:a05:690c:6e81:b0:7bd:a63d:fe69 with SMTP id
 00721157ae682-7c7e6586abemr212584217b3.9.1779183799106; Tue, 19 May 2026
 02:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
 <CADSE00LjJcL8P5M-UPEpzZijU70uEmUirnin29N8YR5W5D-oFg@mail.gmail.com> <CAGsJ_4xwJ7SAhKPJyRtMTw6psTO7H1EcFFpDw0po1W8PX4FE8g@mail.gmail.com>
In-Reply-To: <CAGsJ_4xwJ7SAhKPJyRtMTw6psTO7H1EcFFpDw0po1W8PX4FE8g@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 19 May 2026 11:43:06 +0200
X-Gm-Features: AVHnY4K6WRueJTIRx5g-aAlFuFoKaIp0iRf0U18smAauuYj52IGoBPbNpAKamXc
Message-ID: <CADSE00L00D7yi_DevNsZ8_=VXBVD2eO5FbcM+sv1ZdwgjaiRmg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16072-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6B00C57BEE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 12:43=E2=80=AFAM Barry Song <baohua@kernel.org> wro=
te:
>
> On Mon, May 18, 2026 at 8:16=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
> >
> > On Sat, May 16, 2026 at 9:37=E2=80=AFAM Barry Song <baohua@kernel.org> =
wrote:
> > >
> > > On Tue, May 12, 2026 at 5:18=E2=80=AFPM Albert Esteve <aesteve@redhat=
.com> wrote:
> > > >
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
> > > [...]
> > >
> > > > -               if (mem_accounting)
> > > > -                       flags |=3D __GFP_ACCOUNT;
> > >
> > > Hi Albert,
> > >
> > > would it be better to move this and its description to patch 1? It
> > > looks like patch 1 already introduces the double accounting changes,
> > > and patch 2 is mainly just supporting remote charging.
> >
> > Hi Barry,
> >
> > Thanks for looking into this series! Yes, in my head I was trying to
> > keep patch 1, which was taken from a previous, different series, and
> > then diverge from it starting with patch 2. This would clarify the
> > difference between the two. But I can see it just added some confusion
> > (for example, patch 1 charges on dma_buf_export() and then it is moved
> > to dma_heap_buffer_alloc() in patch 2). I will reorganize it better
> > for the next version, including your suggestion.
>
> Yep, I understand the situation now. I also understand
> that you were referring to T.J.'s patch, which caused
> some back-and-forth confusion for readers when reading
> patches 1 and 2.
>
> >
> > >
> > > Also, mem_accounting is only used by system_heap.c; has this patchset
> > > also eliminated its need?
> >
> > No, mem_accounting is still handled in this patch for the general case
> > where no `charge_pid_fd` is used. See dma_heap_buffer_alloc() code:
> >
> > +       if (memcg)
> > +               css_get(&memcg->css);
> > +       else if (mem_accounting)
> > +               memcg =3D get_mem_cgroup_from_mm(current->mm);
>
> I see. What feels a bit odd to me is that mem_accounting
> could either be dropped (with unconditional charging), or
> it should cover both remote and local charge cases.

Good point. If I understand correctly, looking at patch [1] that
introduced the flag, the shared buffer caveats mentioned there are not
yet covered by this approach, so the flag should stay. I will make it
consistent and cover both remote and local charge cases.

[1] https://lore.kernel.org/all/20260116-dmabuf-heap-system-memcg-v3-1-ecc6=
b62cc446@redhat.com/

>
> I don=E2=80=99t have a strong opinion here=E2=80=94it just feels a bit
> strange, since its description is quite generic for memcg:
>
> "Enable cgroup-based memory accounting for dma-buf heap
> allocations (default=3Dfalse)."
>
> Best Regards
> Barry
>


