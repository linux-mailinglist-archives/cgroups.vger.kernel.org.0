Return-Path: <cgroups+bounces-11831-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6CC4F980
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 20:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DB654E06A2
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5FE3254B2;
	Tue, 11 Nov 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TW2LZWqL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C22571BE
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889149; cv=none; b=b/SrgTxj68eO5+2dVPjnraMVNEwyEa2RIQoLe+ScI4S4sPI38IoHf3LVhASDXY/fB4CqIXGlQTeAq4YB78MgTDlo+CCsVY0W3jqJtQDnaxSoIB/ncffZrg9jS00N4wGv5+XjBdqEXnyc16xj2p75S2Mitu7xuea5qxhrS1V8/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889149; c=relaxed/simple;
	bh=DgsqQNap0feVYlCkdJ8GVil6gBGlQ9IiKSKSA1vgS78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liao6S4Zhiq2iPy7Z7jjXgFxcBKQF5/2qSb5KE5IQP20SM2rtwxY8YgHsUqTjPirkYNkWb1olPfCl0u8YTu/URC7dxxIZlvAJCwrVpwHEZuJufGTUuc2Uv6YdKy1IVVTiGCqeaxC4vECg+FSvWDozxQKimwUkWsXesP4Y65EkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TW2LZWqL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so582635e9.0
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 11:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762889146; x=1763493946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgsqQNap0feVYlCkdJ8GVil6gBGlQ9IiKSKSA1vgS78=;
        b=TW2LZWqLsng4T8jh6y7yEI3YeoANn8hKUphuWUlIDr8N/HR2Y85CHKGKQnBPKExnqx
         IvtHjnHMQ3KsiwaGptUgC0MFNMjqE0BukPCVYtvcsfCgtyfN/N5snRKbu/hTfWhaf8ZN
         1YaoXU/JJ+cg+qQRHF32wouanP7zji6HW94MJutA2BmeBof0ZoLXM2m+XXJKjV1vvje/
         srKmnac3RL6e1QUxrZfkl+x8pgOlnSkEHsyqVqrFcTOv1XJsBufTuZgeqgS6BPaKjme6
         hO36bL3GBwwbLi6Id1uP3JFW4bvPbX9HbVeEW1csvLbgmX7AaMGbz09Qd5zZtihTS1qG
         uTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889146; x=1763493946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgsqQNap0feVYlCkdJ8GVil6gBGlQ9IiKSKSA1vgS78=;
        b=rvNowfl3+A+WiEygYcDKPEfJK7+JOAqtrCcadxDop1okbmrnBahfqlGNG3t3LOY+p4
         OCuIATV1Din94al+mjU7ehxiOm8g9r8SMuZN6sxGs63S7dgRf1Y+txpIcmpbXwY8xqmI
         mmk0jkP7x9XChvyRrpcfdwLAVfU7urmDl2t23jZ02sCWdnNJKz7VO7UNQEyxm1bHmJTA
         VXviS5IjQKhZhzNzv323KxU0S/HbV1Aet4WnfEW5Kh/aO8E+1yh7PCIZ606x6ZY+v0Vi
         Nnj7BneKOQQOTBlYv2pJ64O46fCt8x3w2q9tB9nXZl4ql2Dhh0y0vgS+So8VyXuiRCGS
         q6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD2cXX8UmypomMFT5oxhBIVxQk01z7FGul7cAYma5BJjBwAnH+S7BHi0m1hCwtG6FtVza5sZW0@vger.kernel.org
X-Gm-Message-State: AOJu0YyQgQED8DOU4pQhDF+dOOuaQSswPX+3iImnHzfTtaiYxtX4h9Ct
	RGzSK+QbdBH7igas6ViE7jMaIKy4xCj6xrLwxfNag3XabztUV2wLywofRoBN0w8s73w=
X-Gm-Gg: ASbGncu0p1952wSZIIozrfxelnwG4NFGShvu0cd7Gz8sjHcQhl/aDMGll9zVd2hvKur
	J5DlXnQEPmL9WlaioLxlWbbOSyaTTzpsfDtl0Bc6ShhspM2uYNdELD9nVWT9Oqu34aHCJZFrrDx
	fMSr7UhTGmeZGFyA2X+6Cs8dSebyTW/VhvRuzqyU/ZOxXACGBJWBSWZkO1hQ2jWhnpWwQhe5zAq
	98Wda5HPx0x94vzDWc/anOZ/M5mR/NHLPgrYq9oqijhrmtCLiSqTic7CJloU2ftv0lGq1dNtm+/
	atYFgzx/K3EHOC3nLguAp1kweImnVvzsfz0LUJyWKTKjEq3joKdcD9irBcg09ojduNMNkmk0/IL
	0/grcjFNCggEPFU6SlSjFGZscbgFzVsOuR7PSGbknkoy0G1+MFCtXCpURNl7VYWdxk1d/ZAlenc
	HnGzpZVfwT9lB2G4AFYZZKq/pOgaWZLCM=
X-Google-Smtp-Source: AGHT+IHZU628pAQZAAnaDo67q6kzqKxyu+R+dz906SsaPb/vvBufNcxi/AkBkAwdXNlsyQ0HAiMCOA==
X-Received: by 2002:a05:600c:4714:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-4778704ea68mr4696785e9.18.1762889145924;
        Tue, 11 Nov 2025 11:25:45 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc528sm397981995e9.7.2025.11.11.11.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:25:45 -0800 (PST)
Date: Tue, 11 Nov 2025 20:25:43 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org, 
	hannes@cmpxchg.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
Message-ID: <sebxxc2px767l447xr7cmkvlsewvdiazp7ksee3u2hlqaka522@egghgtj4oowf>
References: <20251111132632.950430-1-chenridong@huaweicloud.com>
 <dpo6yfx7tb6b3vgayxnqgxwighrl7ds6teaatii5us2a6dqmnw@ioipae3evzo4>
 <fed9367d-19bd-4df0-b59d-8cb5a624ef34@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fvxxsanga2y5s6vi"
Content-Disposition: inline
In-Reply-To: <fed9367d-19bd-4df0-b59d-8cb5a624ef34@redhat.com>


--fvxxsanga2y5s6vi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
MIME-Version: 1.0

On Tue, Nov 11, 2025 at 10:16:33AM -0500, Waiman Long <llong@redhat.com> wrote:
> For internal helper like this one, we may not really need that as
> almost all the code in cpuset.c are within either a cpuset_mutex or
> callback_lock critical sections. So I am fine with or without it.

OK, cpuset_mutex and callback_lock are close but cgroup_is_populated()
that caught my eye would also need cgroup_mutex otherwise "the result
can only be used as a hint" (quote from cgroup.h).

Or is it safe to assume that cpuset_mutex inside cpuset_attach() is
sufficient to always (incl. exits) ensure stability of
cgroup_is_populated() result?

Anyway, I'd find some clarifications in the commit message or the
surrounding code about this helpful. (Judgment call, whether with a
lockdep macro. My opinion is -- why not.)

Thanks,
Michal

--fvxxsanga2y5s6vi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRONtRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ahc7QEA5UPtVb+rnzLNsHbbUVJF
jcpVPCYID/X0o4LSGY1becwBANqmtiU88ZCjE1AEHTo+l0lM4C2vXDmymf0fBSlI
m54E
=MaQ3
-----END PGP SIGNATURE-----

--fvxxsanga2y5s6vi--

