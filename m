Return-Path: <cgroups+bounces-815-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 167578059DE
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 17:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC15BB211DD
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD1D60BB8;
	Tue,  5 Dec 2023 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="utiDAg7x"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A4DC3
	for <cgroups@vger.kernel.org>; Tue,  5 Dec 2023 08:19:31 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b845ba9ba9so3669694b6e.3
        for <cgroups@vger.kernel.org>; Tue, 05 Dec 2023 08:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701793171; x=1702397971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cOwZEVf0hmkZ/l+HRKkvqqzx2g2Yp/f9J4vlDNBGiHU=;
        b=utiDAg7xObmhKeJNFLxhPVkKOXPkEFFaUepZycJdP1svHuaMqVIwOTY9mGfxZmYeO/
         JDAvLK6/Ujy+pTOpB6/MYctsUzMyob0eUA44LVGPYeop+prJYILQdjCE7p12GbtD0g7J
         Lqf1+ZGk3Ah0VaSp3swrBI5X7k6Jg1XrLBJzkEzIBN6cQ1FseClHN/xfkXeORasR0gT/
         MyUdCCmf7N2AsACYRZ9VXtB4SSQzUi2GR1iqcScbryTvajoLABBoeSrp6BYtMbuMdQnp
         vXlU5/FAL4gHJXShCyh35zOOX1NGtR011+9+XegHQLdnyEI00+rzXg9aTMBJANu+1kzG
         d7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793171; x=1702397971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOwZEVf0hmkZ/l+HRKkvqqzx2g2Yp/f9J4vlDNBGiHU=;
        b=Lgeck8pldY28f0R44rl3HIwQSo8WDHE+Um4MoYHKS16Vu9PWMyMr4VAZu0xhh0K2f6
         rDPhJbkyVgX4K02823Sja9hljVQ2NHjNQTYpLtL62aoZsNHxJzUWuP84jBZNnvKzoHcl
         vYNdzQ6ZpPEedfQX+hSUEZhxTTA6kCqyhbm0F4gMDDjMSWVQcsU/7Vqiy6Un1BMoVNIr
         ow1VFWei/uJFlDlVEq7bLvbtrqoCyvEm+wX1lr0e/DFMDHXNuDpwkmleYCanF0DKga7L
         +smCM1sKyfUVeaCKWAIWfR2OY0kcmZtpT7ezG0+Cn3l1Bi/v4hATupg2uqC5sz0lFayx
         i3MA==
X-Gm-Message-State: AOJu0Yzft16h1uICu2kgqkmGCLqsgLyXzSHf5iWaXARj1CqJ6dlGOSqg
	w5Qs5viwc9J9GftcPLC65xpTSmGGqD6cU4TPcXA=
X-Google-Smtp-Source: AGHT+IF0szzPb51TMNvPFceb886yewCVCDgejwmhkzQ/VpGpcexkajnRa+SXBlHruOBwpSWcysfvHA==
X-Received: by 2002:a05:6808:b0f:b0:3b8:b063:ae0f with SMTP id s15-20020a0568080b0f00b003b8b063ae0fmr6846455oij.108.1701793171128;
        Tue, 05 Dec 2023 08:19:31 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id c8-20020a05620a164800b0077d78c5b575sm5197904qko.111.2023.12.05.08.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:19:30 -0800 (PST)
Date: Tue, 5 Dec 2023 11:19:29 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <20231205161929.GA99931@cmpxchg.org>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka>
 <20231130165642.GA386439@cmpxchg.org>
 <ZWmoTa7MlD7h9FYm@tiehlicka>
 <20231201170955.GA694615@cmpxchg.org>
 <ZW3vAz9KF5wM3HgE@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW3vAz9KF5wM3HgE@tiehlicka>

On Mon, Dec 04, 2023 at 04:23:47PM +0100, Michal Hocko wrote:
> On Fri 01-12-23 12:09:55, Johannes Weiner wrote:
> > On Fri, Dec 01, 2023 at 10:33:01AM +0100, Michal Hocko wrote:
> > > On Thu 30-11-23 11:56:42, Johannes Weiner wrote:
> > > [...]
> > > > So I wouldn't say it's merely a reclaim hint. It controls a very
> > > > concrete and influential factor in VM decision making. And since the
> > > > global swappiness is long-established ABI, I don't expect its meaning
> > > > to change significantly any time soon.
> > > 
> > > As I've said I am more worried about potential future changes which
> > > would modify existing, reduce or add more corner cases which would be
> > > seen as a change of behavior from the user space POV. That means that we
> > > would have to be really explicit about the fact that the reclaim is free
> > > to override the swappiness provided by user. So essentially a best
> > > effort interface without any actual guarantees. That surely makes it
> > > harder to use. Is it still useable?
> > 
> > But it's not free to override the setting as it pleases. I wrote a
> > detailed list of the current exceptions, and why the user wouldn't
> > have strong expectations of swappiness being respected in those
> > cases. Having reasonable limitations is not the same as everything
> > being up for grabs.
> 
> Well, I was not suggesting that future changes would be intentionally
> breaking swappiness. But look at the history, we've had times when
> swappiness was ignored most of the time due to heavy page cache bias.
> Now it is really hard to assume future reclaim changes but I can easily
> imagine that IO refault cost to balance file vs. anon lrus would be in
> future reclaim improvements and extensions.

That's a possibility, but it would be an explicit *replacement* of the
swappiness setting. Since swappiness is already exposed in more than
one way (global, cgroup1), truly overriding it would need to be opt-in.

We could only remove the heavy page cache bias without a switch
because it didn't actually break user expectations. In fact it
followed them more closely, since previously with a swappiness=60 the
kernel might not swap at all even with a heavily thrashing cache.

The thing Linus keeps stressing is not that we cannot change behavior,
but that we cannot break (reasonable) existing setups. So we can make
improvements as long as we don't violate general user expectations or
generate IO patterns that are completely contradictory to the setting.

> > Again, the swappiness setting is ABI, and people would definitely
> > complain if we ignored their request in an unexpected situation and
> > regressed their workloads.
> > 
> > I'm not against documenting the exceptions and limitations. Not just
> > for proactive reclaim, but for swappiness in general. But I don't
> > think it's fair to say that there are NO rules and NO userspace
> > contract around this parameter (and I'm the one who wrote most of the
> > balancing code that implements the swappiness control).
> 
> Right, but the behavior might change considerably between different
> kernel versions and that is something to be really careful about. One
> think I would really like to avoid is to provide any guarantee that
> swappiness X and nr_to_reclaim has an exact anon/file pages reclaimed
> or this is a regression because $VER-1 behaved that way. There might be
> very ligitimate reasons to use different heuristics in the memory
> reclaim.

Yes, it shouldn't mean any more than the global swappiness means.

> Another option would be drop any heuristics when swappiness is provided
> for the memory.reclaim interface which would be much more predictable
> but it would also diverge from the normal reclaim and that is quite bad
> IMHO.

I would prefer to keep the semantics for global/reactive and proactive
reclaim the same. Making an existing tunable available in cgroup2 is
much lower risk than providing something new and different under the
same name.

