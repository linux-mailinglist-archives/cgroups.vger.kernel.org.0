Return-Path: <cgroups+bounces-6602-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EDAA3B5B8
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 10:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE87A2041
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 08:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D26F1E25E8;
	Wed, 19 Feb 2025 08:53:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F401E25E1
	for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955212; cv=none; b=mbE4knm4gSQhWVvEgaWDiHvgoVqFZuVkjZnzqPyR/apSI/sEpWMC/fS0eU+4rji/x2p133yNsQ2gFscGc+x4tWho8/OrBUYYU0727OENWXyyjK+o9RhLrCUpm2IQrAxQz8xf7iwI2VaKKfASNBGfoyH4A9dfADWRji+42x0rMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955212; c=relaxed/simple;
	bh=ga+H8C7qCWq2mdOsuWymB8O1cED71toSD/ccoaCZWcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2Ej7guRdEvpOADcYX8JI6pDcQTRQsmh3LltRVOHycoYbFQ2NnRP3RsuVD31qLGulUyTHcu7zXMJs6dTcCoYpmliC6n2+cxD69Zh3Rkuu2LYA2g5lNF+eo6n0eCwmdpe6ddtvjcfVxuExPrbDbxanZkVFr98PYv7LVOFM/+vWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lankhorst.se
Message-ID: <5d692735-de55-4ec7-9988-ae360685f7d4@lankhorst.se>
Date: Wed, 19 Feb 2025 09:53:26 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/dmem: Don't open-code
 css_for_each_descendant_pre
To: Tejun Heo <tj@kernel.org>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org
References: <20250114153912.278909-1-friedrich.vock@gmx.de>
 <20250127152754.21325-1-friedrich.vock@gmx.de>
 <7f799ba1-3776-49bd-8a53-dc409ef2afe3@lankhorst.se>
 <Z7TT_lFL6hu__NP-@slm.duckdns.org>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <Z7TT_lFL6hu__NP-@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey,

On 2025-02-18 19:39, Tejun Heo wrote:
> Hello,
> 
> On Tue, Feb 18, 2025 at 03:55:43PM +0100, Maarten Lankhorst wrote:
>> Should this fix go through the cgroup tree?
> 
> I haven't been routing any dmem patches. Might as well stick to drm tree?

Thanks, I've pushed the fix to drm-misc-fixes. It should likely enter 
v6.14-rc4, otherwise rc5. :)

Cheers,
~Maarten

