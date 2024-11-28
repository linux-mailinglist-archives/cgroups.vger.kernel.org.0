Return-Path: <cgroups+bounces-5711-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C0F9DBD31
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 22:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A663B218D5
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 21:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BC21C1F06;
	Thu, 28 Nov 2024 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Wgr4rUYB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A61537F8
	for <cgroups@vger.kernel.org>; Thu, 28 Nov 2024 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732828339; cv=none; b=PlfX8pd2Gq1gMJDAtYJOSguqzc5Rtb82VBRluia3uT5QwD0Q0GXf3HVp+nJ31HJKSDVxd1t1mZzIcqpYptGtq9JL1Rc0eesCuUWR8Xy8pSVyk58TEeXqIWvvbPEjiIAEu9E/QaVaDG/pEuWzDMjFLsZklK+S84UqdcrYhVv3uf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732828339; c=relaxed/simple;
	bh=SNH6Vhy1Qsz73JYqfCuZ2bp8yHxqGV6IJ9piA+m/bZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9zDQXkWSpJGuy8uiuyqmPCLfE3FPQleClvpGLgGFkIeCL1/L1J3pSwoITNcjPY5PLZ1zHhmj5FnPOWX2FImj2fFzh3H1nGBD02WN0RpKqHNk8u+5yP0uq16Jwn5vLrWyhxzEz4L0Suq6MXH4ACazOlus4Ggrl7twIqP29i7X/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Wgr4rUYB; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fbd70f79f2so1065758a12.2
        for <cgroups@vger.kernel.org>; Thu, 28 Nov 2024 13:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732828337; x=1733433137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZQjgHCOdKGOLIMC8jx2ghuoSXfBYmvpjKyrW4dIslk=;
        b=Wgr4rUYBuV/V9lT8TlgAYppw3jyi8xptn2CAfFNIu+7EEwzDQtMTGvKbIcuM3VKWrr
         SG84y6AGJRIycUXDyVIuYRq37auNIPbudXiDe90vmIh0LfSC8w8eyar+23/AA2NBk08r
         3VWrKV/wT4EwWIeGADnDN0++k8iD75Y9ankmydg2rd/bIO8rQ53OA8jjfxj03WEgu6Al
         vCH5zt4CsDR/VGkU/31Hg9LUzmutU+gJxcNKntAenSYFYrk7K0Or2K5IVA/LBZdXYo01
         F0IiaK68nW1Qw7SQ1w77cLvUqWUGn0Od7thMPK2Xci3evySpDvJym2DFmRb+1jsI9/g+
         Exew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732828337; x=1733433137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZQjgHCOdKGOLIMC8jx2ghuoSXfBYmvpjKyrW4dIslk=;
        b=Zq6yUuMrAIWT3bFjcR3NiviAIw86JiROAvKOk+k/j8AdwM0zfnZ3BOyHd2ML0Shbv3
         XpGVNbG+aDDAa9TW3PgUof9WB25G8JfYqULWn1WHcCNjtT2X4gr5Bb93jz41OTNRzu2i
         XWoZzR2maV/O+M+G8e2emNSKPzgNEtg9g94ichFCJDV5/nsTKyOCgI/vvila61R7mSFS
         rY9ylxVCo4+ddDYqtfAL0kgH4QlACjbZba+D+kIHYn98SxOiQbQljRzHnwDlWm7l0jG6
         P0T0UsFba29/ZYSHB3D9PZi65Tzf+MtuTIWLXrL8JNYFIGuXXGG+3eACHkswTwduqcwI
         wYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCURGjYb9ZCKWmM3yqWIHNhUjVH7bJ9PIjIMtUw1lHtuOVIpa8dGbmiM7/wpboFwJgR2YfrAojWJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyLvo4g+cW+Ag/nb/Ch7FLpMLPSHflxsGWAo0FMHCUrDSlKz9D5
	HcTP3DiEtgI9tf7GS7iAf1cX0zBrGGO99hV4WAqybIVyOUnHlLGD+vwd74LhbVE=
X-Gm-Gg: ASbGncvK/YOYlrGtLGEWK3MDtWvvIeg9ptwt9lmTR+b2NDKjtqQkuiWQD9OK1edArk5
	h/TAm/QX9B14HChpU7M9Gxf1Lj/e1+RWKtSY0cvtuORDrtPlBrKcmH9LCTCd6vK6LZYDVXVn/8H
	d4J1g99TxCRHnMoi25RPIKJ4QfdqwkZSjakws0vzZ4NREUCy/SKeZ78OdeMimKci483wcmuvCT9
	wnl+AWy/f+adH6h9qDB9lXM8lfnNcZmXs3kPHYgG+8x9ZyvpdOqW2PQZvYR75kvZXWdzkXXRO0M
	WTTPxQIg3iYEhng=
X-Google-Smtp-Source: AGHT+IH6amO2slru4tjcta7Dz2nO85K3hdLLPHfnkg7IE2FAO0Bdpfqa+QOZGZFc1id6LQ57hv1jaA==
X-Received: by 2002:a05:6a21:70cb:b0:1e0:c30a:6f22 with SMTP id adf61e73a8af0-1e0e0b8cdabmr12970905637.40.1732828336956;
        Thu, 28 Nov 2024 13:12:16 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761474sm2025702b3a.32.2024.11.28.13.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 13:12:16 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tGlo5-00000004Fmx-35VV;
	Fri, 29 Nov 2024 08:12:13 +1100
Date: Fri, 29 Nov 2024 08:12:13 +1100
From: Dave Chinner <david@fromorbit.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] list_lru: expand list_lru_add() docs with info about
 sublists
Message-ID: <Z0jcrYt1iSKgQecY@dread.disaster.area>
References: <20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com>

On Thu, Nov 28, 2024 at 12:12:11PM +0000, Alice Ryhl wrote:
> The documentation for list_lru_add() and list_lru_del() has not been
> updated since lru lists were originally introduced by commit
> a38e40824844 ("list: add a new LRU list type"). Back then, list_lru
> stored all of the items in a single list, but the implementation has
> since been expanded to use many sublists internally.
> 
> Thus, update the docs to mention that the requirements about not using
> the item with several lists at the same time also applies not using
> different sublists. Also mention that list_lru items are reparented when
> the memcg is deleted as discussed on the LKML [1].
> 
> Link: https://lore.kernel.org/all/Z0eXrllVhRI9Ag5b@dread.disaster.area/ [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  include/linux/list_lru.h | 48 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 13 deletions(-)

Looks fine to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

