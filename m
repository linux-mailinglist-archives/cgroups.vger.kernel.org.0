Return-Path: <cgroups+bounces-6508-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564CAA316C3
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 21:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F018E3A7369
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 20:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01802641F0;
	Tue, 11 Feb 2025 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FxRY4JDL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D52641DF
	for <cgroups@vger.kernel.org>; Tue, 11 Feb 2025 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306152; cv=none; b=Viab6ns2a/8XfLpCpeoL9ktyRk5xnqeIXXPPinI+qEt2B6ePqNEU39cnh3xVaFShSA1stTpwyPBnUPMMyMvTaPeUtMW6xj/mJWb3DdUqAfKJ/EROECr7b5Idt1Su3TsXb/8Yg8Xn7250iUvRk9fwLDG/jgJP1t5iYIoXJ3KE9No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306152; c=relaxed/simple;
	bh=I/rRvCIpq5RQ/FsIgsACBEfeYvKxNnoBO9K08yU3P4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mp6ZjcuYHdjLlS8TsnavLbjwF+AV0xNR7URjv03Wn7/mO4kVWiE92iN44j9S2CDR7rMYV1z1sP7I3N/Sc6LOLtdIkG++sxfVSNcJyPZTlkF/v7bGAg53q88A2rJr6XQnuPCOpvJpTDO7ky59PBuiejEwJfArDamtblrEBvzVp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FxRY4JDL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7e1286126so211719166b.0
        for <cgroups@vger.kernel.org>; Tue, 11 Feb 2025 12:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739306149; x=1739910949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/+5NhGenzwK+okbWkOEFe6qAeAZMKB5uNP62rHILYo=;
        b=FxRY4JDLWC9RhptdpCfJkkCY2Ijv5P1PAXnqWTpVFeIBp5YbicL4vwrVXYuft3+ISn
         fazMxzdKGj9glmuMCJxA1R+PuP0T7HadqewjtgakZwa6EbZJ4TJJZ4oqnQFDaav+lpy4
         SrToh+5vUhazMNAL0BUnlBYxTB8pb4fAzMkF7mQ9imonCdlu8F7xVGkRe/pGtwLPynkt
         DfaKtwf5HagAH4Hf/Mn5gNW/q6JGOThCXC3f2cFn7HJbi11Hw8YbGL9jONCMYo1TsFbs
         /JP0Cp6AhB5GH++Sg8qR6WpkHd90ohwEDwBAfDUteYotjB3fVBqNtj8VbJtykuQw3OM3
         nB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739306149; x=1739910949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/+5NhGenzwK+okbWkOEFe6qAeAZMKB5uNP62rHILYo=;
        b=LwzPuy4bN1SbNkXj0ycP14HFfI5lFpsYllw3R0x6ynTT0kO1V4U4JWJO8bycC6jASu
         2RKERmXm84SgvbnSH6OYPX3hxg318mUMaiWlJWBt2CbI1w/RNu8ZlNBBalfH2+6okR0Z
         xr4jgl8DDw/aWyub9PMLXnD4M0DkBH/YU0MdFbPH6xKTKSCoDUXFkDhjLva66lT8KZS/
         N1WSPMm3ZXZqbVeEDeEusg7jFRBIx22rKx0e8fqHLWLK90b+5yu6xFWgNdlyFFnmJcuO
         KSjv7F3lJcIsjY2jMY+w6eXhqi6o7inxmCc3AoMUZrVRrtaICJG4K4v21cH7SktbgYW8
         dIEg==
X-Forwarded-Encrypted: i=1; AJvYcCWlOJEMLy/vUSAZcuPvidYQB2T0QrXdhjcjGn87vO1iyV1JVO75dcw/+7D37zQfALO7cftZdfiG@vger.kernel.org
X-Gm-Message-State: AOJu0YzkmqVpDtl+GC48QtR7xQ65J8VEw1HGxpNjJxHnra04FGXex4l0
	YN9Isuf8DWEv0nH60JWcw9dltsL3Efnz6KzcTDIF1LiNbD21+LD7r0sQrAIJS+E=
X-Gm-Gg: ASbGnctAii7y0VxfHxtoR0MxtwvEeANdLUUxZSLd3mj4NqsQcEBad5BazLdVNGIBozn
	9x9pSvpidJ8vYf++VnRGLy4HAeUocYvQbdXGa6Kb2YdIfZZowiZRt87TvAhIx5YsjHOFB8gI7MO
	kdWJ/Hph7Tnlz2vXzue9L+QqnRqn74Ivjcmo5fGV8ohp+1YoKedj5nyGxyh6mXnObICvo+/KN9u
	ZRthv5+CCWbsYxkhausDChG9xDrkxfW0LaKI5BmAFF2c1ON2WfmuwNSR83L5NXUY8CLYZ+3R5iJ
	uj7W9fHuA55ZTtSk7Inc73W6OZ6P
X-Google-Smtp-Source: AGHT+IF0DWh7q4wE4jKyFHvY3n/IIjvJFTSVgSxHhSO9S8uipftjoult8ADuAAeQjn4KXOC625HjXQ==
X-Received: by 2002:a17:906:f58e:b0:ab7:b2a7:9cb8 with SMTP id a640c23a62f3a-ab7f3380e64mr30140266b.15.1739306148735;
        Tue, 11 Feb 2025 12:35:48 -0800 (PST)
Received: from localhost (109-81-84-135.rct.o2.cz. [109.81.84.135])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab78d5771easm947387866b.83.2025.02.11.12.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 12:35:48 -0800 (PST)
Date: Tue, 11 Feb 2025 21:35:47 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH] memcg: avoid dead loop when setting memory.max
Message-ID: <Z6u0o_xr9Lo7nwh-@tiehlicka>
References: <20250211081819.33307-1-chenridong@huaweicloud.com>
 <gf5pqage6o7azhzdlp56q6fvlfg52gbi47d43ro7r6n2hys54i@aux77hoig5j2>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gf5pqage6o7azhzdlp56q6fvlfg52gbi47d43ro7r6n2hys54i@aux77hoig5j2>

On Tue 11-02-25 11:04:21, Shakeel Butt wrote:
> On Tue, Feb 11, 2025 at 08:18:19AM +0000, Chen Ridong wrote:
[...]
> Wouldn't it be more robust if we put an upper bound on the else case of
> above condition i.e. fix number of retries? As you have discovered there
> is a hidden dependency on the forward progress of oom_reaper and this
> check/code-path which I think is not needed. 

Any OOM path has a dependency on oom_reaper or task exiting. Is there
any reason why this path should be any special? With cond_resched we can
look for a day where this will be just removed and the code will still
work. With a number of retries we will have a non-deterministic time
dependent behavior because number of retries rather than fwd progress
would define the failure mode.
-- 
Michal Hocko
SUSE Labs

