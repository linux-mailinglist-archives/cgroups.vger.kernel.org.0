Return-Path: <cgroups+bounces-12332-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D888CCB4956
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 03:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F0123016DDA
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 02:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379372BD01B;
	Thu, 11 Dec 2025 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="uhBougWh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443E15B998
	for <cgroups@vger.kernel.org>; Thu, 11 Dec 2025 02:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765421906; cv=none; b=P3APM3aS9lad6kyrS43h4lGZHwphXvkXItCvV8zPPYhwjNhJDqbmv3Pr1+BmeWCWMfrzSEiqJghgJRZNEL8ZBOJpfW3+s/H8jEUx9J/TBCtjZQP9dORF11eHPnX+1Lxu2YOpOo+lYOmNe7TG9O7BEMfTKzHcWr2OMtelA/AdIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765421906; c=relaxed/simple;
	bh=TDCP8jSTjqvfR2lbb+PqyLvPxdA+5/VnBnQRxLoH4ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZbeEP+maHqaRFR5yE9zwHd8DZ1ijS+HX9sFbzEk9PeHBhoTiY6dKzTp1I/lQPB7qozW9L0pu5ZFIelmggg1y9t1IdQX/ytVVLCjpnmgkVVoiWbz/q22kyLIDwg+vZwNrz2Gj5Af8nnQO5LI7S/MuIa27036UlfJGgIsZt/orQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=uhBougWh; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b9d2e33e2dso75166685a.3
        for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 18:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1765421903; x=1766026703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LfuhWoMqWAloJULoKj1IudIPQc7ilfqshnWS+4Dsvw=;
        b=uhBougWhGOJ1gplNd8NKYu/zvBOqeKdvkU3dmzOKc7AI8G0MvfciMa6tiofYel1N7n
         20DX16fMDdDsk9yiNGhvLQ59lz8LlkVRCMtD8LkwkC8jY7uF/E3jkE2HOzVE8PjJprPd
         QTpDMVOBharrVm4Ppfp2w28o6XdxCYU615yM286YIF3TZ6m/eeM8g4tiJB8ebMfXBy5I
         2Ch19EO5SIu1STT5Kkei0hBpCrTq8KbvQAyboSxLDdEHaNC9KNY8sGQsuVI0e2i8mNKs
         1ZxZDp02wdNy6lsBMn7fXxQkz/3+5pWXDt4ouxsYfunNOC9KqbK2VAWkz+i4nog4yVr9
         pVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765421903; x=1766026703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LfuhWoMqWAloJULoKj1IudIPQc7ilfqshnWS+4Dsvw=;
        b=oR/F/IU+TrrIcEdmJpevru1gMyKXShvzBzDm0fw4x1NvwBmC899Ajg2DO6LpyYVPFy
         XM8LGkts0Em/I3TcUDhzikzeFhdUhN4sBI45gUXCJEslsK4Xydudgb1UEmidZ2lvwN4K
         JoSeVhCoap0Yelr2+NbqhFYwgSB7hLHg6jJndwGqNYjhpLU5KMTF3ILOLY3UVreBc54L
         wZ836qNA/039ujRw3LGx3EyxYGX6rulOc1bIxZLhVVUM7ftWB+SNFID7x93bOJONYAmu
         9X7vE7rMUr5VOepFf19ijfayJ2e2NVeempETXpCGJitIDRISjndTJhW3NAxeoDy4NQWn
         58DA==
X-Forwarded-Encrypted: i=1; AJvYcCXPMogTo2/0OOyS+lPWAbxYQOtNX8+/bpHdfVg+Joq4vPEKx7Q39nA4X9NVrusqPCSAs3gU1GIh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5r54QtYEitmJ6kHeq+Ssfx20AV7EC/338pXTErmub7LcvRv1
	TuQejnu+bHcMDE535NSmjzn0qnUDRUI2Ev43/55Wa8Kl7JSTUDxDpYjjB1VjaV2L01k=
X-Gm-Gg: ASbGncupH8uUaIfTmRieoRFEUESJ0Pb1Udoo6uEa4P0KXhyKtVj1RlNI9z2ef9WeSH6
	2VLUR1D0TI0ujN6m8GfgnmsxFNm7y4BmNlxKhhqbATOQEvlnUpuAYL6HVYNbZiktWxBvoO2ntJP
	LqueucnL2gqbg1H1m3uIpAwNq/othurWaNdOE1bofCPhZEL04eSoqiLPL27izQ+TiN7luVfFhfR
	n3c9AkWrg66EMHShwcq106kbtv4kDqjN9m4US4zmxNwuYheDA4Q3VJ0CvX8YUas/alFPagbC2hq
	s4hsy9lfFzOnql5IKfEvKG6mJ3pvLPkJnBjO1OEKvjj7MXFLL0j3AgwlZ0fG6H4Wmi69YfPtbtQ
	M4us+dvtKgmGN8vEgbtAiIRilbC6QP8dPOZ8AGu7qk655rmEkFoVk4RfMHcg6EdPEX+6rT6wO0x
	5SUQDcjIae2EokvRRoI+/G
X-Google-Smtp-Source: AGHT+IFoXwBG0n5fP0BNrUvena3y71ni22tWG0aSIY3lZQj1Rng9OU7AuijjB7Oixr4MMXI+LjJMQg==
X-Received: by 2002:a05:620a:2a11:b0:84a:71fc:a16a with SMTP id af79cd13be357-8ba39d46b56mr689168385a.37.1765421903169;
        Wed, 10 Dec 2025 18:58:23 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab47f6f15sm113968985a.0.2025.12.10.18.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 18:58:22 -0800 (PST)
Date: Wed, 10 Dec 2025 21:58:21 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH -next v3 2/2] memcg: remove mem_cgroup_size()
Message-ID: <20251211025821.GC643576@cmpxchg.org>
References: <20251211013019.2080004-1-chenridong@huaweicloud.com>
 <20251211013019.2080004-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211013019.2080004-3-chenridong@huaweicloud.com>

On Thu, Dec 11, 2025 at 01:30:19AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The mem_cgroup_size helper is used only in apply_proportional_protection
> to read the current memory usage. Its semantics are unclear and
> inconsistent with other sites, which directly call page_counter_read for
> the same purpose.
> 
> Remove this helper and get its usage via mem_cgroup_protection for
> clarity. Additionally, rename the local variable 'cgroup_size' to 'usage'
> to better reflect its meaning.
> 
> No functional changes intended.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

