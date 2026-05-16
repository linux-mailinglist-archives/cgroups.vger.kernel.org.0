Return-Path: <cgroups+bounces-16001-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJiCHaweCGqPaAMAu9opvQ
	(envelope-from <cgroups+bounces-16001-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 09:37:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D2455A9E1
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 09:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A3AC3016D3A
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58B380FCA;
	Sat, 16 May 2026 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNpNtXRG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A526C385
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778917028; cv=none; b=kKQ+W5zV/6fUK4UnB1Je9VjkILhRhgLMs44ndW+qOah8dhNX1eA8nvK27+VLUoilaq+FoYL4CsDOWmEaeq1U22wLEhuacOZ3HTkMTC2w7TD7xM3sDuij4WgEfs+pKtsK54yLvtEgpm2k21ux4Kby2dbZVDWGNVxYRNBkh/zaZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778917028; c=relaxed/simple;
	bh=P3vqgwHwD6iLuiEKYHBc9rKUdaJI1VWv+dxZinDZG8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7s8yj97p0DECCbosMDEoA7SxlBwZd/W/QV2UHVkohlad3SMMi27EyXXYYHaW513XPp5swXv22R+X4y+UFBlHReiRAaUaFjIj+XWzdE0mT3DD2MJ22mR9ez7sV1SN8d+TCqbAiq6B+NDRLvqtLwfrXfZUn20d9cvzH3dh3El2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNpNtXRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F77CC19425
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 07:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778917028;
	bh=P3vqgwHwD6iLuiEKYHBc9rKUdaJI1VWv+dxZinDZG8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nNpNtXRGUw0mf4NnH+yNpsGfoHEeYyd5NHflVOhmZkdo7mVPuYo0Sn7ejcQkpbAdL
	 Xq4AnHBYR4AGZl8TBwgKc4eBK1jQKV2THXCREwHOk3eNmL2yNugi07+KM4ItzVAMO6
	 lSPY0Q0dGzv7nMdKXX7wA4HJVc7hGOOjnXN54jcMnyKjaImX35rvGB1CMn7FnXzrEH
	 ttD1bT9CLBvfDdqqOFFKIZxJh2yhLap9F2AzPm/qZYxfkQWJm8kzSDn2H87s6wQ+fJ
	 uJXowVoELz8Hq3RAcg3eCdTqAUK/EgUtAJVUnrzr3fZqJNnt9hF+hAPgi/sObhd4Kf
	 /5dvJQcCOdrpg==
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso10984836d6.1
        for <cgroups@vger.kernel.org>; Sat, 16 May 2026 00:37:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Ysb0G8cvSpklCnygo82O0kaYbt4ZUqFufexNkbebyPzSnm1+A/yw4k+0EUNOG/f5WKLHJAIrB@vger.kernel.org
X-Gm-Message-State: AOJu0YylNpDNqbazxHUyiRIVMRkaMVBddauZWA53eYOrLSMhoIJDaawE
	0ucZOhy75dIZr24YuNLC5buBabgE6uLHbisyEYhWHDHwOm6PcysXmCz+Xxroejed+kgQVzBZ8kQ
	1kU6GtF5ZEHjkUMq0UcxaMyiXV0B/z0w=
X-Received: by 2002:a05:6214:29ce:b0:8b3:ff3f:5d61 with SMTP id
 6a1803df08f44-8c8fda1ccbbmr178745586d6.22.1778917027156; Sat, 16 May 2026
 00:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
In-Reply-To: <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
From: Barry Song <baohua@kernel.org>
Date: Sat, 16 May 2026 15:36:56 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
X-Gm-Features: AVHnY4L9M-s1Neba6WebvB2EkXnslTMMIykTYPVPE3skCvVx5rzQK6ntLSW6W0w
Message-ID: <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
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
X-Rspamd-Queue-Id: 37D2455A9E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16001-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 5:18=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On embedded platforms a central process often allocates dma-buf
> memory on behalf of client applications. Without a way to
> attribute the charge to the requesting client's cgroup, the
> cost lands on the allocator, making per-cgroup memory limits
> ineffective for the actual consumers.
>
> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> the mem_accounting module parameter enabled, the buffer is charged
> to the allocator's own cgroup.
>
> Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> all accounting through a single MEMCG_DMABUF path.
>
[...]

> -               if (mem_accounting)
> -                       flags |=3D __GFP_ACCOUNT;

Hi Albert,

would it be better to move this and its description to patch 1? It
looks like patch 1 already introduces the double accounting changes,
and patch 2 is mainly just supporting remote charging.

Also, mem_accounting is only used by system_heap.c; has this patchset
also eliminated its need?

Thanks
Barry

