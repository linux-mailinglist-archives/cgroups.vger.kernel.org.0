Return-Path: <cgroups+bounces-7017-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BF0A5E0AC
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 16:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57511883281
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72A252913;
	Wed, 12 Mar 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2kI93PJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471FB23A9B4;
	Wed, 12 Mar 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794065; cv=none; b=DCeI+9SYELnDnY42roEiTYsIXeqH2W0D4ZJYRBTSNqgzp2eSCGGUqPJQi2SJdRL6BcFtKm8ueDEy5AfonTDagtWpsqiXIQJy6DBPjiMFr87iKzFKwx4HUNkMhLd6NHzGVN4j0APXqcQ5SiwI1JUBIZOOjU15hN+Ip7fOlbvf+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794065; c=relaxed/simple;
	bh=+DjZrMhoe4S80lso1kZouk0162bjEZBCnZ+ayHsbcco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dO2HfJxEGZqX/tI3D/NzKuhT/GxrMfGF9rvim06oQPooC7OUQAi6agh5uilshTkxpJYn2l5k5Qgiz7MnFNC9cG0MOy/a6P1UrulCOvmLfxb+0CI5dk7uXrLrNigrvW7jYDzfSfOQ15F9MRxJMyz3070XZl97cp6b2xbL7oackHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2kI93PJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D38C4CEDD;
	Wed, 12 Mar 2025 15:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741794064;
	bh=+DjZrMhoe4S80lso1kZouk0162bjEZBCnZ+ayHsbcco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e2kI93PJwrZsHc79AU8BZ5RCBZLJoSoYEnUXthRsPCJ44E4PlwcYVZCmSJx/3RqB1
	 XlyLfcJNX6T75ZnzJH/NZI1KMS2od/AnGqIHY6u49ZrpOUgYpG+TXe/+SbF7wEqI24
	 72RFgJ8LygU37SC4YmEj0oQ2Bm8SFVIXNU7LwyuZqyF+CVcxLanFGMJJ+cnyQYVi8M
	 YrIfZhFiF/Heeusbqthq25bnHSgPq/8idyBLAE2bjTVQ6XuHMlKiObBy/V4bu9agt4
	 JKc9OFaaCWyygI/3LB5cBhmeSLoML0jga1RfTwjNzUygLOCcY6tFifRQO7V85ShQPK
	 IiDtquB5LnHTQ==
Date: Wed, 12 Mar 2025 05:41:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, josef@toxicpanda.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-throttle: support io merge over iops_limit
Message-ID: <Z9GrD-7tW6tKVimk@slm.duckdns.org>
References: <20250307090152.4095551-1-yukuai1@huaweicloud.com>
 <Z8sZyElaHQQwKqpB@slm.duckdns.org>
 <5fc124c9-e202-99ca-418d-0f52d027640f@huaweicloud.com>
 <Z85LjhvkCzlqBVZy@fedora>
 <Z88K5JtR4rhhIFsY@slm.duckdns.org>
 <baba2f82-6c35-8c24-847c-32a002009b63@huaweicloud.com>
 <Z9CQOuJA-bo4xZkH@slm.duckdns.org>
 <c1e467a9-7499-e42b-88ed-b8e34b831515@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1e467a9-7499-e42b-88ed-b8e34b831515@huaweicloud.com>

Hello,

On Wed, Mar 12, 2025 at 09:51:30AM +0800, Yu Kuai wrote:
...
> In the case of dirty pages writeback, BIO is 4k, while RQ can be up to
> hw_sectors_kb. Our user are limiting iops based on real disk capacity
> and they found BIO merge will be broken.
> 
> The idea way really is rq-qos based iops limit, which is after BIO merge
> and BIO merge is ensured not borken. In this case, I have to suggest
> them set a high iops limit or just remove the iops limit.

I get that that particular situation may be worked around with what you're
suggesting but you should be able to see that this would create the exact
opposite problem for people who are limiting by the IOs they issue, which
would be the majority of the existing users, so I don't think we can flip
the meaning of the existing knobs.

re. introducing new knobs or a switch, one thing to consider is that
independent iops limits are not that useful to begin with. A device's iops
capacity can vary drastically depending on e.g. IO sizes and there usually
is no one good iops limit value that both doesn't get in the way and
isolates the impact on other users, so it does feel like trying to polish
something which is fundamentally flawed.

Whether bio or rq based, can you actually achieve meaningful isolation with
blk-throtl's iops/bw limits? If switching to rq based (or something
approximating that) substantially improves the situation, adding new sets of
knobs would make sense, but I'm skeptical this will be all that useful. If
this is just going to be a coarse safety mechanism to guard against things
going completely out of hands or throttle already known IO patterns, whether
the limits are based on bio or rq doesn't make whole lot of difference.

Thanks.

-- 
tejun

