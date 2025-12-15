Return-Path: <cgroups+bounces-12368-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B29CBFE5B
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 22:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E32A23018422
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 21:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8422B32D0CC;
	Mon, 15 Dec 2025 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="l25U/l6x"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D113254A2
	for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833482; cv=none; b=HDthStGAWtq7A2To78yMZMsEEWSdF0oKe7+0fuZGU0JySAJauFhwJ3fHtuF50TCV4bCQj9X5+W2FdAJ4LmWmFJUY9A4QphND/KqynZgFkyFAi6t+4G0pThzKu0A1CHSS9/STfgj7YW8bd/oZ7rGVB1fpY5EtFByv8yxfVxbvCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833482; c=relaxed/simple;
	bh=CKH+FAAjzoon1OSofCyCce54ZroGwUuCKRL8FMDMFd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmG0elMyqQBhQsUa2QpDvUBuhbJMpxtBv7jo4QXDzD0mSiDHizbR0X5a5IWAUjbIPg8aXBqNcRE9M6axdWv8JILhvMmn9uhZGgygmAQJNsD8qoCTUiH6cipkkijywYEI9/X2tPW00Z0RCezU0MRhYv81gnn32wYZ+8vBQxqRYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=l25U/l6x; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed75832448so52771321cf.2
        for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 13:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1765833477; x=1766438277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQYOTwdjJwYgvuX1nPstCicu4NCv26qFYc5XYhTLu6s=;
        b=l25U/l6xkMdk4avz9x8Qm1HZan+6tmYV9fzTGwToDT7VvTcukRzfL3RR3T3ugQxaWN
         UqBDHXZJpUetn5jyw7oVH1PA5z5xQILInTO6UTFpjXkbUecCC0IJNYM1tzrVXYmQZkMT
         UWsPoHaizF3jjNtYR8yQ8N/ktY7TYQI7VuJEnd8do1jutD6/dvB0xFPLAdukgfSAxwlu
         kF5uY/feeddLCy0nSniBEn2szppCC0+9/qde7ugCzERFX9AtJEEaI6C8s2lVPj1aAEK4
         /htm1tx4FT9aNhby7COhA0DZLz/tFTcMv/j0XjBcTvuJu9O95sBHAEMBWVwlbJ6E8IlF
         G4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765833477; x=1766438277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQYOTwdjJwYgvuX1nPstCicu4NCv26qFYc5XYhTLu6s=;
        b=c0oSq2pZjQp/rZ+AFiHV4SxdtiVIdJ7ktR4Fv9ThXz+hIM7u41Z79A1iJTLbVZYdhY
         usO5GmTGutm6WV5Zd1dIyorpJ6mVxEjqxqQTn5/1k4Zi//pe1iDupB9cTrnzo3VdO1Ka
         3IT3OFkvGkRWKwKo3BWrMEQawYQm+hEU+KggwDwdW6b8iaMyfWBJSYt13Ja5WuG7XESl
         /SH5x51fmiceQtYaPhzTrwMd3ZcRwQBlbu+iI/tnhUvs39rhvytUZEdNo9IfCOvAAkgo
         1KE2bOxMF0TKYUC7XllvU5tyamZ9GpUCXVgyzJCqDmzTvDUXiyq2PFlU0lMVVZsxKEXI
         Ko0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1U+4gA+cq/z+AmNTq5Maf0d8+N8AjCJafUaH8XygzA9fttgPr+zRi69vL8PYXQ4Jv/uCrJHLE@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEzwVUZRg5AUSRk5EHkZtqklmHjG4I+q0UOPpzwJ5krez5uAu
	O/eYDDOKbT+dwJ0+X/tWirpzqCAM/RfU1IV3/GqYPhCU7+uz9aE51+9VwRMlmsyF68k=
X-Gm-Gg: AY/fxX4VmajsPAqWfAbwqFQ8c9nBMJFpzdgnIGaEIeh3gXx6gi9CSruc0f5LQFNEhcO
	ntmsVu1fzEe7xRfpv4y3dGwYpXetNNvhV+P2KHS7ETsqOUQ+ZxZhLoUHZndjMvKU6fV11bYB/eB
	GLmL3gQEfv/vZ+mRW4QCQU75kv6GUgsMttSVBaLOPAkmASsG7KGCsE3U32NUx7xtx1NcGz91Qhp
	9SeU4yDGj8NxLGt5KreVgdSfe0iLZUppoObtpAMaB6gYU6almYN3Ui9tfTOn/93X2/5beWgiOOR
	uHP514bK5Y+nC5h5zA2aJGv94GoHKqGeOUx7zB0eSBrs2DEATuUiLrAslOn6AqV5TgU0oSRdR/8
	DjS4hmdpIb5kS896SdzMcAV8a4LJe2LJbRlIhXlJxFn2mzJSlyFrWraPnLrt2D3tfyE8FF7//Q7
	7lygqjArgb2w==
X-Google-Smtp-Source: AGHT+IExtT3C2ce1bnbMtFFEc4vbTu4xnrtsiKWUFgckjaMMD6DyYbjwCUrjL+1tWyqf3FThMCPBWg==
X-Received: by 2002:a05:622a:4109:b0:4ee:2420:4f7a with SMTP id d75a77b69052e-4f1d047a1aamr167228381cf.2.1765833477067;
        Mon, 15 Dec 2025 13:17:57 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345c2e0ecsm2877711cf.19.2025.12.15.13.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 13:17:55 -0800 (PST)
Date: Mon, 15 Dec 2025 16:17:54 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, corbet@lwn.net,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	lujialin4@huawei.com, zhongjinji@honor.com
Subject: Re: [PATCH -next 4/5] mm/mglru: combine shrink_many into
 shrink_node_memcgs
Message-ID: <20251215211754.GG905277@cmpxchg.org>
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
 <20251209012557.1949239-5-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209012557.1949239-5-chenridong@huaweicloud.com>

On Tue, Dec 09, 2025 at 01:25:56AM +0000, Chen Ridong wrote:
> @@ -5822,6 +5779,12 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  
>  		shrink_one(lruvec, sc);
>  
> +		if (should_abort_scan(lruvec, sc)) {

Can you please rename this and add the jump label check?

		if (lru_gen_enabled() && lru_gen_should_abort_scan())

The majority of the checks in there already happen inside
shrink_node_memcgs() itself. Factoring those out is probably better in
another patch, but no need to burden classic LRU in the meantime.

