Return-Path: <cgroups+bounces-4188-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940D994D802
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 22:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30031C229F9
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D31160860;
	Fri,  9 Aug 2024 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ydWGSR+p"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A3148823
	for <cgroups@vger.kernel.org>; Fri,  9 Aug 2024 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235010; cv=none; b=pgdiHC6I5Zae+6VJV07EH0S5vZRTeO9nY8FrVTpjz0fJuDlWf96+UyLUAFWiDlQ5mdtYxYg76qPhzINa1iC7W9UjxjznirRjWjmu3qluk8Z70TD2l41iAgrTZjVwq3hAlAyFUxd3wla5TVbo5qMmxu264+OAdhvPAgMJ9ECL8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235010; c=relaxed/simple;
	bh=lIE5ff22MqP4XyUhpK02PYr8qqT2gvdFUzR+DgOceQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJBAv8heWFseAarzHctiyfBr8Wz9qOAw3ZVGVr4ODMaNhQ/RjJovpkMHUKL+cWNFMUGb3edm7ycVAG+HLr0G7mWeIQpkNlZcwKaqRugiyjzIEO3Lw0XXyUfOGV4CuU/wCIjom832twFl2z5y1GR0EGkvOAq7WPO94SLP2CK67rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ydWGSR+p; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bbbd25d216so25478286d6.0
        for <cgroups@vger.kernel.org>; Fri, 09 Aug 2024 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1723235007; x=1723839807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=we2GavC7rNI44UKDEW6KhQYEaUpZOUZ86BP/aMxAKoo=;
        b=ydWGSR+pZfgSVCgT9sX1gSuweybmzvrIkDS2kfH2fZyqphT4IgJDXoH9kj3ORi4xkJ
         /Q5+UcxK5V8qBr98bTVK9nTVcjg85OZtBxdID1rzwXGscdeo3+dbgUnqelCsPjn+xmOK
         XVvC8+frxNzB5O9pb4BIlH+uV8B79YbczN7f08tNIVxsS7c8I/vYvYDu68GPBzHRcs3F
         wPL2/SWSmd5ugECGMuMlbb67d6zZsl4od3bn2JMjWvlMPGHQTUUAsVcbwu6S4Rv7F406
         gWLpO0hb6tu3kK4nybznHo9MUlzOfcJzO5T7r0M/AQ6uRt/puWaEfV9bcOr8VqTZb2Y9
         kNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723235007; x=1723839807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=we2GavC7rNI44UKDEW6KhQYEaUpZOUZ86BP/aMxAKoo=;
        b=bho/Yt4bpulBQnjoxZS/DaMD5dVbeyTcHZLkDR13kk+OO3lDPxrscz38e+2/Kz4uXf
         V+oEOpKVaClQ0I+Qocw58ZHoGDF/eVZ3MKy/Ys4cOPc6+gY3SwK21ebUpze2enqimcrT
         AFplS6ziiFB7w0edo0Ebqgr6cM74O+n1gSQUqre7sXqbX1QQFjXI4NBrDzGgwrV36v+q
         +77NhvoeT08EeF4iC5LYb3Vq+GKODJie/suvcX2B1RubI2tIF+DR9dvxv+nq3vmb96oJ
         o013w1ebMNDbOYF0gUefjSD36upU7u91LTMlmjaEosfOw1RXJZ7TaVOUzfFKszdHxr9T
         Qw2A==
X-Forwarded-Encrypted: i=1; AJvYcCV/lDFCDJ6XEiZIK4LviAIOLlGQBNkRNbkXQEpvRiz7U7s6aozEHTbeWKr1x+QTXsAm9HH6PtE2L95a26lcWnvC8eQ7wlb4fQ==
X-Gm-Message-State: AOJu0YxBI0Xgk4aCJfWMQ02r4NQWReidPB0ATxe36cn0FJDVWb5cyKnq
	uWFDZXViUGB8kEe0v2iutWR0dk0MgyKfwBo8diWO6NcDSD8LZypUXc4Bd0uUPwY=
X-Google-Smtp-Source: AGHT+IFIRlZVxggSsHYBTjzZ+CPJpwP2DBNOyJSNbJYQmLhE01Uni3G8BOfXEXzW+0TAfN0yl3oflw==
X-Received: by 2002:a05:6214:242f:b0:6b7:9a0a:33db with SMTP id 6a1803df08f44-6bd6cb5ce28mr111108136d6.23.1723235006839;
        Fri, 09 Aug 2024 13:23:26 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e53a83sm1230186d6.118.2024.08.09.13.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:23:26 -0700 (PDT)
Date: Fri, 9 Aug 2024 16:23:25 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] memcg: replace memcg ID idr with xarray
Message-ID: <20240809202325.GA2157603@cmpxchg.org>
References: <20240809172618.2946790-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809172618.2946790-1-shakeel.butt@linux.dev>

On Fri, Aug 09, 2024 at 10:26:18AM -0700, Shakeel Butt wrote:
> At the moment memcg IDs are managed through IDR which requires external
> synchronization mechanisms and makes the allocation code a bit awkward.
> Let's switch to xarray and make the code simpler.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Nice.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

