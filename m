Return-Path: <cgroups+bounces-5743-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA2B9E19A1
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 11:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7367116674C
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD4D1E25E4;
	Tue,  3 Dec 2024 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FrREfCdS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75E1E230E
	for <cgroups@vger.kernel.org>; Tue,  3 Dec 2024 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222646; cv=none; b=TqZ1VTODHeBLau2OcMIesaoVX5wgEStjvBDdi+EvQJXH3manPqRJ/zfbwY3KpgWipzVQlPDhZUxOZK4Qx9AQmNL1P9KzXCzFBbetbnSd/YIVl24wxNDYCC7XCyVV6G9r/g/+LipcjoPT107RNlG/W/LLK1fI7fRUCeLjtqyc9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222646; c=relaxed/simple;
	bh=iL+OdIGkXYlFltzIJA5/1Zmew0K54VlsMV2aPYAo6UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuRtodtD8YDlo5u+fFk7kk+gisXF5D5loEG2i60gKvO/9PQrt4Vhcw8F/ipR4x4MHqrMpBtQUr/ucYmyR94F5lJRL1Df23qinKUTTVqimZD+kscNPwKJDqazqwKgZoCQxUuLfy8yaf5mkpGCE9cLAQN9E5RbK9YY8xH/F2LMuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FrREfCdS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4349fb56260so46673125e9.3
        for <cgroups@vger.kernel.org>; Tue, 03 Dec 2024 02:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733222643; x=1733827443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U03OPGQRaXmE1ghscIoxpSXZHQUjfrvCB18PsXKgzhs=;
        b=FrREfCdSV2/aYsFXHTO5+1VisvRSH3XhkkNnwg2dePJ4vo5G+7A51+Lv69Aq2OccOX
         CQ8v1u0LbsDbncdeoSWDUj7zq/okhSnr5dmnyR+AabbVY7iVJX+F6896zpBFR/1przUQ
         y/r7AslBCTRCq+P09s9wizR/5V3sStFKw4yO2LxeFzZAvezUKrY+0iRnAmjCwfwHxHVM
         MBUxjDnCoxFhNoZg2lA0/xByj7Hv/wS3MhwIkSrQqmMEtiJLhLIMSY6Lnqqi7ZTPsLst
         cbQsR2qEqSxUC4moFMXwqXsJde74EubSqTPOYdq47Sdf694cX+MFBEqO0Oy5Fx5ML9wG
         hW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222643; x=1733827443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U03OPGQRaXmE1ghscIoxpSXZHQUjfrvCB18PsXKgzhs=;
        b=iIXpqfDkGmmKay2ZM/v7OvlhVNuuIGAZOoJcfqrY9V9HOxpVbFSBUdnd/UHRNUsQVf
         7JqK1QCX7OJh5GlDk/jYQlmPPZBcRNBVrhPW/6o5TzOkjtaR3O8hVeNJbm85CgSGTd3t
         aui1KjCYgDz9nAruSAPmdjAyu4rQfGV3Tnid70y7f23gnYTk2XGF89h0O+R1X6VLTirU
         EabeVMlM5Gh2qRMHE2MmpssS7RXbVikxxdBmM3b8OVI0ywW4YMKuep5/pdH6iuA8ENsS
         d+Igyvc1aHQaf9+oWepzGc979oKesg8fClYWDZrUalQoF9MlPTPYLwymILpjjv3pwiH1
         4Zjg==
X-Forwarded-Encrypted: i=1; AJvYcCVsn6EMmxR0CLogScJ9KkyyRB/vLotFYKFycmH+4XPgHjsMrFYTXlJ4Vgy84k4SHEL6/+fyn6mE@vger.kernel.org
X-Gm-Message-State: AOJu0YyyNnjAoxcVXTlrZv0PdGoG9BMq/NokNxQ0uCxLJ7bkRyTfLh2X
	l9cnA1Eg6cJaZJwwDPaHP9usNdzlMYAQM1t85QslJa7/AlSNpIheK1DuVtGhEtI=
X-Gm-Gg: ASbGnctnBOSfUJr6DchD8LLND+sgcQEbzqemscCjLZ0j9Jo8WNMI0X3KvEe2rOqsRbb
	XtXvqn2cO+97LPWAmRmNl14fU5PktPbb2bhQqc0W5XHJqtECmMDcI/b8hz+pu9FZlRQctILBbVq
	exL7lcFWaUFIO7uJ9v89a+rIKirCu1hOl4mEWIuUnCEolY7gKRdg+84xoYFfeW8Cguc33zZbzt0
	opmVqaWi0Sv8PmP/y8QcmWsLR/qAgWzs6xKK25irLTyQDQprVRX
X-Google-Smtp-Source: AGHT+IFjjbvEeALxzGnisfRqO1VWpGZ6FOPcBFJVA64KLUcBabiM0AVQuu2EXYMYgxb4LiiFJ5aWzg==
X-Received: by 2002:a05:600c:3546:b0:434:9fb5:fddd with SMTP id 5b1f17b1804b1-434d0a07350mr13720895e9.23.1733222643100;
        Tue, 03 Dec 2024 02:44:03 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f32594sm187382555e9.32.2024.12.03.02.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:44:02 -0800 (PST)
Date: Tue, 3 Dec 2024 11:44:00 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Dave Chinner <david@fromorbit.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Linux Memory Management List <linux-mm@kvack.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, cgroups@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] What memcg lifetime is required by list_lru_add?
Message-ID: <siexzzafqmgtya5jas4v5pjpartt2h4l2amimjhaaztqidapht@2rexlquzrdsx>
References: <CAH5fLghFWi=xbTgaG7oFNJo_7B7zoMRLCzeJLXd_U5ODVGaAUA@mail.gmail.com>
 <Z0eXrllVhRI9Ag5b@dread.disaster.area>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7hgwm4vbrllohur"
Content-Disposition: inline
In-Reply-To: <Z0eXrllVhRI9Ag5b@dread.disaster.area>


--f7hgwm4vbrllohur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 09:05:34AM GMT, Dave Chinner <david@fromorbit.com> =
wrote:
> It's enforced by the -complex- state machine used to tear down
> control groups.

True.

> tl;dr: If the memcg gets torn down, it will reparent the objects on
> the LRU to it's parent memcg during the teardown process.
>=20
> This reparenting happens in the cgroup ->css_offline() method, which
> only happens after the cgroup reference count goes to zero and is
> waited on via:

What's waited for is seeing "killing" of the _initial_ reference, the
refcount may be still non-zero. I.e. ->css_offline() happens with some
referencs around (e.g. from struct page^W folio) and only
->css_released() is called after refs drop to zero (and ->css_free()
even after RCU period given there were any RCU readers who didn't
css_get()).

> See the comment above css_free_rwork_fn() for more details about the
> teardown process:
>=20
> /*
>  * css destruction is four-stage process.
>  *
>  * 1. Destruction starts.  Killing of the percpu_ref is initiated.
>  *    Implemented in kill_css().
>  *
>  * 2. When the percpu_ref is confirmed to be visible as killed on all CPUs
>  *    and thus css_tryget_online() is guaranteed to fail, the css can be
>  *    offlined by invoking offline_css().  After offlining, the base ref =
is
>  *    put.  Implemented in css_killed_work_fn().
>  *
>  * 3. When the percpu_ref reaches zero, the only possible remaining
>  *    accessors are inside RCU read sections.  css_release() schedules the
>  *    RCU callback.
>  *
>  * 4. After the grace period, the css can be freed.  Implemented in
>  *    css_free_rwork_fn().

This is a useful comment.

HTH,
Michal

--f7hgwm4vbrllohur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ07g7gAKCRAt3Wney77B
SWSLAQDYSjM8dIWjMx78MOe0HwHi7Jr3Zy7NTu/rfkCngqsLhQEAq0eCFBipF6FO
zr4LRLdBi2pGv+clMNdjT1BSgdjqBQo=
=UtFx
-----END PGP SIGNATURE-----

--f7hgwm4vbrllohur--

