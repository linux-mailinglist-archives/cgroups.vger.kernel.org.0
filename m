Return-Path: <cgroups+bounces-5455-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4299BF4AC
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 18:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E07B2281C
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B6D2076B1;
	Wed,  6 Nov 2024 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTsgDwhA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073A205E11;
	Wed,  6 Nov 2024 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915674; cv=none; b=H/KA60e0+cKC5URc1jtnVnJan+i5zRbo5+EQ0DIQYF4CNixorvkFVGp5isvVugAH+FcEguR2MLn7ko98WUjaui9jUiWoWTDW8JAyERIwBTRbtNNspS3NQaAAb7TdaVtgY7SHoUiiB6NfQzDqHEQP9+w/0krFiCx+IZuVTeOEQjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915674; c=relaxed/simple;
	bh=jf7KOZW7MkxSdy84zxMPX5bS25WtjnjSgbIM0UxdFEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h80ihWrHWFt7adKbxaUhgl3OVOe5HH48OQNLxrc4v7cLzpF7JryO+44RX53GDOPwcrwhuhP+8CnAywxOfdx/VzQGB/9Tk0KexB6AREIXhZ3TmQE24aSNRugUTIGC/F1xqL4s3E/Pkwpc7YTKbHHQB+ANTuoyo53pTTve8bvlA5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTsgDwhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FE5C4CEC6;
	Wed,  6 Nov 2024 17:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730915674;
	bh=jf7KOZW7MkxSdy84zxMPX5bS25WtjnjSgbIM0UxdFEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTsgDwhAtgbqwMidiaW8Ha7yhg8jmHbzo7W9hpQx6mKw/OSFx6LY4kFKl3tIbe2wU
	 qP/9l+q1TUZf42LilTGMANRO0Oyx/cS+fchx+Ke0NaQNDl5jAeKZ7KUnWP0wTNiwto
	 gbuPhXGjdPxWl0X6UrBKWVK73mSSWPmOnC0tBzXNCLrmme/uyYceDKE+0YY8x2/3/E
	 71+N+XtQfoKekE/RYt88079238fNHR+NkfriEozpD90Az/dziyOcgq2ddoD2wSw7VL
	 Ik+LA5Y94Cz+JFJOHb0NqXD+PxIcfIZajO2lIPDR4lFMIvq7+sr08B0N0johkoTBxG
	 ZHBzGJR3F527w==
Date: Wed, 6 Nov 2024 07:54:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, longman@redhat.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zefan Li <lizf.kern@gmail.com>, Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v2] MAINTAINERS: remove Zefan Li
Message-ID: <ZyutWWrDL3vbFmSM@slm.duckdns.org>
References: <20241105030252.82419-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105030252.82419-1-songmuchun@bytedance.com>

On Tue, Nov 05, 2024 at 11:02:52AM +0800, Muchun Song wrote:
> From: Zefan Li <lizf.kern@gmail.com>
> 
> Not active for a long time, so remove myself from MAINTAINERS.
> 
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Signed-off-by: Zefan Li <lizf.kern@gmail.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Applied to cgroup/for-6.13.

Thanks.

-- 
tejun

