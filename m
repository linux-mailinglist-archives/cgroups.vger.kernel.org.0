Return-Path: <cgroups+bounces-7176-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE14AA699B8
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 20:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1918A4CBF
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A79214801;
	Wed, 19 Mar 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ml95u2be"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC21E8855
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413576; cv=none; b=pjDXlbLbhFepvn2jI5z+zYkb6NA3HBZWP/spBM/mFO7rlD8pUpwAhBr52a1tC9hsDKysDin7vyr+hAEgjC8je1c4u8UouHyzGe0JUEtYUn5xNfVnqpei+69UwM0dsT7KZuINrow2E6q71P06o8J9+rbb34Oxx2djUVP4W8sEX3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413576; c=relaxed/simple;
	bh=qlvN6iAULWo5vrmeRzfDI9VaAi52aMTIKGtEDdG7464=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3cEJXMFoFqOkPVEMW1gkFIzenQ8isPPU+bA9QUwViNOpBvj1bnmHbQKX0NGbDA6MRmsGOpImluFM8HKTgtxw+tH5wt98mENENtIUI1HGrwBGREoAIqXp0KJsxKvBGBrD9NoFJMBsSTdcv6S90jfZ+JdUoqTDgtGwp2zVeRF4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ml95u2be; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8f7019422so78346d6.1
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742413572; x=1743018372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMGdQd+1GtsqkZyrmcturm7A0b+BWeuqV9nKfwmQHB8=;
        b=ml95u2benNxrgrQJ3ZM0L+z97sokjxIn2GBTzPM7FPsatCO7sQvBQb2a93eO5770Gc
         H+iK3fxOtHu+CpKdTCY5TbO6+TBe0b1gP6yjIDDMbzV4Rew7mHKN8/i4t1VfW65fgmlI
         NyZIotrseobBq4wt3CFOsi48GnDazeG4oEVExeESnHOvfVwhWkskjO7Db3NRWVF4B102
         rBJd/trhR/cz4lCf/XUAgU/VPp+86ePtnjfL3rDqXs400ARkfXw/mvZWqCfZhseWokNO
         xZcRnBxNeLc3dlbhymWa8m59zzdEnpJFPWBMwhEpTWJD4UrdgizCU5Dsf6XYmEKQBgK/
         F0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413572; x=1743018372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMGdQd+1GtsqkZyrmcturm7A0b+BWeuqV9nKfwmQHB8=;
        b=ewyo0tEkV9jh+goQEuqMnmd5jqBNfZzavCSPBU4y21FU0g6oprEVWvYKcWzx3R+Frh
         2YhUUw3QOxF6eojpnn2hZbx0p0fUhiAS/LbCqti0sSxfWhN5Lc2sNtH8SNBu8QofFLFa
         o/hFz++Qbsh1lmXJmmEj4Pk6BLkavFc/ZM7gTZTPcW4FpHT4R4RYbmvsWyqFvA6kTEiv
         qnNzFYykCA3FKImGjG9e3P0giuL/STSHM33yalNzdpblzBkTvbN54jot0wUJDZUGGyKm
         sNbdopZl2BtrfEEAAwwxTsFrceDSFEmamLBtRXYSgQGOtWzidWYDdZK8uN3CKZvFVL+J
         wL3A==
X-Forwarded-Encrypted: i=1; AJvYcCXGgyAqGrQzosZMp3netARXLXpaz7FQ0dIGMpM3pghh9KR2eqwcOo5QomAOGxeq+Yr/TZWGhFYC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7vnuRPinQNW54ZAtpsxV50qD5TzfqGC7/Yvtp5NUxdEANt9T
	prQMToUTdgyv7P440lipi+NkmxaGWAUOYD/uasAgkZuAN7rzBW3EE5EGKzQDT2CxEqs2DSZTS2/
	C
X-Gm-Gg: ASbGncuUjpQmP4RHvc7+gU6jVZSvPLOY7W3ckXOa81vHk2jl7ywr4ThY2KR2IUw7wFu
	bvGUReuQ36xcDgGD8Bsz6vHMzx3eUoeAh8olPxb8RYJX0RvF55uh+kMTkva1P/MN8d/9qJuXWtp
	7S5CPCVotIb4/n78RqzR3suuRFqgdy3adDD4JckTEpsHvwxM7gQKJrTFKRYyVP+Dm1i2UDJ6/Xx
	LJis5W15aCA6cIY/dDPFMcPHPjEfydduxrUpcgzKH4c32rwr2P/dSwQIYZlghX2axhVvW3OFQpQ
	nCPwsSJlCn2+U3uDIIllWmxyX/cvi8+xxcDmNqoh7fY=
X-Google-Smtp-Source: AGHT+IGBPtC/y//GuXQrmvUuvNI+AJ1VTUL//CIpJG88EeiQgsUx/MStOJniyzmiXVM1kRKKRMEnkw==
X-Received: by 2002:ad4:4eae:0:b0:6e8:9dc9:1c03 with SMTP id 6a1803df08f44-6eb293a3360mr70586226d6.21.1742413572115;
        Wed, 19 Mar 2025 12:46:12 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb036e8b00sm49213526d6.17.2025.03.19.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:46:11 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:46:10 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <20250319194610.GF1876369@cmpxchg.org>
References: <20250319071330.898763-1-gthelen@google.com>
 <Z9r70jKJLPdHyihM@google.com>
 <20250319180643.GC1876369@cmpxchg.org>
 <Z9sOVsMtaZ9n02MZ@google.com>
 <20250319191638.GD1876369@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319191638.GD1876369@cmpxchg.org>

On Wed, Mar 19, 2025 at 03:16:42PM -0400, Johannes Weiner wrote:
> On Wed, Mar 19, 2025 at 06:35:02PM +0000, Yosry Ahmed wrote:
> > On Wed, Mar 19, 2025 at 02:06:43PM -0400, Johannes Weiner wrote:
> > > (btw, why do we not have any locking around the root stats in
> > > cgroup_base_stat_cputime_show()? There isn't anything preventing a
> > > reader from seeing all zeroes if another reader runs the memset() on
> > > cgrp->bstat, is there? Or double times...)
> > 
> > (I think root_cgroup_cputime() operates on a stack allocated bstat, not
> > cgrp->bstat)
> 
> That was the case until:
> 
> commit b824766504e49f3fdcbb8c722e70996a78c3636e
> Author: Chen Ridong <chenridong@huawei.com>
> Date:   Thu Jul 4 14:01:19 2024 +0000

Nevermind, Tejun pointed me to the follow-up fix he's got already
queued up:

https://web.git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/commit/?id=c4af66a95aa3bc1d4f607ebd4eea524fb58946e3

That brings it all back on the stack.

