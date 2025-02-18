Return-Path: <cgroups+bounces-6591-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3824EA3A5E2
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 19:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E19189899F
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266211A2C27;
	Tue, 18 Feb 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTBrZK4D"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BED2356B4
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903999; cv=none; b=FQxYxpIqsfUAXBtUkfTWniCp/WHnRUgcgspk1ZkNWOvqIeEbFdcVdBXZ3X3Mh7yyk5mIXgF9W2zbw0797kaBoEKd5e1U/0qkduX7LiwOSd8jifGqPQbaP28A4c1ilc2tYhGjpuL7hj+6PaeUNtJebzexpAranUt5bTCquTtGXys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903999; c=relaxed/simple;
	bh=YnpuuOh5VaiRketHegrQjGYmcZ2o8O6xGHvTQK8T3IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAYC3QGIT/ssXuAkQ29ELYhlCDMaVrKw1oV0DhwPbGbKhouMsNRuLRaJ6VKlJWlh4pf0/m+m8tuszIPT6hoXlNkmC8zr0LvydBT49zAMUSZ/hiqWBCTHimTHXjqBHAKs8so9DxibopzJB2+61cyJsNJxDnxR5sfmmQoj1/6IF+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTBrZK4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF4DC4CEE2;
	Tue, 18 Feb 2025 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903999;
	bh=YnpuuOh5VaiRketHegrQjGYmcZ2o8O6xGHvTQK8T3IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTBrZK4Dp19lYxVB4lLX4gCwVnNpFCsxRRmP7upEjFWM1vWK6QKxm6HsOj+41j3wg
	 iA+YzZVnHFN5op2/h+nkoKpOdqgsC8OY6jBA3bIqYFDOKS2egEQRRwF0fEHIiZPcBz
	 GD+JNCZAmzSxK7ov4LqGHXvw7yaMhb6HBaVloOV66yvfi0kPeFyJ80TI9427PcHw13
	 SrFIw1Pj7tfQf/Nm3L/1vw+td/2xwL+2x02toNmohm/q9y1kNhO+gnaRuMwPhPgRgW
	 rCNywBOYmMTl+zuxDgCSXCDTH+74OfKvLUtWh/E0giLEkEsWsHX/qOaFDCXUkyFJR8
	 zy/3La9Q36/JQ==
Date: Tue, 18 Feb 2025 08:39:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/dmem: Don't open-code
 css_for_each_descendant_pre
Message-ID: <Z7TT_lFL6hu__NP-@slm.duckdns.org>
References: <20250114153912.278909-1-friedrich.vock@gmx.de>
 <20250127152754.21325-1-friedrich.vock@gmx.de>
 <7f799ba1-3776-49bd-8a53-dc409ef2afe3@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f799ba1-3776-49bd-8a53-dc409ef2afe3@lankhorst.se>

Hello,

On Tue, Feb 18, 2025 at 03:55:43PM +0100, Maarten Lankhorst wrote:
> Should this fix go through the cgroup tree?

I haven't been routing any dmem patches. Might as well stick to drm tree?

Thanks.

-- 
tejun

