Return-Path: <cgroups+bounces-710-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D465D7FFB83
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 20:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113141C20E9A
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B7B52F81;
	Thu, 30 Nov 2023 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="WNjVE1Y3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C406FD67
	for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 11:39:58 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77d645c0e06so66523985a.3
        for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 11:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701373198; x=1701977998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kWhHBtnSLbzDgabGaZdMiHsx1XbL7QU05xk19LHaQ6U=;
        b=WNjVE1Y3/9xHKbrGPdiUpJMEHJvhooqIewU+40DWXhbwoJlNTIIT+m2sP5V39vLYyx
         +CaayDnMIsuLh2XWc1RroIhgpC2WJTaEzlAvZqmTKbjng5WojXCIJh8EN7lRhNcBpNWY
         mq5Etk82VDtqM6Dhw3MkA9PlESxNSNGdkYX17nlN+ukWwQ1gHZ4fNICLtgQ0g5xIJg6x
         nHaWmZ0zxS6cqeABJjOhf7i4C1sgKjdK2Na2lML25ENa/uH1bJedY11bNB103zHdoq+D
         lAGJ3VYgHCdb4ulZtQZRJBXVMto8q088LoQ7KgltTkVpJyrBEEyWJW4Oc9W2GTn+ecGL
         +trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373198; x=1701977998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWhHBtnSLbzDgabGaZdMiHsx1XbL7QU05xk19LHaQ6U=;
        b=hOW3e8yYaI3D5Gyd4rW3awz3yhLFWJqmQkxqFEjorkefclraaUzgLxtkLwlRnm+zQh
         /Uc6EYwIi8ysiw3t+EbB1enmpqwpMOcnVcV15xHLA5G8IkqW+j8z8zGQB/y+FHHGbxHb
         AnWsaZfacHf4gyu4O+IswCY2KdEC9VMven7adUazF1BTjjHhCv9BMexgzrX74ngVdb/t
         X2N/PXGDIgNA1C16BxXc0N5qZWbZidx4VqKRuDgH733HOjEpB+var8qVgymxTuLrAns4
         pNucP4T53WmslSGy/wApdxhubvcFjBH2sQKT5x2tctr5MEPLeY/oa+dlcDRlrkUh1H5H
         X2Ug==
X-Gm-Message-State: AOJu0YxD6N0KpH65tvsyF+GrH3D0D+PaAth9C2Xg3Nc6B1hC06hV+4lL
	v2xkryZ92b4jhpclNovKWoTHYQ==
X-Google-Smtp-Source: AGHT+IEFiJ7HUmH7N0Bzbwakio/WFmv3HQJLHQA0LHzQtGakhez6PA62028PhdqZ/7D8Vx5vBeBWnA==
X-Received: by 2002:a05:620a:40ca:b0:77d:8515:a5af with SMTP id g10-20020a05620a40ca00b0077d8515a5afmr22851289qko.31.1701373197785;
        Thu, 30 Nov 2023 11:39:57 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id vy13-20020a05620a490d00b0077da601f06csm775056qkn.10.2023.11.30.11.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:39:57 -0800 (PST)
Date: Thu, 30 Nov 2023 14:39:56 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Shakeel Butt <shakeelb@google.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <20231130193956.GA543908@cmpxchg.org>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <20231130184424.7sbez2ukaylerhy6@google.com>
 <ZWjabcWQm/GUoGTf@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWjabcWQm/GUoGTf@casper.infradead.org>

On Thu, Nov 30, 2023 at 06:54:37PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 30, 2023 at 06:44:24PM +0000, Shakeel Butt wrote:
> > On Thu, Nov 30, 2023 at 07:36:53AM -0800, Dan Schatzberg wrote:
> > > * Swapout should be limited to manage SSD write endurance. In near-OOM
> > 
> > Is this about swapout to SSD only?
> 
> If you're using spinning rust with its limit of, what, 200 seeks per
> second, I'd suggest that swapout should also be limited but for
> different reasons.  We can set you up with a laptop with insufficient
> RAM and a 5400rpm drive if you'd like to be convinced ...

^_^

Yeah, we don't enable disk swap on the hard drive hosts that are
left. This aspect is only about write endurance management on SSD
during proactive reclaim.

