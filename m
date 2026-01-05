Return-Path: <cgroups+bounces-12906-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFB9CF1D89
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 06:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 927B8301227F
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 05:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19EF325705;
	Mon,  5 Jan 2026 05:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bei2fnu7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0931ED7D
	for <cgroups@vger.kernel.org>; Mon,  5 Jan 2026 05:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767589869; cv=none; b=O48LN5Sm7x5YLl/gaCqMy0AE4ZTx+z0NbBkskckIbOS7wgNhGQKs49Va7M4mAPO71LL2FCBgeW523PCB0EPw6/npKfuHYm6VKqtLs2pB9JE+HELIvjnv8nqHeUAdG/0zGm63RwkWLoHpJ8IZdc+50rjJMyICL92kc/OBRhZB4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767589869; c=relaxed/simple;
	bh=WF9Sz2IhN9bGLIbLOcwdYrTwvywEFHkO5vlzbir2gEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex9eTqWOyeRjxekNxiY45BuAQCtsC0oj2Dv/PL+tVOvCT2a6AgO71Wq+dxFk9Ju0PxqskfooOFn7KST/HU+AhQTs5TVl4YZyHybl31cEa6ym0f3Qyx6VLivel+r2cF0PBZu9nRd2tnp6jSTLd4qqya5JQj/CQP7X5YQqrOwIZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bei2fnu7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d06cfa93so155285ad.1
        for <cgroups@vger.kernel.org>; Sun, 04 Jan 2026 21:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767589865; x=1768194665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvpNrM6V6EQoznDW/e/eykjEU9kcBlSrOOOQoJkleao=;
        b=Bei2fnu7zTY9TawBGSPqwf3bFtvy+gFVtdDwix7xrVw7w4JlLWK6k+kc7q5E9LfCHt
         bk04gME564UwrMdANzs7Ea2oiJ/0HWcJdNctPorINuox7oCsDyGux/lYmc20jkruhIZ+
         SJ5epOA11SzQzCIgi7K5ySPMLOTJln4S4y8xma+s/LrkcIARpWrvFAon07BxZb/Vlh9A
         l96WjmrjeQc/83lUEay1F/GloK2UJuQr8JxoRXnm06RKNLRTE4Y1iQm96ISwKwpCypei
         zYfq+WO8D8EG6wvo0MeH2NevX/wo7ntFPj6SCwzwoSviOAhQO4+VdWj2txcPv8bc7dC4
         JSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767589865; x=1768194665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvpNrM6V6EQoznDW/e/eykjEU9kcBlSrOOOQoJkleao=;
        b=PnjDznAQL/PBpYZYDSmo3xedSbEVjS5LeyTQCWkNoqLHp1puWs4bpAcJ/1QBhE/r08
         Y+psYUF1XAi0ScYtI0SEEJ/iEOV4rftkSq99Jf12XrU9J9lb8M2TC2ZJfmRjbLfuuNsB
         lNZ7pcFkULX6dmno0Cpr4qFC4QFAaf87by9Dh6uHEE/1wttvPFK6AEDtC7m60CW7CJR0
         ZJKeeLttbZ7uynQALhhnHBVZIy7D5/IoYwxVdf3e/afqt1UiPHY6c3UoEPw6+BlwsG9c
         4rdpijsxAthYHfA96IJv1Veqi6iMNwlaE1p6BNddn1dGu4ND4plXucH2xwijkhh2SZC8
         +VjA==
X-Forwarded-Encrypted: i=1; AJvYcCVx7ZsDZPikNTdNGlGlhhmQ7DRhioMyVruTmhUsiucWTASZEYZuN/TdR11oMSu8HoenxBJg/5YN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh83KZqQzjv/rWDuJ/rH2vs3WovTiK+uNnyA16mfIqT0chv0QQ
	M3/shxLEmQDQptUMMIYq7/pv5UiOkmRrKmt7GqMi56O4N7V8Ab/0p7TwyPZPyd8LMA==
X-Gm-Gg: AY/fxX5lGMxOwdM9CNiCWVyGd9YE94Sz5Pq/rtnxNT1CZVW2ueXqgd6+hORRk60FzTb
	8BOk87poyMTVfwOWL9UFVbkRuAWUMSRs9OC4xhnmspd8EOjzx8lJsTDElUQ0F5MN4VKMAS/IJqb
	4/c6MjS3zrFBSFV/XAw8bNMKT66yx6LDH2ugSjlG/6v5sr4SYf/gzfntXjk6tsxH65fmc/Z9y3e
	rOvww9VttgbJ+AUcGAjFe61WQpFZiaXRppsC39883xFthPbsfYK0RA1J1YvwzwtJhN2a5XzCEGy
	/ZuEo7M+ZXhl+YEb7iuKVkigflS4MaMi+bzJanJGYCAvtlT7GV9J6kfmLun+Giu+jf4pI5MM5A6
	D0yTpIAkkNM49OO0o1LVW9JSEJct1ayscl3Hw5bvJU02rwbN1BAcmoOa7g/ogx9qvWCmkg4voik
	hh3PEe/MQaTwTsFw92a9PbA2YNwxDPI7+pe4B1v30VBxezlYO7NnE+PewCGjv1kkc=
X-Google-Smtp-Source: AGHT+IH6GRc2aKx9uWPc08BhMYf4GulScHtpZeTvi1OKubAvka4Vbsx4UDJ2sIYfstiF5FDYFBSb0Q==
X-Received: by 2002:a17:902:d4d2:b0:26d:72f8:8cfa with SMTP id d9443c01a7336-2a3c3188ae9mr1797925ad.13.1767589864039;
        Sun, 04 Jan 2026 21:11:04 -0800 (PST)
Received: from google.com (248.132.125.34.bc.googleusercontent.com. [34.125.132.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7ae354easm46697199b3a.16.2026.01.04.21.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 21:11:03 -0800 (PST)
Date: Mon, 5 Jan 2026 05:10:58 +0000
From: Bing Jiao <bingjiao@google.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, gourry@gourry.net, longman@redhat.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	mkoutny@suse.com, david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v4] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aVtH4tXHgx0a3udf@google.com>
References: <20251223212032.665731-1-bingjiao@google.com>
 <20260104085439.4076810-1-bingjiao@google.com>
 <b55451ff-b861-4e4f-bc79-6de0c802d64e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b55451ff-b861-4e4f-bc79-6de0c802d64e@huaweicloud.com>

On Mon, Jan 05, 2026 at 10:48:09AM +0800, Chen Ridong wrote:
> >  	cs = container_of(css, struct cpuset, css);
> > -	allowed = node_isset(nid, cs->effective_mems);
> > +	nodes_and(*mask, *mask, cs->effective_mems);
>
> Why do we need the and operation? Can't we just copy cs->effective_mems to mask directly?
>
> Per Longman's suggestion, name it cpuset_nodes_allowed and handle the filtering in
> mem_cgroup_node_filter_allowed. Please keep the allowed nodes retrieval logic common.
>
> Best regards,
> Ridong

Thank you for the explanation and suggestions.

Patch v5 has been sent with the corresponding updates.

Best,
Bing

