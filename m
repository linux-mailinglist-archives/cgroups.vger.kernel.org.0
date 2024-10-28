Return-Path: <cgroups+bounces-5295-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC029B3254
	for <lists+cgroups@lfdr.de>; Mon, 28 Oct 2024 15:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0B2B21165
	for <lists+cgroups@lfdr.de>; Mon, 28 Oct 2024 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04FD1DD540;
	Mon, 28 Oct 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="aNe4lK9f"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C91DB372
	for <cgroups@vger.kernel.org>; Mon, 28 Oct 2024 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124022; cv=none; b=YlsFHuADyP6Rjx0f/wXnFhj5PdcRB3tkTzbUyhJNwBG94UYwVlim77pOD1ZmVX9ovHGZuus+Y66tVt6IVbG63csnZfnjA3TSHXfVc3kC095EbqjW5Uo3QTN9SwJ0pK3pdZt7YNj8SCFKVdXIVHzjRp77snNvT45nU5lmkgP8ZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124022; c=relaxed/simple;
	bh=v2HK0A45xfCW6LF3YFD2TPmEq4ihQfGG/Qxy38acCAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc2NO7LEpSLOwMPEZ6Uhp4eHvZKoshmuP2vtXHt7zEsfAsufv1bwk+7NSWS1Gv0nxAwWlmAt8JNHOYMs1/yUUD9c+E9eMF7m8xfehHerRfGlj2KVKD5W2oQWR9Uo0Ha53uvVAuQSvAbEL5xMPvRXmIOdBWe7SNqkQ7AyANyF12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=aNe4lK9f; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e605ffe10cso2603769b6e.3
        for <cgroups@vger.kernel.org>; Mon, 28 Oct 2024 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730124018; x=1730728818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FihaM4IoEI/TwOyPoeUguS8WS7IqmB9x82K637EGe5Y=;
        b=aNe4lK9fRYs0brgi0ZiIPyRw8NmUo0obkPXCawojqJlIMKj/ka38Ak0yvj7cXS6rn+
         Aslkr30lDPMowwatyN1o8R6nLDEE2Iptq+JvpIfHgLQ06WztZ0Ej91IjhGRXMVgmazth
         1c2ru7VoW6pOEf5n6ho4RLcA3aoOMuDdAYB5rH++aZ7+F8DDM2X2StdcJ0ksAbBzH/g1
         TUp13wwYymwEa/oGDc5avaEQWbQxAef4xkIgSUgqv2r2gt4LSjduLYpbjEca8iXgWNJw
         nyc0XOw1SgCyV99O5388VKEtKVun3p9OtdOpB1C8nQPUobFjmcceqSz4QTtz3YVHsHLz
         odhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124018; x=1730728818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FihaM4IoEI/TwOyPoeUguS8WS7IqmB9x82K637EGe5Y=;
        b=d7L5DRt5uUf9rUajF2BJYG5JVTrnmL/i7Rj6xmeI9vWck1EPvTCE5KJkqOyd3adKPN
         lK+2xalzFpprvclKLJIuL7YiM0W2xtaUn4MKfB/rJzYekGeXVquIBjK98nhLpxKgrQ6W
         uYcba2ZrgpKxQIJpdZEf1ZJYYt/kqpHTLrmJieq2ILnky3mpcUlKSOg1FaaN9IhsDVRz
         dZpqkinpea6lX4XQGmQ4Onu6lB+PjzlKTJ2aqw7nmaJZefHUQ5asWOLwO1I8yk81Uw0o
         az3bmVJdgGJiKg+E8Mhbl26fIrM/IR5tBLPM3p5eX3wXuN+ducU0dbiC5gdWB2J8It8e
         fIVw==
X-Forwarded-Encrypted: i=1; AJvYcCXqHRhzDqt+wJw1TV2ps298jyKrL11UKrlYLHSjfbQdOvisfE3Q4x9JR/4nQeJdAXyn4XGe7Vtf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dvryMKgr5fpYKJkDxOuyr/7ZaK2HetMUJnfcGnB3mP1xj/Sa
	1FksGW9TDVbLhO9vcRQeGPFdcXQ82qr0GxR14YP9bA56iKvBftPttYE80c3jYqY=
X-Google-Smtp-Source: AGHT+IH9co64vboTin+h8OS63UgFbBeD4w6rdjM3nCxgpXXvLvMDezoy7l2Ep0U63nuT2u+Cay9MJQ==
X-Received: by 2002:a05:6808:444c:b0:3e6:4c48:8942 with SMTP id 5614622812f47-3e64c488acamr1321455b6e.35.1730124017959;
        Mon, 28 Oct 2024 07:00:17 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17972f5d5sm32494226d6.23.2024.10.28.07.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:00:17 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:00:16 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 3/6] memcg-v1: no need for memcg locking for dirty
 tracking
Message-ID: <20241028140016.GC10985@cmpxchg.org>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-4-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-4-shakeel.butt@linux.dev>

On Thu, Oct 24, 2024 at 06:23:00PM -0700, Shakeel Butt wrote:
> During the era of memcg charge migration, the kernel has to be make sure
> that the dirty stat updates do not race with the charge migration.
> Otherwise it might update the dirty stats of the wrong memcg. Now with
> the memcg charge migration deprecated, there is no more race for dirty
> stat updates and the previous locking can be removed.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

