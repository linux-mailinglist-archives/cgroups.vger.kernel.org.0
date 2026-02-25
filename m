Return-Path: <cgroups+bounces-14380-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF8CJwBFn2m5ZgQAu9opvQ
	(envelope-from <cgroups+bounces-14380-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 19:52:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B1419C76E
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 19:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 610CD306B5B2
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 18:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B663031196C;
	Wed, 25 Feb 2026 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nta+qFyq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364532C15BE
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045529; cv=pass; b=UjnMlOvV25qv9wNs3qDN/h0DH/Pf205mU1TPFsXbYFj61XdCSYDw/wTIt6N25LBRt/Qbhnak2sJ5du6wIklco2llSe6xIT2n5XmTrskEp0rkE+64j8srzrF/MT/mp2HVVoNb0A/jCB5BkYusjV5aRKHMvUky1bRjWpuPulpjbNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045529; c=relaxed/simple;
	bh=4iVOkZnDaZKnxDwCxXuTasKFYGrTM4oqL6UDmqmgzC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCK95KMnK0GGccbACS9yu5Vu82aNLIicHiZWMCoAupKmpGfvAbIHn1waP6QI0+o7+RwGpCu2vTRHYLWi7ScMmr8FriyGwhzlj8wVmChMTpD6zOsbhYQranEf25KhpvvYFe7mFNkRREwhjK2j6+C+0rPQ3W/auVGRKYf7ElOMxk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nta+qFyq; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65f9763e8d1so211496a12.1
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 10:52:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772045526; cv=none;
        d=google.com; s=arc-20240605;
        b=FmSAfVYL/yhukJlcC9BfXmz0ZW+4hRPvI1Ee3a4Mmu27gO6djrcjjlBbfdapA2UTeS
         yoPt3FonRMbOGd14g76dnx42hrWK+exavP0fiubPtw3Zoy2IO4MI/7ozbh2WbE3paKak
         sQZp3p+FWOwzgzOK7cAVMB8F5vI2SHt9HaBNJBzJLpeDWUmcPlOKHcevynAofShq8tAU
         0kgMew7xf7bPgNvSRg+FzV8duzhrwWB3MSYkeXw51kAOP3bNl1Wdg2cy4hKkK+uBE4hN
         ftThJyj+3zjnFC1rptrdWWeSlG5WARBDgn1ZqQxqeTseIrBx6ALAROIUw6hB9TPRvX+s
         k9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4iVOkZnDaZKnxDwCxXuTasKFYGrTM4oqL6UDmqmgzC0=;
        fh=Z4mwt+QmDS22Vw7dJkXAXny45clcr1FOtNUfHXPIpWg=;
        b=RACA70HJdM5ALAHp42O3yULbvrg1Gjy/mbug6vR85eZZbUZrDsft6NbCWgrIkEKiFK
         2DrY9ul3kn6+MH9XZPzs/arDS5t3MjBqNM+mKa+vDgkq0ZDeUw2FDWgN0f07DKdQBGse
         5oP2Ifi5wKrKN9HWn7cDF0h3/aJHfql7yJ/9bkAOKE8lcrjjWkRKuPVBldaL4xKnMDhC
         TQGrLabniid1xV8QZfnSS9eERYt6l16NYn+eEFIqUNGW05ychvp+IWmJDALAil+mQzD1
         ST0D8qHYAGLg/2InVhkV/MbO9nr/VjUrFZis8aR+58f93X2cFOKYXouyKq9qdqD3XQND
         glUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772045526; x=1772650326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iVOkZnDaZKnxDwCxXuTasKFYGrTM4oqL6UDmqmgzC0=;
        b=nta+qFyqRdwcuTwP1ZxehGr9jEwMgrMDUbJGXGfQOayg6afR6vQzIsfdIBSAT+k/WF
         jyzRKP+zVNrEEsXG+/CAg5JecFI/brM4Oq6be3VCza5QYmL+m6IWelIIKrfDyR6W/n/i
         w+CCgQkz1jaIG6lUn1vkF4E8+IalEZvFxjCL/60RKayl0ztKY933/VltrbnFPj5dNUup
         zNPx+CZFKpystHA4bzNj359LhqZSawafJGM1cJqGWyw2fHFimfK1kj2qbGoNd5NkNvQQ
         Ilpx2LmQxvoO+iJ3XkSM1p3RK/3eQWxULAftXWLwo0W2dfy5Lkw1voYXiEOsckG5T9u8
         lEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045526; x=1772650326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4iVOkZnDaZKnxDwCxXuTasKFYGrTM4oqL6UDmqmgzC0=;
        b=aAKKgn9s/+k3BgmymX+ote3ld9gVEmS74A9hyRGspfoSEQo77M2BoOQqNemB6UDs/v
         B5tAApNZtl2ji7yt4P9Tc/oIG2La4KQmNgkNhD+OlKo15XjS78mjq/haXGQtQbeTMWnI
         mqkF0lbhk737q7MR4r5hv8w/nYmRwkM5vzqEJ+SnXFWqSKJIubW4ZdqTOH61fmvzWpPI
         hJHRyNU5YYqvP9ifm9ja+X+V8YA4LBVYgaPcHDGfIZ1QCxSnlMS0VBJxMpS/ihzoEJLy
         9Z9Ze/ZjVPUHOrNBWU5FCdYzFKP0HcAYt87JJs1hU/Pget3sDKVtHdu8QKnrv1rmdTuO
         J6fw==
X-Forwarded-Encrypted: i=1; AJvYcCXber0aAuECO8vbrcyzheKpf6mNFkDWQMNCwQaW/eBxkcuRdBUe4zGHbcGHggeChPYs3GKws56t@vger.kernel.org
X-Gm-Message-State: AOJu0Yx56RLIp776C8SFv9DFSNN4e8iGp683fqUX0fdyqmjP8B8onLJ+
	izvBILqVbk7W8cDg7j1tBdwQd/KOP7ukiNyapBfZyVqekXOZg1gypUgdZHWMMU3+uUBAWhS/14k
	0hLSW8ceABIrgFiMyDEbAVzegz03WNGSjjDELTcSl
X-Gm-Gg: ATEYQzz62OhUYgGoecxnNllknnMHznEfgZMTYUeuFTE7D1s5Drcj/8uPFJyVuomYdnR
	GYodAg1x8VkuWx+9+jcM78QU8x+LXa1BxE1XbTO/C4Z/V0S7ZQ3vjk5o7C8G4bfmUvR7wxJ5un5
	gryvZHy+xnAi/A7QW9z9muai/48wrn9VnXGt5GID4V6ZS2rn9N7/WQp7EjWxx0ML92U/M8DX3jZ
	y66/kXC6qrPeMLcJiQQmpvRyXFZfsRyARKiJRLGUoKih20Dd8/inh3TaDFm0FzwxPqYtWaT37EW
	Ot4et2w/owobO9fqh3XtYilwOqKOLLGDCipa7KdlLGMx0utwwybOknxHxoIK8vXPXrY5ww==
X-Received: by 2002:a17:907:9345:b0:b87:1be6:c707 with SMTP id
 a640c23a62f3a-b90819d9848mr1250245566b.17.1772045526051; Wed, 25 Feb 2026
 10:52:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770854662.git.ackerleytng@google.com> <18dbaf2ff9579b285d92f26b9a69e1e302f3bbcc.1770854662.git.ackerleytng@google.com>
In-Reply-To: <18dbaf2ff9579b285d92f26b9a69e1e302f3bbcc.1770854662.git.ackerleytng@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 25 Feb 2026 10:51:29 -0800
X-Gm-Features: AaiRm50XxXWOX9aUqCLJd9hStNskLlQ1-JFNXvuIWR8a-npd0KRSIcBGQr5XjmY
Message-ID: <CADrL8HWf4UN=eOi0HV7APRXR9Z_YFMrw703ocW57wPNjGRRh9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/7] mm: hugetlb: Move mpol interpretation out of alloc_buddy_hugetlb_folio_with_mpol()
To: Ackerley Tng <ackerleytng@google.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, david@kernel.org, 
	fvdl@google.com, hannes@cmpxchg.org, jgg@nvidia.com, jiaqiyan@google.com, 
	kalyazin@amazon.com, mhocko@kernel.org, michael.roth@amd.com, 
	muchun.song@linux.dev, osalvador@suse.de, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterx@redhat.com, pratyush@kernel.org, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roman.gushchin@linux.dev, 
	seanjc@google.com, shakeel.butt@linux.dev, shivankg@amd.com, 
	vannapurve@google.com, yan.y.zhao@intel.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14380-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jthoughton@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 20B1419C76E
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 4:37=E2=80=AFPM Ackerley Tng <ackerleytng@google.co=
m> wrote:
>
> Move memory policy interpretation out of
> alloc_buddy_hugetlb_folio_with_mpol() and into alloc_hugetlb_folio() to
> separate reading and interpretation of memory policy from actual
> allocation.
>
> This will later allow memory policy to be interpreted outside of the
> process of allocating a hugetlb folio entirely. This opens doors for othe=
r
> callers of the HugeTLB folio allocation function, such as guest_memfd,
> where memory may not always be mapped and hence may not have an associate=
d
> vma.
>
> No functional change intended.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: James Houghton <jthoughton@google.com>

