Return-Path: <cgroups+bounces-6112-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76B4A0BFC5
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 19:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65CE1614A9
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 18:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D601C242C;
	Mon, 13 Jan 2025 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn54B0Bh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7931C3C0B;
	Mon, 13 Jan 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792808; cv=none; b=OWgz3RR5oz1kniOSh+aSt6EIueZ9sMUbXy8xRjox7x4mVvlUb281uHpJ8VXJ/R+vfkT8WjJyVx4HFMJq3E5P+M/5ADldpLNR2E6J/Hl08U3Em+iyXgJ7X4skANkEnRHm0UE+Th3xukqYngHFqsjiaFPj8+NOlQazcT3N+SlPanY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792808; c=relaxed/simple;
	bh=qrnMO+SEhArbD9drBVGu2JBe+n5ukAPSY/0qzjKehrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc3z1/L1vfaDI0rIy1sRCh95hxj0dM4QNHAGp9e48rRBtNBFJLff8InHq+j5eNWMUsWP5GpdIKEWwMZij7moSO+zow2AWUNgHmyDTC1cAoLz9ZTg+Eqlzuqe95BMyI63EOFEdoMaOBJGaI35A5MT1LV8sLVfRcrudlUkYNXeyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn54B0Bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99091C4CED6;
	Mon, 13 Jan 2025 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736792807;
	bh=qrnMO+SEhArbD9drBVGu2JBe+n5ukAPSY/0qzjKehrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gn54B0Bh1ocuPNt94ilrpJoyStCw1HLF2Z3xH1mEg+Z+t6DzHOlO53/hEAi6vjcET
	 uZ2FkNu6Zoiq5BAj0PlVYTxDsN9w7de7d9XxK66SHFu5icLxHeXOWpLh49vCx4+1M7
	 /cnXchY3zpbuTOiD/jA29a7xWipBfKWsvT1tVO7UA6oR/Bk45BYmg4BKQ0ecocM/Un
	 BgOx/sTDVSxSB/ZC21Nv0snVOSsfHCnd5njxWoGGCoF7Lv0gAuYjJKw1XBJNBMXFWg
	 NWrJPtp+yzh1kUGGME7ieK9nSaj7KC36TTdTL/KycUsQIyIDfL06nwr92g+Ym6lf7O
	 rkqpVj5q/p+Jg==
Date: Mon, 13 Jan 2025 08:26:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Haorui He <mail@hehaorui.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, mkoutny@suse.com,
	hannes@cmpxchg.org
Subject: Re: [PATCH] cgroup: update comment about dropping cgroup kn refs
Message-ID: <Z4Va5lxSMo1o8bXg@slm.duckdns.org>
References: <20250112144920.1270566-1-mail@hehaorui.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112144920.1270566-1-mail@hehaorui.com>

On Sun, Jan 12, 2025 at 10:49:20PM +0800, Haorui He wrote:
> the cgroup is actually freed in css_free_rwork_fn() now
> the ref count of the cgroup's kernfs_node is also dropped there
> so we need to update the corresponding comment in cgroup_mkdir()
> 
> Signed-off-by: Haorui He <mail@hehaorui.com>

Applied to sched_ext/for-6.14.

Thanks.

-- 
tejun

