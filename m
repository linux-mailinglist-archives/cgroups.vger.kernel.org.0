Return-Path: <cgroups+bounces-6408-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BC1A2497C
	for <lists+cgroups@lfdr.de>; Sat,  1 Feb 2025 15:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0387A1883E9D
	for <lists+cgroups@lfdr.de>; Sat,  1 Feb 2025 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBD91B87E7;
	Sat,  1 Feb 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="Ti5fjUya";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJ6BBRPw"
X-Original-To: cgroups@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C561586C8;
	Sat,  1 Feb 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738418941; cv=none; b=daaFGGY+kewiOr14pD2hiGJlsDjJBDnuZTofX2OOaoUmJQFEIlCA8lUoQAzK7305BI0xL65oQu6cYgp16Top5DQ9UliXbhqvQiMEsp29miEPY0IrZD4OWsuTBVQ9HIQ+Z4JCJ0odnacJSr9Y/XCATpDCpIvOpanFsFgOtfIhe94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738418941; c=relaxed/simple;
	bh=60iSH3xkgzYLu5tNPSL6p85EuOS24Vc5RQZXS9zkAkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pvy0fW4R2G5nz/7Ojpz63tvIUAk4QEMGvX/V31gaWdHhmjuiWQqdcjCLcZLJTobxFFEyhE3FCVpMJenjZN+8bfINyN+iS6Y/hnFnrKd2wXBsi4lIDWBgJZkqJWO+mVcY2UlqVasZvqZS1x5gR0wOHa0rdK3ivo5/A1vram9btyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=Ti5fjUya; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJ6BBRPw; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A96BF11400F6;
	Sat,  1 Feb 2025 09:08:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 01 Feb 2025 09:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738418938; x=
	1738505338; bh=uhCrR4gpWxcjRPhfgaQgwAxhoK1eIO+GJqfVxvXMHEU=; b=T
	i5fjUyav12jpsKOSiohw6VInxbucj5+NwrACDLl4mSIF7up0wG1qnPQpkHcABDc5
	8cmfRSQbe+SjYwSjBRU04mMvIFHAreV8cpywqv0AnMD/paNRkVG5rCktdrxP80GH
	wDtYAVyBoE+gy+3mvVgVrIjy45qWdJAFVdSVPYexn9i0S51kinKyENSNG1LFC986
	IB4L7cHEg4xF8J7T1Sk7rZEUpYlywqU818k1hUZFOp/frcJm/dnVDxBz8XyL59ik
	tZgSlCIQyMa/5VFMtEU1H7Z/GDkAr9c8zSXyYE6d8xvViENkPsVkAzT1pjPRzpKX
	JkmQYtR96J1DVMoBp+8Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738418938; x=1738505338; bh=uhCrR4gpWxcjRPhfgaQgwAxhoK1eIO+GJqf
	VxvXMHEU=; b=VJ6BBRPwS+jpQg3kr4Zh0vT9UoMM1MpvWdalAZRuPUHYYp//rfV
	SThysL/nZXX3AND5+sP+DkDrmdNTiqxIdVIz8M81i9YY2E3DgH6LvZDUgQXOacNE
	8Ce/mzm98LhR298fwirQrMVMXr/Q0sFTGnUTU68Nw1fjw3+KqTcVCqnn62+KYfym
	CTvm2ejdrvX61BU8yNykav62rMT89ArxbIvzvjy5VXSvXcmafw8PMl+hI8F04Gkw
	NU0ExRyoRuqG5cp258wgCJ17/u2zbbV/70cJBJoWGC9zK2HOej1f+bqVjNXtTtrP
	MCHCIaZlV2UxlgZ1eZsvAszqOGhLcgTIjFw==
X-ME-Sender: <xms:-SqeZ-xI_3gOfckwUnvrypoI8Q_RgC6jTHAZ-nTvASJtBHS-Bskmqw>
    <xme:-SqeZ6QwvAkcCtGVupqXyokP5QgjWMbPcJa0xvjgzOOU-X7s9jdKBPgomaYDhY0a_
    i2f0W54VZ0fucCx9ss>
X-ME-Received: <xmr:-SqeZwVmZD94GQ1OTVhpe4Q75yfyPJtsT8Bj3n7tC6ssFb1O5qYSOEJRXY5ssfFq6lRTMap-iwJ-xhKFkQHTSGWYiTV0fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffgffkfggtgesthdtredttdertdenucfhrhhomhepffgrvhhiugcutfgvrghvvghr
    uceomhgvsegurghvihgurhgvrghvvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduje
    fguddtueetgfegfeegueetkeetgfffieelvefhudetuedulefggeetgeffleenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthihnvgigihhumh
    esphhrohhtohhnrdhmvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtghhrohhuphhssehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdhorhhgpdhr
    tghpthhtoheplhhiiigvfhgrnhdrgiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtth
    hopehtjheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgihnhgvgihiuhhmsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:-SqeZ0ha59j2dMjHpf-PTGl9hE3sXeBbs6rfPMftFXt1ci6W4cORig>
    <xmx:-SqeZwDlQRznpw5aMW0WbJ6dRn8wfR_Mw4-7XlreOrF1VSSmvnmwQg>
    <xmx:-SqeZ1Ids9img0SFAKTYRnxL_Z5l6HSoOvpuVvyIXzpRgTT4ttajIg>
    <xmx:-SqeZ3C50MausHHSdFCZvf-x9DlQhAQ7LI7QtT37Cu5yakJTAzQ3HA>
    <xmx:-iqeZ-Ar421iA7Bhwda0MaVn7tOekk4XNtHfYjl9sI0uL9D2NVztTNUZ>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Feb 2025 09:08:56 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Umar Pathan <cynexium@gmail.com>
Cc: tj@kernel.org,  lizefan.x@bytedance.com,  hannes@cmpxchg.org,
  cgroups@vger.kernel.org,  linux-kernel@vger.kernel.org,  Umar Pathan
 <cynexium@proton.me>
Subject: Re: [PATCH cgroup] https://github.com/raspberrypi/linux/issues/6631
In-Reply-To: <20250201095145.32300-1-cynexium@proton.me> (Umar Pathan's
	message of "Sat, 1 Feb 2025 09:51:45 +0000")
References: <20250201095145.32300-1-cynexium@proton.me>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sat, 01 Feb 2025 06:08:55 -0800
Message-ID: <86cyg1bvuw.fsf@davidreaver.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Umar Pathan <cynexium@gmail.com> writes:

> The existing freezer propagation logic improperly reduces
> nr_frozen_descendants by an increasing 'desc' counter during unfreeze,
> leading to:
> - Premature parent cgroup unfreezing
> - Negative descendant counts
> - Broken hierarchy state consistency
>
> Scenario demonstrating the bug:
> 1. Create hierarchy A->B->C
> 2. Freeze C (A/B freeze via propagation)
> 3. Freeze A->D (separate branch)
> 4. Unfreeze C -> A incorrectly unfreezes despite frozen D
>
> Fixes: 711f763 ("freezer,cgroup: add freezer.stats subsystem")
> Signed-off-by: Umar cynexium@gmail.com
> ---
>  kernel/cgroup/freezer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> index e9c15fbe5d9b..d384df2f53c2 100644
> --- a/kernel/cgroup/freezer.c
> +++ b/kernel/cgroup/freezer.c
> @@ -304,6 +304,7 @@ void cgroup_freeze(struct cgroup *cgrp, bool freeze)
>  			 */
>  			if (dsct->freezer.e_freeze > 0)
>  				continue;
> +
>  			WARN_ON_ONCE(dsct->freezer.e_freeze < 0);
>  		}

Hey Umar,

I dug around Github and I think I found the patch you intended to submit
https://github.com/raspberrypi/linux/pull/6632/commits/711f76376ae7e11f48a1c22a4a04828a24d6a87a

Unfortunately, your email only contains the inverse of your PR's
whitespace change removing a line in freezer.c, not the rest of the
patch. Did you perhaps revert that whitespace change in a new commit and
accidentally only submit that commit instead of the whole change?

Thanks,
David Reaver

