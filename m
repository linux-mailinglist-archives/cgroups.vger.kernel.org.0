Return-Path: <cgroups+bounces-12512-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F66CCC51A
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 15:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 485323116D7D
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D512D877A;
	Thu, 18 Dec 2025 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="bXJDC5QQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B562EACEF
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067984; cv=none; b=mCZv/uU/gqNWSiI4MaVhEOz5yFOHyiU6ddJAcJcFRqjeR7pBQD0lIaisRc37pIk/B6m/X+2k4ppMo91QjZr1r8IZ3rZ8h86Bsw/xOHcQHMqHkfM5G4RgpU4ZuMYoxAT+G+YV6+xFbm4UiFjSP63xTxt3LJkWSBJ3qC0Paz0sbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067984; c=relaxed/simple;
	bh=+tqbzSsCOlNx3bYnQg0e6G2u96ugel+0x7WAXg56Ir8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eY8n1m3C8ubRJRFLIhQQISRApvfN8dUI4RX6EM4slblTdVggCvQGggDXzlWNNAxdYblhke6o1Wm4IxPwCh0zBC5PlMS2rrgehPtoV8bjzVKJfgPzr0tkGBHp3l3eCn4BQYyzzKuJpd5JQ2puT6J5PLQ7mQpPM3/gVK1s0ultMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=bXJDC5QQ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-888bd3bd639so6964526d6.1
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 06:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766067979; x=1766672779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4JfDdWMGPq8CSrxduIu7FfagUjVyoTiMCySGeC3YnI=;
        b=bXJDC5QQ+cYAW4r6KI0wTzVHVJRtlYPAMDK493B7+Qq63cHV/zFVDJPhILlaR5anoR
         HIZF9duOMGIXI3usiTOU+EjvodPjr/5SKhnIQrsMn33qFi3QuwwQ8HpqXeISZxZBeaQm
         MYyN64Li762lXYqDG0CZGi696pauDqwvjs9R5OywtzurzLz9x7jbQZbO9LsHl9MatB55
         ewXGqaSgG2qrR6hTNQl/8wEXZSEjL/2vs+YCHtAW7bg4u+r/hBlczK6vJKPd2n1mCv5j
         y0MXrEvQTvUdc+GROdPKojofJUnGz/DH38Oeoycn/VyKW5F38unZe4srtXj4zlcgsFBb
         A6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766067979; x=1766672779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4JfDdWMGPq8CSrxduIu7FfagUjVyoTiMCySGeC3YnI=;
        b=WfjWkUDT9kDxq1WjFBQ49tf8BZVPalVmoYRaRwB2M1/nJm55RTDpjPqekYoVUyvphv
         eya8hUYF1yc4ypc1bVNnkijvtmmfCddK/bWqUQTcpgg/B5A2XoJ7IYg2q5dARIi8Tzxi
         Zu0sq/I2p9ZRuKTnU/HjUIi8LNdUkwlDo7JB2CYO8HSijwt7aFVr/zNTFbZ/UrZN6HTw
         dIW73nsr9QUaNhuAJn4/SxQSRDGCeJr/p0bWl8rSjqZcYHQe0TDvWWykrhTioJJbWixb
         PLTOAWeKBHpZ61+4rIeX5Fn0cASMIV4f4Uz7uX9hfVFOfUp6M/yn3cNDBNtdovvOLBsl
         g9XA==
X-Forwarded-Encrypted: i=1; AJvYcCVii4bB5jasrTc9ZMYZxU/2TD3lMBlgag3mMuCWoHgZz5M9kZp+se4tJ2vf5Hn2RNOEP8sQw9zF@vger.kernel.org
X-Gm-Message-State: AOJu0YzuyE5xAHpWYzypdTOiDG2Tfj7Ccxff18QZBCrSOIigUJtQ7BKY
	gjH8hecncqBLAvXHZX6xzat5WomI5qT9xWcFwSFB3I5d3AlrLK5yTpBjjMVXEVBbGCs=
X-Gm-Gg: AY/fxX6Tvbzfu0Ajf2q9Y/9si250LWQ7B2DDdusEKakdiAJHWP1dzsq1sCxKsKrzxT1
	6nkuL5jYIZQFEqvinImHGe+Uy9p3x+4U6QQtwXDHjf0lKoIrhBpVXJwGIz3kqU1xA98C0WkgF+o
	vHzmjDX7B0ao8ojHforxBGkrdn3f/0JjQ6J6bUgJ9a/6x9wR3e7Uuu8h8zlyLRXAefh3Kpvm7zu
	NBMUEsZarXAtkgG28RANYXqp3eq4YzUkVO3jqdPN8cNSqGiqpxHqt5wp06PxCQAfI1ddGhVDYw8
	VAU8VQCCC6UNQ6eoGYz0aoagL5LA0rCqctNkQmkBWgi5oviqvT7sisZFjqINVb1C77+ckI0dlvz
	PFnVIry1/Et3jWv3q2zA4+g73p5SGUVWr4z9n0wn3QwXBQtubAVqMqo/ebxmCNKYhO59nhLYNVZ
	1GEz5yCaFDAA==
X-Google-Smtp-Source: AGHT+IELq2RKx20U60QDHWt5nbgZD6b0sDzQmfp1LT1fm0LfAa5ovOYvirAd5MjdzrOUr19AMKNjZA==
X-Received: by 2002:a05:6214:2d46:b0:880:5589:54cd with SMTP id 6a1803df08f44-88c51e5859dmr46310956d6.19.1766067979375;
        Thu, 18 Dec 2025 06:26:19 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c6089a7c3sm18147036d6.27.2025.12.18.06.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 06:26:18 -0800 (PST)
Date: Thu, 18 Dec 2025 09:26:15 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Qi Zheng <qi.zheng@linux.dev>, hughd@google.com, mhocko@suse.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	harry.yoo@oracle.com, imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
	mkoutny@suse.com, akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
	lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 13/28] mm: migrate: prevent memory cgroup release in
 folio_migrate_mapping()
Message-ID: <aUQPB0cUP9PXnrqh@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <1554459c705a46324b83799ede617b670b9e22fb.1765956025.git.zhengqi.arch@bytedance.com>
 <3a6ab69e-a2cc-4c61-9de1-9b0958c72dda@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6ab69e-a2cc-4c61-9de1-9b0958c72dda@kernel.org>

On Thu, Dec 18, 2025 at 10:09:21AM +0100, David Hildenbrand (Red Hat) wrote:
> On 12/17/25 08:27, Qi Zheng wrote:
> > From: Muchun Song <songmuchun@bytedance.com>
> > 
> > In the near future, a folio will no longer pin its corresponding
> > memory cgroup. To ensure safety, it will only be appropriate to
> > hold the rcu read lock or acquire a reference to the memory cgroup
> > returned by folio_memcg(), thereby preventing it from being released.
> > 
> > In the current patch, the rcu read lock is employed to safeguard
> > against the release of the memory cgroup in folio_migrate_mapping().
> 
> We usually avoid talking about "patches".
> 
> In __folio_migrate_mapping(), the rcu read lock ...
> 
> > 
> > This serves as a preparatory measure for the reparenting of the
> > LRU pages.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >   mm/migrate.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 5169f9717f606..8bcd588c083ca 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -671,6 +671,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
> >   		struct lruvec *old_lruvec, *new_lruvec;
> >   		struct mem_cgroup *memcg;
> >   
> > +		rcu_read_lock();
> >   		memcg = folio_memcg(folio);
> 
> In general, LGTM
> 
> I wonder, though, whether we should embed that in the ABI.
> 
> Like "lock RCU and get the memcg" in one operation, to the "return memcg 
> and unock rcu" in another operation.
> 
> Something like "start / end" semantics.

The advantage of open-coding this particular one is that 1)
rcu_read_lock() is something the caller could already be
holding/using, implicitly or explicitly; and 2) it's immediately
obvious that this is an atomic section (which was already useful in
spotting a bug in the workingset patch of this series).

"start/end" terminology hides this. "lock" we can't use because it
would suggest binding stability. The only other idea I'd have would be
to spell it all out:

memcg = folio_memcg_rcu_read_lock(folio);
stuff(memcg);
otherstuff();
rcu_read_unlock();

But that might not be worth it. Maybe somebody can think of a better
name. But I'd be hesitant to trade off the obviousness of what's going
on given how simple the locking + access scheme is.

