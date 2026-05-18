Return-Path: <cgroups+bounces-16031-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CBWLDoFC2rd/QQAu9opvQ
	(envelope-from <cgroups+bounces-16031-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 14:25:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA9356C983
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 529AF30237FC
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 12:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917140148C;
	Mon, 18 May 2026 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhDsoxB7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pJBVJPui"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280433FF8A4
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106617; cv=pass; b=qEPThJ4edCcqJXLcE7wNhdrmRTD0jyjwHaDEW91S99q/WJfY0MshmbnwCbAnvD4Bk+61vbw4Gf8+/tRMf4dXreHwqr2sLmapyvFl7V1VE0INWWSdeuFMCB7PiljJ3xw/7NuWTaoYG5TkSiWBjine6ZK25ZZ7GbiHcMXbHqzSUcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106617; c=relaxed/simple;
	bh=GxTu0NfteCWY6YUdX16wT/N4BvT3hXjpZN7hbF/PIrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVSOG1Sy1dx3kdSBGz9I45dtVdC3bIKhfOhIfna8mfAUsCIL7mW6ZnmYN3EkbSOcTK9DdwbqbwNCyU8JzJjSu0bRyzAMFBCNmvmtzGuKdfnQyEVvZXVG9I321foTpHLQ0+YTY+n1cQCsmF8WIKvyhi84RcTlUErxox7D43LuGaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhDsoxB7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pJBVJPui; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779106614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTNxjctaqLUFv9CjPVEgJLujFyB864ku/zdpEqnLvsc=;
	b=WhDsoxB7L47W8xbX7MDJn5xFkPS7vFUBxSLsjTkdQHpCUvfrZ2macQHMWB5Me9Oz4xFfRy
	rU83cKpB8CWTcAbKWSg8hKQKNCQ8hlhIYhDmkzl2awUlsQhJES36YB3UMNZPoB3GfPhtaw
	3OcK3btvZLxFKGwZt6Fh6qdu7EOZEMI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-cLRQig_FMNaxm2A-meSs3A-1; Mon, 18 May 2026 08:16:53 -0400
X-MC-Unique: cLRQig_FMNaxm2A-meSs3A-1
X-Mimecast-MFC-AGG-ID: cLRQig_FMNaxm2A-meSs3A_1779106612
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7bd795b6288so25758727b3.0
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 05:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779106612; cv=none;
        d=google.com; s=arc-20240605;
        b=BTUU9emdA5ADyUei2Bl/0dvvPnkfeyYWRBTvmbfCFg3ywzWK93XPQag5geE16ffm8x
         32JvfV3sehnJhH4/O+GI6Vgq9LWM17ODGd3EPBtSwr09qysa6Q6gLVAjsKSRZ5WDcgwU
         cFW5/pgSXL9gIsWsgef+nX0WbCDoLUnAp46Z1AkO+uOZ6SCnwxGIrqwkj4AF4hC4SL29
         qjmjfc7a7Ms6ge9WamQXq2Iu8vjR/rGefpm7IiosQ0QF9mHKCqdPZ9morpswerIR7XxJ
         s/GGm23XDTB69yqUdy6f4k0Tm7HnaebcF5ZLDwS6gQXB4CMNsrqMd6QulVsOiMaCYTsI
         ARBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nTNxjctaqLUFv9CjPVEgJLujFyB864ku/zdpEqnLvsc=;
        fh=h+cdn3C8NVUQ6zkX8Yj4ax4+w4hgoQFl1mcsdVTjDpA=;
        b=aeTnKiGxXqXJVaRR+C+2FCvhcrZZMx2BQDnraURHKgoCH95vXXHPsF3Ww1Sljzsnq+
         UReAdi4hsuIn96/uWtjeOaRHiaM8OwYC2palHEcurjp0n509xDRAduuzdwLuJ8S01tAJ
         nnMqz9WKiENRGwA4Po6pAdrTZEcj0gy/poncOkhgXsjEP2Fi6OyduE2tWn82y7q5a2c7
         31euzpDhgpxZTWcL1mYdjfUNNSVdCOm8SoD2NxRMK2OZeTdk0DtMzEhDVmaKxgoQnXvH
         Mn+9VfMyh1qRzehVhwjTZLF/K98Wyk6rCaCyBwu6Qqkyzw+EcTiCwCs141U6X6gn8PSO
         LHrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779106612; x=1779711412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTNxjctaqLUFv9CjPVEgJLujFyB864ku/zdpEqnLvsc=;
        b=pJBVJPuiJ9TppGffJ7/vAPnD/Z2mIYqgiML0AkBYA1lmD/96RwCBB8DnmO7WT60GyV
         jW3ZI87unkDZDW1xghetk6urrRbI8jcT3MHbs4F036uHvin3DbJvk0wV4UVYhrjx+7OO
         hJpJgv6Kpa+Voxr33d9/uf64uTHm3+FVc7FyztyY/lG1ypsZBNQLT4nlkOXQDotGpVvw
         /O6OQltvdVdc9xB5Yh0uKHN4cq1059lXmi/dghfpxCuqIbhEgXnMAVhwkqPbZCvdhj/0
         K25FscMl+T1/3s0pDQ1A8+NmNuixSyESlMeW/b/5L46HmwbaMFwq3CKrmfq/VEc/wZp2
         D7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106612; x=1779711412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nTNxjctaqLUFv9CjPVEgJLujFyB864ku/zdpEqnLvsc=;
        b=bWMBDFzqSyhGActccROalo5j007ixBVQ6L4+XmUegirnsYf5yl0OOWGWKq4+k8dILn
         5LYv3zxiqR8Ii5bp3fkWPgGqNlUMR8Y1oagdDRKY6trG7mkWhhGcQaF3m5EUfn2m/0Gp
         OWanwj9G8J8hlhf0shrrXJWmpLzM5PEmraa0UmVrul+p119p+VrlTTqMGB+Ka3rwFjUm
         DZDo2N1oxbqvOqB+jZ/ZrSXcJ8BEiqUWw3NMCJuTyZCgIsPSldz9ShZuzmAcAUiNCcmi
         zevwSRSGOMFe8pqRdoMEpe12ZjscrqYr3cgEXJxttyYwl7fU7N0vFNFfre959mBlIwzk
         s5eQ==
X-Forwarded-Encrypted: i=1; AFNElJ8sv+9VTvvkPp6XU0E5ZVuI66W9xFYMVIF+girzEGl5QDR6hoALKBJP2R83owtaSXyURyymZmkr@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGPfUHTeOy7mzkslqrp05DBOk8/AJmckHI8VSXyONqcVLGh9Q
	ifH/MIlIrJYZL9Ot0Ao6Y9jFWCgECvlILFfB/M2q+diUnV3QmaYQY3CHGgffSPEgLNndqzDzMBY
	YYmSMJObflDDZLRuROTePPIWDHjGYH36U8KLByPlaKMd8HJtqVZAxRwrC8MLG9WiM/GyAWiX4Ag
	CJZsWIyFT43la16EKgqXudDJkJRT4CkshR6w==
X-Gm-Gg: Acq92OEjfuKROM6MnF20uDEEwgz6JTD9Srvr12YHB/qRhIjDTuZmHkMxxd5cptfuXFP
	yt07tzTgSk4a/V9M1TM1iFJS8LUXV94UXkL0rzGgenLeng22DxoCjnP8wo/jC1UTDPSihVYMq7K
	0SOla3f/Np/3Fyikl28jLomO72ufubXIWb9z5zQJfY7PYVkYBHJgWvJeTEOlxPXvqYWiqaFeCKW
	90l3Q==
X-Received: by 2002:a05:690c:18:b0:79a:b440:5c8d with SMTP id 00721157ae682-7c94765b6ecmr126200847b3.11.1779106612296;
        Mon, 18 May 2026 05:16:52 -0700 (PDT)
X-Received: by 2002:a05:690c:18:b0:79a:b440:5c8d with SMTP id
 00721157ae682-7c94765b6ecmr126200267b3.11.1779106611396; Mon, 18 May 2026
 05:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com> <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
In-Reply-To: <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 18 May 2026 14:16:37 +0200
X-Gm-Features: AVHnY4KtxiMU87dVIS1J63myR0LimTeIXsyDKnE3-mVGrbnQ2cunkdBN5oMYBbg
Message-ID: <CADSE00LjJcL8P5M-UPEpzZijU70uEmUirnin29N8YR5W5D-oFg@mail.gmail.com>
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
X-Rspamd-Queue-Id: 2DA9356C983
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16031-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 9:37=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Tue, May 12, 2026 at 5:18=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
> >
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
> [...]
>
> > -               if (mem_accounting)
> > -                       flags |=3D __GFP_ACCOUNT;
>
> Hi Albert,
>
> would it be better to move this and its description to patch 1? It
> looks like patch 1 already introduces the double accounting changes,
> and patch 2 is mainly just supporting remote charging.

Hi Barry,

Thanks for looking into this series! Yes, in my head I was trying to
keep patch 1, which was taken from a previous, different series, and
then diverge from it starting with patch 2. This would clarify the
difference between the two. But I can see it just added some confusion
(for example, patch 1 charges on dma_buf_export() and then it is moved
to dma_heap_buffer_alloc() in patch 2). I will reorganize it better
for the next version, including your suggestion.

>
> Also, mem_accounting is only used by system_heap.c; has this patchset
> also eliminated its need?

No, mem_accounting is still handled in this patch for the general case
where no `charge_pid_fd` is used. See dma_heap_buffer_alloc() code:

+       if (memcg)
+               css_get(&memcg->css);
+       else if (mem_accounting)
+               memcg =3D get_mem_cgroup_from_mm(current->mm);

>
> Thanks
> Barry
>


