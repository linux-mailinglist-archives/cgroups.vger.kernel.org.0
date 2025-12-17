Return-Path: <cgroups+bounces-12451-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 589B3CC9AC9
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57AA13009F33
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9F53112B6;
	Wed, 17 Dec 2025 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="JRe9hjm8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B378310640
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766009581; cv=none; b=ZYL3fLpcjc1BOUtMO6ujuEUmmwujdg9D9TrFVplz9q4Uh3lzG51w/VKrua+i3yIVdaZmhZFF89Or9CpzCblBrsjog0H4kwSVVSEexPbDhf/E/4Q8CX6lDtjG8LjX2wkH25rHbVYZ4FaLHecBbrGNUMIlNaTvXkM6gsZWiFVbxB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766009581; c=relaxed/simple;
	bh=g6P7tF79NSs1C7Ex+Ei2etYQt42ludWHJUyAOcnHKvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuUYERO74wGEgmkcMP/xlKLbtD5ioAkyQslM+TcpdMDD9PFn/73pChp6nYibUA+Pq7aTfS+3/Uc19Qt4LTevUqmpWOJKEjGExHAE36IkMdDwxY9DnuU6C+jf/pej2KH02xUTz5DllQ1YFkJkVox+Mx3M9QIGOiNL4zYHF7J3/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=JRe9hjm8; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ba0d6c68a8so1426585a.1
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766009579; x=1766614379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0r4AcHCJsbraBtvKrxqLUV4+jAnSf+GId2QtAk4JbW8=;
        b=JRe9hjm85SvXwNYNA+qFiIAC7IS4XFVNNSIln0/pd6x+EZDq+KO4Q5o/7h54DB13Ib
         aIfXCz0FDG/GM5N8B0NlATehgRLuf7YiqqJiC4F1VlUtJOW3dTgXbcvfkaS4MmhWWQ9R
         9jmvga1I8rkKRFKQ2rH3HX3agbYYqa/uE2PDUw0k4GAykdu2exJwNbaoIos8aX02Cgu+
         F/bA8nTdEfZNeRZ9UiBR60xVOE41xRLmWZupGCRp6kmFOGTOiNFccORzmGrWlpRqhlje
         erhSCxVjQovAbxzKuXMd6iOLsAnK9psAyyKFFNSNN0yBLnlyrZyUNpeGAJhdD+okU97J
         AwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766009579; x=1766614379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r4AcHCJsbraBtvKrxqLUV4+jAnSf+GId2QtAk4JbW8=;
        b=aTfLnw674JMXwgNd0no5aDW8Z/3QpHDN8aaau1TUsMlFQ8qQQ182zu1IKjzKJ7Cj2n
         7NYypFyqQIAxfTOQFwjTSuQ3cm7FtIWjTw9oN9d2ZeRv9buYA4A81FXlcrtZJMfvCPNQ
         rgHGplpESrwl0wRiNcVh9FQlmu5HAUH2Yn3DlRgMrNUb+XSymnsukaQAFuWXAyBAfjjo
         VZOU8aSlZtaoBLlumwLJc2ex0YGwzBgzcmIuLXTmyWbB8Y/lRbKstB1HkiMmgxKYqFJ3
         2GwW6esGK33pEwC1vu8PZiK4lsOay8U9JlUZ4/xu/noESgql0IG1pztlst8OWg5Kxvku
         ARFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlkN7K2jYFTcoefxgklanyIxOHS4CZqfpJznmWodbGiOhX3TsI45bcypA4CP8qbeGtsVgS7dgX@vger.kernel.org
X-Gm-Message-State: AOJu0YxszluJ53jg8G3vfXuWZQ0pcvxkLjiNg0sy+dNcTe45QoFwP2UA
	ZrNoovD1XqZWOu0X9OcXAPPrkA4zhfcVG69NSdbB93IEexxLHriNnvS+0w50F4zkefk=
X-Gm-Gg: AY/fxX4KAyabdylIbv/jdyEXWXSTbSQiSEvh/SFM1pSn89ypgZ5Ud/rTj9UBdETfkpT
	ANzOi6COiVmIfVG0Oz8AoV4YK/uqTrNEC0SBxzfrMCVR0k7Kp9m4gKMCv48tFY0zcBKMgD4hVMV
	hBfUIMPg2m1nnUbIq9Fv+4MYkGmTHsah4A9Q1P51RvAoZtow1zD6iRHsgFuJb2D0n3onqsZu2lT
	+/q9VQFqUEZMKTWhja2q1DIsUE7c/7f/eMM+mUiZzNpssIpuVFd/y9KjRvyJUcbm3FZCA21YIEi
	iMMYidiZ28nTOmkIaXCvGeTrcG65gKZy5NnoGEXDrtoo8TTNNX/zcAHJL1LSnxaMv7XGue9Raj3
	7Job3PoKvMekgm/9eWUTX+gihekZMp0QA7wdFkS4oiVarU8QuCqIAlurKtsABaDOra/o5KHEzl+
	XsaSqxojcE1g==
X-Google-Smtp-Source: AGHT+IEDjxNMfGaDHTeRxR6IoP+YChMcHJokF/E/cKPiKQN2J5ktp2NQR0qF8g9TEYzKuBc3jsLv0Q==
X-Received: by 2002:a05:620a:4046:b0:8b2:dd0a:8814 with SMTP id af79cd13be357-8bb3a39ee87mr2765045485a.85.1766009579048;
        Wed, 17 Dec 2025 14:12:59 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beebb3ab66sm35932785a.48.2025.12.17.14.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:12:58 -0800 (PST)
Date: Wed, 17 Dec 2025 17:12:56 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 12/28] mm: page_io: prevent memory cgroup release in
 page_io module
Message-ID: <aUMq6PEuosi3JhWF@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <30588f984137d557e4663ae8dcf398b8c408169b.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30588f984137d557e4663ae8dcf398b8c408169b.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:36PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in swap_writeout() and
> bio_associate_blkg_from_page().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

