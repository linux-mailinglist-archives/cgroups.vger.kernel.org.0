Return-Path: <cgroups+bounces-11432-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14A1C20141
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 13:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292B11A22869
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 12:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372C434217C;
	Thu, 30 Oct 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXQIkmhJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E88340281;
	Thu, 30 Oct 2025 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828485; cv=none; b=T55JNC6UAlEGZGkM0VrnQGoMlee2dwvVOctNj7IdFILpOzeldrGPlTE0VWm5bAS6fRRiTU/mAjmtNPmmPQmq+SHhVQqUJrfmdyF7FkNzf9DWvmkGYRw971eJwAEF/va0goKa05+flNUR+L5FQOgyGf6Lv1A2rIEz0SQATt5VH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828485; c=relaxed/simple;
	bh=z/TmCLUEKXNCbQR2FR3bsCd/PFGIFQxm5MYX5nhHiYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxzBX34g2+JITfj3ljZpglP5zNiTIfhqxiV0Icm32IYz7K5i0lfPObwBlH5UFKzYRbCYCwk6F8KBeAJYK2AejHq1fvKWs9I7fnwHZ5DkEeKhd2ek3i8W6URo4pmEhtbsCpojwIZDo5Ex952ADRDJrD6zF8Os/EG4Du86GslB8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXQIkmhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A024C4CEF1;
	Thu, 30 Oct 2025 12:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761828484;
	bh=z/TmCLUEKXNCbQR2FR3bsCd/PFGIFQxm5MYX5nhHiYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXQIkmhJhyNbHD/vH4ojMOBpjiEHIEsGq7axLac9Wfb5ZzMNyyjBmdmK+OVZwrdrj
	 TGN+DYg5JF3BRx+lxG1z+rLLo3yEUnY41Br7up8Wni/NKj4eb9/MtEQC5ZWkY9+liQ
	 ROwe8TrtFAxbGJOpCwWfCevQSEIyA33BfEEeJ9BNvN9aYWg12cLyBrCpo5ywF21IS2
	 OY+ZJ88YupWL6/9YDnUVO9VmbEmL6JRz1I6uKEhHgT4y8bfytlizs2ahdACWJpLcCy
	 XXFGkyXRjTKYJaf6VqSnDOQOT2WnrAWmIQrsuWTXpHJJ99vzjXfN+vdnHS3kJguPkq
	 6NoaDauw5FL6A==
Date: Thu, 30 Oct 2025 12:47:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 07/14] sched: Fix do_set_cpus_allowed() locking
Message-ID: <990f3ce9-d7df-4344-863a-e4b71fe957c9@sirena.org.uk>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.103475671@infradead.org>
 <29d7b92b-594e-4835-9dd3-3c9e2b02ada3@sirena.org.uk>
 <20251030090715.GQ3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w7/3MAhEllohHjTX"
Content-Disposition: inline
In-Reply-To: <20251030090715.GQ3245006@noisy.programming.kicks-ass.net>
X-Cookie: Is there life before breakfast?


--w7/3MAhEllohHjTX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2025 at 10:07:15AM +0100, Peter Zijlstra wrote:
> On Thu, Oct 30, 2025 at 12:12:01AM +0000, Mark Brown wrote:

> > We're seeing lockups on some arm64 platforms in -next with the LTP
> > cpuhotplug02 test, the machine sits there repeatedly complaining that
> > RCU is stalled on IPIs:

> Did not this help?

>   https://lkml.kernel.org/r/20251027110133.GI3245006@noisy.programming.kicks-ass.net

It looks like that hadn't landed in yesterday's -next - it showed up
today and things do indeed look a lot happier, thanks!

--w7/3MAhEllohHjTX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkDXnwACgkQJNaLcl1U
h9CkSgf+MBexVKsLYF9KOOfxlRxNgU3VjK+zpctbbqvVj7cgaBu15pdOgguhX8pY
FMsAWORE70ktq7z/M5Q63I9bSZ6ecqvMHqfz3co4IxWJn0f0P+iK+PMsqfvJOU8z
wIEe7xfFY0PzYX58ZaO3MQXUMkQxhipaLUO97mPLgdB4Y8f0EJxuJbpSuHkVHBX5
GBoBl/HbkJGvOeGCDF3hRY7wa72ww+8LDNPqzdxiM4avg2fXtsFmiTYBq/pyKkuh
Htd5JrkeJKcZLb3zx/+m/J+LnLsxOpuTc5J0vZ/7Q2mn+1CWCAGEWm5xEBm8ygWm
iEQ4Ne7Ac5+qb0AsbyIztfUFOWZ9DA==
=G62n
-----END PGP SIGNATURE-----

--w7/3MAhEllohHjTX--

