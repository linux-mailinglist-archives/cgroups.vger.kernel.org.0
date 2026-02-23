Return-Path: <cgroups+bounces-14157-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEysAVKEnGm7IwQAu9opvQ
	(envelope-from <cgroups+bounces-14157-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:46:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBDD17A155
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 832223191BA5
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BA2314A7A;
	Mon, 23 Feb 2026 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="TzuB9CCO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9B30BBA9
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864623; cv=none; b=bH5EAIStpdlTxVLJkCGdgR4qJ2y32noUbeaB4NY/KjFZZACDlQ2/6eyHsKBmdE88Uocpp+7RPs2V7++TfU80x5/NV9WbHA6M9LdbZkScgtDx6Wh5iS2g4ONg0pHTsQtdgYzwDs/0GAjgEguBMjmD1j5Hnls7UTOHzK1ipDLBuDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864623; c=relaxed/simple;
	bh=4nR3ks6vdAF8p/4j30tU975pQLc2amH+V3QrAEHXWDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHB0kMgRMpwXUK70nvaqMMxcrbdR1HLFcihrejPpSuVc1QfiWI44+ayWZoYcZsbZIHUptWpPL+4BHp5Lka6/WtFzbn8wOobfKiaSnZX2d0wTuL23OGyc8angjQjcVcrpHl8/hz9fT1iMhdvSRdbZKg61m5wP9AU6s7jyU493SVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=TzuB9CCO; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb3e22435fso451167285a.1
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 08:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1771864620; x=1772469420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WzArJKlU+ASYCguYb43+yRgFO3yBr9sECL/9qGjk+Qc=;
        b=TzuB9CCO2aZNrA1+dnFaRa2TN3EqurZ3L88IMU8V0kG2nehcdm0DJn40aS7O7XU3TO
         lXN8BR73D4HncNJecB5lEwKqfY6s3R0FEZv/NIYP7yMpeyZFGVUrezAYzmpcMGjNG43p
         9JcVhMBw60ufTTaQd6CvIL/XCCUHOPfwO1U3qZbS9YZLdhijPYJjPAy5FxMjo+N6jlGv
         IZkkRHo5ROKKGX+egkNjPS7zVAPCoSv2L1I+C+R+KnNTvHgVe077+ouGPYtxqV4BmZTu
         Z06xUrAfYyv4B0kUezaAiNUcq/geKK+iz7+u7O96dKpaD1g9rXQR7M1MMONlfM6O17Gd
         2SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864620; x=1772469420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzArJKlU+ASYCguYb43+yRgFO3yBr9sECL/9qGjk+Qc=;
        b=Mqmoa8Mq+VcHdsTThBPURBWfedjo5PjqrL5Snq4smXsDVqg6c2gZD9LMd6nJs46c1w
         MZTX13AVJaPK1pPk8mLf+Do67A3jMwaJmJEgn25HiUyAUqP++Y8IuXc2NxM71+y075Oh
         Am9aQzoOi2nRwBfRHs0wfrGgPOdjC775K5SHlTXwzn+P3gxP2r0LTQHc5/Gj+wkC5QGn
         ddIXE42VegxTzhc0nPfUN1Rsm5fiREIPDNGEI0ZyuitQUnZ/acXSp9eg3upqBc/ZMlPp
         +4dqNrrripk0fuFLBMs8l8sDkSiKbjGLLh9rp5uK0SSyFQ38wLilbnOQWIgYOjlBchMt
         lpJg==
X-Forwarded-Encrypted: i=1; AJvYcCV5bEqszSQDvJvyaX9noV9A3Uzj1/c1k9X5TbaZGq3cMYcn+RowyCdONjyxbcV6e6bUvrhJAAdb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy6BvKyMihp8mLgsBbzTfJSqdtK7AFgOIEsYyE5JTf+KAn3+qk
	HYqSwgWr74x7s6bEduFTQ5+7NSDm1fu8/6ym+YXRGB//z7HvzLrsYcwADIlSXJO9Y0FLZCzFXW6
	bUGPM
X-Gm-Gg: AZuq6aIpZCPgfnyGH2FCuFpKgsPbNE7pYfaApjU8XJu9hfdsR+Twi/DK9vfoSY3qMpy
	r/wrjB0LDRCULxo0nIINXmZFdWXq9q5zbb0r+k6HgZWPi7HKQnRkXrpNR0Hg4CE7scw9jGfw/z1
	Rj3sEPbEZVPuCYOfEM+WJaX1phrITh0/Osm2Q9VGJ/EZAkbnpb5r8C6eBEOcrjqQqsyIaBo/h0I
	wWqb0kikTFyhD2bbbtLbpDLT3FCa8KvxZ+kdP9G8m4+oB/eZijmlFB9bgc9NIRpb8s8AQG0xigq
	6gplbtPdbfGa4zTF4wzBnrVwpuyZ5NwReVrXKiIhojX8NBDwGIvqEJRXRoa0BKa5B4e5dcj8CwT
	NPh0fT84XJS/W3ImlB1oWmiAYn85TV+ml7QODiE1fJU+XBSznKHl67uiSdTGcNKEDId0l41RTvE
	LNRHZW3WtOcrafatKg8gjoLA==
X-Received: by 2002:a05:620a:472b:b0:8b2:e17a:17e3 with SMTP id af79cd13be357-8cb7be3b84fmr1746011685a.1.1771864619752;
        Mon, 23 Feb 2026 08:36:59 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e7747f0sm72340136d6.51.2026.02.23.08.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:36:58 -0800 (PST)
Date: Mon, 23 Feb 2026 11:36:55 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Youngjun Park <youngjun.park@lge.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH RFC 08/15] mm, swap: store and check memcg info in the
 swap table
Message-ID: <aZyCJ6pH4hey-ZoU@cmpxchg.org>
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
 <20260220-swap-table-p4-v1-8-104795d19815@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-swap-table-p4-v1-8-104795d19815@tencent.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14157-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,linux.dev,lge.com,bytedance.com,vger.kernel.org,tencent.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups,kasong.tencent.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DBDD17A155
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 07:42:09AM +0800, Kairui Song via B4 Relay wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> To prepare for merging the swap_cgroup_ctrl into the swap table, store
> the memcg info in the swap table on swapout.
> 
> This is done by using the existing shadow format.
> 
> Note this also changes the refault counting at the nearest online memcg
> level:
> 
> Unlike file folios, anon folios are mostly exclusive to one mem cgroup,
> and each cgroup is likely to have different characteristics.

This is not correct.

As much as I like the idea of storing the swap_cgroup association
inside the shadow entry, the refault evaluation needs to happen at the
level that drove eviction.

Consider a workload that is split into cgroups purely for accounting,
not for setting different limits:

workload (limit domain)
`- component A
`- component B

This means the two components must compete freely, and it must behave
as if there is only one LRU. When pages get reclaimed in a round-robin
fashion, both A and B get aged at the same pace. Likewise, when pages
in A refault, they must challenge the *combined* workingset of both A
and B, not just the local pages.

Otherwise, you risk retaining stale workingset in one subgroup while
the other one is thrashing. This breaks userspace expectations.

