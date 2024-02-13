Return-Path: <cgroups+bounces-1488-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AF385255E
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 02:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C3D1F24E84
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 01:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5537A4207A;
	Tue, 13 Feb 2024 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxHJvnaz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5D942AA8
	for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784192; cv=none; b=ZTN8V+WpFZMO+FFn3H1Zofo3ke/XQRwmgvO+Rl1liqr4L8wTs5N9WQboRQ5jvcEBLkO8eQWYwKHpim+RG8JCrlpSOKvGqeqIsPLZUEzzsVSkxAOdq732QnnEWjRarsf7QbrpZji0XNDJpGCRgNq8XUhNjHusrtljRFjXERofREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784192; c=relaxed/simple;
	bh=i7DhwlNZbfI88wM5HL3Wb4UfNpC0zihYetLYTTKTM4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/rNi3ceGgu3oDcxmobu7I7iTWhDsgBgbt7tFGMgC9HZAYtLRSAMnmN67Q+2G3suK+Tr3J0CI36T+OQTDOla9gbPKmaczE8gOWDGAOvwCXoPMgaN56jIZZUv+AMi173Kg+zKEDQcmsf/wubnp/Ssaaz0g2dOCrz9UwHG2fPKrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jxHJvnaz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d751bc0c15so33336965ad.2
        for <cgroups@vger.kernel.org>; Mon, 12 Feb 2024 16:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707784190; x=1708388990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKs+1yTn2Kh2ROZPp6elsN7agahGkRma180U23twrOk=;
        b=jxHJvnazAsBR9YXg0Lti9Uq+sKEDcMaqmCt3QQp9dTbURgxF9JcDh0Z6a15H8bpk+5
         0j5dRsQ2Y8mD7keGH6fVd3gp5IwOsy6enXs20EtjFFBdiZcsTlHlHXagA6iIWsmo2jv7
         6xBzFlnbwfJ2agJCf+t0AVuXFH8I46uXX1+v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707784190; x=1708388990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKs+1yTn2Kh2ROZPp6elsN7agahGkRma180U23twrOk=;
        b=s0k+P5dGs8ltJLEW0x6Zjm1l+J35xppwKIqvTR7JLn/4JFaBsFdcpOGoK2NLoCWFXf
         Rm3BuP7ZzJXE8DbHwxP/8FLnOl8wIwdl3XO/dZMr7QlGd6v23WPZ7d0cDxdT+sQk5k13
         OHOgpHGoWfAvMJIUg6zEYRSACuNa4Re/uGnJ5Uxq2b8My680y7vuS0WN7R9a4Q27YL4u
         1JZe2exekfAUzn2MyUNeVmEJScGhs4PE86wypNBnIfA/e78tqkaejC2HMltOgaRQ8M1v
         dQNPTuqNNXt8AUyw3DPJ4/ejmZobY5RR8UCv3axwqA9Ka2xQ/my5RRAw9Hgy3M5cGIo0
         5fzQ==
X-Gm-Message-State: AOJu0YwZYEtWnBRhB7eWOSlHJ4kdtMDfZZrvW09wJznwqMndHP88R2Bj
	8b+mEtbSSmtd6x6WtdXTPndvPJYfJR1yVKnfSB2UafaM33EcyhhXbViMvGdgIw==
X-Google-Smtp-Source: AGHT+IHwo9JREPBJ3sxdF8GWr7reDb+peYhSjWEF2iPVp+uKldnx5Wi4BPoJAaVADJtH3tNhLI+aog==
X-Received: by 2002:a17:902:eb8e:b0:1d9:9774:7e8a with SMTP id q14-20020a170902eb8e00b001d997747e8amr9851611plg.24.1707784190141;
        Mon, 12 Feb 2024 16:29:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXI9rzAigYfhPKNt2n4dwbGS6kodvPrUI6WvXfXxDiWl3qz/Yc6hc8PAI3K5+rhuv7VxneIKL1WTi5hS4PYL9zwmQTG26bCSqQP7n5E7qPtPrlkUxAI6X4+qQrQ+0nKE2khQ5hZnzEcn6l+hh8JRZ8mCK3LUbyV2vZxvjUkn/aavw99paadErkUqPpGKvxRRQUsKJMaX8cQtKdBdqeT8ZCl9KyrO97VqHfypO6wjAKaIg+kHpkf1XRclb9ti00RIJtRs7PpPk+wPwZIdGL7AKnHLuY5YZCc0OIFgsS0jEvVrPcoGcjJ9Ue5iAd2lxuG7mSnwNeX52eQdflyPh/+G3bVmItPWPDYFVFGC+wTxtusr+022g1GTuiVtIygFYTjmkMSHdiVeoq6fgy8MMz5BbJmEythjE7zmVfycZruphKS5r1FAcbNX9/lhCqGcmrfbAR4LUr+713U/Ljz6fP1ce02j1LOvCNJ7bskwAXmwFtFiIpuIx+mm/pRNajn7VYvpTd9/ZW/ANkl+1wWLyNEMPk+OjedV1ket+elHAFMO8YFMRdaCI2m0rUXNAoGKiYwKDIoNG/8YT0fFGMC144zHkdz/s7sXzvHw/M0A0uiVmKOajiPvcWMoYINIqjMBn6uDqHRLhVGOxNz2qKCnuffsUEdBtR3m/DPnJYWAri4M7xFds5VxOA163n/4pQMYgjKBy6Czmt2ymeIzD+8HeJ6dmyfBDvZSKOdtY1AKpPsi3uHCrCHxPtlnw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902e90300b001db3361bc1dsm164880pld.102.2024.02.12.16.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 16:29:49 -0800 (PST)
Date: Mon, 12 Feb 2024 16:29:48 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <202402121602.CC62228@keescook>
References: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-1-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:46PM -0800, Suren Baghdasaryan wrote:
> Low overhead [1] per-callsite memory allocation profiling. Not just for debug
> kernels, overhead low enough to be deployed in production.

What's the plan for things like devm_kmalloc() and similar relatively
simple wrappers? I was thinking it would be possible to reimplement at
least devm_kmalloc() with size and flags changing helper a while back:

https://lore.kernel.org/all/202309111428.6F36672F57@keescook/

I suspect it could be possible to adapt the alloc_hooks wrapper in this
series similarly:

#define alloc_hooks_prep(_do_alloc, _do_prepare, _do_finish,		\
			  ctx, size, flags)				\
({									\
	typeof(_do_alloc) _res;						\
	DEFINE_ALLOC_TAG(_alloc_tag, _old);				\
	ssize_t _size = (size);						\
	size_t _usable = _size;						\
	gfp_t _flags = (flags);						\
									\
	_res = _do_prepare(ctx, &_size, &_flags);			\
	if (!IS_ERR_OR_NULL(_res)					\
		_res = _do_alloc(_size, _flags);			\
	if (!IS_ERR_OR_NULL(_res)					\
		_res = _do_finish(ctx, _usable, _size, _flags, _res);	\
	_res;								\
})

#define devm_kmalloc(dev, size, flags)					\
	alloc_hooks_prep(kmalloc, devm_alloc_prep, devm_alloc_finish,	\
			 dev, size, flags)

And devm_alloc_prep() and devm_alloc_finish() adapted from the URL
above.

And _do_finish instances could be marked with __realloc_size(2)

-Kees

-- 
Kees Cook

