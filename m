Return-Path: <cgroups+bounces-11976-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2589AC5F598
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 22:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11FC3358E4D
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 21:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EF9355047;
	Fri, 14 Nov 2025 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmK1dBJE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A482FC86C;
	Fri, 14 Nov 2025 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155373; cv=none; b=d8vc4zEd30Df7xJ5MxX3/gesZA6XBaPNE39SUT1JtD/ukkddTE2+kDIqBpbWvR7IMtGGFi1HGVe7GACVpGA4IuwBFg0F2Q/5ZmD8nJnTlEcwOm+zIeSF0MNoFfb+jTMMKQKs3nsL74Y47gQPg79PHtGfDNKfy1jwzU0WS2KZgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155373; c=relaxed/simple;
	bh=0jMPT7Wo0pVBWBmBZYHMmczEsCFoVCz8QbaRD9szspI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=VbWvpnXIuh9m6liwNe1suKi2fy7OV/Cg2Y86CQYRiatMT0MOGFk2wum7EO1qUUBk49vPwKUH5yG2i3AijOXcgPXcpweoZqoMRk4OCOcezStXtcfxtgjzNXlKsAQyxrbWlMzggXX9qlgso1gpZiJLX+RUPXnPaJidKge/8/UMASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmK1dBJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED26C19421;
	Fri, 14 Nov 2025 21:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763155372;
	bh=0jMPT7Wo0pVBWBmBZYHMmczEsCFoVCz8QbaRD9szspI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gmK1dBJEs6Xe6EaQiE1Y2duQDFTqQ/rnXgzzmPerTiViniptgLGwTGQHVOo0ZavSf
	 iyp1lAdDD/C97vdP2O1B82K90FtC6jsjUFgynGeqvclBjPUv4oDD6PiyyDG8xovlCd
	 BYHoClg5H8Uc79OdzwbcuVldlFU9OVLmOl3sDlr8pyL7mMnS84KBcVEAwU1gvl4SPy
	 9kVMyeFVEdSa0cvrsurNOJn+isf65QvwXd42yUVZuIm00L6isWV0+xO2rCFIwTAI4y
	 TyFhurL0tOLL3Mwfu2j8R1DJTkcHgoVke3l/lUH4ORgCiUsQy6Rw9K2YFv+mYawYrz
	 2DM/ncKBDnOQQ==
Date: Fri, 14 Nov 2025 11:22:51 -1000
Message-ID: <0135870c901931c4ec93c76ed3bb3019@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Michal Koutný <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Natalie Vock <natalie.vock@gmx.de>, Maarten Lankhorst <dev@lankhorst.se>, Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 0/3] Memory reclaim documentation fixes
In-Reply-To: <20251114182130.1549832-1-mkoutny@suse.com>
References: <20251114182130.1549832-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

> Michal Koutný (3):
>   docs: cgroup: Explain reclaim protection target
>   docs: cgroup: Note about sibling relative reclaim protection
>   docs: cgroup: No special handling of unpopulated memcgs

Applied 1-3 to cgroup/for-6.19.

Thanks.

--
tejun

