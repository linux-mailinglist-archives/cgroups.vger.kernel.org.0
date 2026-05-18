Return-Path: <cgroups+bounces-16056-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCCvDTujC2ooKQUAu9opvQ
	(envelope-from <cgroups+bounces-16056-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 01:39:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84861575075
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 01:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BDBB303A27E
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 23:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E733970F;
	Mon, 18 May 2026 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiDPL5Sm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9BF331221
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147558; cv=pass; b=W940ZKZHcnLkRe/Fq833VDIBonrrqcCmjZ+rnrbK7096nhgtk7xKVSkxUv9IV3Q2dzZ7bOOnOajH5+NzsgMHjglqFEXu+56oa13cxyyvz3yunlmd8/MVxfJkSsPRp2n8YfjXc1spC8FTch5PX9XxS6hQ4YHH9l0ArCiSdopKqIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147558; c=relaxed/simple;
	bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXxUcPm61GXOOUkWA++TCKaQ7JlNVO++tdUBMRGrdAzT39HiEOZnzXEpnqF7TeaLO/evgxPryTvNPGFnBOMeVcPldawHPZxtmTlr7JznxKPWOn5rU8UNvXc1URrFeJIF6cWo/ERTMktlv2mReOQC+j5+VNrgZhjMadTd0kOmD/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CiDPL5Sm; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so455e9.1
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 16:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779147554; cv=none;
        d=google.com; s=arc-20240605;
        b=JTXT3q86Wj+63OZ+E3v/tHRyOc3r6zRPvOpznuBlFGXTwnR971PT/P1sOwPizw3yBQ
         Px4BpqzeZkksPdPq7mx7+XkM37il24cUDnQlbyuMfxR7ld1B1bEY+pwq3sJaYSTvWXzo
         R+SlrJJYHArJMjZotfwHaPHgJayIWrN9qVgtp4QCARsig5zf10QiRzka3yUK/I8MLZx0
         AvQEPM6XbReHLg4ZbO3dNCN2tXoZ+qIGN2KHi0AZn3438ipQgMbbEsSd+y6y7AtG23UR
         4iBMygf51SKENxodhxeMS4EJMpeKNilwECucVvVQqSC6fazakURM7zDeW/liglgK8srn
         nmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
        fh=M++O8vAlseGCn8dscF+GK6rlMZU4J2u0e3b6Y9R5x1k=;
        b=i3Rd7kJ8fW8KgCInqyd8TSPJcNfk0rUQbQyDV4TQn+1qUKdXQILJ7NVGNbFegGpXGr
         86RdptYayfbaZEy/7kaXm9GlmLnAp1qRZYhjCwstuFDlWbi9npKq6aUFPkA6WhuIEo1o
         EOKaC6DCVe9m4fIJBBHervmZKWd71anAFq0dhg1wrhfGiXQIQbbER/+ipkDI/CQlm+RP
         edAUTnUj0NiwRlNMtq6bpi19W1465eCLOp8tPEAK1stk/6REGKcocVA8ojgxKW/hf/GQ
         OvLcUjve4OoD3EyVZjQKVmvfpnicsygF7Y5Jg3lOQpY6AE1vCOHXmSteNLUMAQgV2Zwv
         Lxdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779147554; x=1779752354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
        b=CiDPL5SmLs8Uj1xMnC+3rSpDgI7bJBLrSvAsM8GnEvfRWf3qxittHUYaoPOdyetJpu
         JB1hiA3FAcsQr8Xvk0ZlvumqY8XNYng0JvUpCtVG1DJHpQ0WgF+CV/NXJVDKN7ha/D5V
         uF/JQ+iboJrsMYyPRJHfPvYpLFTN70CXOfN3gkYX/seyTVNeKgps2MHzHBHUMvKup4rv
         X2KiGwO6w1ICOGOJE1bw+P3EkOGZv4lOWAD5wTrDI6E5VU08b2Pip32Il+WWFSQTsAA/
         WVeQitXHDSigAL84gB9DW8ksILFSJgC4Tab8Ztvqn9itRVBNN8b5JkxRQA519u9z2DRL
         BNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779147554; x=1779752354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
        b=gtUAwO5Jyv6jIgZ7WxE3sTgkku/lN37EtwX/QZxIo7my5AgPZtf30gK5J10iG0euvX
         rxeH/iRjFhCNbx/5pSQ1NYomd5iK0E3lZNelvBSprNhOU4vVxCyc83bJxx7g5/why7iD
         cTlQDevgqkaHwZCJAInRQa8Ihpa63QuYgJ3SXbSIqQuF+0NZwu02/gYskqPKy06LKpqR
         sVoL9izW6e4V3I/QNEgKAyl5FEy7rbYupvy59kD+8G6w+H5XUFXggRzSRoL6L9E9KSjt
         nA2/APKPGxMXQ+YzWEFaV/xPMtS+YwwWLFKJDkO1pRqSbPBsr88V7hW7jmHEKot4IDEB
         e41A==
X-Forwarded-Encrypted: i=1; AFNElJ9lFaS5ti/Qs6SDRxcn19iV4irMhYXkgZOAegEHfQTMSz0XccMh1+3z+CA/LGfyMEVLYzTqcEF8@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCuUGMvjy6MWakdAyH1AAgeogjGLaF1eqJtEqcIHW+RlJ7o3d
	RmY7wivTwVcvglZZ2UtkeWuYNHZs1wg6oGx0jSqGaL/zbruGxdZbRZaNfn8t/D6of3ZydyMAAzk
	To01Ck1fHQLQB6sbNMEAByV6CbfzqFBhejUNkwbMY
X-Gm-Gg: Acq92OEJoFxxr349V49bKicEqIrOhWLSdW0B66ukdiNg9/PnHh4bT29ApPdEQcvbNi3
	sxn/UrPYniowu+hvSHMH50Vk0bd61yYTCKjDvrJewweRWVsw0XGGRjkK+KMW9tDviO3A73xp01k
	Y11DVpFKlwOuiNkFm1pmO61W7kf2JRzgUppLgnj8xmz1UyS/77IFby9b0RY9/VaV1GSFSHUeOHj
	yusbKuLe8jduqRHKZTZJsOoOa/K7Rf/KRrzAcdXhC6f4qX/fBpA4U1ykcy4Fg9arS+wNExc83fi
	xKhpzXGsrjbHblBnO045pD2bYi+fizDJWlzU1LynCZ0gDsr4
X-Received: by 2002:a05:600c:83c4:b0:48a:56fa:36dd with SMTP id
 5b1f17b1804b1-48ffd85790amr3271995e9.11.1779147554173; Mon, 18 May 2026
 16:39:14 -0700 (PDT)
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
 <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com>
In-Reply-To: <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 16:39:02 -0700
X-Gm-Features: AVHnY4K5WzHxjnmBKK1J4Ij9G3s1JmujGOC18rtfp3AXYH6mFeA4fkV1W-efX6I
Message-ID: <CABdmKX3yZubjDKbVqwrjHAiKyj_ioHzOoxd0wzFbJK=PAGOqcQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Albert Esteve <aesteve@redhat.com>, Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, 
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
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16056-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 84861575075
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 7:07=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/18/26 14:50, Albert Esteve wrote:
> > On Mon, May 18, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/15/26 19:06, T.J. Mercier wrote:
> >>> On Fri, May 15, 2026 at 6:53=E2=80=AFAM Christian Brauner <brauner@ke=
rnel.org> wrote:
> >>>>
> >>>> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> >>>>> On embedded platforms a central process often allocates dma-buf
> >>>>> memory on behalf of client applications. Without a way to
> >>>>> attribute the charge to the requesting client's cgroup, the
> >>>>> cost lands on the allocator, making per-cgroup memory limits
> >>>>> ineffective for the actual consumers.
> >>>>>
> >>>>> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> >>>>
> >>>> Please be aware that pidfds come in two flavors:
> >>>>
> >>>> thread-group pidfds and thread-specific pidfds. Make sure that your =
API
> >>>> doesn't implicitly depend on this distinction not existing.
> >>>
> >>> Hi Christian,
> >>>
> >>> Memcg is not a controller that supports "thread mode" so all threads
> >>> in a group should belong to the same memcg.
> >>
> >> BTW: Exactly that is the requirement automotive has with their native =
context use case.
> >>
> >> The use case is that you have a deamon which has multiple threads were=
 each one is acting on behalve of some other process.
> >>
> >> At the moment we basically say they are simply not using cgroups for t=
hat use case, but it would be really nice if we could handle that as well.
> >>
> >> Summarizing the requirement of that use case: You need a different cgr=
oup for each thread of a process.
> >
> > Hi Christian,
> >
> > Thanks for sharing this atuomotive usecase. If I understand correctly,
> > the actual requirement is attributing dma-buf charges to the right
> > client, not putting each daemon thread in a different cgroup?
>
> Nope, exactly that's the difference.
>
> The thread acts as a filtering agent for both memory allocation and comma=
nd submission for somebody else, the process on which behalve the daemon do=
es things can even be in a client VM, completely remote over some network o=
r even something like a microcontroller.
>
> Everything the thread does regarding CPU time, GPU driver memory allocati=
on as well as resources like GPU processing and I/O time etc.. needs to be =
accounted to one client which can be different for each thread of the proce=
ss.
>
> The only thing which is shared with the main process thread is CPU memory=
 resources, e.g. malloc() because that is basically just needed for houseke=
eping and pretty much irrelevant for this kind of use case.
>
> The problem is now you can't do that with cgroups at the moment but unfor=
tunately only the kernel has the information you need to know to do this.
>
> So what you end up with is to define tons of interfaces just to get the n=
ecessary information from the kernel into userspace and then essentially du=
plicate the same infrastructure cgroup provides in the kernel in userspace =
again.
>
> > If so,
> > the `charge_pid_fd` approach achieves this directly by passing the
> > client's `pid_fd`, without needing to add per-thread cgroup
> > infrastructure.
>
> Well it's already a massive improvemt, we could basically stop doing the =
whole duplication part for the GPU driver stack and just use cgroups for th=
is part.
>
> Doing that automatically for CPU and I/O time would just be nice to have =
additionally.
>
> Regards,
> Christian.

Hopefully I'm following correctly here.... So you are duplicating the
GPU driver stack to achieve remote accounting on a per-thread basis?
Does this mean for GPU allocations you currently have some GFP_ACCOUNT
magic in your driver to attribute GPU memory to the correct remote
client? So this series would close the gap for dma-buf allocations,
but what about private GPU driver memory allocated on behalf of a
client?

