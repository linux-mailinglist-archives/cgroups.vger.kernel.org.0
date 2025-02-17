Return-Path: <cgroups+bounces-6562-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DCCA379FB
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 04:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216F2166D45
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 03:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EE61465AB;
	Mon, 17 Feb 2025 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLgHKZg9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5828F3;
	Mon, 17 Feb 2025 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739761250; cv=none; b=Aev2jUBWE5hkank7O4nrwnNsM/eWYR7Blyo8Ejc8CdlqbnoasMtm/TwnUoytuGqR5IvA50m1Br/g0qEu1gooQTFaAaaULsh5UiAH2BDGMujaTsWnKxLCxoX2gTaDPRrShkKmDrhhFPDQwJkPBWOKkxmeO5uubEI6fmZXxmo6KAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739761250; c=relaxed/simple;
	bh=098GAOcKJg2uwNyJFgX23kEQUSWjMe3wSSU467lSHII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3m8iEtayHj/jDhV39h7at7dfttRjXL+ByUFALZ9K0kgXwDHRSwtbI++f9Zx34irlSywW1WjChL1sCm6a8RUwOZT5uBmqkv3eIL+5rE5b4VVASPF6P07rgVbVPNw+I+oppIRiFq8z5Ogm3riZJ/fxxoQH24ryotUfcwVr2T8UQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLgHKZg9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fbfc9ff0b9so5841339a91.2;
        Sun, 16 Feb 2025 19:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739761249; x=1740366049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RM9oXdBZNW/iQqyTSg1FXsRacwBHB2wVEo55z428eLA=;
        b=TLgHKZg9laGqQb6IVf8mPgbHYpAIkvUERX7kWfGlR7aEO4OOZQD/k5/fFgv6Em17BQ
         VfGu4lXHRYij9jRIvRLZs4oaVb5HSrNDtNCLSxv9s/u522XISRfVmZc9DV0Ei/wgxSyi
         uR9/RyeYs4kJ43uKqf2iAM0HTtqML04D8qb7eSZhXrC6yH+OV3X64izVbleU0S3B/Tna
         ndjnEzoucHvuMLnL59ODNENojTEURralLsw4DgMbEug7Ka/Qcy1w2TRfSJSz04lsxVY0
         lvVSdB0xJPkLgfmUtlXrZ3jjKcgcWvVBSk9fs/6/HYndjO7lW9oSxkpshqFaOn8zUguw
         jylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739761249; x=1740366049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM9oXdBZNW/iQqyTSg1FXsRacwBHB2wVEo55z428eLA=;
        b=h3owaFm6f6yIOT0cAMRPeU963K2QiXoskF2N43rYges4X1MblK8NIpEK+U5ZmHvTgm
         6Z7WyRcLon+X4z8AGJdGHykqoXcizMKqlCi4hTMDJVi9KlsMQUzmooDwU+WEYCmueex2
         EaNg+/xfFE6mAyB/+ctvyAceJxceGldTH6MNQ0Fo9xdTbOk5kK9p+qSI4X0tkiy+Othm
         bn+0a+/f4uwsXcF9qw7nhDt/Bx14wp10YskAlfkOXWYDYiApPPqsZTshk8+ZCM7pAv/8
         x+5mOzLYUOAPi3yvYK5ZHroaoMBwnS7At3hljFysqWd2ODyZ+78R/L+tZnAtKeXGwQD7
         TKkw==
X-Forwarded-Encrypted: i=1; AJvYcCUu0DUty1i4BV+keeE4eZXdE4dzYJr+peqx6YZeKwnvGMoexGvz/vT70SjJaYuTp0bm0qfg7FCvOcGHW1Sd@vger.kernel.org, AJvYcCWObp4RU1otE+20/Ib8Ssd/ODLmvilCZUdcXjQswB3EYFBbcqS6pIL74O/RaU5uGpO2vMb4zmZC@vger.kernel.org, AJvYcCXyDAzgPXDbmXJjwOO3lVqxCNo5SYwtCfzcE6aDHVbjep/Yd/hlLFR+wi0TVvhUzUErm2mVHkrM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/53Cj+TWostcubFgeqL37t3NIET5oEJZXqVcLX2IUST11xrT
	GYsPFLtbLK5XN+CaaKViyiS+AYamfaB4oL+TCbzsbDgi1h2HcaEb
X-Gm-Gg: ASbGncvLWlQ3bZkHOLEIdsBd3SDL//5wGthwrXXxoPwcXPv5uzdhfCSO5vClbI3GEq3
	fRke94GA0XQdpZ7Y7YgSTIv5SauYaf3+1q4x8ENUZOw2ePXiV/idbzqrCTOoPjicYkri/3M777a
	wewBBH3dzL7pZbwPcp26FJmKIjenjeeubwDRhmafjFopic+EOZNq1g4lnJNFSDf85f9IM/oqYge
	PCGn+SiRsBuTSeskpFzNuVRNrvvOqqQ5lF8WhHc17NmewEpf97e5DQScB3T4DXgKjAvR0MxXZgc
	nbTbSVL8DuvP6hlURwzL
X-Google-Smtp-Source: AGHT+IFlbZXzjTjaiCfw7RWv2kRvgfxitjDjmHfqC8UYJCSB2hhBiRs+ip/IcfoDod4m+VWndDNKwQ==
X-Received: by 2002:a05:6a00:244e:b0:71e:21:d2d8 with SMTP id d2e1a72fcca58-7326179d668mr14480366b3a.7.1739761248651;
        Sun, 16 Feb 2025 19:00:48 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265678abasm3272624b3a.27.2025.02.16.19.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 19:00:47 -0800 (PST)
Date: Mon, 17 Feb 2025 03:00:40 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Aditya Dutt <duttaditya18@gmail.com>, Shuah Khan <shuah@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests: make shell scripts POSIX-compliant
Message-ID: <Z7KmWNNIsXCnhiax@fedora>
References: <20250216120225.324468-1-duttaditya18@gmail.com>
 <Z7IOR2UNzjy7cQA7@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7IOR2UNzjy7cQA7@slm.duckdns.org>

On Sun, Feb 16, 2025 at 06:11:51AM -1000, Tejun Heo wrote:
> On Sun, Feb 16, 2025 at 05:32:25PM +0530, Aditya Dutt wrote:
> > Changes include:
> > - Replaced [[ ... ]] with [ ... ]
> > - Replaced == with =
> > - Replaced printf -v with cur=$(printf ...).
> > - Replaced echo -e with printf "%b\n" ...
> > 
> > The above mentioned are Bash/GNU extensions and are not part of POSIX.
> > Using shells like dash or non-GNU coreutils may produce errors.
> > They have been replaced with POSIX-compatible alternatives.
> 
> Maybe just update them to use /bin/bash instead? There haven't been a lot of
> reports of actual breakges and a lot of existing tests are using /bin/bash
> already.

+1

Hangbin

