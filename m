Return-Path: <cgroups+bounces-8768-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC85B0A418
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 14:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB907A4F37
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 12:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B0929B78E;
	Fri, 18 Jul 2025 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HDRXubgl"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53EFEEBB;
	Fri, 18 Jul 2025 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841441; cv=none; b=ik7S2J65GCUICgnd/0sHkbgYyThlrzDpfj7bPbZI26LTZk8gSsnFeoyCWw6/yIqb8wc4Az875eg81L6gg+15eg5s4MyQHPwK4pmut3I0YnZxw8BZKDEvlJY+Yc11rkmCd6lgGIwqk/Y2ex2K0U+HFKKfRDQleK44+kfF1PpI1YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841441; c=relaxed/simple;
	bh=mseOW9jacXi6pM8pqP9rGE0HTBT5k58HBheJu2zl3b0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Xwg6YppwuKy+p0sN+8HhS5I5TJs/NmK/30u1XeZG5QPTlf/3DRdtzHAVlapkclP4xXSYLguoWpOR5DO52mlezWx0qxenCMj3RsTECRbvllBrcqUdK3hJLCbWtAiEOATxnev43qEGe6wS5a58W1If83gDSFEIfRzdMMt5COdweuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HDRXubgl; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752841425; x=1753446225; i=markus.elfring@web.de;
	bh=mseOW9jacXi6pM8pqP9rGE0HTBT5k58HBheJu2zl3b0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HDRXubglLBXr7IMMFYK56wpJOljtQKIfhc8QKckL82cGI9STIjgsXU0qLqaflcKC
	 5FOCf75ZLe1ZDqPJiLZkOik998PAusxyYjjC7HB7dVcSejnts5w7X8uXlNWo6+lyG
	 Z+khjgcPhL8q3FgXq85RQwJF5XwrAmhZHhuaCkBdPoxE6Xq2WQVBJx0s9XuGgbmho
	 xY0ACBSLGDoY07oHKcgc9yF1iWb8mMxleBVoYI3jOPxzjzlIweZ5AEUyZ11LSqtKd
	 vYpXeLMxzQ1dFststmd3DrmFdqpsB2UeJKMHGErkXFFszetbcgqrpZBGJKmMr/akF
	 EDDRlOgDyjdW85ZRvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.219]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9cHX-1uifUy2B7d-00vtsq; Fri, 18
 Jul 2025 14:23:45 +0200
Message-ID: <ccda6da0-5157-4520-a22d-437467ada3e1@web.de>
Date: Fri, 18 Jul 2025 14:23:30 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zijiang Huang <kerayhuang@tencent.com>, cgroups@vger.kernel.org
Cc: Zijiang Huang <huangzjsmile@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Hao Peng <flyingpeng@tencent.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
References: <20250718115409.878122-1-kerayhuang@tencent.com>
Subject: Re: [PATCH 1/2] cgroup-v1: Fix missing mutex_unlock in error paths
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250718115409.878122-1-kerayhuang@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F1+xwENFY4TvlJe0fQVwuOhdjFePYRKBuVhUfxlNzP9e8shwKL0
 0bdhG0Bxh7QVsK4e71TuWsTaANLO2ZGJbv9+JoSWV5jEUzqhWfMi5LY1tKJ7E43o8FlfEMN
 7QLGK40P8ySFBGYGgM6o4en9Eo/M0AaW4MHstYh5qwfXu8cinZqU3VvCibCb5JDwBiP/ISa
 rDznDZ7RAUe58dhAARmSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:788imBRHxQw=;0T4gEAsRJ/DvoXajCcWINu/gKfw
 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

> In the function, after acquiring the mutex with mutex_lock, multiple ret=
urn
> paths (such as returning ERR_PTR, NULL, or normal pointers)fail to call
> mutex_unlock to release the lock, which could lead to deadlock risks.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc6#n94


Will a cover letter become helpful for such a patch series?

Regards,
Markus

