Return-Path: <cgroups+bounces-4899-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0628A97A7A8
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 21:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E01CB23960
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 19:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEBF15DBDD;
	Mon, 16 Sep 2024 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q3ubnLmC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E915D5C3;
	Mon, 16 Sep 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726513535; cv=none; b=u6mBOobZBD5vMpHsljTCr3DHry/Hnc8qy/E6F0ckrV6XHkNlM+MqNd0qEcAfqXL25k3AX8WfwnBzqutPuBBekdgxH/dRm6VYYRhm0435Nblmn6x6lMRSqoKsHbE2dIBJYCZ7BalZcNGHEf19344PJY5q8mHY8L4E+zA+N/b1JkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726513535; c=relaxed/simple;
	bh=EsncRPtGWeizXXfWsNe4JLZ/VxGwL9BqHCw6XxBh67I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWbLA6WdDIiknnw+VnV6KQUvO0ckruN0/EexIkxdRuiIYcRyG5SYLjaw6rElbEXXeXLtzZ2R49Td4t16/HUtrkhWvIXKnCNTZFD1wymZGHqykQ63mP53XG/1uDH6NBdfuautFI5WoZgSYmpY2Zjx4pNisIX3W0/9e8rO6dOdF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q3ubnLmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA9DC4CEC4;
	Mon, 16 Sep 2024 19:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726513534;
	bh=EsncRPtGWeizXXfWsNe4JLZ/VxGwL9BqHCw6XxBh67I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3ubnLmCvADTx1loWXurS2mN8slnL9/lctxTeT9aQvtOd6+Ti7FqpEeM3MsfrecmR
	 lft9v2S2HT6wFvjKug9E4ZIKJO+QoBn+lAGmDzIOC2J95c27Dw4bbVcPMWQH3c2iYV
	 LOsDLLymupo3kNfJRaBmJCBT9LEFU2xiqdB+rO70=
Date: Mon, 16 Sep 2024 21:05:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	cgroups@vger.kernel.org, Nadia Pinaeva <n.m.pinaeva@gmail.com>,
	Florian Westphal <fw@strlen.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.10 092/121] netfilter: nft_socket: make cgroupsv2
 matching work with namespaces
Message-ID: <2024091618-lantern-exclusion-404b@gregkh>
References: <20240916114228.914815055@linuxfoundation.org>
 <20240916114232.178821333@linuxfoundation.org>
 <ZuhPzTZxBLBU6Vx5@calendula>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuhPzTZxBLBU6Vx5@calendula>

On Mon, Sep 16, 2024 at 05:33:33PM +0200, Pablo Neira Ayuso wrote:
> Hi Greg,
> 
> This needs a follow up incremental fix. Please, hold on with it.
> 
> I will ping you back once it is there.

Thanks for letting us know, now dropped from all queues.

greg k-h

