Return-Path: <cgroups+bounces-3505-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0A9924CCB
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 02:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA111F2371E
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 00:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF312107;
	Wed,  3 Jul 2024 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e64O4V5h"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AAA1FAA;
	Wed,  3 Jul 2024 00:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719966699; cv=none; b=Fzo1ZCFh7DovVOQsyu3Yo5iBfMEj6L80qRtHe9wECVl9tFRFVmG7Bb+qGDJhTuOgVtgtjHRq7eDRgQw+x+2ai+flnyBoBLtej/sCqFk0iQ6svNrugHpxHafi2ul6MShv1glVbPe6LCKgppHMldyqFxr3t2ED/iCMh5g8K+rSfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719966699; c=relaxed/simple;
	bh=kaZ4gZM7STzbP93BGnqy4GZN9nFQNMc0En0mwXOqhkM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P9E6q28pi71rRYCHMGzWaRqaHzpoudpS5Zi8nASupRa7rtVzIXz4ERtkbJ5HG/4wgVyGe8iUc5c5peMmAHtQIuZFSlEEwMJ4qQ1amw5PhY5dW4f8M9/sSFxQ1oTxe2M8vGTeL+bvQSTisHlrYTolWRKfUTka8Sg6sFIpaPu0uO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e64O4V5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B08C116B1;
	Wed,  3 Jul 2024 00:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719966698;
	bh=kaZ4gZM7STzbP93BGnqy4GZN9nFQNMc0En0mwXOqhkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e64O4V5hkoECY8056JW+tufu3D4bcz45kk26yQeSJs73e3wSkg/6wyPPSDif2rVQD
	 2tYF8poTdc442XfDRuSPq8G1SYEDWixN4K3SwTFI12JQMsEMFN7z6y9NGUf1hICN7s
	 3Tnfn3p2bpxayt04dAn0wBXRkv4Qzsftzf15gDJo=
Date: Tue, 2 Jul 2024 17:31:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: Xavier <xavier_qy@163.com>, longman@redhat.com, mkoutny@suse.com,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH-cpuset v9 0/2] Add Union-Find and use it to optimize
 cpuset
Message-Id: <20240702173137.4987350c977529cc554d9632@linux-foundation.org>
In-Reply-To: <ZoRThI4lcZLxBlwc@slm.duckdns.org>
References: <ZoMXN3G72xtCLjgp@slm.duckdns.org>
	<20240702105010.253933-1-xavier_qy@163.com>
	<ZoRThI4lcZLxBlwc@slm.duckdns.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 09:22:44 -1000 Tejun Heo <tj@kernel.org> wrote:

> On Tue, Jul 02, 2024 at 06:50:08PM +0800, Xavier wrote:
> > Hi Tejun,
> > 
> > Thank you for thoroughly reviewing the code and pointing out the issues.
> > I have made the necessary changes to the code, comments, and documentation
> > based on your suggestions.
> 
> Looks fine to me. Once Waiman is okay with it, I can carry it through the
> cgroup tree. Andrew, any objections? Xavier, it'd really great if you can do
> more conversions so that it's not a single use thing.
> 

OK by me.  cpuset patches live in the cgroup tree, no?

Nit: if there is to be another spin

	/* please do this */
	/*and not this*/



