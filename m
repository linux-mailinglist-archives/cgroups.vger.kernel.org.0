Return-Path: <cgroups+bounces-13321-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEadEoGEcGktYAAAu9opvQ
	(envelope-from <cgroups+bounces-13321-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 08:47:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0753026
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 08:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C909970ACE2
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF0F43900D;
	Tue, 20 Jan 2026 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bTi15G0j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31D439005
	for <cgroups@vger.kernel.org>; Tue, 20 Jan 2026 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916271; cv=none; b=N5M7FlLhd7TtjxMbs/2/wxK4Z3rzTY+0bzv3gnFXrEOhsmeTvxyLlgfziyaBsRP7aGTOecyOZLoVPYboFtMZvByspyvhkl0pCTzu3lANJa51SznI0Fzm87EZ4VuInMslWC1WIQUWDpR0qEm3NoxmcVnRzDLtYu6Wmmt/xsyftdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916271; c=relaxed/simple;
	bh=gTnXdgMDVecZFQ0m9ML2y4y93A7dJ/ojmG/6i+ZUuuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g833FnsR+10eP6yb/4bdjv04/DYYItjtH6zyh27VCH/0XomQANle6Vy1bEpVt50kp3C0ZlQKoWetM9Ks+TuWYEKN+25HSylXDy9xL5zYdmcJQoET463+maLKewiSBQRzQd94YXz31ZRcOcLgqSIPQ0/F5UE035ELDdRwQIYmmB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bTi15G0j; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fbc305914so4398137f8f.0
        for <cgroups@vger.kernel.org>; Tue, 20 Jan 2026 05:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768916268; x=1769521068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Gpn+s9YpaeBzBoWidLlFD1oUE21mqMH9dB3U385I3k=;
        b=bTi15G0jeFkVgJ/LdWfGr6gzIfV6uUnsLr6RlZKepRrLSTqgBKC34a28IS1BxM+93L
         HV3Q52zs5y3L6Kywi9/mRKYxNmMHv6JXJtQWC05sF2XGjQgkfIzgqRs2h6zGY2jJLsJf
         XJiWkqhUHsZbevQh5ujE0tCB1wMwVUqExWycEfY9i0RZdKbpIoE7Incn7mbHZPoc78pD
         XDpc7ZwXV+79WG6nkJiUt7Wb7wpY0pBbV6uYRwzFkVYi8KiTNnOz3WwhNDuYFG80CmLy
         EmZ0HsuXB1nES7MezrViY2JCh/QpJy6CfjMh5NhQ44beVqZ0MdCg7+hnt5FWrx/vbz0D
         goeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916268; x=1769521068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Gpn+s9YpaeBzBoWidLlFD1oUE21mqMH9dB3U385I3k=;
        b=JMvHCTWnBnf57x/D2dggEvD9nmSYyua9MUb4zmG7FDIIrm+v/1bQ/NdHpECf8UZfjx
         7e/c85qj7AhOzMytww+BeILonApgSKOGtA/F3/yJthj6gODfXoxAEmQNgI80ckpDS9rh
         y+BLzDM4Jn4Ig0oIuWnVxCXLFVmVFRJF4poCbGi4MimiuhCn6ExCoHWjKL5dQ+ECc2Nw
         LyLhf3sO6OCFSIFL+eqoqGmiJ0zyZF4phAmY8F+dMkhrRx8BMkI879l7r97X+GQNZNrR
         9+Gt/39R5VyvfdVrGZXVbpN2ZQuNj3AP+Ag9rCHFpw2luPqV7kPU2B7oIjwW6iGTGWiY
         Vp8A==
X-Forwarded-Encrypted: i=1; AJvYcCU5xaayFnjIv/isOSGrTRid2ftTL7GpBlzh6kG0f7qg8pt8dpLDPvf8Xip6O5PoR9B4gXxvrzWV@vger.kernel.org
X-Gm-Message-State: AOJu0YxgpwDUPZKQtmAarx81EYIZTfeTO6RE5Qo2JKN4/hj2O8J8Q2cT
	dzJvqC0UFVCQHotIruNgZT5GCuSwBfAKxFuTLAaWrrLv3NC1IU53f3FZwswmB82lJrs=
X-Gm-Gg: AZuq6aLBceOe85aVh/fOiRGSmwn5jf3rwvsVKIWGxCplFWu/rPtLpz5WoS9sVBVMMUz
	jJDs36Mgzu1+XczzHkLkMow05pzAq/6oDWH6ZlkU37E8YwOkXwBL/EhcVYhiyT0p+Zc5np9D1x7
	uGNpi05r7U8i0recjrvXiOA0vcdlVxc9T/N4DkCrL5zjPsAn6D9CECchvZUb3nsVUhSG5Fbr8P8
	9Us+FKJGvjKf9PqqHuqqkjAOW1o28wJfYygc/Tk/ONF+tyylA7/vZ40gYh4MDdnJeOrHY/gvMX7
	zKTHP3GEgJicw2EnND3tcyT4ZPqy14fWW5a7oCzf0DD5VdgK25+x9dZvLheITb4mS5HPct5ZraY
	SmFgsHJlYtnyUf8YA+DKfXJvZqOkXW1/EiOobcqc8j1wSkvsHQlv2nd2yO4GY5gEdYU+xDZU3vi
	yNTVhMHEr3JtpEVNU0xisYVvAt3xIzGXY=
X-Received: by 2002:a05:6000:3110:b0:430:f72e:c998 with SMTP id ffacd0b85a97d-4358ff302b0mr2976938f8f.51.1768916267928;
        Tue, 20 Jan 2026 05:37:47 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43595e0a705sm1296239f8f.14.2026.01.20.05.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:37:47 -0800 (PST)
Date: Tue, 20 Jan 2026 14:37:45 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: tj@kernel.org, corbet@lwn.net, axboe@kernel.dk, hch@lst.de, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Fix blk-iolatency peer throttling description
Message-ID: <guqq2cm3mk5qf45rcman3twiu7vax4sgkrhj23jrjb26tt3sk3@bh2h6s7givfq>
References: <20260114110837.84126-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a7wrzm4rterhhl2u"
Content-Disposition: inline
In-Reply-To: <20260114110837.84126-1-yizhou.tang@shopee.com>
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-13321-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,shopee.com:email]
X-Rspamd-Queue-Id: E6E0753026
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--a7wrzm4rterhhl2u
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] docs: Fix blk-iolatency peer throttling description
MIME-Version: 1.0

On Wed, Jan 14, 2026 at 07:08:37PM +0800, Tang Yizhou <yizhou.tang@shopee.c=
om> wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
>=20
> The current text states that peers with a lower latency target are
> throttled, which is the opposite of the actual behavior. In fact,
> blk-iolatency throttles peer groups with a higher latency target in order
> to protect the more latency-sensitive group.
>=20
> In addition, peer groups without a configured latency target are also
> throttled, as they are treated as lower priority compared to groups with
> explicit latency requirements.
>=20
> Update the documentation to reflect the correct throttling behavior.
>=20
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Not a big deal but it could've been confusing.


Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--a7wrzm4rterhhl2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaW+FJBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgjhgEAh55N7s2KF8zIbaLqmKfv
rpGZ2vfoGKPfzLdrAdSMHfwBAJIuTXk022wa5HgcNGfMQmlSFOK1m6XMkaTX+kMG
o+kF
=O7oY
-----END PGP SIGNATURE-----

--a7wrzm4rterhhl2u--

