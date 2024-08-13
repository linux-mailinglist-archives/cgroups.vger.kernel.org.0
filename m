Return-Path: <cgroups+bounces-4220-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF9594FD0F
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 07:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C2E1F221B2
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 05:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A58219EB;
	Tue, 13 Aug 2024 05:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mvfnoxv2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285241C68C
	for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723525799; cv=none; b=WM4gnVoPV+3hM7R2mvCAbb37OnCLsJgAIsgYr8Abbwb0B/VrwjJtmYLpv9C4Bx6/Gy9IMUdoeL01vCeUwb5y+d+l4acfsUPd34RaV8+qPZi6brAWk5V/3cLPCiiXo0qjut99w2HAHrzXp5oV1HJ7xzG49fII0UenfZXqhEtJbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723525799; c=relaxed/simple;
	bh=Dcl/gHh+26jW3IUuBhjJO/+Tjz9vSvZTpOazD//w/VU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HnP88NTLjQoTrS3JOd9ZihWZjNHe7xnDTgTOq/kWhvCyDkjxvK/kjq1uGycIS1NNSwIOw/SKgOaRfiM2K/HlWYkUff7VBMTdjddqZYeOKllg0lfemv77dG59IJBTLeNkmHqfLyfCVTo6hCKL0h95S+hoYDAKDhU6Bf1krSVGl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mvfnoxv2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-200aa53d6d2so57815ad.0
        for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 22:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723525797; x=1724130597; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1QYFau/BoTzy76SOWuTODxBFqibSdOTdy65uJMl6Iw=;
        b=Mvfnoxv269in7OXaaEK7Yp1j7zoDnYMgtUI2bZ2uGbFYWO+ByBbuswOspdMoAmi5ld
         LUh2oN/MZslcefe3kvBPAyBmNwLMK608rPMmIZRF7uFMUr0g7il6q63EQIkbnWcXQ4Xm
         YYEIhL48ACktuefnQjC0wRjK7ZpPHWPf3ym2WwbPil/c+dC6bCRnYwR0Q6kdEjcveMbj
         1mV5OZqUG/nLpeJZqySxtD6+DGPjekDvb1RGoNi+lFr4IP3RyBsSWjOK1UsrtKkWxYNm
         7V395WeQWrOgpOXNPU90w4SWTCojSt7gKr7+yc+MUq50RHMpQCJiWuiC1B7pYhRDlX5D
         dCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723525797; x=1724130597;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1QYFau/BoTzy76SOWuTODxBFqibSdOTdy65uJMl6Iw=;
        b=aTPtqSbciVlGTNd7jxaZbaqlMcQgj9XwH5fI9yeN5vXPbX9yotFXA69+DbRjOd53M0
         cxfCjLbBLJVFsg7THfhtBq3lovO5ouMGyNWhUyq48F50p7aHKivL0GgoXkrdshUdhO7S
         yN4Em0i6awQpAr0SjJ8p6PNLYkvW0jypA5rpyv4gv8PaMfXT7XeA0uR1rG+sr88UbtUi
         AqjrzGPNFLRr3hZiQir/FGWD5TO9dKcp8lMcvNr+VQzxrK6RiepbIs8lPJ6lOvo6FeXl
         1bTSJMseZUCQ8YjGUfMKGR24ZV+K30zq+BgwTVGunTbiCBh2XW4T0+Lr4VOv08VvnpAF
         w3aA==
X-Forwarded-Encrypted: i=1; AJvYcCURvGcFByRe6kSq+Bn2GHjyHoFYewRovr0br6R4ruYBAJY1D8p40tiG07GtViYs4tfwvm6hB/PMHmUVgyTuuzbu/nP7KXHNcA==
X-Gm-Message-State: AOJu0YwhkTXP7cx/Zi18gbyP/VQKkhndr+OQF/1MnMTZ3RnxgLaopQ/K
	7yipvuaw+xLxatLrzppdqVVgTCoHwS6N7AhQrb0gWeE+HZSq5vX9AJXNlf+gAA==
X-Google-Smtp-Source: AGHT+IENkwUd9JvkyJ8WZbppPJls1rnH7OlPA+oSb9ghodPLmXaV1doVf6u+fPEMV5OfZQX90Fh5Nw==
X-Received: by 2002:a17:902:f948:b0:1f6:5bba:8ea3 with SMTP id d9443c01a7336-201cdc4fdb4mr591195ad.25.1723525797103;
        Mon, 12 Aug 2024 22:09:57 -0700 (PDT)
Received: from [2620:0:1008:15:499:4e79:c57b:11f5] ([2620:0:1008:15:499:4e79:c57b:11f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14ac10sm5161755ad.102.2024.08.12.22.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 22:09:56 -0700 (PDT)
Date: Mon, 12 Aug 2024 22:09:55 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
cc: linux-mm@kvack.org, cgroups@vger.kernel.org, roman.gushchin@linux.dev, 
    shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
    mhocko@kernel.org, nehagholkar@meta.com, abhishekd@meta.com, 
    hannes@cmpxchg.org
Subject: Re: [PATCH] mm,memcg: provide per-cgroup counters for NUMA balancing
 operations
In-Reply-To: <ZrqRXtVAkbC-q9SP@localhost.localhost>
Message-ID: <284406af-56b8-4b66-750f-10f9d38cfac7@google.com>
References: <20240809212115.59291-1-kaiyang2@cs.cmu.edu> <e34a841c-c4c6-30fd-ca20-312c84654c34@google.com> <ZrqRXtVAkbC-q9SP@localhost.localhost>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Aug 2024, Kaiyang Zhao wrote:

> On Sun, Aug 11, 2024 at 01:16:53PM -0700, David Rientjes wrote:
> > Hi Kaiyang, have you considered per-memcg control over NUMA balancing 
> > operations as well?
> > 
> > Wondering if that's the direction that you're heading in, because it would 
> > be very useful to be able to control NUMA balancing at memcg granularity 
> > on multi-tenant systems.
> > 
> > I mentioned this at LSF/MM/BPF this year.  If people believe this is out 
> > of scope for memcg, that would be good feedback as well.
> 
> Yes that's exactly where we are heading -- per-cgroup control of NUMA
> balancing operations in the context of memory tiering with CXL memory,
> by extending the concept of memory.low and memory.high. The use case is
> enabling a fair share of top tier memory across containers.
> 

Thanks Kaiyang, that will be very useful to test out, looking forward to 
seeing the patches!

Does this include top-tier specific memory limits as well?

And is your primary motivation the promotion path through NUMA Balancing 
or are you also looking at demotion to develop a comprehensive policy for 
memory placement using these limits?

> I'm collaborating with Meta on this, and we already have an implementation
> and some experiments done. The patches will go out soon. If others have 
> thoughts on this, please chime in.
> 

I have lots of thoughts, but not sure if the primary motivation is around 
promotion only here :)

