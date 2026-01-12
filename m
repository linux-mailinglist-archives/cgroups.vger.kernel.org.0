Return-Path: <cgroups+bounces-13056-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65401D10BA8
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 07:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 756243027801
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 06:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B956314D1E;
	Mon, 12 Jan 2026 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0b89kkcv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AD3148D0;
	Mon, 12 Jan 2026 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200164; cv=none; b=qhF8611BrxMvaZkP+XijceNtMNQu5xVYYJ1wVBtSXjas27uHHcSllB0OvSiOTYausP1zWcN9NAzh1JX7sg/D4EB5kDGxq+e1/kbJjvu8KZ/4dlQMr6lrlhX2w9Ocy8VB9c4UF4vYbV3+2NqKllp+NrBVg+X7B/l7KiQ2+sAjEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200164; c=relaxed/simple;
	bh=+dUrPq0F+79c7GRLxwKofk/7S4A9ZHlHErXNxwAz7XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lysvGmxtRcPIOI/9PaDaPgx4DKXWDdUE7Umf39Us4HCEFGsRdtAzALIQ/n05RYPjLPHz+VOee/nvGE5xk8kcgwdLN+Dxe3TcPN///jhtoohU/A6EJPiTXPW4Zvdi2WXGhlXR8UQ2TXNAui8eON8WlX898NUmBhDSZOetbQTFjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0b89kkcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351DBC116D0;
	Mon, 12 Jan 2026 06:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768200163;
	bh=+dUrPq0F+79c7GRLxwKofk/7S4A9ZHlHErXNxwAz7XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0b89kkcvfGY3sj/CXMP7i0gRuwbMe3AM7+cRCpzbN35ZTxWUyf+PZALcZAOiQ47oq
	 x3Uvso4UtI7LPT/MH7OTQnIW3T7Op8ayzsMKSy8XEDE1SUERNzAPYxB78DcHRYDEDg
	 xyMegSvEWOCo0lnsCBoviomXBRaGxDI5sKVnQC50=
Date: Mon, 12 Jan 2026 07:42:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, tj@kernel.org,
	hannes@cmpxchg.org, cgroups@vger.kernel.org, stable@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH] cpuset: Treat cpusets in attaching as populated
Message-ID: <2026011230-immovable-overripe-abfb@gregkh>
References: <20260109112140.992393920@linuxfoundation.org>
 <20260112024257.1073959-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112024257.1073959-1-chenridong@huaweicloud.com>

On Mon, Jan 12, 2026 at 02:42:57AM +0000, Chen Ridong wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I did not send this :(

> 6.6-stable review patch.  If anyone has any objections, please let me know.

This is already in the 6.6.120 release.

thanks,

greg k-h

