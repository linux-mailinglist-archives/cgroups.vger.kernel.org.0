Return-Path: <cgroups+bounces-6227-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796DDA1550C
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 17:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE3C1881E18
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C598719F13B;
	Fri, 17 Jan 2025 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="IaJ+JOkD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697D198822
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132980; cv=none; b=DImtpivFn7+VkWSochYa9E1t8Dr/2byIqqkXZPj8Z2sGHiNNMAY0cLxWLcYKuYdPk75Bod0ZCpYnUo8k+aQQBMntA/+9+mQbBlsdlmtK+/g5wPKNDIAQuIHpPJ56/rx8kj+m5GDBGH8tIaAwZUVliamUzdQWfg8lzyTBNTOxa9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132980; c=relaxed/simple;
	bh=EcKTRL8JXgL6MYjimVIRKmKtsAaC6f8InOAt5ItXdT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+9oQafZvcMIP3n3aaNnazTVvFadNcVpDBOmwFjooZVXhKyVxIEWpXNB9WYY+m9sZGmtzN++Fptc5LKIlNX5vPAiMnwI9KrSakgsiSsjMi+3+2Yv4MlSaHFLOAJQ46W98fIsd5lYhd+l7d2hZpqWvGN9HQrTmH7mrjIAPPcc2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=IaJ+JOkD; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6f1b54dc3so386040485a.1
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737132977; x=1737737777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghbAvzlR6mk62PxWv6MFBehOgd27WJTfHwfhEljUO9k=;
        b=IaJ+JOkDYEkZk209bzt1Zvv8u2V1Ys28Vu4hUAnF6+hwcIJL/ArR3AL3I9wAOWSgWo
         Eg6NZ9gnu/0s7PWPNuAU6zHcgYlYS8g1VIa1VS5pkTUvjkuOqzoSTTusJw2ELSpXYiJC
         NmcslDfp6HD7wkDmOD+oLNFlwYsVON1YhqgwYWFeSOuwrhfq3M0OnoCy9+DmSM0hJ6XI
         R6DxNpIjne4ZE2vTh3y73UQb1f/03+vjw8D8eWx8acBt0pMRgjdgxtWOEm1MLORzWPIF
         cBmmqfIquJHrXgY+vcIfYGArYmJ+ZUKsRntb6DE869SKg527sM8QWlIewH4uzuYV37Q0
         kpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132977; x=1737737777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghbAvzlR6mk62PxWv6MFBehOgd27WJTfHwfhEljUO9k=;
        b=pa+CXoUuNm8VWL/tN2OdwENf7e7VeLhXMMJCq1IyTOHEW5I+9AgPuSh6oeGFcsQtkm
         Y3gejxehZgxInsdw8lzWTJu7bj3JzrC2pi4tuAWTMfobCrFOcx4OlrdtAZrOkbu7htZ3
         zqPE63ggS/kJ1cfsiAeVP0+kFNKWtz2HjzyrATOQRqNXmKWrjiCgcKJ8LKNKOjweOGza
         OV2p0/2CgLuoe2gNPeFU1sLPfPaGGDhPZFtWBU3/J5nkO3dWdJb46IXkaJ/KvaI0YtwA
         PujLgZVPHkT5d95GU0dmROtSdH98IkqsZJ4d28iAOciTHzBXjtYylCQ7xaVFkqwlDPl7
         N1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvWtfedD8ThnWqkvO9QLagB7FZV3m+wmlXBrcqfgXdShbYJtwYVwuH44t1VkEimXw4CKbAzm+A@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+as+j91eDpdZzvP0QKqAG5uOg4JuFa1GIUWZ7mtwPC1RsPhxg
	LxIhURKou6jNqJeN38Kr20ClkpQLQWqVW07UyWKdDo7JYlNgkNIEpruT7f6grjE=
X-Gm-Gg: ASbGncut64rsTT2qbsO4i9pmCeLqOlgdHtAH/WuWCg1LO0P81OZw9yFhdcZlTcI5o39
	bDpPuD3qFXTnTXe0z1ZC0jK2ze7FY4e5lhFAFIEFpmj8S/no4Pl3UdJaQUPzScIdymMrxFbbvKw
	O57n5NP9yoWu7CSa9s2TCQ2rvvvs6UpnxueOKrT/TWcUtL3pKuY4sfXoYK/o0PfZJsxH2FmXvvq
	Rspclz1Lpi9n0Lsvs4pACOBWRZTXGk4AXKS06gLEhnigXdY0tqsmJo=
X-Google-Smtp-Source: AGHT+IGlnTKX/0q5IbCtm50o6MEMkk7zw+6qINZ8d+hjttdZmOyoqXGdPKCXxLM1GFu2wStmxZ0MTw==
X-Received: by 2002:a05:620a:4142:b0:7b6:6e59:2864 with SMTP id af79cd13be357-7be6324fc1cmr571824785a.43.1737132976849;
        Fri, 17 Jan 2025 08:56:16 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:f0c4:bf28:3737:7c34])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e1afc33cacsm12950386d6.66.2025.01.17.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:56:15 -0800 (PST)
Date: Fri, 17 Jan 2025 11:56:15 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, yosryahmed@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH v3 next 4/5] memcg: factor out
 stat(event)/stat_local(event_local) reading functions
Message-ID: <20250117165615.GF182896@cmpxchg.org>
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
 <20250117014645.1673127-5-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117014645.1673127-5-chenridong@huaweicloud.com>

On Fri, Jan 17, 2025 at 01:46:44AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The only difference between 'lruvec_page_state' and
> 'lruvec_page_state_local' is that they read 'state' and 'state_local',
> respectively. Factor out an inner functions to make the code more concise.
> Do the same for reading 'memcg_page_stat' and 'memcg_events'.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

bool parameters make for poor readability at the callsites :(

With the next patch moving most of the duplication to memcontrol-v1.c,
I think it's probably not worth refactoring this.

