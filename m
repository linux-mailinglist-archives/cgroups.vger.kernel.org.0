Return-Path: <cgroups+bounces-5813-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C5B9ED1A9
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 17:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DDB28791A
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 16:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB8A1DD880;
	Wed, 11 Dec 2024 16:28:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5B1DD873;
	Wed, 11 Dec 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934532; cv=none; b=nqFoebT4nwEgYoGJj6D1tZrvysNC4t6ng6XEzWR4hOzbvum62R1zAeY6vzL7ySMu56zVpdZyePz6CUicEbKU+dLdw5NNAeXsAr2n6WeuQdn6rhs/hDvAF0ikpkVqN8s0ckVXHPjiSKuQqvt/H1iRutK3ikpJUoQZd9KWD/+LrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934532; c=relaxed/simple;
	bh=OQRzu+e6XwhsooUrpJyOmagNflsiCNtMo0gU3jCRydA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wc1UyG1pMpuSuwsN6fmw3JrbeAjfa6knDI30neBMaE+7/iYKFYqKUziPblmwbILQVSeWrzQBD8JZECUmLDjWPF8LRVlBPZGDlWj9V1enxyPQsL8urNOdx8ht+f4GrKx1ogNvQHn7HsRGzTCOcQpxoiJaiKlyxZoWmuO83dzt/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tLPZU-000000000Vm-20UB;
	Wed, 11 Dec 2024 11:28:20 -0500
Message-ID: <c6cd075de18a277116a8908de6e0e4841a2dcae8.camel@surriel.com>
Subject: Re: [PATCH] mm: allow exiting processes to exceed the memory.max
 limit
From: Rik van Riel <riel@surriel.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Roman Gushchin	
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun
 Song	 <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org
Date: Wed, 11 Dec 2024 11:28:19 -0500
In-Reply-To: <Z1cyExTkg3OoaJy5@tiehlicka>
References: <20241209124233.3543f237@fangorn> <Z1cyExTkg3OoaJy5@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Mon, 2024-12-09 at 19:08 +0100, Michal Hocko wrote:
> On Mon 09-12-24 12:42:33, Rik van Riel wrote:
> > It is possible for programs to get stuck in exit, when their
> > memcg is at or above the memory.max limit, and things like
> > the do_futex() call from mm_release() need to page memory in.
> >=20
> > This can hang forever, but it really doesn't have to.
>=20
> Are you sure this is really happening?

The stuck is happening, albeit not stuck forever, but exit
taking hours before finally completing.

However, the fix may be to just allow the exiting task
to bypass "zswap no writeback" settings and write some
of the memory of its own cgroup to swap to get out of
the livelock:

https://lkml.org/lkml/2024/12/11/10102

--=20
All Rights Reversed.

