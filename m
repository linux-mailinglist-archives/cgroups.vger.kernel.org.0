Return-Path: <cgroups+bounces-8482-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01D1AD46C7
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 01:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D119E7ABB2D
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 23:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B9283FD5;
	Tue, 10 Jun 2025 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz4GMpfD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651621D5AF;
	Tue, 10 Jun 2025 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598387; cv=none; b=mt3YwA2TVy9GwYQ3l5XhHFAHiHukD18y6/lq7bm7IW5bSoExHUhIO8GIvq5KkZbP4cO6pH5PAykMlwMj1RydNIEcxidra1fgsw9rpnnkogv13aZtaOGPRvY03+lVWCCRNXTHIe22XMoRz0SyRPKBjnIzDIpnYcZjb11Vpnkqm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598387; c=relaxed/simple;
	bh=mxGZjTRvPVcLhqGokrdih0Ia5bs+7zm4I2xGiIFUsd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFYqi7vX3r25bTGBC2mTcQW46Lq1p8cdkeiHXTUbW9dLb80BLP0REGuLRsSa+NXkU1JcOqmZcLowvOB+nWTzG6tvrF8bDTUyG6e2diRm9A6/ZZYnS9pcr//A43JfKmscjf5E/mJwvUJ+DjCDv5sLqyX1VYbyejfcUb3TIYmQ4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz4GMpfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA637C4CEF0;
	Tue, 10 Jun 2025 23:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749598387;
	bh=mxGZjTRvPVcLhqGokrdih0Ia5bs+7zm4I2xGiIFUsd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mz4GMpfDr84Fj0UJvxn1bpFSiBraixonk9d0naNaahLGl+2J3bRwuNNw5G9p1qSSz
	 mksxu8SA/YWpL74R601ohIj4y5vp3EWdNwb4LM8m1HQJouxYbFsFCOYuxUDS6YtkhR
	 eeFVUZnH+jDXQAWQ9buThneFp0DB4cw5GGHoR0F8Nd0rHBNXXmeN+jXaAfFwdE8tIm
	 l8w0eSw+TmMkln0ZY0Zt84VP7ZwGWV/iyyq8PlYe0rEzusNf1WFQK2Ne3RTyhapr0K
	 xvMU68ZdAXu2ORVtDiKR/urvKodbxjYjFUKAwf+NZEhS9ts5vNQNr6QU2t8sLJybEk
	 C3p8UE+B8CMIQ==
Date: Tue, 10 Jun 2025 13:33:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/3] cgroup: make css_rstat_updated nmi safe
Message-ID: <aEjAscULhJReBRjn@slm.duckdns.org>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
 <20250609225611.3967338-3-shakeel.butt@linux.dev>
 <aEijC1iHehAxdsfi@slm.duckdns.org>
 <35ppn2muk4bsyosca4nxnbv5l6qv4ov2cxg5ksypst5ldf5zc4@vwrpziws4wjy>
 <aEi0FplA6eZUHF01@slm.duckdns.org>
 <lmjsy6fp25bhno62mg3hz7z2ysggg4z66yhhpd6mxpzksthsbz@55hjcvz2jymh>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lmjsy6fp25bhno62mg3hz7z2ysggg4z66yhhpd6mxpzksthsbz@55hjcvz2jymh>

Hello,

On Tue, Jun 10, 2025 at 04:28:23PM -0700, Shakeel Butt wrote:
...
> I was actually thinking of using this_cpu_cmpxchg but then I need to
> also check for CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS. However if you
> prefer that, I can try this_cpu_cmpxchg in the next version.

Yeah, I don't think it'd make any performance differences, but, provided it
doesn't too much complexity, it'd make things less confusing as the
construct being used aligns with the problem being solved.

Thanks.

-- 
tejun

