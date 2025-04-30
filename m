Return-Path: <cgroups+bounces-7941-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8A3AA3FED
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 02:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A78928349
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 00:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCD3946C;
	Wed, 30 Apr 2025 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LcLTnVww"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8259B2DC76F
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974735; cv=none; b=U/bV/NaaPz6C9FcgKU832AionwpUSd+F4CWspLqNMBF4bT9X+8Sl+iFJBV1AxBGBjBb8zFpp7YP1S7g0OJduGlI0j3JA2Vo3L87WRVec5qNM43I3SkCcfNIwT7mrtmc0qXGJHRi3uPEIimSc90EI9an0oh1N9h2Xj30U8l1P+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974735; c=relaxed/simple;
	bh=XYE+lheTdejl+h+X68SEDhsnG9Y41Au8JIlwwtV516A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9R7RCCSejfRtwRto5aX4xBqGdTfieG2sLBpxWLOyxpoGfdoZlLHHJeIy6gB4Q/MZPdV8utABGaU7aMhp1z76L4aSu9ycdUKIfLoci4UKClc1Z2x3uttIp/CfR8rxg5Wr+KSetG5EoopizV9TGWdrS9Niwzu0pDWJMb6i2Omggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LcLTnVww; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 30 Apr 2025 00:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745974721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aYN2EqMpbenGtMK43lQY6ujzZxaQdPs5BavHhf79/8=;
	b=LcLTnVwwI5WKnGjxtzPMeol2A5h1yzHoM4CXh2wDLTDg0+ZTWtexpPF3bISsdzTEpnWV3D
	siXDCZEOTKaJmCciNzhhDY20DKdEkJmpElS9vckNnggO3NtmmnMS/1dbW5WBZXLh0yHDsK
	tBzYtbH2vcgHFmyLoaAXwXuJrtRf1HU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 09/12] sched: psi: bpf hook to handle psi events
Message-ID: <aBF1sPtO_UbE1fYo@google.com>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <20250428033617.3797686-10-roman.gushchin@linux.dev>
 <CAJuCfpEdyZWac7diTUYV7JjkpAPDuy9hwT5sfE2AC2zDVPA9ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEdyZWac7diTUYV7JjkpAPDuy9hwT5sfE2AC2zDVPA9ZA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 29, 2025 at 05:28:59PM -0700, Suren Baghdasaryan wrote:
> On Sun, Apr 27, 2025 at 8:37 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > Introduce a bpf hook to handle psi events. The primary intended
> > purpose of this hook is to declare OOM events based on the reaching
> > a certain memory pressure level, similar to what systemd-oomd and oomd
> > are doing in userspace.
> 
> It's a bit awkward that this requires additional userspace action to
> create PSI triggers. I have almost no experience with BPF, so this
> might be a stupid question, but maybe we could provide a bpf kfunc for
> the BPF handler to register its PSI trigger(s) upon handler
> registration?

It looks like it's doable using struct_ops path: the .init callback
can create psi triggers and "attach" them to the loaded bpf program.
But I need to figure out the details.

Good point, thank you!

