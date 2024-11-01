Return-Path: <cgroups+bounces-5376-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154029B91B4
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 14:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468DA1C232B3
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB07D1A071E;
	Fri,  1 Nov 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T1mwZ5Lp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA06A19B3D3
	for <cgroups@vger.kernel.org>; Fri,  1 Nov 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466942; cv=none; b=eK/stRp3CgoTzBkQVUInFc2HxhsO6/rDNuWregsOg4vg8+9Z4rnf7qyR+XKpXgszzxwi6RypcJqj27iETxZveoRXUwikzuoc7FjDWEKYFBy/SuNNrg6NVN0i5OgdyFZ/dC81IVDxigcMXiak/19ogwz4c1phQllmU4Ov0aesFNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466942; c=relaxed/simple;
	bh=LPy0iHmIweNFFAAnB2KUz3/5r3EObx6jirbCfMhTF8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuRlzShkmxyn9rU0yN4nSwG5v3LBQSj/NRerZXtm5h6gwUB5i+Ua1/2hLz28qAXkeZUzjmTwW9E09u8hUHJYd4v/JsHUJ5rR/gtbCpLmVagbAhh6PGFvMRZX2Lx81hgaBCXRqGlArwbQ/SjKM/aS1/+VpluI663/4HvcteUJ3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T1mwZ5Lp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso222226566b.3
        for <cgroups@vger.kernel.org>; Fri, 01 Nov 2024 06:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730466937; x=1731071737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3f9OOv9CCOEOAstnKXEvl/6s8AwqAURBKUhJsNIKwMk=;
        b=T1mwZ5Lpl6kjGhkD2utkwQNaukp+GGP1heSPGrXi9EdpZfZUvjYUX4fIBPHh1jR27D
         XFmrBc+73pABafUKoKmXQaRZFe1HjFzi9FL596fUmB+jd91bmeU2piY6UYfNYHGoe11u
         6wfbmZ04m09YMGKKjcRdaSQoW+QiPwV3eVAIIMJ7FZ3tji7/QNqceG36sjEEDRdQJXH5
         GGlFPA3RQ2MFwyf62sL+DaiUVlscqA+mVhks2v1rBYLoKVDnYr/Dk/fEsgPwbF47CD4E
         3Wfie8clB1A/yqgkaDtz7Hs7WnDUqmk4iNwPNW7z4jPha4xHnnGjM27kJlsS7Ws9Zp3C
         MhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730466937; x=1731071737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3f9OOv9CCOEOAstnKXEvl/6s8AwqAURBKUhJsNIKwMk=;
        b=jHkKioTcjf8cWVBIkS3XFK4h2kH1+QIVMGF3FQcfpArQgRUeOEb7E9CaAoxZk7+7J5
         +OPJBHcHa0oqHnS2MLWi7ZauiFKlfoD59R2iOkJ19k422hypYeKfY7aqE7QB7b/mHgtg
         hyTSgLsjHTSHHOGKiL7ypWYF7Dl5N0Eva1CiVKeuuQWlzvaMCAIL/yxcJSDgnS9dyfRE
         NmOE7GwOHmzUvdvZxPGxixpjvJfe/nBAjbRGy33zzgHqOZ/Jeq6tqzIqtHrB5phGDm9r
         j6rjFLyR21pkGJ8/wNLR0aUFwZwaw5JXee/pjpwXU1Z0a9RF38wrDmackDF0hL601dsw
         aqhg==
X-Forwarded-Encrypted: i=1; AJvYcCUDV/ibU9h5z76R8GZ4+gUy178yA1rOklApAQr+mSOCdEX7pWudCEsL2ewQhGS40LULLupDoXaj@vger.kernel.org
X-Gm-Message-State: AOJu0YylLZQPAgpxBkTLODuGh1LF3YwSGgRJDcVlLusmXewqHvxnOgAp
	yvSNyz87OaNY6BRwejHE+9HGDEkTQS8T3vM7f2anHtqrJFsX3bl47hE6ChOQ1PQ=
X-Google-Smtp-Source: AGHT+IEd3g/Y8qcweQFL3P5DWLjskcIv2qFepd6uX635AhnimwSdRwMdrwRVUx4gFL6le1TbhPFniA==
X-Received: by 2002:a17:907:3da1:b0:a9a:4e77:92f with SMTP id a640c23a62f3a-a9e50b9e343mr601999066b.56.1730466937004;
        Fri, 01 Nov 2024 06:15:37 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56493e40sm178097966b.40.2024.11.01.06.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:15:36 -0700 (PDT)
Date: Fri, 1 Nov 2024 14:15:35 +0100
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
Message-ID: <ZyTUd5wH1T_IJYRL@tiehlicka>
References: <ZyHwgjK8t8kWkm9E@tiehlicka>
 <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
 <ZyI0LTV2YgC4CGfW@tiehlicka>
 <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
 <ZyJNizBQ-h4feuJe@tiehlicka>
 <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
 <ZyNAxnOqOfYvqxjc@tiehlicka>
 <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>
 <ZySEvmfwpT_6N97I@tiehlicka>
 <274e1560-9f6c-4dd9-b27c-2fd0f0c54d03@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274e1560-9f6c-4dd9-b27c-2fd0f0c54d03@huawei.com>

On Fri 01-11-24 14:54:27, Stepanov Anatoly wrote:
> On 11/1/2024 10:35 AM, Michal Hocko wrote:
> > On Thu 31-10-24 17:37:12, Stepanov Anatoly wrote:
> >> If we consider the inheritance approach (prctl + launcher), it's fine until we need to change
> >> THP mode property for several tasks at once, in this case some batch-change approach needed.
> > 
> > I do not follow. How is this any different from a single process? Or do
> > you mean to change the mode for an already running process?
> > 
> yes, for already running set of processes

Why is that preferred over setting the policy upfront?
-- 
Michal Hocko
SUSE Labs

