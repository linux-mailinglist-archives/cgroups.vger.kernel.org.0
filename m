Return-Path: <cgroups+bounces-10651-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4A8BCFACC
	for <lists+cgroups@lfdr.de>; Sat, 11 Oct 2025 20:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736EE189A8BA
	for <lists+cgroups@lfdr.de>; Sat, 11 Oct 2025 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8E827F747;
	Sat, 11 Oct 2025 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AfBnhG7x"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054FC1DA3D;
	Sat, 11 Oct 2025 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760207302; cv=none; b=hPPdmcMOlJHwqLmxdialz/M2O4kkuL662qfsXqcyiHfO6ktlLRrpDdlF5o24mTTV3Fcz7rdmoC5eIAcffuuQz+WtFCUipLgvUrnpkhda6FlJnvcaaWLcCUTQldjFHTwKrVuJr56QlE5KwNixrn493oGMOTHmfStcoG1Hsj6r5hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760207302; c=relaxed/simple;
	bh=FgUWvbT3ZDva6ywfxCHqenEXxBKR7Oh/eD/SLOX+5Yk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GAN+I10WKzjTbghKLRf9P40yt6jGnttC+kwLdJzaHDJb1XBoEuLJUfLEfI3Sf1LZc/n1Kjis3kwCUP26gZtknZ5NSVWGVBjemocMRcgWt8ZC6SL3PvjQa7qHGyDsFvxkje1nxszSF+1GeXVnZwdVOxrRRtlvfrReODyCS6R2PxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AfBnhG7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8115C4CEF4;
	Sat, 11 Oct 2025 18:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760207301;
	bh=FgUWvbT3ZDva6ywfxCHqenEXxBKR7Oh/eD/SLOX+5Yk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AfBnhG7xlmLmfVUbFGyjQ78bq1XHYdU9flYoPoaBuGBTWGnKucM2jmCncWuX7rT71
	 FlTSAz4fuLUwls7McF1/JtXOxaFcu7efZoCive7juPExhTihyq837YdT4cuC3G8aUc
	 dD5+OvKwL0z2YPpBYYro/adbqLfXaRiZQllp+pP8=
Date: Sat, 11 Oct 2025 11:28:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
 harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 0/4] reparent the THP split queue
Message-Id: <20251011112820.0bd349399187a5eb662024b9@linux-foundation.org>
In-Reply-To: <4a134193-ee55-434c-98a9-ca3052bab11b@linux.dev>
References: <cover.1759510072.git.zhengqi.arch@bytedance.com>
	<925E0247-2976-4D85-A8AA-E8C92C64CED4@nvidia.com>
	<4a134193-ee55-434c-98a9-ca3052bab11b@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Oct 2025 08:51:21 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> Hi Zi,
> 
> On 10/11/25 12:25 AM, Zi Yan wrote:
> > On 3 Oct 2025, at 12:53, Qi Zheng wrote:
> > 
> 
> [snip]
> 
> >>
> > 
> > Hi Qi,
> > 
> > I got CPU soft locks when run "echo 3 | sudo tee /proc/sys/vm/drop_caches"

Thanks for testing.

> And hi Andrew, please help drop this patch set from mm-new first.

Gone.

