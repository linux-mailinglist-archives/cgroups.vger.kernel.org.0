Return-Path: <cgroups+bounces-5366-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C4D9B8C1D
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 08:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7E228368C
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89519153BF8;
	Fri,  1 Nov 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LnVgUeTN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5B14F10F
	for <cgroups@vger.kernel.org>; Fri,  1 Nov 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446532; cv=none; b=XYYk9t9hsnutMmU2HASkaWhV4KWVCBb5UaJQ1KGL/CilKh/Q8oNxi4gtQx6u40FGeDTQrX56BhnrKPncKr0KLbYa7YFuyVLNstj972ijDxsmhfUyU6zR/F+KiN1/O5Ue9CAr/WCN6HbLivM9jwL/C4pxHfUJTXtgoGyTU+WhQ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446532; c=relaxed/simple;
	bh=P0vFwttNHOzKZmv1rgw7+ANWTxzIN8kOgv/v0uO+NJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upv7ATwTnylicVIDGdMKZtjEtw01GXA44wHWPeuRhw2NUX/cP58QSO7kj80I+PUriZBVSPA/gLRWNTD8kLzghQfyp6pxBzfyZ4smvuK0r3qYlFJCZzVK+kj5H6gTsS/clZMwS7GNerhSrUbfU4NE5ATNZii6Tkbto1ysfLic6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LnVgUeTN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa086b077so196250666b.0
        for <cgroups@vger.kernel.org>; Fri, 01 Nov 2024 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730446528; x=1731051328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypPJ1NrY2u9lPq4g9XmzWPa71sy3ELLPD5dFtuw86o4=;
        b=LnVgUeTNAwK+oAKDytaNNIe5/lQoAfSQZliGwe26vxEMuaMT0b1MQmSJ7WQjA64i5V
         YHiXZwFxtS5kIKdShi0j7ErtSt0lIzYfW1uB9Sk6MDyedQhuUJ5rmJMLzPu2CTvdibBV
         7dOzgauOWfG5EACivTBkmZ1fNdNivv2zjbum2Me3hkuczhzT3ztg5mmy5LYTIca+dP04
         dPXPXTXAFyINgVLDxZVSJO+pcq8+cPgbL+rD7k9uh2c5kcUByxRpfNzoI8vXwZJ7F6ws
         1CtiLQXwKHnx2PrQU42kUUa/iTklKMG4Fm19kIvT08cA8xKhJlEPoesdgoiITucPbXkC
         Opyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730446528; x=1731051328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypPJ1NrY2u9lPq4g9XmzWPa71sy3ELLPD5dFtuw86o4=;
        b=wQDvbDXOil44GASj8PQifO1gxCMfmdk4+Jo9qrnuR4RaMHLIae4qiFI4q+8fvND7UF
         IJle4qOdDwfTwmB7BQtGLIj6DBDyRwmI4nM91CEOsmRxlu3QxR1+OJ3oRRX5vP2Uiy2C
         XLEubMJm7TXJTY2Rv4oYv9IPdIptO+kHLtLDZmkOlRWoMZr4gCLI+pliGx0McV1xMa49
         FlkJbj9ceCplADLvcwetvWvsYVOQNZ4NUlZIC26LDQ6Z/ZqJh1O9naoa5F5nQg/I6hiR
         4AVX8lhiNbuzEevrYzFgSGCwM40P7sOi3KFyx+v5YefjyQFdJEaMQutMmoFA8sv9OtUI
         /Rgg==
X-Forwarded-Encrypted: i=1; AJvYcCXuHJsyKh3AVuZGpsi/1C5BJInTES1IDMuCWUj1D5gfZ7TgHRAcT9jhaE5CxgFv/+OWqwxrsFhg@vger.kernel.org
X-Gm-Message-State: AOJu0YzpiHc272mvrBxE3jLvVft2O6Zm8USPu2+bn9MzclhvnLe47TUH
	Grm7GaU0LXuDIjIQCTZkHK3um8NFSzaaKtVQCCYWJzSZ26y/ffEeBqurngDvHaY=
X-Google-Smtp-Source: AGHT+IGE691V9XaGzpelyrEeM3zXC4X8ZhHOENA5a+Ka87tc9j22idhGt+6KNAt7B8tZ2d4Zag54Jg==
X-Received: by 2002:a17:906:6a12:b0:a9a:3718:6d6 with SMTP id a640c23a62f3a-a9e3a7f2373mr1127478466b.58.1730446528154;
        Fri, 01 Nov 2024 00:35:28 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564e96a9sm150993266b.97.2024.11.01.00.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:35:27 -0700 (PDT)
Date: Fri, 1 Nov 2024 08:35:26 +0100
From: Michal Hocko <mhocko@suse.com>
To: Stepanov Anatoly <stepanov.anatoly@huawei.com>
Cc: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
	akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	hannes@cmpxchg.org, hocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	alexander.kozhevnikov@huawei-partners.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	artem.kuzin@huawei.com, kang.sun@huawei.com,
	nikita.panov@huawei-partners.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <ZySEvmfwpT_6N97I@tiehlicka>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyHwgjK8t8kWkm9E@tiehlicka>
 <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
 <ZyI0LTV2YgC4CGfW@tiehlicka>
 <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
 <ZyJNizBQ-h4feuJe@tiehlicka>
 <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
 <ZyNAxnOqOfYvqxjc@tiehlicka>
 <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>

On Thu 31-10-24 17:37:12, Stepanov Anatoly wrote:
> If we consider the inheritance approach (prctl + launcher), it's fine until we need to change
> THP mode property for several tasks at once, in this case some batch-change approach needed.

I do not follow. How is this any different from a single process? Or do
you mean to change the mode for an already running process?

> if, for example, process_madvise() would support task recursive logic, coupled with kind of
> MADV_HUGE + *ITERATE_ALL_VMA*, it would be helpful.
> In this case, the orchestration will be much easier.

Nope, process_madvise is pidfd based interface and making it recursive
seems simply impossible for most operations as the address space is very
likely different in each child process.


-- 
Michal Hocko
SUSE Labs

