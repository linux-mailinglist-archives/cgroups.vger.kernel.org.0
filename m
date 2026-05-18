Return-Path: <cgroups+bounces-16057-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKxhBGWjC2ooKQUAu9opvQ
	(envelope-from <cgroups+bounces-16057-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 01:40:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 670D65750DA
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 01:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F2F6302E7A6
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 23:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF133382F3;
	Mon, 18 May 2026 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aX+kKzUs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81317330B01
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147564; cv=pass; b=qaLC+bD6p1pEWuBhR088bhopsabO2mZJbn+2Vwr7hlwj9T568PKRGfMXOwZNeYhysDm5mYGgytC6J2SehCuWhDcmNBclOeeWZKOAvAsRZj1f884Cm4veOjqF1M5A4boHry8eug8NzmdrhQtvJdRZfYCASiJD30/ri0gE3E3jtN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147564; c=relaxed/simple;
	bh=RlgWSbw/qDy0FEEgyFzO7eBFoHyyLd7vQDOSYcU9a5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpmVM6Rj7IiYGkDm+Z2KM8rZjsSz04yiJ+/0GVv+1SO3DG/VA7rYedQcQfalX1ILLmOKEa5/EB0GnzGXM4pjnTvRNnjGdfVcwkJRskywYPti45elgcdToEBYGxCvuqVYU51PeNdJyxB66bRWefpW3XoG4yGLAinhCZSMj5lPq7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aX+kKzUs; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so735e9.1
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 16:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779147561; cv=none;
        d=google.com; s=arc-20240605;
        b=hE8H1jOXXqSPNCg0fuprBFD0wY/+NxkFQlcUzqIEoiXTpmVZASjQc7g4ApX2FDmoM1
         NDacjIhbx1A1XUxcQBNbBrKFuMPtO6ow2sVlbyiNLb6XJbsjKdzkJ5u3SvopCqjQ7cRG
         t0fYCD3kiIL3Q434ikN9MePS07WvJClQNfB2E3FxUJCHIf5RTOv6O5Qbs+x1c+PADTIf
         sWHLF24SX6aLgSgfcHhwcUG0Mn1W8POdBjj6h0ipIdoTEXsb1pM4StjTxz1EM+Pe+0tu
         cGqmUqXmDfUxnoNmuOScrI5JgG3NbdSLrd6LfOlU1VBhpROUvH0UHf6yRfR70zz6SRM4
         y+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RlgWSbw/qDy0FEEgyFzO7eBFoHyyLd7vQDOSYcU9a5s=;
        fh=FDrs+cAZccJk2Pc1GAqheKfgOMUoBfez8aUWfCKFSGk=;
        b=coOBBnSPYgi2abgChp98X3PeYMl8cYRs+YYET6VrYV5O2eeGCv2tyVKXNxQLE3qYrq
         gNp10M0RuwnjkQU77I0DXyhQ891uLNmXjzGL/zGbu3WnCEXRzsL2V49tW6MGNJ/WLoF6
         LUIn3PdW5FHHEvxqTE1w8JMGtDD3NB9n1mx9jUYuDQh8D8fPNLxFmCdSvtHL4vlqcVlY
         lwj+FER+2ZSf2gSbELCTQKFdCr6m+1WFMI7Axsq+DmSSc8IAEdoTTs0SeEm+A1a9vja2
         oTQjz3kugaZcYzs6kHa3o7gsC83j8ZgQdYGum+e5lmhNprBWEXfrYNiUmxKoiMOZcegh
         fyjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779147561; x=1779752361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlgWSbw/qDy0FEEgyFzO7eBFoHyyLd7vQDOSYcU9a5s=;
        b=aX+kKzUsboVSf1MSKClDtOA3TnfKk+2f/C6h/5nyVGbD9QLjyaIW08h8weErzxQ8CV
         K05jrB3VojE83yb+c2TIiJHZ53CzjtK3vhBDEYgkBJbzrecfWi1eqaiES6OCvMAdd70f
         6VUC1A6T4JCWF/UBzVx7hx02iiKtejtlhO9uaTDWQJMQaUDhf+7nzaNcVT+3s0e2QUgS
         GSnujKQ3COePTRHcxTBo16Pc/2bGiAVoDMzg7hza8br6DAfoYb+m6y62mfnRfGopFZgu
         1hCCXb9CCP+V63QbmI6ny3ZzWqx7jKpPC9Uc/dskvKKvJmtPSyszZdVulhdG92zpq2eO
         11Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779147561; x=1779752361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RlgWSbw/qDy0FEEgyFzO7eBFoHyyLd7vQDOSYcU9a5s=;
        b=QjbXYrMO5KPfwm7WuceJDgcDzbs4EVKjZyCJlJXJcfg72AspkEDW9zLyVLIaGCJRae
         RRM47GnDJDztBGByROpvKRAHItHL2V0mk0DxKTO8iWuEF0opKV5wbpcK8OfSLEdwkNES
         4SSrTqiLQha7EPV7QV56sgwgyw5qfug0jlA7dYKx/C5vFNtyTUz4wdPUzftKHLwBcndQ
         /7Mz56k8KsoeWhNXYiKyZmeoJjKDoRM3UzzLxG92+olGuZw8gmTavtYPi3y1AtXTRnNc
         /Nzq/9fuhcnhlRqrKPl0vxsGhv5ttaRxOJ9/W4cvC0WF30LGrS9UOnLa3ncdUHj6cBY8
         w7NA==
X-Forwarded-Encrypted: i=1; AFNElJ8LIKqpfOYLrtRv5i29Ox7EdjCkSNMEQ3jp/QoWYSemCdz0IsyrtQESTdtJed9jKWvOLlSYjB2v@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1XpZLanvw5BNHQaHVWD1QFc/KSpUOwAghLK3OU/0dy2axgBb
	ormGMD5zR0nSaWecIlskKO5eykKFJsrocyhqlLtg8VC9UNNt4uKorh3INbhHml6U3t/keVxkDud
	d+vhpAmNmj9o2BK37qCJA/hXShpPvzy91sokYRo7Qf1O77KeiMCl4zkUUOgVQcA==
X-Gm-Gg: Acq92OEqx7ie4q5PmE23p/X89GG7a9EPwwxVraIhRO8iubFmrFsY+ooXAjt0jGnQtlw
	PWIpwa6BXQdA5g//VM6U9+I+l3Vuwv0ddkUv036zHtWbfdgV1r7+++i6fCXUaUtOEZ8IGxz2sHo
	q4aIu4GR3RcLwcQ7AgyFte//RFxSfn4s+X8kMmpIBt8ut/tfOWGnXeAI2at5vPPWHf/48+o/bHQ
	eLL4XEujnQyC3ACU/sJVo4Jb5/HbBS90EIgIdeUknsgT3ahbXBiQ52qM3uuYHDcAqtk1lkUYj3h
	/9J/bhcGFNrUMBdCmcYljTGydgxwbcE3er0K54pCVl80IMzn
X-Received: by 2002:a05:600c:534b:b0:48f:d634:b18d with SMTP id
 5b1f17b1804b1-48ffa5e1260mr1775015e9.8.1779147560622; Mon, 18 May 2026
 16:39:20 -0700 (PDT)
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
 <CABdmKX0gqg309hcXcOHSj_yTg0h1zwDL34GDk8mX3wp4YoyfDg@mail.gmail.com>
 <CABdmKX3wwgovwS-V8rVC3=+EZcTvPs_cttpQb1w6WemwLAVhsw@mail.gmail.com> <CAGsJ_4y=Gsv=FSUjJ5+99Gg6ULUnv0LRexCGOGetzChR3YA44Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4y=Gsv=FSUjJ5+99Gg6ULUnv0LRexCGOGetzChR3YA44Q@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 16:39:07 -0700
X-Gm-Features: AVHnY4LTFYlENC6xQVXK8AijxUAKUMiH_YZR8cEYxhyMaKCwg0sVArYGdEg8UAo
Message-ID: <CABdmKX3GgCogr9pQFybnV1p_zuo1V9fqJLCXvk-HAnk1gwLoDw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16057-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[android.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 670D65750DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 3:19=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Tue, May 19, 2026 at 5:17=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> [...]
> > > > > Yeah I think this might work. I know of 3 cases, and it trivially
> > > > > solves the first two. The third requires some work on our end to
> > > > > extend our userspace interfaces to include the pidfd but it seems
> > > > > doable. I'm checking with our graphics folks.
> > > > >
> > > > > 1) Direct allocation from user (e.g. app -> allocation ioctl on
> > > > > /dev/dma_heap/foo)
> > > > > No changes required to userspace. mem_accounting=3D1 charges the =
app.
> > > > >
> > > > > 2) Single hop remote allocation (e.g. app -> AHardwareBuffer_allo=
cate
> > > > > -> gralloc)
> > > > > gralloc has the caller's pid as described in the commit message. =
Open
> > > > > a pidfd and pass it in the dma_heap_allocation_data.
> > > > >
> > > > > 3) Double hop remote allocation (e.g. app -> dequeueBuffer ->
> > > > > SurfaceFlinger -> gralloc)
> > > > > In this case gralloc knows SurfaceFlinger's pid, but not the app'=
s. So
> > > > > we need to add the app's pidfd to the SurfaceFlinger -> gralloc
> > > > > interface, or transfer the memcg charge from SurfaceFlinger to th=
e app
> > > > > after the allocation.
> > > > > It'd be nice to avoid the charge transfer option entirely, but if=
 we
> > > > > need it that doesn't seem so bad in this case because it's a bulk
> > > > > charge for the entire dmabuf rather than per-page. So the exporte=
r
> > > > > doesn't need to get involved (we wouldn't need a new dma_buf_op) =
and
> > > > > we wouldn't have to worry about looping and locking for each page=
.
> > > > >
> > > >
> > > > Hi T.J.,
> > > >
> > > > Your description of the three different cases sounds very interesti=
ng.
> > > > It helps me understand how difficult it can be to correctly charge
> > > > dma-buf in the current user scenarios.
> > > >
> > > > I=E2=80=99m wondering where I can find Android userspace code that =
transfers
> > > > the PID of RPC callers. Do we have any existing sample code in Andr=
oid
> > > > for this?
> > >
> > > Hi Barry,
> > >
> > > In Java android.os.Binder.getCallingPid() will provide it. Here
> >
> > ... let me try again
> >
> > Here are some examples from the framework code:
> >
> > https://cs.android.com/search?q=3DgetCallingPid%20f:ActivityManager&sq=
=3D&ss=3Dandroid%2Fplatform%2Fsuperproject
> >
> > In native code we have AIBinder_getCallingPid and
> > android::IPCThreadState::self()->getCallingPid() (or
> > android::hardware::IPCThreadState::self()->getCallingPid() for HIDL)
> >
> > https://cs.android.com/search?q=3DgetCallingPid%20l:cpp%20-f:prebuilt&s=
s=3Dandroid%2Fplatform%2Fsuperproject
>
> Thanks very much, T.J. That is very helpful. I guess
> that would require user space to understand the RPC
> procedure, including single-hop and two-hop cases, and
> make the corresponding changes.

Yes, this is solvable by having a policy in allocator services where
the caller is implicitly charged, while also supporting cases where
the RPC includes additional explicit information about who to charge.
This needs security checks to prevent arbitrary remote charges at both
the ioctl() level (selinux charge_to from patch 4), and at the RPC
level (not sure yet but maybe a private interface between system
components and gralloc), so that only privileged components can
initiate remote charges.

> You pointed out the SurfaceFlinger cases, which are
> two hops. It seems that AI models are also using
> dma_heap, at least from what I have observed on MTK
> and Qualcomm phones. Likely, we need to understand
> those RPC relationships in userspace and make the
> corresponding changes.
> I assume AI models are a single-hop case?

It's currently a mix because AI model loading is largely controlled by
vendor code right now. Some implementations use
AHardwareBuffer_allocate, but that comes with unnecessary RPC overhead
for the AI use case. So I think we should be trending towards direct
allocations from dma-buf heaps because model loading time is
important.

