Return-Path: <cgroups+bounces-6505-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58270A30D70
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 14:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B3A3A3F74
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6741A24BCFD;
	Tue, 11 Feb 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WzvSrZNn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409372441B0
	for <cgroups@vger.kernel.org>; Tue, 11 Feb 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739282235; cv=none; b=sAaThD4R6jdTzIV9wp3F5avdpB77gkNYsehc0Qh+c8Ssnb8vnEJ+KZJ8pHyqrIfwaAtzESZGBfjFI5pKo5z5hPP5Z1BGvISWhFna8LhNoUs/6vH0q2w6lseBcxp+L+DPGNhC4pICzfMWjkAJQRGL1yBhDrMTSiAqUVofcjr/YpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739282235; c=relaxed/simple;
	bh=42SkK/uGcPe3+X1XXQFJq5L9WLaDP9DsrXhpMr8UjQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXghYM5dFskCa/tYgXUBrnbsLJ6KEO6sW5APDDSzoL4ZRS1WR0DiQjv/NjLdwNzRJIlhh+QMuIbvUloI9d0l874RPKaxf8xtwfSpDRTnyPVoB0oGLUKgz+hws1ktlfJM6xZbosLfcKjC2eeb3KNjHXKp5s8ys2oMU1+JLjXPEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WzvSrZNn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dea50ee572so850909a12.1
        for <cgroups@vger.kernel.org>; Tue, 11 Feb 2025 05:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739282231; x=1739887031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc2Fbe5I0sSQTKOy2ZPiGOXHCFIjUyJawnB44aSJiHk=;
        b=WzvSrZNn1GiR5/VEcF2TfggW/UApynWXIGK+sMv+D7KY79IhJqcH9XFgDJC41CHk4B
         R/eoF3Oz0MStjrRPbi0yBVrlMuSfLJ09C5N3gY0TxtMaetUB7rOZ3/wRIYrvDQ7GxrXA
         /icrdFLtEVDqpBqKlRxhl+7vrmYLh40eU7tXUn6N9yjwkEmtJxm8tlcepbaIWzeSAzdn
         WU7uPn0eSuM8HB7GJTUL5IHPY5uHds1a/Qs6EiHup3dR9En2XsI8V+S807MpEuWmCV+Q
         zwqYAsPY77GWnWRl/+uFdEJguzuGR+9nZ/emqDJz5ChP2qwgJWhi0vWXM624WjE25T6m
         2RWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739282231; x=1739887031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nc2Fbe5I0sSQTKOy2ZPiGOXHCFIjUyJawnB44aSJiHk=;
        b=n9Cwh5YRopFKVAjxCYHEoIU6FPjF1oRyjhj59Cla5pQ5Usf7ynDdFu1atG4WTaIf3B
         soRx4oE8m6NIpjUR+5HCjVSTHGlT5v8wXD73LngESE+a6s7SWxbQOyjGzChCQwJLln4t
         Bm7FJxdKzmp/cIokLAY1BdqJbtLgu2WDS35zC8z3MrCQa3iRBDOa1yvPhjUg23LnjtBF
         MwmOz82u/r0gyaOv6oS5skmR1dfA1eNU0WY5OhkvD3oJjJ+1NGwG/2JV2FbX6I6AGkSg
         Ui228JFhe7N7mE/gIm51SXVkOVQtqgaWxcDOx0QgIdG897uOWD60OsnNJ59OXytfroap
         lL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVj8b5DVLiZSE8rrfwJU/7V7QZyvpYQaATHDiovKnDrVcWUDvQbpNf3kJQ1N9NT8PA5BuWLqtNk@vger.kernel.org
X-Gm-Message-State: AOJu0YzP09nTm+4958KOL3JAvjekZeQnsuwlNSUcAQZv5BDapObIeEBG
	+mJlkqdRloa/76dhDo6mCjIwl2vK9yjlarh6r8DqU9aF9ewoBClb23RrAli2/dA=
X-Gm-Gg: ASbGncudVAELU+lKCk+NGl0Stq7DqeAwrl+wDECvDm3aRPGfSlWBr/Km261u9XgBfao
	un2t1IOqy7XuGX44ULJhPsMLUe4fYj33aEcjcD5AZ36/DfS3Cgnd08jwKqW7olTG2835XdCxjG+
	20JBWka4AO73cb5Sb+BBRWqZ59D7SCiNTQUQOzj1T34ZLzzrMgHIhYyNjGr3/iJrX5/bU4sHuYx
	FA8FYeG6C6CIADxOnSoRqjgxmE/sy0elKFNmS4fvEVt7rfpR2aPQxd8GS68KrFXTTtoD5DYBFs1
	BXG3PK+r5OtTBgUKJg==
X-Google-Smtp-Source: AGHT+IHOOumXj+rsEvDgGNfsD2H40sBsAx3FPNbbQOsVuk+Cv32qwjEvbWYK7p7fjHfp7cQhzJxRyw==
X-Received: by 2002:a05:6402:321d:b0:5dc:1ec6:12bc with SMTP id 4fb4d7f45d1cf-5de45087800mr21024023a12.28.1739282231515;
        Tue, 11 Feb 2025 05:57:11 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5941e014sm7157341a12.50.2025.02.11.05.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 05:57:11 -0800 (PST)
Date: Tue, 11 Feb 2025 14:57:09 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Wen Tao <wentao@uniontech.com>, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: validate alloc/free function pairs at the
 start of blkcg_policy_register()
Message-ID: <i6owvzwb4pjg27tex5utdzcoyeeawqejegvc2byz6tnfn2flmh@2ggun5qyokvs>
References: <EE1CE61DFCF2C98F+20250210031827.25557-1-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dllvaf3vwm2keh2z"
Content-Disposition: inline
In-Reply-To: <EE1CE61DFCF2C98F+20250210031827.25557-1-chenlinxuan@uniontech.com>


--dllvaf3vwm2keh2z
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] blk-cgroup: validate alloc/free function pairs at the
 start of blkcg_policy_register()
MIME-Version: 1.0

Hello Linxuan.

On Mon, Feb 10, 2025 at 11:18:27AM +0800, Chen Linxuan <chenlinxuan@unionte=
ch.com> wrote:
> Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn function
> pairs to the start of blkcg_policy_register(). This ensures we immediately
> return -EINVAL if the function pairs are not correctly provided, rather
> than returning -ENOSPC after locking and unlocking mutexes unnecessarily.
>=20
> Co-authored-by: Wen Tao <wentao@uniontech.com>
> Signed-off-by: Wen Tao <wentao@uniontech.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>

If you consider those locks contention a problem (policy registrations
are "only" boot time, possibly module load time), then it's good to refer

Fixes: e84010732225c ("blkcg: add sanity check for blkcg policy operations")

> ---
>  block/blk-cgroup.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

But it's correct,
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--dllvaf3vwm2keh2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ6tXMwAKCRAt3Wney77B
Sc0OAPsFfyTtfA9SZMEqJj2m4PnsUJUwkX/Vql/KV067dSlbYAEA/XZ7eLxelz4n
RI4kpp42WYSfhwBMT9/50Ya9coA9eQQ=
=IM8w
-----END PGP SIGNATURE-----

--dllvaf3vwm2keh2z--

