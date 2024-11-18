Return-Path: <cgroups+bounces-5613-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2876E9D1076
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 13:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50711F222BA
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC13194A51;
	Mon, 18 Nov 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gzRNbH/7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2433B73477
	for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731932195; cv=none; b=uP4CyHggoXPL/f9+pSeIIxo0kX9y3iQ0dDuFU7BbRIkwL9+PYJughDWKbUio0Udbhh1AYNTjdBdA6B1Kqd/XMGY3z0wfr1vpTTa/rtUOmxkjzOelrrLmnlgEWjMQm8kVWUOraI1LgfLWKnfvL2adAo8UeU7OEjO01/BJ/4Abxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731932195; c=relaxed/simple;
	bh=IWwLEV5QRf4HYXkSK9kWrSqetc1/yuz1W5owMeylWKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTb114hfLlzz41O+SPva9ZUeUORLrg/kCpqzedN3sq6QixWoU7XnVb9Ybkx6OX5F4gapvpinaRKzRIyklwQBH4eqcJuyKtZr/nQ5I6qpGWiUx1yUQWwalQiwwXf3GFVTSuIPI4ABvxVmLQbrkySXRJpqrzaCxn7L5E9A1WUSM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gzRNbH/7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3824709ee03so628906f8f.2
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 04:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731932190; x=1732536990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IWwLEV5QRf4HYXkSK9kWrSqetc1/yuz1W5owMeylWKM=;
        b=gzRNbH/72tQAAScPsgTOkeW5WEFE2ZZkBUcqbXGRvpHIbAoGRfoeUY3CuQyg1UIWHW
         Pzqpq8p3di5ELjM/hq2M89DuvQt8xSfGpfF92KdvDCE/4yjVedjBNyqFaLzk9knBSOOd
         Mc/eoCPS4DRS9HRkRQ2AM5TvsfMSxZmwNEsMU6eA4SvfcdDRwLA88S06JH9LMKFbCk6D
         YqJ8XtPqd1rsfGBCR/YJTt4tB+VrEa4/B3KXplKN0hOuoLWOtQftyj8bzjjzQS/IC/2y
         mCAdj/NgXB4ra/obFCjptCnOg+OfQ7H77zZ4cFVtzPcqqeVXGUvSsJwQqx82Se9XwaOl
         eo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731932190; x=1732536990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWwLEV5QRf4HYXkSK9kWrSqetc1/yuz1W5owMeylWKM=;
        b=a5Iq1ZdlfcphW2FjrrWoFc8TQsqLQ73xQt66vBZxjvEDaJacICZe1RIYJ0a71LcZqE
         rzlv2sWlpci6We7LI6hBrTOi4i0bPb9gzszsmE948jAiSpaS70gUh7tG+NPqGMvn7Pr7
         whHYtkQ9xTSFnNYAWOdloo17xh58S/AAIxbV1sjxnaBGQkmwLPXrUjrjVP0JPqwtnecY
         eifiGOHM/rjubWtHGOjxWBiTh9sHmH9eX6yR0A3GeR36idfe3mEiMKllau7pqSZktJF0
         j5UvWN44XsFBQ6rMidh5Rs9863NVwq/joYMSbKhoIN6JwFJwxi0omUIIQLndGeqYvUHB
         ykXw==
X-Gm-Message-State: AOJu0YxloFPpT9MHrCCBRbRLR8M4s6zP1mE/C8TSMw/S8iYX6iOVOuQ5
	Rml1A8AREiUek8Ggvm01h6sInWYHvFjrHDVZTjvcX2/WoUdHJRisXiGemLhKqUZwBGkhi5ikTGc
	Q
X-Google-Smtp-Source: AGHT+IFqSFBTGFwp78Ipf+Q2fpYLTzJ6DLzVs/RlLK5BJ76iNS/Mc0MRSSZm2a1TBIdiCkizgh03bQ==
X-Received: by 2002:a5d:5d8a:0:b0:37d:51bc:3229 with SMTP id ffacd0b85a97d-38225ad5e80mr10033369f8f.51.1731932190340;
        Mon, 18 Nov 2024 04:16:30 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbbc65sm12638286f8f.49.2024.11.18.04.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 04:16:30 -0800 (PST)
Date: Mon, 18 Nov 2024 13:16:28 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: cgroups@vger.kernel.org
Subject: Re: process running under Cgroup2 control is OOM'ed if its stdout
 goes to a file at at tmpfs filesystem
Message-ID: <ro4p7iarm43po64rkfy7l7mpqncelmoyztwchf6zdcnqerwbm6@z3ubeedjvcbo>
References: <e0dccc65-3446-4563-8a0d-1ebda4bd7b81@gmx.de>
 <tuvclkyjpsulysyz6hjxgpyrlku5zuov6gyyhjzvadrqt4qpse@bwmb7ddutwzj>
 <c77e4607-6710-4256-9aac-26251813450f@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7pkhzqcika3su5fo"
Content-Disposition: inline
In-Reply-To: <c77e4607-6710-4256-9aac-26251813450f@gmx.de>


--7pkhzqcika3su5fo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 05:04:06PM GMT, Toralf F=C3=B6rster <toralf.foerste=
r@gmx.de> wrote:
> I removed any limitation for memory.swap.max and have set memory.max to
> the RAM which is needed for the fuzzer.
> That should make it, right?

It depends on the workload=20
With memory.max cgroup OOM is still possible, e.g. if you run out of the
swap space.
I'm not sure that's the answer you expect =C2=AF\_(=E3=83=84)_/=C2=AF

Michal

--7pkhzqcika3su5fo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZzswGgAKCRAt3Wney77B
SRlDAP4nqMm1iiFGsW98KLH4Itzz9CQy3DhlGxD69jI9N1uo6AD7BAHweWAknHOQ
wkCmGcuZ9iIrA4/jY9sRHKSFhG3o8QM=
=TnUu
-----END PGP SIGNATURE-----

--7pkhzqcika3su5fo--

