Return-Path: <cgroups+bounces-5836-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2339ED950
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 23:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB831882455
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 22:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F501E9B3C;
	Wed, 11 Dec 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U1h6E/oK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB731C4A20
	for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954740; cv=none; b=TLGUEkyXgBgnpmy0xekFQC6aZ0uEF4xrNjMobKzcS6U19ZgjmmQ4mgjeNV4zUtaTZ0znxb3sqrmjlB8FqM3njoqWtIoTo54qD/lx9a6Wfsbg9n8O//mDO5otc7J6WryCfb3+fS9AutoWBnZZOKeuTJHLsm4yEGH8nk6K+ZxP3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954740; c=relaxed/simple;
	bh=EM6RN1Y8fkV2+aD2fnXXYb+/aGWtN4RVenYfbRsp9UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyc2L3qnUOzZ6e92zhvT5z0AUJy8j9nLqICz0gI0pkAAI9y0v6utbdS3wVwszzhhYnzKrpLu6m0EDPGG2MlBhRzv3IYo8pWGa1itfN7fNJuiyEHxd7xt5l5qN65Cvb865bMFKTBwqrAPfGwj8VFEMIuKj6G+haOTuXG7JdY9roU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U1h6E/oK; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Dec 2024 14:05:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733954735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVgcEuCnW7ND1Ke1KnD/NQ5ObPzdolVfXNZnx8wq/xk=;
	b=U1h6E/oKYfOvkpzKYmiAIz7NbTTiJfsV7+9Z4bDhou7RmNWpAltHNBj8GnkSLbTYy2+BoJ
	E6QP2JRnUqTnPuS5ouOBDG5YW5QJDsgFMl498fEFnRHRvxY5cJizW3LhrLkaFJu4kYBmx6
	VzsSeAAYGLO7TdGFLdF3qJIuyyKk8ok=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, sj@kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [v3 PATCH 1/3] memcg/hugetlb: Introduce memcg_accounts_hugetlb
Message-ID: <mi54ropabzamou2aluq6qzyxjmxrml7i7xpdpzsikhgm4gawhd@fyx7ig6s7rvm>
References: <20241211203951.764733-1-joshua.hahnjy@gmail.com>
 <20241211203951.764733-2-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211203951.764733-2-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 11, 2024 at 12:39:49PM -0800, Joshua Hahn wrote:
> This patch isolates the check for whether memcg accounts hugetlb.
> This condition can only be true if the memcg mount option
> memory_hugetlb_accounting is on, which includes hugetlb usage
> in memory.current.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

