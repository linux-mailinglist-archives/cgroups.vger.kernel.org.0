Return-Path: <cgroups+bounces-6990-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2617A5CE4F
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 19:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BAD189ED8A
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C83263F26;
	Tue, 11 Mar 2025 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NnaOIMSd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D2263C75
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719392; cv=none; b=kKqHY6rwpmOpMgqo5a7XbRIr4KoQOiFBcPDZsInI0ZzgD2bLzghlH4sjkKPiz4jO/J2VYe9o+fTzF0B1bS2uzodhqEUTXuyxRvLIX4pZ9FVJ8mKc42h1P7rmVVuezlr3+xo2gXDYIB4qz4qu2PB1KxTLwkl9Gcn2eWam+5DcUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719392; c=relaxed/simple;
	bh=lNBjEgxta7oq4TwKBSAROy6ISAN/Tq6iYeWcKE4Vv/0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uyrz3kOvoFGjLzQ5XH6IAQOLijP9jxFmjzM0xjIVmQC9r6jFyAJsDebdJdXL9gWt6abmS+I4fi0Otqd8VJ7h48JKTW7DLsK7p+rtuO6YOPlVmOLBvIwCkgAeCMPN+UCl7qgwa+CtQUEq2AWqPe19O4oN5NhGZwwZal6Wc+/XH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NnaOIMSd; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d46fbfab10so1566875ab.0
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741719389; x=1742324189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1YRjMruou9Tx5jtWPInc60tJt2gIen0DOp7oUm6XP0=;
        b=NnaOIMSddEPHT8Qo1YzHCECi55a8B5zU7qb0NLMcOe01u/v3w/iNulIeG1JuPW0UNy
         /rb1+5kltBqg60TmY8Bz6/9ajmJYAOCmcQnPy0v2K/gWA7l7rh2l9X/UAAf8zHJ4oM9l
         6RoNW/z35MtTPNGzjeNPt+nxZRZpIhQjAHkAfSzw//XVlc25z2oXL2Zixzpe5qRnoFYd
         5THe5/7EDTSfX+eU6+np5F5WsQ6cz5nbf0unICwVfwdpVJ771ofp+Pl9fnNhGlErQG2f
         1+DDW5DkPSDCCAdW21fZnpey9nZiWZvNwemBtuemnmsJoaTHQI2WCN8mbATBeyQOh2QN
         EipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719389; x=1742324189;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1YRjMruou9Tx5jtWPInc60tJt2gIen0DOp7oUm6XP0=;
        b=lpZ+VJYRa70l2TreNPkOt1jFxmI3henambftB3AjP875gMIH0I33bK7ejJcGD//uh/
         U+oNUEftmzTJr7h+oiBDa6NdHO5wl6ysU+o7uB6TgDBUrJgtVHha44TmHleCrPfTWrBY
         +4cg1QkPikDObRsP3XYFNwZNa6Qj8Uo9/HsMQPQVdqQvWDpGtb3zsUIYexsQdTzO4o2I
         Az9Mmulhzy2SCWsnB6dmNLmh8OZxMlqypadGIODjBMSDMsMBkSYULBdr5/YsYfsKxZX7
         diEt2eBsp01Nm385Dn3twz43jyY+RAdFJSUSWMTnY8HrL5p/D7kwT7P/0oAAmUdKKOna
         b1cw==
X-Gm-Message-State: AOJu0YxYzWe3jhDpi+9t+sVqpnFkfp2rwlBOqOfbzi67WYQiaJ/XD6bm
	2KIsXdGXd5uMkCFqIYRUcH8Hat58eEygjLso/Vxkw7VncEyg7b/YXALB1m4CjOM=
X-Gm-Gg: ASbGnctUcJHMec7Z+nhSZnC4rFJJ5TSD7X5KOeBkZ5SnTY1sByy2zcPlHXVy3iJ7iRQ
	8hOUYhpRwx6ZpIYzqTy+WQYDHsFHxp/ZPxCLBPnCMIsPBMoF7tLVH8UJxBeWgCs9mYkZdlLpUQq
	Jwwyz8TQYQMHA0xtPulD90SHUnyQwSHiAooWX+xt0rfrErXhDwXfFlLm9neCjeykRpbhjjf2JhO
	EDhTyZsuaLwMCwhciSpcTT4p3wr5DZG0f+qrTfPrzTgC/1eSNF1gTPKbNkrdWhdadMAPDJR4qpj
	op6DkiyV4nk0zFImc2UE6RJ9g3P39D6t4dx+GslJ
X-Google-Smtp-Source: AGHT+IF6QEvMgNWs9dedBUfcF2UZXbN6XsW8AZipdiC80ycaj5jlFprQu0VmRz6Jjl/szbD7bbMzQQ==
X-Received: by 2002:a05:6e02:1c0b:b0:3a7:87f2:b010 with SMTP id e9e14a558f8ab-3d4419712a9mr212361315ab.5.1741719388965;
        Tue, 11 Mar 2025 11:56:28 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f23abbf42csm1034856173.105.2025.03.11.11.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:56:28 -0700 (PDT)
Message-ID: <32c6f6fb-d75e-45a1-b050-4c078a757a50@kernel.dk>
Date: Tue, 11 Mar 2025 12:56:27 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 00/11] cgroup v1 deprecation messages
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Waiman Long <longman@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Memory controller had begun to print warning messages when using some
> attributes that do no have a counterpart in its cgroup v2
> implementation. This is informative to users who run (unwittingly) on v1
> or to distros that run v1 (they can learn about such users or prepare
> for disabling v1 configs).
>
> I consider the deprecated files in three categories:
>   - RE) replacement exists,
>   - DN) dropped as non-ideal concept (e.g. non-hierarchical resources),
>   - NE) not evaluated (yet).
>
> For RE, I added the replacement into the warning message, DN have only a
> plain deprecation message and I marked the commits with NE as RFC.
> Also I'd be happy if you would point out some forgotten knobs that'd
> deserve similar warnings.
>
> The level of messages is info to avoid too much noise (may be increased
> in future when there are fewer users). Some knobs from DN have warn
> level.
>
> The net_cls and net_prio controllers that only exist on v1 hierarchies
> have no straightforward action for users (replacement would rely on net
> NS or eBPF), so messages for their usage are omitted, although it'd be
> good to eventually retire that code in favor of aforementioned.
>
> At the end are some cleanup patches I encountered en route.

For the block related parts, as I'm assuming Tejun will pick this up:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


