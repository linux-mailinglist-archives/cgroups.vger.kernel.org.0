Return-Path: <cgroups+bounces-9761-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAFEB4660C
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 23:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9259AC39E7
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 21:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEAD2FB98D;
	Fri,  5 Sep 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FC+s6T3B"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEAE2F747D
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108464; cv=none; b=bVsa4ug1cB7C/CdMhZCQ8m1lYKQWJMMHnIhdvRPjRc2olGNZbg6vrNg7hJNjxfV5bkEXJ/x1qt3IjQL4EfNzTn0JJA18CKzyfkOPjRH0e5u47VNcSjTGZLZLF2KhRb7TDQBj9TnVuX67FqZmu394VSgQqDK4dJcaymbIhZGmkOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108464; c=relaxed/simple;
	bh=EISgDghY/knXbNwDvDGK2KSaNFpugS1NjVBQvkSH1ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3ldGKkGlpLd3sELFfRlKvmAh5LcT9yFiXj4gy4D7ywO8rDKN8hQJ4k8WPj/MRVcpry0VCJ7Ekof3l5FqF/JHbSbT31c4nSj6kiiMepsnJa3+17I+gg9fIOaT/1Sj89PsR/6qnbnNSQGIa1hJ4JZj1RcxvaNWfhMNqCm3LG83Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FC+s6T3B; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24b2337d1bfso57285ad.0
        for <cgroups@vger.kernel.org>; Fri, 05 Sep 2025 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757108462; x=1757713262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ/emNLCJz3vxOzQ9R3rq9Yl2yjJO1c1zooZAILHbKw=;
        b=FC+s6T3Be9OhbfE3d46wlRbNypqlcHGfaR3fU5bGf9ZyZZ2fmGWCSbQb8rlZzeCopj
         pjofAdVG2MdF0FLFJNlh06l1AmQhy0a4E+kRIKUgBoRZssqSbeOHgvo8vu7514bZHzPK
         iDT+AMRi0oWyCNR/ccVAKWZKlLYIgihTf0MA6nv+onyUu+RUvcXDwHJ727YGTjOItv0X
         dPVBLYEr/8muy7TKkxfBC7ig1GE4nqlEcJTYe9jyEuqO296rAivFxzq/b+lBSBHrxoIQ
         GgNavhIfeBMjXK+1dBa645uzHc1zrm5STYCy4wgaq4yAN/kfLWnwDPyvDSipNESsqV2n
         CGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757108462; x=1757713262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ/emNLCJz3vxOzQ9R3rq9Yl2yjJO1c1zooZAILHbKw=;
        b=ir454fKeBUZ1V+7FwUrHmILwcMzsUHFYohzJyLFtBAU4TYkvWJWMXr/TBhr+qx2V4a
         X25YWJ1YSo77isdcgF2i+5KpofCNB84xyVOvz3Iq8cXfDH7o9ROHxZyL7Baa1E0bkKz5
         COWnE6YuxdRWR6/+9W5kdct8sJXa60VrDeWDtCu9nNJAGPOiGi2s2yOVzfSvedI/vJ0h
         l9iy0+06V3I1J0dOhPMvipz3RE1QFuLzNeCPS1waumMzHqzSsdo0RJ2jfBOPSSGsshwV
         S2tkjBUZE2g71V4c/nKOxDaNv9jIPLl3feT1zL2zIFbNj6Neox2/9IpzFOIIsIJmKFXr
         pUXg==
X-Forwarded-Encrypted: i=1; AJvYcCWuthR47+j+l7MR4xQ2t0jCluWaTrsVPxPX2etRF43yySl1w+MR9Kow0BbFgj1JQhtJ/QwKIuZW@vger.kernel.org
X-Gm-Message-State: AOJu0YxbuWWagJIijRLLF3re2mB+6amVqq2phQHRXofzBYPVh/fvY+It
	9iwS36OPR9OB0leDQtezfcruynI+Ja91TsWh+dtm3P18tu5hEXwz8r/GnkpaPPnZLw==
X-Gm-Gg: ASbGncv39ikWDZWlC0MiOCRL2HKznVyXW187Ff6fWwNeBlpOE5Zpm/WLcXcKOHtzarj
	NiYfG5zGo6cJPqI39tCOdz5pFwRj7LgXuff+3c21mqrf9H4SclQrjrv7EgCQMwTDd8NVQL0OJrQ
	Mre9bsM9ULztALNGazno6OWB++UNO4LUlpsoVH/WqltmsS4ft0ojLBSmnbdxK6i+exNNBDMr3g1
	LG7ghyjLNfDroFcFv1H+vw4/0h3d+J2XztM1aJ4ovxueMGdyKgqC5P0/a9j43272FnMLrIydm9N
	9GbN2J8AUCgac43swdFE8mV72jrnE3FABwLXyQRrCqkJi2dq1F/WCzh8NUUrGLa5fSztMVj4BcI
	YeCYq2tqYtCslsWxKK/YIIdW0t8pppISgK3SsB3mEhDIbgYnyN6B067GPw1nd7JILLHs=
X-Google-Smtp-Source: AGHT+IEgsoKeEdAOmf7V3AwPOG3rhylbsP/X4Pjd1kcqhKfVj8Dc8zkYrCPZC0GXi2o1KWjaV1iW6Q==
X-Received: by 2002:a17:902:f546:b0:24b:9056:86a5 with SMTP id d9443c01a7336-2517446f701mr288115ad.7.1757108461368;
        Fri, 05 Sep 2025 14:41:01 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2aaa70sm22678386b3a.24.2025.09.05.14.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:41:00 -0700 (PDT)
Date: Fri, 5 Sep 2025 21:40:56 +0000
From: Peilin Ye <yepeilin@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <aLtY6JqoOTMA-OtG@google.com>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <aLtMrlSDP7M5GZ27@google.com>
 <ukh4fh3xsahsff62siwgsa3o5k7mjv3xs6j3u2ymdkvgpzagqf@jfrd7uwbacld>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ukh4fh3xsahsff62siwgsa3o5k7mjv3xs6j3u2ymdkvgpzagqf@jfrd7uwbacld>

On Fri, Sep 05, 2025 at 02:33:16PM -0700, Shakeel Butt wrote:
> On Fri, Sep 05, 2025 at 08:48:46PM +0000, Peilin Ye wrote:
> > On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> > > Generally memcg charging is allowed from all the contexts including NMI
> > > where even spinning on spinlock can cause locking issues. However one
> > > call chain was missed during the addition of memcg charging from any
> > > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > > cgroup_file_notify().
> > > 
> > > The possible function call tree under cgroup_file_notify() can acquire
> > > many different spin locks in spinning mode. Some of them are
> > > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > > just skip cgroup_file_notify() from memcg charging if the context does
> > > not allow spinning.
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > 
> > Tested-by: Peilin Ye <yepeilin@google.com>
> 
> Thanks Peilin. When you post the official patch for __GFP_HIGH in
> __bpf_async_init(), please add a comment on why __GFP_HIGH is used
> instead of GFP_ATOMIC.

Got it!  I'll schedule to have that done today.

Thanks,
Peilin Ye


