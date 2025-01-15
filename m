Return-Path: <cgroups+bounces-6164-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A466A11C6E
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 09:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2789188B311
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90EB1EEA2C;
	Wed, 15 Jan 2025 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXiR539S"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537A23F264;
	Wed, 15 Jan 2025 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931037; cv=none; b=ubyoBybKzV7VTyNHqaCiHiucwRxRU71Ihc2XlDcV9y18zRtn9hj0MjEwwJVR//9B/cX656kC5FDy7vvNR3Mp4rrOPrjaBcmhxOjNdTvtlQXY4nI0sn+wEETZ1uDI8EgHGci/IiuXCi66AopZ2MUb9nScjiwCmi3TVrz+V89wS/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931037; c=relaxed/simple;
	bh=GdB0s3esCm0Taj9qiopz0AL7rQJL+qDQQcnoixILlIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qegcTfIgybISiFi+D8l+7ESjKEMhh0iG6uh9do2NjjBsxgNWKwmMm/gXse0Eq/OpKYxeYeWkDoNs9CnP1Ti8wqGh7ZIbk4ZHXY0Yr5vgluuyyRZJO3nksRnzuMdlGQTGdgDMPC95UFef2tARn0dHj92j6m4esXoKcmeXGYSyptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXiR539S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96B9C4CEDF;
	Wed, 15 Jan 2025 08:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736931037;
	bh=GdB0s3esCm0Taj9qiopz0AL7rQJL+qDQQcnoixILlIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXiR539SdOIS5+z1lRuAb0gIU/FZe1caxq8gN3Vkd2FWFaSwxtVbO1SNEIDuWgLpV
	 my2eJO6BpJA6eerEUw8l0FjTbZ8/YhN+t/2/i6T4/4gSckFVoEvWUYKK4dnWF6fCTx
	 jlb9nGGONVvH8UGcxLsPb55OleS5GM85f3n/AqMOdud/UDgkNmo2RGlC79Buh9TbDk
	 UR640S7vo8Fk/JkrpSp55Pvtj6DES7si/CJwoq5Im49H4xaCtJWFFtOv01NFQkEcyn
	 OuipZOo+4iTf7TRZQ2Z/nYefssD3ZpNLu9ITFS03kl2Fs9HsEZyIwM1MdPu/U87W/e
	 AtF8lF8a20Mbg==
From: Maxime Ripard <mripard@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/4] cgroup/dmem: Select PAGE_COUNTER
Date: Wed, 15 Jan 2025 09:50:28 +0100
Message-ID: <173693101810.2804074.2827818197131810241.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113092608.1349287-1-mripard@kernel.org>
References: <20250113092608.1349287-1-mripard@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 13 Jan 2025 10:26:05 +0100, Maxime Ripard wrote:
> The dmem cgroup the page counting API implemented behing the
> PAGE_COUNTER kconfig option. However, it doesn't select it, resulting in
> potential build breakages. Select PAGE_COUNTER.
> 
> 

Applied to misc/kernel.git (drm-misc-next-fixes).

Thanks!
Maxime

