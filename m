Return-Path: <cgroups+bounces-12444-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0166CC98F7
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 746933013721
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A7530EF83;
	Wed, 17 Dec 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="VxJVgkxL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD313A86C
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766006029; cv=none; b=kbh+tN3CtA2nQb9tGRo7odqoO2DevhDyboeN8aE0Kiiw3RnFCoeLS+kxQQ25T+aFQ3K7pn2RDZSxPybzXzefcdXG/3qrDVfAFvitqOaH4y3jDBnHO3CccX+RZRJA4D9lJnnVg+6I1UaMcgnWGU87cgmi22ssnuMgAf6OYjEDVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766006029; c=relaxed/simple;
	bh=2gTEpwwZsnFbkTdUuykdfyFFKchQrX707OS2a5hGbgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYYy9UVVjayIECRnZZBAu/7WjnLT3A1SOBOQKkpxcJR3b1BInAeD8+FGISvwiGnxY1LvHRU9q80zQg3iAbqKuHzeIayfjHaeGyWfr6mydFPAmw5mIH3uv1wfU1V1WaO7L2va0g4gaMvI1KczK3FYDOLmZZix6Q5wyimzswYVCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=VxJVgkxL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b25ed53fcbso895343385a.0
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 13:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766006026; x=1766610826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtGb0r/P6zEZ8trF9hUpub5gtg16/YJkxY5mix/dDUM=;
        b=VxJVgkxLxOWW3G5FrWPkgkKxyg71F7+5deRnJ+eI7htFdVBlLt0Ixx6BGSWkckqbdv
         kf7HnvTZalo1CfJPCEDa6q00F7GJTHD+qFBAM+OOvDUZX2DmakyfBDfT+aTbNUN1C07U
         y3waxGnSr3uOHRKIxWABXokUg5z1sTkHs1d1PxkJwg0gl3CNotoTFsRd/DaVY1WQA3FG
         YYLfAhTWuhowSYP2OwSBHh61LjQRPtiOLZHaFq6/EW38yGb1HzStsx4azknZzm5ZnofQ
         A+umecUSyp9v3iGpu2YqXLEFG1yG93RhTutjU1WY8kUS8FlaHXNDEhIBwzERPFAMnn1H
         lTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766006026; x=1766610826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtGb0r/P6zEZ8trF9hUpub5gtg16/YJkxY5mix/dDUM=;
        b=CZwEYx+A0g9jx7R5S4GKqpWaX17sWP/jGPQGAmU0rr3E3fNVSlQFvA1fjPF/YPcVHk
         RuXtVpDdK4FQeWoroNpoFx+r8TCdhSsbUMqEgZpGF1Pl52qVmalJMzunm7J/E6OKvzDi
         +BoMId8eqQSHLwufGfc+9Kh/557NzIQt270Zd+Fr82b8s6ikbgJhYuH8pqe/kWhZg1I2
         rhynBAozV9Pok7OZYqe5jj2YwP8ATH+CRL/HrExxwg6oy9VpRR7jtO9fgTLjXmaDLPOn
         pUBkyHYgGaVCE3nWjr04a/Qg846L6fIPAvOpinAT20D9BMbAJ7qfbv5gwPIWJ6tnhrJc
         zNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4ok4v14y7vS1zlGMf3cqdOXslmkyCmbyngozFvzFmOYjEN1mT6Y+eziVr18H+u0bkZfzVOCjw@vger.kernel.org
X-Gm-Message-State: AOJu0YymC4+++nydOgevBTGYEvegFUTsTnplU3dMX8+5Wg4gGq/g3pgd
	8jYSj1RyMSMiot8rQNWeyqZaysQiqjmuZ8KnQC19C7knSugBYx1x2iYX3D5Y0Z7JORA=
X-Gm-Gg: AY/fxX7Aw1u38Du7k0cKBb3N1pZHNn0CqljBKVPYSeesaYcKIy8kuAantV2+c8qWj4/
	hynE6v8NFBnyrIEAEsba63hD8WuGmN17qJP99izXRr6VxW4FrTSzULozwfyCQBf6qy2kSBDNVU+
	z4DcKEzDWk0JlE6V/etT2p8qqDva/mzMG6AJ5wIv1SOxwiKInIXG4jKf5tu5oyHErojftn5z56y
	vjNv1qiFzQIPFw90XAo5UmASGphEgh/d0c20iAPLW09DjZODwmeWdWQrzS/RfClt1aTYxselwsc
	hVtjbGScVePiLprpfnqV0J2sxVcOjJJR/jDQMKtd/v6JyTyvkvMRTwvdmXXE+WuGJ/Q7YtF4kn5
	Rpj6cNkG8jaCR2LbTNT7bQOjPYfWLRBBYW9Nz49woNB3xh5kp6GYdxqKjBsnpQoifCHl77mawN+
	KilJ/rAvbKyw==
X-Google-Smtp-Source: AGHT+IET4L1o4h7gpr31cJq/0Bv9h1gq6eO5+hWYnncruBpcH76SMVyfZw1AptOE09FasXWhGUSOKg==
X-Received: by 2002:a05:620a:4116:b0:8b2:e402:20b4 with SMTP id af79cd13be357-8bb398d914bmr2946405485a.10.1766006026195;
        Wed, 17 Dec 2025 13:13:46 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beeb6e987asm28540285a.22.2025.12.17.13.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 13:13:45 -0800 (PST)
Date: Wed, 17 Dec 2025 16:13:44 -0500
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
Subject: Re: [PATCH v2 04/28] mm: vmscan: prepare for the refactoring the
 move_folios_to_lru()
Message-ID: <aUMdCIr9-rLrQi0X@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4a7ca63e3d872b7e4d117cf4e2696486772facb6.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a7ca63e3d872b7e4d117cf4e2696486772facb6.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:28PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> After refactoring the move_folios_to_lru(), its caller no longer needs to
> hold the lruvec lock, the disabling IRQ is only for __count_vm_events()
> and __mod_node_page_state().
> 
> On the PREEMPT_RT kernel, the local_irq_disable() cannot be used. To
> avoid using local_irq_disable() and reduce the critical section of
> disabling IRQ, make all callers of move_folios_to_lru() use IRQ-safed
> count_vm_events() and mod_node_page_state().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

