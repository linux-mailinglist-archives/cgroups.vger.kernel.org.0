Return-Path: <cgroups+bounces-4141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81F494A5B8
	for <lists+cgroups@lfdr.de>; Wed,  7 Aug 2024 12:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93ABD284726
	for <lists+cgroups@lfdr.de>; Wed,  7 Aug 2024 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D636D1DD3B4;
	Wed,  7 Aug 2024 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckm8qITl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CAE13F435;
	Wed,  7 Aug 2024 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027083; cv=none; b=eP9+Qq1TrSQacQ4izHX6ch8VACKInTs25+GJxKDQD3YWXlSJWxvq+YcvjAs9Os8jMIC1N0hOot72LSe9LGqoOoL5+/8llPzayeGUNLvFK7wtz0eFoQvbD52XLpla0OLG4a7oSQiXsTk/9VRKGDBazLLYDNLFFS0LtJrCLYIvEkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027083; c=relaxed/simple;
	bh=CgJQNX4IMLBr4rldCAKUeGkrwKqcsrBFuXYw6tjH3iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TckpHj5mMOEDmu2xkHTzhFHWFIgrnNVwB7M/r7do8BcXWqerkYwe09X2wRSuC017EwnqHy7aWNRtJ77mzrnPY8kHt/nbzB1DIa4nGua8nC2qO+b9wSNL2oMfn/xfF+znexGcLjhhfKXG8JuNrX4bokL3m6367xLX0g7uIfGQxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckm8qITl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0599C32782;
	Wed,  7 Aug 2024 10:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027083;
	bh=CgJQNX4IMLBr4rldCAKUeGkrwKqcsrBFuXYw6tjH3iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckm8qITlHd2LOUZt5aC6zganRhl8DXzTRCtr2CR5awTMNkRVKcxHH+kltxZrvHYyA
	 lT06f6v9A83FFdr5+Wt4fLV+auH1E4gKL7CwoWCnSwU/gPIdW0/RjCJ9WfHXoDDHcb
	 yimVF0VTbsm73eMmR69m0Oi8I/hSaEKhcU4acM5YM2eSgfF2dDzHnsO4DVNIonS4SO
	 DO2S4r4CxNUHdpFOF2683NdpU7BA9U2QzyjbuujMiv780srNi85za1/kEzt75ldzox
	 9Y7TNKm+DttOQs45yb011JRt1ADX+Jf5cF6TJxi+8rdxpFFd0m88S2Mlp4RUMbB+bt
	 NTuEj84zHqQmw==
Date: Wed, 7 Aug 2024 12:37:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 23/39] fdget(), trivial conversions
Message-ID: <20240807-sport-privat-a33bc176a76c@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-23-viro@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-23-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:09AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> fdget() is the first thing done in scope, all matching fdput() are
> immediately followed by leaving the scope.
> 
> [conflict in fs/fhandle.c and a trival one in kernel/bpf/syscall.c]
> [conflict in fs/xattr.c]
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

