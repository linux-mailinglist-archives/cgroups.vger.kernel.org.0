Return-Path: <cgroups+bounces-5732-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C9B9DFE9D
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 11:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE5C281DC5
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A5D1FBC84;
	Mon,  2 Dec 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rQD3WJAB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE531E2611;
	Mon,  2 Dec 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134624; cv=none; b=VwwyA8XYpWdGeizFGF6vcCGcMlOprMZ0A/h0MQ3wCsP0YXdU74zpgHWrv+j2HUOOlowGBbbbW4r8r6Taw2Yv6XIVhPIeh1WSRspuPJfs/7m81IitpKtfpDhtVrwSh3dbMIiVQLG+hAA2jYizyhgXH77U9izOZepK2DyrnO7qesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134624; c=relaxed/simple;
	bh=nZbkxdkI+UVgIhtCGdCYWt8vDIXlQH1fcvRaVD7SFok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsnQHCEqahnWEf3gBiegjSN0SRGoD6QJ2zFLEHPAF9UsDx374GhFi3WL73OC1+PNHL+KvR4RofLNo8cReruTF3yRoL03egeT2w0P7mtQEy75yPyQcaxWNxFHdW07B5U42IBR90bdr8OtOdX8CGm3OQuc7rxWaAI61ooqKcxu/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rQD3WJAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DDDC4CED1;
	Mon,  2 Dec 2024 10:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733134624;
	bh=nZbkxdkI+UVgIhtCGdCYWt8vDIXlQH1fcvRaVD7SFok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQD3WJAB2SmQbkY8yL2Cb8ReBFEl3EYPEYL6vEV/4gqjyc8eviy7m2j/ikRpdS4m4
	 Va2PJoqEZUzkcVIDSUCnELSfpBZZUcZlH4AfxPHIY7AjCnSsoaBOQ7bI7view//VI5
	 wgpu0r8n8Vt+DRuckJaDHiJValRfNmfcJf/50rrA=
Date: Mon, 2 Dec 2024 11:17:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	cgroups@vger.kernel.org,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: Re: [PATCH 1/2] cgroup: Make operations on the cgroup root_list RCU
 safe
Message-ID: <2024120257-icky-audio-cf30@gregkh>
References: <2024120235-path-hangover-4717@gregkh>
 <20241202101102.91106-1-siddh.raman.pant@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202101102.91106-1-siddh.raman.pant@oracle.com>

On Mon, Dec 02, 2024 at 03:41:01PM +0530, Siddh Raman Pant wrote:
> From: Yafang Shao <laoar.shao@gmail.com>
> 
> commit d23b5c577715892c87533b13923306acc6243f93 upstream.
> 
> At present, when we perform operations on the cgroup root_list, we must
> hold the cgroup_mutex, which is a relatively heavyweight lock. In reality,
> we can make operations on this list RCU-safe, eliminating the need to hold
> the cgroup_mutex during traversal. Modifications to the list only occur in
> the cgroup root setup and destroy paths, which should be infrequent in a
> production environment. In contrast, traversal may occur frequently.
> Therefore, making it RCU-safe would be beneficial.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> [fp: adapt to 5.10 mainly because of changes made by e210a89f5b07
>  ("cgroup.c: add helper __cset_cgroup_from_root to cleanup duplicated
>  codes")]
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> [Shivani: Modified to apply on v5.4.y]
> Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
> Reviewed-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>

I'm confused.  You do know what signed-off-by means, right?  When
sending a patch on, you MUST sign off on it.

Please work with other developers of the Oracle Linux kernel team to get
this right and send it as a whole new series, properly versioned, and
tested in in a format that we can take this in.

thanks,

greg k-h

