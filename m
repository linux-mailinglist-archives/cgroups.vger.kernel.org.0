Return-Path: <cgroups+bounces-15245-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDiuD6w13GmnOAkAu9opvQ
	(envelope-from <cgroups+bounces-15245-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 02:15:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C973E6763
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 02:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A11D300252E
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 00:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E090191F94;
	Mon, 13 Apr 2026 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgGXo85Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C011A275
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776039334; cv=pass; b=BoDL6xsHMF5o52D1pNPzPQdGxXMYFI9Bc2T1cxdQWfd1GVPk6lt2hb9+pJD9+3TbKlFYww+CiNf3TS++Cn1LvPvPiXar5+o6fG7JgYnKGATbVSfLMYSvzpXD2TzsDdkIvVss/3rKt8wZ+iwyone8md+RT4veyaI3zOQVqCCKZaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776039334; c=relaxed/simple;
	bh=Bc7qQZzyiNRpV3OWkFvuiy4V8mNnpMrll52klrXJfPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFeEGAYtfJYq5/lq8X19D5ubHWmAiDKCgN0ZBXLRzZVVnnRj+bsRiONRWcI1Du8v3qfGDMNZeN5uwGYNDxPA5ZpDOwFTu6ZyZzKL7TEIpvslI7niZP0jTI8dP+UHf5Q+77JztZYxR+TtS/3BhhHiaU0EzsiWIWQalPAhkOTQKv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgGXo85Q; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfd96354aso2173170f8f.1
        for <cgroups@vger.kernel.org>; Sun, 12 Apr 2026 17:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776039331; cv=none;
        d=google.com; s=arc-20240605;
        b=joxy+qhutsGmly0H2Fsrwiqb7obNCCqZfAUsAzhBkGHB4q1XaR1VIlKamcmLrZByeQ
         cBWz6Jnf3LcQYzpgOK77u4Ib/fObt4/Ow08Cx+CNBCqF6AG47GDu+9vtd3ud14bg0nVl
         CVWODxr5HdhGPYeT9j/LX0UvzzGA9e49Ma9PXzVxHa6K+sjxx1QEeKg3YSYwae9auo9M
         ElzjEKYSKqhly2MOT6qtg7MfflzmefPUo7lG1GMJxYdiZZBiTEnBsAHAQXWUW2N3FZTp
         lyBiQcL4G/3G26R1bGUHNExIAUPB5SKeNBbqWDm4PHouD05InLfBEW8Cjtd2jpV9C502
         BBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ZjAoNv/0bH6d96ZJoX3aNNUEH/X9X2mePXXADQJKVw=;
        fh=x34euyk/4TlXMPF4WTZgaaXd6eOQub3k+NEf6bKiBBs=;
        b=hfoR/l5qAYaPUrUZVf8psqx0xwPGhDB3/aNsPlwa4kiMf0P//s7iNaE7DbZmjHJIfH
         9xW1qh7Hy3rSrK8KaFLsi5D+sl9QG0madVRXD9zd4aPyb+CtWwXG5xICJ+Rf+FRC3wau
         Jc3G8uLalgcwyAxOkXBRg9753j3hYYeWC6Fieu5k2Cimlkx1n1Q85qpdyivS+fITrMCU
         u5JWAcaM3uq77jDdx+3aLMB17iwPfHrPuIYYUgp9GZo5aK1Ohvb+xTDM+lRiUmiT/UGK
         fZxMw923IDf3Cr3nUubEJxxIiNZLluNBcNTtV0wPO2zf8zXVBDnpd8g7+vRt/i9YU7iP
         hdhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776039331; x=1776644131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZjAoNv/0bH6d96ZJoX3aNNUEH/X9X2mePXXADQJKVw=;
        b=SgGXo85QiWhnF0XUanoosZE7Cm07gc70RpX1epZgTIoQ95BEKTREhWcppNBEjFIgn8
         FsiDiXNM2JGeqm/jATfk1w3YR0TBU0X/XFuwiSaLW/UI/5pZhdM7g1WHS7DrvtoxuJCG
         M8JFOk6b5N46kkLvLla8ACQNtv/sfEmr4Yyj+pzF3i7Ki+OD6aEIHCV6/ywbXFk6BtOa
         G3urc2HlQ5aj82IuLLTV/TKJWDuXrl0Klt5pZNWtZ+z8cv0WyxY/4kID0obQ0bpsDefd
         bMS5Uv7Xqf8LoFoaKWTlPX9ylhb2zX9vnh4FBbgr0Z14ZI6D06sHgJw9y36w9QBBcc76
         X4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776039331; x=1776644131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ZjAoNv/0bH6d96ZJoX3aNNUEH/X9X2mePXXADQJKVw=;
        b=TN6a3pgtHYNmIXoS0iWpIuhD188TF9i3wdrUVucPUgudKgvQN4JyMPVfz1sqamqv78
         IWjPNRSTSbegNN/lNviVJ5/zdh0oDyuUHpvu8436wUP3gBB3w4Tv8bETiPKRXd7RkvU/
         u7S8EVUWJdA+FOBmdCJig6KWS5NAHYq7RrRGwS8ERv5QZ8hUXnKXhlt9IcDivdTmDQqB
         5VvuBoLwu46Ep+VfpFeNSK+KR93zI92On44QajysFTWHrstyhCX1+hLdV8c1pryrXN0a
         2utkogJsjbaLOyd8WFC1opMpvjYmBUUBDxABiCXfRowWlA0Fw5jU8L6fEuJKaI7l1YyW
         5USA==
X-Forwarded-Encrypted: i=1; AFNElJ/nOTpQUrtIDHEy3sbSjMs1F/qTTJc50wH18/caeJI9k4RpIDoERiWRUCbU98nkPqQOoUE3QBDk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1BavMvcMQw8HQGDxPJ0f3rJzwPAOP7Fur6JogrMcLkLRhbyZN
	FMHJjj/Y2EyxA7mfDZDVNyzgqCpAz5HgDacydrXg5om0PfQqBf/yJzGI4J3cRUtg8EhS6O3aP23
	/fi1OTNg4RZS1Jel/jUEXvxgpoVwyVNE=
X-Gm-Gg: AeBDieszU+fQHPwL0DRzyre2iA5B7QzHWa9V9jJMamT4I+XZiTdYNrVdU+qndbCy7o7
	JqCSTKgr7FFN++U2HVEKJUCoFzlXyJ+i9FaQtFPBIUm5wsiOuIegGEQbUpsA9eAjbcXlRSQuJnu
	KT5n6bDN8gFSZ9YawOhfpJM80iowCt7hXB5yhprh/iy732z6yDxoptEB4AHuLaoUtHCcfvWsP/e
	68Yc798I7tjSt8SiRxxzqSwhYszLfBQMCrA6mO/Bam9EMhJZvJbKXYX3Kn4xKR21fcq3DkcXyYv
	6Y7OoBAvClOc0OzAdGjAg6m76rZu5XtsZ726/CC8e+GYBN8p
X-Received: by 2002:a05:6000:4387:b0:43d:7508:c9c1 with SMTP id
 ffacd0b85a97d-43d7508cd32mr5342542f8f.50.1776039331323; Sun, 12 Apr 2026
 17:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402063714.55124-1-liwang@redhat.com> <20260402063714.55124-8-liwang@redhat.com>
In-Reply-To: <20260402063714.55124-8-liwang@redhat.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 12 Apr 2026 17:15:20 -0700
X-Gm-Features: AQROBzCifv09xX9_r3AlbMnr7448_s_gW4fyAOGpR6oYAtKp0TkiGlmLrGMOEK8
Message-ID: <CAKEwX=P5vet_tfsLtOcF5x4vMu3NFkq=2oP1npiY1uemR-GZvg@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] selftest/cgroup: fix zswap attempt_writeback() on
 64K pagesize system
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15245-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39C973E6763
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 11:38=E2=80=AFPM Li Wang <liwang@redhat.com> wrote:
>
> In attempt_writeback(), a memsize of 4M only covers 64 pages on 64K
> page size systems. When memory.reclaim is called, the kernel prefers
> reclaiming clean file pages (binary, libc, linker, etc.) over swapping
> anonymous pages. With only 64 pages of anonymous memory, the reclaim
> target can be largely or entirely satisfied by dropping file pages,
> resulting in very few or zero anonymous pages being pushed into zswap.
>
> This causes zswap_usage to be extremely small or zero, making
> zswap_usage/4 insufficient to create meaningful writeback pressure.
> The test then fails because no writeback is triggered.
>
> On 4K page size systems this is not an issue because 4M covers 1024
> pages, and file pages are a small fraction of the reclaim target.
>
> Fix this by:
> - Always allocating 1024 pages regardless of page size. This ensures
>   enough anonymous pages to reliably populate zswap and trigger
>   writeback, while keeping the original 4M allocation on 4K systems.
> - Setting zswap.max to zswap_usage/4 instead of zswap_usage/2 to
>   create stronger writeback pressure, ensuring reclaim reliably
>   triggers writeback even on large page size systems.

Makes sense to me. We should scale the test by PAGE_SIZE.

Acked-by: Nhat Pham <nphamcs@gmail.com>

