Return-Path: <cgroups+bounces-8277-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD7AABE485
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 22:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42CD3B0946
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5F4288C07;
	Tue, 20 May 2025 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOsTVKi5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE127C863;
	Tue, 20 May 2025 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771910; cv=none; b=up8BklG13yNYGE0M7Oa4uZEOSt6INw1LgYW6SW0JLBcd7VWOcxebzNFm8WqkNgm7Bbqyrjp8iCC1epIcyF8vLl3KmX+LegatX6/YezVtH9UHOU/l7CUGI4mdBV/E8BITbBij+PqAJdyOydKNFenFcNZZNr97n/ZQ5XM6/AijBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771910; c=relaxed/simple;
	bh=3naj0bjbvDnkEd9GJtDdldNR7frDExsIaFCZiA5vpkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ncv168NsNnKqbKmnomP/4/GNNNlh1YEYgZ3UITow3+wc4egwFrhqYwWbjAHrLrk7iroeya2XUldDwel3jWDaTX48+CgAjgnMl+LCuH8/jy6UzMpPZabkOtV9o/I4clfKeivPEHmks1MOvT1ycxruicak8pBU9sRMiDMLe8jAY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOsTVKi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9429FC4CEE9;
	Tue, 20 May 2025 20:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747771909;
	bh=3naj0bjbvDnkEd9GJtDdldNR7frDExsIaFCZiA5vpkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOsTVKi5WWDOcGNVPRsqVqE63azerDqF4l+YLT8Fwi7D7vVdpMwo61KTyhNScJpf/
	 zeOywi3Se7KOMH7KrYds7hoor/cZdLTDkfqtjYW15VIOuRBSO6y1Mwn11MqcwV4gp3
	 Fx1oNj7DPuBb6rrFY4zSzhDax+tpgUEqcPwlxmlqSP60fUhGc9a408SAosu9NQqEu7
	 hMVnEaehfsu2NSu+L15BqByd28YHwYd8vISJ1FLv1AP3jql+7dNtsuBUi3NlZ0u612
	 /xmVV4YsAZPgP/Sz/ZyDkctQUTxrI21m4kDbenozQ7/8LH6TQFWNPpXS4+r2JWEaH1
	 yAQnaUV47Ppvw==
Date: Tue, 20 May 2025 10:11:47 -1000
From: Tejun Heo <tj@kernel.org>
To: shashank.mahadasyam@sony.com
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v2 1/3] cgroup, docs: be specific about bandwidth control
 of rt processes
Message-ID: <aCziA1tUAnnGId6_@slm.duckdns.org>
References: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
 <20250520-rt-and-cpu-controller-doc-v2-1-70a2b6a1b703@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520-rt-and-cpu-controller-doc-v2-1-70a2b6a1b703@sony.com>

On Tue, May 20, 2025 at 11:07:45PM +0900, Shashank Balaji via B4 Relay wrote:
> From: Shashank Balaji <shashank.mahadasyam@sony.com>
> 
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 1a16ce68a4d7f6f8c9070be89c4975dbfa79077e..3b3685736fe9b12e96a273248dfb4a8c62a4b698 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1076,7 +1076,7 @@ cpufreq governor about the minimum desired frequency which should always be
>  provided by a CPU, as well as the maximum desired frequency, which should not
>  be exceeded by a CPU.
>  
> -WARNING: cgroup2 cpu controller doesn't yet fully support the control of
> +WARNING: cgroup2 cpu controller doesn't yet support the (bandwidth) control of

This reads weird to me. Without the () part, it becomes "doesn't yet support
the control of". Maybe rephrase it a bit more?

Thanks.

-- 
tejun

