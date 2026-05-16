Return-Path: <cgroups+bounces-16003-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCQyG9I2CGpregMAu9opvQ
	(envelope-from <cgroups+bounces-16003-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 11:20:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E9155AE27
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 11:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BC423016ED6
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 09:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859B23A641D;
	Sat, 16 May 2026 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1z72bao"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6437C937
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778923194; cv=none; b=RoKu8LmudgnMzQWC+1Ko4NMx4a2d6Pz+k0uu/oIT8YkfAIavw5w9SEI50oYy/VyamUcZcWuZVELGCbyMihlvFEoF5xp9KrvpKEkErPSCZ9D171htlrgyxIGynLqjIULQZX/GYMEuJYDE8Mfp9+w97zK9b61oTo8MlsGfpRvOIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778923194; c=relaxed/simple;
	bh=G1PUbCxyJOX//Tw7UPj9+qUEfRYerN3gCn9IPzsOw7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgkvPxW/Xz9/EEoP7Jj/E9V6EjERTf/dXR7m+J8TRD3j94AQdKaWvNA+HgstF3XKuQHat9q2m/mBRHLBkkQzJwYDo0PZBmgNM11V1J7O5ibIewhHRgyzYWnIFVSjmVsB3b8sr4pe0P3WT7BWWkqZFWPPDvR621kHuzwf6+7kt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1z72bao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2FDC2BCC9
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 09:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778923194;
	bh=G1PUbCxyJOX//Tw7UPj9+qUEfRYerN3gCn9IPzsOw7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M1z72baoLmGJAEKOKqQZ86umfRZIzE/a/XGjsuyC2B4C2wlE1QHhtr/w78SZurUcj
	 weHzRq8Qt//48z9bq7n7N7fFaDfSiTsphqENDn1/PUflv232kYu2CRgg8j9ClFq93b
	 msqTPrTtdkX8k+U6G4aTsX4cXywWFSetkX0oSxWR+RmO+NSY4LOAAUtxDeFPzGxF6E
	 fcRtbK64rUgnF5X+E0teg3M33P+tvkBXmpgqd1T8S9R00XEJPVgzMzrLnyWYyKZ/Q1
	 8R7raGUJN6mb6Qa4oFUGszn5/fGQs04AsGgPMZgDV6zlzRsdAdzTjr89YwHXmbRvH5
	 RoJtjjey6r67A==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-90d042fa745so163395185a.1
        for <cgroups@vger.kernel.org>; Sat, 16 May 2026 02:19:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/mroxa60HnJ01N/utDmGEIoB0D7MahLXnz3PWMd4thMhPa3uFfF0zjq5zyhTs9d2Y1VKqe4H6m@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjXtUdACRqinlkCzL0tgkZL3bn6GgulPw/QEfWTAwgY1/RUqz
	lvaIW9Rz3wLQZyGkDJQd4/XLMBlHH6pSu0uFM8T4MFNQKaetxbP2KxbBL+btsimdhk/NNNFclaW
	Ca4PZXONPRZoGPUi1Anmw5MhSX+BoX/U=
X-Received: by 2002:a05:620a:4487:b0:912:c631:d797 with SMTP id
 af79cd13be357-912c631d977mr618156185a.60.1778923192922; Sat, 16 May 2026
 02:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CADSE00Jq_uvNgvxgPze0mEdUd+hF4-DPZkHy0KroWHZzygf4WA@mail.gmail.com> <CABdmKX3DhejYBis9htLDnzPrG7vuF3R3URLVNEbnyd61SSsx=g@mail.gmail.com>
In-Reply-To: <CABdmKX3DhejYBis9htLDnzPrG7vuF3R3URLVNEbnyd61SSsx=g@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Sat, 16 May 2026 17:19:41 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zyecY6E-=Tm4_couT7uoM9LMcFdTMUPkZAjj4zUKE-dQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lfp6d8-xrGLNMN2A36VEAHbeTkf6FHYhVfd3tCidoD4YpDVmS9DpWsPFQ
Message-ID: <CAGsJ_4zyecY6E-=Tm4_couT7uoM9LMcFdTMUPkZAjj4zUKE-dQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH RFC 2/5] dma-heap: charge dma-buf
 memory via explicit memcg
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Albert Esteve <aesteve@redhat.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
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
X-Rspamd-Queue-Id: 05E9155AE27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16003-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,amd.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 12:35=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
[...]
> > > I have a question about this part. Albert I guess you are interested
> > > only in accounting dmabuf-heap allocations, or do you expect to add
> > > __GFP_ACCOUNT or mem_cgroup_charge_dmabuf calls to other
> > > non-dmabuf-heap exporters?
> >
> > We're scoping this to dma-buf heaps for now. CMA heaps and the dmem
> > controller are on the radar for follow-up/parallel work (there will be
> > dragons and will surely need discussion). For DRM and V4L2 the
> > long-term intent is migration to heaps, which would make direct
> > accounting on those paths unnecessary.
>
> Ah I see. GEM buffers exported to dmabufs are what I had in mind. I
> guess this would only leave the odd non-DRM driver with the need to
> add their own accounting calls, which I don't expect would be a big
> problem.
>

sounds like we still have a long way to go to correctly account for
various v4l2, drm, GEM, CMA, etc. In patch 1, the charging is done in
dma_buf_export(), so I guess it covers all dma-buf types except
dma_heap, but the problem is that it has no remote charging support at
all?

> > udmabufs are already
> > memcg-charged, so adding a separate MEMCG_DMABUF would double count.
> > Are there any other exporters you had in mind that would benefit from
> > this approach?
> >

Thanks
Barry

