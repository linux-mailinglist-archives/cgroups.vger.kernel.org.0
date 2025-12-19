Return-Path: <cgroups+bounces-12530-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F26CCE686
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 05:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CC953045A7C
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 03:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8562BD58C;
	Fri, 19 Dec 2025 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="AALuAP+a"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9848C28751D
	for <cgroups@vger.kernel.org>; Fri, 19 Dec 2025 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766116564; cv=none; b=lFGvbXfJVIr5Jyu5eyz7XOGzghCTWTOEKbFlCgvXrOVVjCA7fmZ4mgslCc7DCx/lH4WmAwo0G+fElbgLtz9Om2GiIbfwWeWtpKmxtsiZxKglOC/KlTyNnCZcuxW6wd8vrLcri+Q8IILbVZ293jKPfpfGrcbwlR0hAGvtcnf2kEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766116564; c=relaxed/simple;
	bh=tBzt9IV1Wl5MTxV6lep8PjuwLbb78DUv5cJLiCeM/Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPcUIHTEUwlglTxeaCTtCbpERfF6+bPOcsZcc85pCyLgsV5X2ECuVIFEjBkCgrm+uRQLi/w5EPjY6gxFFRICffQl8rwDJ0vX5lXH6tLtflu9YxI7OG+PTKonIhD2jDWLxsNiMKZiuU6FHgneyCFT0AZIV6XoAtoXOE9zfG6ELk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=AALuAP+a; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4eda6a8cc12so13445001cf.0
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 19:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766116561; x=1766721361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTtfle4/MykGQYtmzDysxCuwpMvHg0hiZkC5ebsS7CQ=;
        b=AALuAP+aCIiqIz82ecPToGGsjbLaDEaB/p2iIitLaHh6Ob2MjS2p9XQwRBgGrCn9Ey
         KffYiKvd07IYxn1a8JFz0DFJhWdFs1r/Rg/rk029VBxCVtpXyTkXERJ7Ig7rG/HtKD5D
         s4LrlCiZ9IWieuuqleumqm7nqhW3qeqEUMKwa+NcgqRtHkQelSLICXbEh+mWpUGZ7Ols
         bvFiTPL4oOkqn1feNhZu+HLZ7X1ui0RRxrnTWhgQyDhQSP3oJ/nc7wBJxqP0oQ8rYL9O
         2mlt/nzGE1gt908IfuMQU0CokGIwiYeIqNvvJSMvR0nbXAuYU5L8EQoscCbx2be4kcDh
         4VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766116561; x=1766721361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTtfle4/MykGQYtmzDysxCuwpMvHg0hiZkC5ebsS7CQ=;
        b=bqQBeK6dYyEKiDNhRFo+nGp0GE0CPkRMs2MSVfSjob2GfaOKivfvfeNiQsJDNMgAyN
         1auBOWB+QmIlPK+umQ9VUgTTgeTB77UndA/QzJUcq2jkugGHKZQBPRYSrksXLeuM00D2
         bSz15XjWGgkkPkUJQrxefyn/UQMMDCdw/XJ/1ORUWL4hW7U/CrLxbuZjKqAP0nRD9noH
         zObz9PxhZustANoDoJClHU58Clcz9B3roOSp2zVCUu/dhChH9DFuZfhaDbzAKAHlZ5EW
         qo9Fsa1sKQrnDkRSwcVbfg/Bh6TpkVDBYKRNqzuHVFu9n7Eg8tVpShSh1XcxFhK3uA00
         1hLw==
X-Forwarded-Encrypted: i=1; AJvYcCUHD/vMjn/E1n/e2UbCzDkmSbCqHGy4krMe5rSVIH4ouJ7iTn/TanBBFnkfuapt5geitMAjjkAR@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWcVRBEwYd9tjcTWIOQkLKRc4IbxEbcJgxFhz3fTq5bchpqgo
	85DHXKmQFq/W3zDX5zxcU5gU4RbE4VgYA7CbBuo3JaPLsAoG/IQLBnSq0sKoH2xn7Y8=
X-Gm-Gg: AY/fxX6JDZdMaAzo8MqeMw3l8PBhF+Bgjn+dvF6wsUy7U/g8binFoVFS4E/nRZlFAvu
	LVxRHQgxWt9F4Chx2VqJzNJs/6HwCIagGIL/OHpBFMurVsm/UDsXmqlDvtksixNCe9+78B25Nr4
	cMebU6jJVtELNdsiosgSStZvyBdTS7LkkGO40ZFjFdIIyfLTeIg9d+tD6doFapcl4+kcZgm85/E
	mkyUuFtaNGxDiQ1nMo8OA4tw6AwLKV+Cf1JGGysA8JFrCde5tnpnG431/FvI/xe65aV2ugTDjDg
	TGVPuCuRO8CJssUzKZGlyxzi38HYzX/E7VQ0LZdg1yvWbIgm7dbMhQYN/Vh9HH8TLthLXhjDdIt
	nrwEYBGt6NsORY15IWhhDEeJqNNqnGesRxXJ2o70YrzSEMfa19On+u42Pqhs6F3m9i+q4G7+F0C
	/SGfSNLzCBdMqvxDZ21L9k
X-Google-Smtp-Source: AGHT+IFb5/BXn9GeXqAyeNuOtJbDxjaPRu4NM7Bq86/JmBGVvG42Er/O0lr+BnQiTxNW6EgE2U/MvQ==
X-Received: by 2002:a05:622a:2c9:b0:4eb:9df6:5d6f with SMTP id d75a77b69052e-4f4abdbe93cmr23315421cf.74.1766116561499;
        Thu, 18 Dec 2025 19:56:01 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997aed21sm12322946d6.30.2025.12.18.19.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 19:56:00 -0800 (PST)
Date: Thu, 18 Dec 2025 22:56:00 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hughd@google.com, mhocko@suse.com,
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 08/28] mm: memcontrol: prevent memory cgroup release
 in get_mem_cgroup_from_folio()
Message-ID: <aUTM0MdsAbpcH9GM@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <29e5c116de15e55be082a544e3f24d8ddb6b3476.1765956025.git.zhengqi.arch@bytedance.com>
 <aUMkYlK1KhtD5ky6@cmpxchg.org>
 <ot5kji77yk6sqsjhe3fm4hufryovs7in4bivwu6xplqc4btar3@ngl5r7clogkr>
 <aUTMUKEkGu7cEgb2@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUTMUKEkGu7cEgb2@cmpxchg.org>

On Thu, Dec 18, 2025 at 10:53:57PM -0500, Johannes Weiner wrote:
> On Thu, Dec 18, 2025 at 06:09:50PM -0800, Shakeel Butt wrote:
> > On Wed, Dec 17, 2025 at 04:45:06PM -0500, Johannes Weiner wrote:
> > > So starting in patch 27, the tryget can fail if the memcg is offlined,
> > 
> > offlined or on its way to free? It is css_tryget() without online.
> 
> Sorry, I did mean freeing.
> 
> But in the new scheme, they will happen much closer together than
> before, since charges don't hold a reference to the css anymore.
> 
> So when css_killed_work_fn() does
> 
> 		offline_css(css);
> 		css_put(css);
> 
> on rmdir, that's now the css_put() we expect to drop the refcount to 0
> even with folios in circulation.
> 
> The race is then:
> 
> 	get_mem_cgroup_from_folio()	cgroup_rmdir()
> 	  memcg = folio_memcg(folio);
>             folio->objcg->memcg
> 					  offline_css()
>                                             reparent_objcgs()
> 					      objcg->memcg = objcg->memcg->parent
> 					  css_put() -> 0
> 	  !css_tryget(&memcg->css)
> 
> and the retry ensures we'll look up objcg->memcg again and find the
> live parent and new owner of the folio.

But yes, none of this happens until patch 27.

