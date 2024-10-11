Return-Path: <cgroups+bounces-5103-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0FA99ADBD
	for <lists+cgroups@lfdr.de>; Fri, 11 Oct 2024 22:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D1F1C226CC
	for <lists+cgroups@lfdr.de>; Fri, 11 Oct 2024 20:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3DF1CFEDC;
	Fri, 11 Oct 2024 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="c/tVfQuU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB2199231
	for <cgroups@vger.kernel.org>; Fri, 11 Oct 2024 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679883; cv=none; b=QjMis+J6SywOat5cbkUe2On0GCO/gM2XAd7W1WeTgz90S/kI0tY67/ji8+asQK7JJh95EIyL4j9Y+0Zu4Bsa6TLjWZ7ZNWWU8nsJRO5EGlU/WdZtZdjjx/mEGVokOxVvIlnQlpCZfWEHsUGz6I0VUi2V2y8EyFQZswnreFvLNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679883; c=relaxed/simple;
	bh=8ffIk8qLEejL2TEgYMqhyAxPbW2pCrlgFQtGsvbbOAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OabG4C9UOdHD3blZb/dseNWNwr4+OTUtcRz5K5hkzSKmySd32gHBGHOma+Uj760foLe3nyBAVN9nV+eIn4fQU0BIATbGK4k3DkWgpPGA/lOtbdAg7hB9+teZDIkoD0OTL4+Ek6rF2sQhMdk8/dIO8yH0A+3zwAZ0vSdZW2LSyrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=c/tVfQuU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4605674e9cdso4841311cf.2
        for <cgroups@vger.kernel.org>; Fri, 11 Oct 2024 13:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1728679878; x=1729284678; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ffIk8qLEejL2TEgYMqhyAxPbW2pCrlgFQtGsvbbOAA=;
        b=c/tVfQuUMIWEIwbytJCjffH0NeZ0w9Lb9AnKZOHown+inuzIZqGYdxrqCLTK8Sr/xD
         BU5ZcRYN1+wYMtuI0/jHTVFT8quUApvsygD+ECwUuXOtx2u7WVSYTeQ+sdowlq46TJJQ
         W+09+WWMbcJfbvrlms40Iw/90Ec/3pbGgVZNQjn+bl1STJVyZiHaN7Vv8cPjbCeXBHEV
         S9CplQqQusoM+KTZa6IahzXP9kA2qUu6btcIL2zUpYpWWkpileWIRGbffAGapjNEfk7v
         PKNJrJst1yqfhyeN0htfvjfg5jGaVEjcCILPz/9f6a8msquNKT+QlvVavr+Fs5BaZ+z7
         J2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679878; x=1729284678;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ffIk8qLEejL2TEgYMqhyAxPbW2pCrlgFQtGsvbbOAA=;
        b=ZZmQKu+pW9Q8WtRtww6hxruod/jFc73BjmaEgLt/An9Sy9gimS2S8UX21eT1qS/Jkd
         HpvmjrKQ96xDk5/hNwM3LwPx7cntcuxXIQNFQwtVKz58cvsc2ulk0TLrFh89FrAWIFEC
         M9Nvx+7u0RLUwAMxQ3bQ2E7Dwha+/mb8dft0UVMghoaQx74/ZHJCqum1dKcjZJwgwe8V
         L7tU35vBPpUTGDJpH5B3P6vJNdG7OielgTZZELuncUFpkP9P2mTXIN30NIFQohz1z4Om
         MU4Niavn0gFXIfJeCm1BJF07CIBhanH0vFiIuMKKW0apdBXj5ugwRtHBr9EsHa0JEQ+g
         gSYA==
X-Forwarded-Encrypted: i=1; AJvYcCX1d0+Jm00p3mlbGl+W844K1vcXrW03JRyGucC4zN70b5MvjnMuwZutAbq14hnXI1YhCKXhOCtE@vger.kernel.org
X-Gm-Message-State: AOJu0YzAl+U+dTzIl5+dhKRmNXsGJLTDJY6o+A33plxf80JFrdECY1sc
	HbG1JQsyH78bZ6kLDAtN3X5V7ziKae3skTlQ3SbtcXjpTa/rjhsqdge1VER4PQ==
X-Google-Smtp-Source: AGHT+IFa/p5rklltM72VcXSiT0sJgKLEoNQMSnYkUvIY0XGjJfYKAP2lNR7BNsEDJM+AZIAyotAuOA==
X-Received: by 2002:ac8:5753:0:b0:45f:c8c9:dc26 with SMTP id d75a77b69052e-46058423974mr17690361cf.15.1728679878268;
        Fri, 11 Oct 2024 13:51:18 -0700 (PDT)
Received: from localhost.localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427dafddsm19144731cf.34.2024.10.11.13.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 13:51:17 -0700 (PDT)
Date: Fri, 11 Oct 2024 20:51:15 +0000
From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
To: linux-mm@kvack.org, cgroups@vger.kernel.org
Cc: roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, mhocko@kernel.org, nehagholkar@meta.com,
	abhishekd@meta.com, hannes@cmpxchg.org, weixugc@google.com,
	rientjes@google.com, gourry@gourry.net
Subject: Re: [RFC PATCH 0/4] memory tiering fairness by per-cgroup control of
 promotion and demotion
Message-ID: <ZwmPwwWwJBm29Srb@localhost.localhost>
References: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>

Adding some preliminary results from testing on a *real* system with CXL
memory.

The system has 256GB local DRAM + 64GB CXL memory. We used a microbenchmark
that allocates memory and accesses it at tunable hotness levels. We ran 3 such
microbenchmarks in 3 cgroups. The first container has 2 times the access
hotness than the second and the third container. All containers have a 100GB
memory.low set, meaning that ~82GB of local DRAM usage is protected.

Case 1 Container 1: Uses 120GB Container 2: Uses 40GB Container 3: Uses 40GB

Without fairness patch: same as with fairness.

With fairness patch: Container 1 has 120GB in local DRAM. Container 2 and 3
each have 40GB in local DRAM. As long as DRAM memory is not under pressure,
containers can exceed the lower guarantee and put everything in DRAM.

Case 2: Container 1: Uses 120GB Container 2: Uses 90GB Container 3: Uses 90GB

Without fairness patch: Container 1 gets 120GB in local DRAM, and Container 2
and 3 are stuck with ~65GB in local DRAM since they have colder data.

With fairness patch: Container 1 starts early and gets all 120GB in DRAM
memory. As container 2 and 3 start, they initially each get ~65GB in DRAM and
~25GB in CXL memory. Promotion attempts trigger local memory reclaim by kswapd,
which trims the DRAM usage by container 1 and increases the DRAM usage of
container 2 and 3. Eventually, the usage of DRAM memory for all 3 containers
converges at ~82GB, and the excess unprotected usage of 3 containers is in CXL
memory.

Case 3:

Container 1: Uses 120GB Container 2: Uses 70GB Container 3: Uses 70GB

Without fairness patch: Container 1 gets 120GB in local DRAM, and Container 2
and 3 are stuck with ~65GB in local DRAM since they have colder data.

With fairness patch: While the total memory demand exceeds DRAM capacity, at
the stable state, Container 1 is still able to get ~105GB in local DRAM, more
than the lower guarantee. Meanwhile, all memory usage by Container 2 and 3 are
protected from the noisy neighbor Container 1 and resides in DRAM only.

We’re working on getting performance data from more benchmarks and also Meta’s
production workloads. Stay tuned for more results!

