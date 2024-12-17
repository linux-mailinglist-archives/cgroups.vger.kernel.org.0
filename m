Return-Path: <cgroups+bounces-5930-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910BE9F493E
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 11:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37051887AF0
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1559F1E5726;
	Tue, 17 Dec 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N4a5e4Pd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB031E3DC3
	for <cgroups@vger.kernel.org>; Tue, 17 Dec 2024 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432806; cv=none; b=um1e8WctSa9dq9rboKZ9S1CSflnGNY+n0A0vUNmMmIAsaDh6fl9qob7fmLMb2gjUJnwolcX5WqXU8sj2OF2LuXqfN5EVGS7zmEl6vxqJvM+4tHwonIDve5AUPaNXLmjNEYbV5fA0MNxXNi/Jbc/xCsDv/l0GWAVcMWKn2HEnYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432806; c=relaxed/simple;
	bh=d7+9BW8K4QewUbP2jTwYy/PCXEZT3VNk+0tHz654lX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A566CWj5IMCEIDmrybH8fEZe5PRtlhzd4bpqC9cv7XecMi7RNtRrXjXgV/D1VxSNyr7+HinNYQWQZpEo5xyMx6HTz53pr03Iri2ssYvPkNTajqDAfSU4AKtJBQiLvxymknBUkRq/fDy6nhLWnW73Tzjszw+WT6DMTcK3Z3+MJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N4a5e4Pd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso31857705e9.1
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2024 02:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734432802; x=1735037602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=msWP7diS2kvFRPcBtc78wsxhKDUMb7ACTfsyYyoqYmo=;
        b=N4a5e4PdJGed1xudNG4DA7ccNZNcQLT2whdrcRKF78Go3HzZmBQlhRwTmIzSYnkCpc
         0v68en7gSuuk6mG3vnZENgvtUKBsYEhVqYaPU+lBoLUG7iwbFXxkbc6ll/G/PihZFweq
         SPW865jn0S9TlpfgPtqDLvHYvCICgLoRiyp6zL0bPvHiUSGCfp97A/eNtRCXkgB0HitP
         zs7V9xOD14wvTZO367htj6Btk94W+xy/WhFzsn3v+dWHHbsB2RKhBOAwVyOp4MQHjDvX
         1cjZAvMt0VlbKFhWNUdmFTUktBv2v2wrXqeqELhilVaTNgd2NUrKVjWs4Mz93yr6YQPU
         YDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432802; x=1735037602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msWP7diS2kvFRPcBtc78wsxhKDUMb7ACTfsyYyoqYmo=;
        b=iZ7U//CdIQsYnoHCj0K6IhWfGdudDkeI0GOxmpQxmOC7tw634JEfqtCH7/eRV1JyfZ
         3rQoyf3sKfsA954OF71YpI9UBTBIi+0PBzpC+8pQuoB2h6+dHfbkgQKYmPo19sDJPx/x
         dyU+vjTOaU0N45aKhx3sWfrirr+FoH9gfVNLn7R0b+zQDQ6gUyx2c8gv7/RM1JuPjhnr
         A4G5Xt3vRfkyQSDqAywLypc2E+U2bgkoe9hXCeIGIOYCYKGch1q7K6uUs9t+gJ9TJDzw
         8aV2aI7Hb28fP/wLjoFIlE4ZH81Sr8C1x5PJ2q+wwNfzqbHBXBu8KWQ92OY3fpRSu+em
         4qmg==
X-Forwarded-Encrypted: i=1; AJvYcCUagL2FixpW34Po/DhrEgwGg+eUWKjxGlhlQNHhBgeQNPW9Xb62LN5Fpqrxfa92Lg8RmBwTUyzy@vger.kernel.org
X-Gm-Message-State: AOJu0YzmN9HSn7TX9J/CFf7/NE0jim6a0BF7oknKy45ZcLb0jUSqzTDP
	qCRzEAZMiH5r3HHT0f1iOo9FSEPt+oeY+uOqPoQm9ncpqnTl41NcsetYRVqT4Is=
X-Gm-Gg: ASbGncseMkGVMXWNzNUBOrY0iz/xU3CfKxVSNPoE98DsE0DYpKI9fLq7aP/7d4542X2
	1nY4/Js+yFfMT8sQZl7jsZi7SKPQTBVOHvy24sSW9SHFVPrrSZIwoMyDTO20zfZVem5OoxV7eri
	te5vIw6QidrT6MiMz/tAZy0XgSXiyWvEqmVbiRRiaB56It2+M9/Gm+bAqkUFpL/cFmFZUsdB3Tw
	hq8ZADm6owxuqcar1b78+d6PeXvzW7TJ0bwIrgtNh9xaSjBFXw6wkHKCNg=
X-Google-Smtp-Source: AGHT+IGyfrTyYkJoCRxqhYGk1u28o0yTqWD3MD3JzLr8BdSHDbBeflaHknFdAospbyRDDlQjPkcRbg==
X-Received: by 2002:a05:600c:1d25:b0:436:1af3:5b13 with SMTP id 5b1f17b1804b1-436481ebda5mr24912215e9.15.1734432802087;
        Tue, 17 Dec 2024 02:53:22 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80162a6sm10632527f8f.33.2024.12.17.02.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:53:21 -0800 (PST)
Date: Tue, 17 Dec 2024 11:53:20 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, 
	roman.gushchin@linux.dev, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v3] freezer, sched: report the frozen task stat as 'D'
Message-ID: <vyzwumy6fckiwljdtadaqmemevqbz5p4hzc6lqdly5e7v5fner@d2oxcuwzbb3h>
References: <20241217004818.3200515-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2shnbco2dkqsvkjb"
Content-Disposition: inline
In-Reply-To: <20241217004818.3200515-1-chenridong@huaweicloud.com>


--2shnbco2dkqsvkjb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:48:18AM GMT, Chen Ridong <chenridong@huaweicloud=
=2Ecom> wrote:
>  include/linux/sched.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--2shnbco2dkqsvkjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ2FYHQAKCRAt3Wney77B
SUUpAP0cEvTsd+NZqY5PnnJFUIqwjqkYw/teDJADk5wCb/r4LwD/WpK0qoYWJxRT
H7W369kWvcsrqreaxAph545j1+IZSAY=
=vZk0
-----END PGP SIGNATURE-----

--2shnbco2dkqsvkjb--

