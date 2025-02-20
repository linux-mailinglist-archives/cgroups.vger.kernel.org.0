Return-Path: <cgroups+bounces-6617-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C380A3DF04
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 16:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30E4189D5E2
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F5E1EEA27;
	Thu, 20 Feb 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMVxTLt+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0A1FECD0
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066166; cv=none; b=csEAcctVksGkJR3KFKcmvciZ1IO4IoDDtSWQntyL8ZG7X6ru4ss10w+zZvm4WbNHRBUBs8Y4DlKu+Su1YYIEeeUk451O0eQAaD1S4tiTCCx/ooTiR5rr9g0ipdBpYQtHeVHAx+ZEFqAeQPyDUswSJklbRNvTyFymXTuu+0HKwXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066166; c=relaxed/simple;
	bh=R42UsajzAxka9fkfebAW2aXGR8HYWr7WW8nJOx8+3gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leBmdh53y/Rk1zUcwX5MxPauPr3qa6nLR/lTg9jgQWtZ3DsrimGFHUO37hG2nopnixTKg0hNdh5VqbbhiZY70I81l8NX6x38m69gVn0+M6GL6Ug6IKZqYvC3p/mBLBVKssHya52vPORj6woRw1VK4hJkNvgWlrO69IsPA1aYCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMVxTLt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945BCC4CED1;
	Thu, 20 Feb 2025 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740066165;
	bh=R42UsajzAxka9fkfebAW2aXGR8HYWr7WW8nJOx8+3gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMVxTLt+JiavuSx9hPa3q4kWPq8sBb/J713N980RuC3btMmABShM9NI/ATGd6uywn
	 /ojK8eLd88IMTbCCHBA3/5DbWOOf6SK7lmmPFo1SD/8Pe4AEPaaz7mCf0IeQjNXUxY
	 BlAAu0Ab+bbGdHj6FACtHKk++z79WaVz5WcizI9LIQ+NBeDqsYMcB8flEQyWkPt7EQ
	 MzluHIM1ze9YQ3FtsQ1xHoQWZgQ5peK/tF49aM7qqGngBBwXTqRj6zfw7Ri0Md3cCw
	 4veFkaF8rGxapJjnvLlAXZiPTTJWsZws01oER38CV+yw8ljG4hD/bgVxbGO6V8BiyF
	 GxL2CdKFXTw/Q==
Date: Thu, 20 Feb 2025 05:42:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>
Subject: Re: [PATCH] MAINTAINERS: Add entry for DMEM cgroup controller
Message-ID: <Z7dNdKLxEDqxkNmJ@slm.duckdns.org>
References: <20250220140757.16823-1-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220140757.16823-1-dev@lankhorst.se>

On Thu, Feb 20, 2025 at 03:07:57PM +0100, Maarten Lankhorst wrote:
> The cgroups controller is currently maintained through the
> drm-misc tree, so lets add add Maxime Ripard, Natalie Vock
> and me as specific maintainers for dmem.
> 
> We keep the cgroup mailing list CC'd on all cgroup specific patches.
> 
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Acked-by: Natalie Vock <natalie.vock@gmx.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

