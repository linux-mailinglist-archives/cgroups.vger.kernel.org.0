Return-Path: <cgroups+bounces-6074-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D301BA065AC
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 21:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B123A2E73
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 20:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39901CDFD5;
	Wed,  8 Jan 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioXjA9/N"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707121A725A;
	Wed,  8 Jan 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736366425; cv=none; b=PGw6qFdIXqY68wqpN5M/iL5k8M01ZdXQGq/jdv1iIYZ9LLWJcUpFwfRTNJnLEbigmXazIMdKiXPVlBgTEKDyNU+LjUlCDXRTUmfqPle2jqdcW+4Pvbe3lSN6qx8Fjcdo5ZGPjZ4g4JbieCCx6CZxX/qM2VgkP9R35fx09NOonds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736366425; c=relaxed/simple;
	bh=lm7Vd13gHxVihDJwz8803Iv+/fjPZOciPmNJ/GgUOJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw5GM0StniSfJ75P3R2f7EF2OpyY2C4mN2EtHwd6rWhLv5a7rnGMS2QuWnTWdkRmhJDVQO4/oS6sfUoJvz+OqB5gwwQlub4bb7n0Qe3hPPNjmsCXKsru6ckwM59fQ6EYlRGZe6FZtWZ5+grOWLvSoaUvBP4IkT/eU9t34rbaWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioXjA9/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6BAC4CED3;
	Wed,  8 Jan 2025 20:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736366425;
	bh=lm7Vd13gHxVihDJwz8803Iv+/fjPZOciPmNJ/GgUOJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ioXjA9/NNWd+YFpbntJH5xMhuEryGvdeMJbqTTvE4JKwpN7vXv2wVpVCVqPCwbgHt
	 x2ne4Mr4UJ1ckwJMsKqmN0SI6f5GTldl3EdUDaRXAQb/kTEJdhRiDrP+6AIgG9fgPv
	 XNVn4bx6lml6cfrKQLdaQMl8PgYI1OTCXJPZWgXND/fDtAs+11qaGKZeZo/4m2gunm
	 pwtF9qU4RQge7X1EhRBmlQWpza/W6mHuNfszPOrrjEI1W7ZOixIA7MtumwjW0JspZp
	 AXfF23DMq0PHWaT4WM/xKw++pCc+trtRBVe+oVc6zJU5wtoGSmwY78XCnrQZO3cvsv
	 P82ETJ//QWHiw==
Date: Wed, 8 Jan 2025 10:00:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: remove kernfs active break
Message-ID: <Z37ZVyx_PI6cHwZ7@slm.duckdns.org>
References: <20250106081904.721655-1-chenridong@huaweicloud.com>
 <Z36th2ni0q32gsUE@slm.duckdns.org>
 <c40d5b49-1955-42ee-b95c-37ed580e9933@redhat.com>
 <Z37TiId4rFkwc0Mc@slm.duckdns.org>
 <625d03cd-302f-41b1-9502-dfd25eb677e1@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625d03cd-302f-41b1-9502-dfd25eb677e1@redhat.com>

Hello,

On Wed, Jan 08, 2025 at 02:50:19PM -0500, Waiman Long wrote:
...
> It is not the strict ordering that I am worrying about. It is all about the
> possibility of hitting some race conditions.
> 
> I am thinking of a scenario where a cpuset loses all its CPUs in hotunplug
> and then restored by adding other CPUs. There is chance that the css will be
> operated on concurrently by the auto-transfer task and another task moving
> new task to the css. I am not sure if that will be a problem or not. Anyway,
> it is very rare that we will be in such a situation.

Hmm... I might be missing something but cgroup_transfer_tasks() is fully
synchronized against migrations. I don't see anything dangerous there.

Thanks.

-- 
tejun

