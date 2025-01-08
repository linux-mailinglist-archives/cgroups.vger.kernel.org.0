Return-Path: <cgroups+bounces-6067-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB2A062AE
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 17:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F5C1883307
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2421FF61E;
	Wed,  8 Jan 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da02MPuo"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299581FF5E3;
	Wed,  8 Jan 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355210; cv=none; b=d+3j05XFx21ahnH4j3y/B5rnnbxd4LicTOAyk0AGbDgrUTCfkPW5pN2XPp6pm/ehRdBr72JJYwxo9d6LSfLh/1poZK9nQStYzoXlpGXoNP0B66xSw25NISAeW75bwuxONekNIwXROEKHfZ8b9VPPeZp7ugw88FNQonCpVAwnO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355210; c=relaxed/simple;
	bh=jkBISQty02/VJw2o9jAj8WxRReZffDp8qt9uHtVlXe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSZVPz85TlkJorUf3JDiJiG/yPpL88TQXhywVV1DXkHFqrtv97zC6Kpggnz+JwUqk7YdOEoZbWf9N9rC/W7WMegS2pe996xVQ26VpKFvhUOkwFftx+dleAfpKYZ1Fu9lZCUgbrkPiHhW+BSqQP1JX5wJVnCrhGZORC9BB344e8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da02MPuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5DDC4CED3;
	Wed,  8 Jan 2025 16:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736355208;
	bh=jkBISQty02/VJw2o9jAj8WxRReZffDp8qt9uHtVlXe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=da02MPuoT/W25THOjXxuVkcuaMoGBQAA2m/or4No/Vv8nTPCJAE5wZ6ydBXcRdzJK
	 6rC1P3bpu/ewUEjUbShB5BJep0nWHEKKZ9KcRzXSvcXKQdbdhr9K0uKmftMinWt6yU
	 H+sraEs3U3G4G/Tu6ZvyDjOXRthA3X6flP+ejEHkblOFfLxjmui2hy8cMOrkmb2vGy
	 q1WJjAu5k+po794N5w+LQzkRlWouKyNhxYOYdwPeGQrZe2daUv69zFKbDDya19R5YF
	 1iqJR/W+QeenxXYc8Q7YuOTwmI8OqmJRY/6nXSIVPrk4jQJmb90hYkwhFtZfD6LZOX
	 fXdvi1EkyNxzQ==
Date: Wed, 8 Jan 2025 06:53:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: remove kernfs active break
Message-ID: <Z36th2ni0q32gsUE@slm.duckdns.org>
References: <20250106081904.721655-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106081904.721655-1-chenridong@huaweicloud.com>

Waiman, what do you think?

-- 
tejun

