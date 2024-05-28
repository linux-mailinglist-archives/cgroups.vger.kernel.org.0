Return-Path: <cgroups+bounces-3033-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7F98D282A
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2024 00:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA591C240CC
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 22:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612F13E055;
	Tue, 28 May 2024 22:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVmaUyGN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156BD13DDD2;
	Tue, 28 May 2024 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936157; cv=none; b=HU2d0dUCQsYZ7Vc5pfTteYQ5dUqnWwB1P/s6eR5O1JhUm5JnpAfKwWr7uxJHBWw/lM0hf7Agy9jrHomkjE7qlpts+TwWQBTzNtrjEPymKwxLutk8ZP7eAWiyyT/yBevXlqJ01Z6XGiIX7szFO9iRWx/wSpDxPWemgwhCZaXLlig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936157; c=relaxed/simple;
	bh=D0HSFpq25DgEVf9kDADMq+qZ9etlDXDt0aOI3IoPHoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYaj0GGaeJHraB4JPy3G4R4N2fwRPRcqQBAyp91myglML/e/5JNLPJYN93tKsjJh3kFGJRBxN6Hy6G1pv5OHWsOY3B3BKvbEKgHu5xM/uOS5PNHxD08LAXwDqPPAu/Z0iwZHYf1AInbapOA6T1Ho1FzAvyn/NpWoHCoR1uxZHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVmaUyGN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f693fb0ab6so1239633b3a.1;
        Tue, 28 May 2024 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716936155; x=1717540955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzL8p3QJDmj2dei45S+A9A4OpWxd9oLv/TmmXb7owpE=;
        b=jVmaUyGNjQVLWUR7kyekxyhwyIl1Yq7cpviqEQxL+S414R0aqLSUo95zAfsjlBPEY6
         8cmMNJ3Kcasn5UMfKPfsX5xrA9IpsSFy1GLK1n2JjjhY8cgz+Yuo4XHpfcUK6rNi2t+S
         OpH72lGQmsqchNMrFzpK87HMAS1lSdhC4YYfpo3EQk/sVPRiKOEbkPlkqgEvnJV5lyKW
         JJDpfTakRDH5XyAvMQJu5IuC1zUv5iI5dtVuMKeK5tGUQ339Rxjc5hsaMcEmGMugan06
         rLI6n9SXgHThvT4S+mzKPx9a+hhMksT9ZKm8q8+jQjWNNUr4kBtcjKNrOoFkoTRptCLO
         0UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716936155; x=1717540955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzL8p3QJDmj2dei45S+A9A4OpWxd9oLv/TmmXb7owpE=;
        b=TQfwC1fXFRudFSEspZZTHMz82I/eXhMELwSJczzJLMOH+41aofaYKs1U8P7tHZ6KQ/
         eSh85vuruW2JhGWx/NC/Poiz0V4iys4I3YsJhG0XVHJoWBlZkSGdK7BRN75jhWkMWOaK
         /epP7gSMUeehFZY4S2aKuyl5Hvmo/kMLJaOUx933lB2gYGk10ZdGLexc5VSQYAafFX6F
         t5sGw6F6s9i8S2SJA2tq5ssNa6GmEdtDo3L0E4qKAfQi/v5kACiEnMnr3Wv9GheF6bpX
         lyMdN+yrHDkyhDz5sUiZGnXvExa75wFcA/kzB7fJhBhl6cNzMa4G6cG4c+2QHR4DMvek
         MCtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAHOfDNqhymYgHpNwwJJP9ihAhtDN91DJHsKRyqBp46bXM38FOU3aGb5IPgUW36VxxYr/kANBV2LF+3uAlXIkPnJPySkZ9m/TFdJBbUPY0JS+NyYe6UnpVKtXM+dU8ebIpXBoa9w==
X-Gm-Message-State: AOJu0Yw6SyAvPUNj/NLCCAwGBaijvNoHpfY9tswLlgMGPXNGDjKpyuBZ
	OLLqB0XjQ9YF0MDS0ZMjz4naqYe2+AVP7ihNGG2uNwGGPxb603Ib
X-Google-Smtp-Source: AGHT+IHTQlljV+UgbG8n2d1mkSGo70004SS7ilxYmVpopUL+CcCUVFdxkakluXc2A6KM3psEfao3zg==
X-Received: by 2002:a05:6a20:a127:b0:1a3:df1d:deba with SMTP id adf61e73a8af0-1b212d3bffdmr15708748637.31.1716936155224;
        Tue, 28 May 2024 15:42:35 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682274ba9edsm7968804a12.90.2024.05.28.15.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 15:42:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 May 2024 12:42:32 -1000
From: Tejun Heo <tj@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: Fix /proc/cgroups count for v2
Message-ID: <ZlZd2EsF7KOqPx7a@slm.duckdns.org>
References: <20240528163713.2024887-1-tjmercier@google.com>
 <ZlYzzFYd0KgUnlso@slm.duckdns.org>
 <zrvsmkowongdaqcy3yqb6abh76utimen5ejrnkczd4uq3etesl@jv3xb4uso4yk>
 <CABdmKX2vmpFS=j_FoFOadHRVVWaWUsReJYv+dJNHosk1uE_Dvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX2vmpFS=j_FoFOadHRVVWaWUsReJYv+dJNHosk1uE_Dvw@mail.gmail.com>

On Tue, May 28, 2024 at 03:38:01PM -0700, T.J. Mercier wrote:
> > > I think it would make sense to introduce something in a similar
> > > fashion. Can't think of a good name off the top of my head but add a
> > > cgroup. file which lists the controllers in the subtree along with the
> > > number of css's.
> >
> > BTW, there is the 'debug' subsys that has (almost) exactly that:
> > 'debug.csses' -- it's in v1 fashion though so it won't show hierarchical
> > sums.

Yeah, something like that but hierarchical and built into cgroup2 interface.
Would that work for your use case?

Thanks.

-- 
tejun

