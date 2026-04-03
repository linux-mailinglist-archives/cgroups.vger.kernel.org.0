Return-Path: <cgroups+bounces-15172-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKyiIZn2z2lT2AYAu9opvQ
	(envelope-from <cgroups+bounces-15172-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Apr 2026 19:19:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32862396ECA
	for <lists+cgroups@lfdr.de>; Fri, 03 Apr 2026 19:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DDAD304B34D
	for <lists+cgroups@lfdr.de>; Fri,  3 Apr 2026 17:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1A43CE48B;
	Fri,  3 Apr 2026 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQpHbFRT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969103537EB
	for <cgroups@vger.kernel.org>; Fri,  3 Apr 2026 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236616; cv=pass; b=AlVnEjLonF256wuEuVKsiP0KP3fyHeQaeSFFUWdF3yDDxIOpQM61yVuCE7fKtATWNyRZ45fohKfB0M4R+Pf2Ce6yJlgBhrC30BB83OupvEMvIyyt+MZpqc/Mtpp+o/AH5DTCyNAoQRKOyOEFAe9hHsxLfCQlij5tcpfWB1cCLLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236616; c=relaxed/simple;
	bh=1SyoVLAt1yCyzm5+Yd3lOzM3kjZo/TmY4bzd+hRNO48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPYDyGDDzVJ0NFHXQgUk2aPT4B+M31p8+HLJ0G2I1scZl8FKpcNufIXsQYaec4WIkWurErFshPcYFubT7RYcVl63X+pPp4uymZD8/frfUh6Jr+gw/caXG7qfrbUmRMRWJSAiAs9gXntAnM4WLfD3BCOlA+IHHhRDHQBJpPiDwHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQpHbFRT; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d17bb1c65so1196104f8f.0
        for <cgroups@vger.kernel.org>; Fri, 03 Apr 2026 10:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775236613; cv=none;
        d=google.com; s=arc-20240605;
        b=KUZKeS4EOCslqHJPo8w3zXXxnu1BYqLnGWl8D88/GWr52N3URwHslwQWRr4Z5sPPfG
         48KZLYBa56FpHlbtL6/SRqW0bBzHIA0WO6lqtDceBD5JgM39M+gM4iVsFrOvTSdiia6N
         OSYSU9GofNlTNlgdgKXZfG3nNj1ywSyYKxZP/wKhjXPn5hsUInIrzaeDFLkLIiWf3TqF
         9I/LfHmskRv0jRs5AIK9eCWUnMZb0j3jLd5PSmrHn4Eyjwci6uO5Lr5yLVeMHSfpditY
         px5IrIxwCAe93EG3WY/L5pWQIEc0qZkwhECQZDvZ28Mclm2o0oLhOePMu0pXIrVuD3H+
         LGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1SyoVLAt1yCyzm5+Yd3lOzM3kjZo/TmY4bzd+hRNO48=;
        fh=uhrdHzZzRuyXUC9gTb/+Nt2WGln8qCj4PwgG37QQwaM=;
        b=Zt7KSU4AAOP573JpfMXGisC+0GnUmUYgKcIXwrK2ivllw/noVKEamVd5w9hMW1b+z+
         fCRVyTbdWipwMyLuPqoZETUk/DIanVMRS5/Q0EIqDdEEXUd9AoUEdTmOqva7ciZqoJxA
         yQ/Mq2lbBdDESyzSsRnWn7BvQBIQdX9T/gs0jES2xvzcBKfdPrWQEaBAUuZHFs1EgrUC
         /2hOz9bcLuefkhWtQgv5dPbRyi5sc0l8Bc7cBdLdxfMlZHnez+8ys71Mei4pwCwbfPTh
         ybvH4C6Y+fEcUucVCOnlxS2sgjwnG7K8y6iLLz9TfXVwAYTD5jmkmNeCZ5ZL0YmY3ve+
         Vthg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775236613; x=1775841413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SyoVLAt1yCyzm5+Yd3lOzM3kjZo/TmY4bzd+hRNO48=;
        b=PQpHbFRTxtoKy80dTJsZSjg0xOkNgXDIcXTpRuMmz3wkmVsE8sUDBmDXVkAnJ7k3Db
         0YA2PVHWXy+ER4Nfdj6gv0REdDlbpl7D52dxF873U8X0coW2CBhlC07Nzry2aiu7Wll7
         VrVtzVy9NkrMOeLMq6b8MWFttwAkxvd2F6aYQ9rU4BQrC9fXfPWbbbDN6aMJka+NNUTt
         AdITES+LCfeIDpJlp18jwyPNEjcIajalNTEXsifkLXYgFxtzIBx0S5zcl/yU1Ro+j9wX
         TvgysYB8feU6nOdZH7mXUGeIwOITniWbAmKMY4uEk9zXtDyZxhYPPF+JPx7213e2EiWH
         4Dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775236613; x=1775841413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1SyoVLAt1yCyzm5+Yd3lOzM3kjZo/TmY4bzd+hRNO48=;
        b=rB4M0wBN44jYOBXE98mY+jkV1QQb2jCMUey7W2KdZCW5N5FEgl3+RcNeskh6ud97cZ
         lbVe7tTKb7u0Zlysg3L0Jnp079Tg57zE4wxtHqfrX++8tbzApj3a0BY0cGAg3hn3YBx+
         es6k5u1NUj80kS9HjZJAi2bwn18pEZryf6xr1zdZ/8J4iPlmmAWp6BfX8DtKlUo+7+Sk
         xWW7gbtYPqyRHGEUg/Of0GAOuQYzrSA3YHjS1S2lHn6ChNVKtuTn+YrmDsEzCVngoQaz
         xKch1tSYj/hPhO0lVBdAcVPtKThjnqX0Ek8BcxUaICXUfL4ziUUeMRxylSwtUH24Ksyn
         /org==
X-Forwarded-Encrypted: i=1; AJvYcCW5rUI2fgVoSh6TyUUM3V4DTbYdfamG6QIPYIWuobEl65GI6rIOPwIPYYynhzfRfEvqs6B20MKN@vger.kernel.org
X-Gm-Message-State: AOJu0YwinKtppgWXM7lKe8i7kHcp2mriGAKi3q0LuktdVY6NdiCJVWMC
	Gc9zVeLlHYfIMmCWgmWlfmJSeepfyjTiuXp+6LwgD71uWbp1oGEf/9o8S0vZ7oiJmLUJX+NVRUt
	m3QpUt/LqHgpzSzmCjx6Vesi+wpdzhYI=
X-Gm-Gg: AeBDietP+aeq/RrNyXtYH6WEvYCAZ3Juuq4aLLicdU1KxOEr/QuUYLyNqOtKGrb63tE
	GOWZjfztWtk6XBpYuwj7biJI+vgVePuPiptsUE6RQaOiRBOA6RiiIssbtPL9IvviuS1e48RblVy
	d7/tWvurnkYLRiJndT2rihtV5GBaiuI1/2NRJWyr8b/heh8oaGxgVYzEns05pLnpOZAsx9WPBYC
	56O3TleSsVzNjMSqMKWgIND1R+CY+0FIJK6EcTc75FdJCZ7MRxLmHM7sFQjLpXCD/9i5/zHQKN8
	JLCKnrw0F6WZsTqzlKroBQINSXAkS0lZ2gM1xPvYUjfUmfFQMw==
X-Received: by 2002:a05:6000:2885:b0:43b:87bf:89cc with SMTP id
 ffacd0b85a97d-43d292f9ab0mr6063228f8f.49.1775236612678; Fri, 03 Apr 2026
 10:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402063714.55124-1-liwang@redhat.com> <20260402063714.55124-6-liwang@redhat.com>
In-Reply-To: <20260402063714.55124-6-liwang@redhat.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 3 Apr 2026 10:16:40 -0700
X-Gm-Features: AQROBzB0e0tCl_YCjgHALlhPlXxgnQULvs8SWo3GWsE0zwlBRZHXMDg93N-xH90
Message-ID: <CAKEwX=PVQD7i796z0unVDp3M9k9tZrWEzPTsE5hCL=s=zBna4Q@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] selftests/cgroup: replace hardcoded page size
 values in test_zswap
To: Li Wang <liwang@redhat.com>
Cc: akpm@linux-foundation.org, rppt@kernel.org, david@kernel.org, 
	hannes@cmpxchg.org, yosry@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com, 
	mhocko@suse.com, shuah@kernel.org, chengming.zhou@linux.dev, 
	longman@redhat.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15172-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:email,suse.com:email,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 32862396ECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 11:38=E2=80=AFPM Li Wang <liwang@redhat.com> wrote:
>
> test_zswap uses hardcoded values of 4095 and 4096 throughout as page
> stride and page size, which are only correct on systems with a 4K page
> size. On architectures with larger pages (e.g., 64K on arm64 or ppc64),
> these constants cause memory to be touched at sub-page granularity,
> leading to inefficient access patterns and incorrect page count
> calculations, which can cause test failures.
>
> Replace all hardcoded 4095 and 4096 values with a global pagesize
> variable initialized from sysconf(_SC_PAGESIZE) at startup, and remove
> the redundant local sysconf() calls scattered across individual
> functions. No functional change on 4K page size systems.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Yosry Ahmed <yosry@kernel.org>

Acked-by: Nhat Pham <nphamcs@gmail.com>

