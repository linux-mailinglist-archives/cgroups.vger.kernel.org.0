Return-Path: <cgroups+bounces-10887-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FC6BEDE75
	for <lists+cgroups@lfdr.de>; Sun, 19 Oct 2025 07:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FB53E67BC
	for <lists+cgroups@lfdr.de>; Sun, 19 Oct 2025 05:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6576921A444;
	Sun, 19 Oct 2025 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxjuVyCj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A39189
	for <cgroups@vger.kernel.org>; Sun, 19 Oct 2025 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760851569; cv=none; b=ZcD0XYwGQWQAbm/BWTHiESLN+0W2gPJgNkuHSWLy8ojaF9pI5z6JY60cm8ChdIKlfpzV/cN1hVPclodAL42F+ujZ2GhnGALX8HoP7jj3tGuKMcxm3s8Lyogkck4FPHcV/DYRh1BJn9Ejc1pESTz7+9XhZymhU3C6DOVIkK/carA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760851569; c=relaxed/simple;
	bh=h0T3W8ouEen84XWfEFr7K7emuZQR6OFa6kJ8dT5AHug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+41iH5GVP8BKLFPkrkvpy/B6YKu00KVj0kGBrQbtG2VnYcqRa4oOCOzVB01UbVXl8+mgTVMg9+O7/hutKmPGvDkyzR3o1Am5uwn5wVoq3Rdwv6LBgSWqbhOhc9a1shfi3OnA1KP34sKmd7da/Uy2wEFMfVrcNpeKDo2T6WPbtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxjuVyCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A692C4CEE7;
	Sun, 19 Oct 2025 05:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760851565;
	bh=h0T3W8ouEen84XWfEFr7K7emuZQR6OFa6kJ8dT5AHug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxjuVyCjuycsSGac+RNNVFd+FJmIqkL2zAFOPsRfWoYDBxbzPUPfYAy1RhjhjFsrj
	 9fTQ9OsJwv1MGsUbZWZN5jE5mjfHyR4KyV4jiB/KyDbGdm7JUimNwIGiqA/tN3G0JH
	 7obs84LIEg/xlj2XPYEtuE2Vx0Jq1DXkFv38MjRwXX1cJW+S+/71NE//oZC54uDDsN
	 gYelzTN0RQnhi4Qq47OEIEXnHIQwvYxmpNPeASFMP5RUtkufBNGmWyb/3lV5ye8XWB
	 ZmnF01F8o1+y0hlAj9TNYU2FriPdksPTFwD09b810zLMhBYuu2mrbqRCqQJXbuviwR
	 6j/xhDNQQ79+g==
Date: Sat, 18 Oct 2025 19:26:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: cgroups@vger.kernel.org
Subject: Re: freezing() returned false when the cgroup is being frozen
Message-ID: <aPR2bL5S3jTWv5Se@slm.duckdns.org>
References: <d41dff2c-71e5-4ea3-b7d5-8412b5b0b3e6@suse.com>
 <aPQhJ2EW8wzuyjJr@slm.duckdns.org>
 <88463f43-347d-437b-b026-24e0c397dbb7@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88463f43-347d-437b-b026-24e0c397dbb7@suse.com>

...
> As you explained, since legacy cgroup is not that widely used anymore, I
> believe systemd is using cgroup v2, thus it's fully signal based, so
> freezing() is no longer the proper way to detect such freezing, but
> signal_pending().
> 
> Maybe some comment on freezing() about this?

Yeah, that sounds like a good idea. Will do.

Thanks.

-- 
tejun

