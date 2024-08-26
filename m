Return-Path: <cgroups+bounces-4464-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6DD95F8FB
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 20:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A341C216A0
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 18:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC191991B3;
	Mon, 26 Aug 2024 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltW5hL44"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34DA18FC83
	for <cgroups@vger.kernel.org>; Mon, 26 Aug 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696992; cv=none; b=kd+3J6mIknBQZkBdv5/wg6/Ni35mOn1fO0DJaSBSL1wk/NfM3pniPJMTXdYw+ZPxHZXGPaRvaESZr5c/mZeG8xvFCzfVkDN1jpMyU8+ZfD2+dPUOlFNTidbOwgvUivClHiAKrZHe2s5a65C2i5paJH3RS5a3ajXTVwxYKTT1b4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696992; c=relaxed/simple;
	bh=c60b7Mg6iVPLbQjWE69pxVj66BXVrOoksd2Qdb+OnLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkQAhpEOctbI/Bv13cWjhIChnWEoiz2BCLzQD9n+sCMEDNty8XmTshc0AAnsXBRFqLQweYUO/rmmF3gqMg5v6Zu84A3aIbitT0A+AzSFWbmneM48PEFrBuOCB4L+nJdU1qVGnTXyi92QlWnUOVqNPs7fYHt+HAxFfi1F9nYo6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltW5hL44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3453FC8B7AD;
	Mon, 26 Aug 2024 18:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724696992;
	bh=c60b7Mg6iVPLbQjWE69pxVj66BXVrOoksd2Qdb+OnLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltW5hL44rNLU01BUO4vjJtf35W2z3CRzXWsQ1bbuUj5HHnQQAro23OcSw1KYSgo5R
	 AopE3g20zJ8xs/ENdksC26dgN0RgFj3bOl6oDjEf5hsJcQJLUnXuGZvGfN/muW2hHt
	 6aezisF4rNugPti7MWFFumPSTqcnEPM8f4957HCzmEonA+kKm86iKh46RBKZsmJTVA
	 e+HyH+Q0VU6vbDVgGEvjcN4c6LAVd4PopkjSCop/XDUePBa/otjRt64GFWeNIc3KHe
	 FzPBJ4YqC7Pwusc23LrolaLQsZa7iVzI6yzMP56J+n/n2ZSEy1Nr80v25GPWImN7T+
	 etyY/T49fuQaA==
Date: Mon, 26 Aug 2024 08:29:51 -1000
From: Tejun Heo <tj@kernel.org>
To: StanPlatinum <liuwj0129@foxmail.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	weijieliu@nankai.edu.cn, lizhi16@hust.edu.cn, 15086729272@163.com
Subject: Re: [PATCH] Integrating Namespaces and Cgroups for Enhanced Resource
 Management
Message-ID: <ZszJnxg6PYLaqLwM@slm.duckdns.org>
References: <tencent_BFC5A388F2922E5FB6F3FE2E3A3662561809@qq.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_BFC5A388F2922E5FB6F3FE2E3A3662561809@qq.com>

Hello,

On Sat, Aug 24, 2024 at 09:17:11PM +0800, StanPlatinum wrote:
> This patch not only strengthens the Linux kernel's resource management
> framework but also enhances > security and efficiency in containerized
> environments. We expect the community to take heed of this issue and
> collaborate in enhancing the security of cgroups.

This might be a great idea but it won't get any traction if you post it like
this. If you actually want this to happen, it would be a good idea to look
at how linux kernel development is generally done and try to follow the
conventions.

Thanks.

-- 
tejun

