Return-Path: <cgroups+bounces-5456-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C1C9BF525
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 19:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA6A285BE6
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B6F208202;
	Wed,  6 Nov 2024 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI6oUEgb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F6620721E;
	Wed,  6 Nov 2024 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917241; cv=none; b=is6r1yEEKXrQGx6i4U4zD5u8NstwO9d2gejf4BZIbroiiSD+DIrHplezHffhp82eU6JsoUpbux98QZTTe8Rd3XAiuvMd/IHOKwnT927JtlH6jQw0rHay70+N0j7Qyny+H00UxTMEXfc16VD29x6dR7L2FkBE4jmwm8yzl0Gfv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917241; c=relaxed/simple;
	bh=8G4O4dEtP6Bo3rEClOZ0cMEjXqTB7M09ZeIdHwMKGJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3YAXwcdPrnO+Htqo/l+Eo5B/pzM66fKrP7aCY4QDCVAfQs5hah2/n6PnG4dFQeYH3BY6dc1Vp6n5o6S7Rx0L5M5QKXZ9J2S56zOEJDMIk8rPMlbRDkd1HsKtWrl7N7w//PhrR4jX8RvW3QIQ3OeZN3uUWO0EmPdcWHU7R05Jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI6oUEgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0665DC4CEC6;
	Wed,  6 Nov 2024 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730917241;
	bh=8G4O4dEtP6Bo3rEClOZ0cMEjXqTB7M09ZeIdHwMKGJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CI6oUEgbzBdNEoQTZ6DNY7g81Q1DxYs3Rvu60LDGJFxcHJo0Jvmj+oyzKEE1681Zn
	 NXF0BZPTBMdRZVV3kOpU/liXrCs6kT8UllX1enH3IWMy/etzd73oOC4WGBWGdaeORX
	 AjXYScrdgIV1mMYT9g8SRt15NkxQntvkZv65EDz+qv5L+9l4kOWi+BeBq+yTAG5X4b
	 tIONYjD92Q7csM9zCTA4WTfRca2bZxCTNUw+KYRN5Bf6aKuuSFxZ+hJ/mHHuOy8W+F
	 GJwR6aVrvA7CWAlruOZW1lqgNlQmytHaRPQkyvaCX+uUW/U3KmGbUi/fm038rHdrsN
	 b9TzQn+uRjTPQ==
Date: Wed, 6 Nov 2024 08:20:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Zefan Li <lizefan.x@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
Message-ID: <ZyuzeIhTgXU5CCk0@slm.duckdns.org>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
 <ZxlRLMwkabTaOrjc@slm.duckdns.org>
 <20241024-beautiful-spaniel-of-youth-f75b61@houat>
 <Zxp-nLXOJXoSy8BN@slm.duckdns.org>
 <20241028-meaty-mega-nuthatch-3d74b1@houat>
 <20241029203834.GA636494@cmpxchg.org>
 <20241106-vivacious-eagle-of-gaiety-44a419@houat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-vivacious-eagle-of-gaiety-44a419@houat>

On Wed, Nov 06, 2024 at 11:31:49AM +0100, Maxime Ripard wrote:
...
> > How about dmem for this one, and dpu for the other one. For device
> > memory and device processing unit, respectively.
> 
> dmem sounds great to me, does everyone agree?

Sounds good to me.

Thanks.

-- 
tejun

