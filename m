Return-Path: <cgroups+bounces-4852-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883F0975CB4
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 23:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE1F1C220AB
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 21:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCEC1AE845;
	Wed, 11 Sep 2024 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0tU0ig6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37122EAE5;
	Wed, 11 Sep 2024 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726091838; cv=none; b=NMD05GSeKFnsw3o0zAKRlcgGgNCdorSzOMsm6q3QIKr7kaSTWGewNsEbRPO8+KVdyssGoRtfRnpDF8DlLPxtgS+vBWFkFmqH/BS7iIZe3a7fbScGh8JXmrflbIEJeXGsfcddMBgYLVDcdERXQThESSfprGShdMVBgFWhCZWMvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726091838; c=relaxed/simple;
	bh=RGIHKXqeK3cKjK9hGDwDFRzIy3fTQi81SyAb9jOpzX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pma167NQJLkKWeV+0d4JRsIc2ebicvrYlUTAuEbXggLWZDOsSELlzcWi8VBt3hVQoHBSz0VDDMbrZ0newo2Sxgx2jkY/mGrwBqV1ZBE76x0RyZ0vY3mcE3TaacckqMQu2Koh0IAt37sZzNlPxLQlRuQOwUImkB+jTtsTR5nZkvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0tU0ig6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47354C4CEC0;
	Wed, 11 Sep 2024 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726091837;
	bh=RGIHKXqeK3cKjK9hGDwDFRzIy3fTQi81SyAb9jOpzX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0tU0ig6FjRVBWJEyciWDWzHNxaS8Ixja8o+x0AXDczMok10JamkvVCiFy8GAat+h
	 bub/9+FVBO1li9uhPxRaaZnhIsVXHTSVger5qSEnwcujSOpZbY5mKgFwn2DHsV5Eca
	 FZBk3/fipudrm9YwjuCI9dSvsaeCiGrWvG1LUpcJbV4Moqz1oe3jc507S/ipi+hwI3
	 v3SIYYBRhWfBSRoVk7oWVZrUGw+SZwRLlL6F1Nv9VXCirBnplRPK5xJDEbSDwqZsTq
	 lVkkHbEw2ej+i/e9lIKmksx8JlBkaiZkXn9KKfyb7UREGSB+dhMb5Ucwq1vxg52HvF
	 bZzv6PeTZHhqg==
Date: Wed, 11 Sep 2024 11:57:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] blk_iocost: make read-only static array
 vrate_adj_pct const
Message-ID: <ZuISPEjVOG6JkjDV@slm.duckdns.org>
References: <20240911214124.197403-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911214124.197403-1-colin.i.king@gmail.com>

On Wed, Sep 11, 2024 at 10:41:24PM +0100, Colin Ian King wrote:
> The static array vrate_adj_pct is read-only, so make it const as
> well.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

