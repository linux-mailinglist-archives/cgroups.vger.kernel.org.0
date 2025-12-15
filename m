Return-Path: <cgroups+bounces-12366-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C61F2CBFD11
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 21:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89A6530146F8
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 20:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3109326D6F;
	Mon, 15 Dec 2025 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="mQKOms3G"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52032142D
	for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765831592; cv=none; b=SqRE1IBOZFctQoJgik0H3jMn1/uPtZEP8hTV3fo6YFpPp7H5MRGbCCYhA8FJipvKA4VyA3eMUV12rhBAOmE9K6kKDQ/c0oN8bKIuvP1QkyocXY98rPgvgzKz6gYRK3ASoGHKyMZEqdLptyP+pRtkIf9TTo/AXHGQFYcKQNw4/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765831592; c=relaxed/simple;
	bh=VCihespKqAvwz4ayGQuB9sxPczkPFI2wbSUtu79RQqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LI2p5dnHcgQp/E68gjjPU422CAoVBXSYZhtB7Er6MFtUosl/Za3czcAKUtJhso+H7SdxGrVVo11wynMyteuRZ9qrepuxzv9wP+Q7Ycm1Py54YJpqInm4MHMkrcbmd8vw0DWsU3bgJJnbiFJiPhzV8MSP2BDPiivNKvl/X1ZlDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=mQKOms3G; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88a2ad13c24so20462266d6.1
        for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 12:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1765831589; x=1766436389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/5OmwgaCDghH9Y+B9p9dsz0t3uJjAxYmjjcZ3Iaws4=;
        b=mQKOms3GNbbYN9xNauU2u61awieNv24TitEmFkylCF397fggvINi0+sxqVUMnyyK4b
         r0DJ5Ls82S2GeuRtduBRiezdo1bi0zEgAZxtxFmcZLdVEs/jbfI0MF523t2FXmaIwRsU
         qSP/7c/hvS8L7TlbQxE6+bm/vKcfDQr6xQVyy6UOa3WtBfB8Sg/HGLqHz4wfUsIkBXL1
         Ke+b9KoXcoZKTrvQTx9Ww/xvz6YpHgW2AomPKIyKS8qcZ9ZaFU8PuGcQtmV6oPvxwmID
         JV2kTZKqYtHjxPx8Z2VYRMpmnVyyauc/RHBWPaKZ+zdcPNq7wmLbf3zANEICTiDUUMyC
         cQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765831589; x=1766436389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/5OmwgaCDghH9Y+B9p9dsz0t3uJjAxYmjjcZ3Iaws4=;
        b=PCcG+RRAE4qPcJCvsIYHhlz/0pETohUXoZAMRfSDc0WcALIUc7BmoMqIPPux1hTLYN
         8s9QCYjIuGwA0cIN+Bi8H1V4INE7VjlGt36yzVRJp0wGPTScj64jg7zPNM9sid+UpLwy
         A9jKPL9o+yOGlWv9umdNtdcw+8FkDBJ+qve0zzu+SeH+ZzyLPmtcCYqvQe8l5OqZQk9i
         6SpwRK/MhRDAruOUZeN4JBq9BgMnnLus2VTin9FCyILR5T4rPbyEnpWqcBuWq/VM4yRI
         ZnSGga9280Z/95rCbAmRUdq4g70VpNHuGSjpLyoPFYS1Y5CeyesGmDcIKoxjFw+wuLT5
         RCiw==
X-Forwarded-Encrypted: i=1; AJvYcCUHcJL5XT55nfXSOubSMWTOtiN1518ogOmX0P3Ngj/O3s/bjI5gKrJYRZP52i454iPjvgzpW/ko@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUsXB70d5wYc4/COCIA+B4R6HhDl27wQsIIc5G+TVFsB/WWS6
	dIMKPMTM7mONEO7YkVF/BnTcczr5gcmHr8rfLT+gbqRRKCJbVn0ZHqZIZP0/b80iCCM=
X-Gm-Gg: AY/fxX5osSbEcAFaq4TPdT3TasINh2qHBOLGWF3wKojOcAZPbtnkjo3GdRjYr0jBkgs
	Lt48pL6Baul0QrMwGg2yBUXCb3nObVEs36a1BHw/BTQsY/OzikP7HlNAXW5DQdCLTHicDQK5qS9
	lrWeKGxNF8X4b6fx6AKDAwsR8QJi30aDsOG6iL4LHthU5u5Cl8a23Mppl3Qz4Y9+8zbHskdjaiF
	sZNbTNTnRJRrvnYuVg0ZdexMWIM+GigyTOoR6mpWrI/rlzOV81D444iPqV3dJFCXZfN/fxB7xUP
	EHHw+1ttxrLwI6EXuEwrPMNwMbtS0zh/tXbABHR+ug6I3RjZiBK0vQqkCFgkgy53BldeasSMUFn
	08dJSMaJDBlH5gTa6gE37QjOfl3luEoCxcMMLf6hzQOkMNW1CfXmwM4IlAOXGNJ7I+oQenDniEm
	UU3bKuivl5Jg==
X-Google-Smtp-Source: AGHT+IEECaGepI8b2WL9DLllMIh/MG6dmTXrWRWKDLKwFMYbp3fGB5X/Ym5XHJbEgAFZKvqnX0dTkA==
X-Received: by 2002:a05:6214:4906:b0:88a:2f0f:c173 with SMTP id 6a1803df08f44-88a2f0fc33emr107185346d6.68.1765831588949;
        Mon, 15 Dec 2025 12:46:28 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b41dc9sm59677586d6.9.2025.12.15.12.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:46:28 -0800 (PST)
Date: Mon, 15 Dec 2025 15:46:24 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: reorder retry checks for clarity in
 try_charge_memcg
Message-ID: <20251215204624.GE905277@cmpxchg.org>
References: <20251215145419.3097-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215145419.3097-1-kdipendra88@gmail.com>

On Mon, Dec 15, 2025 at 02:54:19PM +0000, Dipendra Khadka wrote:
> In try_charge_memcg(), reorder the retry logic checks to follow the
> early-exit pattern by testing for dying task before decrementing the
> retry counter:
> 
> Before:
>     if (nr_retries--)
>         goto retry;
>     
>     if (passed_oom && task_is_dying())
>         goto nomem;
> 
> After:
>     if (passed_oom && task_is_dying())
>         goto nomem;
>     
>     if (nr_retries--)
>         goto retry;
> 
> This makes the control flow more obvious: check exit conditions first,
> then decide whether to retry. When current task is dying (e.g., has
> received SIGKILL or is exiting), we should exit immediately rather than
> consuming a retry count first.
> 
> No functional change for the common case where task is not dying.

It's definitely a functional change, not just code clarification.

The oom kill resets nr_retries. This means that currently, even an OOM
victim is going to retry a full set of reclaims, even if they are
hopeless. After your patch, it'll retry for other reasons but can bail
much earlier as well. Check the other conditions.

The dying task / OOM victim allocation path is tricky and it tends to
fail us in the rarest and most difficult to debug scenarios. There
should be a good reason to change it.

