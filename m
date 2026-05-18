Return-Path: <cgroups+bounces-16058-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEMsJtejC2ooKQUAu9opvQ
	(envelope-from <cgroups+bounces-16058-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 01:42:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 239AF57515F
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 01:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA10E3076BA9
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 23:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CB43396F4;
	Mon, 18 May 2026 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHSbLGwp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5003382F0
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147572; cv=pass; b=jHA+gWXKs28fBT86kNnOcg681WtiEQ7C/bxrp7amw4iE7TcTzFSkknquOM6LrspKUBTY3Rb+zeQt2hVyxwSLgMDzGErBSBJB9E+ddm6VA2UXvaxns36Ldn93f9Pmxch+zU2S/CO6yvBBuKln/M40+bjN0u/aJb+iAJDCLE0hl+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147572; c=relaxed/simple;
	bh=MVyBd8P8ZHPDO43tWlBSuB0zkMXQCxdJ+/go03Ht3bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRvT457OsUbu8ZYzgBgTwGY9VwHL4vZKNMOyy1xnMRO+oEzc9TShpCI/5fP/I8uzpBHis+8xcxhna4nutnVTuptc2JrE7bTbWml4aP6sxQorpaXIJuFTCmfqmLseEhamn6ClK//AoYokBRz/xVlWXbmvEkV29WE+eZn8Kxvbtmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WHSbLGwp; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d1c670255so665e9.0
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 16:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779147569; cv=none;
        d=google.com; s=arc-20240605;
        b=T+zPOqVYAUtlbyOcg1K5JDiVxwPQHnz8YGnir2szAnV6xCnuQngu719aPDe8Iyas91
         26wRnZCsvYukazd3bCduKVAs/VcATKEbB8rbBoYj+QfzG5ANMQVG0SoxJaiHevdPsjt1
         rDusQx+DYxH/MTzwEd2UnggCBEhai1AUz4664sFjlaoncSHPCJgIy+o7Cda+wBhJwL5B
         2n0SKHhox3iCixO8sLJQRZTAaLT1qrdtk1SgUTgt8dZtpdjCOGXgV0M8TCkyQMvLU3Zp
         bi7WBz0r5sLNJkYsmxZp0rWMyLMGiIYplxAWpO27M3Xlqr3zKxTirbqTOGfEy4FZxIK4
         aG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=itOYKoJgfjMZD3HtReaYbMSuntrxVom1KXxY5d6gQNg=;
        fh=wwuL0yjnz9d0CPW88dh1jQIFkY8ehXf07GgO96pGqn0=;
        b=U2EhH0q6z/lnURPda+szwsQ1LlodOpcF2qpV44kSF7E8Xm7F6D6NMYsGwz5aWqiwr/
         7F7T9+jGIHf8Xmcl7FoGV0XO1h5lsmULr+16Q8rfeA7OPvO1eKpslTOsNTT3k5ZTRRni
         GIagYYryXN27ryd9TKqqpShj41mn8IM7t+0iq6T7Qsbj1bS7F4lUkmTxOZ1/7rvRK2zi
         ecURBcqsuG+6LO7jC1TSWSwlLtHYSywEH4SsE6P7zkmqvJka0FaV1gtRCrDTaE2h8nmA
         P97dCxkrmk0nzk6xqvudfIu2X9ltuZZIGVeL5803sQhkpVaRrDY0oixKlIVgZ3eEY4XC
         tKww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779147569; x=1779752369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itOYKoJgfjMZD3HtReaYbMSuntrxVom1KXxY5d6gQNg=;
        b=WHSbLGwp9dzHm/Ck5v7yRf5STkpaQFc89CC3BbVSTDlpg14DuO4gO+VVBVOPT5M14h
         KfqufuMH5sVR/bEsVqq6bJ/gUyg+om+Jqv6ikla3l+2RLeFwKCXZ1EJocfxdaXYkNi3I
         6u3OwoSXpMmpQ4ny+ZIRYuq37zpcWUZ2i7uhxq3znLQsukNatjHZgVbjrH8CsnxTah9O
         kFDsCLjtiqeeCX9KzZIrpsVPVTOCcou2lWUDo6i+lnpZxpAofY7TA9U6mJx1TBxSoqck
         P+wHE7LPCr96YN3EQCd4PyXP1lTWx/uxIyX1xZ9du1HCQsLrvscFYe5vUnvAbnbWAGVX
         xNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779147569; x=1779752369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=itOYKoJgfjMZD3HtReaYbMSuntrxVom1KXxY5d6gQNg=;
        b=moeU9E56KtFc5a7rM+3YGROVgWND4jnUcsbBHeVfVBy/xbHLG9FQgMOEeMWybmwWgl
         gFFmwxwMcqd9qtDV0niK9G1/NCJqLx8sRLLxch89hgV3lrFhgk4Ie+uEVy2ce4UGjmrA
         Qlirm7LxVN9o8H4xAnq/cZmm/vINvVd78hQDsKaaez9+Bn3sQirHF5n6teg0lc0QIEoE
         fBFzVDCcfuF+SdUMM05BLTR0JfXC3OnFSQnMZ6cOm0q8ynbhPCbwaWQK1/W7dPWp9jz0
         NgVZAPMf2rO2clhhvPdfhWddZopraAVYAxn+F8FFJoOWkSkCtOsQVhYT4b7iYi6ddNpd
         FhJg==
X-Forwarded-Encrypted: i=1; AFNElJ/Q383qcFZX39GScNsVmxIlCqlerymoXVOzsPRtLG/WR+NH1fZ9SEtdsvfawxWT3kn1/R0PZTRG@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ0yNmjZ1K2i4A77HxgXeEvNsHk/ofkYqD9aMYEiof+e7II1TT
	k0VpieHh6cxSACxc+neL8CYrlUWtMdNonZNkGGTrYKndqm4TQx+cgZBaXhLsWqu8lwqaR9djVeD
	D0moxjyofXbpYT9JD7AW9xjdEUzmGCnvyxGJ6+0Fm
X-Gm-Gg: Acq92OGfHpSWRMSUMo1maVJ4Nm92jep8pKNEOvI1sSaTcG4NMV1vyWaswYA1lmD2fkB
	uL4FW4S1XyzNn0cQUOUBA+xBxz8cGh1B275WMid4TdjolusrXs5jvRufXLehdcmNC4nEHhM64Hr
	4StaPgQcRyHOXK2OhW/+8HAzqR956m6yev7gq1xjq+lJ/FIW8YG0O8/Wok4h6gAphZxnbgJ9ena
	hItHSbUHE6bHhz1XN4Sl4GkSj9JbHH6l1FJ7TrdZVe0XH6tQjt0jKg9vG+o9w20uKsJRhDhpwl6
	p1zYVhBuYQdwGNUJuYHYkEAwGn6mhO9SjPVocyKISpeI6O1P
X-Received: by 2002:a05:600c:828f:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-48ffa06d607mr3320695e9.0.1779147569161; Mon, 18 May 2026
 16:39:29 -0700 (PDT)
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
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 16:39:14 -0700
X-Gm-Features: AVHnY4JenMsTlW8PdrNyXvGhnvZE3E4HsfXXDBDrw2kB1e9N8h1WWqyjOLM9WZU
Message-ID: <CABdmKX2+PqZJc588dL7Yp7hYDnfXw7LRCKfLJ6n5=faKBvWBWg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
Cc: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16058-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 239AF57515F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 3:43=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
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

Albert, please don't feel obligated to keep my patch intact if
integrating it into other patches simplifies the series.

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
>
> I don=E2=80=99t have a strong opinion here=E2=80=94it just feels a bit
> strange, since its description is quite generic for memcg:
>
> "Enable cgroup-based memory accounting for dma-buf heap
> allocations (default=3Dfalse)."
>
> Best Regards
> Barry

