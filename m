Return-Path: <cgroups+bounces-8715-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36445B02C2E
	for <lists+cgroups@lfdr.de>; Sat, 12 Jul 2025 19:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1ACB4E2970
	for <lists+cgroups@lfdr.de>; Sat, 12 Jul 2025 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA301F76A5;
	Sat, 12 Jul 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5j0D4Qd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027E2C181
	for <cgroups@vger.kernel.org>; Sat, 12 Jul 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752341747; cv=none; b=dKROEHum2btRKvhT2sWl43nW1md/gxg/r95/32rEWDeV2fai9ljPAT7Yp4TKJnBJBGp3ypDCreRS/2MnYqTL/l51JVrQwJvNXzmFJrAdtcYEkydmWQGyWSC9n2YckPfQfgsaTXDqs4+kev+SnQA2PUDV4F3YVOTcR8X2I7XM8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752341747; c=relaxed/simple;
	bh=ywVlJ2v91lRwgQGzDMoGap1+iJjDXEUZ+RUqsHc12gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAVrrnhLYFfKzbgzp1gWSM8SPwesR9dfd9s3YmiraxPYfEQyC54cHpSMviXuXLjji8ukp1xREhwrVvcn3B5C78qQzOiaEMZteOECBLlR2/x4t83CIvXhbkasB2s/dFSXI96ZyUeHRryxn86ogXMtmgDXGwgbsVrmtKJniedtM28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5j0D4Qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178F4C4CEEF;
	Sat, 12 Jul 2025 17:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752341747;
	bh=ywVlJ2v91lRwgQGzDMoGap1+iJjDXEUZ+RUqsHc12gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5j0D4QdD22E1DdVYqjxJ5QnycLE9ZwZnnqTkCuuJyoNN5h8aAWUFpM1ii2AafP+e
	 EbElJkfD690Qczj3wFX0XHM/sP7M6XWiAUPunnlJKlviVx9daRBgIrisWKCFMY1n+h
	 hI+whNSqBmFstrUEZ2YQCBokuMEZCGnYNHAhYVsO3syZvz+5DiA0Xyio53Nk7hTK0p
	 oEvYYFs2gJeKbvrFVqQlOJHeIt4YRhzcghMmdxyfE5rXjavgr9VKRkZgaC06lejz3p
	 +5E5LGaCAt+3FxPi85xT3/fytawxGycaXd5FMnjBfJ4nRoOZfPvr87O4Zqrcsk+Qzo
	 cra7fsXN2Efcg==
Date: Sat, 12 Jul 2025 07:35:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: cgroups@vger.kernel.org, Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH] selftests: cgroup: Fix missing newline in
 test_zswap_writeback_one
Message-ID: <aHKc8rtcey9Ap7CN@slm.duckdns.org>
References: <20250702164010.8874-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702164010.8874-1-sebastian.chlad@suse.com>

On Wed, Jul 02, 2025 at 06:40:10PM +0200, Sebastian Chlad wrote:
> Fixes malformed test output due to missing newline
> 
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>

Applied to cgroup/for-6.17.

Thanks.

-- 
tejun

