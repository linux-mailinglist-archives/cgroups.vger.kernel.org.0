Return-Path: <cgroups+bounces-5421-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED5C9BBCF5
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 19:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5EA1C21E63
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39141C9ED6;
	Mon,  4 Nov 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axsiRI6G"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9B179958;
	Mon,  4 Nov 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743933; cv=none; b=ef4xahCzBEUQ82UG+BWwGh3BSvTGkJZz5peFla15UwEQjEklj8BRZmX6CDN0dU7FAs80g/0ipUzKYtlsri0KGjuhtxB90/wBApMWyGKkTRe3vL1mkKE73HFoLqymE9Zr56aVAB2+5C/Omx+fa6I8U5keH8NQl1e9n8rjq2AO4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743933; c=relaxed/simple;
	bh=jNHzsEQJ6takp/T2Ap12pPreG5TEo6oWXCrXZGdFvrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrLboWXWriJWYwA4w7X48n/TO5xBf16rXhPNTmEpmZ8RQdXb5XlEto52ZW8u/lw4FUy7q9S3w6cxLYB114aEa4+lcQF2WvHa9bk5Kd3ptCii5JX493hgnogiiAtywW9wed3wu0HcXnBtNn1D2jhs/06x4RLp/WANiwWZ3tFE7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axsiRI6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9D9C4CECE;
	Mon,  4 Nov 2024 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730743933;
	bh=jNHzsEQJ6takp/T2Ap12pPreG5TEo6oWXCrXZGdFvrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axsiRI6GFC3Im3RaDQgFOZhqiV6hnNCLtl8LNHxkvfhPVsVzZZlAicKT/BtG8BY53
	 jmWHbEe6hMbmsgakfCPGGY2mcLhAn59bPUsTSwnwF1XED2C6CHsG1wYMP9XBE/SmpB
	 6e36dfEulXQqT73EMa38mv0RX0vz6FypH7WGUACBkaz75xL9mqpTh61T/Z4PXYm5xI
	 +sPfTDYWpm2f+A1w6t5vl4lS5tgS1zwSbFUDCgW26SBMOx9nVCbI8x0jxGkyWJWgmh
	 AkR1txKtA8MzMT5itlHeGJy6JahpiE4mZyGzlwurpQMKerkr2vHZzndPYamJUSM5V2
	 wNL9gqjwfIOlQ==
Date: Mon, 4 Nov 2024 08:12:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, longman@redhat.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zefan Li <lizf.kern@gmail.com>, Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH] MAINTAINERS: remove Zefan Li
Message-ID: <ZykOfDWLjEB5Sc8G@slm.duckdns.org>
References: <20241101095409.56794-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101095409.56794-1-songmuchun@bytedance.com>

Hello,

On Fri, Nov 01, 2024 at 05:54:09PM +0800, Muchun Song wrote:
> From: Zefan Li <lizf.kern@gmail.com>
> 
> Not active for a long time, so remove myself from MAINTAINERS.
> 
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Signed-off-by: Zefan Li <lizf.kern@gmail.com>

As Zefan hasn't been active for a while, removing makes sense. However, the
S-O-B chain above doesn't work - if the original patch is from Zefan and
Muchun is forwarding it, it should also have Muchun's S-O-B at the end. Can
Zefan send the patch himself?

Thanks.

-- 
tejun

