Return-Path: <cgroups+bounces-11718-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5EC45A93
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 10:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 136584EA4C0
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 09:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95AA266EE9;
	Mon, 10 Nov 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XY3ljPL/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280D1C860A
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767087; cv=none; b=T5MKIgpXtFU7S8ukcC/6sLVKe1+jqRQ/vdgHVpbyE7qdKf8MYqQxQGthIRhjdfiBtr7HtJSykUNZWhPlvNP1tAL4mvAtPtcUmraF0wTIH/pbG6PwPQb7iqM60rVJnvO3idCQ5PfUEm3enp8XK/PAms723ra2ySOaYgBGE/73H+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767087; c=relaxed/simple;
	bh=m/QU9kQD+zT8DY4zIk3dOkJ1ZJpquGhCSedUwO/1RWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaapHo4gzF4+vSXYQYyYZcTPx80lySTIri2N8O1GV1ZYH1l7mpCTcJolVlRAPMnva7Jc7+JxrrWswPttQevzeNp9ritaUYR/1/12GaAzh8ARDOtSZlSAwGtt/lvS7cfc3vBkldAdoSD7DNDarW476qeN5cDV4EdMCDhMEEWt1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XY3ljPL/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so4556209a12.3
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 01:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762767084; x=1763371884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amfX240/D0izGpL77kjzwIZmsTrj0WyJRpbOWOmEfmw=;
        b=XY3ljPL/xz1PQLkTjPFNbhtiMBR5eX9KKnZQv5AyRYFMxUWJ6VLil4Y1DxchnMjhll
         Z6Thdyt6ZTKoDRU8m+7LF+v+WIZLu0MNuQ+l7vb9kgrYO+2Raz37L9sl14Yg4kLBmTS6
         Xqc7RBHzOECH85qlwdkAKDh1VsrPu01H5K8zYypoBFUTUJjNqq9RUk7rvb/uORuRgdhJ
         0/fPp+EhkZOnkdvs7O+pN7NtttOAw9/OHDyR3QZcKp6ry65UbYDMTaUkguZWzSwRVRNO
         Q4o5zW9ZpgYFS5tnZiekPs94bXeFh4EAh2ZxSQLhxeY6yOrZgeAADEccH0blVkqIDSY8
         cLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767084; x=1763371884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amfX240/D0izGpL77kjzwIZmsTrj0WyJRpbOWOmEfmw=;
        b=w3ZVOgfI1+1l2irh0hsMYAyzqvwvXvrEZSbEZ9AAndhTnLAoAgpHtBkyeESCamURrC
         Hjf9pMMLURvAGciU7iunVi6pa14yv1gm+Ut6XfJPgFASXda8TQPDADRpcmYW6fN2ResK
         urwJROaOZ61rLBB35rhOb5ppmqV7iNDlyVilkUh62IWLkGqjgv74kTajhLjeInOmjgBR
         vl2jkIJP5YwSzKFnXa/LScvI5aqvBbklhnxy7tEVdX1obpqpqwf1P6IPu9nadwv4QMsg
         LKw3qsaeYsNQTLcp8E3lrY+z+uP2GnHRUNoyqSXK4I/HF/pgEaxvPR2JXROdPhmX7dgd
         JlMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXZ4pmwzI9UBpGoiSwLBGO2p7ViZS2XYNsjy4V3htzJ368KDgLge3LzMIKy6vXoYG6OvTFulyU@vger.kernel.org
X-Gm-Message-State: AOJu0YyvaFK85AZ77JtqV1XURwQKr0YSzGRY4nFMt5tmzP1zewApHsf+
	VsMv76OPCy5anrnDTf+StsB/cgUIAeW4c5Uli/PlzxoMJSqjN7lOHHOtGFIP8FxmEkM=
X-Gm-Gg: ASbGncsBmLWKBGB4u9gN2ObtHYEbEkaVrS3Txfg7jJB9WxgoTTXlZNWYIyI05T3x54G
	efbJc2K8RvSZHSP3uQENuRSltD9AE9gAV5uij8+cWCAwZ2Pn3M6G7ARHiW+NZxyY4cXCztk7FZA
	TrwJYRIam89ySOu2xM3WvoVpkdmesLkaaq7lN61HuPJ6NFzShXZYuPPh2KEDjZL1FnpsIjkRrOx
	hepm2kPV4w0phVOq85uCgWfbc1ai1wstrtY3bje9Z9cV1J5t20Q3cim3ASqGl2cus5p+SqufgXt
	tgwywx4BvEBBbiXLI1vKuBRTZVXNh/F17aMo4NDuYfJe1UowdR38lN6EZLAojvNU8xGaUPrLbp7
	mNjvTwy6kev2r/9yzNju8XDBZaP1a1V7huCYp+hp2lQA8awizO1vb/SScxK85Bx2ZBcanhH5scu
	WRRaGftwSCdRKFBw==
X-Google-Smtp-Source: AGHT+IE/txm/8jWMiSkfFFCpyrIegQ7dxW+BtDPga3eQ9vjewsDB6p7h+vXBqAcuv9gNMfcv8ZCOVw==
X-Received: by 2002:a05:6402:278e:b0:640:976f:13b0 with SMTP id 4fb4d7f45d1cf-6415dc11776mr5564134a12.12.1762767084330;
        Mon, 10 Nov 2025 01:31:24 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64184b6c7e4sm3018332a12.24.2025.11.10.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:31:23 -0800 (PST)
Date: Mon, 10 Nov 2025 10:31:22 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 14/23] mm: allow specifying custom oom constraint for
 BPF triggers
Message-ID: <aRGw6sSyoJiyXb8i@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027232206.473085-4-roman.gushchin@linux.dev>

On Mon 27-10-25 16:21:57, Roman Gushchin wrote:
> Currently there is a hard-coded list of possible oom constraints:
> NONE, CPUSET, MEMORY_POLICY & MEMCG. Add a new one: CONSTRAINT_BPF.
> Also, add an ability to specify a custom constraint name
> when calling bpf_out_of_memory(). If an empty string is passed
> as an argument, CONSTRAINT_BPF is displayed.

Constrain is meant to define the scope of the oom handler but to me it
seems like you want to specify the oom handler and (ab)using scope for
that. In other words it still makes sense to distinguesh memcg, global,
mempolicy wide OOMs with global vs. bpf handler, right?

-- 
Michal Hocko
SUSE Labs

