Return-Path: <cgroups+bounces-12509-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB42CCC188
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 14:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E933303A82E
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3976339713;
	Thu, 18 Dec 2025 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="mMpeTU+o"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978883358CE
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065554; cv=none; b=ge7gEunv8arBRPq5sDfZw+O1BOuP8AHNk1+0ZI9b4ugrFgz7A8Gv6YLYHfz9RF7gj4lmTDR1n2ScrX0yvNj0/+O8y0LcGn24TuysG71yY7hqgUpQdyAc3cz0Yee0KJdNaZJuYsqhugk0JMUhoSjbl38hokG8EpeGuhkgQ5P2X7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065554; c=relaxed/simple;
	bh=1lcHYZLIEywXGzhjdYArWAPhpkkoaX7i0+X/MDQj6nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMnts1aGRnQ3qaL03VP7QgFRmhXrDdtoe/ueGFrqf0KXXbCJAy7eDi4WwiutF8+wUpX/lrb/Upc/xpxNx6RkU33Of2PpuyFEbCNdVdeGQ1d2l9imMmXal7qhAQu9GkO2FUj1wxSVL/xq6c/tnmqZZm+rUZIgjO+GK4E37e+Ri2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=mMpeTU+o; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b1e54aefc5so54379285a.1
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 05:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766065549; x=1766670349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvIGD3XhABoeshtW2+k0QV9MFWwD4zZ6lmu7IG4CN2c=;
        b=mMpeTU+oqP88tbl+YFMQsvDFdctzgoqYgzHSXXBTN1TH+SKYndrcrsnao7olp2Jx1P
         pgEfynT20tL5laQJibLNgMeO78czSqyGlC3lo72j6Otj2jIRAqo61as5/+R+n/0enHfQ
         yR/jciVX74yDERGv4d+R1Q6l76ZhqGJvlz70XY6JmjhbpBlwv1vT20JhKJ/9p6lYPLl1
         8ntAOoTO0Qef26civyE8QPhepTim7ZbAweLei0sTk5r4LBgYaGFlss08x/v3jzNyVU2b
         pYhcNaLloxnaV4MohARtICCS+nMyOMx3DDINaRiICRGFzenRP2j1OoH5Fu0Q033hSfMs
         0boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766065549; x=1766670349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvIGD3XhABoeshtW2+k0QV9MFWwD4zZ6lmu7IG4CN2c=;
        b=VXZXE/XE6NMnRPne95gzfF571G5aCZ31Wkke+UO7wchcbr7LZYzA3KzOJdl74Ef9YD
         43ygZIqTOWQlNJDf7gLtkZP/YCqCaVizQI9uqb0TEBnVNf9gNj2Pr6npcAI4R8oRyHJ5
         7rCgdI/cCpO9VkhYxxWhUlP4DC8o8OUPB3hmua13c0cs7ojACvj8q7qUkMUvBZm9n6to
         NSTk2tTDXiRabrV3agdTBcAfttQW/LvObi0SDNMApq6Q9Nc97HSBdoQipiaBDUWHQVgt
         0zV217rdYu5z//rBdIUZIy2WpaqvkmdenoVQSE3DOPnbWSfXY9M7hIK42VPb/lzMtLDu
         Uqnw==
X-Forwarded-Encrypted: i=1; AJvYcCX0Dx3VI8uWSyQirQpgc2bt9p8mHsn4m511a6xLxuvYPz44yqH74ggFUGxrDPj34nEG2z6/1hQi@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHdABZPOmFdtg/wm6J+YLiYcWs0Cw1jXQXUYFUOcGK+/lRD6D
	uPs2+JYhBQe0R4o6sZUshhCyBhybZ4+M4OsmWsvls2ymtkrgXbNHJLh5dWRRVYU1wsE=
X-Gm-Gg: AY/fxX5QouYQvgenrl0ajpI0418lg+loHbyaQGNYsVZ1HoL5KCTshCv5bblH2EK3+OV
	DiSsuP2cuxQ+tvbPS3z5h/Pj3jvmhZILlEiIp14E5Zd+zzUJrczFopNTiKxi+NW1fxwygBZo28q
	h94/hzDiT+Ihb9gd4tRXSsN7giHHdHfhk6CybghwVCKVl2FCs0ecwgdO77CU377J7qmckXn2TJl
	UfC8G8H06THZOtnY6DZt5KdW/ckUZ16Tji5fzmpOOqm4RutyShY4uVm9cegM19QjofR01IjRam6
	2rbhG945NfXkFHglB78DgxAcRkLUDVPQTHg21pN6yHuF9TIaObXKrnarDVy33VTnnEpvVv84OMC
	UeGnpc5mVqUPFAomg+r896g0lUZ9Hh/nlTMGWu5TXXxs2LwGEJYrnClPWoj6yMWWEfG3GzZ/S7K
	FXi7mNP1ENCg==
X-Google-Smtp-Source: AGHT+IHAR30jxVI+lBEnXpDkahfpDPcr5qT9JVMfZp+S17qgX37B1fvWEalT5dou0/zVepFQknr8zw==
X-Received: by 2002:a05:622a:1e94:b0:4f3:4415:e8f4 with SMTP id d75a77b69052e-4f34415eae2mr141964871cf.38.1766065549231;
        Thu, 18 Dec 2025 05:45:49 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f35fd60192sm15091761cf.19.2025.12.18.05.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:45:48 -0800 (PST)
Date: Thu, 18 Dec 2025 08:45:44 -0500
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 26/28] mm: memcontrol: refactor memcg_reparent_objcgs()
Message-ID: <aUQFiFIsvSez8AAP@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <8e4dff3139390fc0f18546a770d2b35c9c148b8b.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e4dff3139390fc0f18546a770d2b35c9c148b8b.1765956026.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:50PM +0800, Qi Zheng wrote:
> +static void memcg_reparent_objcgs(struct mem_cgroup *src)
> +{
> +	struct obj_cgroup *objcg = rcu_dereference_protected(src->objcg, true);
> +	struct mem_cgroup *dst = parent_mem_cgroup(src);
> +
> +	reparent_locks(src, dst);
> +
> +	__memcg_reparent_objcgs(src, dst);

Please have __memcg_reparent_objcgs() return the dead objcg for the
percpu_ref_kill(), instead of doing the deref twice.

And please use @child, @parent (or @memcg, @parent) throughout instead
of @src and @dst.

> +
> +	reparent_unlocks(src, dst);
>  
>  	percpu_ref_kill(&objcg->refcnt);

With that,

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

