Return-Path: <cgroups+bounces-12348-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0304CB8C04
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 12:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BA05304D9E2
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED7A31ED9B;
	Fri, 12 Dec 2025 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0XdHj8B"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039D31ED84;
	Fri, 12 Dec 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765540646; cv=none; b=gQJ/C91ZkTPeAxtCOoMFrfSC+B0Ajhfuk9qXGDQi6pQUtIpSRCx+JdqNnjFnOrHV2NOLFw+xs+3gNgmEmI2RGP1joPGqx1JAFlnANXH1ODKtqNd4DzsxDWmSzhmR70CSaFHzMzXc4EuOTRJekh05YkyqHm0n7LCV6+70PQZUNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765540646; c=relaxed/simple;
	bh=B8kaJig1Qmy/8VwfW5/KFmQMAdC8lDjti5wIe775VME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNsqR1W0Axkmv+5EY/GWCsmHAAGaFA4lnCY+Nri/026v4PEzlsn9zB0UWP2lm3gbffj50OC+WpZd+twI/1vf/Z6Fetpwrf84qP7deOPVI/GdEAJtRnVu8baUdi1pitVR3LQLppibSDA9eMUSyQN7LgGeaBfOaWHFz2cdpo1iwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0XdHj8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1D9C4CEF1;
	Fri, 12 Dec 2025 11:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765540645;
	bh=B8kaJig1Qmy/8VwfW5/KFmQMAdC8lDjti5wIe775VME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0XdHj8BE5bQDXI9rljVUy7gBTq4SPI7XwXwOEOBex/YI/XhXqKwJwsK22qElrC+E
	 pJwMUixAKg8ciHHM+tkBNR68jlb2O+lYzzDJzpPpGog64zwkxsoPKcq6FW8Tw2tJMB
	 f1R1ZctH8Qfa2ThfuyFfYyHQjwggGaJ4s3Cv+xbbEAQaOdKgBUlIVre1oZrRX69WBY
	 8lGpCDoMgI7XzXkEQvwYQ5BuL+BS6VcBGTY0oZKrgIIEtDzLW7GxEeC4qRK2KCtu/p
	 2IQklOV4/khM+FRP+gB3ZtL1Q//EOpbiEMw8WezRmW+nZG6OBMWuX/Mr/aKFsE5ulv
	 J6Z12aaZ7eS/g==
Date: Fri, 12 Dec 2025 12:57:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Mason <clm@meta.com>, LKML <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] genirq: Don't overwrite interrupt thread flags on setup
Message-ID: <aTwDIoiqJECNhIC-@pavilion.home>
References: <20251212014848.3509622-1-clm@meta.com>
 <87ikece8ps.ffs@tglx>
 <87ecp0e4cf.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ecp0e4cf.ffs@tglx>

Le Fri, Dec 12, 2025 at 01:01:04PM +0900, Thomas Gleixner a écrit :
> Chris reported that the recent affinity management changes result in
> overwriting the already initialized thread flags.
> 
> Use set_bit() to set the affinity bit instead of assigning the bit value to
> the flags.
> 
> Fixes: 801afdfbfcd9 ("genirq: Fix interrupt threads affinity vs. cpuset isolated partitions")
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Closes: https://lore.kernel.org/all/20251212014848.3509622-1-clm@meta.com

Whoops!

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

