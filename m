Return-Path: <cgroups+bounces-4212-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CA94FA05
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 00:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8F51F26004
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 22:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E777819AD6A;
	Mon, 12 Aug 2024 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="Lvo2BG3g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BCE19AA7A
	for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502952; cv=none; b=ZD3SYlC7pLk4WE7x9jodWYqbWuPFQ2G+LO9uR6QZnkbW2Dee7nzYHa1bMW7VopZ0I9QSLVjtwKZG6W2egVqjze5YF4piE5MD9reEimYfqW9DkC3L9EqV+VrlhHu7XYglYgHCUVv/+Ffo5sCBcqkGzQKdkEl+vJasKoq7V+OO+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502952; c=relaxed/simple;
	bh=Y5nR1aqsHmVJ2R7eL4levuPrXL7meHhnCIswL/Z55ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvgNOTkOiGYGhZXSvF8+XAiNsXNAShRA9AfobTPTI/4W/zM0HoL6+1ZoahF7DOkXQHxJLwk1W7KMizATF+u21cI82FpExz8k1zzxdq0TQoyPSEfbuMPcPzFRwuI5aUsKq2KnWtrFAJNF+Tn+HkQtm/AKRDQUKBnpHJY9u574a8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=Lvo2BG3g; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-825a23c5e4cso1025008241.3
        for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 15:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1723502948; x=1724107748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zN4Gh5r2ZtT/k8/een1KebeWquCpNOqxuEapGKzxmU=;
        b=Lvo2BG3g6dUD0/XmPGCuwk6ZGRPS+nC/wWrQyDMiUQSpF3+xmFi7AoHqCWCrM+XD/a
         AUDdf7UoHSJHkNOwICH3nFSOE2enFqStmKv0oLUjJoVQrr/G6zmR1MZElCJgrixHgKoe
         mzK97W+ybZpfNpigg1qfFL5RTXRqIUq5cuyKtGP3wcHVtaG+HTSyxBsNAuzZXX1zsGOh
         9fZk67ktGOvw43a/f9ZqLL+PnOHDUkIhfWjKs//IzK2LEoz7B+XZhMOvWZnwMtNLkp1x
         3Y/8YbX8zSbSb/rZNZLJsl3LvHkA6gKfCuXeJUN5tncWOkPhRus7S172P2kblub31jCV
         vsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723502948; x=1724107748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zN4Gh5r2ZtT/k8/een1KebeWquCpNOqxuEapGKzxmU=;
        b=aEWn8QbN6FX04fmQYnDKdDxZgFFnewdCi+lC1J5+92mCfy8LdwZyTOOcDXvQQaU+th
         j0gR4rHWHNSyc0uZsXta1soQj67PGIGwr+JaXKe5cmvtnIHzqWkIjjVlwt0zG3gHcRNY
         WdHGY1dHcNQRNK3ycmHfOMs7KMPok6d/XJzYGPMrpVZb8sgVzxgxYTFWTknnTD9/yo2b
         Keot/A09JfU8/qMoJTrl5u1gnOWeZQ6UzQ/XzsqpEJjVcCDMvogdqY/+HTSG/gucITfn
         6DU2Jfb8/okuV32RUSEcFFfdtGAMn8IvSlX/T1Jv+RAhticokuMYo9WQuFgnsOQUc5GA
         8gEA==
X-Forwarded-Encrypted: i=1; AJvYcCWO9yeGFgCyFgH84sCJZFoQXmNwVFNh6pWTu1PN2Bljda3ViIModEICTpqKzB85GR+VJo08jTvCSPDCRNbkzzNLL+eHt+N1TA==
X-Gm-Message-State: AOJu0Yyqr0/F1Ke5Upo3DQ/IVm6x3es0qMPnInnweUyfgXiyyFOINcI7
	y4faMY29GXatR87fh4brZM6DR2swKdFRyPu+XFjLVaymLpGqsapugHQ58QozZQ==
X-Google-Smtp-Source: AGHT+IEVjzVH8ZuXd99m66D+lu1lA0lbLhsrUGD8ITS/piDDRdkW1qC7PkAwxow7hljU61Pe5BeBOw==
X-Received: by 2002:a05:6102:c0d:b0:48f:df71:17e3 with SMTP id ada2fe7eead31-49743b3d220mr2178995137.28.1723502948148;
        Mon, 12 Aug 2024 15:49:08 -0700 (PDT)
Received: from localhost.localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7df55f9sm284414885a.92.2024.08.12.15.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 15:49:07 -0700 (PDT)
Date: Mon, 12 Aug 2024 22:49:02 +0000
From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
To: David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, mhocko@kernel.org, nehagholkar@meta.com,
	abhishekd@meta.com, hannes@cmpxchg.org
Subject: Re: [PATCH] mm,memcg: provide per-cgroup counters for NUMA balancing
 operations
Message-ID: <ZrqRXtVAkbC-q9SP@localhost.localhost>
References: <20240809212115.59291-1-kaiyang2@cs.cmu.edu>
 <e34a841c-c4c6-30fd-ca20-312c84654c34@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34a841c-c4c6-30fd-ca20-312c84654c34@google.com>

On Sun, Aug 11, 2024 at 01:16:53PM -0700, David Rientjes wrote:
> Hi Kaiyang, have you considered per-memcg control over NUMA balancing 
> operations as well?
> 
> Wondering if that's the direction that you're heading in, because it would 
> be very useful to be able to control NUMA balancing at memcg granularity 
> on multi-tenant systems.
> 
> I mentioned this at LSF/MM/BPF this year.  If people believe this is out 
> of scope for memcg, that would be good feedback as well.

Yes that's exactly where we are heading -- per-cgroup control of NUMA
balancing operations in the context of memory tiering with CXL memory,
by extending the concept of memory.low and memory.high. The use case is
enabling a fair share of top tier memory across containers.

I'm collaborating with Meta on this, and we already have an implementation
and some experiments done. The patches will go out soon. If others have 
thoughts on this, please chime in.

Best,
Kaiyang Zhao

