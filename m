Return-Path: <cgroups+bounces-3727-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095929336E5
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 08:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB951C210A6
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 06:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5F414A8F;
	Wed, 17 Jul 2024 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UPSAm4kt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974A1802E
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197386; cv=none; b=lblk72SKbROGXbNQy9ib3UnWgojG2M3EazQoY0PHu9y9thsKek+2qScT/3sT8L+14M1/arBW1lw2jisKWnIN47ZAsf6qi4IOqi6cCutIxJDNllR9WkuWCPtlcYbqAfHpKqq6SMHHCuv8D2L1IjKIFav+cavm+REyQtm4dOXXLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197386; c=relaxed/simple;
	bh=3MPq2v9TtH8JoXErLENYs/DOCszxRjXk7Mxsc+m3BPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIjV24xKG26ZQsVyleeYNIWxtGAKVhkLMusBNudJXb09nJfr65YXXYdsF0sCqm7ajH7hZ0QPpva1SGQmnalRIcS5Efjg3tlJDvS58ObkT/N4WIrhcls819Rsm1BKjFCIvsmMwjepmHAHFDZ+wlBJ2t5uum8uHAEFRZcZn62SKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UPSAm4kt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-595712c49ebso7553418a12.0
        for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 23:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721197382; x=1721802182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m3+PhR/3a1eRlfLEg4VdiRyLGaVu24qNIiBH/dxTd5U=;
        b=UPSAm4ktemuDEF4HlQMD5UGqtfxNB//ZsTBtdXLnWvNP/Bp8cM8UhnMSfXBJnpvH4R
         LLTNwJ7N5oDcrWJ9nU+RY5ob19qfh+C5ifUz2OLQHlkT0Sa8/KX3a2G0bx/9NfdJa+/F
         xWvRU6k3PNTGL/CRbNKDBTtLH7uFPziVI/KsbYHAatBcqZ6rmP4kbrfvq+Trhq2GrM2d
         1Mkjg4C5lXurWvzecs+umXv4P9I5ak3neQ6IKSJNxVb0Oz4CZ9FjoxagHgZ52pdl6NwS
         75ghUfNnGOadM/bMBeLZ6e4CkLxCX8sawA8aUFnhE79x9FPU9frtg+SATKN/0Uw1daK5
         UO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197382; x=1721802182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3+PhR/3a1eRlfLEg4VdiRyLGaVu24qNIiBH/dxTd5U=;
        b=TQdqdLDBSpoOg/TcOZZLf1B6b1Fa/7H61Ch/idj3BS8eypu/cRZeALBnPyRhwi11sc
         5H4+cjZgd761xGIz/3X2utkxndQDNjC61v13UGmimI4wu3+Fd+dH8c8EvHY+E566HpYF
         eHw3sdy3uy2CBdjk5wy9uttR1YxE2/7tdeJGx9DJ3aT4IxCNSwhQwsbKHOJDK7RFIAoZ
         jMrtUwdKicGmLn5KRRrp5ExulkPmzn2XK3ViuyU3+T/MgmRilnHXp8W8Rn9mL2ZE1oeM
         wfcmzXexHS+sD8jyArLInJRW8/2CbRq1c7ux7GljUZySzKqCmsfK6qMdCNUzG/deI8ZS
         wBSg==
X-Forwarded-Encrypted: i=1; AJvYcCWLl3K2uhmQQnVvi8ji47FkqWbdnIvAl5C9RZQEz5WLlNNrY53ZbJVzdOkn317Ba+FlqBz2PhWXgbVpsRpXyvqXiW95hAJCig==
X-Gm-Message-State: AOJu0YzVb7d7fsnYeWyXo3Sh+OTIxgitCTBS5wrqHxViKfmmc1edWhEs
	oVWEp15yAx9sWXQEz0AmxA2dgNPxQn98VVGbwWaT61/qO5gAyZBVQnqXFYgIMvg=
X-Google-Smtp-Source: AGHT+IETxd/duCNWxFX80WiV+h81gWmi7n0C4ofi3OJjO3PtYvu2atHLt5BB7L7ENAB2bH4yvHwxbQ==
X-Received: by 2002:a05:6402:254f:b0:58a:e73f:6edb with SMTP id 4fb4d7f45d1cf-5a05d2de409mr568638a12.40.1721197382120;
        Tue, 16 Jul 2024 23:23:02 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59eaaee1c97sm2829868a12.28.2024.07.16.23.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:23:01 -0700 (PDT)
Date: Wed, 17 Jul 2024 08:23:01 +0200
From: Michal Hocko <mhocko@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Finkel <davidf@vimeo.com>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZpdjRVYshwksDyJx@tiehlicka>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <Zpa1VGL5Mz63FZ0Z@tiehlicka>
 <ZpbRSv_dxcNNfc9H@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpbRSv_dxcNNfc9H@slm.duckdns.org>

On Tue 16-07-24 10:00:10, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jul 16, 2024 at 08:00:52PM +0200, Michal Hocko wrote:
> ...
> > > If we want to allow peak measurement of time periods, I wonder whether we
> > > could do something similar to pressure triggers - ie. let users register
> > > watchers so that each user can define their own watch periods. This is more
> > > involved but more useful and less error-inducing than adding reset to a
> > > single counter.
> > 
> > I would rather not get back to that unless we have many more users that
> > really need that. Absolute value of the memory consumption is a long
> > living concept that doesn't make much sense most of the time. People
> > just tend to still use it because it is much simpler to compare two different
> > values rather than something as dynamic as PSI similar metrics.
> 
> The initial justification for adding memory.peak was that it's mostly to
> monitor short lived cgroups. Adding reset would make it used more widely,
> which isn't necessarily a bad thing and people most likely will find ways to
> use it creatively. I'm mostly worried that that's going to create a mess
> down the road. Yeah, so, it's not widely useful now but adding reset makes
> it more useful and in a way which can potentially paint us into a corner.

I really fail to see how this would cause problems with future
maintainability. It is not like we are trying to deprecate this
memory.peak.

I am also not sure this makes it so much more attractive that people
would start using it just because they can reset the value. It makes
sense to extend our documentation and actually describe pitfalls.
-- 
Michal Hocko
SUSE Labs

