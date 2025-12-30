Return-Path: <cgroups+bounces-12832-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB49CEAC1B
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 23:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15CDA30303BE
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 22:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47E829AAFA;
	Tue, 30 Dec 2025 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s/zWljl2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91D82882C5
	for <cgroups@vger.kernel.org>; Tue, 30 Dec 2025 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767132227; cv=none; b=KQ26K+aC5QzCgx7PDHSNfdnzvzr2M6mWMhDg2mgz3BR2Davz+XgGn4jN77ixK1UL7i8q1q/hU+x7aNZS/m/djecVkAiEJ8HGeDGWU6uKoExWKg94K7VGj8wlQiTkKcOOL+hPLQKcUOpY+Xe8F46AmqtcJd0Sosst3bDnOA2b4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767132227; c=relaxed/simple;
	bh=YZ8HSwXURoyKdtord6xQyU9G8lZDO6cM9ShKqBtjkJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m1vEAgFXSeB3ceqUygwVGjyMIyg/Kiemf2z7JVnY/rq6D5u9pLHvh8B7AS7xG+rhj4j7uDY1Ewf69JoIVuCZxdFmA7VVqAtS/oi8+/9y2gn4oLBznyUOzLWzcnUcZLNm4n4/kq1xRAev/fgkpJn5Dd2H5hDEh3tBY0veLKKGucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s/zWljl2; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767132209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYw6PYyW0VlKW2REqOCLoq1sRa2/WhNEmjyXvfT6fN4=;
	b=s/zWljl2wXMXniaZyBwbMB8GBHWkU4sfoAwrP2HJEFJ+U1LakGQRmyb9UXbaY9TJNK7tXs
	ZVx3Qk8+pTdn2Mlz54fZkPsJPv1nTqxBZ0Vz1MKS1a0weNxoNBNVd/TzDEDO6EXaBw0tUa
	8y3vGtXc5oO/g6DHH1lUPmSH2VC6DJs=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@meta.com>,  Shakeel Butt <shakeel.butt@linux.dev>,  Zi
 Yan <ziy@nvidia.com>,  Qi Zheng <qi.zheng@linux.dev>,  hannes@cmpxchg.org,
  hughd@google.com,  mhocko@suse.com,  muchun.song@linux.dev,
  david@kernel.org,  lorenzo.stoakes@oracle.com,  harry.yoo@oracle.com,
  imran.f.khan@oracle.com,  kamalesh.babulal@oracle.com,
  axelrasmussen@google.com,  yuanchu@google.com,  weixugc@google.com,
  chenridong@huaweicloud.com,  mkoutny@suse.com,
  akpm@linux-foundation.org,  hamzamahfooz@linux.microsoft.com,
  apais@linux.microsoft.com,  lance.yang@linux.dev,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  cgroups@vger.kernel.org,  Qi Zheng
 <zhengqi.arch@bytedance.com>,  Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
In-Reply-To: <aVQ7RwxRaXC5kAG2@casper.infradead.org> (Matthew Wilcox's message
	of "Tue, 30 Dec 2025 20:51:19 +0000")
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
	<7ia4ldikrbsj.fsf@castle.c.googlers.com>
	<1fe35038-abe1-4103-b5de-81e2b422bd21@linux.dev>
	<87tsx861o5.fsf@linux.dev>
	<c3ee4091-b50c-449e-bc93-9b7893094082@linux.dev>
	<krpcb6uc5yu75eje7ypq46oamkobmd5maqfbn266vbroyltika@td6kecoz4lzu>
	<03C3C4D4-DC37-4A2F-AFFA-AACC32BAEBEF@nvidia.com>
	<slvvzxjhawqb5kkgfe2tll3owxjwtq2qkwd7m3lmpdslss73lo@hkewnkbik3qr>
	<59098b4f-c3bf-4b6c-80fb-604e6e1c755e@meta.com>
	<aVQ7RwxRaXC5kAG2@casper.infradead.org>
Date: Tue, 30 Dec 2025 22:03:19 +0000
Message-ID: <7ia4tsx7ocew.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Dec 30, 2025 at 02:18:51PM -0500, Chris Mason wrote:
>> >>>> I just think you should do a preliminary review of the AI =E2=80=8B=
=E2=80=8Breview results
>> >>>> instead of sending them out directly. Otherwise, if everyone does t=
his,
>> >>>> the community will be full of bots.
>>=20
>> I do think it's awkward to dump the whole review output for the patch
>> series in a single message.  It looks like there's a sudden jump to
>> XML?
>> It's better to reply to the individual patches with the comments
>> inline, which I think is where Roman is trying to go long term.
>
> I don't know what Roman's trying to do long-term, but his email
> that started this thread was so badly written that it was offensive.
> Had it been sent to me, I would have responded in the style of Arkell
> v Pressdram.

It felt awkward to send a bunch of emails from myself, all beginning
with the "I ran the ai review and here is the output" header.
Once we have a bot, obviously it's better to answer individual emails,
as the bpf subsystem does.

