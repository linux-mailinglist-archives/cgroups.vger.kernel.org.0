Return-Path: <cgroups+bounces-7208-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C60A6B000
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 22:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83CE188A200
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 21:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F7722170A;
	Thu, 20 Mar 2025 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvKBUQde"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DBC2AE6A
	for <cgroups@vger.kernel.org>; Thu, 20 Mar 2025 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506726; cv=none; b=emp0yJlkKYBlgD795Qts2XbunXQrnAw5ycfxGnTo99XBi2ILe12SWagp765d7f3H5hRJYpOZ9Q7txOU8kP/Q7E1oQCY2JdaXpuXwUikGWXkpLNaALCvQuo+/N5pNYRRxJgL65ofltRewqQ/9vkxgPjBalFBex/9bOZF0J3BJY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506726; c=relaxed/simple;
	bh=l+uV6QrlO1o0C6zHA5Uga6ejz6mwdtS+qTv3EQ5ApsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8F0pe9abFKL3pHaipULmg8saCRs9GalF55lfjqxXLA4eglReaX4EmZNXoGcM5HAyH4hDBKY2p05oEEpdIXcH7xyB0AYfNDzWy8Gx3+r/SpWyV3dLBqMM2Wmy92HZ7YWDpsUCBQztIDWQbcKClBBjrnhAnexLTzYlvyM7UlpJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvKBUQde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5FBC4CEDD;
	Thu, 20 Mar 2025 21:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506725;
	bh=l+uV6QrlO1o0C6zHA5Uga6ejz6mwdtS+qTv3EQ5ApsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvKBUQdeb1ftmbQv/66Efm80c9aM6wBp3z8I0bZEsKA8vLwZq14mSCnEfzZjwBhOO
	 XjDmTDsEptWQjjETOTqUzvcV9uNTSozlQqOKw3ljR1/rtUDDukVGHT+kxWU1hCkp//
	 jmgA2dDMvxX5z9x7kBUOMg26+mC90PAAz+bldgVIv0Y2naPPyG1Y8kOzStcbJsERFv
	 Y8QQm8f4OkaezL/HwjYnoqg3o91Z5dfqB9TqrTGH799Dg2njdcJTXrH7Tq6yK4SwnM
	 x/8kflr4TIORNhYcs6naXGBGKV/GzwnuCoTEXD3jQpt3434JX62sey0waIY1jUAJwX
	 ipVKuUh2pazgw==
Date: Thu, 20 Mar 2025 11:38:44 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/4 v3] cgroup: use subsystem-specific rstat locks to
 avoid contention
Message-ID: <Z9yK5KYoQFg4thTQ@slm.duckdns.org>
References: <20250319222150.71813-1-inwardvessel@gmail.com>
 <20250319222150.71813-4-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319222150.71813-4-inwardvessel@gmail.com>

On Wed, Mar 19, 2025 at 03:21:49PM -0700, JP Kobryn wrote:
> @@ -779,6 +784,9 @@ struct cgroup_subsys {
>  	 * specifies the mask of subsystems that this one depends on.
>  	 */
>  	unsigned int depends_on;
> +
> +	spinlock_t lock;
> +	raw_spinlock_t __percpu *percpu_lock;

Please further qualify the names.

> -/* Related to global: cgroup_rstat_lock */
> +/* Related to locks:
> + * rstat_base_lock when handling cgroup::self
> + * css->ss->lock otherwise
> + */

Comment style, here and in other places.

Thanks.

-- 
tejun

