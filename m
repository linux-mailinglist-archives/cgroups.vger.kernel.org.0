Return-Path: <cgroups+bounces-13220-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B87A5D210EB
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 20:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DEB63047439
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 19:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFAF34D4C9;
	Wed, 14 Jan 2026 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7L37YW6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4171E314B73
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419482; cv=none; b=QD738IhoYNOK5KMl8TVY4TQczpGdrbGnwYB/wL6o3Fngwc9hAHxt3I2J/kKo/TT3ZRdEuOmNw2PRz/B9KLiCEUtd6ZHTbdL6orPR4lASl2jqoEc2g7/V/QxWNlvJfCR2wyMhAgxwxNMPb6DCGSIBQ5vBivU0gsGf0wUe45ahVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419482; c=relaxed/simple;
	bh=zq4kJ5VbMw4y+s2OzUm/mReV4LRmVVVdXIVlub2tJSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXo4Jf9yNAzLezS4nADMrB5laqrowcbZe34oYgwA05Cr/l9fcM4tjWIJeBvDEfmTxTpsTCXFNAAGo4uygM7FH4MfP8Kwp1TrFLJxT3f50EZQ5JOd3m0rUtnB4yIFtde1ZxhNbkwpTWLGN+M0pc8RnRe/4OQm8IthiQ5sGH09zSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7L37YW6; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7927b1620ddso2335537b3.0
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 11:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768419479; x=1769024279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwU1lBi0rbbP4UG91Q/23aZsfJ+7kter/zQSZfNp9dk=;
        b=Z7L37YW616n27Wl6ARGTwkT4DcwRbSKLmTq0hlNr40M+qZEYuL0UXJ0CzBHMbnhGf+
         iO6Tf27rLupFeZ8qUN3j53+vqB+7EEpcFVFx/D75VQjs8fgUnnncb5ESVmIOApwdzUrA
         YtDouloUCW+M+H/gaqkbfr3kIZTsIilOluWBZHJ5QwU4EcOWQ+6lF99LNUnHFF9MEh0l
         GoDRNTFZQgpCc6VKzylJOUSaJghSxQGGZi2DSMwKSoGa5y40G0k6CTsuMm1idlSHcsZt
         Nz2Wp0egcgKRxwEizUmmOkM+fVLzJFyAn3lTMFuFE1kN5+uk0QNPQNqovveauJr+a5R2
         I1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768419479; x=1769024279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YwU1lBi0rbbP4UG91Q/23aZsfJ+7kter/zQSZfNp9dk=;
        b=o2kncIYJe6skxycp5G//GkyaGoNhJ+QifSguGQyNfJXyw1xaTZnMVk30LAFs9vv3MM
         Nlr4eroPROeskGtRIkY5rr4/sK7ofMqGAf8CnVObzTuhcc3uIPKWx9YePBmwbjgmJPF+
         kHxk1+uJJSL3iJxZqdbJneaABJDbJ7k0ktUZaH1SpBrQ+11hQn+lQRPLs/FRADkgBkK2
         GtsVMh4LVuzub/ksBn6sEAHP6OVXfQBiVizzkO3djyERsMFT/5UMB3TnYkyvhllXC2XO
         Rs/Prq5VbnSz0lPqDVLxnPQN7xG8rHOUiTHtOFfwIRhx2k7tTwDdZZsmFRr49ztBLdyZ
         icZw==
X-Forwarded-Encrypted: i=1; AJvYcCU8sf6X+KJn9EZf1th76h/yaaUhBUeAQhKs/8RoiWA+vipfweHureDoBrd9SCBamIr95z7bWTdU@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/S7cY+plojYw/XAd7rHbGrdxcRW8vMUivSBDxhqkzY8TGL0l
	uw6I5wn9/bXgDWi1VA6Zw879RqjngpsDslVBqar8Aq8v+ePlgUYL8L03
X-Gm-Gg: AY/fxX6jWG6qIn+kmH7TXDOwT2dawVntS6ApZI7zUIYbamLARF33CAeEn0KNfi2wBFS
	m7fPzVkosZ5NJRAXWFC6HBoU7Mqfs53yv+Wo3F2PimsUC3nCU6yjup6eLrn1sqdk+6exFmELmZB
	HbKP5b/3Eb3ZwW1o2RAzwrqnVzmTS4+ldOVxYj9Ex3iHvpFlQqpaRHldgIHOjEGsb94otHsgPd7
	HaezDyfyhOfFnpNRNRQONhUy4UcNc0qwMjWFsm/F9Vx85OFS+axnJWeFm2pw0+OBDLazv1tzE41
	g5/Bj41Rdjqc5RN5sTXQ4X0djUHyYlTHiHKc527gp7Ccll/dFe0/yjVkr0bZONkYoH/ZkhRls6R
	JuYeXJiYFNpSGh8ZXA0OrmWYpAP/3pL7bYxNuPmAqj3IDPRIYzL0yDPXEEwq1MR/3e+C9YwC0he
	dieHlrDOtpjw==
X-Received: by 2002:a05:690c:6101:b0:793:ad45:8e8b with SMTP id 00721157ae682-793b34b7537mr6350897b3.19.1768419479114;
        Wed, 14 Jan 2026 11:37:59 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6d93d1sm94111507b3.49.2026.01.14.11.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:37:58 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Rakie Kim <rakie.kim@sk.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Zi Yan <ziy@nvidia.com>,
	cgroups@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] nodemask: align nodes_and{,not} with underlying bitmap ops
Date: Wed, 14 Jan 2026 14:37:57 -0500
Message-ID: <20260114193757.3337985-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114172217.861204-1-ynorov@nvidia.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 14 Jan 2026 12:22:12 -0500 Yury Norov <ynorov@nvidia.com> wrote:

> nodes_and{,not} are void despite that underlying bitmap_and(,not) return
> boolean, true if the result bitmap is non-empty. Align nodemask API, and
> simplify client code.
> 
> Yury Norov (3):
>   nodemask: propagate boolean for nodes_and{,not}
>   mm: use nodes_and() return value to simplify client code
>   cgroup: use nodes_and() output where appropriate
> 
>  include/linux/nodemask.h | 8 ++++----
>  kernel/cgroup/cpuset.c   | 7 +++----
>  mm/memory-tiers.c        | 3 +--
>  mm/mempolicy.c           | 3 +--
>  4 files changed, 9 insertions(+), 12 deletions(-)
> 
> -- 
> 2.43.0

The entire set LGTM, thank you for this patchset! Feel free to add:

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

For the entire series. Have a great day!
Joshua

