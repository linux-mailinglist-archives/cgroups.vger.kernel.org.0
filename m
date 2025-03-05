Return-Path: <cgroups+bounces-6844-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB3A50263
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 15:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9280164F67
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89BD24C69D;
	Wed,  5 Mar 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="QNyf5eB2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55561DAC92
	for <cgroups@vger.kernel.org>; Wed,  5 Mar 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185507; cv=none; b=JizhtYkG9r75uAZgtDJm4PS7XpaNE0/+zDKG9jZHiDjyktOfE1+NxehsOc5iDjOEB7NNsAeAe5JrEUaFBNZSHtflG4n+Yn0/n31b1DMHKT9eTPxFCcI/kIxG7w8uqJsYHWkN0pz9guhlGRhCbr5Q7SORFXGNBIUX3GXAKvg5izk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185507; c=relaxed/simple;
	bh=BqeLWYpmzx08akl6bVj7sB5B/GwdFFEes1rYrt+d1vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujW8LvtbyOMqE9FgHK/oj6UkLH/nP5JAkBKg9kSJokJ/akcgAlGp2JvrBl32Jzjz32bXZphk6wZAaCX+k/XICbb+YQX07/7Rtz+CrQgMVlt6F6xAV+ek+mQFqiUmNmQXu1Y+m5JfR3YkgHzayhIIKpPfFPMXMWaNpHxBX1Iag1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=fail smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=QNyf5eB2; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=andrew.cmu.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e892e0eb74so52590496d6.3
        for <cgroups@vger.kernel.org>; Wed, 05 Mar 2025 06:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1741185503; x=1741790303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka/zF6Ds/g/dxAZATcvUkbSWy5jstJ9gLeo9m4izlug=;
        b=QNyf5eB2mqnQQeMpgkW87arbJgUtBEc7JWfQd6ZrCE1OKOEnIsCxlYQe5kgl7a5ilu
         XDmJ1mTraa+K0plwSwHUIuj+aLWBotfgSiLcMfT1OtNIg+vZRxN19amUAsXCKZRj2Hbv
         g7uFMr7UrUrnuOmVC2qTouuHc5PYMNisNyIBFXI/DgNRK6LJ7kfjug1uFy0krYnG7kuG
         ElsX6MGo+aRMMuKUThCRIu1ur6FZpJp0Sa6yAtb+TQuxGY2zLW24kEYIdZQzwX7ITKYk
         2rYOV0Ftx4EoLDzgaMDJ13w55D6mv4CVdZQva18GNi/F52M46Ia95g9QrCEoQmxiR82B
         Bqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185503; x=1741790303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka/zF6Ds/g/dxAZATcvUkbSWy5jstJ9gLeo9m4izlug=;
        b=jqG2OW+TSUClHIbaKOuoDDV37DcFbmVXs6Ehrdmokmww5nZpgQMfDUjGeqpkWNzjfA
         /UlThmcZSnGA2qtzpBVym2EiTckKbe+545x1PUg35Hft8PpimsIrRBkwNlnHDyd9rITg
         JdFm686WtAVG/dTKa0moGtsAuPdsoRS6UoHcui5YlcUIjj09QWSIBo4/uUDaIuGckuLK
         NRNc3fRJftGa9hl4rOeQgnwWK3xaV4j/HMlh93EbehXX5iUfkn0ijSfO5yq8XMx0J/cB
         RLYTnktm/CU0CruzAViagmniDjLagi9uHBNcff9jQQMUhnFT/X3P1+XI3T/ph1nf63C1
         5a3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiaZKOAzJnPflikv1pJHXCtzbbdkEZYJ40B/ROfTuvL1ZpehqdG4wrZUN/VYikgdCbgaZRlMhP@vger.kernel.org
X-Gm-Message-State: AOJu0YzDrjVRHkE+mnUBTQ2fGmbn8sbdoBZKD07k8xBo/n2/vBYjZ5lT
	zH/Ygkgqc1qe3TXngwCID60DhUtRVdyfYqptZGnubDafP96PRyKgH4ARFTMtEg==
X-Gm-Gg: ASbGncvUnOSf8fP1cS8/SxMNGBeGViVFP5D7SSfXBu6GIiocU+8LJ6YPA3Z1RZkBkNv
	uzcj1YQvUI0uDeBKdtdTDpChPywy6EoKMF6vvTtYDOTPjngAOisocIELKuQ2vygX9Qy/3o1DeH5
	992G0CBIQr+7qesrxjFtQdQ0EAgNsSqGQY/HUx034p/72UCu6ahxckNIKuwB2CTnw+exnCNMdin
	cD2cJC1X+uPWlW3o4rIHjJ14agEg/mGxw8Tvmb+Lr/BqZu/w3etgyQBDP1ttQeKkqcpfPoxj8XG
	gT02CqEWGpdXnIRwKdPM/ZaOCkCUSa9h+87oY8Dot2Diutgz+Umi4QTIlrxE6MmDNn0Wn6nVGnf
	jTKboY6osW33f97ZFccKuiSmBOg==
X-Google-Smtp-Source: AGHT+IHgmaMykJuMYvv7QD/ziX2omMhk+AntnG0Px6ZBZpdvG36UzbAoKiAqQ2mp1n2eBu3/c1Y5Xw==
X-Received: by 2002:a05:6214:2241:b0:6e6:602f:ef68 with SMTP id 6a1803df08f44-6e8e6d1065cmr44842656d6.10.1741185503461;
        Wed, 05 Mar 2025 06:38:23 -0800 (PST)
Received: from localhost.localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976346fcsm79902296d6.14.2025.03.05.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:38:23 -0800 (PST)
Date: Wed, 5 Mar 2025 14:38:14 +0000
From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Tim Chen <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
	Michael Wang <yun.wang@linux.alibaba.com>,
	David Rientjes <rientjes@google.com>,
	Raghavendra K T <raghavendra.kt@amd.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] sched/numa: Introduce per cgroup numa balance
 control
Message-ID: <Z8hh1urLnpmMxHqW@localhost.localhost>
References: <cover.1740483690.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740483690.git.yu.c.chen@intel.com>

On Tue, Feb 25, 2025 at 09:59:33PM +0800, Chen Yu wrote:
> This per-cgroup NUMA balancing control was once proposed in
> 2019 by Yun Wang[1]. Then, in 2024, Kaiyang Zhao mentioned
> that he was working with Meta on per-cgroup NUMA control[2]
> during a discussion with David Rientjes.
> 
> I could not find further discussion regarding per-cgroup NUMA
> balancing from that point on. This set of RFC patches is a
> rough and compile-passed version, and may have unhandled cases
> (for example, THP). It has not been thoroughly tested and is
> intended to initiate or resume the discussion on the topic of
> per-cgroup NUMA load balancing.

Hello Chen,

It's nice to see people interested in this. I posted a set of RFC patches
later[1] that focuses on the fairness issue in memory tiering. It mostly
concerns the demotion side of things, and the promotion / NUMA balancing
side of things was left out of the patch set.

I don't work for Meta now, but my understanding is that they'll attempt
to push through a solution for per-cgroup control of memory tiering that
is in the same vein as my RFC patches, and it may include controls for
per-group NUMA balancing in the context of tiered memory.

Best,
Kaiyang

[1] https://lore.kernel.org/linux-mm/20240920221202.1734227-1-kaiyang2@cs.cmu.edu/

