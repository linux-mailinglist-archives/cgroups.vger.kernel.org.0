Return-Path: <cgroups+bounces-16527-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KQENsfGHWrgdwkAu9opvQ
	(envelope-from <cgroups+bounces-16527-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 19:52:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 538D06237F1
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 19:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C183304B916
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 17:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0683DA7C0;
	Mon,  1 Jun 2026 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rryOr97S"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEE286D56
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336197; cv=pass; b=LNj3IHiGjOgB0gPgn73RCZk12Bf5pygcRT+OQ+5mZJ1ACI2NgUnYsxIKF5suwxgz3I6OmWRNcvPGYbuXjfiUEnw/s6yo+aig1G2wl29tJfPWgGaM1kixPeXt8gKXCiB+Ay4lj/8E4M+2Y7HfShrPrmN7bjeHbwWt3o0I82gyJA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336197; c=relaxed/simple;
	bh=MHMfGyIQO/wWrdZz2ftsSzh09DwykVOPctTnncxFW2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ve+Eg+FzSrSq9k3tOjJgCa4YojU0DftRl/1PFEyE9DA6whiJ+WWFbs2kM6hnqQwmjkpn4PUpPzB2SPyYjKXcFt+JS3ZUAb/GvxVnrsZVa1t5axjg+kxDa+Z2h792xV9xbDCSHKx4wEs/+Pc1B4i+bl77kOP1yBxAo+wWR3Q0QOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rryOr97S; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68c1653ea0cso4993712a12.2
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 10:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780336194; cv=none;
        d=google.com; s=arc-20240605;
        b=ZAS8MPasl3+n8l+cxXx9ZSfGGKclueA4CKcHisbXgwFA2BIaP0V8lRUXmqKtU7Y0aV
         QwXSS5Ye2gb7ECtJlwUGvVyq2mohSDg7X4ZTUgHDi9FgH7e6WOMqd2ona7VzABEV2bTV
         7d65u+q3GtA58l0ldteJhSFff/BggebzuRehiJ2hticOVBSDYNlLGtAusbEKvti0/OoV
         A01RGbvJTIaV8GiOr3aaGsc/l5MPkzZdMXZyO3fP++cu9OZGAPYQHSg50czb3HPjKHPF
         1uWEebFgpsRwMujvYKzfjVYVhddqHG5Gu45FNifCA0MBtVOwG/MSR6+p/BwbuZaxjLXh
         B6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pMR+vMx9phwXvzk3LCs0RnCPA1OW1RBGgb6+eYeQRiE=;
        fh=ptr/o4ygPNe1qDCGkwTPGjTidGtYQ+OB4zR6itFvEyM=;
        b=CCO2G4ndrQoGoJly5UnPZc45OmOxS02ZK90xkn8FXHmANAQiIvVvS1A1D6wpiOW/zQ
         DAnH1H/ZXl777Q4YmlIKFuot0MJ57v3kRsLWQCp82QAsTuRgmhB4bw5QltICP+bQx3z1
         ghBX4p8pV9qCrL8a1rGFryt01Vbh8fEnRaQgM5+Cp/zWUnsRCaI16B6OxbkJyMduF7Cm
         Xo7ImUCqMm0LfHMPeCwfdwe/pqgXkqcObaYV4DrJH0M+sKc0xw/SAUGJdE2MHBHiChW2
         BLz1M7WMrutwOXRt1uA5f/e+i6VmB3VjTxOZHeerhAXmzhW9MZoSTGkGVjeDmeSOx2gj
         GyeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780336194; x=1780940994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMR+vMx9phwXvzk3LCs0RnCPA1OW1RBGgb6+eYeQRiE=;
        b=rryOr97SQy0Yvp2+DlBXsOoeF8EjhQ/KHkErallpDjCJTM8vVvnrxje8waUS3RSM6W
         K44IiWvhr+V7Mr1GrVuyd0oPesAgAbYIEwnpHi4ZUzoD45LioXHsBw9NsL+heiwigq4Q
         jDS7J1LfYzKtBTbBUkElNuXKSFoYll0jTvdQ+h1Y1QVtLGUek+o1BsBc8nxV0CMb9q+f
         uSQgTgxyE327kQkFtC4U9+JNVT0j7XQQ+aEzSl5wP/FhIwJxmfqHxax4oX+3vUO4HcQ9
         gcfswYK4PLHucfo6VsL0zt1lYOWydWR49L5Ioiu/uehdq9XGLtyM+xwnzUkRN20QnWVe
         CKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336194; x=1780940994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pMR+vMx9phwXvzk3LCs0RnCPA1OW1RBGgb6+eYeQRiE=;
        b=ID7QD+SvdznBC+9NHN6odhtckpyFmnUJ5Y0dUB4qpOZ+3brv/yKtVaCBdfeNtCOKMi
         4pg+8d3Ioy7g4VlGdLF2W2MGY8aXCs3hg6baQMmn4AP4qQzNbISz1n43ajsPDEIo51Ud
         1scMksA5LhN1nRC07nNKdJgB/s3mb5WMUNXimPh/693KyLoV6DGpoyHzkdXI4tOk3YHt
         M+aMw56q2GZx9ER0YGDyxXubWawFy0sjlrb0fhGnDBRwTA3r/jX41+ezhtZ2rXgXeq3s
         yqjZs/Vut06IxBR3AI+k1JHdg8Ff75VIxhKde5LYcB8LJ9LzzfkQaAcJXPIx51Yl7Y9Z
         ILpA==
X-Forwarded-Encrypted: i=1; AFNElJ8wPEOJj9iV0aGQYwB6tJLXZH5eqZY8P+m+JkQRGfdTLNeYqkGJHtxASxhi4y+Kmp3sfNz/CdIB@vger.kernel.org
X-Gm-Message-State: AOJu0YwyL/6DI/qIDUMhXQH5ILMfyqhGAhhS7q84ZWApfTcBewHEqCDV
	kiBWMv+z5LdoNyLr5hp83QDxUpJmi3zqd+bu5OzxFr9cseBO1ZKE4IHzElY5dmatg8+OnGsfrVe
	dk4gIs1u7zHAN+ZI7nFcOFoCY+RjeY+I=
X-Gm-Gg: Acq92OGo04q1QBmfKxFg7XScUzXmkWNscT/IU+Feo0nioOGnmwBkuSPcRZWqdx+h0Ot
	fg6QejJXmrztnp7dVwtEqOnFIA42G1QgRPa5ecmMOA/0YwtqvSHoxjFJ+u4n+KFSNqZoYZgCt8I
	SgqPnpcP3Z/341H3EVcEapep7QdKo7+N874lqRXH8obK0TrFbPUEuN7O4J5+qMWz+40kSdM7vQR
	klVm9CxgnuuPyMhVZx+2mF/c3smRueTC8Ljd8YzzDcCJmSPzvqQn/zHOeIaWo1Y75gdC416nEER
	xRSoGsuOTOh2R/E8zOpr5hMWtOczTq+rjmgOHnuN5aN3rf5b8v4=
X-Received: by 2002:a17:906:1ba9:b0:beb:e13b:b3eb with SMTP id
 a640c23a62f3a-bebe13c09c8mr420086866b.9.1780336193926; Mon, 01 Jun 2026
 10:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com> <CAKEwX=NNNf0KCZC0ph7VRW0gjnbXd4W5NKEaHM4XzPdN03Ek3A@mail.gmail.com>
In-Reply-To: <CAKEwX=NNNf0KCZC0ph7VRW0gjnbXd4W5NKEaHM4XzPdN03Ek3A@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 2 Jun 2026 01:49:16 +0800
X-Gm-Features: AVHnY4KkMWDCgqvQ0VtgzLPCLTVcd18CUg6LbNn4WT1rDML5IaDfG1WZK2GBXNs
Message-ID: <CAMgjq7CT0ccCnzmpRGjTGPnNEn4eK==5A-OFbr3+p465dQMH4A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Nhat Pham <nphamcs@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com, haowenchao22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16527-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 538D06237F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jun 2, 2026 at 12:22=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Jun 1, 2026 at 8:56=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Mon, Jun 1, 2026 at 12:34=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Thu, May 28, 2026 at 02:29:24PM +0800, Nhat Pham wrote:
> > > > III. Follow-ups:
> > > >
> > > > In no particular order (and most of which can be done as follow-up
> > > > patch series rather than shoving everything in the initial landing)=
:
> > > >
> > > > - More thorough stress testing is very much needed.
> > > >
> > > > - Performance benchmarks to make sure I don't accidentally regress
> > > >   the vswap-less case, and that the vswap's case performance is
> > > >   good. I suspect I will have to port a lot of the
> > > >   optimizations I implemented in v6 over here - some of the
> > > >   inefficiencies are inherent in any swap virtualization, and
> > > >   would require the same fix (for e.g the MRU cluster caching
> > > >   for faster cluster lookup - see [8] and [9]).
> > >
> > > This could be imporved by per-si percpu cluster. Both YoungJun's
> > > tiering and Baoquan's previous swap ops mentioned this is needed,
> > > and now vswap also need that. If the vswap is also a si, then it will
> > > make use of this too.
>
> Oh and the MRU cluster caching I mentioned here is not the allocation
> caching. It's the lookup caching, basically to avoid doing the
> xa_load() to look up clusters for consecutive swap operations on the
> same vswap cluster (which is the common case with vswap). For v6, it
> massively reduces this indirection lookup overhead. Performance-wise
> it's an absolute winner, just more complexity (because I need to
> handle reference counting carefully).

Ah alright, that's interesting. And I think we can keep things simple
to start, since sensitive users is stil able tol use plain device this
way.

BTW maintaining MRU is also an overhead, I'm not sure if the lookup
pattern always follows that?

> I also just realized we'll induce the indirection overhead on
> allocation here too, even if the cached cluster still have slots for
> allocation, because we look up the cluster (which is basically free
> for static swap device, but not free for vswap devices). Might need to
> take care of that to maintain vswap performance (but it will then
> diverge from your existing code...).

That part should be indeed coverable by the si->percpu cluster though, I th=
ink.

