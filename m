Return-Path: <cgroups+bounces-13840-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCddF5t+i2kzUwAAu9opvQ
	(envelope-from <cgroups+bounces-13840-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 19:53:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D57511E703
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 19:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C66863018721
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 18:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ACE38B98E;
	Tue, 10 Feb 2026 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="ZPYSjFSz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8E38A9C8
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749581; cv=none; b=mCJNXjQjxdeF8IWbOarLZuN9AO6Avr3vXw/tNMws5eAjbLet6aNP70wflhmS6z7qnmYwAZmvVpTV6AgBtMgamDLkHkEqf9nmVEbTHiJ52aacQTuQ+2/AYGIXVrzNn6Sq/MEJuLBz6tzulQdxYNAxk4AmgSGPqV56P01p+u1ikNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749581; c=relaxed/simple;
	bh=2M+aBL+xwIjke2RBYrRF+nVdMsjWO5VVoMXLUs63K5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzE74qYV4Yp9PSVJdDSVn5EZsvxfPgx3HS9tHZyvDSRuI3KUJnmh5aRtSDPXyoZHQNPTkFEeX6fIE0MsGhQiqfkZLrz2ozlBsXNqVA74yJC3Mao4340eIgFi/XKsexZKZ8K/L3sykKguODdwCKJ3/wORW+jHRCLtKdAaEvUFDGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=ZPYSjFSz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c531473fdcso622693585a.3
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 10:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1770749578; x=1771354378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dYxAK4MfxkNTvDSky4rly7XqGqYb657cJCOkNsVbPkc=;
        b=ZPYSjFSzo0LI5+2mg7yQ1l3Y0w+fbxoBOsYscmkcIQw4Ip6+OuFlOc1HCTEKS4euqK
         uZGpCAamX7ThxS63/SpJlHXvfsb5oxlNIS4URcwdog+ldFOMjrbCTedZZx8JfnopPmQ2
         cwhIH5mYhKrpgnXROdB1jr/JP7FiaNjaRQ7J+VxbRpuQO/gb0K0P1IHDnfKulFKEExFF
         Uw6HpWhiAsu5eqkrz5wir8dre3siFDyyK1ZrehfbYqy9pMaziqrGfLgVpRHcTelUaac1
         ZImXTbFQVR+chNfoG326fkznH41ggq6K6WnXOOCsDvGO+Ns4nan0rRlZFAVbqbP5e93R
         qgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770749578; x=1771354378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYxAK4MfxkNTvDSky4rly7XqGqYb657cJCOkNsVbPkc=;
        b=EvnLxG76WXhSS/MPesq3ZuOHB+FCLIZNWAYa0pZIwtiod6fz5/TL4wUK11Qn5eXnK6
         erYywwgVUFkeUs0qZxLM2cs5C5tNR1JYYwzOBapbnh+9TcxjD3mnp3VPz6Yf06DFCLqH
         SXu6jdCiPS7JXJdSFNPAoOlNgT21rXB4ciW0uDEQ0e1CRsAOrW7zxpxzqOAeX3L1Y00D
         CUBsBKFonUzUPd6Ne3rpedpBImjqUCPafJ0MVK2HnTj0xJHYnjeSYKo5z2N/JmSDb3xJ
         KdDGhNrJ2XQ5tjVkI3P8h5aIL8dIca4DzrrywF1/14y7tWb2RMBNUsJr4e4Y0W6/8t7i
         oZdg==
X-Forwarded-Encrypted: i=1; AJvYcCXeaGtv2ZLbl3GPDO2VbVA0n9Y3HesjkP+liKVhxvWKpy+sl92JI7QtWNrkNpsaNzeMXFR0E208@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt56aNMgwZh4NsojTRjjakeXfZcXzyGaS+TFJqdoQk8rSp83jb
	8+XuqAFpcYlwCD6gCHOx/BkLi0DrGGqXCJhbic1dhZ2RCI1nF9Iu6tzTfMB3mgFbEEU=
X-Gm-Gg: AZuq6aJl8uxPt9xcGxXYsL7PxtyBL8aT2fdSUQnefp8zqvQOrdZ8Em0S7MaqFSYHNY6
	mNHva+SUTvnVwueT9pd3v2OHlLuYBhZdO9ILvZ6xNYEge9ZVqyDJWv62mOxfONmWeMjXZIufFNW
	4KcPK5YvroLX4NN4O9MKYhPoMmd/Beik8cObQ33SBj3mYTu07auoNaQSmDWjkmKZqsUrqampUJh
	56aa1azJXHOi8lXUKUxoBkjbITAe6jeRQq3EINbi6SJunnJaxWabM5627lh1vDOq72udTUbBHqz
	THZNbiUQBFy4zZJaPoBXSNgx++S0IsQs6/yw5duBXw9s7QE8klHewNSe5p7wCwgQ9I0Y9mSNIbh
	SEpMAFexKlaH0N6Rgjg/q3yps6GQ9DOYzRJb7+bx7VcnrMoM5Dou6ECgBer3ZxxgZC/tNMgTBhQ
	rFAm27SXQZqK6XhNxzv/gXE1ylOKoYZyo=
X-Received: by 2002:a05:620a:690e:b0:8b6:1877:3689 with SMTP id af79cd13be357-8cb27fc2b12mr39809385a.35.1770749577839;
        Tue, 10 Feb 2026 10:52:57 -0800 (PST)
Received: from localhost ([2603:7000:c00:100:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a16240sm1107793485a.35.2026.02.10.10.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 10:52:57 -0800 (PST)
Date: Tue, 10 Feb 2026 13:52:53 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, hughd@google.com, yosry.ahmed@linux.dev,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk,
	baohua@kernel.org, bhe@redhat.com, osalvador@suse.de,
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com,
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de,
	zhengqi.arch@bytedance.com
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
Message-ID: <aYt-havagZ8kUmov@cmpxchg.org>
References: <20260208215839.87595-2-nphamcs@gmail.com>
 <20260208222652.328284-1-nphamcs@gmail.com>
 <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13840-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,linux-foundation.org,google.com,linux.dev,kernel.org,intel.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D57511E703
X-Rspamd-Action: no action

Hello Kairui,

On Wed, Feb 11, 2026 at 01:59:34AM +0800, Kairui Song wrote:
> On Mon, Feb 9, 2026 at 7:57 AM Nhat Pham <nphamcs@gmail.com> wrote:
> >     * Reducing the size of the swap descriptor from 48 bytes to 24
> >       bytes, i.e another 50% reduction in memory overhead from v2.
> 
> Honestly if you keep reducing that you might just end up
> reimplementing the swap table format :)

Yeah, it turns out we need the same data points to describe and track
a swapped out page ;)

> > * Operationally, static provisioning the swapfile for zswap pose
> >   significant challenges, because the sysadmin has to prescribe how
> >   much swap is needed a priori, for each combination of
> >   (memory size x disk space x workload usage). It is even more
> >   complicated when we take into account the variance of memory
> >   compression, which changes the reclaim dynamics (and as a result,
> >   swap space size requirement). The problem is further exarcebated for
> >   users who rely on swap utilization (and exhaustion) as an OOM signal.
> 
> So I thought about it again, this one seems not to be an issue. In
> most cases, having a 1:1 virtual swap setup is enough, and very soon
> the static overhead will be really trivial. There won't even be any
> fragmentation issue either, since if the physical memory size is
> identical to swap space, then you can always find a matching part. And
> besides, dynamic growth of swap files is actually very doable and
> useful, that will make physical swap files adjustable at runtime, so
> users won't need to waste a swap type id to extend physical swap
> space.

The issue is address space separation. We don't want things inside the
compressed pool to consume disk space; nor do we want entries that
live on disk to take usable space away from the compressed pool.

The regression reports are fair, thanks for highlighting those. And
whether to make this optional is also a fair discussion.

But some of the numbers comparisons really strike me as apples to
oranges comparisons. It seems to miss the core issue this series is
trying to address.

> > * Another motivation is to simplify swapoff, which is both complicated
> >   and expensive in the current design, precisely because we are storing
> >   an encoding of the backend positional information in the page table,
> >   and thus requires a full page table walk to remove these references.
> 
> The swapoff here is not really a clean swapoff, minor faults will
> still be triggered afterwards, and metadata is not released. So this
> new swapoff cannot really guarantee the same performance as the old
> swapoff.

That seems very academic to me. The goal is to relinquish disk space,
and these patches make that a lot faster.

Let's put it the other way round: if today we had a fast swapoff read
sequence with lazy minor faults to resolve page tables, would we
accept patches that implement the expensive try_to_unuse() scans and
make it mandatory? Considering the worst-case runtime it can cause?

I don't think so. We have this scan because the page table references
are pointing to disk slots, and this is the only way to free them.

> And on the other hand we can already just read everything
> into the swap cache then ignore the page table walk with the older
> design too, that's just not a clean swapoff.

How can you relinquish the disk slot as long as the swp_entry_t is in
circulation?

