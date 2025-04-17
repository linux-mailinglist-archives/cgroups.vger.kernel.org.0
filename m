Return-Path: <cgroups+bounces-7610-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7728AA917C5
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 11:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A6C1717E5
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C86218EB8;
	Thu, 17 Apr 2025 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VHnKpn/v"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A08335BA
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744881982; cv=none; b=FuP209tIo3g72XNln7CN9BA/fzZ61VN5V9DTmKliiU8TicAFE6S2ZO5EqYZurdghYCCXCL0snmgZa8ORdSz8/eNajzxAp21Dnn5UW3Am4/p6DESwmhry/JK4GGTUBcvHlIPxWVRv8Xx6ralBPBCW1rLlVdWSF1PdUgzOU37CkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744881982; c=relaxed/simple;
	bh=eh3FbWA9+X5UO9ZStp4ZOy/ysn98/Ghz+ntZJvZupfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoA9w5ThJwJyE2W6f7kwFO/8ygkF0WtI0nYmAqxSu/GAHy643VCyecUc8m28utvwGoAhnrAIUNOWiNDMcyCbrLP1HLP0bJRUhGXQYYLVLCopjlRG5ETv9avO11kLq/siVwxRUwb/YgQ0S9Gl7GqojY3EBg4ehF7+ducZ494Wwso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VHnKpn/v; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so4433415e9.1
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744881978; x=1745486778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eh3FbWA9+X5UO9ZStp4ZOy/ysn98/Ghz+ntZJvZupfY=;
        b=VHnKpn/vfnhB8e4QHWVue50OyTZe4yf256xDWe90giximlae3EpdiGzDFRYNijRD6B
         snkQNXIBUflYhjF8Zc8p2RbEW2GnqFlOcU456TtTqIri9KUjTP9uPRFeUgNKx/rs5K7e
         z94E+R6gnp3RRYgpgjlrSc1c9x7/AVeiYo6V9XXuJfLn9AK/m89CfM4oAviVhn5Ha/M6
         xt0f+1On9c4dYAQ0eZ5trKSMdS03yZhKCx0D7svalsRvW+D+BEdonoiNqQxnGjz3PRIn
         2k6GxGq5YGa4adhoRCCbizrM5sV7OPjZT+mEI2VRT3wZ1EtDP+BaXNbtlCATca16jndR
         tHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744881978; x=1745486778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh3FbWA9+X5UO9ZStp4ZOy/ysn98/Ghz+ntZJvZupfY=;
        b=dfjZNhiMW3z/YmveU2G44b3X2mIvMw9CbEf1gW+l27PAcFBNRQ4ziLZY/50jDgxcZl
         GyYFKcGH/oPNUT53iQXjzADUOGuI3RUzbeBf5xkP6eK1ncdp0XRTSAZB5RQ0FiwB6uwW
         cPA5wNxFMTSdVSBINPWWq1qnmNkx7t+7NSnlYvSkfabYCrtE836EN11g+jE8jCOAuzuY
         JTqoIupsbnMHT0RdxWPmZFihNvyFRy+TSG4M1cdZqiZ+PDyl09tcl9H57NumGiJnBYW7
         dBV2XvlwYKJ/tQrRqcLa6HlZw9n7LKTH5IzuyN7Htp7/BLHJ2RCJBVYqEX/0f3XGosqx
         uvkA==
X-Forwarded-Encrypted: i=1; AJvYcCVdyHhQd7AfDK4LVPX4Jbght50/GLWSyYphS48+7fcz6zaNtlIWZPDE9iKtAafxu8F9DqWjy2Q1@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVaiONr3mMbgDwLO45hCnAyDraKq+4Y3tH5oBKXWn5aGTvZSG
	5nsFUPtU/UUFenW6ri2a34113KSoS+oXIMty5/qTL3nOYqkT9Ro16aDewkhiwyk=
X-Gm-Gg: ASbGnctWSPzia/cilbfWZvTVUAStT4Y9BaVgTOKdidA2cnd5Cc5qkWnba4/j4NnkFQx
	wiWKVPtSSfu2hC6Hz6YkVRS5LiKpuv8t+2zLYabXc3YkcDE6P2aKxmy6Wvm1yxGyI5835sufmFY
	G3h0SDO0RgZcAn+Vsccp3vnz2W9ZWpB1bvPgDkEmQ1QuDwrYvwXr0WllBaEk+wfYvFHQxPsBTv4
	e20KelCgHonb6oxOHhgJMbjkygDZvrvhWp3EeepvbLym5iEXhk4U44Mx/Gt1pgjMBRGieIYRre9
	d6geVc6uSSH0/DW3cAbQEBq5SpD5TVotRnyA+19c6eRdYMszGxwQ7Q==
X-Google-Smtp-Source: AGHT+IEYxZTVXO5DYDGO2NhL2DmdIqaG2JEwEOEFvebpkB3/U6Fhxi3eBBqbMph8OiK0cvolOVKBzQ==
X-Received: by 2002:a05:600c:5027:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-4405d63755emr56733195e9.17.1744881978549;
        Thu, 17 Apr 2025 02:26:18 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b512c52sm46125615e9.30.2025.04.17.02.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 02:26:18 -0700 (PDT)
Date: Thu, 17 Apr 2025 11:26:16 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 4/5] cgroup: use separate rstat trees for each
 subsystem
Message-ID: <oi3hgft2kh44ibwa2ep7qn2bzouzldpqd4kfwo55gn37sdvce4@xets5otregme>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-5-inwardvessel@gmail.com>
 <2llytbsvkathgttzutwmrm2zwajls74p4eixxx3jyncawe5jfe@og3vps4y2tnc>
 <88f07e01-ef0e-4e7d-933a-906c308f6ab4@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adoqqezhfiw7oyyq"
Content-Disposition: inline
In-Reply-To: <88f07e01-ef0e-4e7d-933a-906c308f6ab4@gmail.com>


--adoqqezhfiw7oyyq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 4/5] cgroup: use separate rstat trees for each
 subsystem
MIME-Version: 1.0

On Wed, Apr 16, 2025 at 02:43:57PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
> Hmmm I checked my initial assumptions. I'm still finding that css's from
> any subsystem regardless of rstat usage can reach this call to exit.
> Without the guard there will be undefined behavior.

At which place is the UB? (I saw that all funnels to css_rstat_flush()
that does the check but I may have overlooked something in the diffs.)

Michal

--adoqqezhfiw7oyyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaADJNgAKCRAt3Wney77B
SYJkAQCd8f1aLLSF949AecH8ekZpzNp13svNWdB0GafmzM3cfgD/VvH4N/d8V44i
lZmPnX3zoANmFGwJwXxUG0/mzT5A+gQ=
=9emt
-----END PGP SIGNATURE-----

--adoqqezhfiw7oyyq--

