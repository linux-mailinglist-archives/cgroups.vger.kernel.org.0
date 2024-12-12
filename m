Return-Path: <cgroups+bounces-5857-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FBE9EE854
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 15:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C099116737D
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F340B2147E3;
	Thu, 12 Dec 2024 14:05:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074552135BA;
	Thu, 12 Dec 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012352; cv=none; b=QEgcORv/O0vLwxm+7rZF6uJa/40BCUg1fRAZNoK9MhQ60n8Iybyib386zJjvqCd9O1OajtivDTM5k5BOJwmEBJhCbOMPJelKo9UfsPU6j3PNAvs+55Xeitm/gWi92865PJcMKgTYkKYGwFZAa+XM4W65G05yXojPizb6bH5yjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012352; c=relaxed/simple;
	bh=TcIZDm13wJtBL+TFVJnf0QGwPgEPd0n35Nv5UXAYJco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0TsUy7gQ0iGF7iiryFpcoxFOU1RT9djArDbKc+I7fe6ym7zqhkevSXJT7CmOZ+IZLFNNscdboiF4EmuF+6hQrhRLhUta9Neqnp+qcoTHqLqkfXGK2R+ROPMclR9ZX+qrwpH+PIQSNpIOScEpifNYEwuMvGIqT+VL1vV+znWeRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tLjnA-000000005Ap-2F4L;
	Thu, 12 Dec 2024 09:03:48 -0500
Message-ID: <06afcaa995425c3c8b743485c6374ad92934f5de.camel@surriel.com>
Subject: Re: [PATCH] memcg: allow exiting tasks to write back data to swap
From: Rik van Riel <riel@surriel.com>
To: Balbir Singh <balbirs@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>,  Shakeel Butt <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, Andrew Morton	 <akpm@linux-foundation.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, 	linux-kernel@vger.kernel.org,
 kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>,  Yosry Ahmed
 <yosryahmed@google.com>
Date: Thu, 12 Dec 2024 09:03:48 -0500
In-Reply-To: <1974c064-4c17-403c-a0a0-a799cbdae2f9@nvidia.com>
References: <20241211105336.380cb545@fangorn>
	 <766a28a1-c82b-46fd-b3b0-fe3b6024f462@nvidia.com>
	 <1764e2fc8cff5b07aa9df1ae90a13986a3949250.camel@surriel.com>
	 <1974c064-4c17-403c-a0a0-a799cbdae2f9@nvidia.com>
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

On Thu, 2024-12-12 at 14:25 +1100, Balbir Singh wrote:
>=20
> I was asking about this change (this patch), I know that the return
> true will help avoid the PAGE_ACTIVATE path, but I am not sure why
> this function will return false if CONFIG_ZSWAP is enabled (unless
> zswap_writeback is turned off in one of the groups)
>=20
Some workloads are fine with incurring the latency
from zswap, but do not want the latency of actual
block device backed swap.

Having zswap enabled, with writeback disabled, has
been beneficial to a number of workloads.

--=20
All Rights Reversed.

