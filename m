Return-Path: <cgroups+bounces-5238-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F41E9AF2D0
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 21:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9261C220E7
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 19:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7F1A7AF5;
	Thu, 24 Oct 2024 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hAtqRDGd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60DF1CF96
	for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799157; cv=none; b=uwvBsxAKQUBwaYMMJL2qPYERrB1VW1f4azrF9jM7EEnn05D8gCftkf7xrC9fvwbrVMDF2mkfIqCr9W3iwgBoIlR15sGcWkVeAiXzyoR+ZqXFwwWZatkfqudfBqhiuZFasGtq3JwVQNKfwEDJrVDfvwLoy376iNNTZ+nRrIkM6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799157; c=relaxed/simple;
	bh=iV4qip6noqFvRmg0+R4crLreWqZF1KJ9+3ujyzBCiGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9tsALgWAg54WUZdO8hfxFgID5WhwlqafajybbrFmfxa4qYmgTsc+iFEmgusInw8riABdkh87oksa3if4Lkn877rLmA5hVu8CGLP9DFM1DwyFlMG0aM/7PqiraMULksZI3dvzhJmPanuAOHfuDMBrAzeNQ3K0U+zj3ZY11GD/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hAtqRDGd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso13560355e9.0
        for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729799152; x=1730403952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPb8mKU+KzjeBNrDUNxSqXqnN5Ly29w8syBmz/sIRLU=;
        b=hAtqRDGd5/Dp3Qx77cngVdPP3Q2XeBY94seKUHJcbObv07tuQlFXITLSfaSRftacWC
         g+z7pM1U+JzqScRKTgeh4S7SEnBh2uTccxTBPXTj3GTkXVDvzwgaZqOmLjP0YFVzt3de
         we8arjDxpKEOylU4B/NbQN3+n4DrrUVa/7R73E2sX0D95lcp1yZV7F2ZLj1Ie7KUH/8e
         uCDoByP+PkmPCOEI6+CgLeNG01bR77MvVt2gtjkx6h/pT1zrAdw04R+W3n2UfJAbtB6T
         rQ9MFzXpTNlbTT5LSMCdbPWVClrnSvnzgFWdWaHZgf5HpNsVPTfi2o+N572o/mTBUWlM
         ExMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799152; x=1730403952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPb8mKU+KzjeBNrDUNxSqXqnN5Ly29w8syBmz/sIRLU=;
        b=DGjIcoxdH6F8Q64Eq0aSGHZaONHeZiQ8FY8z3BmhgLqwG+/shVH4fkIHxncMS1PuPL
         Z+Ifk25rnxV3miiIPHCV2O9HVB7Fa+xLT5mm4TxQLiKBmTWGfNp621zoV8D7EZdkZXeF
         iUaz0mrMo/PdZST7cIE2tQ6/xqpfF3QpcyXpC7xu5o3riYHPzhQAGRRGoY/QdB6iuPd6
         V6MKKVxMOxAIHyO0GnXYEHapckXvNmh9b9WC7bO3O8fhA4Bxgy5mKhDQMphbvCvjYBbT
         xB51bthDRdC1xMlY9KOwoooLq4l0IgVCO72k3OZIAKx9dIgyvl4FqhnwJX+CAFJpeyRk
         c/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWasDX29Zh7xpoLqrjsF6hXIk0SqA5Wgq7PmZoLIy4SHHF5/5XZ77liM6QGzND6asIxCfmAh3PY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+TJyPgBU8ek+uuHx3uqyZmm9B7EN95wbf6VxnTX6L55Jx1CM5
	d9y3eNyVfgEIyVYUrq/FNGGknpKhn4YAgcy+jQKvD9aVMv7+2lPcrdTcVO8bdkU=
X-Google-Smtp-Source: AGHT+IE1KNGuPkNPkWg4AR/AqGNEoAixnMnbilmy5HSq6ddD61ZBw/aVan4Y3rF9DyyvlVhbhsb4eA==
X-Received: by 2002:adf:e848:0:b0:37d:4fe9:b6a4 with SMTP id ffacd0b85a97d-37efcf897aamr4839640f8f.50.1729799152197;
        Thu, 24 Oct 2024 12:45:52 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0ba79c8sm12008716f8f.117.2024.10.24.12.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:45:51 -0700 (PDT)
Date: Thu, 24 Oct 2024 21:45:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] memcg-v1: remove memcg move locking code
Message-ID: <Zxqj7hw6Q6ak8aJf@tiehlicka>
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-4-shakeel.butt@linux.dev>
 <Zxp63b9WlI4sTwWk@google.com>
 <7w4xusjyyobyvacm6ogc3q2l26r2vema5rxlb5oqlhs4hpqiu3@dfbde5arh3rg>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7w4xusjyyobyvacm6ogc3q2l26r2vema5rxlb5oqlhs4hpqiu3@dfbde5arh3rg>

On Thu 24-10-24 10:26:15, Shakeel Butt wrote:
> On Thu, Oct 24, 2024 at 04:50:37PM GMT, Roman Gushchin wrote:
> > On Wed, Oct 23, 2024 at 11:57:12PM -0700, Shakeel Butt wrote:
> > > The memcg v1's charge move feature has been deprecated. There is no need
> > > to have any locking or protection against the moving charge. Let's
> > > proceed to remove all the locking code related to charge moving.
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > 
> > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Thanks Roman for the review. Based on Michal's question, I am planning
> to keep the RCU locking in the next version of this patch and folowup
> with clear understanding where we really need RCU and where we don't.

I think it would be safer and easier to review if we drop each RCU
separately or in smaller batches.

Thanks!
-- 
Michal Hocko
SUSE Labs

