Return-Path: <cgroups+bounces-8409-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF40ACB5E8
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 17:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345B7A21131
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEA822B5AD;
	Mon,  2 Jun 2025 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SqUXdBcl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BE22A813
	for <cgroups@vger.kernel.org>; Mon,  2 Jun 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875537; cv=none; b=bvKG2KOp10mfTagDHhbjRqYOQfT9Ou/gXaursPO06Mxw0TyheiSnPCNgYfW4cGG9UcclvjjvVUPpktM1cftcuFeCg/KJgg2JTf3jkNbquAY2qo8CIpimlFl3+OrbLp7xlXatOBOWEUdv5mvkLZqvY0/Xq2vH5KWG3O2VgdnbvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875537; c=relaxed/simple;
	bh=qf8xhx/P8U6G8/9ptr04NOdlpjybtwrNiRY9oxiFgCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgHuktr11kSfjHN01OxBRQdwQIZGG1nf4Q6rJEhwEDCtXKLSR2SaWZXbqwQDHtCbn4L9PnVu85hoXUkvRQfi4VzxkiP/H6fNypBIYJBf8u4oLYRs4Ni2TWakEqVvb9pgT7nuCxSxvSB04Tlzelm0hXXqfaTqUXhQQ+AFAKkEVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SqUXdBcl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so1351618f8f.1
        for <cgroups@vger.kernel.org>; Mon, 02 Jun 2025 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748875534; x=1749480334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qf8xhx/P8U6G8/9ptr04NOdlpjybtwrNiRY9oxiFgCo=;
        b=SqUXdBclmE5O6zjByqrDF5y6WZUKgd5oCUClVCr1PU/WT5pvhHGAcNtGfrq2onZRwX
         0uFfUkXEhwN9lxbIrn8SxKwkmjYyL6fSh45cAEKVxTr7DU2+QnxJK7hYLBK1Kj2r1kxJ
         PcEepwIisICvcGqvHem7trQR7I6rMAEBT1FYYq/ZxmPApKORDS9Scg4EGvWW9BnLGdLF
         RNYI/8AOIIO/hr61h2iatoXsGjGpHZS8orBmtlfj7Ivysi93Za8SWvyhbbD0ZgHrOLbN
         2B+Sq3Gaf0MbpLVpC5gl2nb7ASFDTz0S/6HOzOSDaO0fQSPYvOqFjlpLq50CWlkPQdKu
         KEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748875534; x=1749480334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf8xhx/P8U6G8/9ptr04NOdlpjybtwrNiRY9oxiFgCo=;
        b=mFV9undpsPRTm3lX7nnKvimPTH5alRXDJQfR5egj6C4bYbJW7dpCB+R0Mo9YmVKPn4
         lxXZrxeh0WSTrgequczZN5gpzeHbfgsl8h2M3KI1Yvcmmh8G4OuqCE9RI3Ld6NWcC5D8
         erKCb9WOJVrm3vcxeiD7BmbUg4d9thc9TAg5pCj/HSVR1mtlZovkP0ykozae9rag9EBQ
         30DnM2z/sZfrCAATP6V2o+xxqf0rTueJ8ayS0sjfuofBxaD8j5MczyznAxy/llwPO3HR
         VkIIKaY2l+bxQmA4pwQKyzcZzkIWbTFfj6adcR8NM195nMGVwa6FkdRPlL91rR0Z7MrF
         Qzow==
X-Forwarded-Encrypted: i=1; AJvYcCXwFNuTQQxE3Xwa+R3v4j/wM1Gko0+t+ohVOet1JYGG2slQH5GgwnquqmH9880KvUWJxdGSKuLw@vger.kernel.org
X-Gm-Message-State: AOJu0YzJS3L9AwEGJPwnYMNy9NskWmPcg4Rb2X4nfC+NaWnBC3omQaZe
	woc8ToH7fQJ7H9esgK0BjHqGTlSKqfT6YSzaC0eP7yi1ZHtYRvVtKmlmj7Fd0mOvxDc=
X-Gm-Gg: ASbGncvBU3jWyNmEWv6+i+KkoCyX1igWUPIt9vsII5GhipSox/EOuSOH0Z2jrlp6Kk1
	1zJbvOhY4oHK0p6zFl8nurXarvNFCSNf7UVxncaVC+JuVUChLmUw7JZ51CAo4XDUwYnSbAiQUKh
	qvCd3xZKNaA3OmnY6dm7OpqixtyJELUooJia2xQ+ecuD+gMNb4JgZ7zlM6iJYAK7L1VmNLV9S4X
	baLbDTDQvFU7eTXRrUoxW+L4kdnHR3XIhHBsI2sxss7qNpb7hPGtSrM70sMop7OtQzdSNqORLy0
	ivObd7bk95Nw2Sg3SXJV966LHrBblxkNQIsdZ5bP+6IclpVcIGN85dYroWayOMTQ
X-Google-Smtp-Source: AGHT+IHhOLPK3wy+JJwKSLsDWydjB4lRADzhyLKMg8NOlNveSdw1CmJFuZPFx5ougj5v+ByLkjCMxA==
X-Received: by 2002:a05:6000:40e0:b0:3a4:f41d:6973 with SMTP id ffacd0b85a97d-3a4f89ad29emr9750624f8f.13.1748875533919;
        Mon, 02 Jun 2025 07:45:33 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00971fasm14937650f8f.77.2025.06.02.07.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 07:45:33 -0700 (PDT)
Date: Mon, 2 Jun 2025 16:45:31 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v4 0/5] memcg: nmi-safe kmem charging
Message-ID: <gqb34j7wrgetfuklvcjbdlcuteratvvnuow4ujs3dza22fdtwb@cobgv5fq6hb5>
References: <20250519063142.111219-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7o34cr4hrs2kk3cc"
Content-Disposition: inline
In-Reply-To: <20250519063142.111219-1-shakeel.butt@linux.dev>


--7o34cr4hrs2kk3cc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 0/5] memcg: nmi-safe kmem charging
MIME-Version: 1.0

Hello Shakeel.

On Sun, May 18, 2025 at 11:31:37PM -0700, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> Users can attached their BPF programs at arbitrary execution points in
> the kernel and such BPF programs may run in nmi context. In addition,
> these programs can trigger memcg charged kernel allocations in the nmi
> context. However memcg charging infra for kernel memory is not equipped
> to handle nmi context for all architectures.

How much memory does this refer to? Is it unbound (in particular for
non-privileged eBPF)? Or is it rather negligible? (I assume the former
to make the series worth it.)

Thanks,
Michal

--7o34cr4hrs2kk3cc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaD25CQAKCRAt3Wney77B
SQiTAQC/eAKARy8kEU7fP7GCMHE1+7v+d2sSxmXDyaCQ6wqidAEAu4q3hQa6TLAp
Pqns7WVL19JaCImjilT1rPY77Jv3aQo=
=nNTq
-----END PGP SIGNATURE-----

--7o34cr4hrs2kk3cc--

