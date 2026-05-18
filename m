Return-Path: <cgroups+bounces-16054-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOBDNg2aC2rWJwUAu9opvQ
	(envelope-from <cgroups+bounces-16054-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 01:00:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C71574D8E
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 01:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E6530160FB
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 23:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79642F9985;
	Mon, 18 May 2026 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKBaQ9DW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632E19E819
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145220; cv=none; b=UppZPK/Mv1LBCTFdDflyE4O8s/oLbySmR6hgER2oSbW9EIiUUMMckjNUrmLSXZdnRVB+7SP1ge4ADhyVwOJal/yP7/Vx7cUZa3/iPtVkVlD2Cp7snXbRbRWg9OGgPHjOhmfLr4uStWDsmVEoACsGI97EyavVTcUpF1e5YbzjnLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145220; c=relaxed/simple;
	bh=IdMsK7+qqBktFYOQdPjrszNAWNg59HWQ7/X9tF03+KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIU4FWlB6DfUhCht0e01I/dndtrX0IBwxBtMDvBd9/PU6lRe6VlHY701+vQ0O4lATPqgku5RPol/p0N2yPKsozbe0tlLESy0WZDjrZDf+NOQdcIRSY+8jgLHV5b3DrZbHwPf5WM721GHe1ljNl94wH08FYJSazWNcmPBT/jrA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKBaQ9DW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D7CC2BCF7
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779145220;
	bh=IdMsK7+qqBktFYOQdPjrszNAWNg59HWQ7/X9tF03+KA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GKBaQ9DWHDRe9+tG++ZPlIoQ4CugNvI5+ftXhfTi6txThm87onadLleybQl4vz+Fx
	 sv91RZTsVD3QK0BlRLPvGh7h1DhdF80k0Lok7aGRNy2DCOziFvTd98IBLPvVCl8feD
	 SSQcbGvHwkJ312D/2okkCTyEYk9E+ZwtFGmc1IKWyasVecqiBKSNe7CtdrP9kZoroC
	 15bohK+iE5wRBtNNUs3c52ZfMsZqNg8ZSZzeuYL4/R44GCKrcSK4BCI6CTHKf0nH0n
	 IMU+jccKSztoDoclFBGrt/8LSp8aFKReAOTI9T0eTq9oNQ176bY7MH0VEHiaSuhcon
	 GbWWlR1F98aGQ==
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-63329e1c77aso753600137.3
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 16:00:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+8P4rDeeo6mmuabjK+GfAvA0ADfOi9yWqNIbgwbW3/N6BLjjNO2s2ixdztOo2v9ZAVPHpgyIDU@vger.kernel.org
X-Gm-Message-State: AOJu0YwEXkGMyjDgulQSsOlznS6tdlbeKkLL1lRPjxEL9H+QMCKv5EDs
	KB4/59GCWn1QM1VC337jJ/QcZBHGrbWLPpNPSNjK673euRkiX8r8ix/DSE8DPikn9thedSpmG6N
	ap+bN4tgRc35NUG9wHZMB69QJ74PByes=
X-Received: by 2002:a05:6102:8649:10b0:65a:fcea:5a4 with SMTP id
 ada2fe7eead31-65afcea0ff6mr1668580137.4.1779145219252; Mon, 18 May 2026
 16:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CADSE00Jq_uvNgvxgPze0mEdUd+hF4-DPZkHy0KroWHZzygf4WA@mail.gmail.com>
 <CABdmKX3DhejYBis9htLDnzPrG7vuF3R3URLVNEbnyd61SSsx=g@mail.gmail.com>
 <CAGsJ_4zyecY6E-=Tm4_couT7uoM9LMcFdTMUPkZAjj4zUKE-dQ@mail.gmail.com> <cb84c2ee-9de1-4565-b2e0-60984721228f@amd.com>
In-Reply-To: <cb84c2ee-9de1-4565-b2e0-60984721228f@amd.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 19 May 2026 07:00:07 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z121v4tK_3+j-hkD7HH0gH3w8tWD8nk0CwRhFE5T+4Og@mail.gmail.com>
X-Gm-Features: AVHnY4J-roggZZXq-3fecPrif-MI9m_xhdL-W3ahLsaa5t4gx3NgfHLdPTzAVis
Message-ID: <CAGsJ_4z121v4tK_3+j-hkD7HH0gH3w8tWD8nk0CwRhFE5T+4Og@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH RFC 2/5] dma-heap: charge dma-buf
 memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16054-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 82C71574D8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 3:34=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/16/26 11:19, Barry Song wrote:
> > On Thu, May 14, 2026 at 12:35=E2=80=AFAM T.J. Mercier <tjmercier@google=
.com> wrote:
> > [...]
> >>>> I have a question about this part. Albert I guess you are interested
> >>>> only in accounting dmabuf-heap allocations, or do you expect to add
> >>>> __GFP_ACCOUNT or mem_cgroup_charge_dmabuf calls to other
> >>>> non-dmabuf-heap exporters?
> >>>
> >>> We're scoping this to dma-buf heaps for now. CMA heaps and the dmem
> >>> controller are on the radar for follow-up/parallel work (there will b=
e
> >>> dragons and will surely need discussion). For DRM and V4L2 the
> >>> long-term intent is migration to heaps, which would make direct
> >>> accounting on those paths unnecessary.
> >>
> >> Ah I see. GEM buffers exported to dmabufs are what I had in mind. I
> >> guess this would only leave the odd non-DRM driver with the need to
> >> add their own accounting calls, which I don't expect would be a big
> >> problem.
> >>
> >
> > sounds like we still have a long way to go to correctly account for
> > various v4l2, drm, GEM, CMA, etc. In patch 1, the charging is done in
> > dma_buf_export(), so I guess it covers all dma-buf types except
> > dma_heap, but the problem is that it has no remote charging support at
> > all?
>
> No, just the other way around
>
> DMA-buf heaps can be handled here because we know that it is pure system =
memory and nothing special so memcg always applies.
>
> dma_buf_export() on the other hand handles tons of different use cases, r=
anging from buffer accounted to dmem, over special resources which aren't e=
ven memory all the way to buffers which can migrate from dmem to memcg and =
back during their lifetime.
>

Hi Christian,

Thanks very much for your explanation. So basically it seems that
dma_buf_export() is not the proper place to charge, since it may end up
mixing in non-system-memory accounting?

My question is also about the global view for both heap and non-heap cases.
After reading the discussion, I=E2=80=99ve tried to summarize it=E2=80=94pl=
ease let me know
if my understanding is correct.

for dma_heap, we have the ioctl DMA_HEAP_IOCTL_ALLOC, where users can pass =
a
remote pidfd or similar information to indicate where the dma-buf should be
charged, as in Albert's patchset.

For non-dma_heap dma-bufs, we don=E2=80=99t have an obvious userspace entry=
 point that
triggers the allocation. So we likely need other approaches. We could eithe=
r
move more drivers over to dma-heap, or introduce something like
DMA_BUF_IOCTL_XFER_CHARGE, as you are discussing, to let userspace explicit=
ly
declare a charge.

Best Regards
Barry

