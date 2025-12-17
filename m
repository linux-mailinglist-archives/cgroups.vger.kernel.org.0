Return-Path: <cgroups+bounces-12453-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11202CC9AE9
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C61FF303271A
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A428CF5E;
	Wed, 17 Dec 2025 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="rzWH+vIA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1182192F4
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766009924; cv=none; b=H0JRmWnKnqobOALLBM5Y/hwN/JOLMDWszPRuCH9OMbMdnNgJ1o6UcGMCNdJity9upBMHYYBMXu8TVNNTBg8xvemWf/iwuICCDZErrvK5uMIQotZ9Moy/5PKXo5+fqolnhdKzrno3jbkHWmHuXPwzNDvet573VbEPhzMNB4M/CmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766009924; c=relaxed/simple;
	bh=NiEiLJCQ3mqiOkwKSwuCbSI5AlhBCxb3t1MXVPq1puQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1aUlZkHUjwIQB9MxAiOVwX9Y2z9pv8HmWdVt2Q4wCGlH/ZvAuyVxjNnfzinzypHN5Jg/OnTYD1Nhq57eDuRqJOrutUFGFLBdiv+d52SIawh98dVbF4SHtuacT3ebjEUAJg4/Gz9epNvG/8OB9gGmq4sl7wsQHnaRe/L4yRw+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=rzWH+vIA; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88267973e5cso1506d6.3
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766009922; x=1766614722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXcbwNkeZlIMBZPQNBardsHsUWb/8fu2HEpQ4xgxp4E=;
        b=rzWH+vIAOF3mCPep39JtSCg3EhNkOO1MzTgmY4/9sxh3wQh8R8xLEfWatxN6hJ61Eb
         50HNdrOKDhoMXd0mgfuo8eFj7oxeTeNx1OVoK4D99bkGMUeLChjSql58uEnYR6yEyYUS
         fWtGM+7qXs7MpTJUdV+o9/ST5ncgxabasa4C56DoA1FAaFk5id2+Jw+CoMqxMF9PBsXz
         hYH3R7DJcQ4/V+/2sArIusbJqPrcEb7omxjQxYqv+TPI9C1NSQR6Ns1NMEt2DA7VD8CG
         WKMpt2Eae4KXwrF2t7ilFVQL+g69HAwKas6M0hJ7fFAkhwVz4X1Mvz9t+fVgXlYUMNq9
         WmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766009922; x=1766614722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXcbwNkeZlIMBZPQNBardsHsUWb/8fu2HEpQ4xgxp4E=;
        b=DKZPzyc4C+bNanteENrz6siWYZORgZCj4PjSmRRMpcWGlc2cKhDzI6M+oh4tXjX8a6
         I+RKWq+RbPKC8KdgXWV/W87eQeQt6bTn/JXH7pJ1qlF0mRxyp5G6eQUMs/WVjDcFZe96
         r7G6+4itl04iJTRbR/mi3Ir8GqdXC5K8BqAtkdYwQpzwCR/lqSd11wenWsdwUuT2+0ti
         VgZD7ukpjSmSK1GZciHxBDAi8Om+f2a0m5vc610cKQ4XMGJbj8rhGHjfWkUBTWE0crZ2
         /GkfZRzKsmR5mdRX6tP9OofYj26eDjn3DB1EU4pD4BD3YIUtp1+4dNC4sDcrsGbnMgRr
         QHgw==
X-Forwarded-Encrypted: i=1; AJvYcCVqN6aK5uikQywfCG9MhQ5BIqnevEKBdjMmXZMHPdhxXJXyiBOTJ5QWo+kBniPbHX5r+tbFuHW6@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzpSNlmb/CG7o+6Zz4mMAjiUqhonH3u/u+VUZfFl6Wtf2oZX9
	umKLoQ/armg2cTDQ5qUhqsFoSeUZUNnoXYB3eA4jK/LnVvN8yS9Kih3jvH6d8VDLmNk=
X-Gm-Gg: AY/fxX4yz0mEbyRMizLx2qOpcjRLtPmaWrQSIcjAaT3RLwxM7jYuYQ4c1PvghlRmw+N
	bxuUgYV6v3qVxYnQ15CoJPW5iD/8HIhXmBR5srHOFEvKez1EhRVgX8tzoHwXFtuvNcRLIQRzCcH
	QjN2485caOlFloIA9FXRn2omHvROMLAnZpOtkM55fuuvANfBUEwfzhJef058O+xh8XPPpzEdrZ2
	dsCUy1K3cW6GnFbNX0n5XWL5AfCnO4ZzLPkWK3f6w50pznT762q27qUcxt5OF327z0/uyTadpgZ
	r8zEowvs65WbVjNJt5q1sNL2Iagocbt2JMdTGl1g3f8OP0dMn3Q/FHCSQTUkqMmShChEW0LA7AQ
	GBuKVB8ReJ2mwQyW+UvSNwFvDZW3K8UAPW2Uz+1hSM3MZ3j8+9blH3y+74I2VVTNPw888tCu3DS
	DJqSnbchxbTQ==
X-Google-Smtp-Source: AGHT+IG1f7aReTFQRW4F2M0CyUDBY2Hjp5SXYzk7s/J18pLYnuhEkDgo3DdJ4s8MQTcbTc1pUU5ITw==
X-Received: by 2002:a0c:edc3:0:b0:884:6f86:e096 with SMTP id 6a1803df08f44-8887e7a0854mr204953976d6.34.1766009921932;
        Wed, 17 Dec 2025 14:18:41 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c6089aecesm4698286d6.32.2025.12.17.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:18:41 -0800 (PST)
Date: Wed, 17 Dec 2025 17:18:40 -0500
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
Subject: Re: [PATCH v2 14/28] mm: mglru: prevent memory cgroup release in
 mglru
Message-ID: <aUMsQPjBtYtVWjwf@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <ab60b720d6aef1069038bc4c52d371fb57eaa6e8.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab60b720d6aef1069038bc4c52d371fb57eaa6e8.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:38PM +0800, Qi Zheng wrote:
> @@ -4242,6 +4244,13 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
>  		}
>  	}
>  
> +	rcu_read_lock();
> +	memcg = folio_memcg(folio);
> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +	max_seq = READ_ONCE((lruvec)->lrugen.max_seq);
> +	gen = lru_gen_from_seq(max_seq);
> +	mm_state = get_mm_state(lruvec);
> +
>  	arch_enter_lazy_mmu_mode();
>  
>  	pte -= (addr - start) / PAGE_SIZE;
> @@ -4282,6 +4291,8 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
>  	if (mm_state && suitable_to_scan(i, young))
>  		update_bloom_filter(mm_state, max_seq, pvmw->pmd);
>  
> +	rcu_read_unlock();
> +
>  	return true;

This seems a bit long to be holding the rcu lock. Maybe do a get and a
put instead?

