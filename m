Return-Path: <cgroups+bounces-13637-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNyZFezwgWlAMwMAu9opvQ
	(envelope-from <cgroups+bounces-13637-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 13:58:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D5CD97ED
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 13:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 196313034DFD
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 12:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED5C346794;
	Tue,  3 Feb 2026 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BBHc5wXr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5F2D29C2
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123225; cv=none; b=Msq63p++xr6YseqrTnJNMOvKx2L4HRj9m7YJLSXaS+d56LiOaDdZxFiUTxP1+8b1KT0ZSQDvQ7gTUY7ZJzlOIb7dUx6qJRismz4/f+6HJZSaunDxDlV/QCBnI5Kemo08+NKJp6Us0vjfq6/VutluBImR3xGO7BxpHpPmEmYWtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123225; c=relaxed/simple;
	bh=eaKF3+iwje++PxkLmHGfLcnZ2dLjEPxqiYq20JrteMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoROxNEx0efHhXiiCgP1oPCYuGOalWbAGWqjfEBmmP2qecEZfYmWrHo/Bl+Y6LZK4ev9t3uau/rAxgr/NfSLtcUdpy+lzKI68f6+NwDlVu3Nvl+9Ji/5PW5qF6TKD0czTQfKbpMSSdrSU0NWgfPf0cyN+kfhTEbxrsG4dkPffIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BBHc5wXr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc305914so4953684f8f.0
        for <cgroups@vger.kernel.org>; Tue, 03 Feb 2026 04:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770123223; x=1770728023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eaKF3+iwje++PxkLmHGfLcnZ2dLjEPxqiYq20JrteMU=;
        b=BBHc5wXrzI77HugTckS0smYf++iTZPOtrSxd1O0Zud3cJA2r6no0S9HSULF660oYyG
         H+iA4AYSX8h8tu3KSzN5sUWzdNNWSGqU3ZHyBbgPVsrfpUfMjhCKN8YMNDalCQcfitOR
         e0PPWCfDKPL59klWknazAX6fixwGs+hdnwvQrbAU62y8pdWVbLaCkb75423lu8HvBX1N
         SC7q0StqznmIZTqmrPZIJ4GjL9lpi0e4ZSDmm045NlBI0WFRjbO7rOkBwMkhU/o8tJ5Y
         G1nf2QpxY21YZ8KU0KruBSha7EY9dyIrC0jw37wth5nzK+353LYxV2km0TblhE66I5Xf
         jC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770123223; x=1770728023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaKF3+iwje++PxkLmHGfLcnZ2dLjEPxqiYq20JrteMU=;
        b=Jv3QQBgvQDSofnvvxoNe8T37CbrO5K7W2RgTD9bMGCfuvlfdI/hOi4x5IL4/f9iWwT
         K+SR85miHHxOqmmXoyhbn6BkHGJP7yVthNqcB+pidc+vbDcuiJneXv8zuoBE4aXM8AQh
         M0XJ7iKA05Pk9aVsChDvQOqx11s42m4gtqJrLe+AySf3X7LuwNZ/ooIGa8EASYLwCh+7
         j8QGNnQnra893mwAM8HTwPMoXSBBjnvypBZbRIYQViXY/xhYEO1OgfnUOaLIxysPwYPh
         gGxW1abvhzKZjVOSwY7rVaHRBllenW2F2F6F5NcuE1WhJlJWi3JIeXBUYXYWtX+msqlu
         ykpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE+4w8oh6p2DhwJJy+EjDmIN/9eLABqN9J8cCsdWDw19K6Y1SwdpkOZrdneHk9eNWKtPGYBPwv@vger.kernel.org
X-Gm-Message-State: AOJu0YyOI/Biv1UcyLY+kWG6zZZWaoth47zcgztlXf1LVQEionZazLmm
	xNu1aGJujytZcj3gcq4ZLaJ33UKd9NqjK5VWMGyLT5N7nfLoh/fV1bkNdTOa2EDAMcg=
X-Gm-Gg: AZuq6aLUa+azqRC4s/VqLCtfJM/TS2fhQoI0r0P5WvaDkxH4y8duI2EUUGHa8cSqniw
	piQy9GFddd9OlV4D/VRkH/inx2CH1tQslcd252rRHlzfyNpaswRYLA0Dpv0sMm9e93WEQxQLiHe
	cAcNCZcd4oZ4moYsiCDCYMhSeXxIa/S1aJknPdjJBZrpin+HBoHi4BL/nMzTeOYLqN8wnchEo7/
	8HHvIXTO2BDjPy+DDwUW2X52XCJ0cUY5ckZ7JaDhQw403N07iswKu39NEI/HDcOY8TFLw1oYhCA
	ooMbLlxMVHU1+rJA71GzmUFzAe43c/sJHPX2N5q28VqSrzzkRrb6elbbvlcsaE/DkP28pKgKyns
	Xs30C+emqSJHd4C5KiP7qaRb1zoM2O+M6y9bkFQXbYkOX1xiElJDThES5pYv8voQrzCskqmus79
	Qbopp0CPKv2XJieCEvbpwPbvjLIRHLxkdmVpFimfDL5g==
X-Received: by 2002:a05:6000:2008:b0:430:fa58:a03d with SMTP id ffacd0b85a97d-435f3ad87b4mr22479946f8f.63.1770123222670;
        Tue, 03 Feb 2026 04:53:42 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cf4asm52836675f8f.28.2026.02.03.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:53:42 -0800 (PST)
Date: Tue, 3 Feb 2026 13:53:40 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>, 
	syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai@fnnas.com
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
Message-ID: <l55sz3sgogoyniecolvzscjamxqrxlzgk7w7scds3tt42z6atj@nrfvjqg2agib>
References: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
 <aYFlZf9p4cY0rIbc@fedora>
 <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
 <aYHXzyRJbzFSohNm@fedora>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ebaw6z25hlofpdyb"
Content-Disposition: inline
In-Reply-To: <aYHXzyRJbzFSohNm@fedora>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,googlegroups.com,kernel.org,toxicpanda.com,kernel.dk,vger.kernel.org,fnnas.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13637-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: A9D5CD97ED
X-Rspamd-Action: no action


--ebaw6z25hlofpdyb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
MIME-Version: 1.0

On Tue, Feb 03, 2026 at 07:11:11PM +0800, Ming Lei <ming.lei@redhat.com> wrote:
> RCU supports this way, here is just 2-stage RCU chain, and everything
> is deterministic.

The time when RCU callback runs is noisy, moreover when chained after
each other.
(I don't mean it doesn't work but it's debugging/testing nuisance. And
it also looks awkward.)

> I thought about this way, but ->lqueued is lockless, and in theory the `blkg_iostat_set`
> can be added again after WRITE_ONCE(bisc->lqueued, false) happens, so this way looks
> fragile.

Right, I brushed up on the cycles from the commit 20cb1c2fb7568
("blk-cgroup: Flush stats before releasing blkcg_gq") and it'd be a step
back.

Does anything prevent doing the each-cpu flush in blkg_release() (before
__blkg_release())?

Regards,
Michal

--ebaw6z25hlofpdyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaYHvzxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhLNgD+Jo7Zrh2P2G7VGLqyly8P
XTVQkInFUVhIXBJcbQ/2lisA/1YN137HA3xAXvFsClkiW7neHkMtJTthP9N0mKp+
WlQK
=goom
-----END PGP SIGNATURE-----

--ebaw6z25hlofpdyb--

