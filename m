Return-Path: <cgroups+bounces-5729-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197DE9DFE49
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 11:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC616B27177
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 10:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495261FE44D;
	Mon,  2 Dec 2024 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BFQgfsnA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F11FBEB2;
	Mon,  2 Dec 2024 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134018; cv=none; b=HwF0mFTy9wcGCmCbeBiCXBvJJ8U4MVxA8JKR/325kbKF9XAPuKOHS/3EXOs/4MAWLZU91rVs0Qu3GKCYoiQMTN466S+GA2TAAKKuef3PZf1JEEJLHFmoF8IofP6AELqapkoz4U8ah6aWQxluIFKx6F1R6p34SXieJdB0UCHnigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134018; c=relaxed/simple;
	bh=kjdShMo8ju6umRuMdNFU7aTUyokBSBJdIPIoDdoDhJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCMsLJgBhs/ceiaf5XVXg8FzhHIheOpmFvO//BRKwftfNTSok5PxTbxdmeLroWn0iQ3W8vJ9sXU9GF83POkcbmjOl+K2xAbbMLg7UumZYTw+GL3XoOtdaM+LCc0+hD4UV+IrOaK0u1+rcmSJayJpf2RSJ8CXxPeO4gwix9L0huU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BFQgfsnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0C2C4CED2;
	Mon,  2 Dec 2024 10:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733134017;
	bh=kjdShMo8ju6umRuMdNFU7aTUyokBSBJdIPIoDdoDhJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFQgfsnA4QuTO69HniJR3/iU3US6sitz3fwIDftkEcDdxeKruVwOvnN0W/Qgv/rVt
	 wZ/nI6P1rdaxOgaWf+kv4b7VrV/PRXujC1lTlnjLT933ycvLelEyfSEbvzR/pn90GY
	 krnPjG1Gmgi1vfEKGlGnw547eH2BZgfMe3bY0C/U=
Date: Mon, 2 Dec 2024 11:06:54 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"shivani.agarwal@broadcom.com" <shivani.agarwal@broadcom.com>
Subject: Re: [PATCH 1/2] cgroup: Make operations on the cgroup root_list RCU
 safe
Message-ID: <2024120235-path-hangover-4717@gregkh>
References: <2024120252-abdominal-reimburse-d670@gregkh>
 <20241202095926.89111-1-siddh.raman.pant@oracle.com>
 <86954cae7edc065a9ec6465c38c0eaa22ce74575.camel@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86954cae7edc065a9ec6465c38c0eaa22ce74575.camel@oracle.com>

On Mon, Dec 02, 2024 at 10:01:54AM +0000, Siddh Raman Pant wrote:
> On Mon, Dec 02 2024 at 15:29:25 +0530, Siddh Raman Pant wrote:
> > Reviewed-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> > Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> 
> Oops, please remove signed-off-by it was added by git format-patch
> automatically.

Please fix things up so maintainers do not have to manually hand-edit
patches :(

