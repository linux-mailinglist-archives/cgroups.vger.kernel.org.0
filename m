Return-Path: <cgroups+bounces-8316-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01509AC1495
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 21:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3349D3B008A
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E107F2BD004;
	Thu, 22 May 2025 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhSuu3oi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0D92BCF5D;
	Thu, 22 May 2025 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940961; cv=none; b=iNTjPVVFY5IC88tMjq1AIjzE+ILSxlyaETiSDnJ8IEmkxMmeZjZW8Fpzl5GPept7/+RCpFZrrYJ6GUyPHdZOYtMT1u8JNeCYwTMnEAdGs2s61+oaxtjhCSzf5eFO+0ha2PqVJwvrtx1fjyKX/T5WW4w7X0cMIhBFhGmfiuixMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940961; c=relaxed/simple;
	bh=n7njdCjvJ8Bodp29yZcRUsAUKPu8G8E/D8i0PZa75sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHMkdWKbzgrVvZkr9ZUHgGi7+1WUhkfhDExwLHKTYHjOeBAxmQy+G9+i90I+cwPyqnfrdj0FmuC1qWpGLZruBvZiD/Z+vAbW/Qd4R+KMQqpbKU1k7sLPI6J/9fkK+1hAcpQY9yNWI+rQ/2o8NpHQgeJ1B3c9gKmSraKEn8kCCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhSuu3oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF437C4CEE4;
	Thu, 22 May 2025 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747940961;
	bh=n7njdCjvJ8Bodp29yZcRUsAUKPu8G8E/D8i0PZa75sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhSuu3oiKC9k1Zfj/fyN0A8y0OtsgS0V8pfsvy4B0CYZ1Wlp1d69y7JMYmMUXetER
	 5F3njuAmsJrLx4MyInj1tlLXCSmgSToxBfr2GjV4blp4NBMg2+gUmxCW2k/LHbou33
	 xL4bgAz7PbXUvF9ybVbOeHbP7f2UVg0HDIAgowcrqeaamKkZdiE6hkEvNS8nDHws6Q
	 /riekTGibKOcnk2dru90RcrIM9d6ZFKmBHmUG2VjCSIJzCsaVkRJlI5NqJYxmVYStJ
	 XESxT9x1lWNAu8V4VytT2lXLsH7KyXRa713b5CmGWAa6jiryxyijzlWhJdmamvCIKN
	 iVTbpbrIxeIuQ==
Date: Thu, 22 May 2025 09:09:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v3 2/3] sched_ext, docs: convert mentions of "CFS" to
 "fair-class scheduler"
Message-ID: <aC92YEjJ8TBM5nCo@slm.duckdns.org>
References: <20250522-rt-and-cpu-controller-doc-v3-0-483fc9cca591@sony.com>
 <20250522-rt-and-cpu-controller-doc-v3-2-483fc9cca591@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-rt-and-cpu-controller-doc-v3-2-483fc9cca591@sony.com>

On Thu, May 22, 2025 at 11:08:13AM +0900, Shashank Balaji wrote:
> Mentions of CFS are stale since the fair-class scheduler is implemented using
> EEVDF. So, convert such mentions to "fair-class scheduler" to stay
> algorithm-name agnostic.
> 
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

Applied to sched_ext/for-6.16.

Thanks.

-- 
tejun

