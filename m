Return-Path: <cgroups+bounces-8004-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDEEAA8DDD
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 10:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF9C16B5E0
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 08:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4CC1E47AE;
	Mon,  5 May 2025 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HVafOWoC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213421E1C1F
	for <cgroups@vger.kernel.org>; Mon,  5 May 2025 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746432539; cv=none; b=rmyz+sr1TpTMzlESuN0q7nCelNC3bkh602ceudqG0F1xTeJICdQtMRYP38l22qZSm0iGp/ftvx3A1WsNlrkS5VBIkPuuW8odgzvKJJpFUgtpPW20rbJ4EY9o0g/++fLZ7MrsN9RsmDmthWHWzLjSci38vi6i9QImoOP6cC9yaZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746432539; c=relaxed/simple;
	bh=fpiegDdPN4vJSsUvTfFDScdpNUKB1Bs1LE0KbvzE0rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqvYKUvcyJTxrTGNCCMaCAdWcM+CCzIfJoPdb0g/kxyrAQyofMpj5eM8KAzguboOeGfJu5sivy7jpAeqFLGCwZGBniZVw8HuI7O1Zhfl4QV2K9bk1mgiFrwRJiL9EAbgEEPZXMYBghalDabCTBbjQvpoy6FVnYq+N+/mR34aGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HVafOWoC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so34430315e9.3
        for <cgroups@vger.kernel.org>; Mon, 05 May 2025 01:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746432534; x=1747037334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ih3NqDpNYxVnwTqQNjr/HduzzcPs128fQGA7XiiKKbU=;
        b=HVafOWoC3/jTLo7x3AKPu38ObO0NpLhvPQlSV0JtoLhc9wxHQ+1W5I+dnDU4hkzZwV
         mKPvK74grtYJdMwaYlCHhmMgnpVou62xl1TzmRrw+BuAd2mH+cUSFVnXenRuzLo4w9OU
         c37Rt7N7RflYon88Jqmt+y2eYJ4YtlSUQpFVMTqpHpdjgiwfAMC8/62/VG7SCWs03mFO
         rMAufkA5YrHuPP41kGT7uEZN8ZcXDcSxncQj/jWMS4VYXiAJKokIIHUGp7X9YpP4tyny
         JI/ZEn7gV3l+GOLzusAGkHSxAP9vOU4/3ZeMrW5TQAqUxEZPzHGR0Oas9ym6yQw9I0ZN
         Smtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746432534; x=1747037334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih3NqDpNYxVnwTqQNjr/HduzzcPs128fQGA7XiiKKbU=;
        b=a5b+jkOzUiwiR5SmAqHFdlIMzBt01Wh7UxG6T8z1wmVvk0/1nGm/5rAQLn6n3ZkWLm
         b+D+3la90cAzdS+JYrRdjHRZG/1F6H7Oa7aJDzrzQ8qPm2zTFsUD8oq9eAYXFx2z+ON3
         danHVMDp/4tfvghMRkM0sPLWwUb0qlGM67m7GgC59T3RrxjhL2MtG8EtWnG21N0El5ZL
         JNapYRml5jkwEWarbGPmcXVAlPf2n1V1350T8dSHnNTfBvZGdflBW86tQiMShYuw4h+V
         38AQivGXlVwx3zKTifIygpNpJkZ6M88MHaxTyz7fX5YwcDUPMIBIfKOI1C/ek9tUwS6S
         YUhg==
X-Forwarded-Encrypted: i=1; AJvYcCUTCiriTOmvMBju6ex20Un9CMT6lRG6YjRPWIZMU02ZtZ9GBpOSJLwu0HAN4YoGDPQiD1fiwM5A@vger.kernel.org
X-Gm-Message-State: AOJu0YwWj1K9+V0BTN3oj59x6WwM5VdM1QMrBidm2+7t/DfC36c5L20M
	9LEC9xexdnUsF/CxLj4r8WTDW14DzW1wd5BdC8q3RgwEYmX1dlbrFtJi5KLfQz0=
X-Gm-Gg: ASbGncs1qyPhruTzEoNWV2VbIsbmaWhX0PtZcIKu29QEn5jtDVVGy0DUMd1Rs2z1enW
	pJuYK5IV+5VUWIwgQUlyrrYlT5Us9/ObJcLBvJcSuO5XvR69i2qss0imLHz9LXX6HBNq32YdkQS
	c8u2g1m1uKz+cCeBKrAarsf3stlru7oy4Lf/KZ7ymLpsRxvMzXDLhPmvpnYQ0nQ3LRTvM91IbMz
	/PY32uKpAWOGHAh109RWimMtqiU2cXssxVntUECI+HukvGrsMun6gxaAqE+Jy89HtNPCbPatEQA
	qZeq1E29SMqEMx/68uf0SbH4sLK4rM8HNOJLiCGoNV0ZEEW7upw=
X-Google-Smtp-Source: AGHT+IEurvdHsB2rKDl3Rsu/uufeIj/T+2DXVXCdsFmbDaGBcEViq6YlhktTwiTRJwVY7SSU0p4HUg==
X-Received: by 2002:a05:600c:5124:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-441c48c1d07mr44823985e9.15.1746432534171;
        Mon, 05 May 2025 01:08:54 -0700 (PDT)
Received: from localhost (109-81-80-21.rct.o2.cz. [109.81.80.21])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441b2af4546sm172441785e9.22.2025.05.05.01.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 01:08:53 -0700 (PDT)
Date: Mon, 5 May 2025 10:08:53 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 10/12] mm: introduce bpf_out_of_memory() bpf kfunc
Message-ID: <aBhyFQje85fPhIiM@tiehlicka>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <20250428033617.3797686-11-roman.gushchin@linux.dev>
 <aBC7_2Fv3NFuad4R@tiehlicka>
 <aBFFNyGjDAekx58J@google.com>
 <aBHQ69_rCqjnDaDl@tiehlicka>
 <aBI5fh28P1Qgi2zZ@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBI5fh28P1Qgi2zZ@google.com>

On Wed 30-04-25 14:53:50, Roman Gushchin wrote:
> On Wed, Apr 30, 2025 at 09:27:39AM +0200, Michal Hocko wrote:
> > On Tue 29-04-25 21:31:35, Roman Gushchin wrote:
> > > On Tue, Apr 29, 2025 at 01:46:07PM +0200, Michal Hocko wrote:
> > > > On Mon 28-04-25 03:36:15, Roman Gushchin wrote:
> > > > > Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> > > > > an out of memory events and trigger the corresponding kernel OOM
> > > > > handling mechanism.
> > > > > 
> > > > > It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> > > > > as an argument, as well as the page order.
> > > > > 
> > > > > Only one OOM can be declared and handled in the system at once,
> > > > > so if the function is called in parallel to another OOM handling,
> > > > > it bails out with -EBUSY.
> > > > 
> > > > This makes sense for the global OOM handler because concurrent handlers
> > > > are cooperative. But is this really correct for memcg ooms which could
> > > > happen for different hierarchies? Currently we do block on oom_lock in
> > > > that case to make sure one oom doesn't starve others. Do we want the
> > > > same behavior for custom OOM handlers?
> > > 
> > > It's a good point and I had similar thoughts when I was working on it.
> > > But I think it's orthogonal to the customization of the oom handling.
> > > Even for the existing oom killer it makes no sense to serialize memcg ooms
> > > in independent memcg subtrees. But I'm worried about the dmesg reporting,
> > > it can become really messy for 2+ concurrent OOMs.
> > > 
> > > Also, some memory can be shared, so one OOM can eliminate a need for another
> > > OOM, even if they look independent.
> > > 
> > > So my conclusion here is to leave things as they are until we'll get signs
> > > of real world problems with the (lack of) concurrency between ooms.
> > 
> > How do we learn about that happening though? I do not think we have any
> > counters to watch to suspect that some oom handlers cannot run.
> 
> The bpf program which declares an OOM can handle this: e.g. retry, wait
> and retry, etc. We can also try to mimick the existing behavior and wait
> on oom_lock (potentially splitting it into multiple locks to support
> concurrent ooms in various memcgs). Do you think it's preferable?

Yes, I would just provide different callbacks for global and memcg ooms
and do the blockin for the latter. It will be consistent with the in
kernel implementation (therefore less surprising behavior).

-- 
Michal Hocko
SUSE Labs

