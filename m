Return-Path: <cgroups+bounces-5942-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDBE9F51D9
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 18:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74A47A20C8
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217B1F6671;
	Tue, 17 Dec 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7e6Ky0X"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0F2149DFA;
	Tue, 17 Dec 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455462; cv=none; b=MMwjF8gJVOcd5kxzIAPGZtAbIzoTDPI9Ib7j6wkMYViL4RdWyBva8hj1FXheRD1OqTJgjFuPDZunX3u/ka9DGCO3oaX4rniR3sPhIMTxcxWarHnNQjfoyOjKkd+dPUtEZG5wpj+TBD96uw0rHbNDFxb+ovcPCkMtAdvvp0jeKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455462; c=relaxed/simple;
	bh=fWEKQkxXI884vG+WF4qLVHpsT7vM3EElPdmXZ5tnPrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV+TAV28OSRF/KhcCDe+VnIcU+PdjSQScrFpmi8UDcNgj85x4+h2nA4ymzJLSm713M9sjMA6Jq4x9UfKyN45hdhSBzZcDt7W5K9KRFqmcgZztiW66AY5QSuEEkiC+9CyaBWNuXip2U3pduVJJxsaFXu+xyyUSzgWaUujBH1bmxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7e6Ky0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84EDC4CED7;
	Tue, 17 Dec 2024 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734455461;
	bh=fWEKQkxXI884vG+WF4qLVHpsT7vM3EElPdmXZ5tnPrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7e6Ky0X5QW7vVRBN3FDwoKg+K/J3+YB7JETZWQdy/reod6qL10Z3Zz1xE9c+SafF
	 dcb53XesfsCBLt411HlUfmfkK0Ux4NCwN20GZWYtfE0JP7fANUdxHsoiWUGaC2c0Ov
	 VuNX65kVwM6AtY1zumfEQErppZ+E7NpU1hEi5ekJ+G05/DaifNK4BSUA79WHXemtb5
	 6NP4qyNX6WbhycT2kxk3T67x6m+idCj76G5ubK7D6ReDAX5kgCgXObmJ7r8y4mUihD
	 knish44Q5fMeULq55tljoYm6uIbRiLBvAfK7OLjKzBclCLsIWY+SkobffKgkFzsPnu
	 82OZ0/fBrF3ag==
Date: Tue, 17 Dec 2024 07:11:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
Message-ID: <Z2GwpOQDVshpv-ml@slm.duckdns.org>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <20241213-proud-kind-uakari-df3a70@houat>
 <80c49a80-d49c-4ca5-9568-9f7950618275@lankhorst.se>
 <20241213-gentle-glittering-salamander-22addf@houat>
 <5a50a992-9286-4179-8031-ffb514bca34f@lankhorst.se>
 <20241217-meek-bullfinch-of-luck-2c3468@houat>
 <a69a3500-be17-4899-bdb9-c6a63bf8dc81@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a69a3500-be17-4899-bdb9-c6a63bf8dc81@lankhorst.se>

On Tue, Dec 17, 2024 at 03:28:50PM +0100, Maarten Lankhorst wrote:
> Now that all patches look good, what is needed to merge the series? Without
> patch 6/7 as it is a hack for testing.

There were some questions raised about device naming. One thing we want to
get right from the beginning is the basic interface.

Thanks.

-- 
tejun

