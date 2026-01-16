Return-Path: <cgroups+bounces-13266-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5832D2CD84
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 08:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57B3D30245DA
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 07:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6635270540;
	Fri, 16 Jan 2026 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Up1EMB8O"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A0E555
	for <cgroups@vger.kernel.org>; Fri, 16 Jan 2026 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546845; cv=none; b=EU+Cav7etHAwhknGlS+Hoc03g8gpvXjXBQuIink6pvTrtCq6g7iHjYt5XVsQpRVgGGm4FdB/i/3P4Xe0zNcqAnBY4I/Lxwuri0L7yvKhgoGCzkoqadfh4iu1biRgHwhhYtIifTIo/KOcCp5Fvlp0d9MxrNrqu+/lho0bENMECg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546845; c=relaxed/simple;
	bh=dYxTOubKvkA7tWmjuxqaKdwdnW63JufKL+TPAWpNhbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWBrbUQFNYpOFiNrOYSdjKip3bIfDaDVggRMRBofSfw0JbP42obZyGtfAvBcGPIE6nPrM261HO7GEqqdz8M/m9BGPg35bXAUKjXALvU1bu04XioS0AynCkaH1HLVoZWe2qQuA/zUdCUj3QXIvmGXy2OX0dz5ROWia4E61Iq5b18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Up1EMB8O; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f02651fccso48065ad.0
        for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 23:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768546844; x=1769151644; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yjk/HuTCyBmTrKEgW/VvGyUH8+Hoy04Wh+N75d7lrKA=;
        b=Up1EMB8Odo22rD3WeSULo7G+twhz3BY8qdbcCEYbcNFDLrsLRxTLRgb48UIcOVmvUb
         N8C69Frs3qKc0FPO9G6YKzrTh1Qdv/Zh1mwlI+UST13OGWTYEgs0shVXF6XXh5zDWyBa
         5GRP4CDLpQKIVlNf57SpEzAVasMyrzkR7E5bxQIWmL6OBUpTJJHJNDNh04XggWjqX4/a
         mm0qOEK/+1z0cmA8MNDuIu7LqtciWvLQiWuVqY6nRXQgu3+Z4jGOglyYDG6MQp1tjAG3
         rmEQqXfniPwBoUeD9nwwwqsgaCWnZzDowlKNIke01OMw1DtD4X4rsaxrH4IFuJzrrel3
         g4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768546844; x=1769151644;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yjk/HuTCyBmTrKEgW/VvGyUH8+Hoy04Wh+N75d7lrKA=;
        b=jdhF2eu4anF5RhRAIhKV7AiQE25k4yXUD623/Q5y8Pv7RJGNFQ4ie7vasNpSuJsmps
         TgxF0TVbr6wC1RkXE6bkLokIcctBMdnY5yWOUekZKroD4dBIoWct8rF8NsFuKH6nz9gj
         ecVMfvvS6hgc+s8Pt+eS2nKZJsqwgsE8i+KzDEJY3HRXxTx4meiDsGtbvcnztYIS3Phj
         5HqL9aAqMVSEEeTdecnghRuSpNbW+qodttsu0LEEk7bf83QiHtgNuzGBJ8BpnRxrFVs0
         dqbVgjwgAP0NYs+r6ghC5hx5WjaYaCdxNRoint0v1lO0YYHK24BlTqnN2QUcA2Ipiar3
         FhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhWF8Lh8MpUjvQWo92htv7IYgsDQj5I/GrE0jlE8MFbprX+Y/STDVCKLlbMQ1sHrE77zEfFh+7@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBxdH8SI9sNApALE5zPHyX1sXzPR71pZCyTYsUtQt4g07CUpQ
	wdvQ6pD+ac7nWzNb0MjCWEwHZxEq3BpJxb8p4GydsH1gAhbtgBucWeYEHwFHp8QpAg==
X-Gm-Gg: AY/fxX7T+gx4+jwMBXrbc/jliC9rs1GBmB+Q01x+BSm/tFsIZdjaEIWUrPdHg9NA2uv
	9R2LQKISYyQz0pp93bDdXqVYjaWTVbgNW5CE8RS+Xgdk7iLI+IdO7RJC3mvmLbzzI/JT8Z3dp+a
	NxyaHJaVU5th2in2vtad5S1YYw6wxUr2vHqyPgLOe5AdYy3FkRb9cBDjGtZpR6knPPC6XHZ7nhP
	pXcixN7eCek2XWx89OnL3fFtKhk5LxH49yTsQxt+zkiVwRvpmKDVmRwfUvCzCIq5FD4s/7G0Qor
	nAoWT3GLkxEYcScXojfIEnMtTCbhXc5CneODzOhs7I6iqrLxEWm4twcsLhghEEYEyAhS1rd5G+4
	fuUjuLWxvqjVLT35hr3EFMhXdXVWONY0WvFtnTD3FJcpK/hTj7EYvSq6nImu3UTlXggNPzFZIut
	rEFh1xZNqjShCmDoe8BzZrbZQTZ82l/T0SjD0bJy6MmMu4Ab+alw==
X-Received: by 2002:a17:902:ecc9:b0:2a3:ccfa:c41f with SMTP id d9443c01a7336-2a71a96bcf1mr1526965ad.1.1768546843624;
        Thu, 15 Jan 2026 23:00:43 -0800 (PST)
Received: from google.com (130.15.125.34.bc.googleusercontent.com. [34.125.15.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1094e23sm1195803b3a.4.2026.01.15.23.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 23:00:43 -0800 (PST)
Date: Fri, 16 Jan 2026 07:00:37 +0000
From: Bing Jiao <bingjiao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, muchun.song@linux.dev,
	roman.gushchin@linux.dev, tj@kernel.org, longman@redhat.com,
	chenridong@huaweicloud.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v9 0/2] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aWniFUZgiuNEDe9O@google.com>
References: <20260114070053.2446770-1-bingjiao@google.com>
 <20260114205305.2869796-1-bingjiao@google.com>
 <20260115160011.29dca1c262ab1fb887857508@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260115160011.29dca1c262ab1fb887857508@linux-foundation.org>

On Thu, Jan 15, 2026 at 04:00:11PM -0800, Andrew Morton wrote:
> On Wed, 14 Jan 2026 20:53:01 +0000 Bing Jiao <bingjiao@google.com> wrote:
>
> > I’m resubmitting the full refreshed patch series together this time.
> > I just realized it is better to include the unmodified patches alongside
> > the modified ones to ensure compatibility with upstream automated tools
> > and to simplify your review process.
>
> No probs.
>
> [1/2] is cc:stable whereas [2/2] is not.  Ordinarily that means I must
> split the series apart (they take different routes) and often discard
> the [0/n].

Hi Andrew,

Thank you for the explanation. I appreciate the insight into the upstream
process and the time you have taken to review this series. I wish I had
known this earlier so as not to add to your workload.

> In this case I think I'll leave things as-is, so [1/2]'s entry into the
> -stable pipeline will occur a few weeks later.  I don't think the
> problem is serious enough to need super-fast-tracking?
>
> Hopefully this approach means we'll get some Reviewed-bys ;)

I agree that the issue does not require urgent fast-tracking, so leaving
the series as-is for the standard pipeline is appropriate.

Best regards,
Bing

