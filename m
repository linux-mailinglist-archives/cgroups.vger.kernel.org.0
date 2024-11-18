Return-Path: <cgroups+bounces-5618-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082099D1632
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 17:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CC6283449
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A731BD9D2;
	Mon, 18 Nov 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hI6mieFx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D469A1B0F1C
	for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948910; cv=none; b=S7BYcO+0WwcB5Dod0nt8zFiSjf4SnzX1k0C938IBxZ27B8zoLMRCFNt7NddD5Npxb7EjkRnpxdTpzVwhQfXnsZlzN6kwmpYkuGUrAVpzxfpCn8o5NwNHw3ltQn522jacxbcqzbXJ/INI93gv1MCcM9WLulcfnWG8Cei6WNKXTy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948910; c=relaxed/simple;
	bh=GKMK1JyMM/Q/eWMg2voURQA/7Mbh9yXQofE1v3nkpjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0uO70OAIrdOL3U7GJcCCHF74zaVk/B29cLBWt2cCx6mr9BDo3M0ZPeNngRntkNUGyonXN27OKqu98lJjFpXEHLp+SDLW37kJzzOqYwIPWN03ftc4Yh2hZ0EDEWTY5/pNu2hIZaSbS9SEkt++/bAquVFG3ivugg8iWLeMcMt5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hI6mieFx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Nov 2024 16:55:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731948906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9MyUkf9dFAGGvoHW/TFh5DAeq21F6yqqmWM9DWahjA4=;
	b=hI6mieFxDX5Vs8/RL06upqqLHz6XZpfD4LWSKnGviH59x6MKdGx2NLI2ZqAJpxQt7w65SH
	6KDAl/Ks3ypnp4ZLPp4eyMqiYMN7N1PoKWs1xQlaONbjLduKyLYso+imMA0bxZFJHLiUVZ
	LwvgZOHUyoH/2C3+pSQYrHN7YoVCGKY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Keren Sun <kerensun@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: remove unnecessary whitespace before a quoted
 newline
Message-ID: <ZztxZP1GkhPgziRu@google.com>
References: <20241115235744.1419580-1-kerensun@google.com>
 <20241115235744.1419580-3-kerensun@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115235744.1419580-3-kerensun@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 15, 2024 at 03:57:43PM -0800, Keren Sun wrote:
> Remove whitespaces before newlines for strings in pr_warn_once()
> 
> Signed-off-by: Keren Sun <kerensun@google.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

