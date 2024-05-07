Return-Path: <cgroups+bounces-2825-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14618BE83A
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 18:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E561F2CE0E
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904A16D4E3;
	Tue,  7 May 2024 16:03:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D016D4DC;
	Tue,  7 May 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097786; cv=none; b=A2Tmwx+RYzP2frqtJFhBxiPDY8Ab8S0WH9QO9jyQ9Y4eJEIN7dsMqOj5IoB1Llq0vYlh88OXtCo2cpqmHgB2UDEvXDnddgKtxLsQdHw2E+2H15mtjdlXv4jKj2FrjGH4mmzVV0gzT/oD1l7020UK+Lw0zXn2D0N7+fbBWInMnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097786; c=relaxed/simple;
	bh=lNe2OKBPTAJiByLVNklZt3fwsF2kSncvssGXrmbVVqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0FJfCpK2z9O9EuT2mlYqTFn2/6xhBzS29UmUc1/IehnXQNpnkgXUYfbmfzEiC00p2aDujw26foDF60e7OvABAFLNGFfME8sq6zf4dJWuO4/udVUIhLZaV0T05/9MfWa2uehI9F3igJB21tfi71EvxYngpnzFba5R04lYlEbs0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59cdf7cd78so622954866b.0;
        Tue, 07 May 2024 09:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097783; x=1715702583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXEoid+P4y9d9rlcyx/evf5V3Cmxvkdb7Jf8hRQs27Y=;
        b=njnDiqf9+Tvwuoayrgwz8CATRyA7vnF2FUAFa0r/wxtgkGYxx7L40el/onM7MsaZkX
         VuzW9CL8+2K6LbVZNLhg4H2FL15hIe3ANRVt/BTnpYIyor1HLxeNL/DG8obSWTg1zZTL
         0TBNAQuSbut0ipV5TNl5FHLj6UsuNKaB24vkTSzviBmDAey3oHf7rMplYI4SYr2QZMlv
         4TVUVONsC+iC/d5z3vU8o0MkObT6WECL+zct4zjr4/y/gslHrSDweYbMOaYLj5w7HQeD
         6AwJAs+lr5PN974klc31gCVl0kjsZsOKOiGp+jwbK49wZB/B4rjiof+9nFCqjMnWDlvu
         o56w==
X-Forwarded-Encrypted: i=1; AJvYcCUV56NHKywqVCNgcjd49PVg3VVPni71uYzEMTlTiPxnT69A+IuhmaotzhHODcBSVUb01sJtp/VQCl7uT9jN3h1JYIk6mViSp509bIBOOHa3OTbVZ8X5B4v9xU1MKEzT6iZmVGy3tQ==
X-Gm-Message-State: AOJu0Yx9J7aJOOWL0D0n2JomRL68jdMEh3azKGHK0QGupaf4//kiODRj
	jj/OELbMW9Bcwa1fDSrhnVqGwBBTZgT+Tll2nfbcVs+9U8553aWL+ZA2/g==
X-Google-Smtp-Source: AGHT+IFtMMmBt2l5Z1o6dwv8yMonvYSVpTqzn3bwquAqseHLd2VYeqJJU7FnCoTxbJrq9Fw5nmTMKQ==
X-Received: by 2002:a17:907:da2:b0:a59:ca9c:4de9 with SMTP id go34-20020a1709070da200b00a59ca9c4de9mr6079850ejc.76.1715097783279;
        Tue, 07 May 2024 09:03:03 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id xa8-20020a170907b9c800b00a59eb443e01sm922487ejc.74.2024.05.07.09.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:03:02 -0700 (PDT)
Date: Tue, 7 May 2024 09:03:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, leit@meta.com,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: Fix data-race KCSAN bug in rstats
Message-ID: <ZjpQtDE9aixy0hZf@gmail.com>
References: <20240424125940.2410718-1-leitao@debian.org>
 <ZjTKLVjxuUJwwFPg@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjTKLVjxuUJwwFPg@tiehlicka>

Hello Michal,

On Fri, May 03, 2024 at 01:27:41PM +0200, Michal Hocko wrote:
> On Wed 24-04-24 05:59:39, Breno Leitao wrote:
> > The race occurs because two code paths access the same "stats_updates"
> > location. Although "stats_updates" is a per-CPU variable, it is remotely
> > accessed by another CPU at
> > cgroup_rstat_flush_locked()->mem_cgroup_css_rstat_flush(), leading to
> > the data race mentioned.
> 
> It is worth mentioning that the race is harmless.

Are you suggesting that the race consistently avoids producing corrupt
data, or even if corruption occurs, it's inconsequential because it only
affects statistics?

If there's no data corruption, does it incur any performance drawbacks?

Thanks!

