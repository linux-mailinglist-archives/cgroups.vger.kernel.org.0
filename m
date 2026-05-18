Return-Path: <cgroups+bounces-16053-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBQRNlGWC2rXJgUAu9opvQ
	(envelope-from <cgroups+bounces-16053-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 00:44:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9208D574C03
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 00:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5854E30433E2
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 22:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712BF3AF641;
	Mon, 18 May 2026 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnLwwkQM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F03AD50D
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144219; cv=none; b=aZ8z742QCAt2Vh/OAZUlxW2nQrdAJSXwSLT5N/JJJhLxfaJDnB5Qg+S1vk4qdSvgn/JJO6fpmeAmOzHPRyyUxdX8kJvK/EZrKMMhoOHRn/L3RkKiNZQB2DK6sctjWcG6ztUssGglRQPBIo3sim99fXJlDX6qnqY8L51W0mJs0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144219; c=relaxed/simple;
	bh=ZqxlUv6AphBiZDSxvrCBSCRC+/VdjzoWlIzND7rNfMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3mcpdYvzb5rgvf4WSj5VRkFuwOvq6q77OcTA5NIGQLOOeC6cg2d67CFpi/5Wdwf7h+rVav8U2T8jdj8TzF9XKxDQ4/eVEeiqqb6Qr0EPjFuynmgKjFbnOv8yAuK2ORBDSnEXoYSw4qPoZgJn14hcpV3VHXGD1Ium+37ybOzlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnLwwkQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C64C2BCFB
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 22:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779144219;
	bh=ZqxlUv6AphBiZDSxvrCBSCRC+/VdjzoWlIzND7rNfMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jnLwwkQMSrXKmuTYoC8kFb+1DJ/go3KnenQZXQbnnWDMKKe8Jj3Fzm3HyLrQ0zheV
	 fWwkQt3ckMrypK82sqP40r4dWhy/Sug1Az8mk5wtdqdi3B8OH285juzi22vXh0j4B4
	 DUVPFgA0b1KVuKWxy8+/+DaAhru/iD/G3ca5MZBV4Onpr+/jbrySCFfaO++5TDEQvu
	 3ogI98oJYBqD1C8zrDhoJ1leceekpoRlJDlxh07BKnKkng2BxQy7E7S80tlFJqWAgt
	 IM9QYwIjrjB+uI75Gi/whUG4uhXcOaQc7yM0/nstduFPa55V4lKsPsP3u1KqoxhIWm
	 csQ6T9UwG2PSg==
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6314287380bso2059761137.3
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 15:43:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/NOUdCXxVVHylOKaQyCIFsVQJ0sxEgjWD4cPyBTlknWUARoCmc8pxnb+nwtHeANyOcmWG3UOMu@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ0Y2vERLdp1YCDroVDgN129DfcT2jXfuB4i0wWbfuOe8BtoQN
	MhpKXuG/j2kfci8O0DGF777rISlXJu1tIdMx38x3M5x+b/WHFNA3qCnuPOu7i5OKFtfxLMttwxY
	2+dhsOhF9rbIbEY6aJ+NyJGIfWrG2B5I=
X-Received: by 2002:a05:6102:1497:b0:632:eef7:4b7f with SMTP id
 ada2fe7eead31-63a3f38ed3dmr9090434137.22.1779144217888; Mon, 18 May 2026
 15:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com> <CADSE00LjJcL8P5M-UPEpzZijU70uEmUirnin29N8YR5W5D-oFg@mail.gmail.com>
In-Reply-To: <CADSE00LjJcL8P5M-UPEpzZijU70uEmUirnin29N8YR5W5D-oFg@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 19 May 2026 06:43:26 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xwJ7SAhKPJyRtMTw6psTO7H1EcFFpDw0po1W8PX4FE8g@mail.gmail.com>
X-Gm-Features: AVHnY4KEVuNU5LGUxbEGufPnQvVfof22PSDgrj8C9uNhmMZb-wsisqSstH9JT8s
Message-ID: <CAGsJ_4xwJ7SAhKPJyRtMTw6psTO7H1EcFFpDw0po1W8PX4FE8g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Albert Esteve <aesteve@redhat.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16053-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9208D574C03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 8:16=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On Sat, May 16, 2026 at 9:37=E2=80=AFAM Barry Song <baohua@kernel.org> wr=
ote:
> >
> > On Tue, May 12, 2026 at 5:18=E2=80=AFPM Albert Esteve <aesteve@redhat.c=
om> wrote:
> > >
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
> > [...]
> >
> > > -               if (mem_accounting)
> > > -                       flags |=3D __GFP_ACCOUNT;
> >
> > Hi Albert,
> >
> > would it be better to move this and its description to patch 1? It
> > looks like patch 1 already introduces the double accounting changes,
> > and patch 2 is mainly just supporting remote charging.
>
> Hi Barry,
>
> Thanks for looking into this series! Yes, in my head I was trying to
> keep patch 1, which was taken from a previous, different series, and
> then diverge from it starting with patch 2. This would clarify the
> difference between the two. But I can see it just added some confusion
> (for example, patch 1 charges on dma_buf_export() and then it is moved
> to dma_heap_buffer_alloc() in patch 2). I will reorganize it better
> for the next version, including your suggestion.

Yep, I understand the situation now. I also understand
that you were referring to T.J.'s patch, which caused
some back-and-forth confusion for readers when reading
patches 1 and 2.

>
> >
> > Also, mem_accounting is only used by system_heap.c; has this patchset
> > also eliminated its need?
>
> No, mem_accounting is still handled in this patch for the general case
> where no `charge_pid_fd` is used. See dma_heap_buffer_alloc() code:
>
> +       if (memcg)
> +               css_get(&memcg->css);
> +       else if (mem_accounting)
> +               memcg =3D get_mem_cgroup_from_mm(current->mm);

I see. What feels a bit odd to me is that mem_accounting
could either be dropped (with unconditional charging), or
it should cover both remote and local charge cases.

I don=E2=80=99t have a strong opinion here=E2=80=94it just feels a bit
strange, since its description is quite generic for memcg:

"Enable cgroup-based memory accounting for dma-buf heap
allocations (default=3Dfalse)."

Best Regards
Barry

