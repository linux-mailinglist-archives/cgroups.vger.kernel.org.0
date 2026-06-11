Return-Path: <cgroups+bounces-16865-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mfyEFyLyKmpezwMAu9opvQ
	(envelope-from <cgroups+bounces-16865-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:36:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F3567409D
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:36:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=Z4d4zdLs;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16865-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16865-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B953E3134757
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 17:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD22D593E;
	Thu, 11 Jun 2026 17:29:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383A383333
	for <cgroups@vger.kernel.org>; Thu, 11 Jun 2026 17:29:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198953; cv=none; b=rW0E1l4rLqfZAbyv3GS9qDz7tXIDYRsog/sA9OnxYRO7gB+NvRnwrmSWIMvCFA5UQLAt2wMjiLZdWoesbqEWF84H9YxCZ+GnzhW5wEd0CJriZZtubZVPQ6BPoSiCy+ZP+TaYSjeCBHiHalEm585oKRZIYeKZnoQCaqZ5Wj7/AYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198953; c=relaxed/simple;
	bh=0YgxZApGQtrhau3/Ql7XLU8hXCiCbHwTvv1sV+j+HlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8YVy0RvFfQuH5NXMGuaLnfwjKBpw81Fu60t6vyhlFssZVnP8k+TWONn6AdIp9EZhKE3s+uv3D0zVoKaf6s1mPIiio42YfV4UDqActP6GEPcMQvU6lDIwN8SEXLc7hx8U72b7FYWqhvMSfyxt8gTQvhtgaaFEDeC7fp7adK3zBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z4d4zdLs; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490a76757e5so399835e9.2
        for <cgroups@vger.kernel.org>; Thu, 11 Jun 2026 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781198950; x=1781803750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwvSRSSGkG+e38VEictoYQKspdcnIZMuedRgZfeDWIg=;
        b=Z4d4zdLsL/NERx9XrmyYEfHKP5ptXrUGisuDk6mJMN8YiOT5fRNQMQ4ZEdQDXIJRkW
         MIZlajL4Eunrg2wm1rZmk1QSV0GiJrFHI16OISmtBfS19tBI1XsntP93H2xgzdQr4Nry
         T7FaFRJGdJ0gklf3hBRUjP+ihRSMngbkoTDUNTd8Y98sx+xMR+te/h8Iz3l2QkSNM4XM
         /I0PHIxZVZVPQw+1aosnqhjnTlq34Qy8fi2qyCFWhtbkbh9gtQScL3fNkew45P+xJK3V
         6ad0/+SsbLsUmitGSW0EHzJbb0O+WyCz29JusIinIbooj+wJfvykRCJ97SlOt+qBiST9
         Q4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198950; x=1781803750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwvSRSSGkG+e38VEictoYQKspdcnIZMuedRgZfeDWIg=;
        b=S8v94XP4eRR3WQfJ27edcxEXzysPAoEG7/Uh+z8BlzN6Qb8O7Y+kOVA1pzQJ58VPV+
         u64RqJn84eoMRHF0qCY5M61/8c3hRDct5WZJvmVWUgVfuKmnCY1K1vzk5Q2LAx0ouq+W
         vNsXZXUcjVNtItmFS2Oe/J+qb/oxWVFdI8JJHThAZwJIkpgvCvkF7nmnonX+cxA522BO
         EbRQjwPUfKPeMpJU10cVOlTloEhkFeOzx83JQNNspfbW6ojI/4ZJr5pvtcYNPHl+5r5R
         9LPp1ifJkdSSCEngQ7kSMAFJw5c3SRdR/PHw3Husf8kTxRwNBotTg2C4vpqPF2ErIB9D
         0fvw==
X-Gm-Message-State: AOJu0Yxb4RHKUMBtDWnbLqyIgSjMAffo9oyCIu4H+fnyXFgSzEjOqYhx
	p2WOrSwYAaUzYGuKZS4S7ybMa0tP05JU02mo72GFMJvPOgi8wQXhW1vec19vq1xlzeQ=
X-Gm-Gg: Acq92OFh+0v84dQo8iDwnu8ympngVO9OKk2al+tRU5sZ8gwUbkw3fXhYXf+lCEAu+em
	JaEOYhWylW2AFpO4w4w5M6g+cEuHX3B3HRoKI6XUJ/yqtGJjIwv0TFZJLw7STOSkUwYLeZ2EyB2
	MthPdX7BmToGbeDtHWzqXJ31qilSkxUiaUx0n6n3VQFnBgcpdaYkP6ca8k7gk71ARcVmyIAZnDs
	Gcy7CZgwSPlpIWn2oYWqaPO8/3JIhOq5yyS1ygnWeqKUrLHgmwodZP7dEhSL1Wh13zc8/Hjk5ZO
	NAESkqfnHS+RZ77/tn/6BykfjifJ5m2pZEyLtbPRfJ+NI2r3hsGrp+pzL02Ftl1E8OJAdvGwF5z
	scS/yP0FIPTmii73vd8eP+Ay5msBCbIn0aiRx8ejkJeP2FuHMH6CWtu9GmGRuh1CUdGJ065C7DA
	G9gYRgzITYqZN50gn+gSgwh4wf5zto
X-Received: by 2002:a05:600c:8b5c:b0:490:c6c2:bdc2 with SMTP id 5b1f17b1804b1-490e55b6f4bmr54514995e9.4.1781198950220;
        Thu, 11 Jun 2026 10:29:10 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606c0c9c00sm440421f8f.12.2026.06.11.10.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:29:09 -0700 (PDT)
Date: Thu, 11 Jun 2026 19:29:08 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: cgroups@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, 
	pandit.parav@gmail.com, yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	tr0jan@lzu.edu.cn, d4n.for.sec@gmail.com
Subject: Re: [PATCH 1/1] cgroup: rdma: free idle pools during cgroup teardown
Message-ID: <airsaqxc0JPMMCiO@localhost.localdomain>
References: <cover.1781092143.git.d4n.for.sec@gmail.com>
 <9eb365a37ab83f38686007f8a61a656759d39bd7.1781092143.git.d4n.for.sec@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fm5vjrnfdbne7u5j"
Content-Disposition: inline
In-Reply-To: <9eb365a37ab83f38686007f8a61a656759d39bd7.1781092143.git.d4n.for.sec@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,cmpxchg.org,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-16865-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:cgroups@vger.kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:pandit.parav@gmail.com,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:tr0jan@lzu.edu.cn,m:d4n.for.sec@gmail.com,m:panditparav@gmail.com,m:d4nforsec@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,localhost.localdomain:mid,lzu.edu.cn:email,suse.com:dkim,suse.com:email,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3F3567409D


--fm5vjrnfdbne7u5j
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] cgroup: rdma: free idle pools during cgroup teardown
MIME-Version: 1.0

On Thu, Jun 11, 2026 at 02:13:16AM +0800, Ren Wei <n05ec@lzu.edu.cn> wrote:
> From: Daming Li <d4n.for.sec@gmail.com>
>=20
> rdmacg_css_offline() converts each pool to all-max limits so the
> existing reclaim path can free it after the last uncharge. However,
> zero-usage pools are already reclaimable at that point and leaving them
> linked until rdmacg_css_free() lets later device teardown hit a
> use-after-free when free_cg_rpool_locked() deletes cg_node from a freed
> cgroup list head.

That's a valid problem and good analysis. The rpool->cg_node points to
rdma_cgroup w/out bumping a refcount on respective css hence the
observed UaF.

> Free zero-usage pools directly from rdmacg_css_offline() while holding
> rdmacg_mutex. This keeps the existing reclaim rule, avoids new lifetime
> states, and ensures a cgroup cannot be freed with reclaimable rdmacg
> pools still attached.

I see this approach works (without explicit ref bump and complications
arising from that tracking).

The shortened availability of events/peak should be OK as those are
meant to be only for onlined cgs.

>=20
> Fixes: 39d3e7584a68 ("rdmacg: Added rdma cgroup controller")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Daming Li <d4n.for.sec@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  kernel/cgroup/rdma.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--fm5vjrnfdbne7u5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCairwYBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgBxQEA2rVEVlZsIW9V0G2vfZZR
vD1MlvtgdovVj6cOHe/3ML4A/0a1UW+YdRe6BaYYPMHh5cHho0xbeQnEbMU2V4pb
s2wK
=7hlL
-----END PGP SIGNATURE-----

--fm5vjrnfdbne7u5j--

