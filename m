Return-Path: <cgroups+bounces-8314-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C71AC13DA
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 21:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4F61B6234B
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4B22698AF;
	Thu, 22 May 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPNSHNNb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75228150997;
	Thu, 22 May 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940604; cv=none; b=pBqXevflAWbRk7cmj6LJKLzplMdE3ewzXefGPYn3V3HTCO3KL7VqJi5Tgbe9tRW09EZyUr2EuoYZc/IRRRN+IbcQEUGm6EOrmCXyVzJnJ2F6FEB+i+buNZNwKKx0t3B6o/sJn8QAy9uicuexHRd5C+f8cgWwuFJCMTEYAVQYvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940604; c=relaxed/simple;
	bh=Kxo0b70MUyXTaivsBaYBlY1BO3H9S45etU0YfENA0fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS2NDONUJqo7VqN9blofFJOONv3bcPT9LC2Mfz71F6GFj9+6Kb27JUM/hKbeYOvbtEVwC5Wi8kZ79ZNPajPMbPqptQfNN6D52Wg3SeCOgtHV52PUGG36HFMIYYz9Odju9q0i0vgDXUWlvaGwL07JvzRJcFCOS+hlWxkq367tfHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPNSHNNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4211C4CEE4;
	Thu, 22 May 2025 19:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747940603;
	bh=Kxo0b70MUyXTaivsBaYBlY1BO3H9S45etU0YfENA0fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPNSHNNbfOtz9gGek5fjkqg+PMQmwYXlzcPwHA7Up4L2GyxRG2E2BqDSS5pT23Zat
	 HUj3gJy2mWauqfIa8Oigx/z+QX9Q4OBC9y3G3/1RUq/aKbehfYFu4ZT540LAogpqY9
	 SCcSFtSRJscTeHUZnh+8zJ8mEFqVDljN0QHk7CCP+Rz7edK7C6hSZSxHJ/u8CbcJlA
	 Hf0siB/SxHU+AhhUTI0ltLSTrAGMxq/zQeox7rQTgpnS3+z/IsH5ZuNr1NKJ11G1In
	 4oNiQjezGUd6kIht0eYkTo1JJeN+CvAh66KOiwkNiATqwM/4GqK06uTQVijAkFxJSO
	 rFS10UPg3mXyA==
Date: Thu, 22 May 2025 09:03:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Waiman Long <llong@redhat.com>, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
Message-ID: <aC90-jGtD_tJiP5K@slm.duckdns.org>
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
 <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com>
 <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
 <aC4J9HDo2LKXYG6l@slm.duckdns.org>
 <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>

Hello,

On Thu, May 22, 2025 at 11:37:44AM +0800, Zhongkun He wrote:
> > I don't think this is a good idea. O_NONBLOCK means "don't wait", not "skip
> > this".
> 
> Yes, I agree.  However, we have been experiencing this issue for a long time,
> so we hope to have an option to disable memory migration in v2.
> 
> Would it be possible to re-enable the memory.migrate interface and
> disable memory migration by default in v2?
> 
> Alternatively, could we introduce an option in cpuset.mems to explicitly
> indicate that memory migration should not occur?
> 
> Please feel free to share any suggestions you might have.

Is this something you want on the whole machine? If so, would global cgroup
mount option work?

Thanks.

-- 
tejun

