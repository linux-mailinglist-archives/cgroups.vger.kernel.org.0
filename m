Return-Path: <cgroups+bounces-12449-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 340A6CC9AB7
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 793C53031356
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C835430FF04;
	Wed, 17 Dec 2025 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="jzRq0+zJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D42FB0B9
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766009341; cv=none; b=NoPj+g8UdouPmDKwQUH8WNnHpazVQuedbdKGcjr0x/ydp7IX21Yt9Qra5GsZ+6MJjtrkxwy/o1U/Bptmac0zFZ2NvnrKhPQqB40m0wV5mroSSNgl2FeLhImcc6mHJxs4AsD8o1Wv1LvBRC1O1pt0e9HySqwPUcYiNqOEXPafimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766009341; c=relaxed/simple;
	bh=og+V/7H/u0x3/LR9s9AEMmQzxjwPnf0hbM8o4nNRneM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFdwSB+CJ3JY2gTJ2GE3w20I/rLlLruC5nCnxRbXsCWh2YEx0FSciT3vuqnJq8YAD6u08s8M7+sUJapIOqCJx5/44hjfB5Mf1/thZTauCUF1oks29bimKv9nnFpbtnrY+MmIAZHpvL/P/ZosIiyi1hdTib+HsUQjtmfSpBYgHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=jzRq0+zJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee1939e70bso62514311cf.3
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766009338; x=1766614138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODhSbrm9G4h/sMUfLLtuWBTsR2lrD1pFRKPaojZng2g=;
        b=jzRq0+zJFOWK+/TrVTiG56bU+RBZFNSxrKYZ6cJTPQAuhDOPP+02fbA0uIzwgjlv4l
         8BcyL8JM2IVXX7CvTATv2YHjNLQbfhJo1nmZ00+d6KfNFaM2q+UR4hnsWN/QaGX5KYoX
         X5O5dHbxlvJm+pnaBR8xD8cAu8dS7UfNgMI6UtXBCQMOsOewPRzuIV9lB7CcM1s0ywVb
         rPcJtxEXYkAZ3TN2NzLPZWWHnBjNc9OZWjkQjNgYzR3O3D4W0WEndZztRvpMI+aQAk7u
         jDPYr6SuYYmNSVlBllQpLjf2gxWQZyJN11zmKXKLj3YGcboKo0UgYwQctZSGTDBia5Y6
         HdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766009338; x=1766614138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODhSbrm9G4h/sMUfLLtuWBTsR2lrD1pFRKPaojZng2g=;
        b=uvXeLf1qsyu9xWvk+ujTapSCRXVCpdXOydz9vDyBFgYd4jTZHJvRaaIuslmxkaBm6y
         XNPX50KLpyFHadA6g07rXEiaU9gKirZSLpjn4IlnSW9O1+nKdyZb9tJNQl8lqYC75/Vg
         wskZ2a3tZ63Ow8S2CnY9RgAqqO/DL5vhLKpZBB9Pf+1XDnKHJD3jVUAIf9MVfS9RJDyb
         7fqzmiJWF7d6hlGdujdvUs/BdXOiPeHlwFFPl+Je+d6+fR8yVK7xtlKeFbMCklNUfW34
         cgWPDYtrTNLcLrc2/9ODYN7jvbTBC7WhD/MwDX4thoqBSw3VoOAxJcQfdORPY5VfBivr
         Autg==
X-Forwarded-Encrypted: i=1; AJvYcCX2OZ6RJjL2IZNL0iePkqiMMMT3JzpJagGHBA9yu4ifQ6ZFhv3RlRxyrLLiz9kjwYRi0GVtwzpv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjeegmw0YhcF5R/dJFmg52CSoItkoSJDMXkFmKISfKCTEW9yW3
	39C4D42D1sTjrDSVyqUK5chvnE+YYqAx5xJBD22GjOgu9mA5vGVwefPFgbh4u8IqqWo=
X-Gm-Gg: AY/fxX7k8TunFSq7L2pPszbcx+RvP/HnFJ3Ce0JfXawy/65Spcx19zZ9baKhK1qzNVs
	LXFrssCWodMsKB6OMItFTpAFND8Ur2a44YxeiYpEErxoixpxUQDWCLwL/nCoZSNEm+nYzFNAZ42
	u9s28HGxxyBlMBFCrgioJY/qWtjBSQ8HcJFRw4zlMTZGnHIpfUDVrWqQVQyOzoi36qmBc3tJ6Zw
	E4w3c6xc/8iQCtkmr3A+XoBMgZxp+auV6ypNyEBVQh1+W0f7fgdEEaC3JOWZ1m7H59ebFCcB3sw
	1wfqFFjMXJZ754c9756ln/fHpAZNWfefZ9AXfC8gnmp0lDcQ7jsRLC5xCStbsu2y+Co1ZSn5cQQ
	XZKUvuI9nABU6Zyh9JrHjhzZz0LXeIyKK3QLMhnGZcK7mpORNzKOLycF2It+tvq4eO+oJRGicfl
	w6L63ZbNENoQ==
X-Google-Smtp-Source: AGHT+IF7SO/j32cChYhjgU4Xs4tkHZwOZcvwBvu3/hWlB9NueOn9g2ZOSd1HB0YjPfIoqoeb3McUwg==
X-Received: by 2002:a05:622a:4a89:b0:4ee:1962:dd46 with SMTP id d75a77b69052e-4f1d06320b4mr293520131cf.79.1766009338015;
        Wed, 17 Dec 2025 14:08:58 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c616751b1sm4256836d6.54.2025.12.17.14.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:08:57 -0800 (PST)
Date: Wed, 17 Dec 2025 17:08:53 -0500
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
Subject: Re: [PATCH v2 10/28] writeback: prevent memory cgroup release in
 writeback module
Message-ID: <aUMp9cXFGMwgj8Pn@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <d2863fabba49a16572a84163e42cbce64aee27c9.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2863fabba49a16572a84163e42cbce64aee27c9.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:34PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the function get_mem_cgroup_css_from_folio()
> and the rcu read lock are employed to safeguard against the release
> of the memory cgroup.
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Looks sane to me.

The roo_mem_cgroup handling in get_mem_cgroup_css_from_folio() is
unusual - usually we do NULL for mem_cgroup_disabled(). But that's a
quirk you're inheriting from the existing writeback code.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

