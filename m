Return-Path: <cgroups+bounces-8279-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA11ABE4B1
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 22:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CEF17607B
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 20:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0992328935B;
	Tue, 20 May 2025 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHol3hK9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B74157487;
	Tue, 20 May 2025 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747772806; cv=none; b=BN6AOyv9rwq7h3NWPpyDP//6aiiUmLtDfdJI4eNZ3O8IWfKzpsSIVHKbzGHGmshop6+R3X5dkPwQhUZ45qF1Xypo2K+66rHYELwVsJvHNCPw5X+oCxLG0EgbhFrJ/GVYfKesgJVXYy6ZLWD30cI3CV9c6JfkKK/bvj/ZDrmEoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747772806; c=relaxed/simple;
	bh=wJaYU1TMzFkzmK0srycFV8tZHk+JhdlwC8NkA1IKcDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/RcrTJCnS7V75g0/MBMQBjCyf0tfXcQnqUQ7r7c011k6uR5cfaysb0eL369/YCoNGPfni+4D1Jv5B09uB/cFmcI/Ls1vupe0Eb+Qgu92qx0JsZCvOCjRO0YTtYP7sC1cdWegcIhD4oxc3oi5cpv5g0HJRl3434BNlgi64/GSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHol3hK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F1BC4CEE9;
	Tue, 20 May 2025 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747772806;
	bh=wJaYU1TMzFkzmK0srycFV8tZHk+JhdlwC8NkA1IKcDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QHol3hK9HV0IW/FNR/knUWbemJPaDkLlzwPzVz6sp4nbGHEv3bkZOW266Fg18SKcs
	 zNZEqEfYmiWEPZYhZ+o3zCCbNIRR4pH/DjpMUDmbQZSdh/Kl3sENeR0xLN9OTtMOqV
	 /yjcgVxbnak3kwMH1oXRBPhvzrgDKtjAuEIDDGZ24KQG4HidmtxldUMQ+hvOkC7NBK
	 wP/JmcJjnM5RtaGmNRv0pgGujAuF3UQZlqw5B1oYkVxcngevImlmnJThFiT67Q5CfA
	 O2bJMrGhKD0sK6eemW5gYBFbYbPj4helTO+iLIlMrryhgPhL2JdI7OH65w3P6u+36b
	 h5NenvY7gqtjw==
Date: Tue, 20 May 2025 10:26:44 -1000
From: Tejun Heo <tj@kernel.org>
To: shashank.mahadasyam@sony.com
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v2 2/3] sched_ext, docs: add label
Message-ID: <aCzlhJCdW74nJreb@slm.duckdns.org>
References: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
 <20250520-rt-and-cpu-controller-doc-v2-2-70a2b6a1b703@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520-rt-and-cpu-controller-doc-v2-2-70a2b6a1b703@sony.com>

On Tue, May 20, 2025 at 11:07:46PM +0900, Shashank Balaji via B4 Relay wrote:
> From: Shashank Balaji <shashank.mahadasyam@sony.com>
> 
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

Applied to sched_ext/for-6.16.

Thanks.

-- 
tejun

