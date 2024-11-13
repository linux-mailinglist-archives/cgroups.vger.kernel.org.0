Return-Path: <cgroups+bounces-5545-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D58D9C7B37
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 19:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4ED287D44
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D69E74BED;
	Wed, 13 Nov 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF91YXhY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFA1FAC53;
	Wed, 13 Nov 2024 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522591; cv=none; b=aOXNbOzS2vjuM+vTx5xyDBIrzKXOMOF8INyoFgFDuYZ7A2RZ/DB58H8wnhga869/NhwDpcAPcZvZYOFI4OGtOA9lP7Sc7+4vXdKXtv67vrBhTtHKYXmEtwn3nNuCI00dN25/Ogx+N7bbGCoReNuYh8/MN/C2T6ZlEQKvHFkrjnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522591; c=relaxed/simple;
	bh=PVDbYbNqRERQaA9TjMSh0em+KssXtcnQxggmRi2efsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWr35q1lW7R26hWVNYMTIM//slGwlPNh4py4OZomJ9q4UF6+g5ULQ1q1XMeUn8zJHeUYapwYW4BuvJFSWtw9oJqtj5gvX6N4nuSl5yPIyxZtkVTP4GAmlG2n/31JRpO4EFLCckFGViSzmKJDAspCqI+twnYOzxXrW8UjjdeyIzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF91YXhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7AAC4CEC3;
	Wed, 13 Nov 2024 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731522591;
	bh=PVDbYbNqRERQaA9TjMSh0em+KssXtcnQxggmRi2efsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SF91YXhY1ySElLg5xEuFdftyqMktNaZoSUkruyuHZoowwUycaGNLPUqGWb09MNvrR
	 mnZGqEYkGbbTvW5+eoUub02HkOItVXZrB7yk7vCmLpH2VbNoqxmkW0JfncyFqoKhOt
	 7j22irKZUJktZwKD4+E4jbBXrOJGI6XEi0OASSdNXiK1z1B6q/fJsUcfRZBQZDS+1j
	 LQGtr8NTpkv4vdBJj8pY/bUWrlWE3K0WJxcqfbzdxqmySHRuqfIp00NxXjDbtURheQ
	 9ovB/IYK3C8btkjtlNL4E5pYKroQZapAQTpn9vHO6bO5ClaT8LecQlNyQYn1HyNmUf
	 lkugInU8/bm6g==
Date: Wed, 13 Nov 2024 08:29:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Zefan Li <lizefan.x@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
Message-ID: <ZzTwHr3ah-MOPdx0@slm.duckdns.org>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
 <ZxlRLMwkabTaOrjc@slm.duckdns.org>
 <20241024-beautiful-spaniel-of-youth-f75b61@houat>
 <Zxp-nLXOJXoSy8BN@slm.duckdns.org>
 <20241028-meaty-mega-nuthatch-3d74b1@houat>
 <20241029203834.GA636494@cmpxchg.org>
 <20241106-vivacious-eagle-of-gaiety-44a419@houat>
 <ZyuzeIhTgXU5CCk0@slm.duckdns.org>
 <d6c57862-1593-44ff-a192-7af308cac94b@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6c57862-1593-44ff-a192-7af308cac94b@linux.intel.com>

Hello,

On Wed, Nov 13, 2024 at 03:58:25PM +0100, Maarten Lankhorst wrote:
...
> Thanks for all feedback and discussion. I checked mostly on patchwork so I
> missed the discussion here. Fortunately it's only been about naming. :)
> 
> I'm thinking of adding a 'high' knob as well, that will work similarly to
> high in normal mem controller. (so not proportionally calculated like 'max',
> but (usage + allocated) < max = ok.
> 
> Recursively of course.

I'd be cautious about adding knobs. These being published API, it's easy to
paint oneself into a corner. I suggest starting with what's essential.

Thanks.

-- 
tejun

