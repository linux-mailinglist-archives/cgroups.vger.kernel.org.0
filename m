Return-Path: <cgroups+bounces-16051-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIjvF2yQC2rhJQUAu9opvQ
	(envelope-from <cgroups+bounces-16051-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 00:19:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01658574637
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 00:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47F3530158BB
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 22:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695233AA517;
	Mon, 18 May 2026 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyZJUz3l"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6339B97E
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142756; cv=none; b=C9Ly2qmy06Hew9NWnk6jwkfTFjsG5rMclv74m49hFhIwDedqQa6sFTMVv9Dh7f31Cqf2ryDyuHdSlWCKWuFajt1+J0NOKGYDHcIwSHoVCI41wCMpbINt2IZJdhYPHW38olSmfPzgvbeKK4ecwYEwsFq5uiSoUA8q+swY0qIRZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142756; c=relaxed/simple;
	bh=QwPwsIbtmpQIwK98XGhoY5fkgFLxHo2PkgkWS665XEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHuB9XUMVOajVDRsNf6kW6KaXLVXW83zg0naroR1SEFgS1+DJHXefy9d+R6NFsuDfIvFv2PumcSBRK/Z3CNrwNIkDvQqaiqOufLruuMbsEgILNwA9sv+U6b0IIqGTc6eWTbqT/zdH4zPsP3hndGkxgfDnPSgrnieXgsaQvfZHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyZJUz3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AAAC2BCB7
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 22:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779142755;
	bh=QwPwsIbtmpQIwK98XGhoY5fkgFLxHo2PkgkWS665XEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qyZJUz3lOE231ha1IEgeYCxzXObaBETWrQBGKq7jiBGkIh4nlvzjaS1TAQZaKyghd
	 WDzrb3TUj0axyMqG43s65YrlArYPvTovp39xj+zWXlSEZkB/C3psRaH3ys+YFPYef6
	 5D60lPcDGQ9O33yd9uN09xwZPsQe9mQk8eG+BTp9LDFDDWUMfWG1b6yAGyIGkBv4Ag
	 qfkGTVH7AgNRJ9Zo2irgcAte/2WSIdAcFzDGVpK3u/VaQrHckAWehw9ObBZIUPSVkk
	 KAdRksrtZo+nB9IDEhi1kKHkcgOBBtfGXGlTzgrXAgWDx24Ws47LblQp1hDG5ZG9cU
	 mkTW/MSf1zlTQ==
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-95ce7b777ccso2184445241.1
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 15:19:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/qV9BAn9An+ce9/BeH2iGAtcHrthFLiBIwIhGmxxImlIDO94Eq75Ql3uBs1A2lywa7f6EBoiaF@vger.kernel.org
X-Gm-Message-State: AOJu0YxLP+yK3DNCojfjUhHtVAcBg/Zj46GKeIXEOfPpUBv48bMa4lKd
	ygbJlTw/pXFhO/LmnxdGkcoHdfbSW3qoPwsp5uNCfhFJaugnTbUNTtJwU/Pm48EcjymlOd/Wqes
	1ZX5OuQbagbql4848049AvZ07SyoC4Ww=
X-Received: by 2002:a05:6102:6:b0:65a:fec7:137b with SMTP id
 ada2fe7eead31-65afec72d9emr1102084137.0.1779142755093; Mon, 18 May 2026
 15:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CAGsJ_4zjrFJYQQsLThTGXR6g+2PXzeAhjyDpLHfDFqVViWvyBQ@mail.gmail.com>
 <CABdmKX0gqg309hcXcOHSj_yTg0h1zwDL34GDk8mX3wp4YoyfDg@mail.gmail.com> <CABdmKX3wwgovwS-V8rVC3=+EZcTvPs_cttpQb1w6WemwLAVhsw@mail.gmail.com>
In-Reply-To: <CABdmKX3wwgovwS-V8rVC3=+EZcTvPs_cttpQb1w6WemwLAVhsw@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 19 May 2026 06:19:03 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y=Gsv=FSUjJ5+99Gg6ULUnv0LRexCGOGetzChR3YA44Q@mail.gmail.com>
X-Gm-Features: AVHnY4I1qEOEZQdYFnOfKNfIzm2SBPuZfZoateaLto4Ne3PZjITQyUeamdYuj98
Message-ID: <CAGsJ_4y=Gsv=FSUjJ5+99Gg6ULUnv0LRexCGOGetzChR3YA44Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: "T.J. Mercier" <tjmercier@google.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
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
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mripard@kernel.org, echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16051-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,android.com:url]
X-Rspamd-Queue-Id: 01658574637
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 5:17=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
[...]
> > > > Yeah I think this might work. I know of 3 cases, and it trivially
> > > > solves the first two. The third requires some work on our end to
> > > > extend our userspace interfaces to include the pidfd but it seems
> > > > doable. I'm checking with our graphics folks.
> > > >
> > > > 1) Direct allocation from user (e.g. app -> allocation ioctl on
> > > > /dev/dma_heap/foo)
> > > > No changes required to userspace. mem_accounting=3D1 charges the ap=
p.
> > > >
> > > > 2) Single hop remote allocation (e.g. app -> AHardwareBuffer_alloca=
te
> > > > -> gralloc)
> > > > gralloc has the caller's pid as described in the commit message. Op=
en
> > > > a pidfd and pass it in the dma_heap_allocation_data.
> > > >
> > > > 3) Double hop remote allocation (e.g. app -> dequeueBuffer ->
> > > > SurfaceFlinger -> gralloc)
> > > > In this case gralloc knows SurfaceFlinger's pid, but not the app's.=
 So
> > > > we need to add the app's pidfd to the SurfaceFlinger -> gralloc
> > > > interface, or transfer the memcg charge from SurfaceFlinger to the =
app
> > > > after the allocation.
> > > > It'd be nice to avoid the charge transfer option entirely, but if w=
e
> > > > need it that doesn't seem so bad in this case because it's a bulk
> > > > charge for the entire dmabuf rather than per-page. So the exporter
> > > > doesn't need to get involved (we wouldn't need a new dma_buf_op) an=
d
> > > > we wouldn't have to worry about looping and locking for each page.
> > > >
> > >
> > > Hi T.J.,
> > >
> > > Your description of the three different cases sounds very interesting=
.
> > > It helps me understand how difficult it can be to correctly charge
> > > dma-buf in the current user scenarios.
> > >
> > > I=E2=80=99m wondering where I can find Android userspace code that tr=
ansfers
> > > the PID of RPC callers. Do we have any existing sample code in Androi=
d
> > > for this?
> >
> > Hi Barry,
> >
> > In Java android.os.Binder.getCallingPid() will provide it. Here
>
> ... let me try again
>
> Here are some examples from the framework code:
>
> https://cs.android.com/search?q=3DgetCallingPid%20f:ActivityManager&sq=3D=
&ss=3Dandroid%2Fplatform%2Fsuperproject
>
> In native code we have AIBinder_getCallingPid and
> android::IPCThreadState::self()->getCallingPid() (or
> android::hardware::IPCThreadState::self()->getCallingPid() for HIDL)
>
> https://cs.android.com/search?q=3DgetCallingPid%20l:cpp%20-f:prebuilt&ss=
=3Dandroid%2Fplatform%2Fsuperproject

Thanks very much, T.J. That is very helpful. I guess
that would require user space to understand the RPC
procedure, including single-hop and two-hop cases, and
make the corresponding changes.

You pointed out the SurfaceFlinger cases, which are
two hops. It seems that AI models are also using
dma_heap, at least from what I have observed on MTK
and Qualcomm phones. Likely, we need to understand
those RPC relationships in userspace and make the
corresponding changes.
I assume AI models are a single-hop case?

Best Regards
Barry

