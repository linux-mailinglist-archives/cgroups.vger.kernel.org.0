Return-Path: <cgroups+bounces-718-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BFF7FFBC6
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 20:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6061C20C33
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 19:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA1052F93;
	Thu, 30 Nov 2023 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndownpIx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D46D5C;
	Thu, 30 Nov 2023 11:47:47 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77a453eb01cso68724685a.0;
        Thu, 30 Nov 2023 11:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701373666; x=1701978466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lv+GmmtaQLarUwDGJAav6sGuLpEislLWofysxmwJakI=;
        b=ndownpIx4Bi/oIcTUQji/cOPO/xK0Hp0jTBFXcwdJfPiZ81i5Oh9vPxF3LT66ZcVa9
         /8Ba9wluIjQdjygIK4RqmzA6MiqJ0r/gnpAJTH0DF4mav2QeNq4Loxvc0uELESfDRQxu
         ZqXOWQmf8xFew/dmir/g7SC87GrHYvYRhRHmwjLavC+TQt+f7rB2zXzMd/5LI8egf/vh
         5WOZ+8Moi5ULva0nTdAR8A0bvf1S4uDyQW5YkDcu1jwGMutextMsHVO/RROnapT7ketd
         x0ur6uU8uuXQsAY+Kpk2XGTVBbgADE0GxCkPQ+7Pc1P+HzdAPx1D1qx0f6bfgyF3KZ89
         giXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373666; x=1701978466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lv+GmmtaQLarUwDGJAav6sGuLpEislLWofysxmwJakI=;
        b=psuuRtfdMx2fztr9lthL+BCetCtkXJf2Jo2AQD9K5Fb+O5gtoc9bgqR4eNAHarmfm7
         2bm65eqDdUt3jZQWbGUfLUxcqDGqiiZ5BVogpr8H+wvDjFX8lOb1xUng2Mh8+/AkBwKw
         TJuHDhrTK4U4/w0s2FH92qAUDkCsVIDug+5KYcG/dcf5XZJLWZjgYieu+dkAeP6epuBW
         3XegvSUtYFGYY71LKLRoktQb8zunbtC1EJas4kRsc2LTEANevQhLoNZif70rZyVhwFzk
         AgizGAXibNmDZlkRFtac11KmTCQWwGorBGRoq4bANH0Uln9f10LJWqfiEziR0vq0VIQZ
         Qokg==
X-Gm-Message-State: AOJu0YwJpjnRESQPgVLQBS92/OHdGSxlUOOI2EG4z5jc4PI7nq0KWHpS
	Pnovo+lxxMgnar7T7oFvZqaI+vSkmwrwxA==
X-Google-Smtp-Source: AGHT+IHr7jKju+q7fcsHGej8mnpGAMae91Dq5ivS0hsctdM9vBhFv0dY66LqTwqB9o4bWbamQt/blA==
X-Received: by 2002:a05:6214:86:b0:67a:2b0b:c591 with SMTP id n6-20020a056214008600b0067a2b0bc591mr20348209qvr.25.1701373666490;
        Thu, 30 Nov 2023 11:47:46 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::6:43ad])
        by smtp.gmail.com with ESMTPSA id n9-20020ac86749000000b004239ed654fesm773629qtp.51.2023.11.30.11.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:47:46 -0800 (PST)
Date: Thu, 30 Nov 2023 14:47:43 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <ZWjm3zRfJhN+dK4p@dschatzberg-fedora-PF3DHTBV>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka>
 <20231130165642.GA386439@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130165642.GA386439@cmpxchg.org>

On Thu, Nov 30, 2023 at 11:56:42AM -0500, Johannes Weiner wrote:
> [...]
> So I wouldn't say it's merely a reclaim hint. It controls a very
> concrete and influential factor in VM decision making. And since the
> global swappiness is long-established ABI, I don't expect its meaning
> to change significantly any time soon.

I want to add to this last point. While swappiness does not have
terribly well-defined semantics - it is the (only?) existing mechanism
to control balance between anon and file reclaim. I'm merely
advocating for the ability to adjust swappiness during proactive
reclaim separately from reactive reclaim. To what degree the behavior
and semantics of swappiness change is a bit orthogonal here.

