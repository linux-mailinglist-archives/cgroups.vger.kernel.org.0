Return-Path: <cgroups+bounces-708-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932637FFA00
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 19:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83710B20E84
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 18:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C985954FA6;
	Thu, 30 Nov 2023 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PrQa1CG/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943F1194
	for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 10:49:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c941936f7fso19376067b3.0
        for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 10:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701370190; x=1701974990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SzgB02v3pm2Y/9qEgT9NgIXu3bggWU3e+JewN/6J2M=;
        b=PrQa1CG/o3MZMOToKVbE6k98VF93pYFTlizp3c20C8pA/gCUy8gYqzxOkN+uc8c9SJ
         ViS/PTYi16v//k6HxnQOhEvtqSOf8YLbCN5ePK4Qzz4UuGs7uSib0nX9pYjEIxB5byS0
         EwlK/NlyM6lgzxvwrJhbTAG4A8iSZeYbNACbOz/zlqOxeQUQKJPgquSD1HuKhdRUeCpz
         4KqUvmsrie0Z4idjQCUTvG6vGCAAXE86vmt65fvCjoN7Wrydd7zNtOBshWkj3WKWuuSh
         tpovmuQVovVDV6zalqfEpSL/tbwPkBLcq2MSnDdh/vRw2Aivv4Ww5qOJUPcA8UVsjcJa
         Le8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701370190; x=1701974990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SzgB02v3pm2Y/9qEgT9NgIXu3bggWU3e+JewN/6J2M=;
        b=puFLk41attQc4zmVlE/CCu4RhU/yChnWT6A0cJC2bzJZQXNV5gA59koQL/DmrTR7jr
         1ErDJhf7y2d6pD1FontGBiMkZphvu9zF85py+RcrThtSN1gUAPkfwYg4bpWY43Ld+NgS
         HCExFG0Xwjuk+a9wuY3TgAxSGDWxj+bP375faYrrPucTrtxYXwfWvYdI3dwVeGf0Na5Z
         BNv5QWKHV986Fz47odaio8OmMPBCeVugcs+TW8pB21ejWa78Z3uzkjXw7x1AFzGQD0q6
         CkPLRoI0QUvyob8paYJCN4z1VGoSLgmxwjKOXu5KLCJW9wDkJDZM/SCsGAnQLeqmjheD
         N2Yw==
X-Gm-Message-State: AOJu0YyoDNwdyIxSi01/8oP3XNVY2LOsACBSVOUHeIGuEJGtOKfOxEuQ
	hVTOe5TYOzPKoNbTsOjnV5F3Rym5yEEOtQ==
X-Google-Smtp-Source: AGHT+IFua5sJxKKwzjF614J8ZWN1/fmR30z+ohOLNRCyqzdzcqilwqXd9hF/oOB4O6XstIxY1N+wNq1MagdZjQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:a4ea:0:b0:db5:378f:1824 with SMTP id
 g97-20020a25a4ea000000b00db5378f1824mr135734ybi.1.1701370189834; Thu, 30 Nov
 2023 10:49:49 -0800 (PST)
Date: Thu, 30 Nov 2023 18:49:47 +0000
In-Reply-To: <20231130165642.GA386439@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka> <20231130165642.GA386439@cmpxchg.org>
Message-ID: <20231130184947.ina5qjymijrphibq@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
From: Shakeel Butt <shakeelb@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, 
	Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Peter Xu <peterx@redhat.com>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Yue Zhao <findns94@gmail.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 30, 2023 at 11:56:42AM -0500, Johannes Weiner wrote:
> On Thu, Nov 30, 2023 at 04:57:41PM +0100, Michal Hocko wrote:
> > On Thu 30-11-23 07:36:53, Dan Schatzberg wrote:
> > [...]
> > > In contrast, I argue in favor of a swappiness setting not as a way to implement
> > > custom reclaim algorithms but rather to bias the balance of anon vs file due to
> > > differences of proactive vs reactive reclaim. In this context, swappiness is the
> > > existing interface for controlling this balance and this patch simply allows for
> > > it to be configured differently for proactive vs reactive reclaim.
> > 
> > I do agree that swappiness is a better interface than explicit anon/file
> > but the problem with swappiness is that it is more of a hint for the reclaim
> > rather than a real control. Just look at get_scan_count and its history.
> > Not only its range has been extended also the extent when it is actually
> > used has been changing all the time and I think it is not a stretch to
> > assume that trend to continue.
> 
> Right, we did tweak the edge behavior of e.g. swappiness=0. And we
> extended the range to express "anon is cheaper than file", which
> wasn't possible before, to support the compressed memory case.
> 
> However, its meaning and impact has been remarkably stable over the
> years: it allows userspace to specify the relative cost of paging IO
> between file and anon pages. This comment is from 2.6.28:
> 
>         /*
>          * With swappiness at 100, anonymous and file have the same priority.
>          * This scanning priority is essentially the inverse of IO cost.
>          */
>         anon_prio = sc->swappiness;
>         file_prio = 200 - sc->swappiness;
> 
> And this is it today:
> 
> 	/*
> 	 * Calculate the pressure balance between anon and file pages.
> 	 *
> 	 * The amount of pressure we put on each LRU is inversely
> 	 * proportional to the cost of reclaiming each list, as
> 	 * determined by the share of pages that are refaulting, times
> 	 * the relative IO cost of bringing back a swapped out
> 	 * anonymous page vs reloading a filesystem page (swappiness).
> 	 *
> 	 * Although we limit that influence to ensure no list gets
> 	 * left behind completely: at least a third of the pressure is
> 	 * applied, before swappiness.
> 	 *
> 	 * With swappiness at 100, anon and file have equal IO cost.
> 	 */
> 	total_cost = sc->anon_cost + sc->file_cost;
> 	anon_cost = total_cost + sc->anon_cost;
> 	file_cost = total_cost + sc->file_cost;
> 	total_cost = anon_cost + file_cost;
> 
> 	ap = swappiness * (total_cost + 1);
> 	ap /= anon_cost + 1;
> 
> 	fp = (200 - swappiness) * (total_cost + 1);
> 	fp /= file_cost + 1;
> 
> So swappiness still means the same it did 15 years ago. We haven't
> changed the default swappiness setting, and we haven't broken any
> existing swappiness configurations through VM changes in that time.
> 
> There are a few scenarios where swappiness doesn't apply:
> 
> - No swap. Oh well, that seems reasonable.
> 
> - Priority=0. This applies to near-OOM situations where the MM system
>   tries to save itself. This isn't a range in which proactive
>   reclaimers (should) operate.
> 
> - sc->file_is_tiny. This doesn't apply to cgroup reclaim and thus
>   proactive reclaim.
> 
> - sc->cache_trim_mode. This implements clean cache dropbehind, and
>   applies in the presence of large, non-refaulting inactive cache. The
>   assumption there is that this data is reclaimable without involving
>   IO to evict, and without the expectation of refault IO in the
>   future. Without IO involvement, the relative IO cost isn't a
>   factor. This will back off when refaults are observed, and the IO
>   cost setting is then taken into account again as expected.
> 
>   If you consider swappiness to mean "reclaim what I ask you to", then
>   this would override that, yes. But in the definition of relative IO
>   cost, this decision making is permissible.
> 
>   Note that this applies to the global swappiness setting as well, and
>   nobody has complained about it.
> 
> So I wouldn't say it's merely a reclaim hint. It controls a very
> concrete and influential factor in VM decision making. And since the
> global swappiness is long-established ABI, I don't expect its meaning
> to change significantly any time soon.

Are you saying the edge case behavior of global swappiness and the user
provided swappiness through memory.reclaim should remain same?

