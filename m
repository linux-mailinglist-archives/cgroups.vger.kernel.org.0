Return-Path: <cgroups+bounces-7519-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168D9A888E1
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 18:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139D6176E65
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B47927B4F8;
	Mon, 14 Apr 2025 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="BGqM1k8d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70001F236B
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649250; cv=none; b=M00Y5PQIYeb/AnO6E+BD9iB08qMYQgo4paJkPXJGI7MMHe1R1eSVo6wK9Vr9gto7dkYs9SQy5b/wzpHo9RcjvO15gxAkLIARRobp5sdadVoKoWVPOM6V9dED86IHboIMRUp+uy9dKcub+ZYpSAXM+vNioeMPzjRPJbDuXJerBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649250; c=relaxed/simple;
	bh=C378C9Sed227nr/gwJbV0c7C3hVPbUh88wSNKGMT/4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnE3shiURR9wFGOvqXHfJTURy9qHlE+uhsbbQgXw/6NG7gofFBy52wol4fHcbgg5I2kmWrWh+sJniOjg+QGvECKSEhwWRK3e2syCTiooeHKyaKtqakvuSAONtE7QeM/ScIG0tTVK2OxpYl61Wy1G8bwuFvSgtaOp+V/FEUDidvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=BGqM1k8d; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6eeb7589db4so53454846d6.1
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744649246; x=1745254046; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gvr1Eg7lK7Y8HhVqNwImZJnjSK1mbZPXBkM7KTJCKgE=;
        b=BGqM1k8duufmmTpB9Aay+GnUw9x/XNfdW/P8tWwDwL0kATYCCsUuF+YQ8MuWWFUXdM
         NIlc3Jsd2qBpzgZ8XHmlmoTwJTMcRl7T+bbKuGwLdf2UDKckMd4ANMhCujC8el/5mo5k
         fIBYcvY3gzrpZChPkBC1Qi11giuqovPUIyMyRTiqeWQFtLUdyslOBboWyMB4g/4uOM0t
         Rdg/THMpgSVuz1Ay47uKjFmOjL+lnvfg23Qfq0SFb+84eXOEnlkAiMC6ZDCyMS7WMifD
         JDus9nt2Af64f0OpJyElTCimbFPGAsgyxuUtJ8lMrGlmg8g/yGACMYQ34hifPsjCT5Jw
         EkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649246; x=1745254046;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvr1Eg7lK7Y8HhVqNwImZJnjSK1mbZPXBkM7KTJCKgE=;
        b=gAbVHR0AHPc/wLYUwgXUPV/hYyV3wTZY2gS+CA1TWjkDGXNqs+KAZTAewR2Zh8Qr1L
         V1+U32X0mal2EAnBUCF5Gy1KvSIdyW6TR7O6y3nlWXAVT2w+v0jp2UhqsKiCkcVp7Lvf
         pOWpOw9TNED9T3HhDNXuwXJQbeOIRbqZSLXqldRKHb4nMaL5RjkXDxlKPT5ultX4crsB
         c4KqAZNTDaIcyYFgMm8gbYf4zbQLuFUpscTD5xoHZIt0Zjk11/lACMN5VjLmvZtqJ69I
         KTJLHsceewsrX2y30k+jden44TZNOPMRwt5HLSfljYM/dZUvxmJ5QUyAthogOPnJRY3Y
         9EXg==
X-Forwarded-Encrypted: i=1; AJvYcCWQSL+DZwZ++OvkmcyxoS3m6I0xX08YFbj/XC5Fkxq4susYjWU5JMSWkqVt8LwPIZIbTUT7UYGL@vger.kernel.org
X-Gm-Message-State: AOJu0YzA47ZRf3sg231asNTziii7tD2mM1U2GSkfaY3FybpyXuKVCJOp
	vVYqo3TS4WswqytDRbOlw16U2KxgZc0KlDOP3XWe1CehUOsyDDulhwKihX4T+78=
X-Gm-Gg: ASbGnctgXBVWB6ochZr9foFYSdlHRwGSIl3BpIrFpYMpjLNhweCwYS+ekgsGbGUAfxw
	whIc+tPzXR7UOjS8MgFB7ygBhw9sRb/8CRcUpQBJGWacciLW0vzInfFr5v9oVzq1bKVk++PA4Ze
	6AuOlFfzWpEUK1EYuaWwoOD2leA/ovMQYiECvOhZBAZScX/G2mePRwtiur84jBdl0qx7YURYhQr
	jFxvGkfhpYhyR6B1hvf3OM/5emzjeaN3sfpY1X1G8soms9gQ8mzZm9idyLGuy0BLOCn4Q0PZnv9
	k8AWJNTYsScVcLHu0NWvzhnMZrNT1OBGV3lxxVc2XjKwuGPDFw==
X-Google-Smtp-Source: AGHT+IGyn19E6PStgkF0prqcjwzNPkKDdnhAlejJTPbm0jkoKGh1Or323otXTafl0CJ+s0xtuj6ZeQ==
X-Received: by 2002:ad4:5e8c:0:b0:6e8:f445:3578 with SMTP id 6a1803df08f44-6f230cc177emr218119656d6.2.1744649246264;
        Mon, 14 Apr 2025 09:47:26 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea106cesm85684596d6.103.2025.04.14.09.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:47:25 -0700 (PDT)
Date: Mon, 14 Apr 2025 12:47:21 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Waiman Long <llong@redhat.com>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
Message-ID: <20250414164721.GA741145@cmpxchg.org>
References: <20250414021249.3232315-1-longman@redhat.com>
 <20250414021249.3232315-2-longman@redhat.com>
 <kwvo4y6xjojvjf47pzv3uk545c2xewkl36ddpgwznctunoqvkx@lpqzxszmmkmj>
 <6572da04-d6d6-4f5e-9f17-b22d5a94b9fa@redhat.com>
 <uaxa3qttqmaqxsphwukrxdbfrx6px7t4iytjdksuroqiu6w7in@75o4bigysttw>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uaxa3qttqmaqxsphwukrxdbfrx6px7t4iytjdksuroqiu6w7in@75o4bigysttw>

On Mon, Apr 14, 2025 at 03:55:39PM +0200, Michal Koutný wrote:
> On Mon, Apr 14, 2025 at 09:15:57AM -0400, Waiman Long <llong@redhat.com> wrote:
> > I did see some low event in the no usage case because of the ">=" comparison
> > used in mem_cgroup_below_min().
> 
> Do you refer to A/B/E or A/B/F from the test?
> It's OK to see some events if there was non-zero usage initially.
> 
> Nevertheless, which situation this patch changes that is not handled by
> mem_cgroup_below_min() already?

It's not a functional change to the protection semantics or the
reclaim behavior.

The problem is if we go into low_reclaim and encounter an empty group,
we'll issue "low-protected group is being reclaimed" events, which is
kind of absurd (nothing will be reclaimed) and thus confusing to users
(I didn't even configure any protection!)

I suggested, instead of redefining the protection definitions for that
special case, to bypass all the checks and the scan count calculations
when we already know the group is empty and none of this applies.

https://lore.kernel.org/linux-mm/20250404181308.GA300138@cmpxchg.org/

