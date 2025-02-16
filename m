Return-Path: <cgroups+bounces-6560-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50217A3757C
	for <lists+cgroups@lfdr.de>; Sun, 16 Feb 2025 17:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F83D7A1819
	for <lists+cgroups@lfdr.de>; Sun, 16 Feb 2025 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F65F19994F;
	Sun, 16 Feb 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfNO+Eem"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372809450;
	Sun, 16 Feb 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722313; cv=none; b=cBDjkBQq1cF62udOiaz/lxQseXjnxR5NItb1dyUoW301DpQj7h28HpyfRqMEIykKnHQy/xxzb/vv5rwiCPPnB4Kmco4KGKcJc+UiU/xYCkynPcGTQgarw4C3jtBbJ/TKxkdxdBaaP+UMnVYvN6EM9txhswRqeB8yOEUq2ioYL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722313; c=relaxed/simple;
	bh=IuYx+RCyfyZ6iqiPjwSDvnja0Qr0myQxPu/vJqnSYdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6PQ+iyZHU1NmWAlMiK38nLHtgRaFGa0bCYuVlSmQ9mLTuxeOaCzhzaBPxezq8/4T+3zyRKab9LKNMQ8K7E1n7j8yaQP65hrsnwmloh3zdV3Ho8JUabdcd7XRFw7Y0a5xtOd5btWDfoonPIQqqVSyvJdSRf6f+M+EDi+dNpeGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfNO+Eem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CF5C4CEDD;
	Sun, 16 Feb 2025 16:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739722312;
	bh=IuYx+RCyfyZ6iqiPjwSDvnja0Qr0myQxPu/vJqnSYdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfNO+EemfjTmmipKYxMl+sGeair0y8gIwc0AFZbmNMvzUV4cW+2l6vzU1UoMZxtbg
	 CIU37PKhq/+0idxPtUnqDbxCMCMGxm2jbRyW73MHzrtZ7iov0QmDXiADDMt0XZVKrJ
	 wvfrzr2jO0jt3Ct2Wbl5vRFXWg+oi1sywkPm7NaHMywgxH8FcMHNrF49SOqalERvBH
	 lLAnxDCza/Mcl2xz3UQOlE3Mw5lMyhMOZCJO7ViwOBwo4NFa4LIuT0unURdmK8bmwr
	 UnPl/fFbWWqsz0oZ4BM5dNpVShpOnIpigxgVyw2wSbRx3qXFYDGUUtqYc3urrOHGRx
	 HuSEqo2N4SbjQ==
Date: Sun, 16 Feb 2025 06:11:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Aditya Dutt <duttaditya18@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests: make shell scripts POSIX-compliant
Message-ID: <Z7IOR2UNzjy7cQA7@slm.duckdns.org>
References: <20250216120225.324468-1-duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216120225.324468-1-duttaditya18@gmail.com>

On Sun, Feb 16, 2025 at 05:32:25PM +0530, Aditya Dutt wrote:
> Changes include:
> - Replaced [[ ... ]] with [ ... ]
> - Replaced == with =
> - Replaced printf -v with cur=$(printf ...).
> - Replaced echo -e with printf "%b\n" ...
> 
> The above mentioned are Bash/GNU extensions and are not part of POSIX.
> Using shells like dash or non-GNU coreutils may produce errors.
> They have been replaced with POSIX-compatible alternatives.

Maybe just update them to use /bin/bash instead? There haven't been a lot of
reports of actual breakges and a lot of existing tests are using /bin/bash
already.

Thanks.

-- 
tejun

