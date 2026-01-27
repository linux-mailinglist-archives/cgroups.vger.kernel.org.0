Return-Path: <cgroups+bounces-13479-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOLxMuH1eGnYuAEAu9opvQ
	(envelope-from <cgroups+bounces-13479-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 18:29:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 214BE98728
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 18:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B955306CEF7
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 17:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC372E8B6B;
	Tue, 27 Jan 2026 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eTl4MmGL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD32D060B
	for <cgroups@vger.kernel.org>; Tue, 27 Jan 2026 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534845; cv=none; b=eEyapEf7924elfpczX2yhtIxwKyvv/iSLJHSCZAIhOehWvFmkLOBv4XptHzxD5ZCi5Y6PAeU8YKBK8+GNrK4T1aD0nuHaNs3ImEu7SKkcx3zRI5JhL3D3UnQFwEbvgts1xrptRmT92F/DS53PfELnjFmAW5x+thOoNm6SClZcVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534845; c=relaxed/simple;
	bh=gUjrF+XkCMRpE/S5giDR37YCtfdCprXY3UrIFmpZNbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXJnxFJg0c47M7pitA117ozEdfsAXp60ycmIfyzBuH6UmKuzpifvUlLKOdt0/DF+NEhlkbV1P7NadPQ0V3bLne2czr7t6B8xhBmc/KAPXhArhRA0UZmdfLfpTNaoV4Jk9rSrbpfPlhn8929Y4q3csqhKgsJg+E+xGmlg5qiADzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eTl4MmGL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so86989395e9.0
        for <cgroups@vger.kernel.org>; Tue, 27 Jan 2026 09:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769534842; x=1770139642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gUjrF+XkCMRpE/S5giDR37YCtfdCprXY3UrIFmpZNbk=;
        b=eTl4MmGLvYBkliWkaO2DaxKld8Qyk9lZAz3CVl/SID/186xpjuSojhd2FJx10MlVR+
         tLLIUxzgoJoHgjtAUbClg8J/So73YR01/cUN+3XcDN18tPHOm730ML7Y7FQ5q+nvOpcx
         dawymtUFD0TkLtKScmSfTZJTR02pzYVSLxCbdvWoXaRIbYbZjvJ2BmqzFM9nuHVFIcP+
         4bQy3xRdEVgDMawWxyShsCXiRGjpHBw6RoZxIklZ3fn5guzVgQzIi1dpnaeH/OdKtXbK
         MfqKiVQoWtwmkM1wsMnfL0drdbHu2itGNUw6fWeic6PyKiN+OGtVhOc+tuGRAjtViegW
         ymUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769534842; x=1770139642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUjrF+XkCMRpE/S5giDR37YCtfdCprXY3UrIFmpZNbk=;
        b=EBCrPRPOt7lcMIQSpfHcJVFf7gllffJ2fh1e+Q8/2kJRuKIc0r6o2QYsssAhcikaLJ
         1p+03p2eXjpgDJUr1RrD5gCVnzfXw+qTlq0j2lafs4G7AhX1qIt/gb7DQp4SzUb/D/Tz
         A0NACbF1Cp9FpINFZ7LJXPjT9muqcDGbHn8M4Ht+PzBrE6+lNpOfsbNYQEXx+DrGoUo8
         AGhFHzitMuD6iyz4ze8Xv5yZ7jfjTp2nBxY+mzcq/hjFTHPUDk3gYG5nQUfN7rdanu3G
         b5UnsOhoLRV5OzhLSShKSPKzSLwNIVnzvS4nL2+FERnEfzzJGNSMRnqfgXN7T9atzgCf
         iT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc7HXtRgsE4Qp6kCjwPYIZ6RqyDK5QvEjLUN0hBRuAtSIoiPGrXmC0OkDyWvVDnOoc3ZXRPQ4T@vger.kernel.org
X-Gm-Message-State: AOJu0YzoPzKMsCKMu1zfmUxTkW9VgFcu6a8NIcSs3rSIrVCuMaf/NHdC
	nME3KpiAVt9kb4jOTzgvMiebsQU1qBCENlub8mJ26XhCSR3gXikT5OTU+Nxyoz2uLrY=
X-Gm-Gg: AZuq6aImjyp3MAim5kWQrF+2wnhPIPuhPCPC0yImniLchmaYW4NY1yu4dLRC35qaaJz
	zaNCxewOj6OdJHfJbuUlKnI+TFOp0mzdgHsRwDwFVc7S8319ehJLgoIED9t4rEPo8JJy6e1HrO0
	Bfe3Ya0p3F1cUpiLgyYgLn9p49QoNlBLl2IBdJaMMCJa4IIBac5cELPBbUc5k2LucHWJnGoRYeG
	znO0FtpQufQMapx3yrn3aaApdKef3qh4kQ5woU7uRqiMaLBa3R9LhD97DyE/UcrY2S+dwA2hm9E
	6VJ265/ix9Uk1YkDDbPjdaVSVLcwmRMtv5VRuIrYJ85Zv9C4L7BwuSQEzAtKJ8hNQ41tYePBI0b
	s1/iH9mZzf4LQzA/G/B+lGdaQcA2DuDikbr/dX64uAIqDnIf7gbSefEblwG0ubKZegPflCyIbm0
	kKWVNF2tNt0CteKMQo8Ye4kYJ7yBn5i0Y=
X-Received: by 2002:a05:600c:8b24:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-48069c20e88mr35707395e9.10.1769534842528;
        Tue, 27 Jan 2026 09:27:22 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cde00e8sm7129125e9.6.2026.01.27.09.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 09:27:21 -0800 (PST)
Date: Tue, 27 Jan 2026 18:27:20 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
Message-ID: <uwuworxk3warxfnvr7g3gnrh5g7bnnkq5uhbsnoh42muv7zeax@y7ddpcbhwarw>
References: <20260122112951.1854124-1-mjguzik@gmail.com>
 <CAGudoHErB_Dm8kTRDa8cNOe4aRgc6kAV0bnT90Pp_Uda+_DqDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="27abybku6o7d447a"
Content-Disposition: inline
In-Reply-To: <CAGudoHErB_Dm8kTRDa8cNOe4aRgc6kAV0bnT90Pp_Uda+_DqDQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13479-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 214BE98728
X-Rspamd-Action: no action


--27abybku6o7d447a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
MIME-Version: 1.0

On Tue, Jan 27, 2026 at 03:30:14PM +0100, Mateusz Guzik <mjguzik@gmail.com> wrote:
> ping? I need cgroups out of the way for further scalability work in fork+ exit

I got stuck on following:
- possible implementation with (simpler?) rwlock,
- effect of css_set_lock in cgroup_post_fork().

I want to try some measurements of the latter since I assume that
limits the effect of the elision in cgroup_css_set_fork(), doesn't it?
(IIUC, you'd see it again if you reduced the pidmap_lock contention.)

Regards,
Michal

--27abybku6o7d447a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaXj1dBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhYjwD+JWe4pTbKVjk+RKHrS5KM
9xT8R1WA/hEDoFfj5hwBDJkA/RRInva/tw6tdT3UDEI+HHZRPSKJak7VjuI4pzjO
4tsK
=Lh6x
-----END PGP SIGNATURE-----

--27abybku6o7d447a--

