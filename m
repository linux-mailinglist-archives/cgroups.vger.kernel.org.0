Return-Path: <cgroups+bounces-16069-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLHpNvgfDGphWwUAu9opvQ
	(envelope-from <cgroups+bounces-16069-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 10:31:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 374DD57A189
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 10:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA6E930D6312
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 08:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D123E5594;
	Tue, 19 May 2026 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KK+efXO4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTM7iW8X"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4D3E5567
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179124; cv=pass; b=RlU02bm+iRoUG+65Ughvfx9Cot+nctGmNHg375FMmP28ei7WxM/msdEPPEqGDsgS8wlvVjOaeE0/L0NWTB1Lmcq7RD4WTnCt18Yst3XunDk3afqbSaKHW5r9V8icF4WE/kEnWZBGX04LF/EUVY1mU5q/g0FtkOHI+aZLfZINooE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179124; c=relaxed/simple;
	bh=Zmlcsxs7JMP5bdHZ5kThghYTTdo51TjoA70ut3zJssU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmNbaQycAtgJcPRnr6zTmUVSRWeXb0Hayh0vkAbZij99b7D/VGoUlVI1jtSs/v/E26eFFkvFXUqn/WIbgC5d5Xi3Aq4z8PAowsMkVx5nfO9AS/yvlHK7hE9jeLJBTcdO119DJiYQupTOKFmVnmRYY1xKFOjnG8f7OWbvgKkzWNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KK+efXO4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTM7iW8X; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779179121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zmlcsxs7JMP5bdHZ5kThghYTTdo51TjoA70ut3zJssU=;
	b=KK+efXO4ylYctwcp8LVfDh7CXaZpMeiSf7hoe5yOC3Cv26P7X3ftYv2irWzJ01Dv9/1b58
	/AkcC/zUV1PomlQM/wgknTrbwXhCQYNhGwCvosULkEj2VIf0q6TpyH1cfqZcJrzy2KdA4i
	txlagmXGKw0OU7pXySF3EaXHgUqwu9g=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-dRg3vYDVNyumJ4OaS_ppcw-1; Tue, 19 May 2026 04:25:20 -0400
X-MC-Unique: dRg3vYDVNyumJ4OaS_ppcw-1
X-Mimecast-MFC-AGG-ID: dRg3vYDVNyumJ4OaS_ppcw_1779179119
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7c027fb7a62so8299957b3.1
        for <cgroups@vger.kernel.org>; Tue, 19 May 2026 01:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779179119; cv=none;
        d=google.com; s=arc-20240605;
        b=ioKt9Cmivx0Dl10OUJjl1YcifsR5uFOZPZeHz2EJcP+CLpc5XcO6rZzSfMQrtVrjJO
         Lg5XemtyT5gNBWT9pFk72kKAd99r6uFFzhZ+njsro8CSd4lk5620oQnw6Ji4RGVO30pY
         78jZdsFU10ceW5RChYmS5r6UFlO/Mmnhfa+sDGcEGnvF6tvQ7DP4PkGPMBCwmkJhKG37
         qaufeqI+vo1Bn3I4jE1OuU21HpvHDsE9D3htm90vYIm6L5vWtD2XILhUl7pSN7x6XlMJ
         Y/qUDVIJ5wJr97DZYQMqL+fA9a/m6ac5yfq1CDuxR75SiuOYngHU+H/x9x1RpnauaJoP
         fylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zmlcsxs7JMP5bdHZ5kThghYTTdo51TjoA70ut3zJssU=;
        fh=hIGeXfaT8wBPkUwldYkXfSuLGmu0QtDc48gKzUyAJJ4=;
        b=dvu14P0FswlfTzy4unpeg4D4jR/fnvA5+NFy2NUMJ1nL9ExAHhb32eWEsVz/BS5jFx
         dY3GyhLMgVhZKd32k4m5/GLM8tYG9MEOUlo+bQI+QaCYTFC8bsytaCKdOxjUZim4LahY
         rmOpPxvFhPftpX1Eyqpzh5MD+TyON7wQvEuc4nMOrnYstZyMb2skDh3T3sX+SxOMefl5
         EpuiC9gCkyx6L8NOE0qLkAyShreQXOV9GzTL61rxySvtbJYMeh9KveMT8KD4osLGftIs
         SZVxpQjc80shbBlZkVYZ7oDzr+vZc6bRK1ctwY5+ugh8/pfE0pPrIh//ZI5DKfxto+Dx
         zrzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779179119; x=1779783919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zmlcsxs7JMP5bdHZ5kThghYTTdo51TjoA70ut3zJssU=;
        b=PTM7iW8XX7Fc+svTNvQEPyrabuPKevYgU4wwNa0E2GH8kYNmCTP076uluaszhaEraK
         v/CYuBcnqj0wOzxgH7z1HHOr6Wa9fIE/4W5rKBG0UW/t69AbbsSzrRlZ+tpCYksa1jyb
         ly/65qoT2WsmO/uRyZm4CoZxr+3IjVuIa8dazFTmDVs+YwG4skJU54pbMzwUjZtIEgkl
         j9HrbNhe1ZDSSgEV1+zP3CDzfLrH/a3gdTDNbhpOR09W8o/DsT383zAysKPGV6RnqBmY
         Q7tDkwuSEgOTUbmEdCyswSIz4kSFHRgVMVyG2cHf/lMXFdxONybSi0MZANYMekQRnSGz
         I7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779179119; x=1779783919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zmlcsxs7JMP5bdHZ5kThghYTTdo51TjoA70ut3zJssU=;
        b=nEv+0jl6fEQXBqBWL5Qp2dtTG82G6BBeDqHhTkhOfaijKq6m+3Ninbxv5fvgT1Hjdv
         YSLuEIYO0JSpVhLOQht4YH1RnB9pA0I/mqaHNIwWB50Z3T38Qj/++0yysAJ5iyyuqD7K
         az01kpDYp+Je0M+1RDKISJ7qmtK+rLpA2YSO+CnxVBh34EAMYweKcuHAnNCI72OInGlj
         dU0OP8bVEYeCdNKvPwpu4k3w7pm16bVqt40/hPr1LRyHwdRNF1RiN9GDiVRacoOFu9xs
         R3iOmqaIXCcU4cZgZ+UWZb0el5vUW48pbfLaG2UCEm5WUWQjigyfYU4uzdFd2ZxdXdJG
         vwWA==
X-Forwarded-Encrypted: i=1; AFNElJ9kdeJlSOaPe99saGOeui3Dv4ANMnPqw+xQQxMOBRMt02YvibjUYzYu6gwoQl/HkG1nt1vH4d7U@vger.kernel.org
X-Gm-Message-State: AOJu0YwaxzG57LIz/F+rAO3k2T0ckQeGs2VCV5mFr4rK1j9AlYULorhw
	NgqhYG6gTUohO/RRQ1gBPB8/Pu0CcNWMgRMCWQHzWs1ikEBk6aecnDwUbyWZ/QOJbbMF44ELQVa
	n4PSJ0LnCsD+1nH3Xzh2WpM1gs84bolFd1eNnJF7T8XMVwPAZqXZfB69emXtIEt5jgWPrz5TbEq
	sRLvOgN7qG7ddEYJijSDaTpsE2cOm1bgq4aw==
X-Gm-Gg: Acq92OFEzd0woVKRciA1yFIuGruuJGOpn6brimrIORCrKsc6X1T7AatC9hRezDwIlwS
	rPEQ2KoCsM5VN8+97qwcIwwzZ/QKPTnzTvk/1DyUhssdvNt2QvxM26slh4ZLzrNlEFPefgCC3cx
	bA3aPTDKUfTxPsX8rMY4F3+kejLmBw77MTaeEUtEiv9OMPX9lzwf+iUxoO4gMNkd9xjkf1mZ3WQ
	FVEnw==
X-Received: by 2002:a05:690c:e041:b0:7b3:edc7:9bb8 with SMTP id 00721157ae682-7c955b970femr172556947b3.0.1779179119384;
        Tue, 19 May 2026 01:25:19 -0700 (PDT)
X-Received: by 2002:a05:690c:e041:b0:7b3:edc7:9bb8 with SMTP id
 00721157ae682-7c955b970femr172556607b3.0.1779179118837; Tue, 19 May 2026
 01:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <20260515-hinschauen-effizient-9e3a05a94f2e@brauner> <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
 <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com> <CADSE00Lh95ygoXGKJGsYvQGEsFV8sVmwEC3uvh8M6r3ERzaJwg@mail.gmail.com>
 <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com> <CABdmKX3yZubjDKbVqwrjHAiKyj_ioHzOoxd0wzFbJK=PAGOqcQ@mail.gmail.com>
 <01b6eefc-c107-4f8c-9d7c-3b86f54cabaa@amd.com>
In-Reply-To: <01b6eefc-c107-4f8c-9d7c-3b86f54cabaa@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 19 May 2026 10:25:07 +0200
X-Gm-Features: AVHnY4K5LncaNoVhZCnb-g1Oej_4CFtS9sUy70LBQyTJDD76MUlJZifB3Hgf-cg
Message-ID: <CADSE00KCpCHOu2GMJ++ozXXbwF13fd2ZfmC3CnZBdLM_0p+ZMg@mail.gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16069-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 374DD57A189
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/19/26 01:39, T.J. Mercier wrote:
> > On Mon, May 18, 2026 at 7:07=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/18/26 14:50, Albert Esteve wrote:
> >>> On Mon, May 18, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> wrote:
> >>>>
> >>>> On 5/15/26 19:06, T.J. Mercier wrote:
> >>>>> On Fri, May 15, 2026 at 6:53=E2=80=AFAM Christian Brauner <brauner@=
kernel.org> wrote:
> >>>>>>
> >>>>>> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> >>>>>>> On embedded platforms a central process often allocates dma-buf
> >>>>>>> memory on behalf of client applications. Without a way to
> >>>>>>> attribute the charge to the requesting client's cgroup, the
> >>>>>>> cost lands on the allocator, making per-cgroup memory limits
> >>>>>>> ineffective for the actual consumers.
> >>>>>>>
> >>>>>>> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> >>>>>>
> >>>>>> Please be aware that pidfds come in two flavors:
> >>>>>>
> >>>>>> thread-group pidfds and thread-specific pidfds. Make sure that you=
r API
> >>>>>> doesn't implicitly depend on this distinction not existing.
> >>>>>
> >>>>> Hi Christian,
> >>>>>
> >>>>> Memcg is not a controller that supports "thread mode" so all thread=
s
> >>>>> in a group should belong to the same memcg.
> >>>>
> >>>> BTW: Exactly that is the requirement automotive has with their nativ=
e context use case.
> >>>>
> >>>> The use case is that you have a deamon which has multiple threads we=
re each one is acting on behalve of some other process.
> >>>>
> >>>> At the moment we basically say they are simply not using cgroups for=
 that use case, but it would be really nice if we could handle that as well=
.
> >>>>
> >>>> Summarizing the requirement of that use case: You need a different c=
group for each thread of a process.
> >>>
> >>> Hi Christian,
> >>>
> >>> Thanks for sharing this atuomotive usecase. If I understand correctly=
,
> >>> the actual requirement is attributing dma-buf charges to the right
> >>> client, not putting each daemon thread in a different cgroup?
> >>
> >> Nope, exactly that's the difference.
> >>
> >> The thread acts as a filtering agent for both memory allocation and co=
mmand submission for somebody else, the process on which behalve the daemon=
 does things can even be in a client VM, completely remote over some networ=
k or even something like a microcontroller.
> >>
> >> Everything the thread does regarding CPU time, GPU driver memory alloc=
ation as well as resources like GPU processing and I/O time etc.. needs to =
be accounted to one client which can be different for each thread of the pr=
ocess.
> >>
> >> The only thing which is shared with the main process thread is CPU mem=
ory resources, e.g. malloc() because that is basically just needed for hous=
ekeeping and pretty much irrelevant for this kind of use case.
> >>
> >> The problem is now you can't do that with cgroups at the moment but un=
fortunately only the kernel has the information you need to know to do this=
.
> >>
> >> So what you end up with is to define tons of interfaces just to get th=
e necessary information from the kernel into userspace and then essentially=
 duplicate the same infrastructure cgroup provides in the kernel in userspa=
ce again.
> >>
> >>> If so,
> >>> the `charge_pid_fd` approach achieves this directly by passing the
> >>> client's `pid_fd`, without needing to add per-thread cgroup
> >>> infrastructure.
> >>
> >> Well it's already a massive improvemt, we could basically stop doing t=
he whole duplication part for the GPU driver stack and just use cgroups for=
 this part.
> >>
> >> Doing that automatically for CPU and I/O time would just be nice to ha=
ve additionally.
> >>
> >> Regards,
> >> Christian.
> >
> > Hopefully I'm following correctly here.... So you are duplicating the
> > GPU driver stack to achieve remote accounting on a per-thread basis?
>
> Not quite, we are duplicating the handling cgroup provides in the kernel =
in userspace.
>
> For this memory usage information as well as execution times of the GPU k=
ernel driver is exposed in fdinfo for example.
>
> > Does this mean for GPU allocations you currently have some GFP_ACCOUNT
> > magic in your driver to attribute GPU memory to the correct remote
> > client?
>
> No, we just expose what the kernel driver has allocated for itself. E.g. =
page tables, buffers etc...
>
> When userspace allocates something using memfd_create() for example we ju=
st ignore that.


>
> > So this series would close the gap for dma-buf allocations,
> > but what about private GPU driver memory allocated on behalf of a
> > client?
>
> Well we would need a cgroup which isn't associated with any process were =
we could charge the GPU driver allocations against.

I think I better understand your framing for this now. Thanks again
for taking the time to explain.

I was looking for a way to pass cgroup around to do the charge. I
found that `struct cgroup *cgroup_get_from_fd(int fd)` already exists
in cgroups available symbols to handle cgroup directories.

So here's an idea...

Rename the charge_pid_fd to charge_fd:
- If it is a pidfd (`!IS_ERR(pidfd_pid(fget(charge_fd)))`) then we do
what we're already doing here.
- If it is a cgroup_fd (`!IS_ERR(cgroup_get_from_fd(charge_fd))`) then
we charge to that cgroup.

Also we could add add an ioctl for the generic fd path similar to what
we have for dma-buf heaps. Or have a new flavour for memfd_create:
```
memfd_create2(name, flags, charge_fd);
```

The transfer ioctl could also be made generic to accept both pidfds
and cgroup_fds.

For this series we could move forward as is, and make the generic
solution a follow-up series, knowing that the field can be reused for
cgroup fds.

>
> But good point, charging against a pid wouldn't work in this use case.
>
> Regards,
> Christian.
>


