Return-Path: <cgroups+bounces-12798-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 247D9CE6679
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 11:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B021302B11F
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE432F4A0C;
	Mon, 29 Dec 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cwzNfY/x"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC42F3C0E;
	Mon, 29 Dec 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767004981; cv=none; b=ow70eKNoifsWpQI4OvsTNBqpgK8GGdsp4POb7KbdLoVS0gTcZ5Tul0CeHghjwzcHvX7s2qL95pbkaqkVuF4Pp65g2iRdEVo1bvEKSzjfrt47VVGmaL72gUna2ZOkAQ0vmfYudUmN4HyfohxtUtGqJFltaoBdkqzoxzQVJqmQccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767004981; c=relaxed/simple;
	bh=cO4aZ4iVA+7eKwHnry4hgpa2mXWtxl8mp8VEmcMiE64=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MBh8lznPqvb2uGO9bGTCIvC4EquEfe67i7wneodP5OdfjNZTuG9ucLTQou6rLKiZGjrWFwZUGAOlNfLd1dCxafxlf/hw8JKAZCkBOvgC5fJzFSKySqijljlPePu8l8/ng3eY6HQEZHAWvo5P3/gRa9VQFmRF9EI3sUPbkNatavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cwzNfY/x; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767004950; x=1767609750; i=markus.elfring@web.de;
	bh=cO4aZ4iVA+7eKwHnry4hgpa2mXWtxl8mp8VEmcMiE64=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cwzNfY/xIANdOpBQDwkNEAJ6OqSBwIKlg84PXLTN7eVpMSj7KMVGdW7+aKtUcS/r
	 C9ehiUbU0DDvb6Jpf+Mg8s/dZI3twjQ+yTT8IRnuYUoXH7+VFIJgo1mtFiBe6+Z8p
	 pdVBcPdZPPXbJZwWfuNYyUNS+JzXDRpIeBPsdxKuoWQqd86fE2lSHFxr4ukzxlC0s
	 +MhhjYumR6K/BYoTtnVrbAYeSqVMpwN0KdaUpeVtqVa4OBGSPCs6/lOIASfKm35ya
	 8NSL80WqC05zpeg/ubMXoEET6p1kuAlPo11vveLCLhCWebiDTwIE9bBUSRJxVlb+2
	 Ge7llqmjktG7u5aNbw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.231]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MY5bV-1vQUUF2SL7-00Jlwu; Mon, 29
 Dec 2025 11:42:30 +0100
Message-ID: <6b4a6310-ae36-4726-88f8-46b749c8163f@web.de>
Date: Mon, 29 Dec 2025 11:42:28 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jiayuan Chen <jiayuan.chen@shopee.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 David Hildenbrand <david@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu <weixugc@google.com>,
 Yuanchu Xie <yuanchu@google.com>
References: <20251229033957.296257-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH v2] mm/memcg: scale memory.high penalty based on refault
 recency
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251229033957.296257-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mONcxwL8dcOUof/iuLBHR1VVvzj2He8VP+9VNSYi4yhSe+wyvrt
 MvsGFpkSpIqFEHMXd1ZL52fs8XYv59DwHTEp8xMWyBbjn5dr8tqMFWh6bT3Vjzkx2Tz80jR
 CRsrPv0DkTSg2IwhV+pmZiN5gidlDdtRseVTBrHI1d46oyL7IhOSBKip13jIEN7DQGzeatH
 GNfQbV7qROTL3ukTa1qmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W5p+PrDPuck=;OlSmmtO/pSPpgC196z5rOEnGx5t
 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
 cqPRpHjwtqtsRQ96M=

=E2=80=A6
> We observed an issue in production where a workload continuously
=E2=80=A6

Please avoid a typo in the summary phrase.

Regards,
Markus

