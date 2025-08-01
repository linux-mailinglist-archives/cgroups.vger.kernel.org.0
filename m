Return-Path: <cgroups+bounces-8971-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5E8B17D11
	for <lists+cgroups@lfdr.de>; Fri,  1 Aug 2025 09:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D57B1C26B2E
	for <lists+cgroups@lfdr.de>; Fri,  1 Aug 2025 07:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E2B1F4613;
	Fri,  1 Aug 2025 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kms3koXp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7454A18C031
	for <cgroups@vger.kernel.org>; Fri,  1 Aug 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754031634; cv=none; b=STP9CQJKH6fGGRbij5F1/ixl5+65+3khHoFqbdN3ysh0zz+2gYv2jS0urL0aPFPDWq9pZKY4nh6ej9qeCx6LKnMFKNR1RWbLsxWg8tl9WbkF+OSe1y6PHc6zmynwX6CJ9ce9ZhqqTmtXfjzt509oIhSXRg+R3LbY8xlzFVoJM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754031634; c=relaxed/simple;
	bh=lOdACm39398ZkN2lU2UZXEP/gEQUsiO20iyEfrmnlog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl8BOPOIL7t6cvgx4FHs4Rv6kqi9Btc2IYWsMlI3VbT4AtN38nux2CDLMOl6kTm53SGk6E1WzT+G2kXjgx75oMdCy0YU0P83JfVFlRECCVF/1vqFQW4/WhC/YfIf+6pS+fiK/6FfvAUBobkAlvOHHmB2fE/MluXQbUmazKHHlm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kms3koXp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b788feab29so728061f8f.2
        for <cgroups@vger.kernel.org>; Fri, 01 Aug 2025 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754031631; x=1754636431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOdACm39398ZkN2lU2UZXEP/gEQUsiO20iyEfrmnlog=;
        b=Kms3koXpvqhwr78UjSZurzI/4Qba/l7wa/LoZatXgG58B381rD7frdRu3rXKpkyO3S
         701QdGwW1hwfMVu9fQJigm8BUgDlxV+ITq6QmWifAcvAJlFgU2tRfVV9vyr+42D6Zilt
         xxpPmLrhGiU0617mdfn+VRoLnRUVJtjGPY7Xf8iIzD8KKGOlFTr0Uj5ywSG9hiWRyytR
         DZE3C3a2DChwmFPqFJRQYlak9u8h8lr7Oz0CYIT6NrDPne8Va6uf1c8978H+OxThiVBc
         ACdAtBfillTFJJfiXyBuv3FPDdlHQSNgngSs43dADLbVpwUf0aejWs6Ugr9gBXaDUKRX
         rYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754031631; x=1754636431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOdACm39398ZkN2lU2UZXEP/gEQUsiO20iyEfrmnlog=;
        b=kH8kgEMiUWDe3U70UmBxjEYcJhedvMByv47APsNZfx0AbXqcrcJ0YMiBL6QmSGI/ak
         SRFfbbCxbrVNBs6+dD04NnAT8WXqIqrYnWv2PXrrkWa5AZpah+oh19s29Q07ZVseFp6P
         se4k4w0Ruh3k9qAzUI+2o3zt68oWzegt6DLTC8UMUzdbuvgUwLajh+PF/75Y7vyySuCr
         rj2N8tGQM5CBgfCRUcT3wj1JG4UADuPFzQ+eRyzqop852+2HW7v69xM55eB7J353bjO0
         lFr4LOzEUk+dwu6aaJsKaszB3tlhRw9civfsigm1ezqy4xUhw2r2dw2nV6cKvyo1KJdR
         msjA==
X-Forwarded-Encrypted: i=1; AJvYcCWlqUJ5F+xM7kbCSagEhHss3YMWsmjlTL6uvhZuOFBLaMjOj94CcOoF3fCG4WafG06U5Yx7zPIn@vger.kernel.org
X-Gm-Message-State: AOJu0YzyWoasj6x6G1m5+++Xe7I0zjWnIgYMNmLOCiTzz0gk0daIU/kV
	D3Pvq5SUlOZY7Bs95aN3yY0SVQPg5YSztQ6NtB5ETivb5NmxjIXuSjYQtlbLN9tH2a8=
X-Gm-Gg: ASbGncs7LCRkP5yJBzSAHJcoA5+t7hW6UpW1v8sdbAPAQ7DM6XacfELL/f6IS4CCYnd
	57i57WDu2TEeruThfActtnBgXiipbhzUeRSb5EX66FBzQaxTq3F1osjbUig89hFQsyaLmIO9ysZ
	JVzGrsJ7P/GCk1YUrsLbYC2g1X1fOWIL0fIT8srNRBmtmwOpKDHNYx9/OMZPNE0V5tvbl7UdYFw
	hcFZOM/N17ALHyG7xGXlYEkryNLAuIoD5azAEodvQbWD3aIyGNLh7bKTmbeiyaOAA9A2hC2yn8I
	nZJjYXt44KfUMoR8R81rgdPf2WQxTvda4U6ISnq7WBI9d6wbGASLVyPhPNMC6+eRvS/jq4AzNN9
	BybCa798Ad7p7fYQ1jR2JyUmCabRmOaxrk/uQ0IrAxQ==
X-Google-Smtp-Source: AGHT+IGpo7vCBRl1+3LNZgziFjvZCIsV7Fz+AW0zycTpGAfpOewwiyDA2ffkkvBUhcmMNKx/L1CjEA==
X-Received: by 2002:a05:6000:4212:b0:3b5:dc07:50a4 with SMTP id ffacd0b85a97d-3b794fbeb87mr9254839f8f.2.1754031630614;
        Fri, 01 Aug 2025 00:00:30 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47ae8esm4762632f8f.61.2025.08.01.00.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 00:00:29 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:00:27 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <ekte46qtwawpvdijdmoqhl2pcwtfhxgl6ubxjkgkiitrtfnvpu@5n7kwkj4fs2t>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
 <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
 <CAAVpQUAFAsmPPF0gRMqDNWJmktegk6w=s1TPS9hGJpHQzXT-sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3o5euvcxbwgpnyi"
Content-Disposition: inline
In-Reply-To: <CAAVpQUAFAsmPPF0gRMqDNWJmktegk6w=s1TPS9hGJpHQzXT-sg@mail.gmail.com>


--x3o5euvcxbwgpnyi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
MIME-Version: 1.0

On Thu, Jul 31, 2025 at 04:51:43PM -0700, Kuniyuki Iwashima <kuniyu@google.com> wrote:
> Doesn't that end up implementing another tcp_mem[] which now
> enforce limits on uncontrolled cgroups (memory.max == max) ?
> Or it will simply end up with the system-wide OOM killer ?

I meant to rely on use the exisiting mem_cgroup_charge_skmem(), i.e.
there'd be always memory.max < max (ensured by the configuring agent).
But you're right the OOM _may_ be global if the limit is too loose.

Actually, as I think about it, another configuration option would be to
reorganize the memcg tree and put all non-isolated memcgs under one
ancestor and set its memory.max limit (so that it's shared among them
like the global limit).

HTH,
Michal

--x3o5euvcxbwgpnyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaIxl9AAKCRB+PQLnlNv4
CJZtAQDyxJKYOwR+G5PupdcFpWcem+e2vcVjekmcUSnAefb9SwEAmlcDbWaK+JWZ
zsvVOKp5n3NQmuq9ouqRPxwf+gbdlAs=
=J+oe
-----END PGP SIGNATURE-----

--x3o5euvcxbwgpnyi--

