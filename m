Return-Path: <cgroups+bounces-2807-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8408C8BD5D3
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 21:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A0D1F22B72
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 19:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318F15CD6F;
	Mon,  6 May 2024 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HIkl+1ZF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AC15B99E
	for <cgroups@vger.kernel.org>; Mon,  6 May 2024 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024749; cv=none; b=Nh2xZuQMz9vejXV6kafF7aJURjPm1bgjl01aVsfLZPJRhwSPzJ1YcqUHJK3PwTb+NQk5V9p9il3H8N8ObQgA7ogF6CWtSdVIUPCDHVh3BaOqYjdEpFRKN7eF7NQ/JODPHN9EQ14hednUirB1G+SWASfADoCTHYm3K++09q7D9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024749; c=relaxed/simple;
	bh=lbijACQXQEIFD7n+SPLLEfRap5bsE4hpY11Z7y7ikRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZDoDt31/PMXvME49mF3PYacg4ZzW9Nl2VyRL8Gu1abh9JhGzpa6fl1NuWpJ4VbswOTRJeYZ1LpMwjAQOkaND37m+WooowNgdd7sAxUjeg6raG2pA8gAqn39b18EADtuIa6o5Xc8oMN8i44eAjKQ9tDHzGAvlPEdosdA8QKIPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HIkl+1ZF; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 May 2024 12:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715024746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8Yi4qyNfdzjVzdp5Kazo/gjP3lcaKnRlQW++lDgnuo=;
	b=HIkl+1ZF+1+94HNPJyXD6Uip8vqEnrraN9iTj7qlY5GdlECVSarQLnutAtdAVGKWHPlMO/
	uF+o1UVM038jWPB+LSQHPooKQC2/e+uJdVGb6rrx/hWJgJ6a2ISJ/3tw3yXY6NeEE1rKfN
	85oRK/aAIitnSwkO8kuj5KxYRvMLdrQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Ivan Babrou <ivan@cloudflare.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, 
	Waiman Long <longman@redhat.com>, tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	cgroups@vger.kernel.org, yosryahmed@google.com, netdev@vger.kernel.org, 
	linux-mm@kvack.org, kernel-team@cloudflare.com, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Daniel Dao <dqminh@cloudflare.com>, jr@cloudflare.com
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
Message-ID: <lpvlaiauysfkwgzizvpzxx4kgzsfmy75xw6m24ziq6i6iruawr@j563n3a4bzrn>
References: <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com>
 <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
 <203fdb35-f4cf-4754-9709-3c024eecade9@redhat.com>
 <b74c4e6b-82cc-4b26-b817-0b36fbfcc2bd@kernel.org>
 <b161e21f-9d66-4aac-8cc1-83ed75f14025@redhat.com>
 <42a6d218-206b-4f87-a8fa-ef42d107fb23@kernel.org>
 <4gdfgo3njmej7a42x6x6x4b6tm267xmrfwedis4mq7f4mypfc7@4egtwzrfqkhp>
 <55854a94-681e-4142-9160-98b22fa64d61@kernel.org>
 <mnakwztmiskni3k6ia5mynqfllb3dw5kicuv4wp4e4ituaezwt@2pzkuuqg6r3e>
 <CABWYdi2pTg5Yc23XAV_ZLJepF42b8L3R5syhocDVJS-Po=ZYOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABWYdi2pTg5Yc23XAV_ZLJepF42b8L3R5syhocDVJS-Po=ZYOA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, May 06, 2024 at 09:28:41AM -0700, Ivan Babrou wrote:
> On Mon, May 6, 2024 at 9:22 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
[...]
> >
> > The reason I asked about MEMCG_SOCK was that it might be causing larger
> > update trees (more cgroups) on CPUs processing the NET_RX.
> 
> We pass cgroup.memory=nosocket in the kernel cmdline:
> 
> * https://lore.kernel.org/lkml/CABWYdi0G7cyNFbndM-ELTDAR3x4Ngm0AehEp5aP0tfNkXUE+Uw@mail.gmail.com/
> 

Ah another thing we should fix for you folks. Is it possible to repro
the issue on the latest linus tree and report back? I will be busy for
next 2 weeks but will get back to this after that.

