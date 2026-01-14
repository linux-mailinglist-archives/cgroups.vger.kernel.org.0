Return-Path: <cgroups+bounces-13173-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E971FD1E2EF
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 11:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1367304DD94
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8D9394463;
	Wed, 14 Jan 2026 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IwlTHtnS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5B393DD4
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387236; cv=none; b=ZsvJ8FbGou0Q7rbLPdkyt6b+whr0V5SKFyRZtFboBDGrqCGW9EN8hZs87bAwcJFixk40mdI7uVUVBeQmhL9xXPFsr8nGMozFZBJEzOnP52iuI85Md/7+ZDb/tiRMlFfqGbUdX5Kn9uTILLuac6NDtl9NvWk2gWzzz6gWQyVHW6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387236; c=relaxed/simple;
	bh=RaJUAGLfVK3GLoIHY7U+R2e58mWgeZcKAM/dE8Kkr+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOsI2ZdqPF01yVNGZlPsBmH48YcT+W3Gt0v8tB0fvMbqaKYHZ44KOsyfbFqhAluhJ7Pi8kLBTLuQJ747i3xjRC3EMxkh6EJe8wL25RW9wJ9dwouEVStxsEeESwoFOPnrkmbGpXW40tOTUTZXhEwQNnDxnRfli7QcmGhKx/yFMY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IwlTHtnS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-432da746749so2630252f8f.0
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 02:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768387233; x=1768992033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ciYpY/HXBU2ZSl7XMCNGTs1jM4GJd1oI7sRezLCFktU=;
        b=IwlTHtnSZYbX850/If8CT4S0Uac8V7JpWKvvyruW9kCPVaVwOQgn204G3yTnTbNyxs
         a9M46ZvCEhhyyYVhHUZBCmCt6eBYRCEdwT4VGmmO9cG9G0KCVMgiZ1shOKspIiZDWaTz
         vx+H3aHQ5WAHa4/v1joMWyFPzaEmZp1Mjojy8warUbslbMYi3lsHYW0AhbLLfaDM+6o8
         w3LIzkMR7H0YWPdbuFSSLglSW3He66ZCIMlEK2WVMhtggB1S7Sh1HuLGzWtgtVKxxkV5
         aKB15naaCADJSQqFPhT59n8LlTozc7BBgv4CHAm6/hhDjb3Jj9FIdtw/DjyEdVHzp15r
         y03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768387233; x=1768992033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciYpY/HXBU2ZSl7XMCNGTs1jM4GJd1oI7sRezLCFktU=;
        b=P3UNoutfa2cOBOiabo2BvHjzJ+iZOFgk//BWQSq1FOZNU33qf8TFYISKA2cGfGtayM
         j2ZsPG53T0uk27Bqt8C0goe0S4j+jRpCfaGA6TEh2WrVpEifpyAzAxfHyZMCK4N98pwW
         7OnVpicuwJnhniIs5yvJKe2gsv1LyJ5yDOXdv56Lndoy8ddtzqkWlEo7XyskYwDI404R
         5bmtpt5/r8wxzxcObUIX5Mx08JZBMFteMvxK40CCVqbV3WMuUr17DMW57jwEH1F3ioXj
         FnmF8GsOFxkb16trZvvoom2mU3UI65sDgsArCkJ3zh1APZgufpYNHmqdkFd+93LKovjp
         h1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVP+tNxaIgOAwHwoTAjnAd2d7iT3q97I03ajucajD6KB4M+Wv4LFb6fbMXk0EPZOPvpT9u1QVtW@vger.kernel.org
X-Gm-Message-State: AOJu0YyUGX3ujGp+7bNBF6YHrHNnalYAHa6lyf0r8mkusYp7bE4xP4eb
	XJk+JoE6kxBeESHKaWXHwUDjl/D/aJxPcm47j88KTS8FrmeyIN4TOXtQi7VVdD/RhNU=
X-Gm-Gg: AY/fxX5R92hyeU3v1dqCksIoVyKmCUfGH/S4bl97jbyt/a6uI+/HLo0K9EH9b5p+C7A
	hBkun1gtnwzWzn8F7hSLpjIorXaWcbDtVxR8RNLnmq/AFu4yET1PvFxapFDoAtmjYpxNO4vLF+H
	lb/Gxe+xYUVqYF81s/TgLg6awS9XcC5FsZZqLTWr+n4VEzmmsctujvoFeqQcw+FTQ0O6ygXfMQt
	1JQcyviJifLM27/LstZsNVf5XcKyxfEgvNmkMj7gLfHptdHCTmBVxWTGz/QwgBpqi5EcMWQNlSx
	stu/YTUK4pkOOhV10tJ4emKVMI9vN5lSIAvUEdLpefLG3SOloyuDcCwlXNKapdGzB9LwxrK0BuI
	HhaY6u1v2ywiyHNsCGhxqjYYkD9YZoUHuXd74WFGyEcGxX1lycHqrWOIWHsUWIeRGRX+vqIhZ5D
	lunc4A/TJik2K786L8OLHKCL9A1xVWLcocB7yg22+cyQ==
X-Received: by 2002:a5d:5d83:0:b0:432:85eb:a3cc with SMTP id ffacd0b85a97d-4342c4ffb53mr1869607f8f.19.1768387232768;
        Wed, 14 Jan 2026 02:40:32 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e1adbsm49711083f8f.17.2026.01.14.02.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:40:32 -0800 (PST)
Date: Wed, 14 Jan 2026 11:40:30 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	yukuai3@huawei.com, hch@infradead.org, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, houtao1@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH v2 1/3] blk-cgroup: fix race between policy activation
 and blkg destruction
Message-ID: <le5sjny634ffj6piswnkhkh33eq5cbclgysedyjl2bcuijiutf@f3j6ozw7zuuc>
References: <20260113061035.1902522-1-zhengqixing@huaweicloud.com>
 <20260113061035.1902522-2-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wbxdartwtj2aqf5n"
Content-Disposition: inline
In-Reply-To: <20260113061035.1902522-2-zhengqixing@huaweicloud.com>


--wbxdartwtj2aqf5n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] blk-cgroup: fix race between policy activation
 and blkg destruction
MIME-Version: 1.0

On Tue, Jan 13, 2026 at 02:10:33PM +0800, Zheng Qixing <zhengqixing@huaweic=
loud.com> wrote:
> From: Zheng Qixing <zhengqixing@huawei.com>
>=20
> When switching an IO scheduler on a block device, blkcg_activate_policy()
> allocates blkg_policy_data (pd) for all blkgs attached to the queue.
> However, blkcg_activate_policy() may race with concurrent blkcg deletion,
> leading to use-after-free and memory leak issues.
>=20
> The use-after-free occurs in the following race:
>=20
> T1 (blkcg_activate_policy):
>   - Successfully allocates pd for blkg1 (loop0->queue, blkcgA)
>   - Fails to allocate pd for blkg2 (loop0->queue, blkcgB)
>   - Enters the enomem rollback path to release blkg1 resources
>=20
> T2 (blkcg deletion):
>   - blkcgA is deleted concurrently
>   - blkg1 is freed via blkg_free_workfn()
>   - blkg1->pd is freed
>=20
> T1 (continued):
>   - Rollback path accesses blkg1->pd->online after pd is freed

The rollback path is under q->queue_lock same like the list removal in
blkg_free_workfn().
Why is queue_lock not enough for synchronization in this case?

(BTW have you observed this case "naturally" or have you injected the
memory allocation failure?)


>   - Triggers use-after-free
>=20
> In addition, blkg_free_workfn() frees pd before removing the blkg from
> q->blkg_list.

Yeah, this looks weirdly reversed.

> This allows blkcg_activate_policy() to allocate a new pd
> for a blkg that is being destroyed, leaving the newly allocated pd
> unreachable when the blkg is finally freed.
>=20
> Fix these races by extending blkcg_mutex coverage to serialize
> blkcg_activate_policy() rollback and blkg destruction, ensuring pd
> lifecycle is synchronized with blkg list visibility.
>=20
> Link: https://lore.kernel.org/all/20260108014416.3656493-3-zhengqixing@hu=
aweicloud.com/
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free=
_workfn() and blkcg_deactivate_policy()")
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>

Thanks,
Michal

--wbxdartwtj2aqf5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWdymRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhVEQD/afV2zf+Rm4nO/DjFak0L
o6/bKsjGcOK9qod/PjYkonwA/jRgRovZiExMPDT8mPeN7/5TqWA18WjB7AEnIDBn
I9YM
=5Buz
-----END PGP SIGNATURE-----

--wbxdartwtj2aqf5n--

