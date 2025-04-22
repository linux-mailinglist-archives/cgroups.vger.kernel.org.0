Return-Path: <cgroups+bounces-7729-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFABBA973C9
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 19:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749B34019E0
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 17:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F721DA63D;
	Tue, 22 Apr 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="gGi1je5z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9E1D5ADE
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343666; cv=none; b=UHfm8EmPNIZCyqeP0/zXv0Fn4SPW7JV9AU0mzCz8cvonfwmP80snALW7IGcGzyPrJLhaTkboF9p/ddFsSWaXxKIvcrCQFcXaiU3ykxBU4FocBKEzC38EbcU0SGdkbL62fp861VOAktnFzJRbeoDrF90jPw4bZS9GYL9TLz7JBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343666; c=relaxed/simple;
	bh=sx+1yReHO+W8k5rUqkhkwfBciKZlCEEc04tBXhlIWQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5Z59bKMue50brOEzlPjgm/Hi0WZR9aEJooJCqug3peQh1PSZTWcS2JtQ7HVSIYpSMv7vL6YSuXOuyCL62AB+3r/XGjgBDaZ0JLfIgHNodObRU50Ws3/d16thwrGkQJhwX2jXLLi0mWL+TXaDcjcbqPE5QSdK3Iv+CeWXuy0GOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=gGi1je5z; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c922734cc2so13795285a.1
        for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1745343664; x=1745948464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y86Jn/i/gOfC+tYxi13fILx4oUL1euxGqHwTbq1fZ+s=;
        b=gGi1je5zuwUFkZ2oBYqu8RQpeXIYC3bs0CQsKHxgLv2ajeITLh3wuyS1t7HH5xdMbp
         FZ8/QBgDrBuP3R8WnuXR6+4wNoHji9jZwQxZcKihCoFnkBwAlWHpQLnAAAVYhI4e7Ut3
         h+qZZlkdNOViLbbevv9uYeusVydabeIO5jw/4LBgxd43FRt4Wt6fOLWRoy++MsK/AnTv
         peiueoSFHw5plJvZgn7mfaqZ7ASCncdtldB5fZSt9I1DITDIHR24aSi0xZ0KvkhLTjIp
         1Bm/DCVs6QtnFko9jdARufuSGtw/ZpzwZPCtWw7aR/6LTbE7yHYXVVMYrkUfnXsh2TaN
         9vGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745343664; x=1745948464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y86Jn/i/gOfC+tYxi13fILx4oUL1euxGqHwTbq1fZ+s=;
        b=Jz/yLtHJRvmYbqAsqG/me+SU9PXLNyBNdDE4NiGEaGWxcjSlo0tpRpw+xsmXLd9fV7
         2PdsPpinga+25Ht+Z1BWeJ7hkY1tFyHONGuPqwWD7i+OlSXEjwJXSr9+qIyYecuG+I4p
         i+GvF8j+QlITZTRLjOcDmnT+A6UGAKJO7jz/75The5FwLLEFfrgeYXVVm22yL+zTzDIO
         v3pk5Esm8JKj1H7n3ooqPdKMkiNA4T258EKjVo0SICyJC9o+r37yTz6T9oNwfmMn2nF+
         SyywAIhR03NjMpSdT9pl5Azycqkf7g2hN9VM1m/K3fJONDb1wIvRyoDyaDiStC1ksRlX
         1rCA==
X-Forwarded-Encrypted: i=1; AJvYcCVUrINESnY/hzUdaXjUaZ/vChBfDdawP1UXYM/+IAShd7GLnVlPai6Y1kkNY8dvP5qgDPgCMfsK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4mr0XC7cqWpGVCXjR1BMaLgSXRO2ysoyTHV4ZIMU4ic5vhrbb
	jQBbXZ7ezS8RDzm6Up3Ig9f/9zuZxH43Pq6jKxiwNl0A4q5bMyjZsjnHC00+sIk=
X-Gm-Gg: ASbGncu3J41i96nzJSpnz6Wg/vGGc6zXycwBDOxOkbodnRkNVqSavi5kkhmeeEiUzCU
	VR3i3liRWrGxw4G9AU5I/6D5u8f8hPdEB5IpxXLWuxb7TzyIM9QuwJmZWLikb7szwYnzOzy2dJ7
	ZWa1WrqdBuC3pjj17jxfs5L895cKOzMH95KljE2rOKRF7NCQmyRLnTnVtowYB83JItWLX3B5JaD
	xTMm9ppbpaPDX6PlbibUesxhmoFte6hO8Vc3JIXHjYzHH/x1G4JvFlNwgm8GY1C+E3dz4w3b+vF
	uNGVcwwllY1cku/NdfLCWTo0XLQqd5rXDOtz740=
X-Google-Smtp-Source: AGHT+IEN8+MrZpC1+kXZmyR3wN+NOc72lunYbPsIFQ9LMphGMyp510ZIpiR9wy3Isrz4BHUP8lx02w==
X-Received: by 2002:a05:620a:4256:b0:7c4:c38a:ca24 with SMTP id af79cd13be357-7c92827487emr2492780485a.1.1745343663928;
        Tue, 22 Apr 2025 10:41:03 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c925a8d484sm580566085a.31.2025.04.22.10.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 10:41:03 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:41:02 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v4 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <20250422174102.GC1853@cmpxchg.org>
References: <20250422012616.1883287-1-gourry@gourry.net>
 <20250422012616.1883287-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422012616.1883287-3-gourry@gourry.net>

On Mon, Apr 21, 2025 at 09:26:15PM -0400, Gregory Price wrote:
> It is possible for a reclaimer to cause demotions of an lruvec belonging
> to a cgroup with cpuset.mems set to exclude some nodes. Attempt to apply
> this limitation based on the lruvec's memcg and prevent demotion.
> 
> Notably, this may still allow demotion of shared libraries or any memory
> first instantiated in another cgroup. This means cpusets still cannot
> cannot guarantee complete isolation when demotion is enabled, and the
> docs have been updated to reflect this.
> 
> This is useful for isolating workloads on a multi-tenant system from
> certain classes of memory more consistently - with the noted exceptions.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>

With the rcu lock removal from the follow-up fixlet,

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

