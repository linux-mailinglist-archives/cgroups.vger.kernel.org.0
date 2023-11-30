Return-Path: <cgroups+bounces-719-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 639AF7FFBC9
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 20:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C98A2827C5
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 19:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAF852F98;
	Thu, 30 Nov 2023 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="YkAKUESV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A6110D9
	for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 11:49:15 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7c55a04cd9eso261841241.0
        for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 11:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701373754; x=1701978554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBPZtr1NEPnHIJYCcwUX8aLQYfzJui4bNFBqHRT6Zjk=;
        b=YkAKUESVkNc26kr7QdIdvPAKnFNJ3SPyiPDRiZk4hgr51op7mzDTwvWGo5UAveOw6R
         uIu7rfpO0I3bh59FHpl5ljTo5uD5I0jbzjAbXgw/KmB9zbQVh1EPEWYeigUgslRyeBko
         RTZTwTqQr6CIYVE+QmUCGIqmC1TZbokWYQ58hNThoD2iGGzO6ZSPAJxAyumQrjOuji5+
         xwCjSfvaEk6nZHge31c5mipMDGq3ae31c0vniF4DSRID/6A66EiczWs0nX8GiKPiAN6R
         i0NyDf6eu8rJClXdntnijP+478T7YK2ICxSDuZAPKkCWAfxsNmGpXZuUrbUWCwfKL1EA
         pUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373754; x=1701978554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBPZtr1NEPnHIJYCcwUX8aLQYfzJui4bNFBqHRT6Zjk=;
        b=cx/ahKFvmKUZDlQcb1/RB6t4E6aoZbsgG0SFZEoTFBHZxirMSru1fpGXZRwQKtzkq9
         sdZtb8RyelvZM9iowOKAzt3qC0IjXREVnO3AF25mR2T9lnagMn8rGvm8hXb3JzZKK8mQ
         f40ZSIYZ/W4FmBEvx6cg97nskNAszqNRuHppqUaODDZPZUyNra6yrVk1ci3qURkUNE11
         00J3JtP7j1abPP8VdKGolAqoFdXLcfcnZB9DUF/sVd4CL3/QzfGKXWLWpF/sAt1ni2/v
         3pmIjwEFqhXk/gKdK/pl4+7yOB2Xlgb4zopKPQYfZtoU+2mCVyJ7MGd3cG7YgWwnqMS3
         Fj5g==
X-Gm-Message-State: AOJu0Yz+FERkwo76we6NgUpuBT8D1+W1Bklj2g6Eqxzi5az9Qpvhq8PH
	ISEoqP91OYM38MEWAWoTQT3Ubg==
X-Google-Smtp-Source: AGHT+IFRrBf/434jvWkBCn1mtymuLO7b9BdcyFp+fYScokRpyqxmVUVa9zUpxgkzX5uz+AKWhiW9XQ==
X-Received: by 2002:a67:f10e:0:b0:464:56ed:bfc4 with SMTP id n14-20020a67f10e000000b0046456edbfc4mr3649700vsk.31.1701373754497;
        Thu, 30 Nov 2023 11:49:14 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id k8-20020a0cf588000000b0067a57125f21sm783757qvm.52.2023.11.30.11.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:49:13 -0800 (PST)
Date: Thu, 30 Nov 2023 14:49:12 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20231130194912.GB543908@cmpxchg.org>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <20231130184424.7sbez2ukaylerhy6@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130184424.7sbez2ukaylerhy6@google.com>

On Thu, Nov 30, 2023 at 06:44:24PM +0000, Shakeel Butt wrote:
> On Thu, Nov 30, 2023 at 07:36:53AM -0800, Dan Schatzberg wrote:
> > (Sorry for the resend - forgot to cc the mailing lists)
> > 
> > This patch proposes augmenting the memory.reclaim interface with a
> > swappiness=<val> argument that overrides the swappiness value for that instance
> > of proactive reclaim.
> > 
> > Userspace proactive reclaimers use the memory.reclaim interface to trigger
> > reclaim. The memory.reclaim interface does not allow for any way to effect the
> > balance of file vs anon during proactive reclaim. The only approach is to adjust
> > the vm.swappiness setting. However, there are a few reasons we look to control
> > the balance of file vs anon during proactive reclaim, separately from reactive
> > reclaim:
> > 
> > * Swapout should be limited to manage SSD write endurance. In near-OOM
> 
> Is this about swapout to SSD only?
> 
> >   situations we are fine with lots of swap-out to avoid OOMs. As these are
> >   typically rare events, they have relatively little impact on write endurance.
> >   However, proactive reclaim runs continuously and so its impact on SSD write
> >   endurance is more significant. Therefore it is desireable to control swap-out
> >   for proactive reclaim separately from reactive reclaim
> 
> This is understandable but swapout to zswap should be fine, right?
> (Sorry I am not following the discussion on zswap patches from Nhat. Is
> the answer there?)

Memory compression alone would be fine, yes.

However, we don't use zswap in all cgroups. Lower priority things are
forced directly to disk. Some workloads compress poorly and also go
directly to disk for better memory efficiency. On such cgroups, it's
important for proactive reclaim to manage swap rates to avoid burning
out the flash.

Note that zswap also does SSD writes during writeback. I know this
doesn't apply to Google because of the ghost files, but we have SSD
swapfiles behind zswap. And this part will become more relevant with
Nhat's enhanced writeback patches.

