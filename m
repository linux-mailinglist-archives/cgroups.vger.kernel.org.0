Return-Path: <cgroups+bounces-16462-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDgLO+vyGWp/0AgAu9opvQ
	(envelope-from <cgroups+bounces-16462-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 22:11:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4FB6084C7
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 22:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D59430C7B23
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1CB4266BF;
	Fri, 29 May 2026 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rg33rV7E"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132D402459
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084994; cv=pass; b=UxMqLAjNAWv15Zq5XaUW0uyrUKyOgZeSeEAQUEbr2P5imxwICAKZsmVSVuQdFQRsHnc1gVy/P121N1hVw3YQ30mlVpv9eeYBjayhhHhZq0QZWpW5CRfbLwJPdI//YX6PVpscYf6wvuKx5p8JiiPGKopauLesxR2mxws9I7RDfww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084994; c=relaxed/simple;
	bh=8vV7V3CMoBNjkJhOUfmZqE5k0G0M3MxFKAVMCFWrXI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHIvpKqysL5TK0GV0LkvKrx80Ue2xGZInATVFzN1HExgq7cV97n6wydjHE+0+F3ep99/VuGOD7ZumBVdz34fGtBIY4Kt1IcxKSRnUWKaGnsT19m3frRIV6/gQKWYyJbBtKf65FHFvg/6zH4iRq9ttfiD+P0Nf2y8JeGU1crJj5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rg33rV7E; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45eee266c6cso1284459f8f.1
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 13:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780084991; cv=none;
        d=google.com; s=arc-20240605;
        b=KrYZ3ITolBkdJlxTQFSpTSrZhrUIyuAk0QRjUR5DI9RIFoLM6AXi2uv9pKCEM+oYct
         TN5XgXSWHEq1KI0DcIwmiqM+PPwSVh1YLyouquNscX7WOdv0j9G7kWsuMI7aktdwfvRX
         euSBJ3ILnzpjQ3kNeRPPqbpFFvHSCM+mRKtrnM5z2ARN7HXNh97lO5zCzkxcS5hEf6z0
         bMwsjpgJ/i2CrEjKEI4SpdLJhIz0PAUh5rg++HBKpV32c4o0z+WE+DLEYkZ7d4EvRfSy
         JwxvxiTBxj7fyJhMpU4amvVL5xwPG7vylQyDvbsNUBFoBaGU9nfKDjryhNr9hlP/831K
         CZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8vV7V3CMoBNjkJhOUfmZqE5k0G0M3MxFKAVMCFWrXI0=;
        fh=C9/yQD9OdyA+sEJDBwPHY2jYV3b1EROtUFid1KbVKYY=;
        b=CxU6tj/mYmzJki64360OVTxOo7FTAlnO4F2JznwWfau3U0xwT45Nvnrx+G34kFc7kt
         fA4riMCqbUbAScaxdPZa8MmbfTOQOFcGZl2G7F26lE5KS5pNUpIdqAwjbjagneiWT04V
         TYwfGbITksyuuu81tNSz5SB1oAepeeJ1aWyt/tv9dnA3wQlHLvb7FH09GDVasrhPISGu
         Dp4YjduYJnxAAoWc1S4BweDRHZZixALfVbYYkZd9/RbxhBVK40Cq92WpJv5/yN3KHj6v
         jVIR6ZawdLT6vvetSNLGbHVoZXO5tmcPsz+FrM5f20H2OalEMUsojqALmBsIfP7DiTTJ
         BLCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780084991; x=1780689791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vV7V3CMoBNjkJhOUfmZqE5k0G0M3MxFKAVMCFWrXI0=;
        b=rg33rV7EsQFtyTgiUjK2Ackzr3TNkQBpZHUT8+A87Ac9RXqlFpgBhvSAy5QHW+ScU4
         q15xl/aqyqG1HfygwNI7bVp3e24jLlhKeUNeugk2MPDZYUvW6tB3QEGtQawgIOnsCorw
         5aAsSHgnE31TNV1mODMJvNj9UaQY9oHphJNIvqyddy6uRz32lGfxQREy01fkjhESwAVI
         JtsLrF8BX7Z5Nqws7PKec8z1rAKiXndOg8nC/esldVX224O0ywMCg5dNropwdEQLnuCx
         F7ayUffPAKSV8gCW4H9mFdreRlL9Sz7UOrut6B269UX6qIr2uwcFkgSM84By3eKs/DTk
         BiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084991; x=1780689791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vV7V3CMoBNjkJhOUfmZqE5k0G0M3MxFKAVMCFWrXI0=;
        b=q+NWTcj4c8EoXA5bb/44H/vX1IMBUnhHlhPLXJozk5dZNls4Br36bWU+p5jD67V9dV
         NtI2Ze/rbEWha27v1M25bIzipZmWN2OHf9bGgtt+dyYZNPx+HLKKTSt5yV0sVPchNwAH
         zm7ZnZYMRQT0vOEt2Nshi0Js2XbwJN6RjWjqrwtZciv+r98oWtHOldfXEwmrrNQOw4DR
         /uvlSqBUy28rzc3ybl+VPm/09VTLJaTYHb3PrNjyJnNoT/px6YGCYWrBArEnz/lznoOM
         Fd0JsjlQdQMJLezl/1G/9qEOshWbO/C+IiY4LTuTFtTyEFBN4C1RMwnoTlA53fRrUpjU
         kAmA==
X-Forwarded-Encrypted: i=1; AFNElJ9a5p7rcA4rFYEH/OueTvaz1UFf4QPRN7C05Cpvg4YCdMbtDz5b4hAfXyLfeDS0LC2dddhAK1Jc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vdBXJRm4hdORT6Cvi0rQdqsucFl+Qd9FwTfBfbsG3fWXsFKf
	KMVGjuqdnw0n4orB2MH4PZC3aClTvzVK/EhxO5etUZhO+9bPddje3syFQer9EVKwmu8x5vj79NH
	ICFRQF0/TymRGq/ZWtY+FkgFLdZToaks=
X-Gm-Gg: Acq92OHR87C13M0XchF5fQjUJOhEiW4zvb9NSoov4d4Vga4GhDbDgSRTVuIkO7ORWOw
	+3Sf+fOHO2Xne3uU+C6lb5RL9qsh1z1tuq3/LdpKMIlzDFQdDu7hheuxJp7VuTCBvwNfCd71vD0
	QwkU65Xh8DhmAFjLCtq7fjHKVGCfoPoJhc4X2/ZrotABQT4mOAntfrPYBOUomM+fXXFFLCM1YmH
	daji4TeVAFeDaD/zGhotRt7DBQJo62/Oz+ffeZ6igYAInTo2GFoIwUUgz8phVYz4HryJTPPgUcg
	tyBKUxC1NJPPPt4uKkS0fUlm+14IKr7tYaaSkKXFyVfzHXhPiA==
X-Received: by 2002:adf:e510:0:b0:45e:ef4a:819a with SMTP id
 ffacd0b85a97d-45ef6b1fb03mr1966464f8f.17.1780084991071; Fri, 29 May 2026
 13:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com> <20260526114601.67041-5-jiahao.kernel@gmail.com>
In-Reply-To: <20260526114601.67041-5-jiahao.kernel@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 29 May 2026 13:02:59 -0700
X-Gm-Features: AVHnY4IOqjjiOdCG6Ozo0C_CJ8lU_HS1P7B7pgVtIcaK6gtGQOhL7OfGo5YfYKU
Message-ID: <CAKEwX=Mj8hxSma0DN4zvCgRo3HMs7cbB145+s2=LbTjiKUXh1w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] selftests/cgroup: Add tests for zswap proactive writeback
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16462-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lixiang.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9B4FB6084C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 4:46=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
> From: Hao Jia <jiahao1@lixiang.com>
>
> Add test_zswap_proactive_writeback() to cover the new memory.reclaim
> "zswap_writeback_only" key. The test populates a memory cgroup zswap
> pool, triggers proactive writeback, and verifies the behavior by
> observing the change in zswpwb_proactive. Invalid input combinations
> are also covered.
>
> Extend test_zswap_writeback_one() to assert that the existing
> non-proactive writeback path leaves zswpwb_proactive at zero.
>
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

LGTM.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

