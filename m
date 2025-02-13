Return-Path: <cgroups+bounces-6549-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F701A34A7F
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 17:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C8117986A
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C12245AE7;
	Thu, 13 Feb 2025 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPbh0DvQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4D245AE3;
	Thu, 13 Feb 2025 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464428; cv=none; b=OBqvRHWhhrzxAqjNm9hNyrou/tPmXCdQ1kaBqWzSOd8YkKYOROMOGAbpvC2chIoOjPPJkxY9n1PJ0gcFJR5bz8SfOUYXwdajcrVHd4mjMj58EGnFTV4CtNtHpGGUtLu4zCFwFvtT+ub2wUhTBCCx0ng7fmSouOb8/AAqk/G90M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464428; c=relaxed/simple;
	bh=WSK+jxO7+eAn/ljN1yHLSuLqTYbs/23uKr5d2/62nfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLLrJur7pXhAcR/8DIDuIBxitleum92Up9hqdY0CTr/mgUCfdSUzFPSsdWmEUm0K4WgzQPx9U2B3GgnuF50kwJShReXvTyxs2xzALGQMP9HqirHyIBXXxUI77NEv90ZOVgRMIFfYFPJTVSBSTUwwaCIzIklh5MkTEU78SI1EN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPbh0DvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF86CC4CED1;
	Thu, 13 Feb 2025 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739464428;
	bh=WSK+jxO7+eAn/ljN1yHLSuLqTYbs/23uKr5d2/62nfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPbh0DvQd79c2wGJkuw54l1bZSctZ3gfT/+kGxZkEnAAn3lPUaqhAHE/EOEp2yIE7
	 f1JuJEPNo4Pq5gIbD50izjWZTVTOAKFlHWqViOLy1Ktk4M5p2YBabI6sIdw5BT6F8E
	 HViszApuKRvXInK7phxbamSg3b/XulDCi3BXNduORXE1Xs+eBjEIMpuEuKWqlNEo3T
	 BukV3hn99gKw06H5qkGfL0sAsIONxCK1NE1PV5XJfpYwSecQRHU+ZgX11Wirk7eJyc
	 dAL3D+J3vxl1jbYGtk/gwYqZHmSuOSv/p8iEofyTAE2Ns5zawx8yMcpNRBU0L4i6Sx
	 etsnK9BE+Lfaw==
Date: Thu, 13 Feb 2025 06:33:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, tglx@linutronix.de
Subject: Re: [PATCH v8 0/6] kernfs: Use RCU to access
 kernfs_node::{parent|name}.
Message-ID: <Z64e6gdsFL9i7Cl3@slm.duckdns.org>
References: <20250213145023.2820193-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213145023.2820193-1-bigeasy@linutronix.de>

On Thu, Feb 13, 2025 at 03:50:17PM +0100, Sebastian Andrzej Siewior wrote:
> This started as a bug report by Hillf Danton and aims to access
> kernfs_node::{name|parent} with RCU to avoid the lock during
> kernfs_path_from_node().
> 
> I've split the individual fixes in separate patches (#1 to #4). I've
> also split the ::parent and ::name RCU conversation into a single patch
> (#5 and #6).

Greg, the whole series looks good to me. Probably ready to iterate in tree
even if there are more updates to make?

Thanks.

-- 
tejun

