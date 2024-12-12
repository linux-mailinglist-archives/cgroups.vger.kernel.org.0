Return-Path: <cgroups+bounces-5866-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B776E9EFA55
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 19:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE7516C38B
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A48222D7E;
	Thu, 12 Dec 2024 18:03:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81177222D79;
	Thu, 12 Dec 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026624; cv=none; b=fqHvPKodeUkBlHbFS+RVtaYZ4kEQ548CXnmaBmj+K7zsUrkKTKOuONNsxRCvc6C2ad4+w7jmR9EWYfDXUecIMs7a5FH+z/TjZWxw7csWKeGFDB5eKEm7BkdEHrmgn0PTeowd+CWGPWfp6Cct7iMU+Wy0otI94gqzbObUnvWjS+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026624; c=relaxed/simple;
	bh=jPQdNH3PBHctwjBybj16jQiseDbWuguppjje7WiHw6I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uz8TgkIm2PfjdJSgzaMkV31Km771pQAARSk/dPPaAx6FEQy6IVpesTtQ3lwvywmd+gHkw39OacnRp2ZBi/Ql5oQH2eGRubS8UXdPEzu/NrbeaKXQJ4voUY0PCvEAeVbZtmb587XKDMI325NTILFq6Z78VHygZ1+BRB/ZRGKUqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tLnWI-000000007pC-3OQo;
	Thu, 12 Dec 2024 13:02:38 -0500
Message-ID: <0d9e676686db8e2025bc0c6dc2b55d17d9f16290.camel@surriel.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
From: Rik van Riel <riel@surriel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed
 <yosryahmed@google.com>
Cc: Balbir Singh <balbirs@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song	 <muchun.song@linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, 	cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com,
 Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Dec 2024 13:02:38 -0500
In-Reply-To: <4oxovutecmn7mkbbmbk3rhqudilivf6fkedvmcbcttmcspwebl@fp6pv2a45x6n>
References: <20241212115754.38f798b3@fangorn>
	 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
	 <4oxovutecmn7mkbbmbk3rhqudilivf6fkedvmcbcttmcspwebl@fp6pv2a45x6n>
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

On Thu, 2024-12-12 at 09:51 -0800, Shakeel Butt wrote:
>=20
> The fundamental issue is that the exiting process (killed by oomd or
> simple exit) has to allocated memory but the cgroup is at limit and
> the
> reclaim is very very slow.
>=20
> I can see attacking this issue with multiple angles.

Besides your proposed ideas, I suppose we could also limit
the gfp_mask of an exiting reclaimer with eg. __GFP_NORETRY,
but I do not know how effective that would be, since a single
pass through the memory reclaim code was still taking dozens
of seconds when I traced the "stuck" workloads.

--=20
All Rights Reversed.

